From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v3 2/9] Documentation/ABI: add information about cpu_capacity
Date: Mon, 27 Mar 2017 14:18:18 +0100
Message-ID: <20170327131825.32134-3-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327131825.32134-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org
List-Id: linux-pm@vger.kernel.org

/sys/devices/system/cpu/cpu#/cpu_capacity describe information about
CPUs heterogeneity (ref. to Documentation/devicetree/bindings/arm/
cpu-capacity.txt).

Add such description.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 2a4a423d08e0..f3d5817c4ef0 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -366,3 +366,10 @@ Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
 Description:	AArch64 CPU registers
 		'identification' directory exposes the CPU ID registers for
 		 identifying model and revision of the CPU.
+
+What:		/sys/devices/system/cpu/cpu#/cpu_capacity
+Date:		December 2016
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	information about CPUs heterogeneity.
+
+		cpu_capacity: capacity of cpu#.
-- 
2.10.0
