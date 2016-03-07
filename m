From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Mon, 7 Mar 2016 14:42:10 +0100
Message-ID: <CAJZ5v0hjvQzy-LvnRf2ca6--ZyrKoxZy1Zp08iTx=D0iFHEW9A@mail.gmail.com>
References: <2409306.qzzMXcm4dm@vostro.rjw.lan>
	<15684081.T4iOMUSHCY@vostro.rjw.lan>
	<56DA09B1.4010005@linaro.org>
	<CAJZ5v0jENyu8j0fq1-BhU64QwRHAjvcjQktYc2sa9QmhktoEnQ@mail.gmail.com>
	<CAJZ5v0jd6sXQnvZ87=_L1MQgu2QsBJtYb8jwn=0=m7eRdKVvhA@mail.gmail.com>
	<CAJZ5v0jh7qcmYjDXCdO3Pid4XyuuxQfsKAmWDLXYcrkx0t-phw@mail.gmail.com>
	<20160305164900.GX6356@twins.programming.kicks-ass.net>
	<CAJZ5v0je8158B9jjbMU1MMPyduZXaao7sKhAniq4TPVfTb3JQA@mail.gmail.com>
	<20160307080059.GZ6356@twins.programming.kicks-ass.net>
	<CAJZ5v0jKXQrrpVmEd=CCek4KVWknJaoYSAmwc8rosKK=oDzkFw@mail.gmail.com>
	<20160307133203.GD6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35978 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbcCGNmN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2016 08:42:13 -0500
In-Reply-To: <20160307133203.GD6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Mar 7, 2016 at 2:32 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 07, 2016 at 02:15:47PM +0100, Rafael J. Wysocki wrote:
>> On Mon, Mar 7, 2016 at 9:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> > Sure I know all that. But that, to me, seems like an argument for why
>> > you should have done this a long time ago.
>>
>> While I generally agree with this, I don't quite see why cleaning that
>> up necessarily has to be connected to the current patch series which
>> is my point.
>
> Ah OK, fair enough I suppose. But someone should stick this on their
> TODO list, we should not 'forget' about this (again).

Sure.

>> > But I do think something wants to be done here.
>>
>> So here's what I can do for the "fast switch" thing.
>>
>> There is the fast_switch_possible policy flag that's necessary anyway.
>> I can make notifier registration fail when that is set for at least
>> one policy and I can make the setting of it fail if at least one
>> notifier has already been registered.
>>
>> However, without spending too much time on chasing code dependencies i
>> sort of suspect that it will uncover things that register cpufreq
>> notifiers early and it won't be possible to use fast switch without
>> sorting that out.
>
> The two x86 users don't register notifiers when CONSTANT_TSC, which
> seems to be the right thing.
>
> Much of the other users seem unlikely to be used on x86, so I suspect
> the initial fallout will be very limited.

OK, let me try this then.

> *groan* modules, cpufreq allows drivers to be modules, so init sequences
> are poorly defined at best :/ Yes that blows.

Yup.

>> And that won't even change anything apart from
>> removing some code that has not worked for quite a while already and
>> nobody noticed.
>
> Which is always a good thing, but yes, we can do this later.
>
>> It is doable for the "fast switch" thing, but it won't help in all of
>> the other cases when notifications are not reliable.
>
> Right, you can maybe add a 'NOTIFIERS_BROKEN' flag to the intel_p_state
> and HWP drivers or so, and trigger off of that.

Something like that, yes.
