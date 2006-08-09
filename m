From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 14:08:44 +0200
Message-ID: <20060809120844.GD3747@elf.ucw.cz>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<20060808235352.GA4751@elf.ucw.cz>
	<Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
	<20060809073958.GK4886@elf.ucw.cz>
	<Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0608090751340.2500@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608090751340.2500@gandalf.stny.rr.com>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net, ncunningham@linuxmail.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > cat we get contents of /proc/acpi/thermal*/*/* ?
> >
> > I'm running after a poweroff (left it running over night in the hotel, and
> > I'm still in the hotel).
> >
> > $ grep . /proc/acpi/thermal_zone/THRM/*
> > /proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
> > /proc/acpi/thermal_zone/THRM/cooling_mode:cooling mode: passive
> > /proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
> > /proc/acpi/thermal_zone/THRM/state:state:                   ok
> > /proc/acpi/thermal_zone/THRM/temperature:temperature:             48 C
> > /proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           88 C
> > /proc/acpi/thermal_zone/THRM/trip_points:passive:                 81 C: tc1=4 tc2=3 tsp=100 devices=0xcf6c2338
> >
> > Note thermal_zone/THRM was finished with bash tab completion so they are
> > the only things that match the above glob expr.
> >
> 
> Note: I just did a swsusp and resume and here's the same data:
> 
> $ grep . /proc/acpi/thermal_zone/THRM/*
> /proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
> /proc/acpi/thermal_zone/THRM/cooling_mode:cooling mode: passive
> /proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
> /proc/acpi/thermal_zone/THRM/state:state:                   ok
> /proc/acpi/thermal_zone/THRM/temperature:temperature:             60 C
> /proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           88 C
> /proc/acpi/thermal_zone/THRM/trip_points:passive:                 81 C: tc1=4 tc2=3 tsp=100 devices=0xcf6c2338
> 
> 
> And just leaving my system idle for a few minutes:
> 
> $ grep . /proc/acpi/thermal_zone/THRM/temperature
> temperature:             62 C
> 
> and a few more minutes:
> 
> temperature:             64 C
> 
> 
> And a few more:
> 
> temperature:             66 C
> 
> 
> right now after typing this:
> 
> temperature:             69 C
> 
> 
> So this definitely shows somethings not letting the CPU rest.

Okay, run top to see what goes on, and look for
/proc/acpi/processor/*/* -- you are interested in C states before and
after suspend.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
