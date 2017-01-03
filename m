From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/6] PM / QOS: Add default case to the switch
Date: Tue,  3 Jan 2017 16:36:07 +0530
Message-ID: <476c2130ecb697b4e9f427be0dd247a6a6d3ef81.1483439894.git.viresh.kumar@linaro.org>
References: <cover.1483439894.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1483439894.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483439894.git.viresh.kumar@linaro.org>
References: <cover.1483439894.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
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
