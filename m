Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E929C55178
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 01:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30F2206A1
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 01:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437262AbgJ0BrY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Oct 2020 21:47:24 -0400
Received: from mail-m1272.qiye.163.com ([115.236.127.2]:19799 "EHLO
        mail-m1272.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504056AbgJ0BrY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 21:47:24 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 21:47:23 EDT
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by mail-m1272.qiye.163.com (Hmail) with ESMTPA id 49ABAB01FDE;
        Tue, 27 Oct 2020 09:37:50 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v2] drivers/thermal: optimize the for circle to run a bit fast
Date:   Mon, 26 Oct 2020 18:37:42 -0700
Message-Id: <20201027013743.62392-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0sdTUpJSBpDGh1LVkpNS0hMTUlNTEtOTExVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6UQw5KT8vSigLFx1LHQgw
        DA4wFBFVSlVKTUtITE1JTUxLQkxKVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlOQ1VJ
        SkhVQ0hVSk5MWVdZCAFZQUlIS0M3Bg++
X-HM-Tid: 0a7567b44b7598b7kuuu49abab01fde
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Function thermal_zone_device_register, in the for circle, if the
first if branch set the count bit in tz->trips_disabled, there is
no need to set in the other if branch again.
This change is to make the code run a bit fast and readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*make the code more clear and readable

Link for V1:
*https://lore.kernel.org/patchwork/patch/1324507/
---
 drivers/thermal/thermal_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c6d74bc1c90b..3d1e0033bf3e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1446,12 +1446,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		goto release_device;
 
 	for (count = 0; count < trips; count++) {
-		if (tz->ops->get_trip_type(tz, count, &trip_type))
-			set_bit(count, &tz->trips_disabled);
-		if (tz->ops->get_trip_temp(tz, count, &trip_temp))
-			set_bit(count, &tz->trips_disabled);
-		/* Check for bogus trip points */
-		if (trip_temp == 0)
+		if (tz->ops->get_trip_type(tz, count, &trip_type) ||
+		    tz->ops->get_trip_temp(tz, count, &trip_temp) ||
+		    !trip_temp)
 			set_bit(count, &tz->trips_disabled);
 	}
 
-- 
2.28.0

