From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Thu, 17 Sep 2015 22:43:43 +0200
Message-ID: <20150917204343.GA14658@amd>
References: <1442425343-8339-1-git-send-email-yu.c.chen@intel.com>
 <20150917060735.GF6665@amd>
 <36DF59CE26D8EE47B0655C516E9CE64026584C75@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44678 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbbIQUnp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 16:43:45 -0400
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64026584C75@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "jlee@suse.com" <jlee@suse.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "yinghai@kernel.org" <yinghai@kernel.org>, Ingo Molnar <mingo@kernel.org>

Hi!

> > > This is also because BIOS provides different e820 memory map 
> > > before/after hibernation, and linux regards it as invalid process 
> > > and refuses to resume, in order to protect against data corruption.
> > > However, this check might be too strict, consider the following scenario:
> > 
> > Well... yes, the check is strict, but why is BIOS doing that? Can you 
> > fix it instead?
> Humm, I sync with BIOS team, then  I got the answer that,  
> the e820 map is allocated dynamically each time it boots up,
> so it is poissible BIOS shows different map each time it boots up.
> Currently our BIOS team is working on it, but some problematic BIOS
> have already be released, so I think Linux should deal with this situation.

Well.. you can't really deal with the situation. That's what confuses
me. If original kernel uses memory that is "not present" now, there's
nothing you can do... but panic / fail resume.

> > >    With v3 patch applied, I did 30 cycles on my problematic platform,
> > >    no panic triggered anymore(50% reproducible before patched, by
> > >    plugging/unplugging memory peripheral during hibernation), and it
> > >    just warns of invalid pages.
> > 
> > "Just warns of invalid pages". Do you want to say that you "just cause data
> > corruption"?
> > 
> > If you don't have enough memory, YOU DON'T RESTORE. Disks were synced,
> > so not restoring is safe. Running with memory corruption is NOT.
> >
> Sorry, I do not quite understand this scenario, do you mean:
> "Without this patch , the checking of memory consistency is at a early stage,
> just before the actual pages restoring,so it's a safe time for system to determin 
> restore or terminate.
> And with this patch applied, the checking will be put off to a later stage, which
> is not safe when memory is low?"
> 
> I think in this patch, the  memory size checking has been moved 
> a little later than Its original place, the checking is still before the 
> actual  restoring image data pages:
> It happens once the last meta_page has been readed:
> prepare_image->mark_unsafe_pages  (before the actual restoing of
>    data pages)

Aha, so you should still see some failures in the testing.



> > > +	if (!swsusp_page_is_valid(pfn_to_page(pfn))) {
> > > +		pr_err(
> > > +		"PM: Hibernation failed, address %#010llx to restored not
> > valid!\n",
> > > +			(unsigned long long) pfn << PAGE_SHIFT);
> > 
> > ...and still bad english.
> > 
> Oh, will fix it: 
> PM: Hibernation failed, address %#010llx to be restored is not  valid!
> 
> Hope to hear from you, thanks!

Yes, that's better.

But I still don't like the patch.

0) BIOS is broken, and this does not completely work around it. Users
will still see the failed hibernation when the memory that is now
unavailable was actually used.

1) It allocates bm3 even on systems that don't need the workaround
(arm, ia32)

2) If you use hibernation on 32-bit kernel on affected system, you'll
still get panic.

3) I'm not sure I understand the changelog correctly. What happens
when BIOS reports less memory on hibernation? Will you magically
remove memory from kernel at runtime? Will /proc/meminfo be invalid
after resume? Will all the memory management tuning need fixing?

Changelog is really confusing. "failor" is not a english word.

After this patch applied, the panic will be replaced with the warning:

...

according to your explanation, panic will be replaced with the resume
failure, not mere warning.

I believe we have case of "this BIOS problem can not be reasonably
worked around" here.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
