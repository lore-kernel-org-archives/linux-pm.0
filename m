From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH] cpuidle: mvebu: indicate failure to enter deeper
 sleep states
Date: Mon, 5 Oct 2015 13:45:21 +0200
Message-ID: <561262D1.5070506@linaro.org>
References: <E1ZiI7T-0002zo-Ez@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34671 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbbJELpY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 07:45:24 -0400
Received: by wicfx3 with SMTP id fx3so115524451wic.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2015 04:45:23 -0700 (PDT)
In-Reply-To: <E1ZiI7T-0002zo-Ez@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On 10/03/2015 10:24 AM, Russell King wrote:
> The cpuidle ->enter method expects the return value to be the sleep
> state we entered.  Returning negative numbers or other codes is not
> permissible since coupled CPU idle was merged.



> At least some of the mvebu_v7_cpu_suspend() implementations return th=
e
> value from cpu_suspend(), which returns zero if the CPU vectors back
> into the kernel via cpu_resume() (the success case), or the non-zero
> return value of the suspend actor, or one (failure cases).
>
> We do not want to be returning the failure case value back to CPU idl=
e
> as that indicates that we successfully entered one of the deeper idle
> states.  Always return zero instead, indicating that we slept for the
> shortest amount of time.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Please think about this - having only an Armada 388 platform, I can't
> test this due to CPU idle being disabled there.  However, the code pa=
ths
> indicate that if we fail to sleep in armada_370_xp_pmsu_idle_enter() =
or
> armada_38x_do_cpu_suspend() fail to sleep, we end up reporting that w=
e
> successfully slept in CPU idle state 1 in both cases.
>
> Rafael - the code in cpuidle.c prior to the addition of coupled CPU i=
dle
> seems to allow the return of negative error numbers from the ->enter(=
)
> method:
>
>          if (entered_state >=3D 0) {
>                  /* Update cpuidle counters */
>                  /* This can be moved to within driver enter routine
>                   * but that results in multiple copies of same code.
>                   */
>                  dev->states_usage[entered_state].time +=3D dev->last=
_residency;
>                  dev->states_usage[entered_state].usage++;
>          } else {
>                  dev->last_residency =3D 0;
>          }
>
> Since coupled CPU idle, negative return codes will give a negative ta=
ble
> index inside cpuidle_state_is_coupled() - which is obviously buggy.  =
Does
> this need fixing?  If so, this patch below is wrong, and we should be
> returning a negative errno rather than zero on failure to enter a low
> power state.

It is not possible since the commit 0b89e9aa2.

This change was to prevent to re-enable the local interrupt when we are=
=20
in the process of coupling an idle state and let the coupled code to=20
handle that.

If the backend driver changed the state in our back (for example to a=20
shallower state) to a non coupled one, the local interrupt will be=20
re-enabled. If at the contrary, the backend driver choose a deeper idle=
=20
state which is coupled, we won't re-enable the interrupt. I don't know=20
any driver doing this but the code allows it (not sure it is a good=20
thing - anyway).

So the test:

if (!cpuidle_state_is_coupled(dev, drv, entered_state))

should be:

if (!cpuidle_state_is_coupled(dev, drv, *index*))

=2E.. in order to have the decisions made when entering this function=20
symmetric to the ones which will be taken when exiting the function=20
because they will be based on the same index.

It is the same behavior than the broadcast timer enter/exit in the same=
=20
function.

To be clean, the above should be fixed.

But in any case, armada_370_xp_pmsu_idle_enter and=20
armada_38x_do_cpu_suspend can return a negative value because they don'=
t=20
depend on the ARCH_NEEDS_CPU_IDLE_COUPLED, and cpuidle_state_is_coupled=
=20
is an inline for 'return false'.

  -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

