From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory map by md5 value
Date: Tue, 30 Aug 2016 14:04:05 +0200
Message-ID: <7552351.MYV7GZcH0A@vostro.rjw.lan>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com> <CAJZ5v0gBTjZjvS7iCKAQCvaYH-szObtExtV3B4ai4srow_kNMg@mail.gmail.com> <20160829151334.GA21313@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49674 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1758331AbcH3L6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 07:58:19 -0400
In-Reply-To: <20160829151334.GA21313@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lee@nazgul.tnic, Chun-Yi <jlee@suse.com>

On Monday, August 29, 2016 05:13:34 PM Pavel Machek wrote:
> On Mon 2016-08-29 15:41:34, Rafael J. Wysocki wrote:
> > On Mon, Aug 29, 2016 at 6:59 AM, Borislav Petkov <bp@alien8.de> wrote:
> > > On Mon, Aug 29, 2016 at 12:35:40AM +0800, Chen Yu wrote:
> > >> On some platforms, there is occasional panic triggered when trying to
> > >> resume from hibernation, a typical panic looks like:
> > >>
> > >> "BUG: unable to handle kernel paging request at ffff880085894000
> > >> IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> > >>
> > >> This is because e820 map has been changed by BIOS across
> > >> hibernation, and one of the page frames from first kernel
> > >> is right located in second kernel's unmapped region, so panic
> > >> comes out when accessing unmapped kernel address.
> > >>
> > >> In order to expose this issue earlier, the md5 hash of e820 map
> > >> is passed from suspend kernel to resume kernel, and the system will
> > >> trigger panic once it finds the md5 value of previous kernel is not
> > >> the same as current resume kernel.
> > >
> > > ... so basically now even the cases where it managed to resume would
> > > panic because the digests differ, even if the original panic condition
> > > doesn't trigger the bug, i.e. your Note 1 below.
> > >
> > > The more important question IMHO would be, can we resume our system
> > > successfully *even* if BIOS fiddled with the e820 map?
> > >
> > > We'd still warn the hell out of it and even make that the md5 digest
> > > comparison a default-enabled thing without even having a config option
> > > to disable it but can we try harder not to panic and deal with this next
> > > BIOS f*ckup more intelligently than throwing our hands in the air and
> > > giving up?
> > 
> > We need not panic in principle and I wouldn't do that.
> > 
> > I would warn and try to continue regardless (which was the original
> > plan here AFAICS), or we change a possible data loss into a guaranteed
> > one.
> > 
> > IMO it is sufficient to give up when a PFN we have image data for is
> > not pfn_valid() during resume, which we do already.
> 
> Well... can you guarantee what will be effect of resuming with
> different memory map?
> 
> Because there's big difference between panic and trying to continue
> with corrupted memory.

If all of the page frames the image kernel used before hibernation are
available during resume as well, memory won't really get corrupted, at least
not right away.

There may be problems going forward, but whether or not they actually happen
depends on what the differences are.  So while an e820 mismatch indicates that
things may go wrong, it doesn't necessarily mean that they will.

Also, that panic() may cause hibernation to stop working in a sort of hard and
nasty way where it used to work flawlessly previously and that would be a
regression, so not really acceptable.

Thanks,
Rafael

