Return-Path: <SRS0=Yl30=UA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F15DC28CC1
	for <linux-pm@archiver.kernel.org>; Sat,  1 Jun 2019 13:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C20C2750D
	for <linux-pm@archiver.kernel.org>; Sat,  1 Jun 2019 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396022;
	bh=dre30RdEQXy41bPIIowne0S263PWWWGLIDPuhU17HJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ycfi4AVzKk6m95MBR0Y+Z4gCWszNwRnerkkNZhJbOxzePQvf1iZOYNEJBiBvghS48
	 7pTfnQaqg9qc7U3qGGRlldeqRxjmFpBWXg6BqDEYFeP+wnWVV67dJ66AWdvW7lxgQx
	 4sZRMNNPF5ptyrBqjlNBXK4+yAqbG9Q1KOMv/WCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfFANY0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbfFANY0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Jun 2019 09:24:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60D3F27355;
        Sat,  1 Jun 2019 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395465;
        bh=dre30RdEQXy41bPIIowne0S263PWWWGLIDPuhU17HJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9RmorXG4qA6JqrabuNUOG1FGznLnxNgr4UWb+PdrEQGEK0b8CvfkekIwGW62Fbes
         7wFSk9fQKaNEmqxYuKqYJWCqemOBrnZuVhkAkkOgo3yII0NzflU4eSj1K7F50JOqMa
         CM4+3uTH/1WveTzbWhHczJ8VU6OZbiXbclAEL8nk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/99] drivers: thermal: tsens: Don't print error message on -EPROBE_DEFER
Date:   Sat,  1 Jun 2019 09:22:22 -0400
Message-Id: <20190601132346.26558-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132346.26558-1-sashal@kernel.org>
References: <20190601132346.26558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Amit Kucheria <amit.kucheria@linaro.org>

[ Upstream commit fc7d18cf6a923cde7f5e7ba2c1105bb106d3e29a ]

We print a calibration failure message on -EPROBE_DEFER from
nvmem/qfprom as follows:
[    3.003090] qcom-tsens 4a9000.thermal-sensor: version: 1.4
[    3.005376] qcom-tsens 4a9000.thermal-sensor: tsens calibration failed
[    3.113248] qcom-tsens 4a9000.thermal-sensor: version: 1.4

This confuses people when, in fact, calibration succeeds later when
nvmem/qfprom device is available. Don't print this message on a
-EPROBE_DEFER.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qcom/tsens.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3f9fe6aa51ccc..ebbe1ec7b9e83 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -162,7 +162,8 @@ static int tsens_probe(struct platform_device *pdev)
 	if (tmdev->ops->calibrate) {
 		ret = tmdev->ops->calibrate(tmdev);
 		if (ret < 0) {
-			dev_err(dev, "tsens calibration failed\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "tsens calibration failed\n");
 			return ret;
 		}
 	}
-- 
2.20.1

