From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle/idle: move idle traces to cpuidle_enter_state
Date: Sat, 05 Jul 2014 17:45:24 +0200
Message-ID: <53B81D94.6000404@linaro.org>
References: <1404293458-9799-1-git-send-email-sandeep.tripathy@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:41203 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaGEPp1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Jul 2014 11:45:27 -0400
Received: by mail-we0-f177.google.com with SMTP id u56so2626521wes.8
        for <linux-pm@vger.kernel.org>; Sat, 05 Jul 2014 08:45:26 -0700 (PDT)
In-Reply-To: <1404293458-9799-1-git-send-email-sandeep.tripathy@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sandeep Tripathy <sandeep.tripathy@linaro.org>, rjw@rjwysocki.net
Cc: rostedt@goodmis.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On 07/02/2014 11:30 AM, Sandeep Tripathy wrote:
>   idle_exit event is the first event after a core exits
> idle state. So this should be traced before local irq
> is ebabled. Likewise idle_entry is the last event before
> a core enters idle state. This will ease visualising the
> cpu idle state from kernel traces.
>
> Signed-off-by: Sandeep Tripathy <sandeep.tripathy@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/cpuidle.c | 3 +++
>   kernel/sched/idle.c       | 4 ----
>   2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 8236746..97680d0 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -99,12 +99,15 @@ int cpuidle_enter_state(struct cpuidle_device *de=
v, struct cpuidle_driver *drv,
>   	ktime_t time_start, time_end;
>   	s64 diff;
>
> +	trace_cpu_idle_rcuidle(index, dev->cpu);
>   	time_start =3D ktime_get();
>
>   	entered_state =3D target_state->enter(dev, drv, index);
>
>   	time_end =3D ktime_get();
>
> +	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> +
>   	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
>   		local_irq_enable();
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 8f4390a..07c446a 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -141,7 +141,6 @@ static int cpuidle_idle_call(void)
>   					&dev->cpu);
>
>   			if (!ret) {
> -				trace_cpu_idle_rcuidle(next_state, dev->cpu);
>
>   				/*
>   				 * Enter the idle state previously
> @@ -154,9 +153,6 @@ static int cpuidle_idle_call(void)
>   				entered_state =3D cpuidle_enter(drv, dev,
>   							      next_state);
>
> -				trace_cpu_idle_rcuidle(PWR_EVENT_EXIT,
> -						       dev->cpu);
> -
>   				if (broadcast)
>   					clockevents_notify(
>   						CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

