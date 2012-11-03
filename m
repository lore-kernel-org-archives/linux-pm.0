From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Linux 3.7-rc3
Date: Sat, 3 Nov 2012 12:35:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1211031225100.17692-100000@netrider.rowland.org>
References: <CA+55aFx+w2hFifGTr_u76D9d_sDKxKJBDd2L4p0GVk-RXCczMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFx+w2hFifGTr_u76D9d_sDKxKJBDd2L4p0GVk-RXCczMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2 Nov 2012, Linus Torvalds wrote:

> On Fri, Nov 2, 2012 at 3:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > Well, not everything is rosy in the suspend land, though.  This is a
> > failure to freeze khubd during the second in a row attempt to suspend to
> > RAM (your current tree):
> 
> Ugh. So khubd is blocked in usb_start_wait_urb(), and apparently the
> timeout for that block is longer than the freezing timeout.
> 
> There's a comment about why khubd needs to be freezable, but I wonder
> if that whole thing isn't doing something wrong. Causing the suspend
> to fail is definitely always the wrong thing.

khubs has been a potential problem for suspend since the beginning.

The USB spec mandates timeouts of 5 seconds.  In addition, khubd does
lots of retries when errors occur (probably way too many) and checks
for freezability only when its to-do list is empty.

Under normal circumstances this isn't a problem.  Issues arise when a 
non-cooperative device is plugged in shortly before a suspend starts.

I suppose we could scatter a whole bunch of checks at spots throughout 
the device-initialization code.  This seems awkward but I can't think 
of anything better.  Does anyone have other suggestions?

Alan Stern
