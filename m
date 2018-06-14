From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 01/12] PM / devfreq: Init user limits from OPP limits, not viceversa
Date: Thu, 14 Jun 2018 12:47:01 -0700
Message-ID: <20180614194712.102134-2-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
the devfreq device") introduced the initialization of the user
limits min/max_freq from the lowest/highest available OPPs. Later
commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
frequency") added scaling_min/max_freq, which actually represent
the frequencies of the lowest/highest available OPP. scaling_min/
max_freq are initialized with the values from min/max_freq, which
is totally correct in the context, but a bit awkward to read.

Swap the initialization and assign scaling_min/max_freq with the
OPP freqs and then the user limts min/max_freq with scaling_min/
max_freq.

Needless to say that this change is a NOP, intended to improve
readability.
---
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Changes in v3:
- none

Changes in v2:
- added 'Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>' tag

 drivers/devfreq/devfreq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fe2af6aa88fc..0057ef5b0a98 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -604,21 +604,21 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_lock(&devfreq->lock);
 	}
 
-	devfreq->min_freq = find_available_min_freq(devfreq);
-	if (!devfreq->min_freq) {
+	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
+	if (!devfreq->scaling_min_freq) {
 		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->scaling_min_freq = devfreq->min_freq;
+	devfreq->min_freq = devfreq->scaling_min_freq;
 
-	devfreq->max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->max_freq) {
+	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
+	if (!devfreq->scaling_max_freq) {
 		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->scaling_max_freq = devfreq->max_freq;
+	devfreq->max_freq = devfreq->scaling_max_freq;
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
-- 
2.18.0.rc1.242.g61856ae69a-goog
