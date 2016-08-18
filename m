From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [RFC/PATCH 0/2] powernv:cpuidle: Enable winkle idle state
Date: Fri, 19 Aug 2016 03:56:53 +0530
Message-ID: <cover.1471557381.git.ego@linux.vnet.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <michael.neuling@au1.ibm.com>, Paul Mackerras <paulus@samba.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Hi,

The patches in these series enable support for Winkle idle state in
CPU-Idle.

The first patch is a platform-independent CPU-Idle patch that allows
CPU-Idle states to be  disabled at start (Currently they are all
enabled by default).

The second patch adds the winkle enablement for powernv-cpuidle. By
default, the winkle idle-state is disabled. It can be enabled by
writing zero to the per-cpu cpuidle sysfs control file named
"disable".

This series has been lightly tested on a 2-socket POWER8 system and
the machine was pretty stable while running kernbench and ebizzy. I
didn't see any regressions with those.

I haven't yet evaluated the impact that these patches might have
on latency sensitive workloads. I hope to do that in a day or two.

On the power-savings front, I could observe 6-8% additional
power-savings when winkle state was enabled on an idle system with
SMT=on. With SMT=off, additional idle power-savings observed with
winkle enabled were greater than 15%.  The numbers indicate that it
might be worth the while to pursue this!


Gautham R. Shenoy (2):
  cpuidle: Allow idle-states to be disabled at start
  powernv:cpuidle: Enable winkle idle state in CPU-Idle.

 drivers/cpuidle/cpuidle-powernv.c | 44 ++++++++++++++++++++++++++++++++-------
 drivers/cpuidle/cpuidle.c         |  7 +++++++
 include/linux/cpuidle.h           |  7 ++++++-
 3 files changed, 49 insertions(+), 9 deletions(-)

-- 
1.9.4
