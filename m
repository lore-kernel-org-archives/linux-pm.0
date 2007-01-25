From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep
	"alarm" attribute in	sysfs
Date: Fri, 26 Jan 2007 10:28:50 +1100
Message-ID: <1169767730.1316.58.camel@nigel.suspend2.net>
References: <1168083318.5619.37.camel@localhost.localdomain>
	 <200701242321.09850.lenb@kernel.org> <20070125194710.GC23774@elf.ucw.cz>
	 <200701251812.21180.lenb@kernel.org>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200701251812.21180.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Alessandro Zummo <alessandro.zummo@towertech.it>, linux-pm@lists.osdl.org, Paul Sokolovsky <pmiscml@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On Thu, 2007-01-25 at 18:12 -0500, Len Brown wrote:
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

AFAIK (and I think this is what Pavel is saying) there isn't one - you'd
have to use a shell script of some sort or such like to calculate now +
10s and echo the result to the entry.

Regards,

Nigel

