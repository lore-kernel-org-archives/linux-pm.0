From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/6] PM / QOS: Add default case to the switch
Date: Thu,  9 Feb 2017 09:11:47 +0530
Message-ID: <338b16e4c882634e30e4f4c011a9e9c52d134cbc.1486611268.git.viresh.kumar@linaro.org>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486611268.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1486611268.git.viresh.kumar@linaro.org>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The switch block handles all the QOS request types present today, but
starts giving compilation warnings as soon as a new type is added and
not handled in this.

To prevent against that, add the default case as well and do a WARN from
it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/qos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 58fcc758334e..01f615b18055 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -621,6 +621,9 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
 		req = dev->power.qos->flags_req;
 		dev->power.qos->flags_req = NULL;
 		break;
+	default:
+		WARN_ON(1);
+		return;
 	}
 	__dev_pm_qos_remove_request(req);
 	kfree(req);
-- 
2.7.1.410.g6faf27b
