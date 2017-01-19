From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH 4/7] arm: remove wrong CONFIG_PROC_SYSCTL ifdef
Date: Thu, 19 Jan 2017 14:37:54 +0000
Message-ID: <20170119143757.14537-5-juri.lelli@arm.com>
References: <20170119143757.14537-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170119143757.14537-1-juri.lelli@arm.com>
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

The sysfs cpu_capacity entry for each CPU has nothing to do with
PROC_FS, nor it's in /proc/sys path.

Remove such ifdef.

Cc: Russell King <linux@arm.linux.org.uk>
Reported-and-suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 7e5930aaef5d ('ARM: 8622/3: add sysfs cpu_capacity attribute')
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index b439f7fff86b..c760a321935b 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -56,7 +56,6 @@ static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
-#ifdef CONFIG_PROC_SYSCTL
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -113,7 +112,6 @@ static int register_cpu_capacity_sysctl(void)
 	return 0;
 }
 subsys_initcall(register_cpu_capacity_sysctl);
-#endif
 
 #ifdef CONFIG_OF
 struct cpu_efficiency {
-- 
2.10.0
