From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 03/11] sched: Extend scheduler's asym packing
Date: Thu, 25 Aug 2016 13:45:22 +0200
Message-ID: <20160825114522.GD10138@twins.programming.kicks-ass.net>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-4-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160825112251.GA1323@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160825112251.GA1323@e105550-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 25, 2016 at 12:22:52PM +0100, Morten Rasmussen wrote:
> I haven't reviewed the entire patch set in detail, but why can't the cpu
> priority list be handed to the scheduler instead of moving scheduling
> decisions out of the scheduler?

It basically does that. All that we allow here is the architecture to
override the default order of what is considered priority.

The default (as per Power7) is naked cpu number, with lower cpu numbers
having higher priority to higher numbers.

This patch set allows the architecture to provide a less_than operator
(and through that a custom order).
