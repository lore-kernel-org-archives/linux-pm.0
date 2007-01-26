From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Fri, 26 Jan 2007 18:07:54 +0100
Message-ID: <20070126170754.GA964@elf.ucw.cz>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701242321.09850.lenb@kernel.org> <20070125194710.GC23774@elf.ucw.cz> <200701251812.21180.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701251812.21180.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.osdl.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Alessandro Zummo <alessandro.zummo@towertech.it>, Paul Sokolovsky <pmiscml@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-01-25 18:12:20, Len Brown wrote:
> On Thursday 25 January 2007 14:47, Pavel Machek wrote:
> > Hi!
> > 
> > > > Note that a few RTCs ignore rtc_wkalrm.enabled when setting alarms, or
> > > > aren't set up correctly, so they won't yet behave with this attribute.
> > > > 
> > > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > > 
> > > How do I ask to wake up "as soon as possible"?
> > 
> > If you want to wake up ASAP, don't go to sleep :-).
> > 
> > I see it might be handy for debugging... but I guess we should not
> > mess rtc design because of that. Just set alarm 10 seconds into
> > future.
> 
> That's my point.
> What is the syntax to request "10-seconds into the future"?

echo $(( $(cat since_epoch) + 10 )) > wakealarm

...which is what you should expect. Yep, for users, nice utility would
be nice... but absence of nice utility does not mean that it belongs
in kernel.

Plus, old alarm file was such a mess that I were not figure out how to
use it within two hours... or maybe it just did not work on my
machine? ... so utility will be needed, anyway.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
