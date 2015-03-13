From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC PATCH 2/2] arm64: kernel: perf: add pmu CPU PM notifier
Date: Fri, 13 Mar 2015 16:31:37 -0700
Message-ID: <7hd24cpj8m.fsf@deeprootsystems.com>
References: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1426008682-5680-2-git-send-email-lorenzo.pieralisi@arm.com>
	<7hh9try12u.fsf@deeprootsystems.com>
	<CAJ5Y-eZBS9Z0BgQK92MggttEZLitgKOYPyZqg3-7=RggYAJWvw@mail.gmail.com>
	<20150313174002.GA1763@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32827 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbCMXbm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 19:31:42 -0400
Received: by pagr17 with SMTP id r17so2275621pag.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 16:31:40 -0700 (PDT)
In-Reply-To: <20150313174002.GA1763@e102568-lin.cambridge.arm.com> (Lorenzo
	Pieralisi's message of "Fri, 13 Mar 2015 17:40:03 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Thu, Mar 12, 2015 at 01:18:54PM +0000, Ashwin Chaugule wrote:
>> On 11 March 2015 at 12:02, Kevin Hilman <khilman@kernel.org> wrote:
>> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>> >
>> >> When a CPU is being profiled through PMU events and it enters suspend
>> >> or idle states, the PMU registers content can be lost, which means that
>> >> counters that were relied upon on power down entry are reset on power
>> >> up to values that are incosistent with the profile session.
>> >>
>> >> This patch adds a CPU PM notifier to arm64 perf code, that detects
>> >> on entry if events are being monitored, and if so, it returns
>> >> failure to the CPU PM notification chain, causing the suspend
>> >> thread or the idle thread to abort power down, therefore preventing
>> >> registers content loss.
>> >>
>> >> By triggering CPU PM notification failure this patch prevents
>> >> suspending a system if the suspend thread is being profiled and
>> >> it also prevents entering idle deep states on cores that have profile
>> >> events in use, somehow limiting power management capabilities when
>> >> there are active perf sessions.
>> >
>> > I guess that's one choice.  Couldn't you also stop the PMU and
>> > save/restore it's context in the notifiers? so that you wouldn't affect
>> > PM capabilities?
>> >
>> > That would imply that you lose the ability to profile after a certain
>> > point in suspend/idle, but maybe that's a better trade off than having
>> > profiling disable certain PM features?
>> 
>> I had something like that a few years ago on the Kraits and Scorpions [1].
>
> That's another option, but the point is understanding how we want to
> tackle the issue, by preventing power down or by restoring the
> PMU registers.

Personally, I think the save/restore approach is preferred.  IMO, it's
more intuitive from the perspective of a user who doesn't understand all
the mechanics and also actually allows you to profile most of the
low-power paths and still actually hit the low power states.

> BTW, does your patch below need optimizing ? IIUC it "restores" the PMU
> counters even when that's not needed, I spotted some code in your tree
> that adds additional checks (ie check if returning from idle but I am not
> sure that's viable).

Such an optimization could also be done when we (someday) move this
cpu_pm notifier stuff to a proper pm_domain associated with the
CPU/cluster.

Kevin
