From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 22:47:25 +0100
Message-ID: <20080208214725.GA541@uranus.ravnborg.org>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <200802070049.00461.rjw@sisk.pl> <200802072312.31430.rjw@sisk.pl> <20080207222833.GA23004@uranus.ravnborg.org> <20080208214145.GJ12923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753256AbYBHVrc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080208214145.GJ12923@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 08, 2008 at 10:41:45PM +0100, Pavel Machek wrote:
> > Do we never need data from a .h file?
> > If we do name it wakeup.lds.S and kbuild
> > will fix it (assuming we have wakeup.lds
> > as a prerequisite where it is needed.
> 
> Ok, I got it to work... but notice the ugly #undef :-(.
Great.
We have the same issue with vmlinux_64.lds.S in x86/kernel/

	Sam
