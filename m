Return-Path: <SRS0=+UCx=EJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC77AC55178
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1322242C
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604416411;
	bh=ZCbFeQADKo3yAgfHLi4t3D1MnzyuZ6vb29qyxOt4Yhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJgaWzvhLMSW5ZLUFAhHDlI+tbeT82ZPl/W27XaB6lIXJz7mMaHk0Xg41MXvncTDU
	 cFJLCsjqKZwc48/iASzN3IjpLwYfAAF5KN9Pb65K5cPGYvMtVTfqk9ZR4cAmD1fFC3
	 CXofWQm7fq+bDK8ldCBJ1DXn/y8q91x+5OGb11jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgKCPNa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgKCPMC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:02 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4902920780;
        Tue,  3 Nov 2020 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416322;
        bh=ZCbFeQADKo3yAgfHLi4t3D1MnzyuZ6vb29qyxOt4Yhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMLU9pysq4Mnh2gsQIxNT5NhIktlUBO8FIPysDMMI1g5hp2rZ6TgnBi3M7B0JKDRv
         d+5wj8ODhM3CabMrl0it9YLcOJl1cjXI3b+td7Aq2qTNmFe58ZEWzf/ku4Q1vKJe13
         DJlEZQ1uutrB80WgeBhQhAArPGfx90clbHkwB/Nw=
Received: by pali.im (Postfix)
        id 34616161E; Tue,  3 Nov 2020 16:12:00 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] cpufreq: highbank: Add missing MODULE_DEVICE_TABLE
Date:   Tue,  3 Nov 2020 16:11:32 +0100
Message-Id: <20201103151139.29690-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201103151139.29690-1-pali@kernel.org>
References: <20201103151139.29690-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this cpufreq driver when it is
compiled as an external module.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 6754f556103be ("cpufreq / highbank: add support for highbank cpufreq")
---
 drivers/cpufreq/highbank-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
index 5a7f6dafcddb..ac57cddc5f2f 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -101,6 +101,13 @@ static int hb_cpufreq_driver_init(void)
 }
 module_init(hb_cpufreq_driver_init);
 
+static const struct of_device_id __maybe_unused hb_cpufreq_of_match[] = {
+	{ .compatible = "calxeda,highbank" },
+	{ .compatible = "calxeda,ecx-2000" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, hb_cpufreq_of_match);
+
 MODULE_AUTHOR("Mark Langsdorf <mark.langsdorf@calxeda.com>");
 MODULE_DESCRIPTION("Calxeda Highbank cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1

