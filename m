Return-Path: <SRS0=R0/j=5J=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58592C4332B
	for <linux-pm@archiver.kernel.org>; Tue, 24 Mar 2020 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3654E20658
	for <linux-pm@archiver.kernel.org>; Tue, 24 Mar 2020 12:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCXMU1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:20:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:33838 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbgCXMU1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 08:20:27 -0400
IronPort-SDR: 4bj7BVe2fsrnKU2IHOxZNn7RU9Z6+cFxeQFTMYk7h64xVnBdm9GLIYPf/FXfetFdaSUEfY+1dj
 SHcckQpV9HHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 05:20:26 -0700
IronPort-SDR: QrKiMwNd8E1VplOjPkJMHyaiCbhHS8lmlleMbrQ6JC6wLiVwJwanrbvQPrX0bQXEQVnSomXjxT
 4tXaI7YD5qBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="238218894"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Mar 2020 05:20:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 939D214B; Tue, 24 Mar 2020 14:20:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] driver core: Replace open-coded list_last_entry()
Date:   Tue, 24 Mar 2020 14:20:23 +0200
Message-Id: <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a place in the code where open-coded version of list entry accessors
list_last_entry() is used.

Replace that with the standard macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no change
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index efd0e4c16ba5..27a4d51b5bba 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1226,7 +1226,7 @@ void driver_detach(struct device_driver *drv)
 			spin_unlock(&drv->p->klist_devices.k_lock);
 			break;
 		}
-		dev_prv = list_entry(drv->p->klist_devices.k_list.prev,
+		dev_prv = list_last_entry(&drv->p->klist_devices.k_list,
 				     struct device_private,
 				     knode_driver.n_node);
 		dev = dev_prv->device;
-- 
2.25.1

