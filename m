From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] cpufreq/intel_pstate: Fix an annoying !CONFIG_SMP warning
Date: Fri,  3 Apr 2015 15:19:53 +0200
Message-ID: <1428067193-9608-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:37433 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbbDCNV4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 Apr 2015 09:21:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

=46rom: Borislav Petkov <bp@suse.de>

I keep seeing

  drivers/cpufreq/intel_pstate.c: In function =E2=80=98intel_pstate_ini=
t=E2=80=99:
  drivers/cpufreq/intel_pstate.c:1187:26: warning: initialization from =
incompatible pointer type
    struct cpuinfo_x86 *c =3D &boot_cpu_data;

when doing randconfig builds.

This is caused by the fact that when !CONFIG_SMP, asm/processor.h
defines cpu_info to boot_cpu_data and the local variable

  struct cpu_defaults *cpu_info

overshadows it leading to this unfortunate assignment in the
preprocessed source:

 struct cpu_defaults *boot_cpu_data;
 struct cpuinfo_x86 *c =3D &boot_cpu_data;

Rename the local variable and use static_cpu_has_safe() which alleviate=
s
the need for defining a local cpuinfo_x86 pointer.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/intel_pstate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pst=
ate.c
index 872c5772c5d3..0b883f131a73 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -31,6 +31,7 @@
 #include <asm/div64.h>
 #include <asm/msr.h>
 #include <asm/cpu_device_id.h>
+#include <asm/cpufeature.h>
=20
 #define BYT_RATIOS		0x66a
 #define BYT_VIDS		0x66b
@@ -1183,8 +1184,7 @@ static int __init intel_pstate_init(void)
 {
 	int cpu, rc =3D 0;
 	const struct x86_cpu_id *id;
-	struct cpu_defaults *cpu_info;
-	struct cpuinfo_x86 *c =3D &boot_cpu_data;
+	struct cpu_defaults *cpu_def;
=20
 	if (no_load)
 		return -ENODEV;
@@ -1200,10 +1200,10 @@ static int __init intel_pstate_init(void)
 	if (intel_pstate_platform_pwr_mgmt_exists())
 		return -ENODEV;
=20
-	cpu_info =3D (struct cpu_defaults *)id->driver_data;
+	cpu_def =3D (struct cpu_defaults *)id->driver_data;
=20
-	copy_pid_params(&cpu_info->pid_policy);
-	copy_cpu_funcs(&cpu_info->funcs);
+	copy_pid_params(&cpu_def->pid_policy);
+	copy_cpu_funcs(&cpu_def->funcs);
=20
 	if (intel_pstate_msrs_not_valid())
 		return -ENODEV;
@@ -1214,7 +1214,7 @@ static int __init intel_pstate_init(void)
 	if (!all_cpu_data)
 		return -ENOMEM;
=20
-	if (cpu_has(c,X86_FEATURE_HWP) && !no_hwp)
+	if (static_cpu_has_safe(X86_FEATURE_HWP) && !no_hwp)
 		intel_pstate_hwp_enable();
=20
 	if (!hwp_active && hwp_only)
--=20
2.3.3

