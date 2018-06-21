From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 06/12] PM / devfreq: Make update_devfreq() public
Date: Wed, 20 Jun 2018 18:52:31 -0700
Message-ID: <20180621015237.100100-7-mka@chromium.org>
References: <20180621015237.100100-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621015237.100100-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Currently update_devfreq() is only visible to devfreq governors outside
of devfreq.c. Make it public to allow drivers that adjust devfreq policies
to cause a re-evaluation of the frequency after a policy change.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
--
Changed in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- added 'Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>' tag
---
 drivers/devfreq/governor.h | 3 ---
 include/linux/devfreq.h    | 8 ++++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index b81700244ce3..f53339ca610f 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -57,9 +57,6 @@ struct devfreq_governor {
 				unsigned int event, void *data);
 };
 
-/* Caution: devfreq->lock must be locked before calling update_devfreq */
-extern int update_devfreq(struct devfreq *devfreq);
-
 extern void devfreq_monitor_start(struct devfreq *devfreq);
 extern void devfreq_monitor_stop(struct devfreq *devfreq);
 extern void devfreq_monitor_suspend(struct devfreq *devfreq);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 7c8dce96db73..c4f84a769cb5 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -222,6 +222,14 @@ extern void devm_devfreq_remove_device(struct device *dev,
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
+/**
+ * update_devfreq() - Reevaluate the device and configure frequency
+ * @devfreq:	the devfreq device
+ *
+ * Note: devfreq->lock must be held
+ */
+extern int update_devfreq(struct devfreq *devfreq);
+
 /* Helper functions for devfreq user device driver with OPP. */
 extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags);
-- 
2.18.0.rc2.346.g013aa6912e-goog
