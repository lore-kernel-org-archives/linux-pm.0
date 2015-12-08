From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Tue, 08 Dec 2015 16:27:57 +0100
Message-ID: <3600864.XZTfEJ2ljK@skinner>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <1449247235-29389-3-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38348 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933152AbbLHP2A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 10:28:00 -0500
In-Reply-To: <1449247235-29389-3-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>, Len Brown <lenb@kernel.org>

Hi,

On Friday, December 04, 2015 05:40:30 PM Philippe Longepe wrote:
> From: Philippe Longepe <philippe.longepe@intel.com>
> 
> Target systems using different cpus have different power and performance
> requirements. They may use different algorithms to get the next P-state
> based on their power or performance preference.

But this does not necessarily have to do with the CPU model.

> For example, power-constrained systems may not want to use
> high-performance P-states as aggressively as a full-size desktop or a
> server platform. A server platform may want to run close to the max to
> achieve better performance, while laptop-like systems may prefer
> sacrificing performance for longer battery lifes.

Here you name it. It is about the platform type.

There may be atoms clustered in server platforms and there may be
performance oriented CPU models built into laptops.
 
> For the above reasons, modify intel_pstate to allow the target P-state
> selection algorithm to be depend on the CPU ID.

This is wrong in 2 ways:
  1. it should depend on the platform type, not the CPU id
  2. it should still be overridable from userspace (this is what Len
     came up with when I recently sent a patch. We recently added a patch
     (pasted at the very end of the mail) to adjust
     pstate knobs, to be more performance oriented, depending on the platform
     type you are running on to SLES 12).

Below patch is based on an older kernel.
IMO 3 things should get combined:
1. This patch based on ACPI pm_profile instead of CPU id
2. Your algorithm changes
3. A way to adjust ACPI pm_profile from userspace and boot parameter.
   e.g. acpi.pm_profile=
   intel_pstate could register a callback:
   void preferred_pm_profile(u8 pm_profile);
   and adjust it's algorithm and tunables according to what user writes to:
   /sys/firmware/acpi/pm_profile (which could be made overridable)


---------------------------------------------

From: Thomas Renninger <trenn@suse.com>
Subject: intel_pstate: Adjust performance knobs on servers for SLES
Patch-mainline: never
References: bnc#945201

Depending on ACPI FADT table's preferred PM profile
(compare with ACPI spec chapter 5.2.9.1 Preferred PM Profile System Types)
the intel_pstate performance tunables will be set to a more performance
oriented policy.

intel_pstate=vanilla_policy
boot parameter will disable this functionality again.

intel_pstate=server_policy
will apply the performance optimized values also on laptops, desktops
or where the ACPI preferred PM profile value is not set.

---
 drivers/cpufreq/intel_pstate.c |   43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -532,6 +532,14 @@ static struct cpu_defaults byt_params =
 	},
 };
 
+static struct pstate_adjust_policy adj_server_policy = {
+	.sample_rate_ms = 10,
+	.deadband = 0,
+	.setpoint = 30,
+	.p_gain_pct = 10,
+	.d_gain_pct = 0,
+	.i_gain_pct = 0,
+};
 
 static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 {
@@ -862,6 +870,8 @@ static struct cpufreq_driver intel_pstat
 };
 
 static int __initdata no_load;
+static int __initdata vanilla_policy;
+static int __initdata server_policy;
 
 static int intel_pstate_msrs_not_valid(void)
 {
@@ -978,6 +988,9 @@ static int __init intel_pstate_init(void
 	int cpu, rc = 0;
 	const struct x86_cpu_id *id;
 	struct cpu_defaults *cpu_info;
+#if IS_ENABLED(CONFIG_ACPI)
+	const char *profile = NULL;
+#endif
 
 	if (no_load)
 		return -ENODEV;
@@ -1003,6 +1016,32 @@ static int __init intel_pstate_init(void
 
 	pr_info("Intel P-state driver initializing.\n");
 
+#if IS_ENABLED(CONFIG_ACPI)
+	if (!vanilla_policy) {
+		switch (acpi_gbl_FADT.preferred_profile) {
+		case PM_WORKSTATION:
+			profile = "Workstation";
+			break;
+		case PM_ENTERPRISE_SERVER:
+			profile = "Enterprise Server";
+			break;
+		case PM_SOHO_SERVER:
+			profile = "SOHO Server";
+			break;
+		case PM_PERFORMANCE_SERVER:
+			profile = "Performance Server";
+			break;
+		default:
+			if (server_policy)
+				profile = "Server";
+		};
+
+		if (profile) {
+			pr_info("Intel P-state setting %s policy\n", profile);
+			copy_pid_params(&adj_server_policy);
+		}
+	}
+#endif
 	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
 	if (!all_cpu_data)
 		return -ENOMEM;
@@ -1036,6 +1075,10 @@ static int __init intel_pstate_setup(cha
 
 	if (!strcmp(str, "disable"))
 		no_load = 1;
+	if (!strcmp(str, "vanilla_policy"))
+		vanilla_policy = 1;
+	if (!strcmp(str, "server_policy"))
+		server_policy = 1;
 	return 0;
 }
 early_param("intel_pstate", intel_pstate_setup);


