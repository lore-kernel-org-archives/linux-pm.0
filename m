From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v7 8/8] drm/rockchip: Add dmc notifier in vop driver
Date: Mon, 22 Aug 2016 11:36:24 +0800
Message-ID: <1471836984-6316-9-git-send-email-hl@rock-chips.com>
References: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, myungjoo.ham@samsung.com
Cc: tixy@linaro.org, mark.rutland@arm.com, typ@rock-chips.com, linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

when in ddr frequency scaling process, vop can not do enable or
disable operation, since in dcf we check vop clock to see whether
vop work. If vop work, dcf do ddr frequency scaling when vop
in vblank status, and we need to read vop register to check whether
vop go into vblank status. If vop not work, dcf can do ddr frequency
any time. So when do ddr frequency scaling, you disabled or enable
vop, there may two bad thing happen: 1, the panel flicker(when vop from
disable status change to enable). 2, kernel hang (when vop from enable
status change to disable, dcf need to read vblank status, but if you disable
vop clock, it can not get the status, it will lead soc dead) So we need
register to devfreq notifier, and we can get the dmc status. Also, when
there have two vop enabled, we need to disable dmc, since dcf only base
on one vop vblank time, so the other panel will flicker when do ddr
frequency scaling.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes in v7:
- None

Changes in v6:
- fix a build error

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

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 127 ++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ec8ad00..a76e70c 100644
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
@@ -515,7 +592,6 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 		VOP_WIN_SET(vop, win, enable, 0);
 		spin_unlock(&vop->reg_lock);
 	}
-
 	drm_crtc_vblank_off(crtc);
 
 	/*
@@ -546,7 +622,6 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 	 * vop standby complete, so iommu detach is safe.
 	 */
 	rockchip_drm_dma_detach_device(vop->drm_dev, vop->dev);
-
 	clk_disable(vop->dclk);
 	clk_disable(vop->aclk);
 	clk_disable(vop->hclk);
@@ -559,6 +634,25 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 
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
@@ -1410,6 +1504,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm_dev = data;
 	struct vop *vop;
 	struct resource *res;
+	struct devfreq *devfreq;
+	struct devfreq_event_dev *event_dev;
 	size_t alloc_size;
 	int ret, irq;
 
@@ -1471,6 +1567,27 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	pm_runtime_enable(&pdev->dev);
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
2.6.6
