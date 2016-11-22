From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v7 1/8] sched: Extend scheduler's asym packing
Date: Tue, 22 Nov 2016 12:21:19 -0800
Message-ID: <1479846079.3064.16.camel@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
         <0c494b134a93e89ebf48e45719a6b864d4ac96b7.1478805832.git.tim.c.chen@linux.intel.com>
         <20161122100959.GC3124@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122100959.GC3124@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2016-11-22 at 11:09 +0100, Peter Zijlstra wrote:
> 
> 
> Not a big fan of that part.. would not something like the below cure
> that?
> 
> It would be slightly less optimal for Power7 but would actually be
> faster (on average) for the ITMT case, but most importantly, it does
> away with that extra weak function.

Okay. I have made this change to get rid off the extra weak function.
However, two patches are affected.  So I think it is cleaner to refresh
the whole patch set.  I'll send out the refreshed v8 patch set separately.

Thanks.

Tim
