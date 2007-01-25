From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Thu, 25 Jan 2007 20:47:10 +0100
Message-ID: <20070125194710.GC23774@elf.ucw.cz>
References: <1168083318.5619.37.camel@localhost.localdomain> <20070107111859.GB4792@ucw.cz> <200701071944.59470.david-b@pacbell.net> <200701242321.09850.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701242321.09850.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.osdl.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Alessandro Zummo <alessandro.zummo@towertech.it>, Paul Sokolovsky <pmiscml@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Note that a few RTCs ignore rtc_wkalrm.enabled when setting alarms, or
> > aren't set up correctly, so they won't yet behave with this attribute.
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> How do I ask to wake up "as soon as possible"?

If you want to wake up ASAP, don't go to sleep :-).

I see it might be handy for debugging... but I guess we should not
mess rtc design because of that. Just set alarm 10 seconds into
future.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
