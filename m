From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Wed, 6 Feb 2008 02:56:35 +0100
Message-ID: <200802060256.35870.rjw@sisk.pl>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060242.15097.rjw@sisk.pl> <47A9129A.7050706@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763270AbYBFB6o@vger.kernel.org>
In-Reply-To: <47A9129A.7050706@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 6 of February 2008, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
> >> The asm() for making beeps really need to be moved to a function and 
> >> cleaned up (redone in C using inb()/outb()) if they are to be retained 
> >> at all.
> > 
> > Yes, they are.  For some people they're the only tool to debug broken resume.
> 
> That's fine, but they should get cleaned up.

I 100% agree.

> /me is tempted to provide a version which can send messages in Morse Code ;)

That would be great.  It could also play some music or something. ;-)

Rafael
