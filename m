From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 9908859acaa9 cpuidle/menu: add per CPU PM QoS resume latency consideration
Date: Thu, 23 Feb 2017 23:34:05 +0100
Message-ID: <2909793.Vfsrmqmg03@aspire.rjw.lan>
References: <1487768197.27533.5.camel@gmx.de> <2050688.jCOqd8xbcD@aspire.rjw.lan> <e8261472-4338-eab2-98e1-5dd6039899f7@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46304 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751242AbdBWWjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2017 17:39:33 -0500
In-Reply-To: <e8261472-4338-eab2-98e1-5dd6039899f7@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>, Linux PM <linux-pm@vger.kernel.org>

On Thursday, February 23, 2017 09:55:17 PM Alex Shi wrote:
> 
> On 02/23/2017 08:15 PM, Rafael J. Wysocki wrote:
> > On Wednesday, February 22, 2017 10:55:04 PM Alex Shi wrote:
> >>>
> >>> Its not hard; spinlock_t ends up being a mutex, and this is ran from the
> >>> idle thread. What thread do you think we ought to run when we block
> >>> idle?
> >>>
> >>
> >> Straight right.
> >> Thanks for explanations! :)
> > 
> > I overlooked that, sorry.
> > 
> > Shall we revert?
> > 
> > I don't want RT to be broken because of this.
> > 
> 
> The RT kernel had a fix already. :)
> This feature is very useful to save power of cpu. We could have a better fix
> to keep this feature and good for RT.

Well, first, please submit this properly (with a proper subject and CC to linux-pm)
if I'm expected to apply it.

Second ->

> From cfe82c555628f7197ecd91d3b8092a98b34a371a Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linaro.org>
> Date: Thu, 23 Feb 2017 21:27:09 +0800
> Subject: [PATCH] cpuidle/menu: skip lock in per cpu resume latency reading
> 
> dev_pm_qos_read_value using a lock to proctect the concurrent device
> latency reading, that is useful for multiple cpu access a global device.
> But it's not necessary for a per cpu data reading here. And furthermore,
> RT kernel using mutex to replace spinlock causes fake panic here.
> 
> So, skip the lock using is nice for this per cpu value reading.
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> ---
>  drivers/cpuidle/governors/menu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 8d6d25c..b852d99 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -273,6 +273,14 @@ static unsigned int get_typical_interval(struct menu_device *data)
>  	goto again;
>  }
>  
> +int read_per_cpu_resume_latency(int cpu)
> +{
> +	struct device *dev = get_cpu_device(cpu);
> +
> +	return IS_ERR_OR_NULL(dev->power.qos) ?
> +		0 : pm_qos_read_value(&dev->power.qos->resume_latency);

-> This essentially duplicates __dev_pm_qos_read_value() except for the lockdep assertion.

What about the (untested) patch below instead?

Thanks,
Rafael


---
 drivers/base/power/qos.c         |    3 +--
 drivers/cpuidle/governors/menu.c |    2 +-
 include/linux/pm_qos.h           |    7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/power/qos.c
===================================================================
--- linux-pm.orig/drivers/base/power/qos.c
+++ linux-pm/drivers/base/power/qos.c
@@ -108,8 +108,7 @@ s32 __dev_pm_qos_read_value(struct devic
 {
 	lockdep_assert_held(&dev->power.lock);
 
-	return IS_ERR_OR_NULL(dev->power.qos) ?
-		0 : pm_qos_read_value(&dev->power.qos->resume_latency);
+	return dev_pm_qos_raw_read_value(dev);
 }
 
 /**
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -287,7 +287,7 @@ static int menu_select(struct cpuidle_dr
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
-	int resume_latency = dev_pm_qos_read_value(device);
+	int resume_latency = dev_pm_qos_raw_read_value(device);
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
Index: linux-pm/include/linux/pm_qos.h
===================================================================
--- linux-pm.orig/include/linux/pm_qos.h
+++ linux-pm/include/linux/pm_qos.h
@@ -172,6 +172,12 @@ static inline s32 dev_pm_qos_requested_f
 {
 	return dev->power.qos->flags_req->data.flr.flags;
 }
+
+static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+{
+	return IS_ERR_OR_NULL(dev->power.qos) ?
+		0 : pm_qos_read_value(&dev->power.qos->resume_latency);
+}
 #else
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 							  s32 mask)
@@ -236,6 +242,7 @@ static inline void dev_pm_qos_hide_laten
 
 static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev) { return 0; }
 static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
+static inline s32 dev_pm_qos_raw_read_value(struct device *dev) { return 0; }
 #endif
 
 #endif
