From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [RFC PATCH V2] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 memory map
Date: Wed, 22 Jul 2015 16:56:31 -0700
Message-ID: <CAE9FiQVM6p0+yLj5JJ9H_tUeX6S1r-E3hMSZg+JSyguUhLDouA@mail.gmail.com>
References: <1437553748-7344-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35230 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbbGVX4c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 19:56:32 -0400
Received: by igr7 with SMTP id 7so80908946igr.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2015 16:56:31 -0700 (PDT)
In-Reply-To: <1437553748-7344-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ZhangRui <rui.zhang@intel.com>, yex.tian@intel.com

On Wed, Jul 22, 2015 at 1:29 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 reserved
> regions") was reverted, because this patch makes resume from hibernation
> on Lenovo x230 unreliable. But reverting may bring back the kernel
> exception firstly reported in former patch. In general, there are three
> problems in current code when resuming from hibernation:
>
> 1.Resuming page may also be in second kernel's e820 reserved region.
> BIOS-e820: [mem 0x0000000069d4f000-0x0000000069e12fff] reserved
> this causes kernel exception described in Commit 84c91b7ae07c
> ("PM / hibernate: avoid unsafe pages in e820 reserved regions")
>
> 2.If Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
> reserved regions") is applied to fix problem 1, and if E820_RESERVED_KERN
> regions causes some regions at e820 table not page aligned,
> e820_mark_nosave_regions will misjudgment the non-page aligned space to
> be "hole" space and add to nosave regions, this causes resuming failed.
> Refer to https://bugzilla.kernel.org/show_bug.cgi?id=96111 for detail.
>
> 3.e820 memory map inconsistence. Sometimes resuming system may have
> larger memory capacity than the one before hibernation. If a strict
> superset relationship is satisfied, it should be allowed to resume.
> For example,  use case of memory hotplug after hibernation.
>
> e820 memory map before hibernation:
> BIOS-e820: [mem 0x0000000020200000-0x0000000077517fff] usable
> BIOS-e820: [mem 0x0000000077518000-0x0000000077567fff] reserved
>
> e820 memory map during resuming:
> BIOS-e820: [mem 0x0000000020200000-0x000000007753ffff] usable
> BIOS-e820: [mem 0x0000000077540000-0x0000000077567fff] reserved
>
> This patch is based on Lee, Chun-Yi's original patch
> Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 reserved
> regions"), then treats any ajacent E820_RAM/E820_RESERVED_KERN regions
> as one region, this can prevent any non-page aligned address in
> ajacent E820_RAM/E820_RESERVED regions, from being added to nosave regions,
> thus allow system to restore the hibernation image, for example:
> three E820_RAM/E820_RESERVED_KERN regions,
> [a,b] [b+1,c] [c+1,d], should be treated as a whole:
> [a,d].
> For the bug reported at https://bugzilla.kernel.org/show_bug.cgi?id=96111
> reserve setup_data: [mem 0x000000005baff000-0x000000009d3e0017] usable
> reserve setup_data: [mem 0x000000009d3e0018-0x000000009d3f0057] usable
> reserve setup_data: [mem 0x000000009d3f0058-0x00000000d684ffff] usable
> these regions will be treated as one:
> [mem 0x000000005baff000-0x00000000d684ffff] usable.
>
> Tested-by: Tian Ye <yex.tian@intel.com>
> Tested-by: Wendy, Wang <wendy.wang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Is this same as:

https://bugzilla.opensuse.org/show_bug.cgi?id=913885

that could be fixed by:

https://lkml.org/lkml/2015/7/7/982
