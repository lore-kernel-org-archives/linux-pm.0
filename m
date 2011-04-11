From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V2 0/4] cpuidle: global registration of idle
	states with	per-cpu statistics
Date: Mon, 11 Apr 2011 12:45:44 +0530
Message-ID: <20110411071508.6348.67918.stgit__42960.1710675799$1302506266$gmane$org@tringupt.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, peterz@infradead.org
Cc: karthik-dp@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The core change is to split the cpuidle_device structure into parts
that can be global and parts that has to remain per-cpu.  The per-cpu
pieces are mostly generic statistics that can be independent of
current running driver. 

Motivation:
* Simplify the cpuidle subsystem framework and have 
  registration/unregistration done by single cpu.

* Have single copy of cpuidle_states structure and thus reduce 
  memory consumption.

* Only in very rare cases asymmetric C-states exist which
  can be handled within the cpuidle driver. Most architectures
  do not have asymmetric C-states.

* References: 
	https://lkml.org/lkml/2011/2/10/37
	https://lkml.org/lkml/2011/3/25/52

The first couple of patches in the series move the statistics accounting 
part to withing cpuidle driver; which ensures correctness in updation
of statistics. Moving statistics within cpuidle driver is also required to
make cpuidle_state not writable and thus global. Third patch splits 
the per-cpu part out of cpuidle_state structure and the fourth patch 
makes the cpuidle_state global. Please refer to 
https://lkml.org/lkml/2011/3/25/52 . Version 1 of the series is at
https://lkml.org/lkml/2011/3/22/161

This patch series applies on top of 2.6.38 and is tested on x86 Nehalem 
system with multiple ACPI C-States.

To Do:

1. This patch series works only for acpi_idle driver. Changes would
  have to be done for other idle drivers i.e. intel_idle, at91_idle_driver,
  davinci_idle_driver, kirkwood_idle_driver, omap3_idle_driver.

2. Make ladder governor follow changed API. Currently it works for menu
  governor only.

Thanks,
-Trinabh

---

Trinabh Gupta (4):
      Single/Global registration of idle states
      Split cpuidle_state structure and move per-cpu statistics fields
      Remove CPUIDLE_FLAG_IGNORE and dev->prepare()
      Move dev->last_residency update to driver enter routine; remove dev->last_state


 drivers/acpi/processor_driver.c  |   18 ----
 drivers/acpi/processor_idle.c    |  184 ++++++++++++++++++++++++++++++--------
 drivers/cpuidle/cpuidle.c        |   80 +++++------------
 drivers/cpuidle/driver.c         |   26 +++++
 drivers/cpuidle/governors/menu.c |   25 +++--
 drivers/cpuidle/sysfs.c          |   18 ++--
 include/linux/cpuidle.h          |   49 ++++++----
 7 files changed, 247 insertions(+), 153 deletions(-)

--
