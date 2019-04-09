Return-Path: <SRS0=kGmN=SL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B1DC10F13
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 02:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673BB213F2
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 02:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw3XOPvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfDIC0D (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:26:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42552 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDIC0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 22:26:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so8373741pgh.9
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2019 19:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1yFBlLIRtZfhlb3srtkw9Y5OqnGv4j679hLxxjat+iE=;
        b=iw3XOPvjBy4iuWquw/5w4E4R20e35cyxVf8JqkspMBMOFBGjDc6PIxYzeJwlEWDGGz
         p0ZaC697SFIVf/dbw3AgGcCcFD5S40Fx402mjs7R2rjAjY2YLepMDd2QgUhwgaa3xPZk
         uaUISBa41AfSdjo3qiGEcWq1FI8vy7cVxeaHxqdHMzKUPTK6ChCODOiJ98b1TAGuQBVX
         Zr4GE+X/OZ1rwLAqCC1f9GO7AqdBuFTb/zSB/EYc+/RgRzCRaXg8ADLCzjiL7cDbPKvj
         RmJJwCfflyRCEmOecpTf3GcdRtTyAUpAlNNcE512gnxF/YVkK10PIZ74A3vgneUgQR4Q
         /Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1yFBlLIRtZfhlb3srtkw9Y5OqnGv4j679hLxxjat+iE=;
        b=FiYyZq/Q8Uue76NALdg5Y+FxKQRmbt5OsXXMwFCjoDnfGLtHYk+jSTqD/vO1rkuQFm
         eQfrVRULe/BM79kpAWHx4nVLnp4N63H2Peii6sWBjmmRVnk8VhXDsVeTWI0haXSELAIX
         QYLAhDkc7eVNBxu2Ne4KJcuyKTHdeRdRx/iMadH/rgDkifSP/qwyoCl7ItDLWohhZZNy
         TvX37JkmCWQHtWnzEagYOT0QLK/0Dyw/NJK1h2rvyPfpvG9nN0OT+Km0uGdNORILAn/y
         wG+cLIoWH1LzYOGre0azwjVdVQa4bgnmQidmbEs65vUJ3V5PALzmlzBXQe04cQhnwP1v
         QKVg==
X-Gm-Message-State: APjAAAXQCmA5b0O/dlU4mQniuFWu2IJa2HG6pFPj6o6s7NvV8s5IM08y
        JqFC8Fy718TXYS1UaO7yOQQ=
X-Google-Smtp-Source: APXvYqy4OzJUUacyNUgswGGah9FjzpZREnibwsWBeNYVKxPrwxLsDEDDGCqQj0lFDSBKWnrh0NGVmA==
X-Received: by 2002:a62:61c2:: with SMTP id v185mr33911934pfb.117.1554776761998;
        Mon, 08 Apr 2019 19:26:01 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id f7sm57000029pga.56.2019.04.08.19.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 19:26:01 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] cpufreq: Remove cpufreq_driver check in cpufreq_boost_supported()
Date:   Tue,  9 Apr 2019 10:25:36 +0800
Message-Id: <20190409022536.6164-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently there are three calling paths for cpufreq_boost_supported() in
all as below, we can see the cpufreq_driver null check is needless since
it is already checked before.

<path1>
  cpufreq_enable_boost_support()
    |-> if (!cpufreq_driver)
    |-> cpufreq_boost_supported()

<path2>
  cpufreq_register_driver()
    |-> if (!driver_data ...
    |-> cpufreq_driver = driver_data
    |-> cpufreq_boost_supported()
    |-> remove_boost_sysfs_file()
          |-> cpufreq_boost_supported()

<path3>
  cpufreq_unregister_driver()
    |-> if (!cpufreq_driver ...
    |-> remove_boost_sysfs_file()
          |-> cpufreq_boost_supported()

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e109227..d9123de 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2426,7 +2426,7 @@ int cpufreq_boost_trigger_state(int state)
 
 static bool cpufreq_boost_supported(void)
 {
-	return likely(cpufreq_driver) && cpufreq_driver->set_boost;
+	return cpufreq_driver->set_boost;
 }
 
 static int create_boost_sysfs_file(void)
-- 
1.9.1

