From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/7] Cpuidle: Minor fixes
Date: Mon, 24 Feb 2014 22:24:41 +0100
Message-ID: <530BB899.4060803@linaro.org>
References: <1393223377-5744-1-git-send-email-tuukka.tikkanen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:46636 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbaBXVYl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2014 16:24:41 -0500
Received: by mail-wi0-f181.google.com with SMTP id hi5so3631362wib.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2014 13:24:40 -0800 (PST)
In-Reply-To: <1393223377-5744-1-git-send-email-tuukka.tikkanen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>

On 02/24/2014 07:29 AM, Tuukka Tikkanen wrote:
> This set of patches makes some minor changes to menu governor and the=
 poll
> idle state.
>
> Patch 1 is simply a rename of a variable to make the name better repr=
esent
> the contained information.
>
> Patch 2 fixes calculating actual residency in cases where the entered=
 state
> is different from the state decided by the menu governor.
>
> Patch 3 makes sure the menu governor timer coefficients are not updat=
ed
> with values that might cause a coefficient to reach a value greater t=
han
> unity.
>
> Patch 4 fixes calculation actual residency in cases where the entered=
 state
> does not support measuring residency. In such cases the residency tim=
e
> is taken from time remaining until next timer expiry. The timer is ex=
pected
> to go off at the start of exit latency, not after it. Therefore the e=
xit
> latency must not be substracted from the assumed value.
>
> Patch 5 moves the performance multiplier based comparison out of the =
state
> selection loop by changing it into a latency requirement. This allows
> using a generic state selection function accepting only (duration, la=
tency)
> tuple as input. The change is possible by noting that performance mul=
tiplier
> is used only to check for a minimum predicted idle duration to exit l=
atency
> ratio. As predicted idle duration is a constant for the loop, the max=
imum
> allowed latency can be calculated outside of the loop.
>
> Patch 6 prevents using negative values from tick_nohz_get_sleep_lengt=
h()
> in the menu governor. If unchecked, the negative values are used as h=
uge
> unsigned values. Negative values occur fairly often (e.g. on x86_64 I=
've
> seen this happen several times per minute) on a busy system, allowing
> the deepest state to win the selection while the shallowest should be=
 picked.
>
> Patch 7 adds CPUIDLE_FLAG_TIME_VALID to poll_idle. I do not know of a=
ny
> platfrom where cpu_relax() would break ktime_get() and in fact poll_i=
dle
> uses ktime_get itself.
> (Note: poll_idle updates dev->last_residency for some reason. Does it=
 ever
> get called without going through cpuidle_enter_state, which will over=
write
> the value? Even if some state redirects to this state, the call will
> eventually return to the framework. The redundant time measurement co=
uld
> be removed, unless there is some obscure way of getting called on som=
e
> platform that I am unable to figure out.)
>
> Tuukka Tikkanen (7):
>    Cpuidle: rename expected_us to next_timer_us in menu governor
>    Cpuidle: Use actual state latency in menu governor
>    Cpuidle: Ensure menu coefficients stay within domain
>    Cpuidle: Do not substract exit latency from assumed sleep length
>    Cpuidle: Move perf multiplier calculation out of the selection loo=
p
>    Cpuidle: Deal with timer expiring in the past
>    Cpuidle: poll state can measure residency
>
>   drivers/cpuidle/driver.c         |    2 +-
>   drivers/cpuidle/governors/menu.c |   85 ++++++++++++++++++++++++---=
-----------
>   2 files changed, 54 insertions(+), 33 deletions(-)

You should put Arjan van de Ven in Cc for the menu governor changes.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

