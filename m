From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v5 8/8] drm/rockchip: Add dmc notifier in vop driver
Date: Wed, 10 Aug 2016 11:26:44 +0800
Message-ID: <1470799604-12877-9-git-send-email-hl@rock-chips.com>
References: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: myungjoo.ham@samsung.com, mark.yao@rock-chips.com, cw00.choi@samsung.com, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org, tixy@linaro.org, typ@rock-chips.com, sudeep.holla@arm.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

when in ddr frequency scaling process, vop can not do
enable or disable operation, since dcf will base on vop vblank
time to do frequency scaling and need to get vop irq if there
have vop enabled. So need register to devfreq notifier, and we can
get the dmc status. Also, when there have two vop enabled, we need
to disable dmc, since dcf only base on one vop vblank time, so the
other panel will flicker when do ddr frequency scaling.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v5:
- improve some nits

Changes in v4:
- register notifier to devfreq_register_notifier
- use DEVFREQ_PRECHANGE and DEVFREQ_POSTCHANGE to get dmc status
- when two vop enable, disable dmc
- when two vop back to one vop, enable dmc

Changes in v3:
- when do vop eanble/disable, dmc will wait until it finish

Changes in v2:
- None

Changes in v1:
- use wait_event instead usleep

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 128 +++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 31744fe..7ce3890 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -12,6 +12,8 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/devfreq.h>
+#include <linux/devfreq-event.h>
 #include <drm/drm.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
@@ -118,6 +120,13 @@ struct vop {
 
 	const struct vop_data *data;
 
+	struct devfreq *devfreq;
+	struct devfreq_event_dev *devfreq_event_dev;
+	struct notifier_block dmc_nb;
+	int dmc_in_process;
+	int vop_switch_status;
+	wait_queue_head_t wait_dmc_queue;
+	wait_queue_head_t wait_vop_switch_queue;
 	uint32_t *regsbak;
 	void __iomem *regs;
 
@@ -428,21 +437,59 @@ static void vop_dsp_hold_valid_irq_disable(struct vop *vop)
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
+static int dmc_notify(struct notifier_block *nb, unsigned long event,
+		      void *data)
+{
+	struct vop *vop = container_of(nb, struct vop, dmc_nb);
+
+	if (event == DEVFREQ_PRECHANGE) {
+		/*
+		 * check if vop in enable or disable process,
+		 * if yes, wait until it finishes, use 200ms as
+		 * timeout.
+		 */
+		if (!wait_event_timeout(vop->wait_vop_switch_queue,
+					!vop->vop_switch_status, HZ / 5))
+			dev_warn(vop->dev,
+				 "Timeout waiting for vop swtich status\n");
+		vop->dmc_in_process = 1;
+	} else if (event == DEVFREQ_POSTCHANGE) {
+		vop->dmc_in_process = 0;
+		wake_up(&vop->wait_dmc_queue);
+	}
+
+	return NOTIFY_OK;
+}
+
 static void vop_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
+	int num_enabled_crtc = 0;
 	int ret;
 
+	if (vop->is_enabled)
+		return;
+
+	/*
+	 * if in dmc scaling frequency process, wait until it finishes
+	 * use 100ms as timeout time.
+	 */
+	if (!wait_event_timeout(vop->wait_dmc_queue,
+				!vop->dmc_in_process, HZ / 5))
+		dev_warn(vop->dev,
+			 "Timeout waiting for dmc when vop enable\n");
+
+	vop->vop_switch_status = 1;
 	ret = pm_runtime_get_sync(vop->dev);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
-		return;
+		goto err;
 	}
 
 	ret = clk_enable(vop->hclk);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to enable hclk - %d\n", ret);
-		return;
+		goto err;
 	}
 
 	ret = clk_enable(vop->dclk);
@@ -456,7 +503,6 @@ static void vop_enable(struct drm_crtc *crtc)
 		dev_err(vop->dev, "failed to enable aclk - %d\n", ret);
 		goto err_disable_dclk;
 	}
-
 	/*
 	 * Slave iommu shares power, irq and clock with vop.  It was associated
 	 * automatically with this master device via common driver code.
@@ -485,6 +531,21 @@ static void vop_enable(struct drm_crtc *crtc)
 
 	drm_crtc_vblank_on(crtc);
 
+	vop->vop_switch_status = 0;
+	wake_up(&vop->wait_vop_switch_queue);
+
+	/* check how many vop we use now */
+	drm_for_each_crtc(crtc, vop->drm_dev) {
+		if (crtc->state->enable)
+			num_enabled_crtc++;
+	}
+
+	/* if enable two vop, need to disable dmc */
+	if ((num_enabled_crtc > 1) && vop->devfreq) {
+		if (vop->devfreq_event_dev)
+			devfreq_event_disable_edev(vop->devfreq_event_dev);
+		devfreq_suspend_device(vop->devfreq);
+	}
 	return;
 
 err_disable_aclk:
@@ -493,16 +554,32 @@ err_disable_dclk:
 	clk_disable(vop->dclk);
 err_disable_hclk:
 	clk_disable(vop->hclk);
+err:
+	vop->vop_switch_status = 0;
+	wake_up(&vop->wait_vop_switch_queue);
+	return;
 }
 
 static void vop_crtc_disable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
+	int num_enabled_crtc = 0;
 	int i;
 
 	WARN_ON(vop->event);
 
 	/*
+	 * if in dmc scaling frequency process, wait until it finish
+	 * use 100ms as timeout time.
+	 */
+	if (!wait_event_timeout(vop->wait_dmc_queue,
+				!vop->dmc_in_process, HZ / 5))
+		dev_warn(vop->dev,
+			 "Timeout waiting for dmc when vop disable\n");
+
+	vop->vop_switch_status = 1;
+
+	/*
 	 * We need to make sure that all windows are disabled before we
 	 * disable that crtc. Otherwise we might try to scan from a destroyed
 	 * buffer later.
@@ -559,6 +636,25 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 
 		crtc->state->event = NULL;
 	}
+
+	vop->vop_switch_status = 0;
+	wake_up(&vop->wait_vop_switch_queue);
+
+	/* check how many vop use now */
+	drm_for_each_crtc(crtc, vop->drm_dev) {
+		if (crtc->state->enable)
+			num_enabled_crtc++;
+	}
+
+	/*
+	 * if num_enabled_crtc = 1 now, it means 2 vop enabled
+	 * change to 1 vop enabled  need to enable dmc again.
+	 */
+	if ((num_enabled_crtc == 1) && vop->devfreq) {
+		if (vop->devfreq_event_dev)
+			devfreq_event_enable_edev(vop->devfreq_event_dev);
+		devfreq_resume_device(vop->devfreq);
+	}
 }
 
 static void vop_plane_destroy(struct drm_plane *plane)
@@ -1406,6 +1502,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm_dev = data;
 	struct vop *vop;
 	struct resource *res;
+	struct devfreq *devfreq;
+	struct devfreq_event_dev *event_dev;
 	size_t alloc_size;
 	int ret, irq;
 
@@ -1467,6 +1565,30 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	pm_runtime_enable(&pdev->dev);
+
+	vop->psr_enabled = false;
+	INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
+
+	init_waitqueue_head(&vop->wait_vop_switch_queue);
+	vop->vop_switch_status = 0;
+	init_waitqueue_head(&vop->wait_dmc_queue);
+	vop->dmc_in_process = 0;
+
+	devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
+	if (IS_ERR(devfreq))
+		goto out;
+
+	vop->devfreq = devfreq;
+	vop->dmc_nb.notifier_call = dmc_notify;
+	devfreq_register_notifier(vop->devfreq, &vop->dmc_nb,
+				  DEVFREQ_TRANSITION_NOTIFIER);
+
+	event_dev = devfreq_event_get_edev_by_phandle(vop->devfreq->dev.parent,
+						      0);
+	if (IS_ERR(event_dev))
+		goto out;
+	vop->devfreq_event_dev = event_dev;
+out:
 	return 0;
 }
 
-- 
1.9.1
