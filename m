From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 4/4] PM / Domains: Use domain-idle-state compatible
Date: Tue, 25 Oct 2016 08:26:39 -0700
Message-ID: <1477409199-52182-5-git-send-email-lina.iyer@linaro.org>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Use the more specific "domain-idle-states" compatible property to read
idle state properties from DT.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index aac656a..07ed835 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2048,7 +2048,7 @@ out:
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
 static const struct of_device_id idle_state_match[] = {
-	{ .compatible = "arm,idle-state", },
+	{ .compatible = "domain-idle-state", },
 	{ }
 };
 
-- 
2.7.4
