From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute =?iso-8859-1?q?in=09sysfs?=
Date: Thu, 25 Jan 2007 18:12:20 -0500
Message-ID: <200701251812.21180.lenb@kernel.org>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701242321.09850.lenb@kernel.org> <20070125194710.GC23774@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070125194710.GC23774@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Alessandro Zummo <alessandro.zummo@towertech.it>, Paul Sokolovsky <pmiscml@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 25 January 2007 14:47, Pavel Machek wrote:
> Hi!
> 
> > > Note that a few RTCs ignore rtc_wkalrm.enabled when setting alarms, or
> > > aren't set up correctly, so they won't yet behave with this attribute.
> > > 
> > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > How do I ask to wake up "as soon as possible"?
> 
> If you want to wake up ASAP, don't go to sleep :-).
> 
> I see it might be handy for debugging... but I guess we should not
> mess rtc design because of that. Just set alarm 10 seconds into
> future.

That's my point.
What is the syntax to request "10-seconds into the future"?
