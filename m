Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BABC433E0
	for <linux-pm@archiver.kernel.org>; Thu, 14 Jan 2021 18:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49ABE23B3E
	for <linux-pm@archiver.kernel.org>; Thu, 14 Jan 2021 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbhANSmg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:42:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53368 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbhANSmg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 13:42:36 -0500
Received: from 89-64-81-33.dynamic.chello.pl (89.64.81.33) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 53ba55cc67cb7881; Thu, 14 Jan 2021 19:41:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH] driver core: Extend device_is_dependent()
Date:   Thu, 14 Jan 2021 19:41:53 +0100
Message-ID: <2073294.4OfjquceTg@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When adding a new device link, device_is_dependent() is used to
check whether or not the prospective supplier device does not
depend on the prospective consumer one to avoid adding loops
to the graph of device dependencies.

However, device_is_dependent() does not take the ancestors of
the target device into account, so it may not detect an existing
reverse dependency if, for example, the parent of the target
device depends on the device passed as its first argument.

For this reason, extend device_is_dependent() to also check if
the device passed as its first argument is an ancestor of the
target one and return 1 if that is the case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Stephan Gerhold <stephan@gerhold.net> 
---
 drivers/base/core.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
 #endif
 #endif /* !CONFIG_SRCU */
 
+static bool device_is_ancestor(struct device *dev, struct device *target)
+{
+	while (target->parent) {
+		target = target->parent;
+		if (dev == target)
+			return true;
+	}
+	return false;
+}
+
 /**
  * device_is_dependent - Check if one device depends on another one
  * @dev: Device to check dependencies for.
@@ -221,7 +231,7 @@ int device_is_dependent(struct device *d
 	struct device_link *link;
 	int ret;
 
-	if (dev == target)
+	if (dev == target || device_is_ancestor(dev, target))
 		return 1;
 
 	ret = device_for_each_child(dev, target, device_is_dependent);



