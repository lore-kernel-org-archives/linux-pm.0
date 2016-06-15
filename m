From: Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 12:00:29 +0200
Message-ID: <20160615100029.GB32588@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51066 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbcFOKAe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 06:00:34 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

Hi people,

so we've been talking about this for a long time now - how loading
msr.ko is not a good thing and how userspace shouldn't poke at random
MSRs.

So my intention is to move away users in tools/ which did write to MSRs
through the char dev and replace it with proper sysfs et al interfaces.
Once that's done, we can start tainting the kernel when writing to MSRs
from that device or even forbid it completely at some point.

We'll see.

Anyway, here's a first attempt, please scream if something's not right.
Functionality-wise, it should be equivalent as I'm exporting the
pref_hint of the IA32_ENERGY_PERF_BIAS in sysfs and it lands under

/sys/devices/system/cpu/cpu?/energy_policy_pref_hint

where anything with sufficient perms can read/write it.

Comments are, as always, appreciated.

---
From: Borislav Petkov <bp@suse.de>
Date: Wed, 15 Jun 2016 11:20:41 +0200
Subject: [PATCH] Move away from msr.ko

Take care of MSR_IA32_ENERGY_PERF_BIAS.

Not-yet-signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/Makefile                       |  1 +
 arch/x86/kernel/cpu/intel.c                        |  2 +
 arch/x86/kernel/cpu/sysfs.c                        | 55 ++++++++++++++
 drivers/base/cpu.c                                 | 28 ++++++-
 tools/power/cpupower/Makefile                      |  2 +-
 tools/power/cpupower/utils/cpupower-info.c         |  4 +-
 tools/power/cpupower/utils/cpupower-set.c          |  4 +-
 tools/power/cpupower/utils/helpers/helpers.h       |  6 --
 tools/power/cpupower/utils/helpers/msr.c           | 57 --------------
 tools/power/utils/utils.c                          | 45 +++++++++++
 tools/power/utils/utils.h                          |  7 ++
 tools/power/x86/turbostat/Makefile                 | 16 +++-
 tools/power/x86/turbostat/turbostat.c              | 11 ++-
 tools/power/x86/x86_energy_perf_policy/Makefile    |  4 +-
 .../x86_energy_perf_policy.c                       | 86 +++++-----------------
 15 files changed, 182 insertions(+), 146 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/sysfs.c
 create mode 100644 tools/power/utils/utils.c
 create mode 100644 tools/power/utils/utils.h

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 4a8697f7d4ef..d8085857a0d1 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -20,6 +20,7 @@ obj-y			:= intel_cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
+obj-y			+= sysfs.o
 
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 6e2ffbebbcdb..37d02df6803e 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -210,6 +210,8 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	}
 
 	check_mpx_erratum(c);
+
+	setup_force_cpu_cap(X86_FEATURE_EPB);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/sysfs.c b/arch/x86/kernel/cpu/sysfs.c
new file mode 100644
index 000000000000..7114abdc9dac
--- /dev/null
+++ b/arch/x86/kernel/cpu/sysfs.c
@@ -0,0 +1,55 @@
+#include <linux/sysfs.h>
+#include <linux/device.h>
+
+static ssize_t
+energy_policy_pref_hint_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	u64 epb;
+
+	rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
+
+	return sprintf(buf, "%d\n", (unsigned int)(epb & 0xFULL));
+}
+
+static ssize_t
+energy_policy_pref_hint_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	u32 val;
+	u64 epb;
+
+	if (kstrtou32(buf, 10, &val) < 0)
+		return -EINVAL;
+
+	if (val > 15)
+		return -EINVAL;
+
+	rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
+
+	if ((epb & 0xf) == val)
+		return count;
+
+	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~0xFULL) | val);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(energy_policy_pref_hint);
+
+static struct attribute *cpu_attrs[] = {
+	&dev_attr_energy_policy_pref_hint.attr,
+	NULL,
+};
+
+static struct attribute_group cpu_attr_group = {
+	.attrs = cpu_attrs,
+};
+
+const struct attribute_group * arch_get_cpu_group(void)
+{
+	if (static_cpu_has(X86_FEATURE_EPB))
+		return &cpu_attr_group;
+
+	return NULL;
+}
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 691eeea2f19a..4b9a6e499dbd 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -344,6 +344,8 @@ static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
 }
 #endif
 
+const struct attribute_group * __weak arch_get_cpu_group(void) { return NULL; }
+
 /*
  * register_cpu - Setup a sysfs device for a CPU.
  * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
@@ -354,6 +356,8 @@ static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
  */
 int register_cpu(struct cpu *cpu, int num)
 {
+	const struct attribute_group *arch_grp;
+	int grp_size;
 	int error;
 
 	cpu->node_id = cpu_to_node(num);
@@ -368,13 +372,31 @@ int register_cpu(struct cpu *cpu, int num)
 	cpu->dev.bus->uevent = cpu_uevent;
 #endif
 	cpu->dev.groups = common_cpu_attr_groups;
-	if (cpu->hotpluggable)
+	grp_size = ARRAY_SIZE(common_cpu_attr_groups);
+
+	if (cpu->hotpluggable) {
 		cpu->dev.groups = hotplugable_cpu_attr_groups;
+		grp_size = ARRAY_SIZE(hotplugable_cpu_attr_groups);
+	}
+
+	arch_grp = arch_get_cpu_group();
+	if (arch_grp) {
+		const struct attribute_group **tmp;
+
+		tmp = kcalloc(grp_size + 1, sizeof(struct attribute_group *), GFP_KERNEL);
+		if (tmp) {
+			memcpy(tmp, cpu->dev.groups, sizeof(*tmp) * grp_size);
+			tmp[grp_size - 1] = arch_grp;
+			cpu->dev.groups = tmp;
+		}
+	}
+
 	error = device_register(&cpu->dev);
-	if (!error)
+	if (!error) {
 		per_cpu(cpu_sys_devices, num) = &cpu->dev;
-	if (!error)
 		register_cpu_under_node(num, cpu_to_node(num));
+	}
+
 
 	return error;
 }
diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 8358863259c5..1d52a5f9dbaf 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -138,7 +138,7 @@ UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
 	utils/idle_monitor/mperf_monitor.o utils/idle_monitor/cpupower-monitor.o \
 	utils/cpupower.o utils/cpufreq-info.o utils/cpufreq-set.o \
 	utils/cpupower-set.o utils/cpupower-info.o utils/cpuidle-info.o \
-	utils/cpuidle-set.o
+	utils/cpuidle-set.o ../utils/utils.o
 
 UTIL_SRC := $(UTIL_OBJS:.o=.c)
 
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index c7caa8eaa6d0..d1e202debdc1 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -15,6 +15,8 @@
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
 
+#include "../../utils/utils.h"
+
 static struct option set_opts[] = {
      {"perf-bias", optional_argument, NULL, 'b'},
      { },
@@ -93,7 +95,7 @@ int cmd_info(int argc, char **argv)
 		}
 
 		if (params.perf_bias) {
-			ret = msr_intel_get_perf_bias(cpu);
+			ret = get_pref_hint(cpu);
 			if (ret < 0) {
 				fprintf(stderr,
 			_("Could not read perf-bias value[%d]\n"), ret);
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 532f46b9a335..00f5b4681d0d 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -16,6 +16,8 @@
 #include "helpers/sysfs.h"
 #include "helpers/bitmask.h"
 
+#include "../../utils/utils.h"
+
 static struct option set_opts[] = {
 	{"perf-bias", required_argument, NULL, 'b'},
 	{ },
@@ -87,7 +89,7 @@ int cmd_set(int argc, char **argv)
 		}
 
 		if (params.perf_bias) {
-			ret = msr_intel_set_perf_bias(cpu, perf_bias);
+			ret = set_pref_hint(cpu, perf_bias);
 			if (ret) {
 				fprintf(stderr, _("Error setting perf-bias "
 						  "value on CPU %d\n"), cpu);
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index afb66f80554e..107d2c7c1ace 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -102,8 +102,6 @@ extern struct cpupower_cpu_info cpupower_cpu_info;
 extern int read_msr(int cpu, unsigned int idx, unsigned long long *val);
 extern int write_msr(int cpu, unsigned int idx, unsigned long long val);
 
-extern int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val);
-extern int msr_intel_get_perf_bias(unsigned int cpu);
 extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
 
 /* Read/Write msr ****************************/
@@ -147,10 +145,6 @@ static inline int read_msr(int cpu, unsigned int idx, unsigned long long *val)
 { return -1; };
 static inline int write_msr(int cpu, unsigned int idx, unsigned long long val)
 { return -1; };
-static inline int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val)
-{ return -1; };
-static inline int msr_intel_get_perf_bias(unsigned int cpu)
-{ return -1; };
 static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
 { return 0; };
 
diff --git a/tools/power/cpupower/utils/helpers/msr.c b/tools/power/cpupower/utils/helpers/msr.c
index 31a4b24a8bc6..6c076c26ef52 100644
--- a/tools/power/cpupower/utils/helpers/msr.c
+++ b/tools/power/cpupower/utils/helpers/msr.c
@@ -10,7 +10,6 @@
 /* Intel specific MSRs */
 #define MSR_IA32_PERF_STATUS		0x198
 #define MSR_IA32_MISC_ENABLES		0x1a0
-#define MSR_IA32_ENERGY_PERF_BIAS	0x1b0
 #define MSR_NEHALEM_TURBO_RATIO_LIMIT	0x1ad
 
 /*
@@ -43,62 +42,6 @@ int read_msr(int cpu, unsigned int idx, unsigned long long *val)
 	return -1;
 }
 
-/*
- * write_msr
- *
- * Will return 0 on success and -1 on failure.
- * Possible errno values could be:
- * EFAULT -If the read/write did not fully complete
- * EIO    -If the CPU does not support MSRs
- * ENXIO  -If the CPU does not exist
- */
-int write_msr(int cpu, unsigned int idx, unsigned long long val)
-{
-	int fd;
-	char msr_file_name[64];
-
-	sprintf(msr_file_name, "/dev/cpu/%d/msr", cpu);
-	fd = open(msr_file_name, O_WRONLY);
-	if (fd < 0)
-		return -1;
-	if (lseek(fd, idx, SEEK_CUR) == -1)
-		goto err;
-	if (write(fd, &val, sizeof val) != sizeof val)
-		goto err;
-	close(fd);
-	return 0;
- err:
-	close(fd);
-	return -1;
-}
-
-int msr_intel_get_perf_bias(unsigned int cpu)
-{
-	unsigned long long val;
-	int ret;
-
-	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
-		return -1;
-
-	ret = read_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &val);
-	if (ret)
-		return ret;
-	return val;
-}
-
-int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val)
-{
-	int ret;
-
-	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
-		return -1;
-
-	ret = write_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, val);
-	if (ret)
-		return ret;
-	return 0;
-}
-
 unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
 {
 	unsigned long long val;
diff --git a/tools/power/utils/utils.c b/tools/power/utils/utils.c
new file mode 100644
index 000000000000..0377c5686704
--- /dev/null
+++ b/tools/power/utils/utils.c
@@ -0,0 +1,45 @@
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+int get_pref_hint(unsigned int cpu)
+{
+	char fname[64];
+	int val = -1;
+	int fd;
+
+	sprintf(fname, "/sys/devices/system/cpu/cpu%d/energy_policy_pref_hint", cpu);
+
+	fd = open(fname, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	if (read(fd, &val, sizeof(val)) != sizeof(val))
+		val = -1;
+
+	close(fd);
+	return val;
+}
+
+int set_pref_hint(unsigned int cpu, unsigned int val)
+{
+	char fname[64];
+	int ret = 0, fd;
+
+	sprintf(fname, "/sys/devices/system/cpu/cpu%d/energy_policy_pref_hint", cpu);
+
+	fd = open(fname, O_WRONLY);
+	if (fd < 0)
+		return -1;
+
+	if (write(fd, &val, sizeof(val)) != sizeof(val))
+		ret = -1;
+
+	close(fd);
+	return ret;
+}
+
+
diff --git a/tools/power/utils/utils.h b/tools/power/utils/utils.h
new file mode 100644
index 000000000000..d6989a0cecc8
--- /dev/null
+++ b/tools/power/utils/utils.h
@@ -0,0 +1,7 @@
+#ifndef __TOOLS_POWER_UTILS_H_
+#define __TOOLS_POWER_UTILS_H_
+
+int get_pref_hint(unsigned int cpu);
+int set_pref_hint(unsigned int cpu, unsigned int val);
+
+#endif /* __TOOLS_POWER_UTILS_H_ */
diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index e367b1a85d70..a806b81e2e5e 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -2,22 +2,30 @@ CC		= $(CROSS_COMPILE)gcc
 BUILD_OUTPUT	:= $(CURDIR)
 PREFIX		:= /usr
 DESTDIR		:=
+INCLUDE		:= -I../../utils
 
 ifeq ("$(origin O)", "command line")
 	BUILD_OUTPUT := $(O)
 endif
 
-turbostat : turbostat.c
+OBJS		:= turbostat.o ../../utils/utils.o
+
+turbostat : $(OBJS)
 CFLAGS +=	-Wall
 CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+CFLAGS +=	$(INCLUDE)
+
+%.o: %.c
+	@mkdir -p $(BUILD_OUTPUT)
+	$(CC) -c $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
 
-%: %.c
+turbostat: $(OBJS)
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
+	$(CC) $(CFLAGS) $? -o $(BUILD_OUTPUT)/$@
 
 .PHONY : clean
 clean :
-	@rm -f $(BUILD_OUTPUT)/turbostat
+	@rm -f $(BUILD_OUTPUT)/turbostat $(BUILD_OUTPUT)/*.o $(BUILD_OUTPUT)/../../utils/utils.o
 
 install : turbostat
 	install -d  $(DESTDIR)$(PREFIX)/bin
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index acbf7ff2ee6e..1695afa634fb 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -43,6 +43,8 @@
 #include <linux/capability.h>
 #include <errno.h>
 
+#include "../../utils/utils.h"
+
 char *proc_stat = "/proc/stat";
 FILE *outf;
 int *fd_percpu;
@@ -2353,8 +2355,8 @@ dump_cstate_pstate_config_info(unsigned int family, unsigned int model)
  */
 int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
-	unsigned long long msr;
 	char *epb_string;
+	int pref_hint;
 	int cpu;
 
 	if (!has_epb)
@@ -2371,10 +2373,11 @@ int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		return -1;
 	}
 
-	if (get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr))
+	pref_hint = get_pref_hint(cpu);
+	if (pref_hint < 0)
 		return 0;
 
-	switch (msr & 0xF) {
+	switch (pref_hint) {
 	case ENERGY_PERF_BIAS_PERFORMANCE:
 		epb_string = "performance";
 		break;
@@ -2388,7 +2391,7 @@ int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		epb_string = "custom";
 		break;
 	}
-	fprintf(outf, "cpu%d: MSR_IA32_ENERGY_PERF_BIAS: 0x%08llx (%s)\n", cpu, msr, epb_string);
+	fprintf(outf, "cpu%d: %s\n", cpu, epb_string);
 
 	return 0;
 }
diff --git a/tools/power/x86/x86_energy_perf_policy/Makefile b/tools/power/x86/x86_energy_perf_policy/Makefile
index 971c9ffdcb50..8c194d2102a9 100644
--- a/tools/power/x86/x86_energy_perf_policy/Makefile
+++ b/tools/power/x86/x86_energy_perf_policy/Makefile
@@ -1,9 +1,9 @@
 DESTDIR ?=
 
-x86_energy_perf_policy : x86_energy_perf_policy.c
+x86_energy_perf_policy : x86_energy_perf_policy.c ../../utils/utils.c
 
 clean :
-	rm -f x86_energy_perf_policy
+	rm -f x86_energy_perf_policy ../../utils/utils.o
 
 install :
 	install x86_energy_perf_policy ${DESTDIR}/usr/bin/
diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 40b3e5482f8a..50baebb9aa6f 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -31,6 +31,8 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "../../utils/utils.h"
+
 unsigned int verbose;		/* set with -v */
 unsigned int read_only;		/* set with -r */
 char *progname;
@@ -69,8 +71,6 @@ void usage(void)
 	exit(1);
 }
 
-#define MSR_IA32_ENERGY_PERF_BIAS	0x000001b0
-
 #define	BIAS_PERFORMANCE		0
 #define BIAS_BALANCE			6
 #define	BIAS_POWERSAVE			15
@@ -184,79 +184,31 @@ void validate_cpuid(void)
 	return;	/* success */
 }
 
-unsigned long long get_msr(int cpu, int offset)
-{
-	unsigned long long msr;
-	char msr_path[32];
-	int retval;
-	int fd;
-
-	sprintf(msr_path, "/dev/cpu/%d/msr", cpu);
-	fd = open(msr_path, O_RDONLY);
-	if (fd < 0) {
-		printf("Try \"# modprobe msr\"\n");
-		perror(msr_path);
-		exit(1);
-	}
-
-	retval = pread(fd, &msr, sizeof msr, offset);
-
-	if (retval != sizeof msr) {
-		printf("pread cpu%d 0x%x = %d\n", cpu, offset, retval);
-		exit(-2);
-	}
-	close(fd);
-	return msr;
-}
-
-unsigned long long  put_msr(int cpu, unsigned long long new_msr, int offset)
+void print_bias(int cpu)
 {
-	unsigned long long old_msr;
-	char msr_path[32];
-	int retval;
-	int fd;
-
-	sprintf(msr_path, "/dev/cpu/%d/msr", cpu);
-	fd = open(msr_path, O_RDWR);
-	if (fd < 0) {
-		perror(msr_path);
-		exit(1);
-	}
-
-	retval = pread(fd, &old_msr, sizeof old_msr, offset);
-	if (retval != sizeof old_msr) {
-		perror("pwrite");
-		printf("pread cpu%d 0x%x = %d\n", cpu, offset, retval);
-		exit(-2);
-	}
+	unsigned int val;
 
-	retval = pwrite(fd, &new_msr, sizeof new_msr, offset);
-	if (retval != sizeof new_msr) {
-		perror("pwrite");
-		printf("pwrite cpu%d 0x%x = %d\n", cpu, offset, retval);
-		exit(-2);
-	}
-
-	close(fd);
-
-	return old_msr;
-}
+	val = get_pref_hint(cpu);
+	if (val < 0)
+		return;
 
-void print_msr(int cpu)
-{
-	printf("cpu%d: 0x%016llx\n",
-		cpu, get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS));
+	printf("cpu%d: 0x%08x\n", cpu, val);
 }
 
 void update_msr(int cpu)
 {
-	unsigned long long previous_msr;
+	unsigned int previous_val;
+
+	previous_val = get_pref_hint(cpu);
+	if (previous_val < 0)
+		return;
 
-	previous_msr = put_msr(cpu, new_bias, MSR_IA32_ENERGY_PERF_BIAS);
+	if (set_pref_hint(cpu, new_bias))
+		return;
 
 	if (verbose)
-		printf("cpu%d  msr0x%x 0x%016llx -> 0x%016llx\n",
-			cpu, MSR_IA32_ENERGY_PERF_BIAS, previous_msr, new_bias);
+		printf("cpu%d  pref hint: 0x%08x -> 0x%08x\n",
+			cpu, previous_val, new_bias);
 
 	return;
 }
@@ -310,12 +262,12 @@ int main(int argc, char **argv)
 
 	if (cpu != -1) {
 		if (read_only)
-			print_msr(cpu);
+			print_bias(cpu);
 		else
 			update_msr(cpu);
 	} else {
 		if (read_only)
-			for_every_cpu(print_msr);
+			for_every_cpu(print_bias);
 		else
 			for_every_cpu(update_msr);
 	}
-- 
2.7.3


-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
