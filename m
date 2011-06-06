From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V5 0/4] cpuidle: global registration of idle
	states with	per-cpu statistics
Date: Mon, 06 Jun 2011 19:09:18 +0530
Message-ID: <20110606133917.5670.54949.stgit__41632.5490143665$1307367778$gmane$org@tringupt.in.ibm.com>
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
To: arjan@linux.intel.com, peterz@infradead.org, lenb@kernel.org, venki@google.com, ak@linux.intel.com, len.brown@intel.com, santosh.shilimkar@ti.com, khilman@ti.com
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The following patch series implements global registration of cpuidle
states, and also has the necessary data structure changes to
accommodate the per-cpu writable members of the cpuidle_states
structure.

Previous version of the series (V4) is at https://lkml.org/lkml/2011/4/28/312
This series applies on 3.0-rc1

Changes from previous version (V4):

1. Rebased the series to 3.0-rc1
2. Made same changes for Samsung exynos4 cpuidle driver registration

Tests done:
1. Compile tested for ARM using the following configs: da8xx_omapl_defconfig,
  exynos4_defconfig, kirkwood_defconfig, omap2plus_defconfig.

2. Boot tested on x86 nehalem with multiple C-states for both intel_idle
  and acpi_idle drivers.

Thanks
-Trinabh 
