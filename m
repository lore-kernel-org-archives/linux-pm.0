From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/16] tools/power turbostat: make fewer systems calls
Date: Sat, 27 Feb 2016 04:01:06 -0500
Message-ID: <bc7729baac558e4ba8ba63d24091fe07db2d7997.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34335 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbcB0JCE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:02:04 -0500
Received: by mail-yw0-f193.google.com with SMTP id f6so5310138ywa.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:02:04 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

skip the open(2)/close(2) on each msr read
by keeping the /dev/cpu/*/msr files open.

The remaining read(2) is generally far fewer cycles
than the removed open(2) system call.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 51 ++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ad5bd56..2e47c2b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -45,6 +45,7 @@
 
 char *proc_stat = "/proc/stat";
 FILE *outf;
+int *fd_percpu;
 struct timespec interval_ts = {5, 0};
 unsigned int debug;
 unsigned int rapl_joules;
@@ -270,23 +271,34 @@ int cpu_migrate(int cpu)
 	else
 		return 0;
 }
-
-int get_msr(int cpu, off_t offset, unsigned long long *msr)
+int get_msr_fd(int cpu)
 {
-	ssize_t retval;
 	char pathname[32];
 	int fd;
 
+	fd = fd_percpu[cpu];
+
+	if (fd)
+		return fd;
+
 	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
 	fd = open(pathname, O_RDONLY);
 	if (fd < 0)
 		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
 
-	retval = pread(fd, msr, sizeof *msr, offset);
-	close(fd);
+	fd_percpu[cpu] = fd;
+
+	return fd;
+}
+
+int get_msr(int cpu, off_t offset, unsigned long long *msr)
+{
+	ssize_t retval;
+
+	retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
 
 	if (retval != sizeof *msr)
-		err(-1, "%s offset 0x%llx read failed", pathname, (unsigned long long)offset);
+		err(-1, "msr %d offset 0x%llx read failed", cpu, (unsigned long long)offset);
 
 	return 0;
 }
@@ -1453,19 +1465,30 @@ dump_config_tdp(void)
 		fprintf(outf, "TDP_LEVEL=%d ", (unsigned int)(msr) & 0x3);
 	fprintf(outf, " lock=%d", (unsigned int)(msr >> 31) & 1);
 	fprintf(outf, ")\n");
-	
+
 	get_msr(base_cpu, MSR_TURBO_ACTIVATION_RATIO, &msr);
 	fprintf(outf, "cpu%d: MSR_TURBO_ACTIVATION_RATIO: 0x%08llx (", base_cpu, msr);
 	fprintf(outf, "MAX_NON_TURBO_RATIO=%d", (unsigned int)(msr) & 0x7F);
 	fprintf(outf, " lock=%d", (unsigned int)(msr >> 31) & 1);
 	fprintf(outf, ")\n");
 }
+void free_fd_percpu(void)
+{
+	int i;
+
+	for (i = 0; i < topo.max_cpu_num; ++i) {
+		if (fd_percpu[i] != 0)
+			close(fd_percpu[i]);
+	}
+
+	free(fd_percpu);
+}
 
 void free_all_buffers(void)
 {
 	CPU_FREE(cpu_present_set);
 	cpu_present_set = NULL;
-	cpu_present_set = 0;
+	cpu_present_setsize = 0;
 
 	CPU_FREE(cpu_affinity_set);
 	cpu_affinity_set = NULL;
@@ -1490,6 +1513,8 @@ void free_all_buffers(void)
 	free(output_buffer);
 	output_buffer = NULL;
 	outp = NULL;
+
+	free_fd_percpu();
 }
 
 /*
@@ -2449,7 +2474,7 @@ int print_thermal(struct thread_data *t, struct core_data *c, struct pkg_data *p
 
 	return 0;
 }
-	
+
 void print_power_limit_msr(int cpu, unsigned long long msr, char *label)
 {
 	fprintf(outf, "cpu%d: %s: %sabled (%f Watts, %f sec, clamp %sabled)\n",
@@ -3202,10 +3227,16 @@ void allocate_output_buffer()
 	if (outp == NULL)
 		err(-1, "calloc output buffer");
 }
-
+void allocate_fd_percpu(void)
+{
+	fd_percpu = calloc(topo.max_cpu_num, sizeof(int));
+	if (fd_percpu == NULL)
+		err(-1, "calloc fd_percpu");
+}
 void setup_all_buffers(void)
 {
 	topology_probe();
+	allocate_fd_percpu();
 	allocate_counters(&thread_even, &core_even, &package_even);
 	allocate_counters(&thread_odd, &core_odd, &package_odd);
 	allocate_output_buffer();
-- 
2.7.1.339.g0233b80

