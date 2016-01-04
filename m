From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2] thermal: re-calculate k_po/k_pu when update
 sustainable power
Date: Mon, 4 Jan 2016 22:31:19 +0800
Message-ID: <20160104143119.GC29062@leoy-linaro>
References: <1451471920-2148-1-git-send-email-leo.yan@linaro.org>
 <20151231172125.GA11863@localhost.localdomain>
 <20160101000347.GA2572@leoy-linaro>
 <568A55F2.10800@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <568A55F2.10800@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, javi.merino@arm.com
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 04, 2016 at 11:22:26AM +0000, Daniel Thompson wrote:
> On 01/01/16 00:03, Leo Yan wrote:
> >Hi Eduardo,
> >
> >Thanks for review.
> >
> >On Thu, Dec 31, 2015 at 09:21:26AM -0800, Eduardo Valentin wrote:
> >>On Wed, Dec 30, 2015 at 06:38:40PM +0800, Leo Yan wrote:
> >>>k_po/k_pu are in essence ratio values compared with sustainable power.
> >>>So when update sustainable power, we can recalculate k_po/k_pu simply
> >>>with below formula:
> >>>
> >>>                sustainable_power(new)
> >>>     k_p(new) = ---------------------- * k_p(old)
> >>>                sustainable_power(old)
> >>>
> >>>Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >>>---
> >>>  drivers/thermal/thermal_core.c | 6 +++++-
> >>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>>diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> >>>index d9e525c..223f8df 100644
> >>>--- a/drivers/thermal/thermal_core.c
> >>>+++ b/drivers/thermal/thermal_core.c
> >>>@@ -908,7 +908,7 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
> >>>  			const char *buf, size_t count)
> >>>  {
> >>>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
> >>>-	u32 sustainable_power;
> >>>+	u32 sustainable_power, old_val;
> >>>
> >>>  	if (!tz->tzp)
> >>>  		return -EIO;
> >>>@@ -916,8 +916,12 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
> >>>  	if (kstrtou32(buf, 10, &sustainable_power))
> >>>  		return -EINVAL;
> >>>
> >>>+	old_val = tz->tzp->sustainable_power;
> >>>+
> >>>  	tz->tzp->sustainable_power = sustainable_power;
> >>>
> >>>+	tz->tzp->k_po = (tz->tzp->k_po * sustainable_power) / old_val;
> >>>+	tz->tzp->k_pu = (tz->tzp->k_pu * sustainable_power) / old_val;
> >>
> >>I believe this has to be done by the governor. These properties are
> >>power_allocator specific. thermal_core should not really care about
> >>them.
> >
> >Okay, I will try to update these properties in power_allocator.c.
> >Javi, do you think this is fine for you?
> 
> If sustainable power were to change frequently (perhaps on
> entry/exit of a fan inhibitor mode?) then we would accumulate
> rounding errors here...

Correct, I observed it accumulates some minor deviation after change
sustainable power several times.

I think we should change to use k_po_ratio and k_pu_ratio to represent
relationship between k_po/k_pu and sustainable power, and update
k_po/k_pu when sustainable power has been changed.

[...]

Thanks,
Leo Yan
