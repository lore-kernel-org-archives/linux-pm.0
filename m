From: Rajagopal Venkat <rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/3] PM / devfreq: fix stats start time stamp
Date: Tue,  8 Jan 2013 11:20:38 +0530
Message-ID: <1357624239-13938-2-git-send-email-rajagopal.venkat@linaro.org>
References: <1357624239-13938-1-git-send-email-rajagopal.venkat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1357624239-13938-1-git-send-email-rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Mark the stats start time stamp when actual load monitoring is
started for accuracy.

Signed-off-by: Rajagopal Venkat <rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/devfreq/devfreq.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 5782c9b..2843a22 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -254,9 +254,12 @@ static void devfreq_monitor(struct work_struct *work)
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
 	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
-	if (devfreq->profile->polling_ms)
+	if (devfreq->profile->polling_ms) {
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
+
+		devfreq->last_stat_updated = jiffies;
+	}
 }
 EXPORT_SYMBOL(devfreq_monitor_start);
 
@@ -498,7 +501,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->time_in_state = devm_kzalloc(dev, sizeof(unsigned int) *
 						devfreq->profile->max_state,
 						GFP_KERNEL);
-	devfreq->last_stat_updated = jiffies;
 	devfreq_set_freq_limits(devfreq);
 
 	dev_set_name(&devfreq->dev, dev_name(dev));
-- 
1.7.10.4
