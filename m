Return-Path: <SRS0=fmUR=CQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3044C43461
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 17:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0952080A
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 17:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgIGR6k (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:58:40 -0400
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:55890 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729355AbgIGR6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2020 13:58:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C87BB100E7B44;
        Mon,  7 Sep 2020 17:58:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: point00_13148c4270ce
X-Filterd-Recvd-Size: 2473
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 17:58:19 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/4] drivers core: Reindent a couple uses around sysfs_emit
Date:   Mon,  7 Sep 2020 10:58:07 -0700
Message-Id: <88db4a1fc2aaaa827f74542b99325928be4113a2.1599501047.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1599501047.git.joe@perches.com>
References: <cover.1599501047.git.joe@perches.com>
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
index 60abdb27137b..f10e8236aba8 100644
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
index c3d303c4c9c2..eace289938e0 100644
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

