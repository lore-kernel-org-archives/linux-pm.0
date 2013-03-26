From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 05/15] cpuidle: imx6: remove timer broadcast
 initialization
Date: Tue, 26 Mar 2013 15:25:01 +0800
Message-ID: <20130326072458.GA7141@S2101-09.ap.freescale.net>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:35264
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934123Ab3CZHYq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 03:24:46 -0400
Content-Disposition: inline
In-Reply-To: <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch, linus.walleij@linaro.org, linux@arm.linux.org.uk

On Mon, Mar 25, 2013 at 06:55:30PM +0100, Daniel Lezcano wrote:
> The initialization is done from the cpuidle framework.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-imx/cpuidle-imx6q.c |   15 ---------------
>  1 file changed, 15 deletions(-)
>=20
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cp=
uidle-imx6q.c
> index 5ae22f7..a783a63 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -6,7 +6,6 @@
>   * published by the Free Software Foundation.
>   */
> =20
> -#include <linux/clockchips.h>

Removing this causes the compile error below.

  CC      arch/arm/mach-imx/cpuidle-imx6q.o
arch/arm/mach-imx/cpuidle-imx6q.c: In function =E2=80=98imx6q_enter_wai=
t=E2=80=99:
arch/arm/mach-imx/cpuidle-imx6q.c:25:2: error: implicit declaration of =
function =E2=80=98clockevents_notify=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
arch/arm/mach-imx/cpuidle-imx6q.c:25:21: error: =E2=80=98CLOCK_EVT_NOTI=
=46Y_BROADCAST_ENTER=E2=80=99 undeclared (first use in this function)
arch/arm/mach-imx/cpuidle-imx6q.c:25:21: note: each undeclared identifi=
er is reported only once for each function it appears in
arch/arm/mach-imx/cpuidle-imx6q.c:45:21: error: =E2=80=98CLOCK_EVT_NOTI=
=46Y_BROADCAST_EXIT=E2=80=99 undeclared (first use in this function)
cc1: some warnings being treated as errors
make[2]: *** [arch/arm/mach-imx/cpuidle-imx6q.o] Error 1

Shawn

>  #include <linux/cpuidle.h>
>  #include <linux/module.h>
>  #include <asm/cpuidle.h>
> @@ -43,17 +42,6 @@ done:
>  	return index;
>  }
> =20
> -/*
> - * For each cpu, setup the broadcast timer because local timer
> - * stops for the states other than WFI.
> - */
> -static void imx6q_setup_broadcast_timer(void *arg)
> -{
> -	int cpu =3D smp_processor_id();
> -
> -	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
> -}
> -
>  static struct cpuidle_driver imx6q_cpuidle_driver =3D {
>  	.name =3D "imx6q_cpuidle",
>  	.owner =3D THIS_MODULE,
> @@ -84,8 +72,5 @@ int __init imx6q_cpuidle_init(void)
>  	/* Set chicken bit to get a reliable WAIT mode support */
>  	imx6q_set_chicken_bit();
> =20
> -	/* Configure the broadcast timer on each cpu */
> -	on_each_cpu(imx6q_setup_broadcast_timer, NULL, 1);
> -
>  	return imx_cpuidle_init(&imx6q_cpuidle_driver);
>  }
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

