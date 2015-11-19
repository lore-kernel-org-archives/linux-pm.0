From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 6/6] PM / devfreq: Set the min_freq and max_freq of devfreq
 device
Date: Thu, 19 Nov 2015 17:17:50 +0900
Message-ID: <1447921070-6045-7-git-send-email-cw00.choi@samsung.com>
References: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

After probing the devfreq device driver, the value of both min_freq and
max_freq are zero(0). So, this patch initializes the 'min_freq' and 'max_freq'
field of devfreq device by using the freq_table array.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c292ceb7ff19..0b24ae7b7a48 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -121,6 +121,11 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
 		profile->freq_table[i] = freq;
 	}
 	rcu_read_unlock();
+
+	mutex_lock(&devfreq->lock);
+	devfreq->min_freq = profile->freq_table[0];
+	devfreq->max_freq = profile->freq_table[profile->max_state - 1];
+	mutex_unlock(&devfreq->lock);
 }
 
 /**
-- 
1.9.1
