From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] acpi, cpuidle: Register with cpuidle even if cpu is onlined
 after boot (beyond maxcpus)
Date: Mon, 25 Jun 2012 16:55:43 +0530
Message-ID: <4FE84AB7.6020305@linux.vnet.ibm.com>
References: <4FDB549F.1020002@linaro.org> <4FDE3B96.8030306@linaro.org> <4FDF1E3A.6010200@linux.vnet.ibm.com> <4FDF24FE.1010108@linaro.org> <4FE02233.2060809@linux.vnet.ibm.com> <4FE0243C.4040600@linux.vnet.ibm.com> <4FE027AC.8010607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4FE027AC.8010607@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, trenn@suse.de, Linux PM mailing list <linux-pm@vger.kernel.org>, lenb@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org


Daniel Lezcano noticed that after booting with maxcpus=X, if we online the
remaining cpus by writing: echo 1 > /sys/devices/system/cpu/cpuY/online, then
for the newly onlined cpus, the cpuidle directory is not found under
/sys/devices/system/cpu/cpuY.

Partly, the reason for this is that acpi restricts the initialization to cpus
within the maxcpus limit. (See commit 75cbfb9 "ACPI: Do not try to set up acpi
processor stuff on cores exceeding maxcpus="). The maxcpus= kernel parameter is
used to restrict the number of cpus brought up during boot. That doesn't mean
that we should hard restrict the bring up of the remaining cpus later on. So
teach acpi to play nice with maxcpus= parameter, and perform the initialization
for all present cpus, but defer their startup to the point when they are
actually onlined later.

But that alone won't suffice as a fix, because there is one more thing that
the present but !online cpus lack - the need_hotplug_init flag.
The need_hotplug_init flag is set only for physically hotplugged cpus and not
for cpus which were already present but not brought online during boot (due to
the maxcpus= parameter). For cpus with this flag set, during the online
operation, acpi_cpu_soft_notify() takes care of the registration with cpuidle.
So, in order to allow the present but !online cpus to be onlined later with
full features (by making use of acpi_cpu_soft_notify()), set their
need_hotplug_init flag.

Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

Daniel, this patch works for me. Does it work for you as well?

 drivers/acpi/processor_driver.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 0734086..f29d30f 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -551,11 +551,6 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		return 0;
 	}
 
-#ifdef CONFIG_SMP
-	if (pr->id >= setup_max_cpus && pr->id != 0)
-		return 0;
-#endif
-
 	BUG_ON((pr->id >= nr_cpu_ids) || (pr->id < 0));
 
 	/*
@@ -580,6 +575,17 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		goto err_clear_processor;
 	}
 
+#ifdef CONFIG_SMP
+	if (pr->id >= setup_max_cpus && pr->id != 0) {
+		/*
+		 * Don't start cpus beyond maxcpus now. But allow them to
+		 * to be brought online later.
+		 */
+		pr->flags.need_hotplug_init = 1;
+		return 0;
+	}
+#endif
+
 	/*
 	 * Do not start hotplugged CPUs now, but when they
 	 * are onlined the first time


