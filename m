Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052543CEF7
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420274; cv=none; b=n3O07xmAUNng95t23fDXr/m4sAAQUZVsl/N4f/hgky8LSF8OmK4P7M0m7OatoVjzfhsIoNgDUDDdKcTcEn+FO2vms31WG14Vkqjw5fq83i+IBeqzUAy6gnUq5i/M3N7OIKdq+ACJAuol5jCJ1o/Sz3SAv69HBGAoxT9AGojeQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420274; c=relaxed/simple;
	bh=uFhwgS2vLQEmm4lBKzXFfa4rECzUW1SHhbCizBlG4TQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UirXfL1Vk2+ROV+z1H6pHXMUrafwW2GKgdLBlG0d5ay+yq/srz4B2vZLQ58t226DoLIWUp5iPJCSLIARa6A3CHCTFFXWg2bRXOobASZYPpqB9ZJnbqWCgDdUwRmjuA4QqTi1y5Z0cxMGZytV8dsPLcYV9HQnafNivAM+KWOMGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-458582a8c9fso651377fac.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 07:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420269; x=1786025069;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+OaPrjgQyiPhwmLW40a+vLrhbjAPIk0/p/m0HGMDaI=;
        b=H/MP1EwkcGfA5WlKrla9/7LXJiv50qf8KA+RameVZ7Ho3LpF+SGOQ4+SmDW831bycm
         x2B38z05YNWLHKYBdRmQFAr5f3umyF127tcIztTsaNDgRSsRRFfRravG8o8bTpuW52AU
         G+lRUZjixnz8O0flxNyT9mgbY81+Dc/yHXnxbAEyp7+vwlJiUPKQH6831wHF1rWHXdc2
         zo66qy/RjF5nkNG4Pj2sSB5ljK7PpyfC1KT/9b6aZUQOFcpi17AIjsYtfx4ItoNUyME7
         bOgQ5lIaFvseJHCAQT+bXWuF6SfChUUag1Htk6EwwY6qHWjrR4RrVeKQjFYO7uX0o9JN
         hzgw==
X-Forwarded-Encrypted: i=1; AHgh+RoWKLQazCc/zEhbmXEzMvVfNYeyht5PJt6/KwzeBue7WAgMGeUG505H126NAnftv0kWeFze4UhRZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2LXu22CzM+4QRy3177qs2Fc1ZHsazM5lrNAvKLRwfowut8HO
	FWYHos64IQzBtmM1I7j5giQ3hGOoxS6faJ7SyGu51GxsJ+Q2cltikZG+CZZ1n7m+nhHPbvVfM/o
	sjC8ytj9u8mIoPe3Fd0X7yfAySxwPQg/jnijxLXNSncxMhyv64NNPoW3g1TI=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:b22:b0:44c:b209:d716 with SMTP id
 586e51a60fabf-458c19ba5ecmr1758769fac.22.1785420269144; Thu, 30 Jul 2026
 07:04:29 -0700 (PDT)
Date: Thu, 30 Jul 2026 07:04:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6b59ed.57649fcc.360844.0019.GAE@google.com>
Subject: [syzbot] [pm?] KASAN: invalid-access Read in swsusp_save
From: syzbot <syzbot+461576769f21a04b4bc0@syzkaller.appspotmail.com>
To: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b5f4b83c4ab Merge tag 'for-7.2-rc5-tag' of git://git.kern..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=11f35632580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c49f4c107ee8924
dashboard link: https://syzkaller.appspot.com/bug?extid=461576769f21a04b4bc0
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-3b5f4b83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd359154ea98/vmlinux-3b5f4b83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ae5720d1f28/Image-3b5f4b83.gz.xz

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
BUG: KASAN: invalid-access in swsusp_save+0x2cc/0x590 kernel/power/snapshot.c:2133
Read at addr f4f000000341f100 by task syz.1.8/3536
Pointer tag: [f4], memory tag: [fe]

CPU: 0 UID: 0 PID: 3536 Comm: syz.1.8 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace arch/arm64/kernel/stacktrace.c:498 [inline] (C)
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x60/0x80 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x1c4/0x4b0 mm/kasan/report.c:482
 kasan_report+0x84/0xac mm/kasan/report.c:595
 report_tag_fault arch/arm64/mm/fault.c:368 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:380 [inline]
 __do_kernel_fault+0x1b4/0x220 arch/arm64/mm/fault.c:424
 do_bad_area+0x68/0x80 arch/arm64/mm/fault.c:529
 do_tag_check_fault+0x34/0x44 arch/arm64/mm/fault.c:909
 do_mem_abort+0x40/0x90 arch/arm64/mm/fault.c:985
 el1_abort+0x44/0x64 arch/arm64/kernel/entry-common.c:322
 el1h_64_sync_handler+0x50/0xac arch/arm64/kernel/entry-common.c:449
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:589
 do_copy_page kernel/power/snapshot.c:1436 [inline] (P)
 safe_copy_page kernel/power/snapshot.c:1457 [inline] (P)
 copy_data_page kernel/power/snapshot.c:1508 [inline] (P)
 copy_data_pages kernel/power/snapshot.c:1543 [inline] (P)
 swsusp_save+0x2cc/0x590 kernel/power/snapshot.c:2133 (P)
 swsusp_arch_suspend+0x74/0x618 arch/arm64/kernel/hibernate.c:355
 create_image kernel/power/hibernate.c:358 [inline]
 hibernation_snapshot+0x208/0x438 kernel/power/hibernate.c:442
 hibernate+0x1cc/0x3c0 kernel/power/hibernate.c:811
 state_store+0xe8/0xf4 kernel/power/main.c:821
 kobj_attr_store+0x18/0x34 lib/kobject.c:840
 sysfs_kf_write+0x7c/0x98 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x138/0x200 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x244/0x36c fs/read_write.c:687
 ksys_write+0x70/0x108 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x1c/0x30 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x54/0x10c arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x1c/0x34 arch/arm64/kernel/syscall.c:140
 el0_svc+0x38/0x1fc arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0xa0/0xf0 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:594

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4341c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x1ffec0000000040(head|node=0|zone=0|lastcpupid=0x7ff|kasantag=0xb)
page_type: f8(unknown)
raw: 01ffec0000000040 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 01ffec0000000040 0000000000000000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000f8000000 0000000000000000
head: 01ffec0000000002 ffffc1ffc00d0701 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 fff000000341ef00: f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4
 fff000000341f000: f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4 f4
>fff000000341f100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 fff000000341f200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 fff000000341f300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
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
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
