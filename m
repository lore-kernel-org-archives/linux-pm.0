From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Tue, 30 Aug 2016 21:53:23 +0200
Message-ID: <20160830195323.GA9937@amd>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <CAJZ5v0gBTjZjvS7iCKAQCvaYH-szObtExtV3B4ai4srow_kNMg@mail.gmail.com>
 <20160829151334.GA21313@amd>
 <7552351.MYV7GZcH0A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40190 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbcH3Tx0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 15:53:26 -0400
Content-Disposition: inline
In-Reply-To: <7552351.MYV7GZcH0A@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lee@nazgul.tnic, Chun-Yi <jlee@suse.com>


> > > I would warn and try to continue regardless (which was the original
> > > plan here AFAICS), or we change a possible data loss into a guaranteed
> > > one.
> > > 
> > > IMO it is sufficient to give up when a PFN we have image data for is
> > > not pfn_valid() during resume, which we do already.
> > 
> > Well... can you guarantee what will be effect of resuming with
> > different memory map?
> > 
> > Because there's big difference between panic and trying to continue
> > with corrupted memory.
> 
> If all of the page frames the image kernel used before hibernation are
> available during resume as well, memory won't really get corrupted, at least
> not right away.
> 
> There may be problems going forward, but whether or not they actually happen
> depends on what the differences are.  So while an e820 mismatch indicates that
> things may go wrong, it doesn't necessarily mean that they will.

Well "memory won't get corrupted right away" seems like good reason to
panic the machine ASAP.

You can flip some bits in memory, and it may not cause problems. Still
if you know some bits in memory were flipped, you'd better panic the
machine. Continuing is unsafe.

If you could guarantee that machine will panic down the line, and not
something worse, you'd be right.

But at least the case where there is _less_ memory available after
resume, kernel will write into BIOS reserved memory and bad things
will happen. Yes, it usually panics, but it is quite clear it could
corrupt memory, too.

So I believe we should take the patch, and let users update their
BIOSes. [And I believe it is not too widespread, either.]

If you want to try to cook a patch that determines if new e820 map is
superset of the old one... well... I believe the resulting complexity
will be obviously unreasonable but I guess you (or some interested
person) can try.

> Also, that panic() may cause hibernation to stop working in a sort of hard and
> nasty way where it used to work flawlessly previously and that would be a
> regression, so not really acceptable.

Well, turning memory corruption bug into panic is an improvement, not
a regression.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
