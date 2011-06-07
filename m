From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 0/7] cpuidle: (POWER) cpuidle driver for
	pSeries
Date: Tue, 07 Jun 2011 21:59:15 +0530
Message-ID: <20110607162847.6848.44707.stgit__44351.4387043708$1307464216$gmane$org@tringupt.in.ibm.com>
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
To: linux-pm@lists.linux-foundation.org, linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch series ports the cpuidle framework for ppc64 platform and
implements a cpuidle back-end driver for ppc64 (pSeries) platform.
Currently idle states are managed by pseries_{dedicated,shared}_idle_sleep() 
routines in arch/powerpc/platforms/pseries/setup.c.  There are
generally two idle states (snooze and cede) that are exploited by
these routines based on simple heuristics.

Moving the idle states over to cpuidle framework can take advantage of
the advanced heuristics, tunables, and features provided by cpuidle
framework. Additional idle states like extended cede with hints would be
included and exploited using the cpuidle framework. The statistics and 
tracing infrastructure provided by the cpuidle framework also helps in 
enabling power management related tools and help tune the system and 
applications.

This series aims to maintain compatibility and functionality to
existing pSeries idle cpu management code.  There are no new functions
or idle states added as part of this series. The first three patch
in the series are taken from "idle cleanup - v3" posted by 
Len Brown (https://lkml.org/lkml/2011/4/2/8). These are required to
eliminate usage of pm_idle.

[1/7] cpuidle: create bootparam "cpuidle.off=1"
[2/7] cpuidle: replace xen access to x86 pm_idle and default_idle
[3/7] cpuidle: stop using pm_idle
[4/7] - Provides arch specific cpu_idle_wait() function required by cpuidle
  subsystem.
[5/7] - pseries_idle cpuidle driver
[6/7] - Enables cpuidle for pSeries and directly calls cpuidle_idle_call()
[7/7] - Handles powersave=off kernel boot parameter and disables registration
  of pseries_idle cpuidle driver.

This patch series has the following dependencies:

(1) Base kernel tree: 3.0.0-rc2
(2) Patch: cpuidle: global registration patch 
        https://lkml.org/lkml/2011/6/6/259

This series is tested on ppc64 pSeries POWER7 system with the snooze
and cede states.

Thanks,
-Trinabh
