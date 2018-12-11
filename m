From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v10 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Date: Tue, 11 Dec 2018 15:15:09 +0100
Message-ID: <20181211141509.GA32005@gmail.com>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-11-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181203095628.11858-11-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org


* Quentin Perret <quentin.perret@arm.com> wrote:

> In its current state, Energy Aware Scheduling (EAS) starts automatically
> on asymmetric platforms having an Energy Model (EM). However, there are
> users who want to have an EM (for thermal management for example), but
> don't want EAS with it.

Well, then introduce a new Kconfig variant for EAS, if it's super 
important to allow this to be disabled.

Why do we want to disable it - is it not reliable in some circumstances?

> In order to let users disable EAS explicitly, introduce a new sysctl
> called 'sched_energy_aware'. It is enabled by default so that EAS can
> start automatically on platforms where it makes sense. Flipping it to 0
> rebuilds the scheduling domains and disables EAS.

Yeah, making this a sysctl ABI is asking for trouble - this really should 
be a Kconfig or debug space knob, at most.

Thanks,

	Ingo
