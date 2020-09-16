Return-Path: <SRS0=SH1q=CZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5FEC433E2
	for <linux-pm@archiver.kernel.org>; Wed, 16 Sep 2020 20:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050CE20770
	for <linux-pm@archiver.kernel.org>; Wed, 16 Sep 2020 20:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgIPUlK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:41:10 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:54106 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgIPUlI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 16:41:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 14424182CF665;
        Wed, 16 Sep 2020 20:41:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mark37_29160942711c
X-Filterd-Recvd-Size: 2593
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:41:01 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH V3 4/8] drivers core: Reindent a couple uses around sysfs_emit
Date:   Wed, 16 Sep 2020 13:40:41 -0700
Message-Id: <33224191421dbb56015eded428edfddcba997d63.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1600285923.git.joe@perches.com>
References: <cover.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just a couple of whitespace realignment to open parenthesis for
multi-line statements.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/node.c        | 4 ++--
 drivers/base/power/sysfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f6bde7acd5fe..b2dcca375da6 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -386,9 +386,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(i.freeram),
 		       nid, K(i.totalram - i.freeram),
 		       nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
-				node_page_state(pgdat, NR_ACTIVE_FILE)),
+			      node_page_state(pgdat, NR_ACTIVE_FILE)),
 		       nid, K(node_page_state(pgdat, NR_INACTIVE_ANON) +
-				node_page_state(pgdat, NR_INACTIVE_FILE)),
+			      node_page_state(pgdat, NR_INACTIVE_FILE)),
 		       nid, K(node_page_state(pgdat, NR_ACTIVE_ANON)),
 		       nid, K(node_page_state(pgdat, NR_INACTIVE_ANON)),
 		       nid, K(node_page_state(pgdat, NR_ACTIVE_FILE)),
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 61e16786f6c5..e05207abb99e 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -102,7 +102,7 @@ static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	return sysfs_emit(buf, "%s\n",
-				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
+			  dev->power.runtime_auto ? ctrl_auto : ctrl_on);
 }
 
 static ssize_t control_store(struct device * dev, struct device_attribute *attr,
-- 
2.26.0

