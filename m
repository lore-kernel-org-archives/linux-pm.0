Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DB1519B4
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688330; cv=none; b=CumSimX37OUjWXLZVbSAQTPrN5uW1e3KADgRg2ZOqdE3eC79cr+ez62D7ihDUSk7E0btaRPQ73HSCowsOcon+ajhQmhUDanQ4lcPLyI2posEdBgEokuw07VwVFncvVkqyZOZ9tC2F5lms9hRBpATAsyJ4N5wrDFet92ONBXlx70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688330; c=relaxed/simple;
	bh=Uxd395M5No0tmeds3CebbzdYyl+spfrNZo6wL1EyNxE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MtXLyz41hCq/ZqwSZkMA7dMg1t9fE9xNarolACOb6vcjB2ahwD3qKzE5dOyz1HbzmTxt+4cWKZy8hbwFO3qR1kURw9D674Aq1nCuwW9n9LSjnZe0Bgbk9U4C9eW/xAJAdZ2HfqbeNa4BeJPuf38OOMYPTg8ufc/zAJmXKok+bGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7dcd7302f00so6702732a34.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688326; x=1779293126;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPmji9BqOQnsHVACLKL7Cn6kb40BuI/VFnSiEA244Zo=;
        b=RnMZt0ZQ+kQj9kA0e8vjdBwa4Xu0ESW3X2E8mU0fYbk8BIFfe5tg+7E/tzNhW3j21Z
         7NE0NWju55WUWQcvg1VO4JtVmxmC7XX5iDET7g/AAXknqahW5aFfsgLAxP1o7yMjYLfd
         pV/1fn9JWsNSiFGB3px78LgymttXazBFZQCqxVMrgqwz/cNXF9wKZeQAfFhWaCOICIzq
         xqpKeRAvTFPdCPKW8vHohPfOlyzCDZZBgoS1w4z/lPgnHJHdGUkrTO5IX5S7fFwOH2qZ
         iu1JbPBBME5CmV77m9hFaDfOxDPIpKuuRtFxNq0SuPWEH+RsiYwRGWgDYRFBkh9SNI9S
         xkDw==
X-Forwarded-Encrypted: i=1; AFNElJ8vLnkBA61lhIbbv0qIEhXYOO7NoSKl/dSDpDVxw1Lj81r1H7QgacExhIvt5u079+0asgci0d3P+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUeTn3QngO8vnGfyLvrOlV4OaJSiqdgpzhTiz//PUkkvkNbYx
	Q2EFJdRqg/5Zmv8NI/+PRLKOKpeIV184HBEI+xnW2tBsV+yg0Ij0QI/M+E4/fagWS/7002dX9Et
	cOAl3p8V+ncMrRtSYUC48lLXPndW5JT4CALseN/DEmwjk2/bHqUh08nRm8zw=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:6488:b0:7d7:fcac:6374 with SMTP id
 46e09a7af769-7e3da0fcacemr2190878a34.8.1778688326574; Wed, 13 May 2026
 09:05:26 -0700 (PDT)
Date: Wed, 13 May 2026 09:05:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a04a146.050a0220.54aed.0003.GAE@google.com>
Subject: [syzbot] [pm?] WARNING in complete_all (3)
From: syzbot <syzbot+7227d49ef464b1dff36d@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f2abc305aa93 riscv: Define __riscv_copy_{,vec_}{words,byte..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11732a1f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cf93e35eaea44b1
dashboard link: https://syzkaller.appspot.com/bug?extid=7227d49ef464b1dff36d
compiler:       riscv64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-f2abc305.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94904c75b810/vmlinux-f2abc305.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2195b3067ea1/Image-f2abc305.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7227d49ef464b1dff36d@syzkaller.appspotmail.com

WARNING: [] kernel/sched/completion.c:76 at complete_all+0x1d2/0x24c kernel/sched/completion.c:76, CPU#1: syz-executor/4284
Modules linked in:
CPU: 1 UID: 0 PID: 4284 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : complete_all+0x1d2/0x24c kernel/sched/completion.c:76
 ra : complete_all+0x1d2/0x24c kernel/sched/completion.c:76
epc : ffffffff802d3be2 ra : ffffffff802d3be2 sp : ffff8f800b147010
 gp : ffffffff8a24a9a0 tp : ffffaf8019989ac0 t0 : 0000000000000000
 t1 : fffff5ef03994000 t2 : ffffffff91623ec8 s0 : ffff8f800b147050
 s1 : ffffaf80339588e0 a0 : ffffaf8019989ac8 a1 : ffffffff86deaee0
 a2 : 0000000000000002 a3 : ffffffff8014e99c a4 : 0000000000000000
 a5 : 0000000000000000 a6 : fffff5ef03994001 a7 : ffffaf801cca0003
 s2 : ffffaf8072c654a8 s3 : ffffaf801998aac0 s4 : ffffffff91623ec0
 s5 : 1ffff5f00672b110 s6 : 0000000000000001 s7 : ffff8f800b1471c0
 s8 : ffff8f800b147200 s9 : 1ffff1f001628e34 s10: ffffaf801978a380
 s11: ffffaf80339580e0 t3 : ffffffff88060bc0 t4 : fffff5ef03994000
 t5 : fffff5ef03994001 t6 : 0000000000000002 ssp : 0000000000000000
status: 0000000200000120 badaddr: ffffffff802d3be2 cause: 0000000000000003
[<ffffffff802d3be2>] complete_all+0x1d2/0x24c kernel/sched/completion.c:76
[<ffffffff82c8ae64>] device_pm_sleep_init+0x8c/0x124 drivers/base/power/main.c:118
[<ffffffff82c32670>] device_pm_init drivers/base/power/power.h:168 [inline]
[<ffffffff82c32670>] device_initialize+0x200/0x4e4 drivers/base/core.c:3167
[<ffffffff8535e4f8>] netdev_register_kobject+0x28/0x32c net/core/net-sysfs.c:2324
[<ffffffff85263dbc>] register_netdevice+0x1374/0x2490 net/core/dev.c:11420
[<ffffffff832ff322>] wg_newlink+0x3aa/0x75c drivers/net/wireguard/device.c:372
[<ffffffff852a7684>] rtnl_newlink_create net/core/rtnetlink.c:3863 [inline]
[<ffffffff852a7684>] __rtnl_newlink net/core/rtnetlink.c:3994 [inline]
[<ffffffff852a7684>] rtnl_newlink+0xd74/0x2054 net/core/rtnetlink.c:4109
[<ffffffff852aa8aa>] rtnetlink_rcv_msg+0x8e2/0xd84 net/core/rtnetlink.c:6995
[<ffffffff8560bc98>] netlink_rcv_skb+0x1e8/0x394 net/netlink/af_netlink.c:2550
[<ffffffff85297852>] rtnetlink_rcv+0x26/0x30 net/core/rtnetlink.c:7022
[<ffffffff8560a0f6>] netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
[<ffffffff8560a0f6>] netlink_unicast+0x4f6/0x7c0 net/netlink/af_netlink.c:1344
[<ffffffff8560aba0>] netlink_sendmsg+0x7e0/0xd64 net/netlink/af_netlink.c:1894
[<ffffffff8517a596>] sock_sendmsg_nosec net/socket.c:787 [inline]
[<ffffffff8517a596>] __sock_sendmsg+0xca/0x160 net/socket.c:802
[<ffffffff85185400>] __sys_sendto+0x278/0x350 net/socket.c:2265
[<ffffffff85185598>] __do_sys_sendto net/socket.c:2272 [inline]
[<ffffffff85185598>] __se_sys_sendto net/socket.c:2268 [inline]
[<ffffffff85185598>] __riscv_sys_sendto+0xc0/0x158 net/socket.c:2268
[<ffffffff80078f0a>] syscall_handler+0x92/0x114 arch/riscv/include/asm/syscall.h:112
[<ffffffff8648ebf0>] do_trap_ecall_u+0x3dc/0x61c arch/riscv/kernel/traps.c:342
[<ffffffff864b9f62>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232


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
