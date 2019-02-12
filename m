From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 4/7] include: devfreq: add polling_idle_ms to 'profile'
Date: Tue, 12 Feb 2019 23:23:55 +0100
Message-ID: <1550010238-24002-5-git-send-email-l.luba@partner.samsung.com>
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222434eucas1p134dcdce827df19704c698fd6452b0a06@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Add needed fields to support new state: idle, where different polling
interval is in use. It provides better control of the devfreq device
and lower the power consumption when the device is not busy.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/linux/devfreq.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index fbffa74..5140970 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -72,6 +72,11 @@ struct devfreq_dev_status {
  * @initial_freq:	The operating frequency when devfreq_add_device() is
  *			called.
  * @polling_ms:		The polling interval in ms. 0 disables polling.
+ * @polling_idle_ms:	The polling interval in 'idle state' in ms.
+ *			When the device is running at lowest frequency and has
+ *			low-load, it is considered as in 'idle state'.
+ *			Thus, longer polling interval is used for the device
+ *			to save some power.
  * @target:		The device should set its operating frequency at
  *			freq or lowest-upper-than-freq value. If freq is
  *			higher than any operable frequency, set maximum.
@@ -98,6 +103,7 @@ struct devfreq_dev_status {
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
 	unsigned int polling_ms;
+	unsigned int polling_idle_ms;
 
 	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
 	int (*get_dev_status)(struct device *dev,
-- 
2.7.4
