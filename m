From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH v2 00/15] DT/core: update cpu device of_node
Date: Wed, 17 Jul 2013 15:06:09 +0100
Message-ID: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

As more and more information is getting added into the cpu node, the number
of drivers needing to parse the device tree for CPU nodes are increasing.
Most of the time, the information needed from the cpu node is preferred
in the logical CPU order. Hence many drivers first parse and search the
CPU node, match them to logical index if needed and then search for the
required property inside a particular cpu node. Some of them assume the
logical and physical CPU ordering to be same which is incorrect.

This patch series initialises the of_node in all the cpu devices when
registering the CPU device.
1. This avoids different drivers having to parse the cpu nodes to obtain
   different attributes like operating points, latency,...etc.
2. This handles different physical and logical cpu ordering which is not
   the case in current code.
3. Also all the cpu nodes will have their of_node initialised correctly.
   Currently different drivers assign them partially and incorrectly.
4. Removes all the reduntant parsing in various drivers.

Changes v1->v2:
1. Moved most of arch_of_get_cpu_node to OF/DT core as of_get_cpu_node
   adding a provision for architecture specific hooks for matching
   logical and physical ids.
2. Extended removal of DT cpu node parsing to PPC cpufreq drivers
3. Added Acks from Viresh and Shawn

Regards,
Sudeep

Sudeep KarkadaNagesha (15):
  of: add support for retrieving cpu node for a given logical cpu index
  driver/core: cpu: initialize of_node in cpu's device struture
  ARM: DT/kernel: define ARM specific arch_match_cpu_phys_id
  ARM: topology: remove hwid/MPIDR dependency from cpu_capacity
  ARM: mvebu: remove device tree parsing for cpu nodes
  drivers/bus: arm-cci: avoid parsing DT for cpu device nodes
  cpufreq: imx6q-cpufreq: remove device tree parsing for cpu nodes
  cpufreq: cpufreq-cpu0: remove device tree parsing for cpu nodes
  cpufreq: highbank-cpufreq: remove device tree parsing for cpu nodes
  cpufreq: spear-cpufreq: remove device tree parsing for cpu nodes
  cpufreq: kirkwood-cpufreq: remove device tree parsing for cpu nodes
  cpufreq: arm_big_little: remove device tree parsing for cpu nodes
  cpufreq: maple-cpufreq: remove device tree parsing for cpu nodes
  cpufreq: pmac64-cpufreq: remove device tree parsing for cpu nodes
  cpufreq: pmac32-cpufreq: remove device tree parsing for cpu nodes

 arch/arm/kernel/devtree.c           |  5 +++
 arch/arm/kernel/topology.c          | 61 +++++++++++----------------------=
-
 arch/arm/mach-imx/mach-imx6q.c      |  3 +-
 arch/arm/mach-mvebu/platsmp.c       | 52 ++++++++++++++---------------
 drivers/base/cpu.c                  |  2 ++
 drivers/bus/arm-cci.c               | 28 ++++------------
 drivers/cpufreq/arm_big_little_dt.c | 39 ++++++++++------------
 drivers/cpufreq/cpufreq-cpu0.c      | 23 +++----------
 drivers/cpufreq/highbank-cpufreq.c  | 18 ++++------
 drivers/cpufreq/imx6q-cpufreq.c     |  4 +--
 drivers/cpufreq/kirkwood-cpufreq.c  | 14 ++++++--
 drivers/cpufreq/maple-cpufreq.c     | 23 ++++---------
 drivers/cpufreq/pmac32-cpufreq.c    | 11 ++++++-
 drivers/cpufreq/pmac64-cpufreq.c    | 54 ++++++++++--------------------
 drivers/cpufreq/spear-cpufreq.c     | 10 +++++-
 drivers/of/base.c                   | 66 +++++++++++++++++++++++++++++++++=
++++
 include/linux/of.h                  |  5 +++
 17 files changed, 213 insertions(+), 205 deletions(-)

--=20
1.8.1.2


