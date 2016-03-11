From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Sat, 12 Mar 2016 00:54:46 +0100
Message-ID: <CAJZ5v0jkH0qQOsGDQTY7RQ_ftFiMMNSw2P8rrE99UB2YrDx4MA@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<87si087tsr.fsf@iki.fi>
	<CAJvTdKmg=H2hqFd+fwu0t8Rx4PV8E3vNGc-j8zzVKLFX4nprYg@mail.gmail.com>
	<87a8m74mcc.fsf@iki.fi>
	<002d01d17a57$ec417030$c4c45090$@net>
	<CAJZ5v0i0cx_xYUwFWDX5nE+rNgbX4TY0ATYuD3rEi86Ky5cA5A@mail.gmail.com>
	<003701d17a5d$cab287a0$601796e0$@net>
	<CAJZ5v0gaO3vB7Bz+URiwdXx2jypqPSJ3Pc_aJ5VGgh4wJyB9Kg@mail.gmail.com>
	<20160311090306.1bfe380b@annuminas.surriel.com>
	<002401d17bc2$fad32af0$f07980d0$@net>
	<20160311153044.1a3be1c6@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33474 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbcCKXys (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Mar 2016 18:54:48 -0500
Received: by mail-lb0-f169.google.com with SMTP id k15so177145786lbg.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Mar 2016 15:54:47 -0800 (PST)
In-Reply-To: <20160311153044.1a3be1c6@annuminas.surriel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Fri, Mar 11, 2016 at 9:30 PM, Rik van Riel <riel@redhat.com> wrote:
> On Fri, 11 Mar 2016 10:22:30 -0800
> "Doug Smythies" <dsmythies@telus.net> wrote:
>
>> On 2016.03.11 06:03 Rik van Riel wrote:
>> > On Thu, 10 Mar 2016 00:59:01 +0100 "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
>> > The patch below should fix that.
>> >
>> > It didn't for Arto, due to the other issues on his system, but
>> > it might resolve the issue for Doug, where cstate/pstate is
>> > otherwise working fine.
>> >
>> > Doug, does the patch below solve your issue?
>>
>> No.
>
> OK, lets try doing this check a little more aggressively, since there
> almost certainly are good reasons why the main selection loop in
> menu_select() so aggressively tries to stay with shallower C states.
>
> With the patch below, we compare the (not corrected for load) expected
> sleep time against the target residency of the C1 (hlt) state on the CPU.
>
> This might resolve the issue, while still doing the right thing on CPUs
> that have really high C1 latencies (eg. Atom).
>
> Does this resolve the issue for you?
>
> ---8<---
>
> Subject: cpuidle: use predicted_us not interactivity_req to consider polling
>
> The interactivity_req variable is the expected sleep time, divided
> by the CPU load. This can be too aggressive a factor in deciding
> whether or not to consider polling in the cpuidle state selection.
>
> Use the (not corrected for load) predicted_us instead, and compare
> it against the target residency of C1 (hlt).
>
> Signed-off-by: Rik van Riel <riel@redhat.com>
> ---
>  drivers/cpuidle/governors/menu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 0742b3296673..7dda15cfe547 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -330,7 +330,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>                  * We want to default to C1 (hlt), not to busy polling
>                  * unless the timer is happening really really soon.
>                  */
> -               if (interactivity_req > 20 &&
> +               if (data->predicted_us > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency &&

If we do this, we probably should check the exit latency (against
latency_req) too.

>                     !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
>                         dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
>                         data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
>
