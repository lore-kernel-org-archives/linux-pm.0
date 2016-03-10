From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/10] cpufreq: Reduce cpufreq_update_util() overhead a
 bit
Date: Thu, 10 Mar 2016 10:19:01 +0100
Message-ID: <20160310091901.GS6344@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <CAJZ5v0gt3tmJ1ZunvkLKfeUSgZv7yiO9vBDtDmXSuC=tUUpPLg@mail.gmail.com>
 <20160309152934.GO6356@twins.programming.kicks-ass.net>
 <5173878.LnSyxxsz2i@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57013 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965556AbcCJJTF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 04:19:05 -0500
Content-Disposition: inline
In-Reply-To: <5173878.LnSyxxsz2i@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Mar 09, 2016 at 10:35:02PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: Move scheduler-related code to the sched directory
> 
> Create cpufreq.c under kernel/sched/ and move the cpufreq code
> related to the scheduler to that file and to sched.h.
> 
> Redefine cpufreq_update_util() as a static inline function to avoid
> function calls at its call sites in the scheduler code (as suggested
> by Peter Zijlstra).
> 
> Also move the definition of struct update_util_data and declaration
> of cpufreq_set_update_util_data() from include/linux/cpufreq.h to
> include/linux/sched.h.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c          |   53 -------------------------------------
>  drivers/cpufreq/cpufreq_governor.c |    1 
>  include/linux/cpufreq.h            |   34 -----------------------
>  include/linux/sched.h              |    9 ++++++
>  kernel/sched/Makefile              |    1 
>  kernel/sched/cpufreq.c             |   37 +++++++++++++++++++++++++
>  kernel/sched/sched.h               |   49 +++++++++++++++++++++++++++++++++-
>  7 files changed, 96 insertions(+), 88 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
