From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Thu, 17 Sep 2015 18:11:01 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64026584C75@SHSMSX101.ccr.corp.intel.com>
References: <1442425343-8339-1-git-send-email-yu.c.chen@intel.com>
 <20150917060735.GF6665@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150917060735.GF6665@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "jlee@suse.com" <jlee@suse.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "yinghai@kernel.org" <yinghai@kernel.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Pavel, thanks a lot for your time to review it!
[Since you have replied v2,v3,v4, I copy/paste them here together.]

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Thursday, September 17, 2015 2:08 PM
> To: Chen, Yu C
> Cc: rjw@rjwysocki.net; Brown, Len; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Zhang, Rui; jlee@suse.com;
> joeyli.kernel@gmail.com; yinghai@kernel.org
> Subject: Re: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
> inconsistent e820 map
> 
> > This is also because BIOS provides different e820 memory map 
> > before/after hibernation, and linux regards it as invalid process 
> > and refuses to resume, in order to protect against data corruption.
> > However, this check might be too strict, consider the following scenario:
> 
> Well... yes, the check is strict, but why is BIOS doing that? Can you 
> fix it instead?
Humm, I sync with BIOS team, then  I got the answer that,  
the e820 map is allocated dynamically each time it boots up,
so it is poissible BIOS shows different map each time it boots up.
Currently our BIOS team is working on it, but some problematic BIOS
have already be released, so I think Linux should deal with this situation.

> > According to above data, the number of present_pages has increased 
> > by 40(thus 160K), linux will terminate the resuming process. But 
> > since [0x0000000020200000-0x0000000077517fff] is a subset of 
> > [0x0000000020200000-0x000000007753ffff], we should let system resume.
> 
> Ok, complex, but will work. But what happens in the opposite case? On 
> the next boot, bios gets you 160K less....
> 
If BIOS shows less memory in second kernel, we can let it go, 
because we will check each page's legality by  
mark_unsafe_pages - > is_valid_orig_page.
So it does not matter whether memory size has changed or not.

> Can you do echo powerdown > /sys/power/disk to work around this?
Do you mean shurdown? I think it does not work neither, because when system 
does a fresh  bootup, the e820 memory map will be allocated dynamically in theory.

> >    With v3 patch applied, I did 30 cycles on my problematic platform,
> >    no panic triggered anymore(50% reproducible before patched, by
> >    plugging/unplugging memory peripheral during hibernation), and it
> >    just warns of invalid pages.
> 
> "Just warns of invalid pages". Do you want to say that you "just cause data
> corruption"?
> 
> If you don't have enough memory, YOU DON'T RESTORE. Disks were synced,
> so not restoring is safe. Running with memory corruption is NOT.
>
Sorry, I do not quite understand this scenario, do you mean:
"Without this patch , the checking of memory consistency is at a early stage,
just before the actual pages restoring,so it's a safe time for system to determin 
restore or terminate.
And with this patch applied, the checking will be put off to a later stage, which
is not safe when memory is low?"

I think in this patch, the  memory size checking has been moved 
a little later than Its original place, the checking is still before the 
actual  restoring image data pages:
It happens once the last meta_page has been readed:
prepare_image->mark_unsafe_pages  (before the actual restoing of data pages)

> > +	if (!swsusp_page_is_valid(pfn_to_page(pfn))) {
> > +		pr_err(
> > +		"PM: Hibernation failed, address %#010llx to restored not
> valid!\n",
> > +			(unsigned long long) pfn << PAGE_SHIFT);
> 
> ...and still bad english.
> 
Oh, will fix it: 
PM: Hibernation failed, address %#010llx to be restored is not  valid!

Hope to hear from you, thanks!


Best Regards,
Yu
