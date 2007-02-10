From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Re: NAK new drivers without proper power management?
Date: Sat, 10 Feb 2007 21:02:02 +1100
Message-ID: <1171101723.3821.22.camel@nigel.suspend2.net>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	 <45CD24F6.8090107@shaw.ca> <1171076554.10170.5.camel@nigel.suspend2.net>
	 <200702101034.04410.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753043AbXBJKCH@vger.kernel.org>
In-Reply-To: <200702101034.04410.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Gidday.

On Sat, 2007-02-10 at 10:34 +0100, Rafael J. Wysocki wrote:
> On Saturday, 10 February 2007 04:02, Nigel Cunningham wrote:
> > On Fri, 2007-02-09 at 19:50 -0600, Robert Hancock wrote:
> > > It also kind of bothers me that if a driver has no suspend/resume 
> > > functions, and you suspend and resume the system, we don't complain 
> > > about it even though there's a very good chance that device is not going 
> > > to function properly. How about something in dmesg like:
> > > 
> > > Warning: driver for device XXXX has no suspend or resume support.
> > > Device may not function properly after resume.
> > > 
> > > so that users know who to complain to. Maybe there are some devices that 
> > > truly don't need any handling for suspend, but if so I suspect the 
> > > number of those is small enough that adding empty functions would be a 
> > > good-enough solution.
> > 
> > Here's my current version of a patch to do this, if anyone wants to try
> > it out. It dumps stack with the warning to make it easier to see what
> > the source of the message is:
> 
> I have an alternative idea.
> 
> There is a test mode of swsusp that's triggered with
> "echo test > /sys/power/disk" and "echo disk > /sys/power/state".  We can make
> it set a switch that will be used to trigger the warnings in the core.
> 
> This way the warnings will only appear in the user's dmesg in the test mode
> and not always.
> 
> Would that be acceptable?

Well, the original desire was to stop new drivers getting in without
proper power management. For this to help achieve that aim, one or more
of the following would need to happen:

* developers of new drivers would have to remember to run the test
after/during writing their driver. Of course if they remember to do
this, they've already remembered that they need to implement power
management;
* you, I or someone else would need to test all these trees before
Andrew and Linus merge them and report problems to the developers before
they get their new drivers merged;
* Andrew or Linus would run it prior to or after merging a whole lot of
stuff.

I'm afraid I don't like the chances of any of those things happening, so
I'm not sure that it is an acceptable alternative from my perspective. 

Sticking a printk in dmesg doesn't exactly put the problem in flashing
red 36 point characters before the developer either, but I think they're
slightly more likely to see it there if only because they might stick
printks in that they want to read (eg perhaps while debugging the
driver) and therefore see the message when checking output from the
driver being loaded/initialised.

Maybe another alternative would be to make the warnings compile time
warnings - if that's possible?

Regards,

Nigel
