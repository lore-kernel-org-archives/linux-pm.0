From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 2/2] arm64: kernel: perf: add pmu CPU PM notifier
Date: Thu, 12 Mar 2015 10:27:33 +0000
Message-ID: <20150312102733.GC18414@red-moon>
References: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1426008682-5680-2-git-send-email-lorenzo.pieralisi@arm.com>
 <7hh9try12u.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48314 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbbCLK1f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 Mar 2015 06:27:35 -0400
Content-Disposition: inline
In-Reply-To: <7hh9try12u.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, dave.martin@arm.com

[Cc'ing Dave]

On Wed, Mar 11, 2015 at 04:02:17PM +0000, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > When a CPU is being profiled through PMU events and it enters suspend
> > or idle states, the PMU registers content can be lost, which means that
> > counters that were relied upon on power down entry are reset on power
> > up to values that are incosistent with the profile session.
> >
> > This patch adds a CPU PM notifier to arm64 perf code, that detects
> > on entry if events are being monitored, and if so, it returns
> > failure to the CPU PM notification chain, causing the suspend
> > thread or the idle thread to abort power down, therefore preventing
> > registers content loss.
> >
> > By triggering CPU PM notification failure this patch prevents
> > suspending a system if the suspend thread is being profiled and
> > it also prevents entering idle deep states on cores that have profile
> > events in use, somehow limiting power management capabilities when
> > there are active perf sessions.
> 
> I guess that's one choice.  Couldn't you also stop the PMU and
> save/restore it's context in the notifiers? so that you wouldn't affect
> PM capabilities?

Yes, that's why I sent this an RFC. This solution can also be easily
ported to power domains, when we put them in place.

To save/restore PMU counters we can either reuse perf core (IIRC Dave
had a stab at this, it is not a trivial patch) or do arch specific
save/restore (with related buffers for registers context) but I think
Will does not like the idea at all (and he has a point since the context
memory is already there in perf core).

> That would imply that you lose the ability to profile after a certain
> point in suspend/idle, but maybe that's a better trade off than having
> profiling disable certain PM features?

I am ok either way, as long as we make a decision, it has been hanging
in the balance for aeons.

Thanks,
Lorenzo
