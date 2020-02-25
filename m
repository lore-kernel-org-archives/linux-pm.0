Return-Path: <SRS0=jPMq=4N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9258AC35DE1
	for <linux-pm@archiver.kernel.org>; Tue, 25 Feb 2020 12:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BD620726
	for <linux-pm@archiver.kernel.org>; Tue, 25 Feb 2020 12:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgBYMuY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:50:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60286 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgBYMuI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 07:50:08 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j6Zf4-0005kT-AU; Tue, 25 Feb 2020 12:50:06 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-pm@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v5 9/9] net: fix sysfs permssions when device changes network namespace
Date:   Tue, 25 Feb 2020 13:49:48 +0100
Message-Id: <20200225124948.80682-10-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225124948.80682-1-christian.brauner@ubuntu.com>
References: <20200225124948.80682-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that we moved all the helpers in place and make use netdev_change_owner()
to fixup the permissions when moving network devices between network
namespaces.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
unchanged

/* v5 */
unchanged
---
 net/core/dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a69e8bd7ed74..0f9c4684fcbd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10016,6 +10016,7 @@ EXPORT_SYMBOL(unregister_netdev);
 
 int dev_change_net_namespace(struct net_device *dev, struct net *net, const char *pat)
 {
+	struct net *net_old = dev_net(dev);
 	int err, new_nsid, new_ifindex;
 
 	ASSERT_RTNL();
@@ -10031,7 +10032,7 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net, const char
 
 	/* Get out if there is nothing todo */
 	err = 0;
-	if (net_eq(dev_net(dev), net))
+	if (net_eq(net_old, net))
 		goto out;
 
 	/* Pick the destination device name, and ensure
@@ -10107,6 +10108,12 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net, const char
 	err = device_rename(&dev->dev, dev->name);
 	WARN_ON(err);
 
+	/* Adapt owner in case owning user namespace of target network
+	 * namespace is different from the original one.
+	 */
+	err = netdev_change_owner(dev, net_old, net);
+	WARN_ON(err);
+
 	/* Add the device back in the hashes */
 	list_netdevice(dev);
 
-- 
2.25.1

