From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 4/4] PM / Domains: Enforce PM domains to stay powered during boot
Date: Wed,  1 Oct 2014 16:41:34 +0200
Message-ID: <1412174494-15346-5-git-send-email-ulf.hansson@linaro.org>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

When there are more than one device in a PM domain these will obviously
be probed at different times. Depending on timing and the implemented
support for runtime PM in a driver/subsystem, genpd may be advised to
power off a PM domain after a successful probe sequence.

Ideally we should have relied on the driver/subsystem, through runtime
PM, to bring their device's PM domain into powered state prior doing
probing if such requirement exist.

Since this is not a common practice by drivers/subsystems, enforcing
such a change doesn't seem viable.

Instead, let's improve the situation, by preventing genpd from powering
off any of the PM domains until late_init. At that point genpd already
tries to power off unused PM domains, so it seems like a decent match.

Cases which can't be covered within the window of until late_init needs
to be adressed separately and likely through a more common long term
solution.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 17 ++++++++++++++++-
 include/linux/pm_domain.h   |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cfb76e8..3dbadfd 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -451,10 +451,12 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 	 * (2) The domain is waiting for its master to power up.
 	 * (3) One of the domain's devices is being resumed right now.
 	 * (4) System suspend is in progress.
+	 * (5) late_init hasn't completed to allow it.
 	 */
 	if (genpd->status == GPD_STATE_POWER_OFF
 	    || genpd->status == GPD_STATE_WAIT_MASTER
-	    || genpd->resume_count > 0 || genpd->prepared_count > 0)
+	    || genpd->resume_count > 0 || genpd->prepared_count > 0
+	    || genpd->keep_power)
 		return 0;
 
 	if (atomic_read(&genpd->sd_count) > 0)
@@ -724,6 +726,18 @@ void pm_genpd_poweroff_unused(void)
 
 static int __init genpd_poweroff_unused(void)
 {
+	struct generic_pm_domain *genpd;
+
+	mutex_lock(&gpd_list_lock);
+
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		genpd_acquire_lock(genpd);
+		genpd->keep_power = false;
+		genpd_release_lock(genpd);
+	}
+
+	mutex_unlock(&gpd_list_lock);
+
 	pm_genpd_poweroff_unused();
 	return 0;
 }
@@ -1854,6 +1868,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->status = GPD_STATE_ACTIVE;
 	init_waitqueue_head(&genpd->status_wait_queue);
 	genpd->poweroff_task = NULL;
+	genpd->keep_power = true;
 	genpd->resume_count = 0;
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ad4aa87..d87ef6a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -58,6 +58,7 @@ struct generic_pm_domain {
 	enum gpd_status status;	/* Current state of the domain */
 	wait_queue_head_t status_wait_queue;
 	struct task_struct *poweroff_task;	/* Powering off task */
+	bool keep_power;		/* Flag to keep power until late_init */
 	unsigned int resume_count;	/* Number of devices being resumed */
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
-- 
1.9.1
