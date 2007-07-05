From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 11:30:13 +0200
Message-ID: <20070705093013.GA3228__39454.7751326629$1183628149$gmane$org@elf.ucw.cz>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031608.06348.nigel@nigel.suspend2.net>
	<1183447184.10386.102.camel@localhost.localdomain>
	<200707031456.40890.rjw@sisk.pl>
	<1183497290.3388.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1183497290.3388.4.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > >  - For STR, don't do the freezer thing.
> > 
> > In the long run, I agree.
> > 
> > Still, can you please read this post from Alan Stern:
> > 
> > https://lists.linux-foundation.org/pipermail/linux-pm/2007-June/012847.html
> > 
> > ?  I don't think I'm able to repeat the arguments given in there in a
> > convincing way.
> 
> That's the same crackpot I've been hearing for the past 3 years or
> so ...
> 
> Both Paulus and I think the freezer is just a way to try to put your
> head in the sand and ignore the problem. It causes as many problems as
> it solves on its own, and is just not a solution that will be of any use
> once you start implementing dynamic PM schemes etc...

Well, yep, you can view freezer as a head in the sand...

> In many cases, having proper support for "live" suspend of devices is
> just a matter of having a couple of helpers in whatever subsystem those
> drivers hookup with. In the case of network, for example, it's mostly
> trivial (stop the queue). For block, it's not terribly hard neither,
> though you want to have some orderign/atomicity between the blocking of
> the incoming request queue and the sending of things like spindown &
> flush commands to the disk. For old-style IDE, that was fairly easily
> solved by piping suspend/resume command down the request queue itself
> and have the queue block/unblbock itself after processing them. Some of
> that logic could maybe be moved to the block layer for all block drivers
> to benefit.

...but the moment you start blocking tasks that done driver request,
you _do_ have mini-freezer of your own, with pretty much the same
problems.

In another message I shown that removing freezer will not help with
FUSE in general case.

It probably does not help with firmware, too; as soon as udev attempts
to do something with your wireless card, it is blocked, and if the
wireless card needs the firmware from udev, you are deadlocked.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
