From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4][V2] ARM: timer-sp: Set dynamic irq affinity
Date: Fri, 08 Mar 2013 16:28:55 +0100
Message-ID: <513A03B7.7000004@linaro.org>
References: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org> <1362219013-18173-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:39430 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758719Ab3CHP3B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Mar 2013 10:29:01 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so1252757pbc.24
        for <linux-pm@vger.kernel.org>; Fri, 08 Mar 2013 07:29:00 -0800 (PST)
In-Reply-To: <1362219013-18173-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: john.stultz@linaro.org, tglx@linutronix.de, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: viresh.kumar@linaro.org, jacob.jun.pan@linux.intel.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, rickard.andersson@stericsson.com, vincent.guittot@linaro.org, linus.walleij@stericsson.com

On 03/02/2013 11:10 AM, Daniel Lezcano wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> When a cpu goes to a deep idle state where its local timer is shutdow=
n, it
> notifies the time frame work to use the broadcast timer instead.
>=20
> Unfortunately, the broadcast device could wake up any CPU, including =
an idle one
> which is not concerned by the wake up at all.
>=20
> This implies, in the worst case, an idle CPU will wake up to send an =
IPI to
> another idle cpu.
>=20
> This patch fixes this for ARM platforms using timer-sp, by setting
> CLOCK_EVT_FEAT_DYNIRQ feature.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi Russell,

I asked Thomas if he could take this patch in its tree but it falls
under your umbrella. Thomas agreed to take it if you ack this patch.

Is this patch acceptable for you ?

Thanks in advance
  -- Daniel


>  arch/arm/common/timer-sp.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
> index 9d2d3ba..ae3c0f9 100644
> --- a/arch/arm/common/timer-sp.c
> +++ b/arch/arm/common/timer-sp.c
> @@ -158,7 +158,8 @@ static int sp804_set_next_event(unsigned long nex=
t,
>  }
> =20
>  static struct clock_event_device sp804_clockevent =3D {
> -	.features       =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHO=
T,
> +	.features       =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHO=
T |
> +		CLOCK_EVT_FEAT_DYNIRQ,
>  	.set_mode	=3D sp804_set_mode,
>  	.set_next_event	=3D sp804_set_next_event,
>  	.rating		=3D 300,
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

