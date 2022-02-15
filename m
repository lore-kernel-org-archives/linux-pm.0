Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D796C433F5
	for <linux-pm@archiver.kernel.org>; Tue, 15 Feb 2022 00:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiBOAyF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 14 Feb 2022 19:54:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiBOAx4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 19:53:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBD8145AF8;
        Mon, 14 Feb 2022 16:53:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so974187pjv.5;
        Mon, 14 Feb 2022 16:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GniugwCBRot+g0mQTXvaIL/7nwoTX5TsSIiFOKffpis=;
        b=aeWOm9QayhfBDEezRJj42f59gvzMGiJczqeKX3RBsDN77Qb8eeiXdrTqVJdCR8to3c
         xFdjqNpsVsEZs+EXfgozb17spbUi4RQCyw3/LeT7NKZTg+RyZe5TO6FaTibiYvK5Ap/o
         y/tPK6t6RxGCII9wAnYGhvzOc8gjEe2y2AqZ9QnKU/u4pmF1HX4JC1ySFvZwh8zIjhoc
         x9sxPvNmYoY1SCQipP/V/d+UWhmj6EpAt7Os4rjHBJcqsftye3M9r5wng2boXRe/1LPn
         G6bkRP+CZuTWrh47SeZdYv1OY4yAQJPCgst/YyJgCMwA9ipn0iyGvwU0BniyiOlGSfnc
         GceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GniugwCBRot+g0mQTXvaIL/7nwoTX5TsSIiFOKffpis=;
        b=Y1DisF0a7fZOwdRIiDDd4qE0EDb8fX34dloKP66GyUe2Io0cS1KkjRlaPuJZeS6hu8
         PDujBt0WXEV3Sg7dN+Oe8GQ+/yoE2PFBmtiB6/8X3eoOjtHLhhSylO51rkJY+T+AYJVa
         r5A6VH5YWjcLY33Oexf1BzXwA9rC6pfDG9THia6sRanMorrTjxR/y0yMgDOJSxAzSwr3
         sCqwP5tKF0zxzZTVJjPJmtwtUCQYqBLb8I696VIyagtcgIq9PsfEOP0SmvFe+6EuNLiR
         yaRqZmKNo1Wo0Oygfp7Rv4ZUHWo4n25fg2xAn2SsHOB3HBhMYZSXSX96Q9s0wSrMvAQs
         HwBA==
X-Gm-Message-State: AOAM532MotMvAsGmaIsw3PKsVhZAuCHydQxFcxf74v8gn9csjkLrjIwa
        X7OYqwHFs6LBRSvYXW/TnBM=
X-Google-Smtp-Source: ABdhPJwf3PeI9WQkibFLQkgzCE5C/ipxp9YFytHwJ4Bs5P/fpD+4xQF/lVMKCXK7sHKKQEhWxyGXYQ==
X-Received: by 2002:a17:902:f78c:: with SMTP id q12mr1513147pln.165.1644886408101;
        Mon, 14 Feb 2022 16:53:28 -0800 (PST)
Received: from localhost.localdomain (192.243.120.247.16clouds.com. [192.243.120.247])
        by smtp.gmail.com with ESMTPSA id 16sm14935161pje.34.2022.02.14.16.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 16:53:27 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     t.schramm@manjaro.org
Cc:     davidcomponentone@gmail.com, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] power: supply: cw2015: Fix application of sizeof to pointer
Date:   Tue, 15 Feb 2022 08:53:11 +0800
Message-Id: <a45647609e9d87e8fee643920b1479492956df2a.1644837424.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The coccinelle check report:
./drivers/power/supply/cw2015_battery.c:692:12-18:
ERROR: application of sizeof to pointer

Using the real size to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/power/supply/cw2015_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 0c87ad0dbf71..db56db322b64 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -689,7 +689,7 @@ static int cw_bat_probe(struct i2c_client *client)
 	if (ret) {
 		/* Allocate an empty battery */
 		cw_bat->battery = devm_kzalloc(&client->dev,
-					       sizeof(cw_bat->battery),
+					       sizeof(*(cw_bat->battery)),
 					       GFP_KERNEL);
 		if (!cw_bat->battery)
 			return -ENOMEM;
-- 
2.30.2

