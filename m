From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ACPI code in platform mode hibernation code paths
	(was: Re: [PATCH] swsusp: do not use pm_ops)
Date: Fri, 4 May 2007 00:48:07 +0200
Message-ID: <20070503224807.GD13426__47136.819191701$1178232579$gmane$org@elf.ucw.cz>
References: <20070425072350.GA6866@ucw.cz> <200705021542.24988.rjw@sisk.pl>
	<8f8ff01d0705020711r630b8b92sdd2cd9316eb39edc@mail.gmail.com>
	<200705022126.47897.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705022126.47897.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

Crazy idea... could we kill hibernate_ops-like struct, and just create
a device for ACPI, using its suspend()/resume()/whatever callbacks to
do the ACPI magic?

> Okay.  Since we're trying to separate the hibernation code from the
> suspend code anyway, we can use the opportunity to introduce some new
> callbacks for the hibernation and/or redefine the existing ones.
> 
> The spec suggests that we need the following callbacks:
> 
> (1) prepare() - called after device_suspend(), execute _PTS and
> disable GPEs

sysdev .suspend() method would do the trick.

> (2) cancel() - called at any time after prepare() if there's an error, execute
>     _WAK and enable run-time GPEs

sysdev .resume() should do the trick. 

> (3) enter() - called after the image has been saved, execute _GTS and do what's
>     currently done in pm_enter()

This one is tricky. It is essentially
powerdown_but_enter_S4_instead. I guess we can live with if()... as we
need to special-case reboot in the same place.

> (4) finish() - called after the image has been restored, do what's currently
>     done in pm_finish()

platform (?) device .resume() method should work.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
