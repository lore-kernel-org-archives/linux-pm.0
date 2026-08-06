Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19F3ACA64
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974437; cv=none; b=ULLxKQw3Hz/0eDShG50RHhc9t+rukHqBrZ9BQMJ3z9G/Grb2NoFLnUV9UarKjQQqw10y+c7PeOYElYASbaUZXRM+6rKH0OCg5rp6AKm6ol9K1+TxGawT9cKQdfsHD15/0RkrMqNcnciuM0Vq0PgJHo/kbgan8PN/lrMYMotoowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974437; c=relaxed/simple;
	bh=hcohk4NzbRT14PGGfBMWxdKRFk+Z0cwS1gPHlcbGaK8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aRGIZ+EDMXBCm6Jl3rYK/vWsvBhSGbjmbbKval49bwZC746LCcPPDlnIl1eSqKFYpOD+FC18ON9vS5DQwEPczrtKGbLiRNw3wTO/w7pc4RwICmeDHPi04or0gdqhDX+jR8sZ0AawzoytXKRqNK9G4ITmtilTIcmXEBImPpYy+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7e9e2db9914so503852a34.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 17:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785974434; x=1786579234;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HajvAZFk0gPgBAXqiTmSSdY8BxkppvZ2ryfU4N5QNM=;
        b=HMcBts2SaTIR0P2Xket4TUsRY0mFv2utd0OGErgYE7j8YThHQgfGxKVorj9EBLmORh
         sVq6YQlWf+9wqu9QkgKZAEkiwsDdu87zA1dgW8Ayp/wYfACYZZNQeWodUqjTHX/oUonH
         p3iNc510jakJ5vD+dYx4hT1gNwYoLyq1TNDvtEb+XPjZYJUmF3Rjr6yA17wxv6e59Pzo
         t1NJxu0tT8g8JxJdA44yGywBtzQSeU54+Sqpmsb0gEejHYSZ/kYLjDhEc4hLnX4l9l4f
         phAMMJ32+XdRGArUeUdnVeaNSsEd2ZvbZO4PD0ZxyINFZ2PQXEVeLh28sk6O2Ef3EzT5
         z8KA==
X-Forwarded-Encrypted: i=1; AHgh+RrbdBkD6I6UA3E/TX0OiMOqDdDWZoaOiWD5wAGGnpyveZXXCfoLj/2tXEdGqOeltqWciX4YG0USaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlprKSgNcVzETspLZ1OVEZMOdTErY0M+A9YyuN+1AzU0DBd82N
	TKqxA7fxlaM+fkqN0ZLOOS5NZ+/xWFeM66tBvzL1kUJC+RRYBUFOojEFa1zEjKtbn+wh7A1AvYW
	Hpkz04MKuKxWTbHNBIGcLbv6bOKrK3CjGVHYC6NstkwYcmFLelAff4BX13dA=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2215:b0:6ae:7f68:22f3 with SMTP id
 006d021491bc7-6aeb24aa301mr1600861eaf.16.1785974434448; Wed, 05 Aug 2026
 17:00:34 -0700 (PDT)
Date: Wed, 05 Aug 2026 17:00:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73cea2.01d0871a.3a0d52.000b.GAE@google.com>
Subject: [syzbot] [pm?] WARNING in __set_task_frozen
From: syzbot <syzbot+209eccd8f507de9f7f1b@syzkaller.appspotmail.com>
To: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11cd7e32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=209eccd8f507de9f7f1b
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fa93b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17dd7649580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/375d27e96ecb/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ba19a656b9d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c2a17aaee7c/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+209eccd8f507de9f7f1b@syzkaller.appspotmail.com

------------[ cut here ]------------
debug_locks && p->lockdep_depth
WARNING: kernel/freezer.c:139 at __set_task_frozen+0x260/0x340 kernel/freezer.c:139, CPU#0: syz-executor276/5646
Modules linked in:
CPU: 0 UID: 0 PID: 5646 Comm: syz-executor276 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:__set_task_frozen+0x260/0x340 kernel/freezer.c:139
Code: 00 80 00 00 89 e8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 15 09 97 09 cc e8 ef 21 15 00 90 0f 0b 90 e9 f7 fe ff ff e8 e1 21 15 00 90 <0f> 0b 90 eb 93 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c c3 fd ff ff
RSP: 0018:ffffc9000453f9f0 EFLAGS: 00010093
RAX: ffffffff81b0b75f RBX: ffff888040865d00 RCX: ffff88801eaebe00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffffff81b0b500 R12: ffff888040865d18
R13: 1ffff1100810cba3 R14: 0000000000000000 R15: ffff888040866900
FS:  0000555557b46400(0000) GS:ffff888125c3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557b577e8 CR3: 000000003c3b8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 task_call_func+0x1aa/0x260 kernel/sched/core.c:4495
 __freeze_task kernel/freezer.c:150 [inline]
 freeze_task+0x216/0x390 kernel/freezer.c:169
 try_to_freeze_tasks+0x190/0x620 kernel/power/process.c:54
 freeze_processes+0xce/0x1e0 kernel/power/process.c:137
 suspend_freeze_processes kernel/power/power.h:281 [inline]
 suspend_prepare kernel/power/suspend.c:387 [inline]
 enter_state kernel/power/suspend.c:609 [inline]
 pm_suspend+0x2f1/0x760 kernel/power/suspend.c:644
 state_store+0x206/0x290 kernel/power/main.c:819
 kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae06a8bea9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcfa30da68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007fae06a8bea9
RDX: 0000000000000003 RSI: 0000200000000200 RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000000000000a R09: 000000000000000a
R10: 000000000000000a R11: 0000000000000246 R12: 00007ffcfa30dd78
R13: 0000000000000002 R14: 0000200000000003 R15: 0000000000000000
 </TASK>


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
