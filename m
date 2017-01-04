From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 4/4] ARM: keystone: Drop PM domain support for k2g
Date: Wed, 4 Jan 2017 14:55:36 -0600
Message-ID: <20170104205536.15963-5-d-gerlach@ti.com>
References: <20170104205536.15963-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104205536.15963-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-pm@vger.kernel.org

K2G will use a different power domain driver than the rest of the
keystone family in order to make use of the TI SCI protocol so prevent
the standard keystone pm_domain code from registering itself in
preparation for a new driver.

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
