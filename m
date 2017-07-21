From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: speedstep: remove unnecessary static in speedstep_detect_chipset()
Date: Sat, 22 Jul 2017 00:38:22 +0200
Message-ID: <1908499.SpSD1enk2O@aspire.rjw.lan>
References: <20170705030921.GA18166@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44446 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753502AbdGUWqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 18:46:16 -0400
In-Reply-To: <20170705030921.GA18166@embeddedgus>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, July 04, 2017 10:09:21 PM Gustavo A. R. Silva wrote:
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
>  
>  		hostbridge  = pci_get_subsys(PCI_VENDOR_ID_INTEL,
>  			      PCI_DEVICE_ID_INTEL_82815_MC,
> 

Applied, thanks!
