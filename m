From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Date: Tue, 27 Jun 2006 10:38:39 -0700
Message-ID: <200606271038.40510.david-b@pacbell.net>
References: <20060623042452.GA23232@kroah.com> <20060626235732.GE32008@kroah.com> <20060627090304.GA29199@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932485AbWF0RsP@vger.kernel.org>
In-Reply-To: <20060627090304.GA29199@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb-devel@lists.sourceforge.net
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

> > > > And we also need to be able to handle devices in the device tree that do
> > > > not have a suspend/resume function ...
> > >
> > > Ah, there's the rub.  If a driver doesn't have suspend/resume methods, is 
> > > it because it doesn't need them, or is it because nobody has written them 
> > > yet?  In the latter case, failing the suspend or unbinding the driver are 
> > > the only safe courses.
> > 
> > No, if it's not there, just expect that it knows what it is doing, and
> > don't fail the thing.  Unless you want to add those methods to _every_
> > driver in the kernel, and that's going to be a lot of work...

It seems reasonable to me to require that drivers have at least
stub "it's actually OK to do nothing here" suspend/resume methods.


> I believe 90% of drivers need them, anyway... Idea is that if we
> refuse the suspend, user has dmesg and did not loose his work. If we
> suspend but can't resume due to driver problems, it is slightly more
> interesting to debug, and user lost open applications.

Or as I put it earlier, a clean failure right at the "suspend/resume
method missing" point is more robust than unpredictable failures much
later (long after that actual failure points).

- Dave
