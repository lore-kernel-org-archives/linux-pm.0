From: Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFC] QoS params patch
Date: Thu, 27 Sep 2007 08:17:18 -0700
Message-ID: <20070927151718.GD25718__45790.7589887784$1190906334$gmane$org@linux.intel.com>
References: <20070926223712.GA22029@linux.intel.com>
	<20070926224026.GA23218@linux.intel.com>
	<20070926164159.3b43479b.randy.dunlap@oracle.com>
	<20070927004020.GB29906@linux.intel.com>
	<22087.1190861583@turing-police.cc.vt.edu>
	<20070927031821.GA26307@linux-sh.org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070927031821.GA26307@linux-sh.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mundt <lethal@linux-sh.org>, Valdis.Kletnieks@vt.edu, Randy Dunlap <randy.dunlap@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-ker>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 27, 2007 at 12:18:21PM +0900, Paul Mundt wrote:
> On Wed, Sep 26, 2007 at 10:53:03PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 26 Sep 2007 17:40:20 PDT, Mark Gross said:
> > > --- linux-2.6.23-rc8/kernel/Makefile	2007-09-26 13:54:54.000000000 -0700
> > > +++ linux-2.6.23-rc8-qos/kernel/Makefile	2007-09-26 14:06:38.000000000 -
> > 0700
> > > @@ -9,7 +9,7 @@
> > >  	    rcupdate.o extable.o params.o posix-timers.o \
> > >  	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
> > >  	    hrtimer.o rwsem.o latency.o nsproxy.o srcu.o die_notifier.o \
> > > -	    utsname.o
> > > +	    utsname.o qos_params.o
> > 
> > So I don't get a choice in the matter if I will be dragging this thing
> > around in my kernel, even if I have no intention of using the functionality?
> > 
> You don't get that option with latency.c either at the moment, and it's
> arguable whether it's even worth it. The more curious thing is that while
> this qos params seems to be an evolution of Arjan's latency.c (and the
> drivers that are using it are updated in the rest of the patch set),
> latency.c itself is still compiled in. Is this an oversight, or was it
> intentional? One set of latency hinting APIs only, please :-)

It was intentional to compile latnecy.c in (and hence qos_parms is
starting off doing the same thing)  

I agree, "there can be only be one".  (couldn't resist)

I split the patch set up this first patch puts in the qos_param.c and
the second patch yanks latency.c replacing things with its interfaces.

--mgross
