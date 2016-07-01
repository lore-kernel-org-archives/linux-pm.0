From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5] cpuidle: Fix last_residency division
Date: Fri, 1 Jul 2016 16:32:06 +0200
Message-ID: <57767EE6.4080108@linaro.org>
References: <1467383054-1959-1-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38180 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbcGAOcI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 10:32:08 -0400
Received: by mail-wm0-f50.google.com with SMTP id r201so31906291wme.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2016 07:32:07 -0700 (PDT)
In-Reply-To: <1467383054-1959-1-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, nicolas.pitre@linaro.org, bsingharora@gmail.com

On 07/01/2016 04:24 PM, Shreyas B. Prabhu wrote:
> Snooze is a poll idle state in powernv and pseries platforms. Snooze
> has a timeout so that if a cpu stays in snooze for more than target
> residency of the next available idle state, then it would exit thereb=
y
> giving chance to the cpuidle governor to re-evaluate and
> promote the cpu to a deeper idle state. Therefore whenever snooze exi=
ts
> due to this timeout, its last_residency will be target_residency of n=
ext
> deeper state.
>
> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()=
")
> changed the math around last_residency calculation. Specifically, whi=
le
> converting last_residency value from nanoseconds to microseconds it d=
oes
> right shift by 10. Due to this, in snooze timeout exit scenarios
> last_residency calculated is roughly 2.3% less than target_residency =
of
> next available state. This pattern is picked up get_typical_interval(=
)
> in the menu governor and therefore expected_interval in menu_select()=
 is
> frequently less than the target_residency of any state but snooze.
>
> Due to this we are entering snooze at a higher rate, thereby affectin=
g
> the single thread performance.
>
> Fix this by using precise division via ktime_us_delta.
>
> Reported-by: Anton Blanchard <anton@samba.org>
> Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

