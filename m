From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: governor: Fix race in dbs_update_util_handler()
Date: Mon, 22 Feb 2016 14:30:04 +0100
Message-ID: <CAJZ5v0gJ3oZtH2Qf=p4iLZhg+5T1Frvk57p0e9GMz7rON2sO6g@mail.gmail.com>
References: <2410542.x6e5Rli2VY@vostro.rjw.lan>
	<2648721.JQxjFin8bu@vostro.rjw.lan>
	<20160222052336.GB28226@vireshk-i7>
	<CAJZ5v0jNBWYhuFud7-P1J2cc0e7Ex2F+YYE5J_qq2bEweLe8jQ@mail.gmail.com>
	<20160222130407.GP28226@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36737 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbcBVNaH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 08:30:07 -0500
In-Reply-To: <20160222130407.GP28226@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Feb 22, 2016 at 2:04 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-02-16, 13:26, Rafael J. Wysocki wrote:
>> On Mon, Feb 22, 2016 at 6:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 21-02-16, 03:14, Rafael J. Wysocki wrote:
>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[cut]

>> > I think we should be doing this here:
>> >
>> >         delta_ns = time - ACCESS_ONCE(policy_dbs->last_sample_time);
>> >         if ((s64)delta_ns < policy_dbs->sample_delay_ns) {
>> >                 atomic_set(&policy_dbs->work_count, 0);
>> >                 return;
>> >         }
>> >
>> > There is no point running the routine again, we already have ->work_count
>> > incremented for us, lets do the check right now.
>>
>> No, we need to check work_in_progress too.
>
> Then maybe move first half of this routine into a separate function
> and call it from the beginning and here ?

That won't help.   The time value is still going to be stale.

Thanks,
Rafael
