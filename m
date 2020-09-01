Return-Path: <SRS0=Ebod=CK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE69C43461
	for <linux-pm@archiver.kernel.org>; Tue,  1 Sep 2020 17:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADFE207D3
	for <linux-pm@archiver.kernel.org>; Tue,  1 Sep 2020 17:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgIARj5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:39:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64710 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgIARj4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 13:39:56 -0400
Received: from 89-64-88-247.dynamic.chello.pl (89.64.88.247) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 9794ea559f62b2f3; Tue, 1 Sep 2020 19:39:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v4 1/5] cpufreq: intel_pstate: Refuse to turn off with HWP enabled
Date:   Tue, 01 Sep 2020 19:25:53 +0200
Message-ID: <5860605.v7HuRlE7Aj@kreacher>
In-Reply-To: <3748218.V0HrpZKF9g@kreacher>
References: <3748218.V0HrpZKF9g@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

After commit f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive
mode with HWP enabled") it is possible to change the driver status
to "off" via sysfs with HWP enabled, which effectively causes the
driver to unregister itself, but HWP remains active and it forces the
minimum performance, so even if another cpufreq driver is loaded,
it will not be able to control the CPU frequency.

For this reason, make the driver refuse to change the status to
"off" with HWP enabled.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v4: No changes

---
 drivers/cpufreq/intel_pstate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e0220a6fbc69..bcda1e700a73 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2716,9 +2716,15 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 {
 	int ret;
 
-	if (size == 3 && !strncmp(buf, "off", size))
-		return intel_pstate_driver ?
-			intel_pstate_unregister_driver() : -EINVAL;
+	if (size == 3 && !strncmp(buf, "off", size)) {
+		if (!intel_pstate_driver)
+			return -EINVAL;
+
+		if (hwp_active)
+			return -EBUSY;
+
+		return intel_pstate_unregister_driver();
+	}
 
 	if (size == 6 && !strncmp(buf, "active", size)) {
 		if (intel_pstate_driver) {
-- 
2.26.2




