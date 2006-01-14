From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Sat, 14 Jan 2006 18:43:45 +0100
Message-ID: <20060114174345.GA16427@elf.ucw.cz>
References: <200601122241.07363.rjw@sisk.pl> <200601141040.00088.rjw@sisk.pl> <20060114112950.GA2571@ucw.cz> <200601141319.53573.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750717AbWANRn5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200601141319.53573.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

> > > to read the value.  However, afterwards I'd have to rescale that value
> > > to megs for swsusp_shrink_memory().  It's just easier to pass the value
> > > in megs using the last argument of ioctl() directly (which is consistent
> > > with the /sys/power/image_size thing, BTW).
> > 
> > Well, I'd be inclined to make image_size in bytes, too. Having
> > each ioctl/sys file in different units seems wrong.
> 
> I'll add these changes to the userland interface patch, then.  There won't
> be too many of them, I think.

Thanks.
									Pavel
-- 
Thanks, Sharp!
