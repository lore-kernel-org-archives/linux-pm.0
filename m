Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128558;
	b=R7iwu+1ufJPW0mf0rQsvJPTtC4w5BGOVdmODiqfazd2OefiCTsdPlTPgLpjF0+4AKiY9
	 m53BG83l/iCIph8VZH7PTZrAmqV3OMuDj1UCKIGAwMoq66Kj8miQHQG/DyISLCyeo+mFD
	 WrtPzqUA7vXZTVAuC0Uc1dPsNCxZ0wMENwnbOCUKUokWCSP20kswjvhzFEJ1CJipFEGYd
	 LSfuiRvov5qyigzpNIFwuu0RtPRPpLzCtGi8rQa8GZYAG/XfWNlvfa7cdme1ZSKRFUSlD
	 y4j25tCJzUO+RBehnb7MQ/g6GSUh2tFdHy/25VhIHElm0/py+iLHGY/yHvlPp+zq9JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=IFuhL2k1RKVhokBiBwYm161DVxxuEYLh75jZQDM+pyw=;
	b=RGdxnRVZtW9DzF36YXpOLiFv3BhQ5u/K4mqe+k8v2xmNyNAyEZvA9xINE3KWohGOZ8JJ
	 THgH10/7sQXXIN4ALNYAGhQeiddX0Rotgmcx/SW93SV/L3ebg29MSEpghpttKsk2sP5Tf
	 bUdh2wZegd5Gs9E8QZum8HlvAGux2IA5nNyxcGchSZmWPgqQlN25ew0stiCPiHTE6jQKn
	 o5nbNJVgM43xyJA3eJXbXL8c4ERm86e56UiQVBv600W9QSafy6+3D2O1AMxJ1M7vrTstD
	 U9Yb7RWYZVSBAV6F6QSJILBZiMg3u18WVDQ1IDGHHbsaG8SYpm4CU6tVTLQ2Yg2cDIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byRaEva8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAFC606A31A
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byRaEva8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DCC1F01825;
	Tue, 27 Oct 2026 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128557;
	bh=IFuhL2k1RKVhokBiBwYm161DVxxuEYLh75jZQDM+pyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=byRaEva8emNW1plHHldhnni2/id6KdDQueUFgYSR3e1tMSOSIhnRxHYSLMlIE0uo0
	 8oRwEzwQBn3NwPAu3kwZRdxM2wSDvIA7bXASSPqYycjY4VCED5yIm6xM3+oIIvUJBO
	 MYdDWe6GsCtXC77fBIJ2uKZeEAwd++rK15uup3Ww3HYVrEcd74TiD4ymCYD6eFDhcb
	 vjnpXUvYw+ouX2sevRRnqC4/s2jpRSWFzi9n3klj1vG0OsvhTc8MkzKGzIAjrH0pJ0
	 F8sl1QXy1zdXF4c7S8TeTHp/7LlY3FWxXGfrMufFMkDT1Ok976P7kRutltbEo6w871
	 N9GIxlf7T0I1Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 01/16] x86_energy_perf_policy: Rewrite Linux/Android MSR path discovery
Date: Tue, 27 Oct 2026 15:01:55 -0400
Message-ID: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261027191550.369122-1-lenb@kernel.org>
References: <20261027191550.369122-1-lenb@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

First check that the Linux MSR driver path exists, modprobe if no.
If still no, then check that the Android MSR driver path exists.

Read or Write permissions are handled at run-time
in the get_msr()/put_msr() error paths.

Create set_msr_path() helper.

Return -1 for all fatal errors.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 73 ++++++++++++-------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 0dc959e30076..8a15093a485e 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include <sched.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <sys/resource.h>
 #include <getopt.h>
 #include <err.h>
@@ -98,6 +99,7 @@ unsigned char update_platform_profile;
 int soc_slider_balance;
 int soc_slider_offset;
 char platform_profile[64];
+char msr_path[64];
 
 #define PATH_TO_CPU "/sys/devices/system/cpu/"
 #define SYSFS_PATH_MAX 255
@@ -799,21 +801,32 @@ void err_on_hypervisor(void)
 		err(-1, "not supported on this virtual machine");
 }
 
+/*
+ * if (use_android_msr_path)
+ *	msr_path = /dev/msr%d	// Android
+ * else
+ *	msr_path = /dev/cpu/%d/msr	// Linux
+ */
+static void set_msr_path(int cpu)
+{
+	if (snprintf(msr_path, sizeof(msr_path), use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", cpu) >= (int)sizeof(msr_path))
+		err(-1, "MSR path buffer overflow for cpu%d", cpu);
+}
+
 int get_msr(int cpu, int offset, unsigned long long *msr)
 {
 	int retval;
-	char pathname[32];
 	int fd;
 
-	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", cpu);
-	fd = open(pathname, O_RDONLY);
+	set_msr_path(cpu);
+	fd = open(msr_path, O_RDONLY);
 	if (fd < 0)
-		err(-1, "%s open failed, try chown or chmod +r %s, or run as root", pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
+		err(-1, "%s open failed, try chown or chmod +r, or run as root", msr_path);
 
 	retval = pread(fd, msr, sizeof(*msr), offset);
 	if (retval != sizeof(*msr)) {
 		err_on_hypervisor();
-		err(-1, "%s offset 0x%llx read failed", pathname, (unsigned long long)offset);
+		err(-1, "%s offset 0x%llx read failed", msr_path, (unsigned long long)offset);
 	}
 
 	if (debug > 1)
@@ -825,14 +838,13 @@ int get_msr(int cpu, int offset, unsigned long long *msr)
 
 int put_msr(int cpu, int offset, unsigned long long new_msr)
 {
-	char pathname[32];
 	int retval;
 	int fd;
 
-	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", cpu);
-	fd = open(pathname, O_RDWR);
+	set_msr_path(cpu);
+	fd = open(msr_path, O_RDWR);
 	if (fd < 0)
-		err(-1, "%s open failed, try chown or chmod +r %s, or run as root", pathname, use_android_msr_path ? "/dev/msr*" : "/dev/cpu/*/msr");
+		err(-1, "%s open failed, try chown or chmod +w, or run as root", msr_path);
 
 	retval = pwrite(fd, &new_msr, sizeof(new_msr), offset);
 	if (retval != sizeof(new_msr))
@@ -1601,32 +1613,41 @@ void set_base_cpu(void)
 		err(-ENODEV, "No valid cpus found");
 }
 
-static void probe_android_msr_path(void)
+/* return 0 if path exists */
+static int check_msr_path(void)
 {
 	struct stat sb;
-	char test_path[32];
 
-	sprintf(test_path, "/dev/msr%d", base_cpu);
-	if (stat(test_path, &sb) == 0)
-		use_android_msr_path = 1;
+	return stat(msr_path, &sb);
 }
 
+/*
+ * Check Linux MSR path
+ * If it fails, try modprobe and check it again
+ * If still no joy, enable Android path and try again
+ */
 void probe_dev_msr(void)
 {
-	struct stat sb;
-	char pathname[32];
+	int retval;
 
-	probe_android_msr_path();
+	use_android_msr_path = 0;
+	set_msr_path(base_cpu);
+	if (check_msr_path() == 0)
+		return;
 
-	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", base_cpu);
-	if (stat(pathname, &sb)) {
-		if (system("/sbin/modprobe msr > /dev/null 2>&1")) {
-			if (use_android_msr_path)
-				err(-5, "no /dev/msr0, Try \"# modprobe msr\" ");
-			else
-				err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
-		}
-	}
+	retval = system("/sbin/modprobe msr > /dev/null 2>&1");
+
+	if (check_msr_path() == 0)
+		return;
+
+	use_android_msr_path = 1;
+	set_msr_path(base_cpu);
+	if (check_msr_path() == 0)
+		return;
+
+	if (WIFEXITED(retval))
+		retval = WEXITSTATUS(retval);
+	errx(-1, "\"msr\" driver support required, modprobe msr returned %d", retval);
 }
 
 static void get_cpuid_or_exit(unsigned int leaf, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
-- 
2.45.2

