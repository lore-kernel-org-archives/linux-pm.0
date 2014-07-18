From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
Date: Fri, 18 Jul 2014 15:09:53 +0100
Message-ID: <1405692594-19352-2-git-send-email-punit.agrawal@arm.com>
References: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:52300 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934609AbaGROLg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 10:11:36 -0400
In-Reply-To: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: orjan.eide@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

=46rom: =C3=98rjan Eide <orjan.eide@arm.com>

These functions are indended for use by drivers and should be available
also when the driver is built as a module.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: =C3=98rjan Eide <orjan.eide@arm.com>
---
 drivers/devfreq/devfreq.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 9f90369..30b538d8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1119,6 +1119,7 @@ struct dev_pm_opp *devfreq_recommended_opp(struct=
 device *dev,
=20
 	return opp;
 }
+EXPORT_SYMBOL(devfreq_recommended_opp);
=20
 /**
  * devfreq_register_opp_notifier() - Helper function to get devfreq no=
tified
@@ -1142,6 +1143,7 @@ int devfreq_register_opp_notifier(struct device *=
dev, struct devfreq *devfreq)
=20
 	return ret;
 }
+EXPORT_SYMBOL(devfreq_register_opp_notifier);
=20
 /**
  * devfreq_unregister_opp_notifier() - Helper function to stop getting=
 devfreq
@@ -1168,6 +1170,7 @@ int devfreq_unregister_opp_notifier(struct device=
 *dev, struct devfreq *devfreq)
=20
 	return ret;
 }
+EXPORT_SYMBOL(devfreq_unregister_opp_notifier);
=20
 static void devm_devfreq_opp_release(struct device *dev, void *res)
 {
--=20
1.7.10.4

