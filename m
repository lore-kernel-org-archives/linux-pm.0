From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] USB power usage
Date: Tue, 26 Dec 2006 15:46:44 -0800
Message-ID: <200612261546.45800.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0612252245310.29662-100000@netrider.rowland.org> <20061226144008.GA2062@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932861AbWLZXqt@vger.kernel.org>
In-Reply-To: <20061226144008.GA2062@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> > > Couple of watts is not that bad, considering usb still eats 4W more
> > > than it should.
> > 
> > The USB autosuspend mechanism has been present for a while in -mm and is
> > included in 2.6.20-rc (although you have to turn on CONFIG_USB_SUSPEND,
> > which is off by default -- it would be nice to change that).

Call me paranoid, but I'd like to leave it this way for for a while yet
to shake out bugs.  There are some complicated interactions here, some
of which are hardware-specific, and we've only just started to really
shake out the associated problems.  (But yes, eventually we do want to
see that option go away, and this behavior be standard with PM enabled.)


> > Has anybody 
> > tried doing some real-world measurements to see if it actually makes a
> > significant improvement in power usage?
> 
> I did measurements while in -mm, and yes it helped. And yes,
> it works in 2.6.20-rc2, too:
> 
> ...
> 
> As you can see, it saves ~3.5W, which is huge deal on machine that
> eats 11W total.

Hey, that's great to know.  Thanks for sharing the figures!

And special thanks to Alan, for reworking (and re-reworking) relevant
parts of usbcore so that these power savings can (mostly) be automated.
ISTR the first patches supporting USB suspend/resume/wakeup landed in
about the 2.6.10 kernel, and things look a LOT better than back then.

- Dave


> (X60 owners, get 2.6.20, and _disable that bluetooth_ while not in use).
> 									Pavel
