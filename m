From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 4/6] devfreq: add devfreq_suspend/resume() functions
Date: Wed, 21 Nov 2018 19:01:39 +0100
Message-ID: <1542823301-23563-5-git-send-email-l.luba@partner.samsung.com>
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds implementation for global suspend/resume for
devfreq framework. System suspend will next use these functions.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  7 +++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7e09de8..2f4391c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -44,6 +44,9 @@ static LIST_HEAD(devfreq_governor_list);
 static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
 
+/* Flag showing state of suspend/resume */
+static bool devfreq_suspended;
+
 /**
  * find_device_devfreq() - find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
@@ -938,6 +941,52 @@ int devfreq_resume_device(struct devfreq *devfreq)
 EXPORT_SYMBOL(devfreq_resume_device);
 
 /**
+ * devfreq_suspend() - Suspend devfreq governors and devices
+ *
+ * Called during system wide Suspend/Hibernate cycles for suspending governors
+ * and devices preserving the state for resume. On some platforms the devfreq
+ * device must have precise state (frequency) after resume in order to provide
+ * fully operating setup.
+ */
+void devfreq_suspend(void)
+{
+	struct devfreq *devfreq;
+	int ret;
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		ret = devfreq_suspend_device(devfreq);
+		if (ret)
+			dev_warn(&devfreq->dev, "device suspend failed\n");
+	}
+	mutex_unlock(&devfreq_list_lock);
+
+	devfreq_suspended = true;
+}
+
+/**
+ * devfreq_resume() - Resume devfreq governors and devices
+ *
+ * Called during system wide Suspend/Hibernate cycle for resuming governors and
+ * devices that are suspended with devfreq_suspend().
+ */
+void devfreq_resume(void)
+{
+	struct devfreq *devfreq;
+	int ret;
+
+	devfreq_suspended = false;
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		ret = devfreq_resume_device(devfreq);
+		if (ret)
+			dev_warn(&devfreq->dev, "device resume failed\n");
+	}
+	mutex_unlock(&devfreq_list_lock);
+}
+
+/**
  * devfreq_add_governor() - Add devfreq governor
  * @governor:	the devfreq governor to be added
  */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 7fe96f9..4f0fea8 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -202,6 +202,10 @@ extern void devm_devfreq_remove_device(struct device *dev,
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
+
+extern void devfreq_suspend(void);
+extern void devfreq_resume(void);
+
 /**
  * update_devfreq() - Reevaluate the device and configure frequency
  * @devfreq:	the devfreq device
@@ -396,6 +400,9 @@ static inline int devfreq_update_stats(struct devfreq *df)
 {
 	return -EINVAL;
 }
+
+static inline void devfreq_suspend(void) {}
+static inline void devfreq_resume(void) {}
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
2.7.4
