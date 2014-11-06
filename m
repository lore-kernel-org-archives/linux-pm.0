From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 1/4] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Thu, 06 Nov 2014 16:57:33 +0100
Message-ID: <545B9A6D.5060206@samsung.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
 <1412174494-15346-2-git-send-email-ulf.hansson@linaro.org>
 <542C2D9F.8060005@samsung.com>
 <CAPDyKFq+9G+n3qaj+Ls9i4sOi_BdOGzk5SypDzEMZJwAJMa97Q@mail.gmail.com>
 <542D3E45.5020908@samsung.com>
 <CAPDyKFozS+J_sTZykF=9tVJsCByby_BDuQmGiMt-Uw-qC4Tzuw@mail.gmail.com>
 <542D7525.8000804@samsung.com>
 <CAPDyKFqi=eKYBXSuRPzTZ0vybRfV6oMNt-_vCqT-6+otGiMucQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55750 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaKFP5o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 10:57:44 -0500
In-reply-to: <CAPDyKFqi=eKYBXSuRPzTZ0vybRfV6oMNt-_vCqT-6+otGiMucQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

[dropping some addresses from Cc]

On 03/10/14 12:36, Ulf Hansson wrote:
> On 2 October 2014 17:54, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>> On 02/10/14 15:30, Ulf Hansson wrote:
>> [...]
>>> Correct me if I am wrong, but I think in principle these exynos
>>> drivers don't use pm_runtime_set_active() during ->probe() and are
>>> instead relying on CONFIG_PM_RUNTIME to be enabled.
>>
>> Yes, pm_runtime_set_active() is not used in probe(), I believe this
>> is not required. In case of those IP blocks there is no use of activating
>> them during probe(). Instead we check if PM_RUNTIME is enabled through
>> pm_runtime_enabled() helper and enable the device clock(s) if not.
>> I agree it all doesn't quite work in current mainline for !PM_RUNTIME,
>> since there is nothing ensuring that the power domains are enabled
>> in such kernel configuration.
>>
>>> That's not a good behaviour. If these drivers are build without
>>> CONFIG_PM_RUNTIME - they won't work.
>>
>> They wouldn't similarly work with pm_runtime_set_active() call in probe()
>> with CONFIG_PM_RUNTIME disabled, would they ?
> 
> Yes they would, although they require some minor additional adaptations.
> 
> Those resources that are enabled from the driver's runtime PM resume
> callback, should also be enabled during ->probe(). The
> pm_runtime_set_active() will then update the state to reflect this.
> 
> Then, if CONFIG_PM_RUNTIME is enabled - the device will be scheduled
> to go inactive from driver core (pm_request_idle()), after ->probe()
> has completed. Thus saving power if it's unused.
> If CONFIG_PM_RUNTIME isn't enabled - the driver will still be
> functional, since all resources are enabled during ->probe().

OK, I suspected you also assumed enabling relevant resources, so the PM
state matches the hardware state.

Sorry for getting back late to this, now there is a regression on
Exynos seen in multiple drivers, i.e. affecting all the media and
video devices.  Is this patch series going to be merged for v3.18 as
a regression fix ? If so I would need to update remaining drivers to
enable clocks and use pm_runtime_set_active() in probe().

I can see two options to fix bugs which appeared in Exynos after
merging the patch series switching to the OF generic power domain API:

1. merge this series and update the affected drivers for v3.18,

2. revert for now to the previous behaviour, doing something as
   the patch below.

1. seems only a partial solution, since the regression remains for the
loadable modules which are loaded after late_initcall().  At that point
power domain may be disabled and the driver attempting to access
the hardware will hand the system.

It's also a bit not clear to me why there is an assumption that when
a power domain is initially enabled all its corresponding devices are
already also fully activated ?

int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
			  struct gpd_timing_data *td)
{
	...
	gpd_data->need_restore = genpd->status == GPD_STATE_POWER_OFF;
	...
}

It seems correct to me to have initially the power domain enabled and some
devices inactive, e.g. if device's driver manages its clocks and didn't
turn them on yet.

-----8<----
>From c7dbc17e940db681d51941b3493e216cee6912f5 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 6 Nov 2014 16:44:05 +0100
Subject: [PATCH] PM / domains: Allow initial restoring of devices in active
 domain

Currently a device in the power domain won't be initially runtime
resumed if it is added to an active power domain. In drivers which
don't enable all resources they manage and call pm_runtime_set_active()
in probe() there are now unbalanced runtime_resume() calls seen after
commit a4a8c2c4962bb655e7152c53a0eb6ca31c47f159
("ARM: exynos: Move to generic PM domain DT bindings").

To fix the regression revert to previous behaviour for Exynos platform.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c   |    2 +-
 arch/arm/mach-s3c64xx/pm.c          |    4 ++--
 arch/arm/mach-shmobile/pm-r8a7779.c |    2 +-
 arch/arm/mach-shmobile/pm-rmobile.c |    2 +-
 drivers/base/power/domain.c         |    8 ++++++--
 include/linux/pm_domain.h           |    4 +++-
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 20f2671..0b0bf68 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -157,7 +157,7 @@ static __init int exynos4_pm_init_power_domain(void)
 no_clk:
 		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;

-		pm_genpd_init(&pd->pd, NULL, !on);
+		pm_genpd_init(&pd->pd, NULL, !on, true);
 		of_genpd_add_provider_simple(np, &pd->pd);
 	}

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index aaf7bea..a347654 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -315,10 +315,10 @@ int __init s3c64xx_pm_init(void)

 	for (i = 0; i < ARRAY_SIZE(s3c64xx_always_on_pm_domains); i++)
 		pm_genpd_init(&s3c64xx_always_on_pm_domains[i]->pd,
-			      &pm_domain_always_on_gov, false);
+			      &pm_domain_always_on_gov, false, false);

 	for (i = 0; i < ARRAY_SIZE(s3c64xx_pm_domains); i++)
-		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, false);
+		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, false, false);

 #ifdef CONFIG_S3C_DEV_FB
 	if (dev_get_platdata(&s3c_device_fb.dev))
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c
b/arch/arm/mach-shmobile/pm-r8a7779.c
index 82fe3d7..fcb17f7 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -83,7 +83,7 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain
*r8a7779_pd)
 {
 	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;

-	pm_genpd_init(genpd, NULL, false);
+	pm_genpd_init(genpd, NULL, false, false);
 	genpd->dev_ops.stop = pm_clk_suspend;
 	genpd->dev_ops.start = pm_clk_resume;
 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c
b/arch/arm/mach-shmobile/pm-rmobile.c
index 717e641..e8c913e 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -106,7 +106,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain
*rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;

-	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
+	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false, false);
 	genpd->dev_ops.stop		= pm_clk_suspend;
 	genpd->dev_ops.start		= pm_clk_resume;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 40bc2f4..6a2da45 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1442,7 +1442,8 @@ int __pm_genpd_add_device(struct generic_pm_domain
*genpd, struct device *dev,
 	mutex_lock(&gpd_data->lock);
 	gpd_data->base.dev = dev;
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
-	gpd_data->need_restore = genpd->status == GPD_STATE_POWER_OFF;
+	gpd_data->need_restore = (genpd->status == GPD_STATE_POWER_OFF ||
+				  genpd->force_restore);
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	mutex_unlock(&gpd_data->lock);
@@ -1857,9 +1858,11 @@ static int pm_genpd_default_restore_state(struct device
*dev)
  * @genpd: PM domain object to initialize.
  * @gov: PM domain governor to associate with the domain (may be NULL).
  * @is_off: Initial value of the domain's power_is_off field.
+ * @force_restore: True to set device's being added "need_restore" flag.
  */
 void pm_genpd_init(struct generic_pm_domain *genpd,
-		   struct dev_power_governor *gov, bool is_off)
+		   struct dev_power_governor *gov, bool is_off,
+		   bool force_restore)
 {
 	if (IS_ERR_OR_NULL(genpd))
 		return;
@@ -1873,6 +1876,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->in_progress = 0;
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
+	genpd->force_restore = force_restore;
 	init_waitqueue_head(&genpd->status_wait_queue);
 	genpd->poweroff_task = NULL;
 	genpd->resume_count = 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 73e938b..1acfe05 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -71,6 +71,7 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
+	bool force_restore; /* True to always initially restore devices */
 	struct gpd_cpuidle_data *cpuidle_data;
 	void (*attach_dev)(struct device *dev);
 	void (*detach_dev)(struct device *dev);
@@ -141,7 +142,8 @@ extern int pm_genpd_name_attach_cpuidle(const char *name,
int state);
 extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_detach_cpuidle(const char *name);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
-			  struct dev_power_governor *gov, bool is_off);
+			  struct dev_power_governor *gov, bool is_off,
+			  bool force_restore);

 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_poweron(const char *domain_name);
-- 
1.7.9.5
-----8<----
