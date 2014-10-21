From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 4/8] ARM: at91: sam9g45/sam9rl: probe the ramc driver
Date: Tue, 21 Oct 2014 23:55:36 +0200
Message-ID: <1413928540-27099-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413928540-27099-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1413928540-27099-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Probe the atmel-sdramc driver from the board files, using platform_data.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9g45.c | 20 ++++++++++++++++++++
 arch/arm/mach-at91/at91sam9rl.c  | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 405427ec05f8..202d9438e1d9 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -415,6 +415,25 @@ static struct platform_device rstc_device = {
 	.num_resources  = ARRAY_SIZE(rstc_resources),
 };
 
+static struct resource ramc_resources[] = {
+	[0] = {
+		.start  = AT91SAM9G45_BASE_DDRSDRC1,
+		.end    = AT91SAM9G45_BASE_DDRSDRC1 + SZ_512 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = AT91SAM9G45_BASE_DDRSDRC0,
+		.end    = AT91SAM9G45_BASE_DDRSDRC0 + SZ_512 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device rstc_device = {
+	.name           = "at91-sam9g45-ramc",
+	.resource       = ramc_resources,
+	.num_resources  = ARRAY_SIZE(ramc_resources),
+};
+
 static struct resource shdwc_resources[] = {
 	[0] = {
 		.start  = AT91SAM9G45_BASE_SHDWC,
@@ -431,6 +450,7 @@ static struct platform_device shdwc_device = {
 
 static void __init at91sam9g45_register_devices(void)
 {
+	platform_device_register(&ramc_device);
 	platform_device_register(&rstc_device);
 	platform_device_register(&shdwc_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index f553e4ea034b..0e2cb3361b15 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -348,6 +348,20 @@ static struct platform_device rstc_device = {
 	.num_resources  = ARRAY_SIZE(rstc_resources),
 };
 
+static struct resource ramc_resources[] = {
+	[0] = {
+		.start  = AT91SAM9RL_BASE_SDRAMC,
+		.end    = AT91SAM9RL_BASE_SDRAMC + SZ_512 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device ramc_device = {
+	.name           = "at91-sam9260-ramc",
+	.resource       = ramc_resources,
+	.num_resources  = ARRAY_SIZE(ramc_resources),
+};
+
 static struct resource shdwc_resources[] = {
 	[0] = {
 		.start  = AT91SAM9RL_BASE_SHDWC,
@@ -364,6 +378,7 @@ static struct platform_device shdwc_device = {
 
 static void __init at91sam9rl_register_devices(void)
 {
+	platform_device_register(&ramc_device);
 	platform_device_register(&rstc_device);
 	platform_device_register(&shdwc_device);
 }
-- 
1.9.1
