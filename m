From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/5] pm: domains: quieten down generic pm domains
Date: Thu, 01 May 2014 01:46:09 +0200
Message-ID: <10021780.rnCkCYmgZH@vostro.rjw.lan>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk> <E1WeP8U-0000Ug-RQ@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50040 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759665AbaD3X3j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Apr 2014 19:29:39 -0400
In-Reply-To: <E1WeP8U-0000Ug-RQ@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>

On Sunday, April 27, 2014 02:28:50 PM Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>

Since you need this one and [2/5] for the rest of the patchset, please feel
free to take them through your tree if that's convenient.

> ---
>  drivers/base/power/domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index bfb8955c406c..ea91ea0e137b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -42,7 +42,7 @@
>  	struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;			\
>  	if (!__retval && __elapsed > __td->field) {				\
>  		__td->field = __elapsed;					\
> -		dev_warn(dev, name " latency exceeded, new value %lld ns\n",	\
> +		dev_dbg(dev, name " latency exceeded, new value %lld ns\n",	\
>  			__elapsed);						\
>  		genpd->max_off_time_changed = true;				\
>  		__td->constraint_changed = true;				\
> @@ -242,7 +242,7 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>  			genpd->max_off_time_changed = true;
>  			genpd_recalc_cpu_exit_latency(genpd);
>  			if (genpd->name)
> -				pr_warning("%s: Power-on latency exceeded, "
> +				pr_debug("%s: Power-on latency exceeded, "
>  					"new value %lld ns\n", genpd->name,
>  					elapsed_ns);
>  		}
> @@ -566,7 +566,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>  			genpd->power_off_latency_ns = elapsed_ns;
>  			genpd->max_off_time_changed = true;
>  			if (genpd->name)
> -				pr_warning("%s: Power-off latency exceeded, "
> +				pr_debug("%s: Power-off latency exceeded, "
>  					"new value %lld ns\n", genpd->name,
>  					elapsed_ns);
>  		}
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
