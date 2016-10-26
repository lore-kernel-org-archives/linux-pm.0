From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 1/9] sched: Extend scheduler's asym packing
Date: Wed, 26 Oct 2016 12:27:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610261226540.4983@nanos>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com> <c3bf1c59ee56dad1dc20ad3b3c06c166abb7a57e.1477000078.git.tim.c.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <c3bf1c59ee56dad1dc20ad3b3c06c166abb7a57e.1477000078.git.tim.c.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Oct 2016, Tim Chen wrote:

> We generalize the scheduler's asym packing to provide an ordering
> of the cpu beyond just the cpu number.  This allows the use of the
> ASYM_PACKING scheduler machinery to move loads to preferred CPU in a
> sched domain. The preference is defined with the cpu priority
> given by arch_asym_cpu_priority(cpu).
> 
> We also record the most preferred cpu in a sched group when
> we build the cpu's capacity for fast lookup of preferred cpu
> during load balancing.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This SOB-chain is bogus. Same for all other patches.

Thanks,

	tglx
