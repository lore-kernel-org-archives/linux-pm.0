From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] drivers: cpuidle: remove stale irq disabling call
 in cpuidle_enter_freeze()
Date: Wed, 25 Feb 2015 15:13:23 +0100
Message-ID: <54EDD883.30608@linaro.org>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <1424800730-32059-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:33783 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbbBYON1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 09:13:27 -0500
Received: by wevk48 with SMTP id k48so3912955wev.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2015 06:13:27 -0800 (PST)
In-Reply-To: <1424800730-32059-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 02/24/2015 06:58 PM, Lorenzo Pieralisi wrote:
> On return from cpuidle_enter_freeze() irqs are re-enabled by the func=
tion
> caller (ie cpuidle_idle_call) in the idle loop. This patch removes a =
stale
> local_irq_disable() call and its stale comment in cpuidle_enter_freez=
e(),
> since they disagree and do not serve a useful purpose.
>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   drivers/cpuidle/cpuidle.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 4d53458..f47edc6c 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -144,9 +144,6 @@ void cpuidle_enter_freeze(void)
>   		cpuidle_enter(drv, dev, index);
>   	else
>   		arch_cpu_idle();
> -
> -	/* Interrupts are enabled again here. */
> -	local_irq_disable();
>   }

Hmm, I think Rafael added this prevent lockdep to raise a warning.

Otherwise, cpuidle_enter or arch_cpu_idle enables the irq again and the=
n=20
when exiting the cpu_idle_call, we enable them again, so leading to a=20
lockdep WARN in trace_hardirqs_on_caller.

That said, if we have to do this, it may reveal something is wrong in=20
the code.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

