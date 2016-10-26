From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v6 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Wed, 26 Oct 2016 10:23:32 -0700
Message-ID: <1477502612.2680.9.camel@linux.intel.com>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>
         <b3f648c2c4cd36b6a043239bee8437a2060c0ac4.1477000078.git.tim.c.chen@linux.intel.com>
         <alpine.DEB.2.20.1610261231250.4983@nanos>
         <20161026112502.GB3117@twins.programming.kicks-ass.net>
         <alpine.DEB.2.20.1610261322580.4983@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1610261322580.4983@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-10-26 at 13:24 +0200, Thomas Gleixner wrote:
> On Wed, 26 Oct 2016, Peter Zijlstra wrote:
> > 
> > On Wed, Oct 26, 2016 at 12:49:36PM +0200, Thomas Gleixner wrote:
> > 
> > > 
> > > > 
> > > > +	/*
> > > > +	 * ITMT capability automatically enables ITMT
> > > > +	 * scheduling for small systems (single node).
> > > > +	 */
> > > > +	if (topology_num_packages() == 1)
> > > > +		sysctl_sched_itmt_enabled = 1;
> > > I really hate this. This is policy and the kernel should not impose
> > > policy. Why would I like to have this enforced on my single socket XEON
> > > server?
> > So this really wants to be enabled by default; otherwise nobody will use
> > this, and it really does help single threaded workloads.
> Fair enough. Then this wants to be documented.
>  
> > 
> > There were reservations on the multi-socket case of ITMT, maybe it would
> > help to spell those out in great detail here. That is, have the comment
> > explain the policy instead of simply stating what the code does (which
> > is always bad comment policy, you can read the code just fine).
> What is the objection for multi sockets? If it improves the behaviour then
> why would this be a bad thing for multi sockets?

For multi-socket (server system), it is much more likely that they will
have multiple cpus in a socket busy and not run in turbo mode. So the extra
work in migrating the workload to the one with extra headroom will
not make use of those headroom in that scenario.  I will update the comment
to reflect this policy.

See also our previous discussions: http://lkml.iu.edu/hypermail/linux/kernel/1609.1/03381.html

Tim
