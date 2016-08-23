From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][v6] PM / hibernate: Print the possible panic reason when
 resuming with inconsistent e820 map
Date: Tue, 23 Aug 2016 18:01:55 +0800
Message-ID: <20160823100155.GA12738@sharon>
References: <1445404900-29702-1-git-send-email-yu.c.chen@intel.com>
 <20160823094527.GG7276@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:14992 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757434AbcHWJyL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Aug 2016 05:54:11 -0400
Content-Disposition: inline
In-Reply-To: <20160823094527.GG7276@linux-rxt1.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de, rui.zhang@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,
thanks for your interest :)
On Tue, Aug 23, 2016 at 05:45:27PM +0800, joeyli wrote:
> Hi all, 
> 
> On Wed, Oct 21, 2015 at 01:21:40PM +0800, Chen Yu wrote:
> > On some platforms, there is occasional panic triggered when trying to
> > resume from hibernation, a typical panic looks like:
> > 
> > "BUG: unable to handle kernel paging request at ffff880085894000
> > IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> > 
> > This is because e820 map has been changed by BIOS before/after
> > hibernation, and one of the page frames from first kernel
> > is right located in second kernel's unmapped region, so panic
> > comes out when accessing unmapped kernel address.
> > 
> > In order to tell the user why this happeneded, and for scalability,
> > we introduce a framework(a new file named hibernation_e820.c) to
> > compare the e820 maps before/after hibernation. If these two
> > e820 maps are not compatible with each other, we will print
> > warning about the first corrupt e820 entry's information
> > (there might be more than one broken e820 entries) once the
> > system goes into panic, for example:
> > 
> > BUG: unable to handle kernel paging request at ffff8800a9688000
> > IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70
> > PM: Hibernation Caution! Oops might be due to inconsistent e820 table.
> > PM: mem [0xa963b000-0xa963d000][ACPI Table] is an invalid old e820 region.
> > PM: Inconsistent with current [mem 0xa963b000-0xa963e000][ACPI Table].
> > PM: Please update your BIOS, or do not use hibernation on this machine.
> > 
> > The following kind of e820 entries will be regarded as invalid ones:
> > 1.E820_RAM:  old region is not a subset of any current region.
> > 2.E820_ACPI: old region is not strictly the same as any current
> >              region(example above).
> > 
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v6:
> >  - Fix some compiling errors reported by 0day/LKP, adjust
> >    Kconfig/variable namings.
> > v5:
> >  - Rewrite this patch to just warn user of the broken BIOS
> >    when panic.
> > v4:
> >  - Add __attribute__ ((unused)) for swsusp_page_is_valid,
> >    to eliminate the warnning of:
> >    'swsusp_page_is_valid' defined but not used
> >    on non-x86 platforms.
> > 
> > v3:
> >  - Adjust the logic to exclude the end_pfn boundary in pfn_mapped
> >    when invoking mark_valid_pages, because the end_pfn is not
> >    a mapped page frame, we should not regard it as a valid page.
> > 
> >    Move the sanity check of valid pages to a early stage in resuming
> >    process(moved to mark_unsafe_pages), in this way, we can avoid
> >    unnecessarily accessing these invalid pages in later stage(yes,
> >    move to the original position Joey once introduced in:
> >    Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
> >    reserved regions")
> > 
> >    With v3 patch applied, I did 30 cycles on my problematic platform,
> >    no panic triggered anymore(50% reproducible before patched, by
> >    plugging/unplugging memory peripheral during hibernation), and it
> >    just warns of invalid pages.
> >    
> > v2:
> >  - According to Ingo's suggestion, rewrite this patch.
> > 
> >    New version just checks each page frame according to pfn_mapped array.
> >    So that we do not need to touch existing code related to
> >    E820_RESERVED_KERN. And this method can naturely guarantee
> >    that the system before/after hibernation do not need to be of
> >    the same memory size on x86_64.
> 
> What's the progress of this patch? Looks already have experts review it.
> Why this patch didn't accept?
This patch is a little overkilled, and I have saved another simpler
version to only check the md5 hash (as people suggested) for it. I can post it later.

thanks,
Yu
