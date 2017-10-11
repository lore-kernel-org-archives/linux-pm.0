From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 5/8] PM / devfreq: Get the available next frequency on
 update_devfreq()
Date: Wed, 11 Oct 2017 12:09:21 +0900
Message-ID: <1507691364-3899-6-git-send-email-cw00.choi@samsung.com>
References: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171011030947epcas1p1133ca20bb9356453c331751b3e3bba4b@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The update_devfreq() considers only user frequency (min_freq/max_freq)
and the next target_freq provided by the governor. But, the commit
a76caf55e5b35 ("thermal: Add devfreq cooling") is able to disable
OPP as a cooling device. In result, the update_devfreq() have to
consider the 'opp->available' status in order to decicde the next freq
by the devfreq_recommended_opp().

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1c4b377cacfb..3b9662ffe603 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -255,6 +255,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
 int update_devfreq(struct devfreq *devfreq)
 {
 	struct devfreq_freqs freqs;
+	struct dev_pm_opp *opp;
 	unsigned long freq, cur_freq;
 	int err = 0;
 	u32 flags = 0;
@@ -273,7 +274,7 @@ int update_devfreq(struct devfreq *devfreq)
 		return err;
 
 	/*
-	 * Adjust the frequency with user freq and QoS.
+	 * Adjust the frequency with user freq, QoS and available freq.
 	 *
 	 * List from the highest priority
 	 * max_freq
@@ -289,6 +290,12 @@ int update_devfreq(struct devfreq *devfreq)
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
 
+	opp = devfreq_recommended_opp(devfreq->dev.parent, &freq, flags);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+	freq = dev_pm_opp_get_freq(opp);
+	dev_pm_opp_put(opp);
+
 	if (devfreq->profile->get_cur_freq)
 		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
 	else
-- 
1.9.1
