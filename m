From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 08:38:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0608090837120.3177@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<20060808235352.GA4751@elf.ucw.cz>
	<Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
	<20060809073958.GK4886@elf.ucw.cz>
	<Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
	<20060809120734.GA30544@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
In-Reply-To: <20060809120734.GA30544@rhlx01.fht-esslingen.de>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-pm@osdl.org, Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net, ncunningham@linuxmail.org
List-Id: linux-pm@vger.kernel.org



On Wed, 9 Aug 2006, Andreas Mohr wrote:

> On Wed, Aug 09, 2006 at 07:45:23AM -0400, Steven Rostedt wrote:
> > It does look like something isn't setting up the ACPI power properly on
> > resume, and that the CPU is probably in a busy loop while the machine is
> > idle.  Just a guess.
>
> In that case could you post
> cat /proc/acpi/processor/CPU?/*
> ?

This is after a suspend:

$ cat /proc/acpi/processor/CPU*/*
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        no
throttling control:      yes
limit interface:         yes
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000]
usage[00000000] duration[00000000000000000000]
state count:             4
active state:            T0
states:
   *T0:                  00%
    T1:                  25%
    T2:                  50%
    T3:                  75%
processor id:            1
acpi id:                 1
bus mastering control:   yes
power management:        no
throttling control:      yes
limit interface:         yes
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000]
usage[00000000] duration[00000000000000000000]
state count:             4
active state:            T0
states:
   *T0:                  00%
    T1:                  25%
    T2:                  50%
    T3:                  75%



>
> Perhaps we're losing ACPI C2/C3 state power saving, and checking
> the busmaster activity indicators there would be useful, too.
>
> Oh, in this context maybe it's actually a problem of a misbehaving driver?
> An active USB mouse is known to distort ACPI power saving, causing reduced
> notebook battery operation length (due to busmaster activity preventing
> ACPI idling, I think). Now what if some certain driver actually caused
> permanent busmaster activity...?

I unplug everything before doing a suspend.  Right now I'm leaving the
network connected so I don't need to go throught the connection process
again.


Got to leave the hotel now, eat breakfast and go to work ;)

-- Steve
