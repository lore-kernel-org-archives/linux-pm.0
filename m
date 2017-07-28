From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2] turbostat: Running on virtual machine is not supported
Date: Fri, 28 Jul 2017 07:58:18 -0400
Message-ID: <1501243098-31262-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdG1L60 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jul 2017 07:58:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

When running turbostat on a virtual machine the error

turbostat: msr 0 offset 0xe2 read failed: Input/output error

is output to the user.

/dev/msr and perf do not work on a virtual machine.  turbostat is
dependent on that support so turbostat does not work either.

When an error is returned from an msr read, turbostat must check to see if
the system is a virtual machine and return an error to the user.

[v2]: Only check for VM if msr read fails

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 tools/power/x86/turbostat/turbostat.c | 57 +++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0dafba2c1e7d..97c51bdce2ef 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -333,14 +333,58 @@ int get_msr_fd(int cpu)
 	return fd;
 }
 
+/*
+ * Open a file, and exit on failure
+ */
+FILE *fopen_or_die(const char *path, const char *mode)
+{
+	FILE *filep = fopen(path, mode);
+
+	if (!filep)
+		err(1, "%s: open failed", path);
+	return filep;
+}
+
+void err_on_hypervisor(void)
+{
+	FILE *cpuinfo;
+	char *flags, *hypervisor;
+	char *buffer;
+
+	/* On VMs /proc/cpuinfo contains a "flags" entry for hypervisor */
+	cpuinfo = fopen_or_die("/proc/cpuinfo", "ro");
+
+	buffer = malloc(4096);
+	if (!buffer)
+		err(-ENOMEM, "buffer malloc fail");
+
+	fread(buffer, 1024, 1, cpuinfo);
+
+	flags = strstr(buffer, "flags");
+	rewind(cpuinfo);
+	fseek(cpuinfo, flags - buffer, SEEK_SET);
+	fgets(buffer, 4096, cpuinfo);
+	fclose(cpuinfo);
+
+	hypervisor = strstr(buffer, "hypervisor");
+
+	free(buffer);
+
+	if (hypervisor)
+		err(-1,
+		    "turbostat is not supported on this virtual machine.");
+}
+
 int get_msr(int cpu, off_t offset, unsigned long long *msr)
 {
 	ssize_t retval;
 
 	retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
 
-	if (retval != sizeof *msr)
+	if (retval != sizeof *msr) {
+		err_on_hypervisor();
 		err(-1, "cpu%d: msr offset 0x%llx read failed", cpu, (unsigned long long)offset);
+	}
 
 	return 0;
 }
@@ -1453,17 +1497,6 @@ static unsigned long long rdtsc(void)
 }
 
 /*
- * Open a file, and exit on failure
- */
-FILE *fopen_or_die(const char *path, const char *mode)
-{
-	FILE *filep = fopen(path, mode);
-
-	if (!filep)
-		err(1, "%s: open failed", path);
-	return filep;
-}
-/*
  * snapshot_sysfs_counter()
  *
  * return snapshot of given counter
-- 
1.8.5.5
