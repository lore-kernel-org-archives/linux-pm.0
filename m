From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v10 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Date: Tue, 11 Dec 2018 14:49:01 +0000
Message-ID: <20181211144901.hio4b6aw3esw3cgw@queper01-lin>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-11-quentin.perret@arm.com>
 <20181211141509.GA32005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211141509.GA32005@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

Hi Ingo,

On Tuesday 11 Dec 2018 at 15:15:09 (+0100), Ingo Molnar wrote:
> 
> * Quentin Perret <quentin.perret@arm.com> wrote:
> 
> > In its current state, Energy Aware Scheduling (EAS) starts automatically
> > on asymmetric platforms having an Energy Model (EM). However, there are
> > users who want to have an EM (for thermal management for example), but
> > don't want EAS with it.
> 
> Well, then introduce a new Kconfig variant for EAS, if it's super 
> important to allow this to be disabled.
> 
> Why do we want to disable it - is it not reliable in some circumstances?

There are people out there using big.little systems who do not care
about energy. Not very many of them, that is true, but they exist. And
those people can be interested in having an Energy Model for
IPA/thermal but also want to spread tasks to minimize latency for
example. So those guys will appreciate a knob, I think. Otherwise EAS
gets enabled/disabled only by side effects (by enabling/disabling
schedutil for example).

> > In order to let users disable EAS explicitly, introduce a new sysctl
> > called 'sched_energy_aware'. It is enabled by default so that EAS can
> > start automatically on platforms where it makes sense. Flipping it to 0
> > rebuilds the scheduling domains and disables EAS.
> 
> Yeah, making this a sysctl ABI is asking for trouble - this really should 
> be a Kconfig or debug space knob, at most.

My original proposal was a sched_feat, but Peter didn't like it because,
well, it's a debug knob :-). I'm personally not against a Kconfig, I
just had the feeling scheduler-specific Kconfig weren't welcome in
general. But if you feel like EAS could be a reasonable exception to the
rule, I won't argue. Otherwise, Juri suggested to have a command line
option at some point. Would that be a better solution ?

Also, when you say we're asking for trouble, what are you referring to
exactly ? There are a couple of existing sysctl to enable/disable
scheduler features.

Thanks,
Quentin
