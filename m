From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 6/6] PM / devfreq: Reject client provided freq_table
Date: Tue, 24 Apr 2018 15:35:21 -0700
Message-ID: <20180424223521.28193-7-bjorn.andersson@linaro.org>
References: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The devfreq profile's freq_table is an internal resource used to keep
track of all levels described in the associated opp table, in order to
support levels being enabled and disabled in runtime by e.g.
devfreq_cooling.

As it is required by the implementation that the device has an
associated opp table and expected that the freq_table matches this, it
is not possible for clients to provide a freq_table through the devfreq
profile.

Check for this in devfreq_add_device() and remove the unnecessary
conditional generation of the internal freq_table.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c804bd72a644..3d1f6a2edf68 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -557,7 +557,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	static atomic_t devfreq_no = ATOMIC_INIT(-1);
 	int err = 0;
 
-	if (!dev || !profile || !governor_name) {
+	if (!dev || !profile || !governor_name || profile->freq_table) {
 		dev_err(dev, "%s: Invalid parameters.\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
@@ -590,11 +590,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
-	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
-		err = set_freq_table(devfreq);
-		if (err < 0)
-			goto err_dev;
-	}
+	err = set_freq_table(devfreq);
+	if (err < 0)
+		goto err_dev;
 
 	devfreq->min_freq = find_available_min_freq(devfreq);
 	if (!devfreq->min_freq) {
-- 
2.16.2
