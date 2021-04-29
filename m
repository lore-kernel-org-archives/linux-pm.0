Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBE0C433ED
	for <linux-pm@archiver.kernel.org>; Thu, 29 Apr 2021 01:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC106143A
	for <linux-pm@archiver.kernel.org>; Thu, 29 Apr 2021 01:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhD2BJX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 28 Apr 2021 21:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD2BJW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 21:09:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B043C06138B;
        Wed, 28 Apr 2021 18:08:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so97380749ejc.4;
        Wed, 28 Apr 2021 18:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OMLFjLReOb2JwNxzWO6xyUiZXAv/sqF1QolMUD4D7A=;
        b=ncV3ZqawPPttw+QVtlDecYRJhUWMej3+hKvkHiNYQ9GeZIB/do3461XYDJ+K7Q7dkO
         lytuhhzbCgUIa+iHhSco7sfiAe4YIPZ1kUawVn1IgfaKJMKQfR7VLqOJyDxKOw8WgSK9
         16uYjTX7SrKPaxm7UhLpehDveYgyY57mD5EnNMYntgmwtIOBwf8c7eT7wygLhUecXnvv
         diY6V7NA06KpFkG12gNShYhhsrIws+BBCBZEHVgSfY8kuGBoB1KqZpwaRfEBC9wBZ0sp
         D+R957udwuvXrHpe04dxfLtRDX63updfjjJ4uHPChU+CAEajckqIeDZ24UbMHu76TBd8
         SMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OMLFjLReOb2JwNxzWO6xyUiZXAv/sqF1QolMUD4D7A=;
        b=Dj+H8GiYerS9fAu9hiShgY45eUOOTjRWYQKFvABiFP2phxg6Rj1nJT1VehhcsrPEgu
         0da1k7dFNaD6M8mXwZNdkkzvRIDwx6zO2jzc25gBRin80PXqrSK9eDJVN2M5dxJukVBF
         610BPL7V6pw4mEVSjfVDJtg8YFp8KZz8xuvfFgoGMhYP0cPC96XjsH0qZn7yilClPvPA
         rzuzULYFtSvPa8u+YOGCUkSlrxx08GGwYKf/Qwq1qqlIf4gWDO73h0ehxzqKgCOXl3rz
         RjEfkcg64CQy1TwnVQRdhl/PAAg0fdKQ4I2CbKUYnE+uMgzgnFagMz5I/uJLYsoE0x22
         BHpg==
X-Gm-Message-State: AOAM530pECrMoHYZ0JoMtgWByeM/07oKRiHO09UeWuawhalvKZiUmrUB
        L/RzVfJgSroWlgbVabFgPfUhEvc/c6P9MA==
X-Google-Smtp-Source: ABdhPJx+QA1nwtL0nBSCep/X68DDBSwioqe2HJhuMfeuIbutnIvsGY3GqnRrMbiuPn89Z/iCtS/1Pw==
X-Received: by 2002:a17:906:494d:: with SMTP id f13mr14561587ejt.490.1619658515152;
        Wed, 28 Apr 2021 18:08:35 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id d5sm1113398edt.49.2021.04.28.18.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 18:08:34 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [thermal-next PATCH v2 2/2] thermal: qcom: tsens: simplify debugfs init function
Date:   Thu, 29 Apr 2021 03:05:18 +0200
Message-Id: <20210429010518.13319-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210429010518.13319-1-ansuelsmth@gmail.com>
References: <20210429010518.13319-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify debugfs init function.
- Add check for existing dev directory.
- Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
  incorrectly reported)

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b37d5fd71f3a..e43898bf3199 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -657,7 +657,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
 			return ret;
 		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
 	} else {
-		seq_puts(s, "0.1.0\n");
+		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
 	}
 
 	return 0;
@@ -669,16 +669,12 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
 static void tsens_debug_init(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
-	struct dentry *root, *file;
 
-	root = debugfs_lookup("tsens", NULL);
-	if (!root)
+	priv->debug_root = debugfs_lookup("tsens", NULL);
+	if (!priv->debug_root)
 		priv->debug_root = debugfs_create_dir("tsens", NULL);
-	else
-		priv->debug_root = root;
 
-	file = debugfs_lookup("version", priv->debug_root);
-	if (!file)
+	if (!debugfs_lookup("version", priv->debug_root))
 		debugfs_create_file("version", 0444, priv->debug_root,
 				    pdev, &dbg_version_fops);
 
-- 
2.30.2

