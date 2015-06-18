From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] clocksource: sh_cmt: Only perform clocksource suspend/resume if enabled
Date: Thu, 18 Jun 2015 17:14:29 +0300
Message-ID: <1829815.c8lIHLtv9K@avalon>
References: <1434622954-26747-1-git-send-email-geert+renesas@glider.be> <1434622954-26747-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:38672 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbbFRONn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 10:13:43 -0400
In-Reply-To: <1434622954-26747-2-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 18 June 2015 12:22:33 Geert Uytterhoeven wrote:
> Currently the sh_cmt clocksource timer is disabled or enabled
> unconditionally on clocksource suspend resp. resume, even if a better
> clocksource is present (e.g. arch_sys_counter) and the sh_cmt
> clocksource is not enabled.
> 
> As sh_cmt is a syscore device when its timer is enabled, this may lead
> to a genpd.prepared_count imbalance in the presence of PM Domains, which
> may cause a lock up during reboot after s2ram.
> 
> During suspend:
>   - pm_genpd_prepare() is called for all non-syscore devices (incl.
>     sh_cmt), increasing genpd.prepared_count for each device,
>   - clocksource.suspend() is called for all clocksource devices,
>   - sh_cmt_clocksource_suspend() calls sh_cmt_stop(), which is a no-op
>     as the clocksource was not enabled.
> 
> During resume:
>   - clocksource.resume() is called for all clocksource devices,
>   - sh_cmt_clocksource_resume() calls sh_cmt_start(), which enables the
>     clocksource timer, and turns sh_cmt into a syscore device,
>   - pm_genpd_complete() is called for all non-syscore devices (excl.
>     sh_cmt now!), decreasing genpd.prepared_count for each device but
>     sh_cmt.
> 
> Now genpd.prepared_count of the PM Domain containing sh_cmt is still 1
> instead of zero.  On subsequent suspend/resume cycles, sh_cmt is still a
> syscore device, hence it's skipped for pm_genpd_{prepare,complete}(),
> keeping the imbalance of genpd.prepared_count at 1.
> 
> During reboot:
>   - platform_drv_shutdown() is called for any platform device that has
>     a driver with a .shutdown() method (only rcar-dmac on R-Car Gen2),
>   - platform_drv_shutdown() calls dev_pm_domain_detach(), which
>     calls genpd_dev_pm_detach(),
>   - genpd_dev_pm_detach() keeps calling pm_genpd_remove_device() until
>     it doesn't return -EAGAIN,
>   - If the device is part of the same PM Domain as sh_cmt,
>     pm_genpd_remove_device() always fails with -EAGAIN due to
>     genpd.prepared_count > 0.
>   - Infinite loop in genpd_dev_pm_detach().
> 
> To fix this, only disable or enable the clocksource timer on clocksource
> suspend resp. resume if the clocksource was enabled.
> 
> This was tested on r8a7791/koelsch with the CPG Clock Domain:
>   - using arch_sys_counter as the clocksource, which is the default, and
>     which showed the problem,
>   - using sh_cmt as a clocksource ("echo ffca0000.timer > \
>     /sys/devices/system/clocksource/clocksource0/current_clocksource"),
>     which behaves the same as before.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good catch. The patch looks good to me.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I've quickly checked the MTU2 and TMU timer drivers and they should be immune 
to the issue, but I'd appreciate if you could confirm that.

> ---
>  drivers/clocksource/sh_cmt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
> index b8ff3c64cc452a16..c96de14036a0adeb 100644
> --- a/drivers/clocksource/sh_cmt.c
> +++ b/drivers/clocksource/sh_cmt.c
> @@ -661,6 +661,9 @@ static void sh_cmt_clocksource_suspend(struct
> clocksource *cs) {
>  	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
> 
> +	if (!ch->cs_enabled)
> +		return;
> +
>  	sh_cmt_stop(ch, FLAG_CLOCKSOURCE);
>  	pm_genpd_syscore_poweroff(&ch->cmt->pdev->dev);
>  }
> @@ -669,6 +672,9 @@ static void sh_cmt_clocksource_resume(struct clocksource
> *cs) {
>  	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
> 
> +	if (!ch->cs_enabled)
> +		return;
> +
>  	pm_genpd_syscore_poweron(&ch->cmt->pdev->dev);
>  	sh_cmt_start(ch, FLAG_CLOCKSOURCE);
>  }

-- 
Regards,

Laurent Pinchart

