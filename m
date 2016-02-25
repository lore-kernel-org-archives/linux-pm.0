From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: acpi-cpufreq: Drop pointless label from acpi_cpufreq_target()
Date: Fri, 26 Feb 2016 00:03:58 +0100
Message-ID: <1905248.5bkSJ3vszA@vostro.rjw.lan>
References: <3419119.Zd6aAZrh1K@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3419119.Zd6aAZrh1K@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The "out" label at the final return statement in acpi_cpufreq_target()
is totally pointless, so drop them and modify the code to return the
right values immediately instead of jumping to it.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -434,7 +434,7 @@ static int acpi_cpufreq_target(struct cp
 		} else {
 			pr_debug("Already at target state (P%d)\n",
 				next_perf_state);
-			goto out;
+			return 0;
 		}
 	}
 
@@ -456,8 +456,7 @@ static int acpi_cpufreq_target(struct cp
 		cmd.val = (u32) perf->states[next_perf_state].control;
 		break;
 	default:
-		result = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
@@ -480,7 +479,6 @@ static int acpi_cpufreq_target(struct cp
 	if (!result)
 		perf->state = next_perf_state;
 
-out:
 	return result;
 }
 
