Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9412EC433EF
	for <linux-pm@archiver.kernel.org>; Tue, 17 May 2022 13:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiEQNXp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 17 May 2022 09:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347577AbiEQNXn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 09:23:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1681433B3;
        Tue, 17 May 2022 06:23:36 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2cGt2kLfzgYBP;
        Tue, 17 May 2022 21:22:14 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 21:23:34 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 21:23:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
CC:     <rex-bc.chen@mediatek.com>, <jia-wei.chang@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>, <khilman@baylibre.com>,
        <viresh.kumar@linaro.org>
Subject: [PATCH -next] cpufreq: mediatek: fix error return code in mtk_cpu_dvfs_info_init()
Date:   Tue, 17 May 2022 21:34:50 +0800
Message-ID: <20220517133450.2266243-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If regulator_get_voltage() fails, it should return the error code in
mtk_cpu_dvfs_info_init().

Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 37a1eb20f5ba..3a2be4552020 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -474,6 +474,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	if (info->soc_data->ccifreq_supported) {
 		info->vproc_on_boot = regulator_get_voltage(info->proc_reg);
 		if (info->vproc_on_boot < 0) {
+			ret = info->vproc_on_boot;
 			dev_err(info->cpu_dev,
 				"invalid Vproc value: %d\n", info->vproc_on_boot);
 			goto out_disable_inter_clock;
-- 
2.25.1

