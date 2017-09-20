From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] PM / OPP: Call notifier without holding opp_table->lock
Date: Wed, 20 Sep 2017 13:25:28 -0700
Message-ID: <5b70f7bdf12975f869a83f77e36bf3a40e0fa4b9.1505939072.git.viresh.kumar@linaro.org>
References: <59C2414E.6020803@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59C2414E.6020803@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, cw00.choi@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, myungjoo.ham@samsung.com, inki.dae@samsung.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The notifier callbacks may want to call some OPP helper routines which
may try to take the same opp_table->lock again and cause a deadlock. One
such usecase was reported by Chanwoo Choi, where calling
dev_pm_opp_disable() leads us to the devfreq's OPP notifier handler,
which further calls dev_pm_opp_find_freq_floor() and it deadlocks.

We don't really need the opp_table->lock to be held across the notifier
call though, all we want to make sure is that the 'opp' doesn't get
freed while being used from within the notifier chain. We can do it with
help of dev_pm_opp_get/put() as well. Let's do it.

Reported-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- s/Lets/Let's/ in commit log and added Stephen's tag.

 drivers/base/power/opp/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4360b4efcd4c..668fd940d362 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1627,6 +1627,9 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 
 	opp->available = availability_req;
 
+	dev_pm_opp_get(opp);
+	mutex_unlock(&opp_table->lock);
+
 	/* Notify the change of the OPP availability */
 	if (availability_req)
 		blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ENABLE,
@@ -1635,8 +1638,12 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 		blocking_notifier_call_chain(&opp_table->head,
 					     OPP_EVENT_DISABLE, opp);
 
+	dev_pm_opp_put(opp);
+	goto put_table;
+
 unlock:
 	mutex_unlock(&opp_table->lock);
+put_table:
 	dev_pm_opp_put_opp_table(opp_table);
 	return r;
 }
-- 
2.7.4
