From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps during resume
Date: Wed, 9 Aug 2006 14:10:29 +0200
Message-ID: <20060809121029.GE3747@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091204.36186.rjw@sisk.pl> <20060809114942.GS3308@elf.ucw.cz> <200608091404.56737.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161009AbWHIMKt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200608091404.56737.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > @@ -53,7 +40,7 @@ static inline void pm_restore_console(vo
> > >  static inline int software_suspend(void)
> > >  {
> > >  	printk("Warning: fake suspend called\n");
> > > -	return -EPERM;
> > > +	return -ENOSYS;
> > >  }
> > >  #endif /* CONFIG_PM */
> > >  
> > 
> > Heh, yes, it is right.. it is also totally unrelated and changes
> > userland interface ;-)))... which is probably okay here. But separate
> > would be nice.
> 
> Ah, well, that's a "btw" thing. ;-)  Will separate.

...and probably should go _before_ the hard patches.
								Pavel 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
