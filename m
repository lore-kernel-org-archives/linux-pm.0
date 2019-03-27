From: Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 1/7] sched: idle: Add sched get idle state helper
Date: Wed, 27 Mar 2019 13:21:07 +0000
Message-ID: <1553692845-20983-2-git-send-email-abel.vesa@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

This helper is useful in order to get the idle state of a specific cpu.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 include/linux/cpuidle.h |  1 +
 kernel/sched/idle.c     | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b39472..88a9119 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -211,6 +211,7 @@ static inline void cpuidle_use_deepest_state(bool enabl=
e)
=20
 /* kernel/sched/idle.c */
 extern void sched_idle_set_state(struct cpuidle_state *idle_state);
+extern struct cpuidle_state *sched_idle_get_state(int cpu);
 extern void default_idle_call(void);
=20
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f5516ba..484825d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -21,6 +21,17 @@ void sched_idle_set_state(struct cpuidle_state *idle_sta=
te)
 	idle_set_state(this_rq(), idle_state);
 }
=20
+/**
+ * sched_idle_get_state - Get idle state for the specified CPU.
+ * @index: CPU index.
+ */
+
+struct cpuidle_state *sched_idle_get_state(int cpu)
+{
+	return idle_get_state(cpu_rq(cpu));
+}
+
+
 static int __read_mostly cpu_idle_force_poll;
=20
 void cpu_idle_poll_ctrl(bool enable)
--=20
2.7.4
