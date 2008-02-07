From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 00:36:42 +0100
Message-ID: <200802080036.43746.rjw@sisk.pl>
References: <20080205190600.GB11613@elf.ucw.cz> <200802080006.54151.rjw@sisk.pl> <20080207233509.GB21468@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932196AbYBGXil@vger.kernel.org>
In-Reply-To: <20080207233509.GB21468@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 8 of February 2008, Pavel Machek wrote:
> Hi!

Hi,

> > > > -	memcpy((void *)acpi_wakeup_address, &wakeup_start,
> > > > -	       &wakeup_end - &wakeup_start);
> > > > -	acpi_copy_wakeup_routine(acpi_wakeup_address);
> > > > +	memcpy((void *)acpi_realmode, &wakeup_code_start, 4*PAGE_SIZE);
> > > 
> > > Using a PAGE_SIZE multiplier here isn't a good thing...
> > 
> > Yes, I'll fix that in one of the next iterations.
> 
> Agreed.
> 
> > > > +	header = (struct wakeup_header *)(acpi_realmode + 0x3f00);
> > > 
> > > ... especially not with magic constants like this.
> > 
> > Yeah.  Pavel, what's at 0x3f00, btw?
> 
> struct wakeup_header.
> 
> I really need the entry point to be at offset 0, so that I can get
> pointers to my data. I could not figure out how to do it any other
> way. And if 0 is taken, I thought I'd put header at the end.

What does the number 0x3f00 follow from?

Rafael
