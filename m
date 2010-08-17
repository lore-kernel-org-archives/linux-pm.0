From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Wakelocks Rebooted - Power management for embedded devices
Date: Tue, 17 Aug 2010 17:58:35 +0300
Message-ID: <1282057115.13642.1146.camel@vimes.research.nokia.com>
References: <1282034436.13642.1115.camel@vimes.research.nokia.com>
	 <201008171550.06753.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201008171550.06753.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "ext Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-08-17 at 15:50 +0200, ext Rafael J. Wysocki wrote:
> On Tuesday, August 17, 2010, Igor Stoppa wrote:

> > 3) Easy identification of problematic apps (those that do not conform to
> > the desired behavior on a certain platform/configuration)
> 
> Well, I guess the ultimate goal is to save as much energy as reasonably
> possible without sacrificing the usability of the system.  That requires
> both appropriate device power management mechanisms and user space
> participation to some extent, but your goals above only seem to address the
> latter.

>From device pov, we already have dynamic idle, which can do a quite good
job, provided that the offenders are 1) prevented from taking over the
system 2) fixed.

Point 1) seems to have a solution in the form of starvation by cgroups
(but it's open for discussion) or even death by sigkill, if so has been
decided by the user, maybe through some policy.

I think the most important part is to identify offenders and provide an
explanation of the reason why they are considered as such.

> > * Introducing a mechanism to prevent power unfriendly apps from ruining
> > the overall system performance/use-time seems to be the way to go (this
> > might have both an automatic mode and a user-interactive mode), so long
> > as the user can express what he wants and gets it (which might depend on
> > what is considered to be paramount in a specific situation)
> 
> That seems to be a major problem from the implementation point of view, because
> power-unfriendly applications may be related to the power-friendly ones in
> various ways.

Indeed. In fact I am not claiming to have a solution :-) but rather a
problem and the will to tackle it.

> 
> > * In practice it seems unlikely that the applications to be made
> > available by 3rd parties will be ported existing legacy PC code, but
> > rather new apps that will be written and targeted to mobile devices.
> > 
> > Yes, there are plenty of examples that contradict my statement, however
> > observing the population of a typical app-store, most of the
> > applications are relatively simple and specifically designed to look
> > nice on a mobile screen.
> > And even for ported apps, if there are no platform specific APIs (like
> > suspend blockers), bugfixes can be contributed back to the upstream
> > project.
> 
> That seems to express the concern about platform-specific hooks added to
> applications with power management in mind.  I'm not sure if it's generally
> possible to avoid them, especially in applications located in the given
> platform's "plumbing layer" (ie. between the kernel and the other apps), but
> also I'm not sure if these applications will be portable anyway.

I suppose it's also a matter of mindset - with application I tend to
identify user-oriented programs, rather than plumbing.

What I would expect in practice is that the level of abstraction grows
with the distance from the lower layers.

cheers, igor
