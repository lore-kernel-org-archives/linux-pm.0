From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 2/2] arm64: kernel: perf: add pmu CPU PM notifier
Date: Fri, 13 Mar 2015 17:40:03 +0000
Message-ID: <20150313174002.GA1763@e102568-lin.cambridge.arm.com>
References: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1426008682-5680-2-git-send-email-lorenzo.pieralisi@arm.com>
 <7hh9try12u.fsf@deeprootsystems.com>
 <CAJ5Y-eZBS9Z0BgQK92MggttEZLitgKOYPyZqg3-7=RggYAJWvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52593 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932196AbbCMRkM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 13 Mar 2015 13:40:12 -0400
Content-Disposition: inline
In-Reply-To: <CAJ5Y-eZBS9Z0BgQK92MggttEZLitgKOYPyZqg3-7=RggYAJWvw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>

On Thu, Mar 12, 2015 at 01:18:54PM +0000, Ashwin Chaugule wrote:
> On 11 March 2015 at 12:02, Kevin Hilman <khilman@kernel.org> wrote:
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> >
> >> When a CPU is being profiled through PMU events and it enters suspend
> >> or idle states, the PMU registers content can be lost, which means that
> >> counters that were relied upon on power down entry are reset on power
> >> up to values that are incosistent with the profile session.
> >>
> >> This patch adds a CPU PM notifier to arm64 perf code, that detects
> >> on entry if events are being monitored, and if so, it returns
> >> failure to the CPU PM notification chain, causing the suspend
> >> thread or the idle thread to abort power down, therefore preventing
> >> registers content loss.
> >>
> >> By triggering CPU PM notification failure this patch prevents
> >> suspending a system if the suspend thread is being profiled and
> >> it also prevents entering idle deep states on cores that have profile
> >> events in use, somehow limiting power management capabilities when
> >> there are active perf sessions.
> >
> > I guess that's one choice.  Couldn't you also stop the PMU and
> > save/restore it's context in the notifiers? so that you wouldn't affect
> > PM capabilities?
> >
> > That would imply that you lose the ability to profile after a certain
> > point in suspend/idle, but maybe that's a better trade off than having
> > profiling disable certain PM features?
> 
> I had something like that a few years ago on the Kraits and Scorpions [1].

That's another option, but the point is understanding how we want to
tackle the issue, by preventing power down or by restoring the
PMU registers.

BTW, does your patch below need optimizing ? IIUC it "restores" the PMU
counters even when that's not needed, I spotted some code in your tree
that adds additional checks (ie check if returning from idle but I am not
sure that's viable).

All in all going to deep idle must emulate a perf context switch through power
down, I am pretty sured Dave implemented something like that, I will
chase the code and then we will see what's the best option.

Lorenzo

> [1] https://www.codeaurora.org/cgit/quic/la/kernel/msm/commit/arch/arm/kernel?h=msm-3.4&id=b5ca687960f0fea2f4735e83ca5c9543474c19de
> 
> Cheers,
> Ashwin.
> 
