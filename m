From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC PATCH 2/2] arm64: kernel: perf: add pmu CPU PM notifier
Date: Tue, 31 Mar 2015 09:35:47 -0700
Message-ID: <7h1tk5azvg.fsf@deeprootsystems.com>
References: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1426008682-5680-2-git-send-email-lorenzo.pieralisi@arm.com>
	<7hh9try12u.fsf@deeprootsystems.com>
	<CAJ5Y-eZBS9Z0BgQK92MggttEZLitgKOYPyZqg3-7=RggYAJWvw@mail.gmail.com>
	<20150313174002.GA1763@e102568-lin.cambridge.arm.com>
	<7hd24cpj8m.fsf@deeprootsystems.com> <20150317172418.GX8399@arm.com>
	<20150330174540.GB11684@red-moon>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35532 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbbCaQfu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 12:35:50 -0400
Received: by pddn5 with SMTP id n5so25842664pdd.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2015 09:35:50 -0700 (PDT)
In-Reply-To: <20150330174540.GB11684@red-moon> (Lorenzo Pieralisi's message of
	"Mon, 30 Mar 2015 18:45:40 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Tue, Mar 17, 2015 at 05:24:18PM +0000, Will Deacon wrote:
>> On Fri, Mar 13, 2015 at 11:31:37PM +0000, Kevin Hilman wrote:
>> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>> > 
>> > > On Thu, Mar 12, 2015 at 01:18:54PM +0000, Ashwin Chaugule wrote:
>> > >> On 11 March 2015 at 12:02, Kevin Hilman <khilman@kernel.org> wrote:
>> > >> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>> > >> >
>> > >> >> When a CPU is being profiled through PMU events and it enters suspend
>> > >> >> or idle states, the PMU registers content can be lost, which means that
>> > >> >> counters that were relied upon on power down entry are reset on power
>> > >> >> up to values that are incosistent with the profile session.
>> > >> >>
>> > >> >> This patch adds a CPU PM notifier to arm64 perf code, that detects
>> > >> >> on entry if events are being monitored, and if so, it returns
>> > >> >> failure to the CPU PM notification chain, causing the suspend
>> > >> >> thread or the idle thread to abort power down, therefore preventing
>> > >> >> registers content loss.
>> > >> >>
>> > >> >> By triggering CPU PM notification failure this patch prevents
>> > >> >> suspending a system if the suspend thread is being profiled and
>> > >> >> it also prevents entering idle deep states on cores that have profile
>> > >> >> events in use, somehow limiting power management capabilities when
>> > >> >> there are active perf sessions.
>> > >> >
>> > >> > I guess that's one choice.  Couldn't you also stop the PMU and
>> > >> > save/restore it's context in the notifiers? so that you wouldn't affect
>> > >> > PM capabilities?
>> > >> >
>> > >> > That would imply that you lose the ability to profile after a certain
>> > >> > point in suspend/idle, but maybe that's a better trade off than having
>> > >> > profiling disable certain PM features?
>> > >> 
>> > >> I had something like that a few years ago on the Kraits and Scorpions [1].
>> > >
>> > > That's another option, but the point is understanding how we want to
>> > > tackle the issue, by preventing power down or by restoring the
>> > > PMU registers.
>> > 
>> > Personally, I think the save/restore approach is preferred.  IMO, it's
>> > more intuitive from the perspective of a user who doesn't understand all
>> > the mechanics and also actually allows you to profile most of the
>> > low-power paths and still actually hit the low power states.
>> 
>> I agree that save/restore is the nicest thing to do, but until we have a
>> generic description of the power-domains in device-tree I really don't want
>> PMU-specific hacks in the arch code to deal with this (since many platforms
>> do not lose PMU state over suspend).
>> 
>> What Lorenzo is proposing is a stop-gap to prevent perf silently losing its
>> state on platforms where the register contents is lost.
>
> Yes, that's exactly the goal. I am fine either way, at the moment we are
> not in a position to define whether a core loses the PMU context, that's
> certain.
>
> I am not sure to understand why people want the core to really go
> to shutdown and save/restore perf context if perf is on (eg profiling a
> cpu for cache stats, clearly powering down a core biases the results
> and might even obfuscate them).

The main thing I was considering is when using perf to profile the
low-power paths (suspend or idle.)

> It is not an easy call. If we go for this patch approach I am happy to
> rebase and retest the series again, for power domains I fear we have to
> wait given the sheer amount of changes in ARM CPUidle world at the moment,
> too much stuff going on there.

Ultimately, I'm OK with the proposed solution as a short/medium term
solution.  When our PM domain and CPUidle integration story gets a
little better, we can revisit this.

Kevin

