Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794213953;
	b=V0szq4+CpOdyUhyZv5ypUucC1hENPtIpl2tDWOS4vB7mdzjjwHRbtZZeIPVM/51hXLD8
	 SifCEW9diDoQYUG0S+ok1RrU7FSrYg3gV4CiyaKr//yyiZX3fINVyLXlAG/CHo0Y45BbM
	 B4N/w0Rz/EL0hnNa/PiaNQZFqaA4E+4xGyMc1KA2m5eGnk3LKHRs1c4aX5QQK87yigdGr
	 6z07aEJzoeiGs23SQg5VFqbOL5g04Ha0l4WdisRLtIVHpRGoHt0jfTSHQQkM3goRQiITF
	 fYuPsU5Dqa8Zm6p5uOu5LabSUy6e/mNZT8Uo5SFMj2OZma7klnhitATwgv5wG5CDIxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=C/umt9X7ORdASGrmB2+2iI7/93OEYSlXyO9e9iBJi7k=;
	b=QQFpguL2969f0wIewZ6UTaKsJS2hJZ5ytt0yHTdvX7OPw3t/fyCjdLaBW97KU+y3lZPP
	 hfwdwq8yBWfMmPc+4I/DrH/ZH2EUnXUGk726E5JGOuy+FKVQ9gUmWYmpEQoo42OZxfecw
	 Tyg8mQr5I2l9FbRAXs3iRBF22555R7vkhVF3d7ovboBfy4QNulciKQNI+u7z0MF5EGI4G
	 EcvjZBh0nl6zcxfOZ3afXDE5Cxj/FPCKy4mdRYXOxYMGTJequLZA9K3NNLlgQI8QUOAS8
	 9HuCCoWV08/DYRY/LcYms4DjMjiUdCSCR10PUhu8ojyGDHXtHsoF1HjUh6dNvK73nAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=spicebrains.com;
	spf=none smtp.mailfrom=spicebrains.com;
	dkim=pass header.d=spicebrains-com.20260707.gappssmtp.com header.i=@spicebrains-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CVjJaCKn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B8606A322
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 08:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B15B8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spicebrains.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=spicebrains.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=spicebrains-com.20260707.gappssmtp.com header.i=@spicebrains-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CVjJaCKn
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-716ea2598eeso321162eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 00:45:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794213951; cv=none;
        d=google.com; s=arc-20260327;
        b=DS1+RRJyiFCJNhOrXnG+LGlAVa0g3lideHslOwQ0f8Yzi2QkkutxIxuVqyRvK/4K66
         2iUNX4hQO/Ycz9dbXrkhmgBlHnRHnpuJGvQipNm3huzvW+D8/lP6q7fduz68EwvVtbiv
         retEysAWW5CDtysdTGpQEctLecM0fLQ41Ra8hYPDLuSd398Gvf876VAGxjlU/MFXNHcp
         ObhTe4ouH4h06enQ+ztn/+tV5bz3BIgYdcKjwa0kO57CiIHYPsK7rL+ghZPfvvIV+iDg
         6m3h0nXLEeX1lkwSq217sij+8Gh6Ik4iEAuXH6a2W0m4Kp3osTyZ3Aa1onISnW9rYt91
         SuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=C/umt9X7ORdASGrmB2+2iI7/93OEYSlXyO9e9iBJi7k=;
        fh=iJRXRS4sewTsjtuTQ1WWGjn8sxYvb4aXt73MFBJIkrs=;
        b=BgAquwZpP79jYMOwfeeeUBHY6C11oToZ9JLOuVT3/YyWYBVuJsbgyyU7wA2iaMwr6k
         bGb+vb9N5ranlZQJ0197+g90y6Z634oNC4gFpVezhDJ1zfp+ElNN6HifmbNxh2FrD3Z6
         lA4o3/TsuYlIYHi1hWcdxBF/Y7JZJX/Fn++QaBlmb+81TjKQY6jeDHuOF7EDSWD40AMa
         Ty05zSWdRihHY6ma5Jg7Sjp077lL6fTw+6wAgMD0enl//xIiVCFCro2XvaClgGCLn0WF
         hI7WH0/LzpnMuqTFl17X4PUKR9oWUS/EdrMc/yIeLQJbB5UFTdjuXO5JpM9Zs9FJL6Ry
         o1gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spicebrains-com.20260707.gappssmtp.com; s=20260707; t=1794213951; x=1794818751; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/umt9X7ORdASGrmB2+2iI7/93OEYSlXyO9e9iBJi7k=;
        b=CVjJaCKncHv2tcOPcLxE+JezlXsAnJtQ2BhTvnX8su2ukW0ByZyESSghoLuQN1Td1q
         5U9aP0iwnY/uaOwTdwtMLr2fXbyBQmXimxUOZL/vKdGghgHVJbOZqDL6x9RYrpPWSo6K
         Cew8i9q+Y+qvvrwF/C/Zg3Ex8NLFwa+/19mOnvNZSd6BpTZw6P6fZXQT4jORKoft0whc
         3CGFNb6iaOnIqAkuKKi3XOkoU4fGAmuHGK9ak1ZT+orxpWE7gOYSbo+21PtydbB3XVZS
         s7bEpYGicoATZov3OkIYZx7OzxK3ys4rmQHaX201Pvki5hTO3H5+fFwoNAnLs0ymLHww
         tzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794213951; x=1794818751;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C/umt9X7ORdASGrmB2+2iI7/93OEYSlXyO9e9iBJi7k=;
        b=o4llrTvvDRp4qeTrmWErWzz9AJvLXkadN2Q/AehbS4ocPLF7E3B4iKQ6WNd7t20cP0
         gpLRBpu915ab6NDiB/9iZMQBtMDwV5MXk7uDqqdPbEgjdlvFnyx2yIq3cGzXmMjgcUQK
         TGDKv6cHUX5pzYpPtXaKLWKWDvee9zBRnXkIgAOPKPMzueR6fbJ2hH86gddqtdtZVxXu
         U7JMaGNP5n2G0IE109XnR2DA7PsQ+T1O+Vv52maGZzr0iIC9fYJ3+1r3M2qjS3VbFqYu
         DhVe/LUELZeKdX0DgvAlqdOCgwjpjzs1zu/UeBP2ZV76oSgfH3KNmDI2JsiRClMLFmPu
         YG2Q==
X-Forwarded-Encrypted: i=1; AL+hErGqopEJTBCWKPu9uELG1+oupLuLAN3knhl80QaAT3FrMMRkK2xcr3SbOgt6/eIxoIOHBsYoDnDt/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/D6TfVmE1zX/5cUauqG0QCwbmZDCMKnBCxAK0v8BPyqVXrADNi
	euUbu3ElPTR71aW0xkZiAOMrn00aztimPNN8uvoj1uouCZx1yuY59LQcb5InrzKbrWdQg9/PW1E
	HC/Zw6BIQcIYD8DlsrOANzc4aPcoOwrJ6iH72w71Subb4BaSafwBLxsNG5w==
X-Gm-Gg: AYBFou1JXKyUVw9753D2EYorMdRjFtIIecrc/Tmzs7svgY/oED5E0UdZex4zm5o9nyh
	4sN9vx+lpEioaMHw+yT8Kdy/CuP0+tmTAwrMgIu9jTnrBMgGeqUZwJaMm8y8b+hNv+a+PaM0J4H
	+QTzmwXi3q2w4Yv9vUn/9eXi4Ko9vlSxL52hAhh89dv4x6Uqkp7VcwLrVn1ZdnKkNu70bYsQFKc
	Kuf14nJ7NbQL6mIyHF4IrODEp7eQ7qkY1elOViNG4acZqvHMz6Xvwv7EXNJJv6Tu81j/8ZTjHZu
	dxWKcG2GS6yqTMuSDASSb+Gq2R5dfwe+/MDfo2aB4EZ471eIQqq9LkwQm26N4dqd7mlgdQMhd8v
	DcME50ixtfrqcl30HoWs8CzzfXacwSvDq8Qo3Kvg=
X-Received: by 2002:a05:6808:3208:b0:4f4:e649:b99d with SMTP id
 5614622812f47-568143f69a9mr1869305b6e.52.1794213951498; Mon, 09 Nov 2026
 00:45:51 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Konstantin Yagola <master@spicebrains.com>
Date: Mon, 9 Nov 2026 10:45:40 +0200
X-Gm-Features: AclHuK9-Jdm55-GfmJKQN5riYtXI9Vg1FpJBsI7Elqw6eLyWaXKmcJAwS5bmTSM
Message-ID: <CAPy+2=yCzFKxPgzgKw7uCfwpd0BqWk_Mf+DSBY=ydTr_pdHr9g@mail.gmail.com>
Subject: [BUG] alloc_tag: GPF in __pgalloc_tag_sub() during hibernation
 snapshot, page tag ref points into .orc_unwind_ip
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: linux-mm@kvack.org, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

my laptop sometimes fails to hibernate: the screen goes dark, the fans
keep spinning and only a forced power-off helps. It happened twice this
week on 7.3. Both times pstore caught the same crash: a GPF in
__pgalloc_tag_sub() while hibernate_preallocate_memory() reclaims
memory for the image. Both times it was the second or third hibernation
of the same boot, after successful S4 resumes. It is not every time:
one boot went through six hibernate/resume cycles without a problem.

Taint first, honestly: P (nvidia), O (openrazer) and S (CPU undervolt
via MSR). I know S makes any report suspicious, so here is why I think
this is a software bug and not random corruption:

  - RCX is fe20d545fe20d545 in BOTH crashes, byte for byte, across two
    different boots with different KASLR offsets;
  - RDX (the codetag pointer taken from the page) minus the KASLR
    offset is the same in both crashes: 0xffffffff835ac1f0;
  - in vmlinux of this build that address is inside .orc_unwind_ip,
    not an alloc_tag. The faulting code is

        mov  rcx, [rdx+0x20]    ; tag->counters
        add  gs:[rcx], rax      ; <-- GPF

    so "counters" is just ORC table bytes read as a percpu pointer.

So a page's tag reference ends up as a valid, KASLR-adjusted kernel
pointer to the wrong place. My guess is that page tag refs get out of
sync with the tags across a hibernate/resume cycle, but I have not
verified that.

Setup: Razer Blade 16 (RZ09-0483, BIOS 2.03), i9-13950HX, 32 GB RAM,
NixOS, kernel 7.3.0 (nixpkgs build, CONFIG_MEM_ALLOC_PROFILING=y,
..._ENABLED_BY_DEFAULT=y, not compressed, no _DEBUG), hibernation to a
48 GB swapfile on btrfs inside dm-crypt, /sys/power/disk = platform.

Workaround: sysctl.vm.mem_profiling=never on the command line. I cannot
reproduce this on an untainted kernel: it happens about once a week,
and with the workaround I will not see it at all. If there is something
cheaper to collect (a debug option, a printk, a check right after
resume), I am happy to run it.

Crash 1 (2026-11-09), assembled from pstore:

Oops: general protection fault, probably for non-canonical address
0xfe20646ff042c545: 0000 [#1] SMP NOPTI
CPU: 3 UID: 0 PID: 458460 Comm: systemd-sleep Tainted: P S         O
     7.3.0 #1-NixOS PREEMPT(lazy)
Tainted: [P]=PROPRIETARY_MODULE, [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
Hardware name: Razer Blade 16 - RZ09-0483/SO690, BIOS 2.03 06/04/2024
RIP: 0010:__pgalloc_tag_sub+0xcc/0x170
Code: e8 79 f4 08 00 48 85 c0 74 eb 48 03 05 9d 09 d2 01 48 8b 10 48
89 c3 48 85 d2 74 1b 44 89 f0 48 8b 4a 20 48 c1 e0 0c 48 f7 d8 <65> 48
01 01 48 8b 42 20 65 48 ff 48 08 48 c7 c7 00 19 c3 ac e8 fb
RSP: 0018:ffffcfcdc517b4d8 EFLAGS: 00010287
RAX: fffffffffffff000 RBX: ffff8f220292fbc0 RCX: fe20d545fe20d545
RDX: ffffffffac3ac1f0 RSI: 0000000000000001 RDI: 0000000002bafbc0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffff8f299ed9d260 R11: 0000000000000000 R12: fffff39ed5d7de00
R13: 0000000000000000 R14: 0000000000000001 R15: ffffcfcdc517b5e8
Call Trace:
 <TASK>
 free_unref_folios+0x18f/0x830
 shrink_folio_list+0x63e/0x1090
 evict_folios+0x154/0x5f0
 try_to_shrink_lruvec+0x132/0x260
 shrink_one+0xc0/0x1a0
 shrink_node+0xb9e/0xdd0
 do_try_to_free_pages+0xbf/0x480
 try_to_free_pages+0xf6/0x1f0
 __alloc_frozen_pages_noprof+0xa00/0x18d0
 alloc_pages_mpol+0xbc/0x180
 alloc_pages_noprof+0x3b/0x90
 alloc_image_page+0x2d/0xb0
 preallocate_image_memory+0x30/0x64
 hibernate_preallocate_memory+0x257/0x391
 hibernation_snapshot+0x9c/0x4c0
 hibernate.cold+0x10d/0x495
 state_store+0xc3/0xd0
 kernfs_fop_write_iter+0x18a/0x230
 vfs_write+0x25d/0x470
 ksys_write+0x73/0xf0
 do_syscall_64+0x114/0x5c0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x28e00000 from 0xffffffff81000000

Earlier in that boot: "ACPI: PM: Waking up from system sleep state S4"
at 28492 s, crash at 83620 s.

Crash 2 (2026-11-07): same RIP, same RCX, RDX ffffffffbc1ac1f0 with
Kernel Offset 0x38c00000 (same address after subtracting it), but this
time in kswapd0, 7 s after "PM: hibernation: hibernation entry". Two
successful S4 resumes earlier in that boot (121257 s, 192472 s).

Full pstore dumps and the vmlinux of this build are available if
useful.

Thanks, KY.
