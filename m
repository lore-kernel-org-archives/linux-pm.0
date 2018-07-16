From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Date: Mon, 16 Jul 2018 11:29:17 +0100
Message-ID: <20180716102917.GA19311@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <4341d199-8018-21e1-c2ce-9af8f7719297@arm.com>
 <20180710083202.GD17598@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180710083202.GD17598@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 10 Jul 2018 at 09:32:02 (+0100), Quentin Perret wrote:
> Indeed, having 'capacity' values in the EM framework is just an
> optimization for the scheduler, so that it doesn't need to compute them
> in the wake-up path. I could get rid of the whole
> em_rescale_cpu_capacity() mess (and by the same occasion the RCU
> protection of the tables ...) if I removed the 'capacity' values from
> the EM.

Another thing to take into consideration here is basically that the
thermal subsystem (IPA) will be impacted by the RCU protection on the
cs_table. However, since the 'frequency' and 'power' fields do not change
at run-time, and since IPA doesn't need the 'capacity' value, there is no
good reason to have IPA do rcu_read_lock() all over the place, so
arguably something needs to be fixed here.

One possibility is to remove entirely the following struct:
	struct em_cap_state {
		unsigned long capacity;
		unsigned long frequency; /* Kilo-hertz */
		unsigned long power; /* Milli-watts */
	};

and to have three independent vectors (of the same size) for frequency,
power and capacity. That way only the 'capacity' vector would be RCU
protected, and IPA could use 'frequency' and 'power' directly, without
further protections.

A second possibility is to remove the capacity values from the EM
altogether (as I suggested in my previous message) and to get rid of the
need for RCU protection at the same occasion.

The second option simplifies the code of the EM framework significantly
(no more em_rescale_cpu_capacity()) and shouldn't introduce massive
overheads on the scheduler side (the energy calculation already
requires one multiplication and one division, so nothing new on that
side). At the same time, that would make it a whole lot easier to
interface the EM framework with IPA without having to deal with RCU all
over the place.

So, if there are no objections, I'll try to explore that possibility for
v5.

I hope that makes sense

Thanks,
Quentin
