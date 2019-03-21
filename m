From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Date: Thu, 21 Mar 2019 08:58:07 +0100
Message-ID: <20190321075807.GK6058@hirez.programming.kicks-ass.net>
References: <2816566.rddYshD6lm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2816566.rddYshD6lm@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 21, 2019 at 01:00:52AM +0100, Rafael J. Wysocki wrote:
> + * The Performance and Energy Bias Hint (EPB) allows software to specify its
> + * preference with respect to the power-performance tradeoffs present in the
> + * processor.  Generally, the EPB is expected to be set by user space through
> + * the generic MSR interface (with the help of the x86_energy_perf_policy tool),
> + * but there are two reasons for the kernel to touch it.

So I hate /dev/msr with a passion. It is absolute atrocious crap.

Please, just make a real interface for this if it is important.
