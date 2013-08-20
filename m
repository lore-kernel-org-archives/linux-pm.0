From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v4 02/19] openrisc: remove undefined of_get_cpu_node
 declaration
Date: Tue, 20 Aug 2013 10:30:04 +0100
Message-ID: <1376991021-12160-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
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
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

This patch removes the declaration of the function 'of_get_cpu_node'
which is not defined for openrisc. This is in preparation to move
it's definition from PPC to DT common code.

Again it could be there as it was originally copied from powerpc.

Cc: Jonas Bonn <jonas@southpole.se>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/openrisc/include/asm/prom.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/include/asm/prom.h b/arch/openrisc/include/asm/prom.h
index bbb34e5..eb59bfe 100644
--- a/arch/openrisc/include/asm/prom.h
+++ b/arch/openrisc/include/asm/prom.h
@@ -44,9 +44,6 @@ void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
 
 extern void kdump_move_device_tree(void);
 
-/* CPU OF node matching */
-struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
-
 /* Get the MAC address */
 extern const void *of_get_mac_address(struct device_node *np);
 
-- 
1.8.1.2
