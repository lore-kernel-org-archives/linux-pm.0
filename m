From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT] [PATCH 03/10] cpufreq: intel_pstate: Utility functions
 to boost HWP performance limits
Date: Wed, 16 May 2018 12:43:13 +0200
Message-ID: <20180516104313.GC12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-4-srinivas.pandruvada@linux.intel.com>
 <20180516072202.GV12217@hirez.programming.kicks-ass.net>
 <CAJZ5v0iaRFO5GWRZAHVWWVMmF8FQps1CowpE5r6zj_tFO7W+jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iaRFO5GWRZAHVWWVMmF8FQps1CowpE5r6zj_tFO7W+jg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mel Gorman <mgorman@techsingularity.net>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 16, 2018 at 11:15:09AM +0200, Rafael J. Wysocki wrote:

> So if the "cached" thing is the last "not boosted EPP", that's why it
> is not updated here.

Sure, I see what it does, just saying that naming and comments are wrong
vs the actual code.
