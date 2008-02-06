From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Wed, 6 Feb 2008 02:42:14 +0100
Message-ID: <200802060242.15097.rjw@sisk.pl>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <47A90F23.80009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932194AbYBFBo3@vger.kernel.org>
In-Reply-To: <47A90F23.80009@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 6 of February 2008, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
> > On Tuesday, 5 of February 2008, Pavel Machek wrote:
> >> This rewrites wakeup code to .c, and it fixes stack (should use movl
> >> ,%esp, not movw). Testers wanted. Makefile infrastructure was done by
> >> hpa, cleanups by rjw.
> > 
> > I'll test it tomorrow and I still have some more cleanups (I was distracted by
> > a nasty scheduler issue in the current mainline).
> 
> The asm() for making beeps really need to be moved to a function and 
> cleaned up (redone in C using inb()/outb()) if they are to be retained 
> at all.

Yes, they are.  For some people they're the only tool to debug broken resume.

Rafael
