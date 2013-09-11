From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/4] ARM: shmobile: change dev_id to cpu0 while registering
 cpu clock
Date: Wed, 11 Sep 2013 18:25:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1309111743130.26942@axis700.grange>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1378835989-19281-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57061 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048Ab3IKQ00 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 12:26:26 -0400
In-Reply-To: <1378835989-19281-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org, Magnus Damm <damm@opensource.se>

On Tue, 10 Sep 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Currently all clkdev registration use "cpufreq-cpu0.0" as dev_id
> for cpu clock which refers to virtual platform device. It needs to
> be "cpu0" instead which is actual cpu0 device id.
> 
> This patch changes the dev_id from "cpufreq-cpu0.0" to "cpu0".
> 
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Magnus Damm <damm@opensource.se>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Tested-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks
Guennadi

> ---
>  arch/arm/mach-shmobile/clock-r8a73a4.c | 2 +-
>  arch/arm/mach-shmobile/clock-sh73a0.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobil=
> e/clock-r8a73a4.c
> index 8ea5ef6..5bd2e85 100644
> --- a/arch/arm/mach-shmobile/clock-r8a73a4.c
> +++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
> @@ -555,7 +555,7 @@ static struct clk_lookup lookups[] =3D {
>  =09CLKDEV_CON_ID("pll2h",=09=09=09&pll2h_clk),
> =20
>  =09/* CPU clock */
> -=09CLKDEV_DEV_ID("cpufreq-cpu0",=09=09&z_clk),
> +=09CLKDEV_DEV_ID("cpu0",=09=09=09&z_clk),
> =20
>  =09/* DIV6 */
>  =09CLKDEV_CON_ID("zb",=09=09=09&div6_clks[DIV6_ZB]),
> diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile=
> /clock-sh73a0.c
> index 1942eae..c92c023 100644
> --- a/arch/arm/mach-shmobile/clock-sh73a0.c
> +++ b/arch/arm/mach-shmobile/clock-sh73a0.c
> @@ -616,7 +616,7 @@ static struct clk_lookup lookups[] =3D {
>  =09CLKDEV_DEV_ID("smp_twd", &twd_clk), /* smp_twd */
> =20
>  =09/* DIV4 clocks */
> -=09CLKDEV_DEV_ID("cpufreq-cpu0", &div4_clks[DIV4_Z]),
> +=09CLKDEV_DEV_ID("cpu0", &div4_clks[DIV4_Z]),
> =20
>  =09/* DIV6 clocks */
>  =09CLKDEV_CON_ID("vck1_clk", &div6_clks[DIV6_VCK1]),
> --=20
> 1.8.1.2
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
