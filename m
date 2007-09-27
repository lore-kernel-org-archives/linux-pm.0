From: Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFC] QoS params patch
Date: Thu, 27 Sep 2007 08:36:12 -0700
Message-ID: <20070927153612.GE25718__10067.060966003$1190907482$gmane$org@linux.intel.com>
References: <20070926223712.GA22029@linux.intel.com>
	<20070926224026.GA23218@linux.intel.com>
	<20070926164159.3b43479b.randy.dunlap@oracle.com>
	<20070927004020.GB29906@linux.intel.com>
	<22087.1190861583@turing-police.cc.vt.edu>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <22087.1190861583@turing-police.cc.vt.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Valdis.Kletnieks@vt.edu
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 26, 2007 at 10:53:03PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 26 Sep 2007 17:40:20 PDT, Mark Gross said:
> (others here are probably better at spotting leaks and races than I am,
> so I'm skipping those and picking other nits. ;)
> 
> > --- linux-2.6.23-rc8/kernel/Makefile	2007-09-26 13:54:54.000000000 -0700
> > +++ linux-2.6.23-rc8-qos/kernel/Makefile	2007-09-26 14:06:38.000000000 -
> 0700
> > @@ -9,7 +9,7 @@
> >  	    rcupdate.o extable.o params.o posix-timers.o \
> >  	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
> >  	    hrtimer.o rwsem.o latency.o nsproxy.o srcu.o die_notifier.o \
> > -	    utsname.o
> > +	    utsname.o qos_params.o
> 
> So I don't get a choice in the matter if I will be dragging this thing
> around in my kernel, even if I have no intention of using the functionality?

nope.

> 
> > + * This QoS design is best effort based.  Dependents register their QoS needs.
> > + * Watchers register to keep track of the current QoS needs of the system.
> > + *
> > + * There are 3 basic classes of QoS parameter: latency, timeout, throughput
> > + * each have defined units:
> > + * latency: usec
> > + * timeout: usec <-- currently not used.
> > + * throughput: kbs (kilo byte / sec)
> 
> It's unclear whether these are registering a differing QoS request for each
> process/container/whatever that asks for one, or if they're global across the
> system.  Also, even though it's "best effort", it would be good to document
> what the failure mode is if we get conflicting requests, or an overcommit
> situation - do new requests get refused, or allowed and ignored, or allowed
> and only sometimes fulfilled.  For instance, assume a gigabit ethernet,
> and 3 processes ask for 400 mbits/sec each - who wins, who gets part of what
> they asked for, and who loses and gets starved?

There are no overcommit failure modes.  These QoS parameters are for
constraining aggressive power management throttling from breaking things
thereby enabling better power management solutions.

The QoS values are system wide parameters, not per process or driver.
So the code takes the max or min depending on what class of parameter is
in question.  So if you have multiple applications asking for network
throughput of 400Mbs the current code will let the nic driver find out
that it shouldn't throttle itself to the point where it can provide
400Mbs to any one.

You raise a perspective I overlooked.  For each of the parameter classes
I had been thinking of computing some extrema out of the set of
requests.  However; for throughput it may make more sense to sum up a
collative value.

I'm not sure which way would make more sense.

--mgross

> 
> > + * User mode requirements on a QOS parameter register themselves to the
> > + * subsystem by opening the device node /dev/... and writing there request to
> > + * the node.  As long as the process holds a file handle open to the node the
> 
> /dev?  What /dev entry do you use for a network interface?  Should this
> be a configfs creature instead, or maybe something else?
> 
> > +/* static helper functions */
> > +static s32 max_compare(s32 v1, s32 v2)
> 
> Blech.  Is it time for the yearly stamp-out-reinvention-of-max() already?
> The use of pointer functions is interesting, but I have to wonder if there's
> not a better way...
> 
> > +#define PID_NAME_LEN sizeof("process_1234567890")
> > +static char name[PID_NAME_LEN];
> 
> And then you just pass a pointer to this and kstrdup() it.  Why not kmalloc()
> the space initially and just 'dep->name = name;' and be done with it?
> 
> General nit - why qos_power_*, when none of the supported QoS parameters
> seem to be power-related?
