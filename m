Return-Path: <SRS0=0A/B=XR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF31FC3A5A6
	for <linux-pm@archiver.kernel.org>; Sun, 22 Sep 2019 19:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5F120869
	for <linux-pm@archiver.kernel.org>; Sun, 22 Sep 2019 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180309;
	bh=J2I7SM7bMsl2OQ6fr2CABIWGTg6EorLiy5htaNXQeuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ex5fn7Hias2Z08m6d9mYm2SGNro793VhUDImcJ1v/StauTEKb0EOWoTooEH7MLDVB
	 U9kbs5/301pK2d84DFkGoRQqjeGAlAf0qLZGWdKO2YuAjaNXUqqGYSjCwnrdavqUtA
	 y1oaOflsZ31uWUv/UmKEin70ynBq5MVZeNSB8X38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407925AbfIVSwd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407920AbfIVSwc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 22 Sep 2019 14:52:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B3A2190F;
        Sun, 22 Sep 2019 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178351;
        bh=J2I7SM7bMsl2OQ6fr2CABIWGTg6EorLiy5htaNXQeuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2FKOsrpFEH5b2PgV1WDbOq3YQARZux3T/pxnbQ2yyl2ZpGRd95uE+49JgMaVKe3k
         yjsh4l9NC43ppmJv4SVaqc3yXvFaTqihj/r003cU4Yf0c337A8wxv9pFfT/DEShLJu
         oBsTWxj8+K8M80OifZx4U6psFyRmP0s/FI6w2uGQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 108/185] PM / devfreq: Fix kernel oops on governor module load
Date:   Sun, 22 Sep 2019 14:48:06 -0400
Message-Id: <20190922184924.32534-108-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

[ Upstream commit 7544fd7f384591038646d3cd9efb311ab4509e24 ]

A bit unexpectedly (but still documented), request_module may
return a positive value, in case of a modprobe error.
This is currently causing issues in the devfreq framework.

When a request_module exits with a positive value, we currently
return that via ERR_PTR. However, because the value is positive,
it's not a ERR_VALUE proper, and is therefore treated as a
valid struct devfreq_governor pointer, leading to a kernel oops.

Fix this by returning -EINVAL if request_module returns a positive
value.

Fixes: b53b0128052ff ("PM / devfreq: Fix static checker warning in try_then_request_governor")
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ab22bf8a12d69..a0e19802149fc 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
 		/* Restore previous state before return */
 		mutex_lock(&devfreq_list_lock);
 		if (err)
-			return ERR_PTR(err);
+			return (err < 0) ? ERR_PTR(err) : ERR_PTR(-EINVAL);
 
 		governor = find_devfreq_governor(name);
 	}
-- 
2.20.1

