From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/44] tools/power turbostat: extend --add option to accept /sys path
Date: Wed,  1 Mar 2017 00:27:34 -0500
Message-ID: <495c7654ccfb771d19ce1b9fbc7be21e45b14636.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34947 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdCAFjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:39:32 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Previously, the --add option could specify only an MSR.

Here is is extended so an arbitrary /sys attribute,
as specified by an absolute file path name.

sudo ./turbostat --add /sys/devices/system/cpu/cpu0/cpuidle/state5/usage

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 92 ++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 23 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 334c4c29d4b5..841f837e317f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -138,6 +138,7 @@ unsigned int has_misc_feature_control;
  * Usually truncated to 7 characters, but also handles 18 columns for raw 64-bit counters
  */
 #define	NAME_BYTES 20
+#define PATH_BYTES 128
 
 int backwards_count;
 char *progname;
@@ -213,6 +214,7 @@ enum counter_format {FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT};
 struct msr_counter {
 	unsigned int msr_num;
 	char name[NAME_BYTES];
+	char path[PATH_BYTES];
 	unsigned int width;
 	enum counter_type type;
 	enum counter_format format;
@@ -344,7 +346,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "Bzy_MHz" },
 	{ 0x0, "TSC_MHz" },
 	{ 0x0, "IRQ" },
-	{ 0x0, "SMI", 32, 0, FORMAT_DELTA, NULL},
+	{ 0x0, "SMI", "", 32, 0, FORMAT_DELTA, NULL},
 	{ 0x0, "Busy%" },
 	{ 0x0, "CPU%c1" },
 	{ 0x0, "CPU%c3" },
@@ -1308,6 +1310,51 @@ static unsigned long long rdtsc(void)
 }
 
 /*
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
+/*
+ * snapshot_sysfs_counter()
+ *
+ * return snapshot of given counter
+ */
+unsigned long long snapshot_sysfs_counter(char *path)
+{
+	FILE *fp;
+	int retval;
+	unsigned long long counter;
+
+	fp = fopen_or_die(path, "r");
+
+	retval = fscanf(fp, "%lld", &counter);
+	if (retval != 1)
+		err(1, "snapshot_sysfs_counter(%s)", path);
+
+	fclose(fp);
+
+	return counter;
+}
+
+int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp)
+{
+	if (mp->msr_num != 0) {
+		if (get_msr(cpu, mp->msr_num, counterp))
+			return -1;
+	} else {
+		*counterp = snapshot_sysfs_counter(mp->path);
+	}
+
+	return 0;
+}
+
+/*
  * get_counters(...)
  * migrate to cpu
  * acquire and record local counters for that cpu
@@ -1397,11 +1444,10 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	}
 
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
-		if (get_msr(cpu, mp->msr_num, &t->counter[i]))
+		if (get_mp(cpu, mp, &t->counter[i]))
 			return -10;
 	}
 
-
 	/* collect core counters only for 1st thread in core */
 	if (!(t->flags & CPU_IS_FIRST_THREAD_IN_CORE))
 		return 0;
@@ -1434,7 +1480,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	}
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
-		if (get_msr(cpu, mp->msr_num, &c->counter[i]))
+		if (get_mp(cpu, mp, &c->counter[i]))
 			return -10;
 	}
 
@@ -1524,7 +1570,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		p->gfx_mhz = gfx_cur_mhz;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (get_msr(cpu, mp->msr_num, &p->counter[i]))
+		if (get_mp(cpu, mp, &p->counter[i]))
 			return -10;
 	}
 
@@ -2013,16 +2059,6 @@ void free_all_buffers(void)
 	free(irqs_per_cpu);
 }
 
-/*
- * Open a file, and exit on failure
- */
-FILE *fopen_or_die(const char *path, const char *mode)
-{
-	FILE *filep = fopen(path, mode);
-	if (!filep)
-		err(1, "%s: open failed", path);
-	return filep;
-}
 
 /*
  * Parse a file containing a single int.
@@ -2581,7 +2617,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	return 1;
 }
 /*
- * SLV client has supporet for unique MSRs:
+ * SLV client has support for unique MSRs:
  *
  * MSR_CC6_DEMOTION_POLICY_CONFIG
  * MSR_MC6_DEMOTION_POLICY_CONFIG
@@ -4342,9 +4378,9 @@ void print_version() {
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-int add_counter(unsigned int msr_num, char *name, unsigned int width,
-	enum counter_scope scope, enum counter_type type,
-	enum counter_format format)
+int add_counter(unsigned int msr_num, char *path, char *name,
+	unsigned int width, enum counter_scope scope,
+	enum counter_type type, enum counter_format format)
 {
 	struct msr_counter *msrp;
 
@@ -4356,6 +4392,8 @@ int add_counter(unsigned int msr_num, char *name, unsigned int width,
 
 	msrp->msr_num = msr_num;
 	strncpy(msrp->name, name, NAME_BYTES);
+	if (path)
+		strncpy(msrp->path, path, PATH_BYTES);
 	msrp->width = width;
 	msrp->type = type;
 	msrp->format = format;
@@ -4402,6 +4440,7 @@ int add_counter(unsigned int msr_num, char *name, unsigned int width,
 void parse_add_command(char *add_command)
 {
 	int msr_num = 0;
+	char *path = NULL;
 	char name_buffer[NAME_BYTES] = "";
 	int width = 64;
 	int fail = 0;
@@ -4417,6 +4456,11 @@ void parse_add_command(char *add_command)
 		if (sscanf(add_command, "msr%d", &msr_num) == 1)
 			goto next;
 
+		if (*add_command == '/') {
+			path = add_command;
+			goto next;
+		}
+
 		if (sscanf(add_command, "u%d", &width) == 1) {
 			if ((width == 32) || (width == 64))
 				goto next;
@@ -4466,12 +4510,14 @@ void parse_add_command(char *add_command)
 
 next:
 		add_command = strchr(add_command, ',');
-		if (add_command)
+		if (add_command) {
+			*add_command = '\0';
 			add_command++;
+		}
 
 	}
-	if (msr_num == 0) {
-		fprintf(stderr, "--add: (msrDDD | msr0xXXX) required\n");
+	if ((msr_num == 0) && (path == NULL)) {
+		fprintf(stderr, "--add: (msrDDD | msr0xXXX | /path_to_counter ) required\n");
 		fail++;
 	}
 
@@ -4495,7 +4541,7 @@ void parse_add_command(char *add_command)
 		}
 	}
 
-	if (add_counter(msr_num, name_buffer, width, scope, type, format))
+	if (add_counter(msr_num, path, name_buffer, width, scope, type, format))
 		fail++;
 
 	if (fail) {
-- 
2.11.0.161.g6610af872
