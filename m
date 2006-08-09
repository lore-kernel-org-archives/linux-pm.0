From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 07:45:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<20060808235352.GA4751@elf.ucw.cz>
	<Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
	<20060809073958.GK4886@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
In-Reply-To: <20060809073958.GK4886@elf.ucw.cz>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net, ncunningham@linuxmail.org
List-Id: linux-pm@vger.kernel.org


On Wed, 9 Aug 2006, Pavel Machek wrote:

> Hi!
>
> > > > A few months ago, I installed suspend2 on my laptop.  It worked great for
> > > > a few days, when suddenly my laptop started to get very hot and the fan
> > > > costantly went off, and then I started getting these:
> > >
> > > I take it as "if I keep it for a week powered off, it will not do
> > > this".
> >
> > Not quite.  It's more of, "if I suspend everynight instead of leaving it
> > running or shutting it down, it will do this" or "if I power off at night
> > or just leave it running, it will not do this".
>
> Okay, can you try to leave it up for a week or two (no suspends, no
> poweroffs) and see what happens?

I've had this laptop running for a couple of months without shutting down
and it doesn't have a problem.  The only time that I do shut it down is
when I'm working on site (which I'm doing now). So I only shutdown the
laptop while traveling.  When I came across suspend2 (and later swsusp), I
was excited that I didn't need to restart all my applications when leaving
the place of work and coming back.  But After being on site for several
days, and using the suspend to disk, I get a hot CPU. But when I've been
on site while shutting down normally when I leave then I don't have a
problem.

>
> > > P4 has thermal protection, so you are actually safe.
> >
> > Yeah, but still, the keyboard gets pretty hot too, and I'm actually more
> > worried about damaging something that is close by than damaging the CPU
> > itself.
>
> If you damage something, machine was misdesigned in the first place.

agreed, but you never know ;)  This laptop is currently my lifeline :)

>
> cat we get contents of /proc/acpi/thermal*/*/* ?

I'm running after a poweroff (left it running over night in the hotel, and
I'm still in the hotel).

$ grep . /proc/acpi/thermal_zone/THRM/*
/proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/THRM/cooling_mode:cooling mode: passive
/proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/THRM/state:state:                   ok
/proc/acpi/thermal_zone/THRM/temperature:temperature:             48 C
/proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           88 C
/proc/acpi/thermal_zone/THRM/trip_points:passive:                 81 C: tc1=4 tc2=3 tsp=100 devices=0xcf6c2338

Note thermal_zone/THRM was finished with bash tab completion so they are
the only things that match the above glob expr.

>
> > $ sudo modprobe ibm_acpi
> > $ ls /proc/acpi/ibm/
> > bay        bluetooth  driver     led        thermal
> > beep       cmos       hotkey     light      video
> >
> > No fan there
>
> Does ibm/thermal work?

$ cat /proc/acpi/ibm/thermal
temperatures:   not supported

I guess not.

>
> Seems like fan is completely controlled by hardware. What may still
> help: either saving or avoiding saving reserved parts of memory. But
> this is all magic.
>
> How s2ram works would be useful info.

No idea.

It does look like something isn't setting up the ACPI power properly on
resume, and that the CPU is probably in a busy loop while the machine is
idle.  Just a guess.

Thanks for the support,

-- Steve
