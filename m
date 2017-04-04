From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v5 5/5] ARM: keystone: Drop PM domain support for k2g
Date: Mon, 3 Apr 2017 21:47:32 -0500
Message-ID: <20170404024732.32699-6-d-gerlach@ti.com>
References: <20170404024732.32699-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170404024732.32699-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

K2G will use a different power domain driver than the rest of the
keystone family in order to make use of the TI SCI protocol so prevent
the standard keystone pm_domain code from registering itself in
preparation for a new driver.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-keystone/pm_domain.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index 8cbb35765a19..fe57e2692629 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -32,7 +32,9 @@ static struct pm_clk_notifier_block platform_domain_notifier = {
 };
 
 static const struct of_device_id of_keystone_table[] = {
-	{.compatible = "ti,keystone"},
+	{.compatible = "ti,k2hk"},
+	{.compatible = "ti,k2e"},
+	{.compatible = "ti,k2l"},
 	{ /* end of list */ },
 };
 
-- 
2.11.0
