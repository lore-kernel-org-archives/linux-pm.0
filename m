From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
	Software Suspend, aka swsusp):
Date: Tue, 14 Aug 2007 09:05:28 +0200
Message-ID: <20070814070528.GA2903__4473.00250311873$1187091862$gmane$org@elf.ucw.cz>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708132325.04810.rjw@sisk.pl>
	<1187040080.10249.323.camel@localhost>
	<200708132338.25925.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708132338.25925.rjw@sisk.pl>
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
Cc: Joe Perches <joe@perches.com>, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > + include/linux/suspend.h
> > > + include/linux/freezer.h
> > > + include/linux/pm.h
> > > + include/asm-*/suspend.h
> > > 
> > > Hm, they are also relevant for suspend to RAM, so perhaps one common
> > > list of files for suspend to RAM and hibernation would be better?
> > 
> > Maybe just collapse the 2 maintainers blocks into one?

No, please don't.

> > HIBERNATION (aka Software Suspend, aka swsusp) and SUSPEND TO RAM:
> > P:	Pavel Machek
> > M:	pavel@suse.cz
> > P:	Rafael J. Wysocki
> > M:	rjw@sisk.pl
> > L:	linux-pm@lists.linux-foundation.org
> > S:	Supported
> 
> Then I think it should be "Maintained".

No, supported is still right :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
