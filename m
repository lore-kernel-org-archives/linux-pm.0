From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 2/2] power: at91-reset: Constify platform_device_id
Date: Sat,  2 May 2015 00:46:44 +0900
Message-ID: <1430495204-31363-2-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495204-31363-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430495204-31363-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-pm@vger.kernel.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/power/reset/at91-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 01c7055c4200..4bfd9056eef5 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -243,7 +243,7 @@ static int at91_reset_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id at91_reset_plat_match[] = {
+static const struct platform_device_id at91_reset_plat_match[] = {
 	{ "at91-sam9260-reset", (unsigned long)at91sam9260_restart },
 	{ "at91-sam9g45-reset", (unsigned long)at91sam9g45_restart },
 	{ /* sentinel */ }
-- 
2.1.4
