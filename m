From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 5/8] sched,x86: Enable Turbo Boost Max Technology
Date: Thu, 08 Sep 2016 11:41:09 -0700
Message-ID: <1473360069.154359.64.camel@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1472762024-88771-6-git-send-email-srinivas.pandruvada@linux.intel.com>
         <20160908075955.GS10153@twins.programming.kicks-ass.net>
         <20160908180928.GB23509@linux.intel.com>
         <20160908182215.GA10153@twins.programming.kicks-ass.net>
         <1473359328.154359.61.camel@linux.intel.com>
         <20160908183318.GB10153@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160908183318.GB10153@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-09-08 at 20:33 +0200, Peter Zijlstra wrote:
> On Thu, Sep 08, 2016 at 11:28:48AM -0700, Srinivas Pandruvada wrote:
> 
> > 
> > Do we need to send v3 to include these changes?
> 
> Might as well I suppose. Then we need to figure out who is going to
> merge what where ;-)
Preferably from Rafael's PM tree as this depends on some CPPC changes
which are in his tree.

Thanks,
Srinivas

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
