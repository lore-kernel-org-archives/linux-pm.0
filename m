Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428722;
	b=YP00SuYmrGwgGbSrJSfV8gydBdU99lhvM8Sr6LvYtkFJwoYz1nlSMIvkwN0tJxryap8b
	 hlXmYcgZisyUpr85/IC/eo8vSsaZjab7OdO/NyMDxy7E2QFthT9V59lWE9XT6DkrYhwHe
	 TMmwB1F1jvEHCt645xw9PC9vKK3IjVGKcsG3fEtQ+yc9NJLPLLzHNemrgHLjNRnf+XOAL
	 j9nuf3scYfAslq2c8TqWpJ6hqxfUN4aVcLpTKxhZVcvsesAqkH0IZRzUu2++0GNTyNBkz
	 MqPTwILc+YtpEeVVb+PIFaFwLcH8cJzDCh2hsZ6PIwB+ImUFuupZlMYyaq7DQawoL2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428722;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=UpwuRUQRj+VIVkHS3piCmRiga8py2/Ri3Shy+aEwzt8=;
	b=fLaBzabPf5vPLkFquC5WhCsdo8aBKuNBAHFCfRXXuIB97Ffqvr3nCv6PbF119fsluK0h
	 v6AUowfZ8HnQE63+RMHWcaWP+IfbWwkARYcbExTUNDMYY+E4fmyFxqN9acPNw8EbPaqhb
	 ThuSsRqcn5slORQCn/e/Y+C45wMZIya0v1EcBeAzbPdCe5ooI8ulNq3XhJRsDtF260nRy
	 VOgPYY385JAwR19G9ew31639dakoHFKYjs1uugHlALyU48qcQ608ObshPr3Eelfa1C50N
	 xgbJscZIL7NdpOAZ6BTO6QYED6PqcFTGawmgT4xF2gbzMpKMMD52P7aBrbOcD3MxnOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V7nQL/m4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8709606A32C
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7nQL/m4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1CF1F000C4;
	Mon, 19 Oct 2026 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428721;
	bh=UpwuRUQRj+VIVkHS3piCmRiga8py2/Ri3Shy+aEwzt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=V7nQL/m4+Mj+Epy8RcCmU2Y52Yae+JxE4CEa9eE0468JavuM0RqX9jZtbz4maP/kZ
	 atVpbnpt/+DGzvqIMxU3BVJoilWlVzPPAzIwEEVnIRjQ2la9Ogt0cBbjahu7YgUeIg
	 5L84IxW+pkU3Xwwnb/K39BCJyqX9cwpnKRqf+7TzCSQRJUKmKvVduN/ChoK+hBvsgs
	 wtKRHmWd2DJDzLS3HSPckjg0ltZBjVvVu3h0vWW3mLgvskVJPqPlSBOavr0o6NTgb1
	 q5Y45f7HJNZqgncme2C3UoMAyIT9n6pFgM2xlpdWTnzwQ0Nyj6JTF+7TFQQjZa8j+O
	 FlLNxf7mc/rKw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 01/18] x86_energy_perf_policy: Create msr_path helper
Date: Mon, 19 Oct 2026 12:43:22 -0400
Message-ID: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261019165156.42592-1-lenb@kernel.org>
References: <20261019165156.42592-1-lenb@kernel.org>
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

Factor out code that creates msr_path[].

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 38 +++++++++++--------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 0dc959e30076..a963c0430794 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -98,6 +98,7 @@ unsigned char update_platform_profile;
 int soc_slider_balance;
 int soc_slider_offset;
 char platform_profile[64];
+char msr_path[64];
 
 #define PATH_TO_CPU "/sys/devices/system/cpu/"
 #define SYSFS_PATH_MAX 255
@@ -799,21 +800,31 @@ void err_on_hypervisor(void)
 		err(-1, "not supported on this virtual machine");
 }
 
+/*
+ * The Linux MSR driver uses offsets into /dev/cpu/{cpu#}/msr
+ * Some Android versions uses an incompatible path: /dev/msr{cpu#}
+ * Probe and prefer the Linux path, use Android if Linux does not work.
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
@@ -825,14 +836,13 @@ int get_msr(int cpu, int offset, unsigned long long *msr)
 
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
+		err(-1, "%s open failed, try chown or chmod +r, or run as root", msr_path);
 
 	retval = pwrite(fd, &new_msr, sizeof(new_msr), offset);
 	if (retval != sizeof(new_msr))
@@ -1604,22 +1614,20 @@ void set_base_cpu(void)
 static void probe_android_msr_path(void)
 {
 	struct stat sb;
-	char test_path[32];
 
-	sprintf(test_path, "/dev/msr%d", base_cpu);
-	if (stat(test_path, &sb) == 0)
+	set_msr_path(base_cpu);	/* called with use_android_path = 0, to probe Linux path */
+	if (stat(msr_path, &sb))
 		use_android_msr_path = 1;
 }
 
 void probe_dev_msr(void)
 {
 	struct stat sb;
-	char pathname[32];
 
 	probe_android_msr_path();
 
-	sprintf(pathname, use_android_msr_path ? "/dev/msr%d" : "/dev/cpu/%d/msr", base_cpu);
-	if (stat(pathname, &sb)) {
+	set_msr_path(base_cpu);
+	if (stat(msr_path, &sb)) {
 		if (system("/sbin/modprobe msr > /dev/null 2>&1")) {
 			if (use_android_msr_path)
 				err(-5, "no /dev/msr0, Try \"# modprobe msr\" ");
-- 
2.45.2

