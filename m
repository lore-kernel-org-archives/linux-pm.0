From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/9] x86/sysctl: Add sysctl for ITMT scheduling feature
Date: Wed, 26 Oct 2016 13:25:02 +0200
Message-ID: <20161026112502.GB3117@twins.programming.kicks-ass.net>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>
 <b3f648c2c4cd36b6a043239bee8437a2060c0ac4.1477000078.git.tim.c.chen@linux.intel.com>
 <alpine.DEB.2.20.1610261231250.4983@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610261231250.4983@nanos>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 26, 2016 at 12:49:36PM +0200, Thomas Gleixner wrote:

> > +	/*
> > +	 * ITMT capability automatically enables ITMT
> > +	 * scheduling for small systems (single node).
> > +	 */
> > +	if (topology_num_packages() == 1)
> > +		sysctl_sched_itmt_enabled = 1;
> 
> I really hate this. This is policy and the kernel should not impose
> policy. Why would I like to have this enforced on my single socket XEON
> server?

So this really wants to be enabled by default; otherwise nobody will use
this, and it really does help single threaded workloads.

There were reservations on the multi-socket case of ITMT, maybe it would
help to spell those out in great detail here. That is, have the comment
explain the policy instead of simply stating what the code does (which
is always bad comment policy, you can read the code just fine).
