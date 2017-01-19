From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/7] Documentation/ABI: add information about cpu_capacity
Date: Thu, 19 Jan 2017 14:37:52 +0000
Message-ID: <20170119143757.14537-3-juri.lelli@arm.com>
References: <20170119143757.14537-1-juri.lelli@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119143757.14537-1-juri.lelli-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, juri.lelli-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

/sys/devices/system/cpu/cpu#/cpu_capacity describe information about
CPUs heterogeneity (ref. to Documentation/devicetree/bindings/arm/
cpu-capacity.txt).

Add such description.

Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 2a4a423d08e0..f3d5817c4ef0 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -366,3 +366,10 @@ Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
 Description:	AArch64 CPU registers
 		'identification' directory exposes the CPU ID registers for
 		 identifying model and revision of the CPU.
+
+What:		/sys/devices/system/cpu/cpu#/cpu_capacity
+Date:		December 2016
+Contact:	Linux kernel mailing list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
+Description:	information about CPUs heterogeneity.
+
+		cpu_capacity: capacity of cpu#.
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
