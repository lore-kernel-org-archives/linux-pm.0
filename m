Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7E54707B
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178105; cv=none; b=XqsESuO6qDgh7aQ8lHy6fYlTa6cYDwI4wgo86PInn+5LNtsgKPCmolspLk/E8h5RquB6XxhPkow4LdS8yjgMZyTGErLtdSoSwfmxYRiL04ycEWUZbvX9hO4t+6bOM2fxocWex9wrwNHKVjl5mNWL9+IZSmfJh5GMIVZbm8q7/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178105; c=relaxed/simple;
	bh=AIYWRZ4YPnh9ZCVIIvCg/hpg7gMM4O8IM7/Jq8WPxCs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lDp0P/1400WY7SQqsfOUY4Y6nFZjOPZDNgTydbWA4pxJ3njx89GuoUpObhn/G3hw+4gawoVl3uQO8mist+zBHx8dEWmGvf8JvSMpc7Bjc9KnnVPZF1psahXh3hc+7Wl5IUSvREkMF4fimMfjIdX/dzTYzCbXp6VjtI6U2RvqqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4f9e7ea8bfcso150307b6e.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2026 22:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791178103; x=1791782903;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkyXZbYMCtvs8D6wKoOix7C+Vk31t3PribzbBIf6BP8=;
        b=p3f7rRgeN4XI2Ole6lp8oOMb4TnUsqe8y8hMzv274UoyNjRXIpwX5P7GdG3WyLSpjR
         2Q5wLHw/3m384ZysHETl9PqaUPqodA/xu0T3dIi3xV90B4lfjdVuA+bggL4sMw8eopzg
         HPtmSsB3zIWHCygejBnRcmK/xmzLAHNML6gPE/YqwEH5o0B4fxU5GTo9Nsq+rtFIYdNb
         N8XNYgRO0oY2F1/IayUQx54/YGJ/tKSU9VS1/w4TrZ0kIMjn5ALCtW/OfWG42xHKm6hU
         n0Mrr0zoUiG23MLIjhIIU807ZG/NELWUdscxeOK7xKM7qW5eB3Qk2jLbQdHAqZJqmBbU
         Do5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwQLhnMfP7zh1eh0+V50C4FugNItvZm0nPU7U87rL+x89NSZzmup3Uhwr68S1cHha60Ge8ynSsvRA==@vger.kernel.org
X-Gm-Message-State: AFuF++lawS+LqBPlMGJ4R8KlfnYBpx9jCAyKD3aSWjMNW5bs8AVdqH7i
	kh2Hzyxfqp2e65rDHcaKB8n4NDYAbuD7HpumRunUYZ68flLqNqDpSvLS5oz1Uj/3s+39wC+L6nU
	1vInNLzDPbo1LRT5O/tEtY9bTKE5BqIaNcPDJHnKzoKY4YZIQp4g2I2cegO8=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a1d:b0:4cb:f21b:6f8d with SMTP id
 5614622812f47-4f529d35c9amr8250049b6e.32.1791178102976; Sun, 04 Oct 2026
 22:28:22 -0700 (PDT)
Date: Sun, 04 Oct 2026 22:28:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac33576.53659fcc.25f34.0004.GAE@google.com>
Subject: [syzbot] [pm?] kernel BUG in mark_free_pages
From: syzbot <syzbot+609c80047e3e808b465c@syzkaller.appspotmail.com>
To: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6addb4f38557 Merge tag 'edac_urgent_for_v7.3_rc6' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16d3d7f5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e5acac5c98285f
dashboard link: https://syzkaller.appspot.com/bug?extid=609c80047e3e808b465c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121d2835580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161d2835580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/484fafd2304b/disk-6addb4f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a897e82997f/vmlinux-6addb4f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57fc9f6de4c3/bzImage-6addb4f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+609c80047e3e808b465c@syzkaller.appspotmail.com

Freezing user space processes
Freezing user space processes completed (elapsed 0.009 seconds)
OOM killer disabled.
PM: hibernation: Preallocating image memory
page:ffffea0005400000 is uninitialized and poisoned
page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
There is not page extension available.
------------[ cut here ]------------
kernel BUG at ./include/linux/mm.h:2402!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5632 Comm: syz-executor292 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2026
RIP: 0010:page_to_nid include/linux/mm.h:2402 [inline]
RIP: 0010:page_zone include/linux/mm.h:2622 [inline]
RIP: 0010:mark_free_pages+0x49a/0x4b0 kernel/power/snapshot.c:1266
Code: 5d e9 3a b9 44 0a e8 15 c9 22 00 90 0f 0b e8 0d fe 41 0a e8 08 c9 22 00 48 8b 7c 24 08 48 c7 c6 64 6c 48 8e e8 97 db 82 ff 90 <0f> 0b e8 ef c8 22 00 90 0f 0b e8 e7 c8 22 00 90 0f 0b 0f 1f 40 00
RSP: 0018:ffffc900035a7ad8 EFLAGS: 00010046
RAX: 26156de6b9890800 RBX: 0000000000010000 RCX: 26156de6b9890800
RDX: 0000000000000000 RSI: 8000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f6917a3 R09: 1ffffffff1ed22f4
R10: dffffc0000000000 R11: fffffbfff1ed22f5 R12: ffff88823fff8100
R13: 0000000000150000 R14: ffffffffffffffff R15: 0300000000000000
FS:  00007f23975186c0(0000) GS:ffff888124cc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe53995418 CR3: 0000000021bc3000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 count_data_pages kernel/power/snapshot.c:1417 [inline]
 hibernate_preallocate_memory+0x14f/0x750 kernel/power/snapshot.c:1859
 hibernation_snapshot+0xd5/0x3d0 kernel/power/hibernate.c:416
 hibernate+0x28f/0x680 kernel/power/hibernate.c:813
 state_store+0x234/0x290 kernel/power/main.c:821
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f23975400a9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f23975181d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f23975f0b48 RCX: 00007f23975400a9
RDX: 0000000000000005 RSI: 0000200000000100 RDI: 0000000000000003
RBP: 00007f23975f0b40 R08: 35203a6b63617473 R09: 35203a6b63617473
R10: 35203a6b63617473 R11: 0000000000000246 R12: 00007f23975c2378
R13: 0000200000000500 R14: 0000200000000600 R15: 00656e696c66666f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:page_to_nid include/linux/mm.h:2402 [inline]
RIP: 0010:page_zone include/linux/mm.h:2622 [inline]
RIP: 0010:mark_free_pages+0x49a/0x4b0 kernel/power/snapshot.c:1266
Code: 5d e9 3a b9 44 0a e8 15 c9 22 00 90 0f 0b e8 0d fe 41 0a e8 08 c9 22 00 48 8b 7c 24 08 48 c7 c6 64 6c 48 8e e8 97 db 82 ff 90 <0f> 0b e8 ef c8 22 00 90 0f 0b e8 e7 c8 22 00 90 0f 0b 0f 1f 40 00
RSP: 0018:ffffc900035a7ad8 EFLAGS: 00010046
RAX: 26156de6b9890800 RBX: 0000000000010000 RCX: 26156de6b9890800
RDX: 0000000000000000 RSI: 8000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f6917a3 R09: 1ffffffff1ed22f4
R10: dffffc0000000000 R11: fffffbfff1ed22f5 R12: ffff88823fff8100
R13: 0000000000150000 R14: ffffffffffffffff R15: 0300000000000000
FS:  00007f23975186c0(0000) GS:ffff888124cc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe53995418 CR3: 0000000021bc3000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
