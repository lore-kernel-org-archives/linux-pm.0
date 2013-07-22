From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v3 03/16] driver/core: cpu: initialize of_node in cpu's device struture
Date: Mon, 22 Jul 2013 12:32:14 +0100
Message-ID: <1374492747-13879-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

CPUs are also registered as devices but the of_node in these cpu
devices are not initialized. Currently different drivers requiring
to access cpu device node are parsing the nodes themselves and
initialising the of_node in cpu device.

The of_node in all the cpu devices needs to be initialized properly
and at one place. The best place to update this is CPU subsystem
driver when registering the cpu devices.

The OF/DT core library now provides of_get_cpu_node to retrieve a cpu
device node for a given logical index by abstracting the architecture
specific details.

This patch uses of_get_cpu_node to assign of_node when registering the
cpu devices.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/base/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c358bc..ea51c6d 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
=20
 #include "base.h"
=20
@@ -289,6 +290,7 @@ int register_cpu(struct cpu *cpu, int num)
 =09cpu->dev.release =3D cpu_device_release;
 =09cpu->dev.offline_disabled =3D !cpu->hotpluggable;
 =09cpu->dev.offline =3D !cpu_online(num);
+=09cpu->dev.of_node =3D of_get_cpu_node(num);
 #ifdef CONFIG_ARCH_HAS_CPU_AUTOPROBE
 =09cpu->dev.bus->uevent =3D arch_cpu_uevent;
 #endif
--=20
1.8.1.2
