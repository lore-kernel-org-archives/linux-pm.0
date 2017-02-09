From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v2 2/9] Documentation/ABI: add information about cpu_capacity
Date: Thu,  9 Feb 2017 09:25:18 +0000
Message-ID: <20170209092525.6654-3-juri.lelli@arm.com>
References: <20170209092525.6654-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170209092525.6654-1-juri.lelli@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, juri.lelli@arm.com, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org, dietmar.eggemann@arm.com, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
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
