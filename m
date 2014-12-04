From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v7 08/11] arm/arm64: Unexport restart handlers
Date: Thu, 4 Dec 2014 14:36:27 +0100
Message-ID: <CAMuHMdVqCa+m1oMkuRHcTZKw2CWNHJVotWBwfTnfBNT11UPEjw@mail.gmail.com>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
	<1408495538-27480-9-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:36033 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbaLDNga convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 08:36:30 -0500
In-Reply-To: <1408495538-27480-9-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux PM list <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Jonas Jensen <jonas.jensen@gmail.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.o

Hi G=C3=BCnther,

On Wed, Aug 20, 2014 at 2:45 AM, Guenter Roeck <linux@roeck-us.net> wro=
te:
> Implementing a restart handler in a module don't make sense
> as there would be no guarantee that the module is loaded when
> a restart is needed. Unexport arm_pm_restart to ensure that
> no one gets the idea to do it anyway.

Why not? I was just going to do that, but I got greeted by:

ERROR: "arm_pm_restart" [drivers/power/reset/rmobile-reset.ko] undefine=
d!

So now we have to make sure all reset drivers for a zillion different
hardware devices are builtin, and can't be modular?

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v7: No change
> v6: No change
> v5: No change
> v4: No change
> v3: No change
> v2: No change
>
>  arch/arm/kernel/process.c   | 1 -
>  arch/arm64/kernel/process.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index ea279f7..250b6f6 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -121,7 +121,6 @@ void (*pm_power_off)(void);
>  EXPORT_SYMBOL(pm_power_off);
>
>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd=
);
> -EXPORT_SYMBOL_GPL(arm_pm_restart);
>
>  /*
>   * This is our default idle handler.
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.=
c
> index 0d3fb9f..398ab05 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -98,7 +98,6 @@ void (*pm_power_off)(void);
>  EXPORT_SYMBOL_GPL(pm_power_off);
>
>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd=
);
> -EXPORT_SYMBOL_GPL(arm_pm_restart);
>
>  /*
>   * This is our default idle handler.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
