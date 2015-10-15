From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 1/4] soc: dove: Let genpd deal with disabling of unused PM domains
Date: Thu, 15 Oct 2015 09:57:55 +0200
Message-ID: <87a8rk36nw.fsf@free-electrons.com>
References: <1444134450-17895-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56189 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750711AbbJOH6H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 03:58:07 -0400
In-Reply-To: <1444134450-17895-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 6 Oct 2015 14:27:30 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>

Hi Ulf and Sebastian,
 
 On mar., oct. 06 2015, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Genpd tries from a late_initcall to disable unused PM domains, which makes
> it unnecessary to also manage this from any earlier phase when for example
> initializing a genpd.

I can't test it and I didn't follow this part.

Sebastian could you have a look on this patch?

Thanks,

Gregory

>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/soc/dove/pmu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
> index 052aecf..abd0879 100644
> --- a/drivers/soc/dove/pmu.c
> +++ b/drivers/soc/dove/pmu.c
> @@ -396,7 +396,6 @@ int __init dove_init_pmu(void)
>  
>  		__pmu_domain_register(domain, np);
>  	}
> -	pm_genpd_poweroff_unused();
>  
>  	/* Loss of the interrupt controller is not a fatal error. */
>  	parent_irq = irq_of_parse_and_map(pmu->of_node, 0);
> -- 
> 1.9.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
