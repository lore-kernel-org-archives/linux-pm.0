Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476897;
	b=apbSLXLAT+7iWtDiC5+rW4Xrzy6MRl5At74wZbp7+UbqcexquqvOLWeheoo9UBw6QQxO
	 mkeir8Hq/JaJiaiURmTVG4AbkGFcfGJ36Kid/drKrhViR6M6miw3HRVpnaniPohURXdb6
	 aLkLs5omhmND5ixoLcWMM8J6IxZ6gavgAINPBq2O0yh9JjOzhoU1j2VUiEWpcaFIvGc2y
	 zHAQHGToZeieQy8yu9j7dFHpdOGiQgvzXiUNIltFAFxeFnI5Le4tKoG2sMCIfB9F3zGPh
	 BJzg1RkGC+NmVHxlJqMiFhsthrsmQzO3ASBbsYTycGEbOnwl7CHihMY/bKvaKyJfvYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476897;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wkrWrfCSO0Aw1I2CW8QTg9DVaeNot/5RTAx8jWCHJxs=;
	b=bWYwc4bAVKGfoO12e7QWZWyuXYaIA+8nvTS3xS95o92c6Kak73wipI1j5rcu8xP+J1t5
	 JVWTMmkJJMNxHAC0CTL6meXdGOA/HyjRsCyrFRw6FSd5c5NBPD/0KKu26vI5OV50p3crE
	 hZ/OjCbpXbTrj8HQm4LHREog1Ex6jG0af8uct6y6KuNBBnXkKCHTqIaHknDZpaNCXBDfH
	 oV8/O4aijsWBjeBDTPD3tjQ9RLar20X9eZlVezckTZqWGG1YvaCdtIsq/s+ttCB2D7+xg
	 3RBn4RZsr9wNj92V98YK7leibNe0wSXNwZUTIgIxRmsYkecs+CIUtk44Wd5U+l36/aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r4AZbjvV;
	arc=none smtp.remote-ip=95.215.58.75
Received: from mta1.migadu.com (out-75.mta1.migadu.com [95.215.58.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE04606A327
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 09:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFE04606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r4AZbjvV
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wkrWrfCSO0Aw1I2CW8QTg9DVaeNot/5RTAx8jWCHJxs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794476894; v=1; x=1795081694;
 b=r4AZbjvV0E9i2FBpqS64xupVfHp/F/l06JO8qkcXV577W0kkdOo6TNNY//SLge2/zM/C0YtF
 QxS2IykLrBmb634GozuZly3e4Juq9ckdpsA53AgsOJ4fIUrR26RBeJq8EuuOdGivwVIFVRV228U
 bbP4P5qSaqopx7tYtpx286Zk=
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ae0cc7bf42fa743d;
	Thu, 12 Nov 2026 09:48:14 +0000
X-Mizu-Trace-ID: ae0cc7bf42fa743d
X-Migadu-Flow: FLOW_OUT
Message-ID: <fc81dd0f-4bc7-4064-97de-3b1af8c529b7@linux.dev>
Date: Thu, 12 Nov 2026 17:49:45 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hao Ge <hao.ge@linux.dev>
Subject: Re: [BUG] alloc_tag: GPF in __pgalloc_tag_sub() during hibernation
 snapshot, page tag ref points into .orc_unwind_ip
To: Konstantin Yagola <master@spicebrains.com>
Cc: linux-mm@kvack.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
References: <CAPy+2=yCzFKxPgzgKw7uCfwpd0BqWk_Mf+DSBY=ydTr_pdHr9g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPy+2=yCzFKxPgzgKw7uCfwpd0BqWk_Mf+DSBY=ydTr_pdHr9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Konstantin

On 2026/11/9 16:45, Konstantin Yagola wrote:
> Hi,
>
> my laptop sometimes fails to hibernate: the screen goes dark, the fans
> keep spinning and only a forced power-off helps. It happened twice this
> week on 7.3. Both times pstore caught the same crash: a GPF in
> __pgalloc_tag_sub() while hibernate_preallocate_memory() reclaims
> memory for the image. Both times it was the second or third hibernation
> of the same boot, after successful S4 resumes. It is not every time:
> one boot went through six hibernate/resume cycles without a problem.
>
> Taint first, honestly: P (nvidia), O (openrazer) and S (CPU undervolt
> via MSR). I know S makes any report suspicious, so here is why I think
> this is a software bug and not random corruption:
>
>  - RCX is fe20d545fe20d545 in BOTH crashes, byte for byte, across two
>    different boots with different KASLR offsets;
>  - RDX (the codetag pointer taken from the page) minus the KASLR
>    offset is the same in both crashes: 0xffffffff835ac1f0;
>  - in vmlinux of this build that address is inside .orc_unwind_ip,
>    not an alloc_tag. The faulting code is
>
>        mov  rcx, [rdx+0x20]    ; tag->counters
>        add  gs:[rcx], rax      ; <-- GPF
>
>    so "counters" is just ORC table bytes read as a percpu pointer.
>
> So a page's tag reference ends up as a valid, KASLR-adjusted kernel
> pointer to the wrong place. My guess is that page tag refs get out of
> sync with the tags across a hibernate/resume cycle, but I have not
> verified that.
>
> Setup: Razer Blade 16 (RZ09-0483, BIOS 2.03), i9-13950HX, 32 GB RAM,
> NixOS, kernel 7.3.0 (nixpkgs build, CONFIG_MEM_ALLOC_PROFILING=y,
> ..._ENABLED_BY_DEFAULT=y, not compressed, no _DEBUG), hibernation to a
> 48 GB swapfile on btrfs inside dm-crypt, /sys/power/disk = platform.

Thanks for the excellent report and especially for the disassembly work;
Sorry for the delayed reply.

Based on your configuration, we are using page_ext mode: the codetag pointer
is stored in page_ext. page_ext is allocated via the page allocator as well.

From your disassembly analysis above, we can see the issue is triggered because
the address stored in a page_ext has been overwritten.

Where those 8 bytes live page_ext (normal pages from the buddy, GFP_ZERO'd at early
boot, before any driver loads),  layout as below:

+---------------+---------------+-------------+-------------+
|     ref(pfn1)  | ref(pfn2)      |       ...          | ref(pfn k)  |
+---------------+---------------+-------------+-------------+
|   &tag_a        | &tag_b         |                     |  &tag_k     |
+---------------+---------------+-------------+-------------+

I'm wondering whether an out-of-bounds write from an adjacent page might have clobbered it.
Are there any other clues available? Could you share where I can get the matching vmlinux,
kernel config and dmesg?

Thanks
Best Regards
Hao

>
> Workaround: sysctl.vm.mem_profiling=never on the command line. I cannot
> reproduce this on an untainted kernel: it happens about once a week,
> and with the workaround I will not see it at all. If there is something
> cheaper to collect (a debug option, a printk, a check right after
> resume), I am happy to run it.
>
> Crash 1 (2026-11-09), assembled from pstore:
>
> Oops: general protection fault, probably for non-canonical address
> 0xfe20646ff042c545: 0000 [#1] SMP NOPTI
> CPU: 3 UID: 0 PID: 458460 Comm: systemd-sleep Tainted: P S         O
>     7.3.0 #1-NixOS PREEMPT(lazy)
> Tainted: [P]=PROPRIETARY_MODULE, [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
> Hardware name: Razer Blade 16 - RZ09-0483/SO690, BIOS 2.03 06/04/2024
> RIP: 0010:__pgalloc_tag_sub+0xcc/0x170
> Code: e8 79 f4 08 00 48 85 c0 74 eb 48 03 05 9d 09 d2 01 48 8b 10 48
> 89 c3 48 85 d2 74 1b 44 89 f0 48 8b 4a 20 48 c1 e0 0c 48 f7 d8 <65> 48
> 01 01 48 8b 42 20 65 48 ff 48 08 48 c7 c7 00 19 c3 ac e8 fb
> RSP: 0018:ffffcfcdc517b4d8 EFLAGS: 00010287
> RAX: fffffffffffff000 RBX: ffff8f220292fbc0 RCX: fe20d545fe20d545
> RDX: ffffffffac3ac1f0 RSI: 0000000000000001 RDI: 0000000002bafbc0
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: ffff8f299ed9d260 R11: 0000000000000000 R12: fffff39ed5d7de00
> R13: 0000000000000000 R14: 0000000000000001 R15: ffffcfcdc517b5e8
> Call Trace:
> <TASK>
> free_unref_folios+0x18f/0x830
> shrink_folio_list+0x63e/0x1090
> evict_folios+0x154/0x5f0
> try_to_shrink_lruvec+0x132/0x260
> shrink_one+0xc0/0x1a0
> shrink_node+0xb9e/0xdd0
> do_try_to_free_pages+0xbf/0x480
> try_to_free_pages+0xf6/0x1f0
> __alloc_frozen_pages_noprof+0xa00/0x18d0
> alloc_pages_mpol+0xbc/0x180
> alloc_pages_noprof+0x3b/0x90
> alloc_image_page+0x2d/0xb0
> preallocate_image_memory+0x30/0x64
> hibernate_preallocate_memory+0x257/0x391
> hibernation_snapshot+0x9c/0x4c0
> hibernate.cold+0x10d/0x495
> state_store+0xc3/0xd0
> kernfs_fop_write_iter+0x18a/0x230
> vfs_write+0x25d/0x470
> ksys_write+0x73/0xf0
> do_syscall_64+0x114/0x5c0
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> </TASK>
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x28e00000 from 0xffffffff81000000
>
> Earlier in that boot: "ACPI: PM: Waking up from system sleep state S4"
> at 28492 s, crash at 83620 s.
>
> Crash 2 (2026-11-07): same RIP, same RCX, RDX ffffffffbc1ac1f0 with
> Kernel Offset 0x38c00000 (same address after subtracting it), but this
> time in kswapd0, 7 s after "PM: hibernation: hibernation entry". Two
> successful S4 resumes earlier in that boot (121257 s, 192472 s).
>
> Full pstore dumps and the vmlinux of this build are available if
> useful.
>
> Thanks, KY.
