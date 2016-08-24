From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 04/11] sched,x86: Enable Turbo Boost Max Technology
Date: Wed, 24 Aug 2016 20:22:55 +0200
Message-ID: <20160824182255.GC10153@twins.programming.kicks-ass.net>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-5-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160824101853.GA25705@gmail.com>
 <20160824175057.GA5032@linux.intel.com>
 <20160824180854.GA1398@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160824180854.GA1398@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 24, 2016 at 08:08:54PM +0200, Ingo Molnar wrote:
> > 
> > So if we take the approach to enable this feature by default for only
> > single node system (using that as a criteria for client), will that seem
> > reasonable to you?
> 
> I suppose that would work. Peter, any objections to such an approach?

Works for me.

Thanks!
