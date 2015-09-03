From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] [v3] PM / hibernate: Fix hibernation panic caused by inconsistent e820 map
Date: Thu, 03 Sep 2015 03:19:07 +0200
Message-ID: <17819977.aDTvlCt931@vostro.rjw.lan>
References: <1441195588-31175-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46375 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755897AbbICAvZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 20:51:25 -0400
In-Reply-To: <1441195588-31175-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: len.brown@intel.com, pavel@ucw.cz, mingo@redhat.com, joeyli.kernel@gmail.com, yinghai@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, September 02, 2015 08:06:28 PM Chen Yu wrote:
> On some platforms, there is occasional panic triggered when trying to
> resume from hibernation, a typical panic looks like:
> 
> BUG: unable to handle kernel paging request at ffff880085894000
> IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70
> 
> This is because e820 map has been changed by BIOS before/after
> hibernation, and one of the page frames from first kernel
> is right located in second kernel's unmapped region, so panic
> comes out when accessing unmapped kernel address.
> 
> Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 reserved
> regions") was once introduced to fix this problem: to warn on the change
> on BIOS e820 and deny the resuming process, thus avoid the panic
> afterwards. However, this patch makes resuming from hibernation on Lenovo
> x230 failed, and the reason for it is that, this patch can not deal with
> unaligned E820_RESERVED_KERN regions and fails to resume from hibernation:
> https://bugzilla.kernel.org/show_bug.cgi?id=96111
> As a result, this patch is reverted.
> 
> To solve this hibernation panic issue fundamentally, we need to get rid of
> the impact of E820_RESERVED_KERN, so Yinghai,Lu proposes a patch to kill
> E820_RESERVED_KERN and based on his patch we can re-apply
> Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 reserved
> regions"), and stress testing has been performed on problematic platform
> with above two patches applied, it works as expected, no panic anymore.
> 
> However, there is still one thing left, hibernation might fail even after
> above two patches applied, with the following warnning in log:
> 
> PM: Image mismatch: memory size
> 
> This is also because BIOS provides different e820 memory map before/after
> hibernation, thus different memory pages, and linux regards different
> number of memory pages as invalid process and refuses to resume, in order
> to protect against data corruption. However, this check might be too
> strict, consider the following scenario:
> The hibernating system has a smaller memory capacity than the resuming
> system, and the former memory region is a subset of the latter, it should
> be allowed to resume. Here is a case for this situation:
> 
> before hibernation:
> 
> BIOS-e820: [mem 0x0000000020200000-0x0000000077517fff] usable
> BIOS-e820: [mem 0x0000000077518000-0x0000000077567fff] reserved
> Memory: 3871356K/4058428K available (7595K kernel code, 1202K rwdata,
> 3492K rodata, 1400K init, 1308K bss, 187072K reserved, 0K cma-reserved)
> 
> after hibernation:
> BIOS-e820: [mem 0x0000000020200000-0x000000007753ffff] usable
> BIOS-e820: [mem 0x0000000077540000-0x0000000077567fff] reserved
> Memory: 3871516K/4058588K available (7595K kernel code, 1202K rwdata,
> 3492K rodata, 1400K init, 1308K bss, 187072K reserved, 0K cma-reserved)
> 
> According to above data, the number of present_pages has increased by
> 40(thus 160K), linux will terminate the resuming process. But since
> [0x0000000020200000-0x0000000077517fff] is a subset of
> [0x0000000020200000-0x000000007753ffff], we should let system resume.
> 
> Since above two patches can not deal with the hibernation failor, another
> solution to fix both hibernation panic and hibernation failor is proposed
> as follows:
> We simply check that, if each non-highmem page frame to be restored is a
> valid mapped kernel page(by checking if this page is in pfn_mapped
> array in arch/x86/mm/init.c), if it is, resuming process will continue.
> In this way we do not have to touch E820_RESERVED_KERN, and we can:
> 1.prevent the hibernation panic caused by unmapped-page address
> accessing
> 2.remove the code that requires the same memory size before/after
> hibernation.
> 
> Note: for point 2, this patch only works on x86_64 platforms
> (with no highmem), because the highmem page frames on x86_32
> are not directly-mapped by kernel, which is out of the scope
> of pfn_mapped, this patch will not guarantee that whether the
> higmem region is legal for restore. A further work might include
> a logic to check if each page frame to be restored is in E820_RAM
> region, but it might require quite neat checkings in the code.
> For now, just solve the problem reported on x86_64.
> 
> After this patch applied, the panic will be replaced with the warning:
> 
> PM: Loading and decompressing image data (96092 pages)...
> PM: Image loading progress:   0%
> PM: Image loading progress:  10%
> PM: Image loading progress:  20%
> PM: Image loading progress:  30%
> PM: Image loading progress:  40%
> PM:  0x849dd000 to restored not in valid memory region
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Well, looks like an improvement, but I wouldn't be comfortable with
pushing it to Linus before it spent a fair amount of time in linux-next.

For this reason, I can queue it up for the next merge window when 4.3-rc1
is out.

Thanks,
Rafael

