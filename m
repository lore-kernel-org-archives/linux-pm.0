From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] PM / clk: Fix broken build due to non-matching code and header #ifdefs
Date: Mon, 19 Oct 2015 10:16:07 +0200
Message-ID: <1445242567-24032-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:56511 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbbJSIQM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2015 04:16:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Greg Ungerer <gerg@uclinux.org>
Cc: linux-pm@vger.kernel.org, linux-m68kvger.kernel.org@ramsan.of.borg, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If an architecture's main Kconfig file doesn't include
kernel/power/Kconfig, but CONFIG_PM=3Dy and HAVE_CLK=3Dy (e.g. m68knomm=
u
allmodconfig):

    drivers/base/power/clock_ops.c: In function =E2=80=98__pm_clk_add=E2=
=80=99:
    drivers/base/power/clock_ops.c:106: error: =E2=80=98struct pm_subsy=
s_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
    drivers/base/power/clock_ops.c: At top level:
    drivers/base/power/clock_ops.c:120: error: redefinition of =E2=80=98=
pm_clk_add=E2=80=99
    include/linux/pm_clock.h:64: error: previous definition of =E2=80=98=
pm_clk_add=E2=80=99 was here
    drivers/base/power/clock_ops.c:135: error: redefinition of =E2=80=98=
pm_clk_add_clk=E2=80=99
    include/linux/pm_clock.h:69: error: previous definition of =E2=80=98=
pm_clk_add_clk=E2=80=99 was here
    drivers/base/power/clock_ops.c:171: error: redefinition of =E2=80=98=
pm_clk_remove=E2=80=99
    include/linux/pm_clock.h:73: error: previous definition of =E2=80=98=
pm_clk_remove=E2=80=99 was here
    drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_remove=E2=
=80=99:
    drivers/base/power/clock_ops.c:180: error: =E2=80=98struct pm_subsy=
s_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
    drivers/base/power/clock_ops.c:180: error: =E2=80=98struct pm_subsy=
s_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
    drivers/base/power/clock_ops.c: At top level:
    drivers/base/power/clock_ops.c:207: error: redefinition of =E2=80=98=
pm_clk_init=E2=80=99
    include/linux/pm_clock.h:54: error: previous definition of =E2=80=98=
pm_clk_init=E2=80=99 was here
    drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_init=E2=
=80=99:
    drivers/base/power/clock_ops.c:210: error: =E2=80=98struct pm_subsy=
s_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
    drivers/base/power/clock_ops.c: At top level:
    drivers/base/power/clock_ops.c:221: error: redefinition of =E2=80=98=
pm_clk_create=E2=80=99
    include/linux/pm_clock.h:57: error: previous definition of =E2=80=98=
pm_clk_create=E2=80=99 was here
    drivers/base/power/clock_ops.c:234: error: redefinition of =E2=80=98=
pm_clk_destroy=E2=80=99
    include/linux/pm_clock.h:61: error: previous definition of =E2=80=98=
pm_clk_destroy=E2=80=99 was here
    drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_destroy=
=E2=80=99:
    drivers/base/power/clock_ops.c:246: error: =E2=80=98struct pm_subsy=
s_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
    drivers/base/power/clock_ops.c:246: error: =E2=80=98struct pm_subsy=
s_data=E2=80=99 has no member named =E2=80=98clock_list=E2=80=99
    drivers/base/power/clock_ops.c: At top level:
    drivers/base/power/clock_ops.c:263: error: expected identifier or =E2=
=80=98(=E2=80=99 before =E2=80=98void=E2=80=99
    drivers/base/power/clock_ops.c:263: error: expected =E2=80=98)=E2=80=
=99 before numeric constant
    drivers/base/power/clock_ops.c:293: error: expected identifier or =E2=
=80=98(=E2=80=99 before =E2=80=98void=E2=80=99
    drivers/base/power/clock_ops.c:293: error: expected =E2=80=98)=E2=80=
=99 before numeric constant
    drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_runtime=
_suspend=E2=80=99:
    drivers/base/power/clock_ops.c:384: error: called object =E2=80=980=
u=E2=80=99 is not a function
    drivers/base/power/clock_ops.c: In function =E2=80=98pm_clk_runtime=
_resume=E2=80=99:
    drivers/base/power/clock_ops.c:400: error: called object =E2=80=980=
u=E2=80=99 is not a function

This happens because:
  - drivers/base/power/clock_ops.c depends on CONFIG_HAVE_CLK,
  - the failing code inside clock_ops.c additionally depends on
    CONFIG_PM,
  - the forward declarations and other definitions in <linux/pm_clock.h=
>
    depend on CONFIG_PM_CLK,
  - CONFIG_PM_CLK is defined as PM && HAVE_CLK in kernel/power/Kconfig,
    but it is not included on all architectures.

=46ix this by protecting the failing code inside clock_ops.c by
CONFIG_PM_CLK instead of CONFIG_PM, so it matches <linux/pm_clock.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Probably m68knommu should start including kernel/power/Kconfig, but
this patch fixes an inconsistency anyway.

 drivers/base/power/clock_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_=
ops.c
index 652b5a367c1f37fd..fd0973b922a75086 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -17,7 +17,7 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
=20
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_CLK
=20
 enum pce_status {
 	PCE_STATUS_NONE =3D 0,
@@ -404,7 +404,7 @@ int pm_clk_runtime_resume(struct device *dev)
 	return pm_generic_runtime_resume(dev);
 }
=20
-#else /* !CONFIG_PM */
+#else /* !CONFIG_PM_CLK */
=20
 /**
  * enable_clock - Enable a device clock.
@@ -484,7 +484,7 @@ static int pm_clk_notify(struct notifier_block *nb,
 	return 0;
 }
=20
-#endif /* !CONFIG_PM */
+#endif /* !CONFIG_PM_CLK */
=20
 /**
  * pm_clk_add_notifier - Add bus type notifier for power management cl=
ocks.
--=20
1.9.1

