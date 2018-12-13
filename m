From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Date: Thu, 13 Dec 2018 15:03:58 +0100
Message-ID: <20181213140358.GJ5289@hirez.programming.kicks-ass.net>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-11-quentin.perret@arm.com>
 <20181211141509.GA32005@gmail.com>
 <20181211144901.hio4b6aw3esw3cgw@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211144901.hio4b6aw3esw3cgw@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 11, 2018 at 02:49:01PM +0000, Quentin Perret wrote:
> Hi Ingo,
> 
> On Tuesday 11 Dec 2018 at 15:15:09 (+0100), Ingo Molnar wrote:
> > 
> > * Quentin Perret <quentin.perret@arm.com> wrote:
> > 
> > > In its current state, Energy Aware Scheduling (EAS) starts automatically
> > > on asymmetric platforms having an Energy Model (EM). However, there are
> > > users who want to have an EM (for thermal management for example), but
> > > don't want EAS with it.
> > 
> > Well, then introduce a new Kconfig variant for EAS, if it's super 
> > important to allow this to be disabled.
> > 
> > Why do we want to disable it - is it not reliable in some circumstances?
> 
> There are people out there using big.little systems who do not care
> about energy. Not very many of them, that is true, but they exist. And
> those people can be interested in having an Energy Model for
> IPA/thermal but also want to spread tasks to minimize latency for
> example. So those guys will appreciate a knob, I think. Otherwise EAS
> gets enabled/disabled only by side effects (by enabling/disabling
> schedutil for example).

Right, also we have a sysctl for numa-balancing, I figured having one
for eas would not be weird.
