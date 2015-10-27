From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 46/70] cpufreq: interactive: fix uninitialized spinlock
Date: Tue, 27 Oct 2015 18:30:34 +0100
Message-ID: <1445967059-6897-46-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Minsung Kim <ms925.kim@samsung.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Minsung Kim <ms925.kim@samsung.com>

Add missing spinlock init

Backtrace:
[<c0011ce4>] (dump_backtrace+0x0/0x10c) from [<c0662a68>] (dump_stack+0=
x18/0x1c)
 r6:00000032 r5:c0bd09ec r4:e6848000 r3:00000000
[<c0662a50>] (dump_stack+0x0/0x1c) from [<c06670b0>] (spin_dump+0x80/0x=
94)
[<c0667030>] (spin_dump+0x0/0x94) from [<c06670f0>] (spin_bug+0x2c/0x30=
)
 r5:c08f91fc r4:c0bd09ec
[<c06670c4>] (spin_bug+0x0/0x30) from [<c0245f74>] (do_raw_spin_unlock+=
0x88/0xcc)
 r5:e547bac0 r4:c0bd09ec
[<c0245eec>] (do_raw_spin_unlock+0x0/0xcc) from [<c066c9cc>] (_raw_spin=
_unlock_irqrestore+0x14/0x40)
 r5:e547bac0 r4:60000013
[<c066c9b8>] (_raw_spin_unlock_irqrestore+0x0/0x40) from [<c044b884>] (=
store_above_hispeed_delay+0x6c/0x80)
 r4:c0b4cf78 r3:00000007
[<c044b818>] (store_above_hispeed_delay+0x0/0x80) from [<c0235d24>] (ko=
bj_attr_store+0x1c/0x28)
 r7:e68ff000 r6:00000032 r5:e58137c0 r4:e61cde80
[<c0235d08>] (kobj_attr_store+0x0/0x28) from [<c0156b78>] (sysfs_write_=
file+0x104/0x184)
[<c0156a74>] (sysfs_write_file+0x0/0x184) from [<c0100680>] (vfs_write+=
0xb0/0x140)
[<c01005d0>] (vfs_write+0x0/0x140) from [<c0100900>] (sys_write+0x44/0x=
70)
 r8:00000000 r7:00000004 r6:00000032 r5:bee43c90 r4:e5600300
[<c01008bc>] (sys_write+0x0/0x70) from [<c000e400>] (ret_fast_syscall+0=
x0/0x30)
 r9:e6842000 r8:c000e584 r6:00000032 r5:bee43c90 r4:00000009

Change-Id: I80a1e0b3fecb24adba501ff44f568479deeff7fa
Signed-off-by: Minsung Kim <ms925.kim@samsung.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 9dd4d38..baf8740 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -1148,6 +1148,7 @@ static int __init cpufreq_interactive_init(void)
=20
 	spin_lock_init(&target_loads_lock);
 	spin_lock_init(&speedchange_cpumask_lock);
+	spin_lock_init(&above_hispeed_delay_lock);
 	mutex_init(&gov_lock);
 	speedchange_task =3D
 		kthread_create(cpufreq_interactive_speedchange_task, NULL,
--=20
1.7.9.5
