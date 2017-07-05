From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: speedstep: remove unnecessary static in
 speedstep_detect_chipset()
Date: Wed, 5 Jul 2017 09:23:44 +0530
Message-ID: <20170705035344.GI3532@vireshk-i7>
References: <20170705030921.GA18166@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35743 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbdGEDxs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2017 23:53:48 -0400
Received: by mail-pg0-f51.google.com with SMTP id j186so117585206pge.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2017 20:53:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170705030921.GA18166@embeddedgus>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux@dominikbrodowski.net
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

+ Dominic,

On 04-07-17, 22:09, Gustavo A. R. Silva wrote:
> Remove unnecessary static on local variable hostbridge.
> Such variable is initialized before being used,
> on every execution path throughout the function.
> The static has no benefit and, removing it reduces
> the code size.
> 
> This issue was detected using Coccinelle and the following semantic patch:
> 
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
> 
> static T x@p;
> ...
> x = <+...x...+>
> 
> @@
> identifier x;
> expression e;
> type T;
> position p != bad.p;
> @@
> 
> -static
>  T x@p;
>  ... when != x
>      when strict
> ?x = e;
> 
> In the following log you can see the difference in the code size. Also,
> there is a significant difference in the bss segment. This log is the
> output of the size command, before and after the code change:
> 
> before:
>    text    data     bss     dec     hex filename
>    5084    3392     256    8732    221c drivers/cpufreq/speedstep-ich.o
> 
> after:
>    text    data     bss     dec     hex filename
>    5062    3304     192    8558    216e drivers/cpufreq/speedstep-ich.o
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/cpufreq/speedstep-ich.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
> index b86953a..0412a24 100644
> --- a/drivers/cpufreq/speedstep-ich.c
> +++ b/drivers/cpufreq/speedstep-ich.c
> @@ -207,7 +207,7 @@ static unsigned int speedstep_detect_chipset(void)
>  		 * 8100 which use a pretty old revision of the 82815
>  		 * host bridge. Abort on these systems.
>  		 */
> -		static struct pci_dev *hostbridge;
> +		struct pci_dev *hostbridge;

This was added way back Sep'02 by Dominic (@Dominic: I hope you are the same
Dominic with a different email id) and I don't think we need it to be static
here. Anyway, Dominic can respond on that.

commit 1673f3b404bd ("[PATCH] CPUfreq i386 drivers update")

(Note: You can find it in history kernel git repo, not the current one).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
