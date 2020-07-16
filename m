Return-Path: <SRS0=Jmv8=A3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE34C433E0
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 02:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D842076C
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 02:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGPCzD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGPCzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 22:55:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6524C061755;
        Wed, 15 Jul 2020 19:55:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: wlozano)
        with ESMTPSA id ED2ED2A3753
From:   Walter Lozano <walter.lozano@collabora.com>
To:     linux-pm@vger.kernel.org
Cc:     kernel@collabora.com, Walter Lozano <walter.lozano@collabora.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Increase parsed_static_opps on _of_add_opp_table_v1
Date:   Wed, 15 Jul 2020 23:54:52 -0300
Message-Id: <20200716025452.25761-1-walter.lozano@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, when using _of_add_opp_table_v2 parsed_static_opps is
increased and this value is used on _opp_remove_all_static to
check if there are static opps entries that need to be freed.
Unfortunately this does not happens when using _of_add_opp_table_v1,
which leads to warnings.

This patch increases parsed_static_opps on _of_add_opp_table_v1 in a
similar way as in _of_add_opp_table_v2.

Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
---

 drivers/opp/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9a5873591a40..b2bc82bf8b42 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -917,6 +917,8 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		nr -= 2;
 	}
 
+	opp_table->parsed_static_opps++;
+
 	return ret;
 }
 
-- 
2.20.1

