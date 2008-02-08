From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 23:08:34 +0100
Message-ID: <20080208220834.GA1631@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <47AB887E.7010000@zytor.com> <20080208215809.GN12923@elf.ucw.cz> <200802082301.51582.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762467AbYBHWL0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802082301.51582.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-02-08 23:01:51, Rafael J. Wysocki wrote:
> On Friday, 8 of February 2008, Pavel Machek wrote:
> > Hi!
> > 
> > Rafael, this is for you.
> 
> Thanks.
> 
> > My cleanups, relative to your cleanup patch. You may need manual patching
> > around rep/stosd.
> 
> OK, I'll try to merge it.

For the record, now it is even tested on 32-bit and test-compiled on
64-bit.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
