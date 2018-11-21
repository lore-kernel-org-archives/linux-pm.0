From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 3/6] devfreq: add support for suspend/resume of a devfreq
 device
Date: Wed, 21 Nov 2018 19:01:38 +0100
Message-ID: <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, len.brown@intel.com, tony.luck@intel.com, keescook@chromium.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, anton@enomsg.org, rjw@rjwysocki.net, robh+dt@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>, tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, pavel@ucw.cz, ccross@android.com, krzk@kernel.org, m.szyprowski@samsung.com
List-Id: linux-pm@vger.kernel.org

The patch adds support for handling suspend/resume process.
It uses atomic variables to make sure no race condition
affects the process.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index cf9c643..7e09de8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -872,14 +872,33 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
-	if (!devfreq)
-		return -EINVAL;
+        int ret;
+        unsigned long prev_freq;
+        u32 flags = 0;
+
+        if (!devfreq)
+                return -EINVAL;
+
+        if (devfreq->governor) {
+		ret = devfreq->governor->event_handler(devfreq,
+					DEVFREQ_GOV_SUSPEND, NULL);
+		if (ret)
+			return ret;
+	}
 
-	if (!devfreq->governor)
-		return 0;
+	if (devfreq->suspend_freq) {
+		if (atomic_inc_return(&devfreq->suspend_count) > 1)
+			return 0;
 
-	return devfreq->governor->event_handler(devfreq,
-				DEVFREQ_GOV_SUSPEND, NULL);
+		ret = devfreq_set_target(devfreq, devfreq->suspend_freq,
+					 &prev_freq, flags);
+		if (ret)
+			return ret;
+
+		devfreq->resume_freq = prev_freq;
+	}
+
+        return 0;
 }
 EXPORT_SYMBOL(devfreq_suspend_device);
 
@@ -893,9 +912,23 @@ EXPORT_SYMBOL(devfreq_suspend_device);
  */
 int devfreq_resume_device(struct devfreq *devfreq)
 {
+        int ret;
+        unsigned long prev_freq;
+        u32 flags = 0;
+
 	if (!devfreq)
 		return -EINVAL;
 
+	if (devfreq->suspend_freq) {
+		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
+			return 0;
+
+		ret = devfreq_set_target(devfreq, devfreq->resume_freq,
+					 &prev_freq, flags);
+		if (ret)
+			return ret;
+	}
+
 	if (!devfreq->governor)
 		return 0;
 
-- 
2.7.4
