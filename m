From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] thermal: rcar_thermal: use pm_runtime_put_sync()
Date: Tue, 10 Nov 2015 09:18:35 +0100
Message-ID: <CAMuHMdWSMsVZYF2jswCoRB217n_3OR8uikNtBYOfQHkQs3oWSA@mail.gmail.com>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
	<87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
	<87d1vili9c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34465 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbKJISf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 03:18:35 -0500
In-Reply-To: <87d1vili9c.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>

Hi Morimoto-san, Ulf,

On Tue, Nov 10, 2015 at 3:12 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> It is using pm_runtime_get_sync() on probe(). Let's use
> pm_runtime_put_sync() instead of pm_runtime_put(). Otherwise thermal
> sensor doesn't work after unbind/re-bind
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 13d01ed..f7cf2d7 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -373,7 +373,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>                 thermal_zone_device_unregister(priv->zone);
>         }
>
> -       pm_runtime_put(dev);
> +       pm_runtime_put_sync(dev);
>         pm_runtime_disable(dev);
>
>         return 0;

While I can confirm this fixes the issue, I think this is a bug in the PM
core, and thus your patch is merely a workaround.

Morimoto-san: I assume this is a recent regression. Have you tried to bisect?

With a bit more debugging info, this is the difference between the failing
and the "fixed" cases:

 unbind:

+rcar_thermal e61f0000.thermal: pm_clk_suspend()
+renesas-cpg-mssr e6150000.clock-controller: MSTP 522/thermal OFF
 rcar_thermal e61f0000.thermal: removing from PM domain clock-controller
 pm_genpd_remove_device: Remove e61f0000.thermal from clock-controller
-renesas-cpg-mssr e6150000.clock-controller: MSTP 522/thermal OFF

 bind:

 rcar_thermal e61f0000.thermal: adding to PM domain clock-controller
 __pm_genpd_add_device: Add e61f0000.thermal to clock-controller
 rcar_thermal e61f0000.thermal: Clock thermal con_id (null) managed by
runtime PM.
-rcar_thermal e61f0000.thermal: thermal sensor was broken
+rcar_thermal e61f0000.thermal: pm_clk_resume()
+renesas-cpg-mssr e6150000.clock-controller: MSTP 522/thermal ON
 rcar_thermal e61f0000.thermal: 1 sensor probed

In the failing case, pm_clk_suspend() is not called, and turning off the
module clock is thus delayed until removal of the device from the clock
domain.
But as pm_clk_suspend() wasn't called, the device isn't correctly resumed on
rebind, and the module clock is never re-enabled, leading to a failure.

Ulf, what do you think?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
