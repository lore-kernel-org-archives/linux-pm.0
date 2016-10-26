From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v6 1/9] sched: Extend scheduler's asym packing
Date: Wed, 26 Oct 2016 11:10:46 -0700
Message-ID: <1477505446.2680.29.camel@linux.intel.com>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>
         <c3bf1c59ee56dad1dc20ad3b3c06c166abb7a57e.1477000078.git.tim.c.chen@linux.intel.com>
         <alpine.DEB.2.20.1610261226540.4983@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:8893 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757156AbcJZSLB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Oct 2016 14:11:01 -0400
In-Reply-To: <alpine.DEB.2.20.1610261226540.4983@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Wed, 2016-10-26 at 12:27 +0200, Thomas Gleixner wrote:
> On Thu, 20 Oct 2016, Tim Chen wrote:
> 
> > 
> > We generalize the scheduler's asym packing to provide an ordering
> > of the cpu beyond just the cpu number.  This allows the use of the
> > ASYM_PACKING scheduler machinery to move loads to preferred CPU in a
> > sched domain. The preference is defined with the cpu priority
> > given by arch_asym_cpu_priority(cpu).
> > 
> > We also record the most preferred cpu in a sched group when
> > we build the cpu's capacity for fast lookup of preferred cpu
> > during load balancing.
> > 
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> This SOB-chain is bogus. Same for all other patches.
> 

I am the primary author of the patch so I have my sign-off on top.  There
were also much internal discussions/reviews between myself, Peter and Srinivas,
before we post the first version of this patch.
I incorporated their inputs into the patch and added their sign-offs.  

Can you be more explicit on why you think the sign-offs here are bogus?

Thanks.

Tim

  
