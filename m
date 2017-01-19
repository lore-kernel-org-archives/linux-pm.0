From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH 3/7] arm: fix return value of parse_cpu_capacity
Date: Thu, 19 Jan 2017 14:37:53 +0000
Message-ID: <20170119143757.14537-4-juri.lelli@arm.com>
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

parse_cpu_capacity() has to return 0 on failure, but it currently returns
1 instead if raw_capacity kcalloc failed.

Fix it by removing the negation of the return value.

Cc: Russell King <linux@arm.linux.org.uk>
Reported-by: Morten Rasmussen <morten.rasmussen@arm.com>
Fixes: 06073ee26775 ('ARM: 8621/3: parse cpu capacity-dmips-mhz from DT')
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ebf47d91b804..b439f7fff86b 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -165,7 +165,7 @@ static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			if (!raw_capacity) {
 				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
 				cap_parsing_failed = true;
-				return !ret;
+				return ret;
 			}
 		}
 		capacity_scale = max(cpu_capacity, capacity_scale);
-- 
2.10.0
