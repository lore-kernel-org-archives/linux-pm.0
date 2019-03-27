From: Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 2/7] cpuidle: Add cpu poke support
Date: Wed, 27 Mar 2019 13:21:09 +0000
Message-ID: <1553692845-20983-3-git-send-email-abel.vesa@nxp.com>
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

Having a poke operation per state, allows each cpuidle driver to
implement, for each state, different ways of waking up (poking) cores.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/cpuidle/cpuidle.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h   |  6 ++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f10830..fca5313 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -297,6 +297,29 @@ int cpuidle_enter_state(struct cpuidle_device *dev, st=
ruct cpuidle_driver *drv,
 }
=20
 /**
+ * cpuidle_poke_single - poke the specified cpu to wake up from
+ *		         current idle state
+ *
+ * @dev: cpuidle device for this cpu
+ * @drv: cpuidle driver for this cpu
+ * @cpu: the index of the cpu
+ */
+int cpuidle_poke_single(struct cpuidle_driver *drv, struct cpuidle_device =
*dev,
+			int cpu)
+{
+	struct cpuidle_state *state;
+
+	if (cpuidle_disabled())
+		return 0;
+
+	state =3D sched_idle_get_state(cpu);
+	if (state && state->poke)
+		return state->poke(dev, drv, cpu);
+
+	return 0;
+}
+
+/**
  * cpuidle_select - ask the cpuidle framework to choose an idle state
  *
  * @drv: the cpuidle driver
@@ -414,6 +437,17 @@ void cpuidle_resume(void)
 	mutex_unlock(&cpuidle_lock);
 }
=20
+void cpuidle_poke(const struct cpumask *mask)
+{
+	struct cpuidle_device *dev =3D cpuidle_get_device();
+	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		WARN_ON(cpuidle_poke_single(drv, dev, cpu));
+	}
+}
+
 /**
  * cpuidle_enable_device - enables idle PM for a CPU
  * @dev: the CPU
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 88a9119..0270771 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -55,6 +55,10 @@ struct cpuidle_state {
 			struct cpuidle_driver *drv,
 			int index);
=20
+	int (*poke)	(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int cpu);
+
 	int (*enter_dead) (struct cpuidle_device *dev, int index);
=20
 	/*
@@ -145,6 +149,7 @@ extern void cpuidle_unregister(struct cpuidle_driver *d=
rv);
 extern void cpuidle_pause_and_lock(void);
 extern void cpuidle_resume_and_unlock(void);
 extern void cpuidle_pause(void);
+extern void cpuidle_poke(const struct cpumask *mask);
 extern void cpuidle_resume(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
@@ -181,6 +186,7 @@ static inline void cpuidle_unregister(struct cpuidle_dr=
iver *drv) { }
 static inline void cpuidle_pause_and_lock(void) { }
 static inline void cpuidle_resume_and_unlock(void) { }
 static inline void cpuidle_pause(void) { }
+static inline void cpuidle_poke(const struct cpumask *mask) { }
 static inline void cpuidle_resume(void) { }
 static inline int cpuidle_enable_device(struct cpuidle_device *dev)
 {return -ENODEV; }
--=20
2.7.4
