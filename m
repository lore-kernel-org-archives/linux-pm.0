From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH 5/7] arm64: remove wrong CONFIG_PROC_SYSCTL ifdef
Date: Thu, 19 Jan 2017 14:37:55 +0000
Message-ID: <20170119143757.14537-6-juri.lelli@arm.com>
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

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-and-suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: be8f185d8af4 ('arm64: add sysfs cpu_capacity attribute')
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm64/kernel/topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 23e9e13bd2aa..62b370388d72 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -40,7 +40,6 @@ static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
-#ifdef CONFIG_PROC_SYSCTL
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -97,7 +96,6 @@ static int register_cpu_capacity_sysctl(void)
 	return 0;
 }
 subsys_initcall(register_cpu_capacity_sysctl);
-#endif
 
 static u32 capacity_scale;
 static u32 *raw_capacity;
-- 
2.10.0
