From: Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 5/7] cpuidle-arm: Add ops to support poke alonside enter
Date: Wed, 27 Mar 2019 13:21:14 +0000
Message-ID: <1553692845-20983-6-git-send-email-abel.vesa@nxp.com>
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

In order to support poking alongside the enter operation,
the cpuidle_dt_ops are added. On each state initialization,
if the state has the property "local-wakeup-poke" set, then
gets to have the poking mechanims enabled. For now,
the arm_poke_idle_state doesn't do anything.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/cpuidle/cpuidle-arm.c    | 13 ++++++++++++-
 drivers/cpuidle/dt_idle_states.c | 15 ++++++++++-----
 drivers/cpuidle/dt_idle_states.h | 10 ++++++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 3a407a3..76ee7ac 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -45,6 +45,12 @@ static int arm_enter_idle_state(struct cpuidle_device *d=
ev,
 	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, idx);
 }
=20
+static int arm_poke_idle_state(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int cpu)
+{
+	return 0;
+}
+
 static struct cpuidle_driver arm_idle_driver __initdata =3D {
 	.name =3D "arm_idle",
 	.owner =3D THIS_MODULE,
@@ -65,9 +71,14 @@ static struct cpuidle_driver arm_idle_driver __initdata =
=3D {
 	}
 };
=20
+static const struct cpuidle_dt_ops cpuidle_ops =3D {
+	.enter =3D arm_enter_idle_state,
+	.poke =3D arm_poke_idle_state
+};
+
 static const struct of_device_id arm_idle_state_match[] __initconst =3D {
 	{ .compatible =3D "arm,idle-state",
-	  .data =3D arm_enter_idle_state },
+	  .data =3D &cpuidle_ops },
 	{ },
 };
=20
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_sta=
tes.c
index add9569..6490ed4 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -27,19 +27,18 @@ static int init_state_node(struct cpuidle_state *idle_s=
tate,
 {
 	int err;
 	const char *desc;
-
+	const struct cpuidle_dt_ops *ops =3D match_id->data;
 	/*
 	 * CPUidle drivers are expected to initialize the const void *data
-	 * pointer of the passed in struct of_device_id array to the idle
-	 * state enter function.
+	 * pointer of the passed in struct of_device_id array to the ops.
 	 */
-	idle_state->enter =3D match_id->data;
+	idle_state->enter =3D ops->enter;
 	/*
 	 * Since this is not a "coupled" state, it's safe to assume interrupts
 	 * won't be enabled when it exits allowing the tick to be frozen
 	 * safely. So enter() can be also enter_s2idle() callback.
 	 */
-	idle_state->enter_s2idle =3D match_id->data;
+	idle_state->enter_s2idle =3D (void *)ops->enter;
=20
 	err =3D of_property_read_u32(state_node, "wakeup-latency-us",
 				   &idle_state->exit_latency);
@@ -83,6 +82,12 @@ static int init_state_node(struct cpuidle_state *idle_st=
ate,
 	idle_state->flags =3D 0;
 	if (of_property_read_bool(state_node, "local-timer-stop"))
 		idle_state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
+
+	if (of_property_read_bool(state_node, "local-wakeup-poke")) {
+		WARN_ONCE(!ops->poke, "cpuidle driver: missing poke function\n");
+		idle_state->poke =3D ops->poke;
+	}
+
 	/*
 	 * TODO:
 	 *	replace with kstrdup and pointer assignment when name
diff --git a/drivers/cpuidle/dt_idle_states.h b/drivers/cpuidle/dt_idle_sta=
tes.h
index 14ae88c..901a40e 100644
--- a/drivers/cpuidle/dt_idle_states.h
+++ b/drivers/cpuidle/dt_idle_states.h
@@ -2,6 +2,16 @@
 #ifndef __DT_IDLE_STATES
 #define __DT_IDLE_STATES
=20
+struct cpuidle_dt_ops {
+	int (*enter)	(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int index);
+
+	int (*poke)	(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int cpu);
+};
+
 int dt_init_idle_driver(struct cpuidle_driver *drv,
 			const struct of_device_id *matches,
 			unsigned int start_idx);
--=20
2.7.4
