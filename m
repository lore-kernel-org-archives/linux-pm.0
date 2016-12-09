From: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 0/4] powernv:stop: Use psscr_val,mask provided by firmware
Date: Fri,  9 Dec 2016 19:01:59 +0530
Message-ID: <cover.1481288905.git.ego@linux.vnet.ibm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Neuling <mikey-/owAOxkjmzZAfugRpC6u6w@public.gmane.org>, Vaidyanathan Srinivasan <svaidy-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Shreyas B. Prabhu" <shreyasbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shilpasri G Bhat <shilpa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Stewart Smith <stewart-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oliver O'Halloran <oohall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

This is the fourth iteration of the patchset to use the psscr_val and
psscr_mask provided by the firmware for each of the stop states.

The previous version can be found here:

[v3]: https://lkml.org/lkml/2016/11/10/37
[v2]: https://lkml.org/lkml/2016/10/27/143
[v1]: https://lkml.org/lkml/2016/9/29/45

This version fixes some of the coding style issues pointed out by
Michael Ellerman in v3. This version also documents the device-tree
bindings defining the properties under the @power-mgt node in the
device tree describing the idle states for Linux running on baremetal
POWER servers.

Synopsis
==========
In the current implementation, the code for ISA
v3.0 stop implementation has a couple of shortcomings.

a) The code hand-codes the values for ESL,EC,TR,MTL bits of PSSCR and
   uses only the RL field from the firmware. While this is not
   incorrect, since the hand-coded values are legitimate, it is not a
   very flexible design since the firmware has the capability to
   communicate these values via the "ibm,cpu-idle-state-psscr" and
   "ibm,cpu-idle-state-psscr-mask" properties. In case where the
   firmware provides values for these fields that is different from
   the hand-coded values, the current code will not work as intended.

b) Due to issue a), the current code assumes that ESL=EC=1 for all the
   stop states and hence the wakeup from the stop instruction will
   happen at 0x100, the system-reset vector. However, the ISA v3.0
   allows the ESL=EC=0 behaviour where the corresponding stop-state
   loses no state and wakes up from the subsequent instruction. The
   current code doesn't handle this case.
   
This patch series addresses these issues.

The first patch in the series renames the existing
IDLE_STATE_ENTER_SEQ macro to IDLE_STATE_ENTER_SEQ_NORET. It reuses
the name IDLE_STATE_ENTER_SEQ for entering into stop-states which wake
up at the subsequent instruction.

The second patch adds a helper function in cpuidle-powernv.c for
initializing entries of the powernv_states[] table that is passed to
the cpu-idle core. This eliminates some of the code duplication in the
function that discovers and initializes the stop states.

The third patch in the series fixes issues a) and b) by ensuring that
the psscr-value and the psscr-mask provided by the firmware are what
will be used to set a particular stop state. It also adds support for
handling wake-up from stop states which were entered with ESL=EC=0.

The third patch also handles the older firmware which sets only the
Requested Level (RL) field in the psscr and psscr-mask exposed in the
device tree. In the presence of such older firmware, this patch will
set the default sane values for for remaining PSSCR fields (i.e PSLL,
MTL, ESL, EC, and TR).

The fourth patch provides the documentation for the device-tree
bindings describing the idle state properties under the @power-mgt
node in the device-tree.

The skiboot patch populates all the relevant fields in the PSSCR
values and the mask for all the stop states can be found here:
https://lists.ozlabs.org/pipermail/skiboot/2016-September/004869.html

The patches are based on top of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes

Gautham R. Shenoy (4):
  powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
  cpuidle:powernv: Add helper function to populate powernv idle states.
  powernv: Pass PSSCR value and mask to power9_idle_stop
  Documentation:powerpc: Add device-tree bindings for power-mgt

 .../devicetree/bindings/powerpc/opal/power-mgt.txt | 123 +++++++++++++++++++++
 arch/powerpc/include/asm/cpuidle.h                 |  46 +++++++-
 arch/powerpc/include/asm/processor.h               |   3 +-
 arch/powerpc/kernel/exceptions-64s.S               |   6 +-
 arch/powerpc/kernel/idle_book3s.S                  |  41 ++++---
 arch/powerpc/platforms/powernv/idle.c              |  81 +++++++++++---
 arch/powerpc/platforms/powernv/powernv.h           |   3 +-
 arch/powerpc/platforms/powernv/smp.c               |  14 ++-
 drivers/cpuidle/cpuidle-powernv.c                  | 113 ++++++++++++-------
 include/linux/cpuidle.h                            |   1 +
 10 files changed, 348 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt

-- 
1.9.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
