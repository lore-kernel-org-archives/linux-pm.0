From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 03/11] sched: Extend scheduler's asym packing
Date: Thu, 25 Aug 2016 15:45:03 +0200
Message-ID: <20160825134503.GH10138@twins.programming.kicks-ass.net>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-4-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160825112251.GA1323@e105550-lin.cambridge.arm.com>
 <20160825114522.GD10138@twins.programming.kicks-ass.net>
 <20160825131836.GB1323@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160825131836.GB1323@e105550-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 25, 2016 at 02:18:37PM +0100, Morten Rasmussen wrote:

> But why not just pass the customized list into the scheduler? Seems
> simpler?

Mostly because I didn't want to regress Power I suppose. The ITMT stuff
needs an extra load, whereas the Power stuff can use the CPU number we
already have.

Also, since we need an interface to pass in this custom list, I don't
see the distinction, you can do the same manipulation by constantly
updating the prio list.

But not of this stuff should be EXPORT'ed, so its only available to the
core kernel, which greatly limits the potential for abuse. We can see
arch code just fine.

And if you spin a custom kernel, you can already wreck the load
balancer.
