From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v2 2/3] PM / EM: Document the Energy Model framework
Date: Mon, 21 Jan 2019 11:17:23 +0000
Message-ID: <20190121111724.18234-3-quentin.perret@arm.com>
References: <20190121111724.18234-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121111724.18234-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, peterz@infradead.org, rjw@rjwysocki.net, juri.lelli@redhat.com
Cc: mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com, patrick.bellasi@arm.com, dietmar.eggemann@arm.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Introduce a documentation file summarizing the key design points and
APIs of the newly introduced Energy Model framework.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>

---

Juri: Although I did change some things to the doc in v2 (translated to
rst mainly), I kept your 'Reviewed-by' as the content is still pretty
much the same. Please scream if you disagree :-)

Thanks,
Quentin
---
 Documentation/driver-api/pm/energy-model.rst | 150 +++++++++++++++++++
 Documentation/driver-api/pm/index.rst        |   1 +
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/driver-api/pm/energy-model.rst

diff --git a/Documentation/driver-api/pm/energy-model.rst b/Documentation/driver-api/pm/energy-model.rst
new file mode 100644
index 000000000000..c447528c4e29
--- /dev/null
+++ b/Documentation/driver-api/pm/energy-model.rst
@@ -0,0 +1,150 @@
+====================
+Energy Model of CPUs
+====================
+
+Overview
+========
+
+The Energy Model (EM) framework serves as an interface between drivers knowing
+the power consumed by CPUs at various performance levels, and the kernel
+subsystems willing to use that information to make energy-aware decisions.
+
+The source of the information about the power consumed by CPUs can vary greatly
+from one platform to another. These power costs can be estimated using
+devicetree data in some cases. In others, the firmware will know better.
+Alternatively, userspace might be best positioned. And so on. In order to avoid
+each and every client subsystem to re-implement support for each and every
+possible source of information on its own, the EM framework intervenes as an
+abstraction layer which standardizes the format of power cost tables in the
+kernel, hence enabling to avoid redundant work.
+
+The figure below depicts an example of drivers (Arm-specific here, but the
+approach is applicable to any architecture) providing power costs to the EM
+framework, and interested clients reading the data from it.
+
+.. code-block:: none
+
+          +---------------+  +-----------------+  +---------------+
+          | Thermal (IPA) |  | Scheduler (EAS) |  |     Other     |
+          +---------------+  +-----------------+  +---------------+
+                  |                   | em_pd_energy()    |
+                  |                   | em_cpu_get()      |
+                  +---------+         |         +---------+
+                            |         |         |
+                            v         v         v
+                           +---------------------+
+                           |    Energy Model     |
+                           |     Framework       |
+                           +---------------------+
+                              ^       ^       ^
+                              |       |       | em_register_perf_domain()
+                   +----------+       |       +---------+
+                   |                  |                 |
+           +---------------+  +---------------+  +--------------+
+           |  cpufreq-dt   |  |   arm_scmi    |  |    Other     |
+           +---------------+  +---------------+  +--------------+
+                   ^                  ^                 ^
+                   |                  |                 |
+           +--------------+   +---------------+  +--------------+
+           | Device Tree  |   |   Firmware    |  |      ?       |
+           +--------------+   +---------------+  +--------------+
+
+The EM framework manages power cost tables per 'performance domain' in the
+system. A performance domain is a group of CPUs whose performance is scaled
+together. Performance domains generally have a 1-to-1 mapping with CPUFreq
+policies. All CPUs in a performance domain are required to have the same
+micro-architecture. CPUs in different performance domains can have different
+micro-architectures.
+
+
+Core APIs overview
+==================
+
+Config options
+--------------
+
+`CONFIG_ENERGY_MODEL` must be enabled to use the EM framework.
+
+
+Registration of performance domains
+-----------------------------------
+
+Drivers are expected to register performance domains into the EM framework by
+calling the :c:func:`em_register_perf_domain()` API. Drivers must specify the
+CPUs of the performance domains using a cpumask, and provide a callback function
+returning <frequency, power> tuples for each capacity state. The callback
+function provided by the driver is free to fetch data from any relevant location
+(DT, firmware, ...), and by any mean deemed necessary.
+
+
+Accessing performance domains
+-----------------------------
+
+Subsystems interested in the energy model of a CPU can retrieve it using the
+:c:func:`em_cpu_get()` API. The energy model tables are allocated once upon
+creation of the performance domains, and kept in memory untouched.
+
+The energy consumed by a performance domain can be estimated using the
+:c:func:`em_pd_energy()` API. The estimation is performed assuming that the
+schedutil CPUfreq governor is in use.
+
+
+Example driver
+==============
+
+This section provides a simple example of a CPUFreq driver registering a
+performance domain in the Energy Model framework using the (fake) `foo`
+protocol. The driver implements an :c:func:`est_power()` function to be provided
+to the EM framework.
+
+:file:`drivers/cpufreq/foo_cpufreq.c`:
+
+.. code-block:: c
+   :linenos:
+
+   static int est_power(unsigned long *mW, unsigned long *KHz, int cpu)
+   {
+   	long freq, power;
+
+   	/* Use the 'foo' protocol to ceil the frequency */
+   	freq = foo_get_freq_ceil(cpu, *KHz);
+   	if (freq < 0);
+   		return freq;
+
+   	/* Estimate the power cost for the CPU at the relevant freq. */
+   	power = foo_estimate_power(cpu, freq);
+   	if (power < 0);
+   		return power;
+
+   	/* Return the values to the EM framework */
+   	*mW = power;
+   	*KHz = freq;
+
+   	return 0;
+   }
+
+   static int foo_cpufreq_init(struct cpufreq_policy *policy)
+   {
+   	struct em_data_callback em_cb = EM_DATA_CB(est_power);
+   	int nr_opp, ret;
+
+   	/* Do the actual CPUFreq init work ... */
+   	ret = do_foo_cpufreq_init(policy);
+   	if (ret)
+   		return ret;
+
+   	/* Find the number of OPPs for this policy */
+   	nr_opp = foo_get_nr_opp(policy);
+
+   	/* And register the new performance domain */
+   	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
+
+           return 0;
+   }
+
+
+Inline kernel documentation
+===========================
+
+.. kernel-doc:: include/linux/energy_model.h
+.. kernel-doc:: kernel/power/energy_model.c
diff --git a/Documentation/driver-api/pm/index.rst b/Documentation/driver-api/pm/index.rst
index 2f6d0e9cf6b7..d3a582adef4c 100644
--- a/Documentation/driver-api/pm/index.rst
+++ b/Documentation/driver-api/pm/index.rst
@@ -5,6 +5,7 @@ Device Power Management
 .. toctree::
 
    devices
+   energy-model
    notifiers
    types
 
-- 
2.20.1
