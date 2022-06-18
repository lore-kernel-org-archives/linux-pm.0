Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD0C43334
	for <linux-pm@archiver.kernel.org>; Sat, 18 Jun 2022 02:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiFRC0j (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 17 Jun 2022 22:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFRC0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 22:26:37 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48D374EA19;
        Fri, 17 Jun 2022 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=W9BI6
        P0wZUTOeM9TLmKa8PQCi7xOpiT0T54lCxRxPbc=; b=ibVG8KPwq/8c02tvikycl
        pOIqVmCmLOfty7N3F6ILGT6B2d+3IX8TYRbMEnGrKe/jtvpaRjWAL5CQ7oM+X8Hd
        pJAi3rFuP1tzaiiYolrycWkWeDhx1z20LDn4kKsiwQknmkoCBEr5KFmIFPk12j6X
        jzqPwT8YJ8hCfmhALecgiU=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgCXm7CqN61iMTL+Ew--.45752S2;
        Sat, 18 Jun 2022 10:25:47 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     windhl@126.com, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: pmac32-cpufreq: Fix refcount leak bug
Date:   Sat, 18 Jun 2022 10:25:45 +0800
Message-Id: <20220618022545.4056299-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgCXm7CqN61iMTL+Ew--.45752S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry8GFWDuw1fur17urW7urg_yoWfCwc_ur
        n5WFy7Zw4UC3WIgr43Cr1Sq3sIv34fWF1FyFn2qF98Aw15Zr9Ivr48WrnrX3929w4Utw43
        Xw4qya1fuw47AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMXo2UUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgskF1-HZUmuEQAAsp
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In pmac_cpufreq_init_MacRISC3(), we need to add corresponding
of_node_put() for the three node pointers whose refcount have
been incremented by of_find_node_by_name().

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/cpufreq/pmac32-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 20f64a8b0a35..4b8ee2014da6 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -470,6 +470,10 @@ static int pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
 	if (slew_done_gpio_np)
 		slew_done_gpio = read_gpio(slew_done_gpio_np);
 
+	of_node_put(volt_gpio_np);
+	of_node_put(freq_gpio_np);
+	of_node_put(slew_done_gpio_np);
+
 	/* If we use the frequency GPIOs, calculate the min/max speeds based
 	 * on the bus frequencies
 	 */
-- 
2.25.1

