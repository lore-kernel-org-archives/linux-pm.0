From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/4] power: supply: sc2731_charger: Avoid repeated charge/discharge
Date: Mon, 12 Nov 2018 18:52:37 +0800
Message-ID: <2298d92a4156f331f9e317d6bc6eed0ff88677bb.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Add info->charging validation to avoid repeated charge or discharge
operation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc2731_charger.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index a012d6c..49b3f0c 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -328,7 +328,7 @@ static void sc2731_charger_work(struct work_struct *data)
 
 	mutex_lock(&info->lock);
 
-	if (info->limit > 0) {
+	if (info->limit > 0 && !info->charging) {
 		/* set current limitation and start to charge */
 		ret = sc2731_charger_set_current_limit(info, info->limit);
 		if (ret)
@@ -343,7 +343,7 @@ static void sc2731_charger_work(struct work_struct *data)
 			goto out;
 
 		info->charging = true;
-	} else {
+	} else if (!info->limit && info->charging) {
 		/* Stop charging */
 		info->charging = false;
 		sc2731_charger_stop_charge(info);
-- 
1.7.9.5
