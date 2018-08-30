From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present
 static key
Date: Thu, 30 Aug 2018 10:57:45 +0100
Message-ID: <20180830095723.4qqbpft7gpbtgkhd@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-8-quentin.perret@arm.com>
 <20180829165058.GR2960@e110439-lin>
 <20180829172004.afbe2oukprvptqs2@queper01-lin>
 <20180830092329.GS2960@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180830092329.GS2960@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On Thursday 30 Aug 2018 at 10:23:29 (+0100), Patrick Bellasi wrote:
> Yes, dunno if it's just me but perhaps a bit of rephrasing could help.

Ok, so what about something a little bit more explicit like:

/*
 * The complexity of the Energy Model is defined as:
 *
 *		C = nr_pd * (nr_cpus + nr_cs)
 *
 * with parameters defined as:
 *  - nr_pd:	the number of performance domains
 *  - nr_cpus:	the number of CPUs
 *  - nr_cs:	the sum of the number of capacity states of all performance
 *		domains (for example, on a system with 2 performance domains,
 *		with 10 capacity states each, nr_cs = 2 * 10 = 20).
 *
 * It is generally not a good idea to use such a model in the wake-up path on
 * very complex platforms because of the associated scheduling overheads. The
 * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
 * with per-CPU DVFS and less than 8 capacity states each, for example.
 */

> Alternatively, why not having this comment and check after patches
> 11 and 12 ?

Oh, you don't like it here ? What's wrong with it :-) ?

> Right... I was totally confused by the idea that we don't
> run EAS if we just have 1 CPU per PD... my bad!
> 
> Although on those systems, since we don't have idle costs, should not
> be a spreading strategy always the best from an energy efficiency
> standpoint ?

Even with per-CPU DVFS, if you have big and little CPUs it matters
_where_ you execute a task, and you'll still need an Energy Model to
make good decisions in a generic way. But yes, there is definitely some
room for improvement for those platforms. That's something we could
improve later on top of this series I suppose.

Thanks for looking at the patches !
Quentin
