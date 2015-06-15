From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 12/14] drivers: sh: Stop using pm_runtime.c for
 multi-platform shmobile with genpd
Date: Mon, 15 Jun 2015 21:44:47 +0200
Message-ID: <CAMuHMdWfqXZKUShiSqi0RmGpfkqgsL-5We__Vnou1aj5OHYPmA@mail.gmail.com>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
	<1432839219-475-13-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432839219-475-13-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-clk@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 28, 2015 at 8:53 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Now most multi-platform ARM shmobile platforms (SH-Mobile, R-Mobile,
> R-Car, RZ) use the CPG Clock Domain to take care of PM runtime
> management of the module clocks, we no longer need the legacy default PM
> domain hack, which also prevented registering the real PM domain.
>
> EMMA Mobile EV2 doesn't have MSTP clocks and doesn't use the CPG Clock
> Domain. But all its device drivers manage clocks explicitly, without
> relying on Runtime PM, so it doesn't need the legacy default PM hack
> neither.
>
> Hence do not compile it when running an ARM multi-platform kernel with
> genpd support.
>
> The default PM domain is still needed:
>   - for legacy SuperH,
>   - for legacy (non-DT) ARM/shmobile platforms
>       - without genpd support (r8a7778, r8a7779),
>       - with genpd support, for devices in the "C5" always-on power
>         area (r8a7740, sh73a0),
>   - for the CONFIG_PM=n case.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> v2:
>   - Add Reviewed-by,
>   - Just stop compiling pm_runtime.c instead of using a runtime check,
>     as no multi-platform ARM platforms need this anymore.

The runtime check must stay for the ARM multiplatform CONFIG_PM=n case,
to prevent the code from running on non-shmobile machines. Will fix.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
