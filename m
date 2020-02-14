Return-Path: <SRS0=AHLa=4C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C796C2BA83
	for <linux-pm@archiver.kernel.org>; Fri, 14 Feb 2020 17:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7597C20873
	for <linux-pm@archiver.kernel.org>; Fri, 14 Feb 2020 17:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701814;
	bh=pkzmAGkgONH4rFn4Kchybr1EOFbP5fb3Z/OEklRicnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LoYWsjflZkLFTyK13VwfNWeUQmc+rS9I/cOlKpb591utAQeEecIp5ZcsJ9jx60avW
	 I6H8rZWByOfxfAa+zyesI5/L7l5RBmXUkur4DqtLtVcc0JHyOd6JLqRLJkeaNPqKLq
	 ZJBCtcNwKDKVC7p70scm/i1tOHcdTf5az8xZeGS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbgBNRgr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:36:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389779AbgBNQFW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787312187F;
        Fri, 14 Feb 2020 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696322;
        bh=pkzmAGkgONH4rFn4Kchybr1EOFbP5fb3Z/OEklRicnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXL7ygHtkma4OBYbpdsjIYBTaYbiLNcxq54bN2gaP/DtI3HLVqV14owCVDuBqZiXT
         J0pQDOGADPeIzw8LAfeKRPvd6tAIQsVGP4sfwCD5a4e8SVzLKbp0By5M1uYgJmZh6H
         ceOlQcityVFTnL2kbUhg0qGtcGwt9b3dGAu54Acc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 162/459] opp: Free static OPPs on errors while adding them
Date:   Fri, 14 Feb 2020 10:56:52 -0500
Message-Id: <20200214160149.11681-162-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit ba0033192145cbd4e70ef64552958b13d597eb9e ]

The static OPPs aren't getting freed properly, if errors occur while
adding them. Fix that by calling _put_opp_list_kref() and putting their
reference on failures.

Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/opp/of.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1cbb58240b801..1e5fcdee043c4 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -678,15 +678,17 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
 			of_node_put(np);
-			return ret;
+			goto put_list_kref;
 		} else if (opp) {
 			count++;
 		}
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count))
-		return -ENOENT;
+	if (WARN_ON(!count)) {
+		ret = -ENOENT;
+		goto put_list_kref;
+	}
 
 	list_for_each_entry(opp, &opp_table->opp_list, node)
 		pstate_count += !!opp->pstate;
@@ -695,7 +697,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	if (pstate_count && pstate_count != count) {
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto put_list_kref;
 	}
 
 	if (pstate_count)
@@ -704,6 +707,11 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	opp_table->parsed_static_opps = true;
 
 	return 0;
+
+put_list_kref:
+	_put_opp_list_kref(opp_table);
+
+	return ret;
 }
 
 /* Initializes OPP tables based on old-deprecated bindings */
@@ -738,6 +746,7 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
+			_put_opp_list_kref(opp_table);
 			return ret;
 		}
 		nr -= 2;
-- 
2.20.1

