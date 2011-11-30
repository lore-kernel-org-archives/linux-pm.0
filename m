From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 0/4] cpuidle: (POWER) cpuidle driver for
	pSeries
Date: Wed, 30 Nov 2011 18:16:12 +0530
Message-ID: <20111130124608.972.87712.stgit__11333.9485521012$1322657207$gmane$org@deepthi-ThinkPad-T420>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: benh@kernel.crashing.org, len.brown@intel.com
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch series ports the cpuidle framework for ppc64 platform and
implements a cpuidle back-end driver for ppc64 (pSeries) platform.
Currently idle states are managed by pseries_{dedicated,shared}_idle_sleep()
routines in arch/powerpc/platforms/pseries/setup.c.  There are
two idle states (snooze and cede) that are exploited by
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
or idle states added as part of this series.

The previous version of this patch can be found at
https://lkml.org/lkml/2011/11/17/127

Changes from the previous version (v2):

	1] Rebased to latest 3.2-rc3

	2] Incorporated the changes from the feedback provided by Ben
	   in the previous version of this series.

This patch series includes:

[1/4] - Provides arch specific cpu_idle_wait() function required by cpuidle
  subsystem.
[2/4] - pseries_idle cpuidle driver
[3/4] - Enables cpuidle for pSeries and directly calls cpuidle_idle_call()
[4/4] - Handles powersave=off kernel boot parameter and disables registration
  of pseries_idle cpuidle driver.

This series has been tested on ppc64 pSeries POWER7 system with the snooze
and cede states

--

 arch/powerpc/Kconfig                            |    4 
 arch/powerpc/include/asm/processor.h            |    3 
 arch/powerpc/include/asm/system.h               |    9 +
 arch/powerpc/kernel/idle.c                      |   27 ++
 arch/powerpc/kernel/sysfs.c                     |    2 
 arch/powerpc/platforms/Kconfig                  |    6 
 arch/powerpc/platforms/pseries/Kconfig          |    9 +
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/processor_idle.c |  329 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h        |    3 
 arch/powerpc/platforms/pseries/setup.c          |  104 +------
 arch/powerpc/platforms/pseries/smp.c            |    1 
 include/linux/cpuidle.h                         |    2 
 13 files changed, 411 insertions(+), 89 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/processor_idle.c



-Deepthi 
