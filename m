From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 0/6] CPPC optional registers AMD support
Date: Fri, 22 Mar 2019 20:25:53 +0000
Message-ID: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
List-Id: linux-pm@vger.kernel.org

CPPC (Collaborative Processor Performance Control) offers optional
registers which can be used to tune the system based on energy and/or
performance requirements.

Newer AMD processors add support for a subset of these optional CPPC
registers, based on ACPI v6.1.

The following are the supported CPPC registers for which sysfs entries
are created:
* enable		(NEW)
* max_perf		(NEW)
* min_perf		(NEW)
* energy_perf
* lowest_perf
* nominal_perf
* desired_perf		(NEW)
* feedback_ctrs
* auto_sel_enable	(NEW)
* lowest_nonlinear_perf

The CPPC driver is updated to enable the OSPM and the userspace to access
the newly supported registers.

The purpose of exposing the registers via the sysfs entries is to allow
the userspace to:
* Tweak the values to fit its workload.
* Apply a profile from AMD's optimization guides.

Profiles will be documented in the performance/optimization guides.

Note:
* AMD systems will not have a policy applied in the kernel at this time.
* By default, acpi_cpufreq will still be used.

TODO:
* Create a linux userspace tool that will help users generate a CPPC profil=
e
  for their target workload.
* Create or update a driver to apply a general CPPC policy in the kernel.

Janakarajan Natarajan (1):
  acpi/cppc: Ensure only supported CPPC sysfs entries are created

Yazen Ghannam (5):
  acpi/cppc: Modify show_cppc_data macro
  acpi/cppc: Rework cppc_set_perf() to use cppc_regs index
  acpi/cppc: Add macros to define a R/W sysfs entry for CPPC registers
  acpi/cppc: Add support for optional CPPC registers
  acpi/cppc: Add support for CPPC Enable register

 drivers/acpi/cppc_acpi.c       | 363 +++++++++++++++++++++++++++++----
 drivers/cpufreq/cppc_cpufreq.c |   6 +-
 include/acpi/cppc_acpi.h       |   6 +-
 3 files changed, 333 insertions(+), 42 deletions(-)

--=20
2.17.1
