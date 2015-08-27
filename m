From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v5 5/5] PM / devfreq: drop comment about thermal setting max_freq
Date: Thu, 27 Aug 2015 11:55:51 +0100
Message-ID: <1440672951-7002-6-git-send-email-javi.merino@arm.com>
References: <1440672951-7002-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440672951-7002-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com, rufus.hamade@imgtec.com, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

The thermal infrastructure should use the devfreq cooling device, which
uses the OPP library to disable OPPs as necessary.

Fix a couple of typos in the same comment while we are at it.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/devfreq/devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ca1b362d77e2..aed1137b2173 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -177,10 +177,10 @@ int update_devfreq(struct devfreq *devfreq)
 		return err;
 
 	/*
-	 * Adjust the freuqency with user freq and QoS.
+	 * Adjust the frequency with user freq and QoS.
 	 *
-	 * List from the highest proiority
-	 * max_freq (probably called by thermal when it's too hot)
+	 * List from the highest priority
+	 * max_freq
 	 * min_freq
 	 */
 
-- 
1.9.1
