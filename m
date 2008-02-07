From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 7 Feb 2008 23:57:32 +0100
Message-ID: <200802072357.33293.rjw@sisk.pl>
References: <20080205190600.GB11613@elf.ucw.cz> <20080207222845.GA6096@elf.ucw.cz> <47AB8A41.3040008@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932614AbYBGW7m@vger.kernel.org>
In-Reply-To: <47AB8A41.3040008@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 7 of February 2008, H. Peter Anvin wrote:
> Pavel Machek wrote:
> > 
> > This is probably more acceptable version of beep; but there are
> > probably even better ways to clean it...
> > 
> >         if (wakeup_header.realmode_flags & 4) {
> >                 inb(97);
> >                 outb(0, 0x80);
> >                 outb(3, 97);
> >                 outb(0, 0x80);
> >                 outb(-74, 67);
> >                 outb(0, 0x80);
> >                 outb(-119, 66);
> >                 outb(0, 0x80);
> >                 outb(15, 66);
> >         }
> > 
> 
> What is available at this point -- are BIOS calls still accessible; are 
> interrupts running?

No interrupts.

We're in the real mode, so BIOS calls should be accessible.

Rafael
