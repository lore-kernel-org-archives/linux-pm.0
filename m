From: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Subject: [PATCH] drivers/cpufreq: Warn user when powernow-k8 tries to fall back to acpi-cpufreq and it is unavailable.
Date: Wed, 9 Jan 2013 19:09:21 -0600
Message-ID: <1357780161-30581-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
List-Id: linux-pm@vger.kernel.org

This patch is in reference to bug#:51741. (https://bugzilla.kernel.org/show_bug.cgi?id=51741)
powernow-k8 falls back to acpi-cpufreq if CPU is not supported. However, it states that acpi-cpufreq
has taken over even if acpi-cpufreq is not compiled in. This patch rewords the warning message to
clarify that the CPU is unsupported and prints a warning message when there is no acpi-cpufreq
present.

Signed-off-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
---
 drivers/cpufreq/powernow-k8.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 056faf6..6fa58b4 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1256,7 +1256,15 @@ static int __cpuinit powernowk8_init(void)
 	int rv;
 
 	if (static_cpu_has(X86_FEATURE_HW_PSTATE)) {
-		pr_warn(PFX "this CPU is not supported anymore, using acpi-cpufreq instead.\n");
+		pr_warn(PFX
+			"this CPU is not supported anymore, use acpi-cpufreq instead"
+			"Look for message from acpi-cpufreq to ensure it is loaded."
+			".\n");
+#ifndef CONFIG_X86_ACPI_CPUFREQ
+	pr_warn(PFX "acpi-cpufreq is disabled."
+		"Enable it in the config options to get frequency scaling.\n");
+	return -ENODEV;
+#endif
 		request_module("acpi-cpufreq");
 		return -ENODEV;
 	}
-- 
1.7.10.4


