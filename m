From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 11/21] cpuidle: replace multiline statements with single
 line in cpuidle_idle_call()
Date: Thu, 26 Sep 2013 00:03:16 +0200
Message-ID: <52435DA4.3080204@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <c79ae2ab0a5a3946fcd0e68c855742f06f695f0f.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:41635 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab3IYWDT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 18:03:19 -0400
Received: by mail-wi0-f177.google.com with SMTP id cb5so328648wib.10
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 15:03:18 -0700 (PDT)
In-Reply-To: <c79ae2ab0a5a3946fcd0e68c855742f06f695f0f.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> Few statements in cpuidle_idle_call() are broken into multiple lines,=
 whereas
> they can actually come in a single line. Convert those to single line=
=2E
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I splitted these lines because they have 81 cols.

> ---
>  drivers/cpuidle/cpuidle.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index ed67e3c..43d5836 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -145,8 +145,7 @@ int cpuidle_idle_call(void)
>  	broadcast =3D drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_ST=
OP;
> =20
>  	if (broadcast)
> -		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
> -				   &dev->cpu);
> +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> =20
>  	if (cpuidle_state_is_coupled(dev, drv, next_state))
>  		entered_state =3D cpuidle_enter_state_coupled(dev, drv,
> @@ -155,8 +154,7 @@ int cpuidle_idle_call(void)
>  		entered_state =3D cpuidle_enter_state(dev, drv, next_state);
> =20
>  	if (broadcast)
> -		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
> -				   &dev->cpu);
> +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> =20
>  	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> =20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

