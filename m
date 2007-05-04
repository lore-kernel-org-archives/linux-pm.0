From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ACPI code in platform mode hibernation code paths
	(was: Re: [PATCH] swsusp: do not use pm_ops)
Date: Fri, 4 May 2007 14:08:02 +0200
Message-ID: <20070504120802.GF13426__30763.7387108572$1178280535$gmane$org@elf.ucw.cz>
References: <20070425072350.GA6866@ucw.cz> <200705021542.24988.rjw@sisk.pl>
	<8f8ff01d0705020711r630b8b92sdd2cd9316eb39edc@mail.gmail.com>
	<200705022126.47897.rjw@sisk.pl>
	<20070503224807.GD13426@elf.ucw.cz>
	<1178276072.7408.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178276072.7408.7.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Crazy idea... could we kill hibernate_ops-like struct, and just create
> > a device for ACPI, using its suspend()/resume()/whatever callbacks to
> > do the ACPI magic?
> 
> Doesn't that have the ordering problem again? You must ensure that this
> sysdev is suspended as the last one, and that's currently impossible if
> ACPI is modular.

I do not think acpi has these kinds of ordering requirements... (And I
do not see what it has to do with module or not).



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
