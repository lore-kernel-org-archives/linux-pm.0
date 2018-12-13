From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 55/73] thermal: armada: fix legacy validity test sense
Date: Wed, 12 Dec 2018 23:28:20 -0500
Message-ID: <20181213042838.75160-55-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>, Eduardo Valentin <edubezval@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 70bb27b79adf63ea39e37371d09c823c7a8f93ce ]

Commit 8c0e64ac4075 ("thermal: armada: get rid of the ->is_valid()
pointer") removed the unnecessary indirection through a function
pointer, but in doing so, also removed the negation operator too:

-       if (priv->data->is_valid && !priv->data->is_valid(priv)) {
+       if (armada_is_valid(priv)) {

which results in:

armada_thermal f06f808c.thermal: Temperature sensor reading not valid
armada_thermal f2400078.thermal: Temperature sensor reading not valid
armada_thermal f4400078.thermal: Temperature sensor reading not valid

at boot, or whenever the "temp" sysfs file is read.  Replace the
negation operator.

Fixes: 8c0e64ac4075 ("thermal: armada: get rid of the ->is_valid() pointer")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/armada_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 2c2f6d93034e..e16b3cb1808c 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -357,7 +357,7 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 	int ret;
 
 	/* Valid check */
-	if (armada_is_valid(priv)) {
+	if (!armada_is_valid(priv)) {
 		dev_err(priv->dev,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
-- 
2.19.1
