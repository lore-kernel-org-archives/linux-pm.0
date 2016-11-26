From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/22] idle/intel: Remove superfluous SMP fuction call
Date: Sun, 27 Nov 2016 00:13:31 +0100
Message-ID: <20161126231350.10321-4-bigeasy@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161126231350.10321-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, tglx@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
hotplugged cpu") the CPU_ONLINE and CPU_DOWN_PREPARE notifiers are
always run on the hot plugged CPU, and as of commit 3b9d6da67e11
("cpu/hotplug: Fix rollback during error-out in __cpu_disable()") the
CPU_DOWN_FAILED notifier also runs on the hot plugged CPU. This patch
converts the SMP functional calls into direct calls.

smp_function_call_single() executes the function with interrupts
disabled. This calling convention is not preserved, because
tick_broadcast_enable() and tick_braodcast_disable() handle
interrupts themselves.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/idle/intel_idle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 4466a2f969d7..f53b42a78186 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -927,8 +927,7 @@ static int cpu_hotplug_notify(struct notifier_block *n,
 	case CPU_ONLINE:
=20
 		if (lapic_timer_reliable_states !=3D LAPIC_TIMER_ALWAYS_RELIABLE)
-			smp_call_function_single(hotcpu, __setup_broadcast_timer,
-						 (void *)true, 1);
+			__setup_broadcast_timer((void *)true);
=20
 		/*
 		 * Some systems can hotplug a cpu at runtime after
--=20
2.10.2
