Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EC3C433DB
	for <linux-pm@archiver.kernel.org>; Wed, 24 Feb 2021 18:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03E464EFA
	for <linux-pm@archiver.kernel.org>; Wed, 24 Feb 2021 18:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhBXSbO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Feb 2021 13:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBXSbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 13:31:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B1CC06174A
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 10:30:33 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e10so2618853wro.12
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HNg21NrFFSzG03akl4ik4jz1Jh6GwsesirJ9uxFbwiU=;
        b=mu++/MQTLxhrxBnIq7qWduUGmbOCTgcpg/K1MUKyzsPEvgWoczFajqUT2PUn1tyqty
         88/iOpznl4DdlFoWt5bbEW8G+TWi2W2NaODfzFYFIqW7wlB0o7S7FkdXU7RmYJziWvWE
         uw7ZQspVgYGALyjNfRDxE8mA0MlnlQhKUBiWjdJ/FtGugpdAsUCdeuv7ljurlnMUDO1q
         XlAqJTQn42+dFtqhRvpwy98i2REuaJKoi0J64R4ekhZVivfZ83dVbg6n5WMzxX1aaQG6
         cV1EaqPusecLBLtdTmM++T2xseC5nGB9Qww8/N/9PCQOZY0Y0gfzzncNSImga6iY6Hvs
         zGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HNg21NrFFSzG03akl4ik4jz1Jh6GwsesirJ9uxFbwiU=;
        b=B8+Py/0HHZBnHU+8DDLQ4zluLGUieHj8Ic0FCYls4Jf8VdCPUdntZ9BEOzdqsc8Vw2
         G7KsI6jww0hOF6As8jfMjFE2k6f4WTsfC+ef+1foOZkjtBFyTB5lcTqX5l+lI3E19akb
         gFDhwc4gMGd4el/M5fb3PnnRphYxoeq9diHDlaLxPgTD848qcU39lhafA4/+PRgQ1YBW
         3G99eBvgUjtNL7Ra2n9RlOWnnJtsIKez6MRlhs5cUcjAKMzEdZZFqzPdX5xyfmcc8/Ud
         islTp7FGlqfjeBXx9RtO/JY32AF6o33E8K+DKHPQ88CQMtGCruoeGcDrr3A12rWzAAtw
         7CLg==
X-Gm-Message-State: AOAM5330oyxs7FqMCsl3zzhf7I6NowZbt1NUp3S8CbW6MXKzfRiRxE6u
        HLP+VqhAqSgL6gXm+Ycs0NL4QQ==
X-Google-Smtp-Source: ABdhPJzJy+BLK7QYhJw1l12NeERtA6m/kc2WzhAzLxQEKBKKAcv85+3becrDuG5cYXWTx+aCViGE3g==
X-Received: by 2002:adf:8151:: with SMTP id 75mr3926866wrm.152.1614191431901;
        Wed, 24 Feb 2021 10:30:31 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id c12sm5105987wru.71.2021.02.24.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:30:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] powercap/drivers/dtpm: Fix root node initialization
Date:   Wed, 24 Feb 2021 19:30:21 +0100
Message-Id: <20210224183022.11846-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The root node is not set to NULL when the dtpm root node is
removed. Consequently, it is not possible to create a new root as it
is already set.

Set the root node to NULL when the last node is removed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 5a51cd34a7e8..c2185ec5f887 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -207,6 +207,9 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 	if (dtpm->ops)
 		dtpm->ops->release(dtpm);
 
+	if (root == dtpm)
+		root = NULL;
+
 	kfree(dtpm);
 
 	return 0;
-- 
2.17.1

