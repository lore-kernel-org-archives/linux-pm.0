From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 1/3] PM / Suspend: Add support to check if platform's power
 is off in suspend
Date: Tue, 8 Jan 2019 10:56:29 +0000
Message-ID: <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support to check if platform's power will be cut off in suspend.
This will help drivers shared by multiple platforms to take only the
necessary actions while suspending/resuming (some platform may not need
to save/restore all the registers if platforms remains powered while
suspended). In this way suspend/resume time could be improved.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/linux/suspend.h |  6 ++++++
 kernel/power/suspend.c  | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 3f529ad9a9d2..21f19b167fe2 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -173,6 +173,9 @@ static inline void dpm_save_failed_step(enum suspend_st=
at_step step)
  *	Called by the PM core if the suspending of devices fails.
  *	This callback is optional and should only be implemented by platforms
  *	which require special recovery actions in that situation.
+ *
+ * @off_in_suspend: Returns wether the platform's power will be cut off at
+ *	the end of suspend procedure or not.
  */
 struct platform_suspend_ops {
 	int (*valid)(suspend_state_t state);
@@ -185,6 +188,7 @@ struct platform_suspend_ops {
 	bool (*suspend_again)(void);
 	void (*end)(void);
 	void (*recover)(void);
+	bool (*off_in_suspend)(suspend_state_t state);
 };
=20
 struct platform_s2idle_ops {
@@ -275,6 +279,7 @@ extern void arch_suspend_disable_irqs(void);
 extern void arch_suspend_enable_irqs(void);
=20
 extern int pm_suspend(suspend_state_t state);
+extern bool platform_off_in_suspend(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
=20
@@ -287,6 +292,7 @@ static inline bool pm_suspend_via_s2idle(void) { return=
 false; }
=20
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops)=
 {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
+static inline bool platform_off_in_suspend(suspend_state_t state) { return=
 false; }
 static inline bool idle_should_enter_s2idle(void) { return false; }
 static inline void __init pm_states_init(void) {}
 static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {=
}
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..e1f60c8a17b9 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -319,6 +319,19 @@ static bool platform_suspend_again(suspend_state_t sta=
te)
 		suspend_ops->suspend_again() : false;
 }
=20
+/**
+ * platform_off_in_suspend() - specifies if SoC's power will pe cut off at=
 the
+ * end of suspend procedure.
+ */
+bool platform_off_in_suspend(suspend_state_t state)
+{
+	if (!suspend_ops || !suspend_ops->off_in_suspend)
+		return false;
+
+	return suspend_ops->off_in_suspend(state);
+}
+EXPORT_SYMBOL_GPL(platform_off_in_suspend);
+
 #ifdef CONFIG_PM_DEBUG
 static unsigned int pm_test_delay =3D 5;
 module_param(pm_test_delay, uint, 0644);
--=20
2.7.4
