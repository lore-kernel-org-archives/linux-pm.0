From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Mon, 29 Aug 2016 17:13:34 +0200
Message-ID: <20160829151334.GA21313@amd>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <20160829045942.GA6163@nazgul.tnic>
 <CAJZ5v0gBTjZjvS7iCKAQCvaYH-szObtExtV3B4ai4srow_kNMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41792 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbcH2PNi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2016 11:13:38 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gBTjZjvS7iCKAQCvaYH-szObtExtV3B4ai4srow_kNMg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lee@nazgul.tnic, Chun-Yi <jlee@suse.com>

On Mon 2016-08-29 15:41:34, Rafael J. Wysocki wrote:
> On Mon, Aug 29, 2016 at 6:59 AM, Borislav Petkov <bp@alien8.de> wrote:
> > On Mon, Aug 29, 2016 at 12:35:40AM +0800, Chen Yu wrote:
> >> On some platforms, there is occasional panic triggered when trying to
> >> resume from hibernation, a typical panic looks like:
> >>
> >> "BUG: unable to handle kernel paging request at ffff880085894000
> >> IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> >>
> >> This is because e820 map has been changed by BIOS across
> >> hibernation, and one of the page frames from first kernel
> >> is right located in second kernel's unmapped region, so panic
> >> comes out when accessing unmapped kernel address.
> >>
> >> In order to expose this issue earlier, the md5 hash of e820 map
> >> is passed from suspend kernel to resume kernel, and the system will
> >> trigger panic once it finds the md5 value of previous kernel is not
> >> the same as current resume kernel.
> >
> > ... so basically now even the cases where it managed to resume would
> > panic because the digests differ, even if the original panic condition
> > doesn't trigger the bug, i.e. your Note 1 below.
> >
> > The more important question IMHO would be, can we resume our system
> > successfully *even* if BIOS fiddled with the e820 map?
> >
> > We'd still warn the hell out of it and even make that the md5 digest
> > comparison a default-enabled thing without even having a config option
> > to disable it but can we try harder not to panic and deal with this next
> > BIOS f*ckup more intelligently than throwing our hands in the air and
> > giving up?
> 
> We need not panic in principle and I wouldn't do that.
> 
> I would warn and try to continue regardless (which was the original
> plan here AFAICS), or we change a possible data loss into a guaranteed
> one.
> 
> IMO it is sufficient to give up when a PFN we have image data for is
> not pfn_valid() during resume, which we do already.

Well... can you guarantee what will be effect of resuming with
different memory map?

Because there's big difference between panic and trying to continue
with corrupted memory.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
