From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: rcar: Add support for R8A7795 SoC
Date: Mon, 7 Aug 2017 09:07:05 +0530
Message-ID: <20170807033705.GE28857@vireshk-i7>
References: <1501852680-21127-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32864 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdHGDhI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Aug 2017 23:37:08 -0400
Received: by mail-pg0-f49.google.com with SMTP id u5so28779971pgn.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Aug 2017 20:37:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1501852680-21127-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On 04-08-17, 15:18, Simon Horman wrote:
> From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> 
> After the commit "a399dc9fc50 cpufreq: shmobile: Use generic platdev
> driver", will use cpufreq-dt-platdev driver to enable cpufreq-dt support.
> Hence, follow the implementation to support new R8A7795 SoC.
> 
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> This is identical to a patch posted by Khiem last year.
> At the time it was asked if using opp-v2 was the preferred approach.
> 
> https://patchwork.kernel.org/patch/9054011/
> 
> An inspection of the current upstream kernel code seems to indicate
> that adding a binding as this patch does is compatibile with using opp-v2
> and I plan to post DTS patches separately which make use of the opp-v2
> bindings - they depend on this driver change to work.
> 
> I have provided an integration patch with this patch, those DTS changes,
> and Renesas clock updates also depended on by the DTS changes. The result
> is working CPUFreq for the r8a7795 (R-Car H3) ES1.0.
> 
> If this work is acceptable I plan to follow up with patches to
> enable CPUFreq on the r8a7796 (R-Car M3-W).
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/r8a7795-cpufreq
> 
> A description of steps taken to lightly exercise the above can be found here:
> 
> http://elinux.org/Tests:R-CAR-GEN3-CPUFreq
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 096aea7fcb67..13b72f3c420b 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -67,6 +67,7 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "renesas,r8a7792", },
>  	{ .compatible = "renesas,r8a7793", },
>  	{ .compatible = "renesas,r8a7794", },
> +	{ .compatible = "renesas,r8a7795", },
>  	{ .compatible = "renesas,sh73a0", },
>  
>  	{ .compatible = "rockchip,rk2928", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
