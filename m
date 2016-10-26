From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Wed, 26 Oct 2016 20:09:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610262000410.5013@nanos>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>  <b3f648c2c4cd36b6a043239bee8437a2060c0ac4.1477000078.git.tim.c.chen@linux.intel.com>  <alpine.DEB.2.20.1610261231250.4983@nanos>  <20161026112502.GB3117@twins.programming.kicks-ass.net>
 <alpine.DEB.2.20.1610261322580.4983@nanos> <1477502612.2680.9.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-942364751-1477505397=:5013"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1477502612.2680.9.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-942364751-1477505397=:5013
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Oct 2016, Tim Chen wrote:
> On Wed, 2016-10-26 at 13:24 +0200, Thomas Gleixner wrote:
> > > There were reservations on the multi-socket case of ITMT, maybe it would
> > > help to spell those out in great detail here. That is, have the comment
> > > explain the policy instead of simply stating what the code does (which
> > > is always bad comment policy, you can read the code just fine).
> > What is the objection for multi sockets? If it improves the behaviour then
> > why would this be a bad thing for multi sockets?
> 
> For multi-socket (server system), it is much more likely that they will
> have multiple cpus in a socket busy and not run in turbo mode. So the extra
> work in migrating the workload to the one with extra headroom will
> not make use of those headroom in that scenario.  I will update the comment
> to reflect this policy.

So on a single socket server system the extra work does not matter, right?
Don't tell me that single socket server systems are irrelevant. Intel is
actively promoting single socket CPUs, like XEON D, for high densitiy
servers...

Instead of handwaving arguments I prefer a proper analysis of what the
overhead is and why it is not a good thing for loaded servers in general.

Then instead of slapping half baken heuristics into the code, we should sit
down and think a bit harder about it.

Thanks,

	tglx
--8323329-942364751-1477505397=:5013--
