From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Wed, 31 Aug 2016 13:03:30 +0200
Message-ID: <20160831110330.GB12296@amd>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <CAJZ5v0gBTjZjvS7iCKAQCvaYH-szObtExtV3B4ai4srow_kNMg@mail.gmail.com>
 <20160829151334.GA21313@amd>
 <7552351.MYV7GZcH0A@vostro.rjw.lan>
 <20160830195323.GA9937@amd>
 <CAJZ5v0iFub00x72-eZJT1H9Sp28wZ-VG=unfp5iTtf0tnmjHaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60784 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbcHaLDe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 07:03:34 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iFub00x72-eZJT1H9Sp28wZ-VG=unfp5iTtf0tnmjHaA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>, Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lee@nazgul.tnic, Chun-Yi <jlee@suse.com>

Hi!

> >> There may be problems going forward, but whether or not they actually happen
> >> depends on what the differences are.  So while an e820 mismatch indicates that
> >> things may go wrong, it doesn't necessarily mean that they will.
> >
> > Well "memory won't get corrupted right away" seems like good reason to
> > panic the machine ASAP.
> >
> > You can flip some bits in memory, and it may not cause problems. Still
> > if you know some bits in memory were flipped, you'd better panic the
> > machine. Continuing is unsafe.
> >
> > If you could guarantee that machine will panic down the line, and not
> > something worse, you'd be right.
> >
> > But at least the case where there is _less_ memory available after
> > resume, kernel will write into BIOS reserved memory and bad things
> > will happen. Yes, it usually panics, but it is quite clear it could
> > corrupt memory, too.
> 
> That depends a good deal on what those ranges were reserved for.
> There very well may not be anything vital in there.

Umm. Yes, you can also flip some bits in memory, and not hit anything
vital.

> >> Also, that panic() may cause hibernation to stop working in a sort of hard and
> >> nasty way where it used to work flawlessly previously and that would be a
> >> regression, so not really acceptable.
> >
> > Well, turning memory corruption bug into panic is an improvement, not
> > a regression.
> 
> Since we don't do anything about these problems today and presumably
> people use hibernation on the affected systems, there are reasons to
> think that the problem is not quite as grave as you're painting it.
> 
> But that aside, adding a panic() like in this patch isn't particularly
> useful anyway, because it panics the restore kernel.  It is sufficient
> to make arch_hibernation_header_restore() return an error to actually
> fail the resume and cause the restore kernel to discard the image.
> And that would preserve the information about the failure in the
> kernel log at least.

I don't think people are using hibernation today on affected systems
they are getting random oopses/panics, that's how this thread started.

Anyway, I agree that failing the resume is preferable to panic().

Thanks and best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
