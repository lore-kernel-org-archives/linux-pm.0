From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/10] cpufreq: Reduce cpufreq_update_util() overhead a
 bit
Date: Wed, 9 Mar 2016 16:29:34 +0100
Message-ID: <20160309152934.GO6356@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan>
 <1988425.XTpZIAJINa@vostro.rjw.lan>
 <20160309123956.GM6356@twins.programming.kicks-ass.net>
 <CAJZ5v0gt3tmJ1ZunvkLKfeUSgZv7yiO9vBDtDmXSuC=tUUpPLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gt3tmJ1ZunvkLKfeUSgZv7yiO9vBDtDmXSuC=tUUpPLg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 09, 2016 at 03:17:48PM +0100, Rafael J. Wysocki wrote:
> > That said, how about the below? It avoids a function call.
> 
> That is fine by me.
> 
> What about taking it a bit further, though, and moving the definition
> of cpufreq_update_util_data to somewhere under kernel/sched/ (like
> kernel/sched/cpufreq.c maybe)?
> 
> Then, the whole static inline void cpufreq_update_util() definition
> can go into kernel/sched/sched.h (it doesn't have to be visible
> anywhere beyond kernel/sched/) and the only thing that needs to be
> exported to cpufreq will be a helper (or two), to set/clear the
> cpufreq_update_util_data pointers.
> 
> I'll try to cut a patch doing that later today for illustration.

Right, that's a blend with your second patch. Sure.
