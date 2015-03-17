From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 2/2] arm64: kernel: perf: add pmu CPU PM notifier
Date: Tue, 17 Mar 2015 17:24:18 +0000
Message-ID: <20150317172418.GX8399@arm.com>
References: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1426008682-5680-2-git-send-email-lorenzo.pieralisi@arm.com>
 <7hh9try12u.fsf@deeprootsystems.com>
 <CAJ5Y-eZBS9Z0BgQK92MggttEZLitgKOYPyZqg3-7=RggYAJWvw@mail.gmail.com>
 <20150313174002.GA1763@e102568-lin.cambridge.arm.com>
 <7hd24cpj8m.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59701 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbbCQRYW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Mar 2015 13:24:22 -0400
Content-Disposition: inline
In-Reply-To: <7hd24cpj8m.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>

On Fri, Mar 13, 2015 at 11:31:37PM +0000, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > On Thu, Mar 12, 2015 at 01:18:54PM +0000, Ashwin Chaugule wrote:
> >> On 11 March 2015 at 12:02, Kevin Hilman <khilman@kernel.org> wrote:
> >> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> >> >
> >> >> When a CPU is being profiled through PMU events and it enters suspend
> >> >> or idle states, the PMU registers content can be lost, which means that
> >> >> counters that were relied upon on power down entry are reset on power
> >> >> up to values that are incosistent with the profile session.
> >> >>
> >> >> This patch adds a CPU PM notifier to arm64 perf code, that detects
> >> >> on entry if events are being monitored, and if so, it returns
> >> >> failure to the CPU PM notification chain, causing the suspend
> >> >> thread or the idle thread to abort power down, therefore preventing
> >> >> registers content loss.
> >> >>
> >> >> By triggering CPU PM notification failure this patch prevents
> >> >> suspending a system if the suspend thread is being profiled and
> >> >> it also prevents entering idle deep states on cores that have profile
> >> >> events in use, somehow limiting power management capabilities when
> >> >> there are active perf sessions.
> >> >
> >> > I guess that's one choice.  Couldn't you also stop the PMU and
> >> > save/restore it's context in the notifiers? so that you wouldn't affect
> >> > PM capabilities?
> >> >
> >> > That would imply that you lose the ability to profile after a certain
> >> > point in suspend/idle, but maybe that's a better trade off than having
> >> > profiling disable certain PM features?
> >> 
> >> I had something like that a few years ago on the Kraits and Scorpions [1].
> >
> > That's another option, but the point is understanding how we want to
> > tackle the issue, by preventing power down or by restoring the
> > PMU registers.
> 
> Personally, I think the save/restore approach is preferred.  IMO, it's
> more intuitive from the perspective of a user who doesn't understand all
> the mechanics and also actually allows you to profile most of the
> low-power paths and still actually hit the low power states.

I agree that save/restore is the nicest thing to do, but until we have a
generic description of the power-domains in device-tree I really don't want
PMU-specific hacks in the arch code to deal with this (since many platforms
do not lose PMU state over suspend).

What Lorenzo is proposing is a stop-gap to prevent perf silently losing its
state on platforms where the register contents is lost.

Will
