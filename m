From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [V4 patch 02/15] ARM: ux500: cpuidle: replace for_each_online_cpu
 by for_each_possible_cpu
Date: Tue, 30 Apr 2013 14:46:55 +0530
Message-ID: <CANuQgHF9x2g=nybwEKMwihd0M9ps9rOaGw_zJM6a46m5-GKT0w@mail.gmail.com>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
	<1366707285-12179-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:42876 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759102Ab3D3JQz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2013 05:16:55 -0400
Received: by mail-ob0-f178.google.com with SMTP id 16so252639obc.9
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2013 02:16:55 -0700 (PDT)
In-Reply-To: <1366707285-12179-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, andrew@lunn.ch, kgene.kim@samsung.com, jason@lakedaemon.net, horms@verge.net.au, Patch Tracking <patches@linaro.org>, khilman@deeprootsystems.com, magnus.damm@gmail.com, linux-pm@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, nsekhar@ti.com, rob.herring@calxeda.com, deepthi@linux.vnet.ibm.com, tony@atomide.com, lethal@linux-sh.org, linaro-kernel@lists.linaro.org, kernel@pengutronix.de, josephl@nvidia.com, jkosina@suse.cz, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org

On 23 April 2013 14:24, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> All the drivers are using, in their initialization function, the
> for_each_possible_cpu macro.
>
> Using for_each_online_cpu means the driver must handle the initialization
> of the cpuidle device when a cpu is up which is not the case here.
>
> Change the macro to for_each_possible_cpu as that fix the hotplug
> initialization and make the initialization routine consistent with the
> rest of the code in the different drivers.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/cpuidle.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
> index c29c1bf..5657d4a 100644
> --- a/arch/arm/mach-ux500/cpuidle.c
> +++ b/arch/arm/mach-ux500/cpuidle.c
> @@ -125,7 +125,7 @@ int __init ux500_idle_init(void)
>                 return ret;
>         }
>
> -       for_each_online_cpu(cpu) {
> +       for_each_possible(cpu) {

for_each_possible(cpu) or for_each_possible_cpu(cpu) ?
>                 device = &per_cpu(ux500_cpuidle_device, cpu);
>                 device->cpu = cpu;
>                 ret = cpuidle_register_device(device);
> @@ -139,7 +139,7 @@ out:
>         return ret;
>
>  out_unregister:
> -       for_each_online_cpu(cpu) {
> +       for_each_possible_cpu(cpu) {
>                 device = &per_cpu(ux500_cpuidle_device, cpu);
>                 cpuidle_unregister_device(device);
>         }
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--
with warm regards,
Chander Kashyap
