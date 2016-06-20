From: Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 03/12] PM,devfreq: Employ atomic_fetch_inc()
Date: Mon, 20 Jun 2016 13:05:55 -0700
Message-ID: <1466453164-13185-4-git-send-email-dave@stgolabs.net>
References: <1466453164-13185-1-git-send-email-dave@stgolabs.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:43561 "EHLO
	smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbcFTUHg (ORCPT
	<rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
	Mon, 20 Jun 2016 16:07:36 -0400
In-Reply-To: <1466453164-13185-1-git-send-email-dave@stgolabs.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: davem@davemloft.net, cw00.choi@samsung.com, dougthompson@xmission.com, bp@alien8.de, mchehab@osg.samsung.com, gregkh@linuxfoundation.org, pfg@sgi.com, jikos@kernel.org, hans.verkuil@cisco.com, awalls@md.metrocast.net, dledford@redhat.com, sean.hefty@intel.com, kys@microsoft.com, heiko.carstens@de.ibm.com, James.Bottomley@HansenPartnership.com, sumit.semwal@linaro.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, dave@stgolabs.net, linux-pm@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>

Now that we have fetch_inc() we can stop using inc_return() - 1.

These are very similar to the existing OP-RETURN primitives we already
have, except they return the value of the atomic variable _before_
modification.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/devfreq/devfreq-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 39b048eda2ce..45b02d3d7e7d 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -329,7 +329,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	edev->dev.class = devfreq_event_class;
 	edev->dev.release = devfreq_event_release_edev;
 
-	dev_set_name(&edev->dev, "event.%d", atomic_inc_return(&event_no) - 1);
+	dev_set_name(&edev->dev, "event.%d", atomic_fetch_inc(&event_no));
 	ret = device_register(&edev->dev);
 	if (ret < 0) {
 		put_device(&edev->dev);
-- 
2.6.6

