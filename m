Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4A22E3F0
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791507810; cv=none; b=LaKcm4WJSpSJXJ432lbRtHGSJv75A373FH96jU8YOuYCELHwQcwHP9LESpGcmkW10rvBdGSsZ0bFKJlEb1IobLlkeh8nqzuMEduSW3+v4exSoKGMACUgMSPjEJX/InAm/IssV723XP34SuSZi8ZW00x98Si9e7oX5WcUOqBLdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791507810; c=relaxed/simple;
	bh=LjI6gaNRagmaa8C/0sDtgWX6dEFGkfcRbBzhI1hhk4w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mfg+J8pq8y/AdWb58GdgVjnvG+6WG5WnUKP04/VL+p1CbtuXbaBqzHai6QNBvL8C03/ZifhkQOKYbubownv1BG0Zm4dquP4lXnW+yOw/dFIUip5AO8S2bI1xLM54iYUmHFL5/DUXedkn+SqebGVsw0WxxmiTk9TGhPnggqkgAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-806004ec379so7244341a34.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 18:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791507808; x=1792112608;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AmPqO2czXr9TeIGlo5pSPQM87H9PwMHscwlhBR3NJF4=;
        b=QlLD8lZQ7sKECAOAYTPt+d8pWEsmkMJaEKrCNNxZOLr2/mu/oz0S5axc7CyXjE5Hxz
         9RDE0jImuVscyxgfglfOAUgAnUV4mS0i04n6lYmoDkjS8XxsPr0l70YGbmJIF/9LWZzi
         nwUvvfBXhXUdh4byvbvzqvvvg2l4iofXMAYRkf6gDr08Jvu+A9QCAu1U4GC2Wm56mfIk
         As3d9eWS1H00z7Ce9RRxJQ6g/5hmRqdNSw49HgT3GIQNUbAy8/uIbRzwFZF92ar6j41k
         Oqa8PK9/7PC4Mt9ewVehwkPPJ+OtukGJgDD4jcNd/4qYvMVXprb/ihow7BqKIeiakSPh
         74Rg==
X-Forwarded-Encrypted: i=1; AKwUvByA8MeF5EKPWxuV4vxFPsGMm0oxBj0Fcur60IR+uCb0hhVfKRzLH+TqbIFu0eDoNLINuRwEdel3pg==@vger.kernel.org
X-Gm-Message-State: AFuF++nT7Cz3ABjHwVJN5rdCK5fiRAgGazvXNjiRoSqp5JGLlLo/fZU4
	3fzeylGymIKimdulcdflJ80dKVylx5NctVQfI2CI4pKcUFaan+fttQycLHBWOxJfM33gCHd1ApX
	G2sFx7UWfUeZDXQ0TOz/TJjEHmF1LUyJ72+9uJUMx2ug/AeOhTRTDHleZ5Tc=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1903:b0:4f7:d324:bc5e with SMTP id
 5614622812f47-50c574a35f6mr301018b6e.58.1791507808274; Thu, 08 Oct 2026
 18:03:28 -0700 (PDT)
Date: Thu, 08 Oct 2026 18:03:28 -0700
In-Reply-To: <6a6b59ed.57649fcc.360844.0019.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac83d60.8cdf6287.1eb53.0040.GAE@google.com>
Subject: Re: [syzbot] [pm?] KASAN: invalid-access Read in swsusp_save
From: syzbot <syzbot+461576769f21a04b4bc0@syzkaller.appspotmail.com>
To: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0c2669a9f4a1 Merge tag 'soc-fixes-7.3-2' of git://git.kern..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=14e881d1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=644925403e5fc5f8
dashboard link: https://syzkaller.appspot.com/bug?extid=461576769f21a04b4bc0
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e881d1580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170e4671580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-0c2669a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/97ac54fdda4f/vmlinux-0c2669a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc86cb1e5945/Image-0c2669a9.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+461576769f21a04b4bc0@syzkaller.appspotmail.com

printk: Suspending console(s) (use no_console_suspend to debug)
Disabling non-boot CPUs ...
psci: CPU1 killed (polled 0 ms)
hibernate: Saved 0 MTE pages
==================================================================
BUG: KASAN: invalid-access in do_copy_page kernel/power/snapshot.c:1436 [inline]
BUG: KASAN: invalid-access in safe_copy_page kernel/power/snapshot.c:1457 [inline]
BUG: KASAN: invalid-access in copy_data_page kernel/power/snapshot.c:1508 [inline]
BUG: KASAN: invalid-access in copy_data_pages kernel/power/snapshot.c:1543 [inline]
BUG: KASAN: invalid-access in swsusp_save+0x2d4/0x5a0 kernel/power/snapshot.c:2133
Read at addr f7f0000003c1f100 by task syz.3.18/3725
Pointer tag: [f7], memory tag: [fe]

CPU: 0 UID: 0 PID: 3725 Comm: syz.3.18 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace arch/arm64/kernel/stacktrace.c:498 [inline] (C)
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x60/0x80 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x1c4/0x4b0 mm/kasan/report.c:482
 kasan_report+0x84/0xac mm/kasan/report.c:595
 report_tag_fault arch/arm64/mm/fault.c:372 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:384 [inline]
 __do_kernel_fault+0x1b4/0x220 arch/arm64/mm/fault.c:428
 do_bad_area+0x68/0x80 arch/arm64/mm/fault.c:533
 do_tag_check_fault+0x34/0x44 arch/arm64/mm/fault.c:913
 do_mem_abort+0x40/0x90 arch/arm64/mm/fault.c:989
 el1_abort+0x44/0x64 arch/arm64/kernel/entry-common.c:342
 el1h_64_sync_handler+0x50/0xac arch/arm64/kernel/entry-common.c:469
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:585
 do_copy_page kernel/power/snapshot.c:1436 [inline] (P)
 safe_copy_page kernel/power/snapshot.c:1457 [inline] (P)
 copy_data_page kernel/power/snapshot.c:1508 [inline] (P)
 copy_data_pages kernel/power/snapshot.c:1543 [inline] (P)
 swsusp_save+0x2d4/0x5a0 kernel/power/snapshot.c:2133 (P)
 swsusp_arch_suspend+0x74/0x618 arch/arm64/kernel/hibernate.c:357
 create_image kernel/power/hibernate.c:358 [inline]
 hibernation_snapshot+0x218/0x43c kernel/power/hibernate.c:442
 hibernate+0x1cc/0x3c0 kernel/power/hibernate.c:813
 state_store+0xe8/0xf4 kernel/power/main.c:821
 kobj_attr_store+0x18/0x34 lib/kobject.c:842
 sysfs_kf_write+0x7c/0x98 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x138/0x200 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x244/0x36c fs/read_write.c:687
 ksys_write+0x70/0x108 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x18/0x24 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x54/0x10c arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x1c/0x34 arch/arm64/kernel/syscall.c:140
 el0_svc+0x38/0x1fc arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:590

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43c1c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x1ffe00000000040(head|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x8)
page_type: f8(unknown)
raw: 01ffe00000000040 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 01ffe00000000040 0000000000000000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 01ffe00000000002 ffffc1ffc00f0701 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 fff0000003c1ef00: f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7
 fff0000003c1f000: f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7
>fff0000003c1f100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 fff0000003c1f200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 fff0000003c1f300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
Enabling non-boot CPUs ...
CPU1 is up
PM: Cannot find swap device, try swapon -a
PM: Cannot get swap writer
OOM killer enabled.
Restarting tasks: Starting
Restarting tasks: Done
PM: hibernation: hibernation exit


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
