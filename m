From: Fengguang Wu <fengguang.wu@intel.com>
Subject: drivers/devfreq/governor_simpleondemand.c:92:5: sparse: symbol
 'devfreq_simple_ondemand_handler' was not declared. Should it be static?
Date: Tue, 23 Oct 2012 13:13:49 +0800
Message-ID: <5086278d.Wk+4wZ82+5/DqqJn%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5086278d.Wo/kweSMtB1hCOR0unxBskZ7gRx9fcoMzG8W1lV31abMSxi3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13789 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab2JWFYM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Oct 2012 01:24:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

This is a multi-part message in MIME format.

--=_5086278d.Wo/kweSMtB1hCOR0unxBskZ7gRx9fcoMzG8W1lV31abMSxi3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Rajagopal,

FYI, there are new sparse warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   13f5e2d9a915373dd1573d8fe0214738bc69004f
commit: 5001044272888cc4c1aa7e29b0e601b7719742f2 PM / devfreq: Core updates to support devices which can idle
date:   6 hours ago

+ drivers/devfreq/governor_simpleondemand.c:92:5: sparse: symbol 'devfreq_simple_ondemand_handler' was not declared. Should it be static?
--
+ drivers/devfreq/governor_userspace.c:119:5: sparse: symbol 'devfreq_userspace_handler' was not declared. Should it be static?

vim +92 drivers/devfreq/governor_simpleondemand.c

ce26c5bb MyungJoo Ham     2011-10-02   76  	/* Set the desired frequency based on the load */
ce26c5bb MyungJoo Ham     2011-10-02   77  	a = stat.busy_time;
ce26c5bb MyungJoo Ham     2011-10-02   78  	a *= stat.current_frequency;
ce26c5bb MyungJoo Ham     2011-10-02   79  	b = div_u64(a, stat.total_time);
ce26c5bb MyungJoo Ham     2011-10-02   80  	b *= 100;
ce26c5bb MyungJoo Ham     2011-10-02   81  	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
ce26c5bb MyungJoo Ham     2011-10-02   82  	*freq = (unsigned long) b;
ce26c5bb MyungJoo Ham     2011-10-02   83  
6530b9de MyungJoo Ham     2011-12-09   84  	if (df->min_freq && *freq < df->min_freq)
6530b9de MyungJoo Ham     2011-12-09   85  		*freq = df->min_freq;
6530b9de MyungJoo Ham     2011-12-09   86  	if (df->max_freq && *freq > df->max_freq)
6530b9de MyungJoo Ham     2011-12-09   87  		*freq = df->max_freq;
6530b9de MyungJoo Ham     2011-12-09   88  
ce26c5bb MyungJoo Ham     2011-10-02   89  	return 0;
ce26c5bb MyungJoo Ham     2011-10-02   90  }
ce26c5bb MyungJoo Ham     2011-10-02   91  
50010442 Rajagopal Venkat 2012-10-23  @92  int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
50010442 Rajagopal Venkat 2012-10-23   93  				unsigned int event, void *data)
50010442 Rajagopal Venkat 2012-10-23   94  {
50010442 Rajagopal Venkat 2012-10-23   95  	switch (event) {
50010442 Rajagopal Venkat 2012-10-23   96  	case DEVFREQ_GOV_START:
50010442 Rajagopal Venkat 2012-10-23   97  		devfreq_monitor_start(devfreq);
50010442 Rajagopal Venkat 2012-10-23   98  		break;
50010442 Rajagopal Venkat 2012-10-23   99  
50010442 Rajagopal Venkat 2012-10-23  100  	case DEVFREQ_GOV_STOP:

Please consider folding the attached diff :-)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

--=_5086278d.Wo/kweSMtB1hCOR0unxBskZ7gRx9fcoMzG8W1lV31abMSxi3
Content-Type: text/x-diff;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="make-it-static-5001044.diff"

diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index cf94218..3716a65 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -89,7 +89,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	return 0;
 }
 
-int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
+static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 				unsigned int event, void *data)
 {
 	switch (event) {
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 1fddee5..7067555 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -116,7 +116,7 @@ static void userspace_exit(struct devfreq *devfreq)
 	devfreq->data = NULL;
 }
 
-int devfreq_userspace_handler(struct devfreq *devfreq,
+static int devfreq_userspace_handler(struct devfreq *devfreq,
 			unsigned int event, void *data)
 {
 	int ret = 0;

--=_5086278d.Wo/kweSMtB1hCOR0unxBskZ7gRx9fcoMzG8W1lV31abMSxi3--
