From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: selective wakeups
Date: Mon, 9 Feb 2015 10:45:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1502091042160.20425-100000@netrider.rowland.org>
References: <54D88267.9060801@collabora.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:42823 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932684AbbBIPpr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 10:45:47 -0500
In-Reply-To: <54D88267.9060801@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Derek Basehore <dbasehore@google.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Mon, 9 Feb 2015, Tomeu Vizoso wrote:

> On 02/04/2015 10:05 AM, Oliver Neukum wrote:
> > On Tue, 2015-02-03 at 10:54 +0100, Tomeu Vizoso wrote:
> >> I'm looking at how to support wakeup sources that resume a subset
> >> of the suspended devices. The goal is for the machine to be able to
> >> wakeup the CPU but not the display or sound card when the wakeup
> >> source isn't user-initiated, such as RTC or a network card (we can
> >> call it automatic resume).
> > 
> > Why the limitation? To stay in example, why wake the sound card if
> > you have no sound to play even if the user initiated the wake up?
> 
> The point is to not wake it up if it isn't an user-initiated wake up. If
> it is, the existing behaviour is fine.

That was _your_ point.  Oliver's point was different: Why not change
the behavior also for user-initiated wakeups?

> > Though in practice the problem with such attempts in the past was 
> > that it is very hard, in fact almost impossible, to find out what 
> > resumed a system.
> 
> Yeah, I know it's not generally doable, but as Derek said, some HW
> allows for it.
> 
> > Secondly, you cannot assume that there's always a single cause for
> > resuming.
> 
> Are you thinking of the case in which the user opens the lid while we
> are waking up because of a RTC alarm? Userspace would realize the lid is
> open and would resume the screen.

In that case, why should the kernel bother resuming the screen when the
wakeup cause is the user opening the lid (since userspace will resume
the screen anyway)?  In fact, why should the kernel bother resuming the
screen ever?

Alan Stern

