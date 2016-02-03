From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v3 3/6] arm: Enable dynamic CPU capacity initialization
Date: Wed,  3 Feb 2016 11:59:56 +0000
Message-ID: <1454500799-18451-4-git-send-email-juri.lelli@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, juri.lelli@arm.com, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, will.deacon@arm.com, dietmar.eggemann@arm.com, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Define arch_wants_init_cpu_capacity() to return true; so that
cpufreq_init_cpu_capacity() can go ahead and profile CPU capacities
at boot time.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index c9c87a5..7d7fc2c 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -52,6 +52,11 @@ void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+bool arch_wants_init_cpu_capacity(void)
+{
+	return true;
+}
+
 #ifdef CONFIG_OF
 struct cpu_efficiency {
 	const char *compatible;
-- 
2.7.0
