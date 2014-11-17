From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
Date: Tue, 18 Nov 2014 00:39:32 +0100
Message-ID: <2808463.UGmrrQ79Aq@vostro.rjw.lan>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54714 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752612AbaKQXS3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 18:18:29 -0500
In-Reply-To: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: stefan.wahren@i2se.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

On Monday, November 17, 2014 01:38:00 PM Viresh Kumar wrote:
> Giving a warning in case we add duplicate OPPs doesn't workout that great. For
> example just playing with cpufreq-dt driver as a module results in this:
> 
> $ modprobe cpufreq-dt
> $ modprobe -r cpufreq-dt
> $ modprobe cpufreq-dt
> 
> cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
> freq: 261819000, volt: 1350000, enabled: 1. New: freq: 261819000, volt: 1350000,
> enabled: 1
> cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
> freq: 360000000, volt: 1350000, enabled: 1. New: freq: 360000000, volt: 1350000,
> enabled: 1
> cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
> freq: 392728000, volt: 1450000, enabled: 1. New: freq: 392728000, volt: 1450000,
> enabled: 1
> cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
> freq: 454737000, volt: 1550000, enabled: 1. New: freq: 454737000, volt: 1550000,
> enabled: 1
> 
> This happens because we don't destroy OPPs (created during ->init()) while
> unloading modules.
> 
> Now the question is: Should we destroy these OPPs?
> 
> Logically kernel drivers *must* free resources they acquired. But in this
> particular case, the OPPs are created using a static list present in device
> tree. Destroying and then allocating them again isn't of much benefit. The only
> benefit of removing OPPs is to save some space if the driver isn't loaded again.
> 
> This has its own complications. OPPs can be created either from DT (static) or
> platform code (dynamic). Driver should only remove static OPPs and not the
> dynamic ones as they are controlled from platform code. But there is no field in
> 'struct dev_pm_opp' which has this information to distinguish between different
> kind of OPPs.
> 
> Because of all this, I wasn't sure if drivers should remove static OPPs during
> their removal. And so just fixing the reported issue by issuing a dev_dbg()
> instead of dev_warn().
> 
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 89ced95..490e9db 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -466,9 +466,9 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
>  		int ret = opp->available && new_opp->u_volt == opp->u_volt ?
>  			0 : -EEXIST;
>  
> -		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
> -			 __func__, opp->rate, opp->u_volt, opp->available,
> -			 new_opp->rate, new_opp->u_volt, new_opp->available);
> +		dev_dbg(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
> +			__func__, opp->rate, opp->u_volt, opp->available,
> +			new_opp->rate, new_opp->u_volt, new_opp->available);
>  		mutex_unlock(&dev_opp_list_lock);
>  		kfree(new_opp);
>  		return ret;

Don't you think that this may hide real bugs?

Rafael

