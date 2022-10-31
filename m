Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D878EC38A02
	for <linux-pm@archiver.kernel.org>; Mon, 31 Oct 2022 13:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJaNCH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiJaNCG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2022 09:02:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D008FD18
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 06:02:05 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N1CsC5yGhzJnP3;
        Mon, 31 Oct 2022 20:59:11 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:02:03 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:02:03 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH 2/2] tools/thermal: tmon: fix format unexpected build warning
Date:   Mon, 31 Oct 2022 21:21:10 +0800
Message-ID: <20221031132110.65847-2-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221031132110.65847-1-wangxiongfeng2@huawei.com>
References: <20221031132110.65847-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Building tmon tools emits the following warning. This patch fix it by
correcting the print formats.

tui.c: In function ‘show_cooling_device’:
tui.c:216:19: warning: format ‘%d’ expects argument of type ‘int’, but argument 7 has type ‘long unsigned int’ [-Wformat=]
  216 |    "%02d %12.12s%6d %6d",
      |                 ~~^
      |                   |
      |                   int
      |                 %6ld
......
  219 |    ptdata.cdi[j].cur_state,
      |    ~~~~~~~~~~~~~~~~~~~~~~~
      |                 |
      |                 long unsigned int
tui.c:216:23: warning: format ‘%d’ expects argument of type ‘int’, but argument 8 has type ‘long unsigned int’ [-Wformat=]
  216 |    "%02d %12.12s%6d %6d",
      |                     ~~^
      |                       |
      |                       int
      |                     %6ld
......
  220 |    ptdata.cdi[j].max_state);
      |    ~~~~~~~~~~~~~~~~~~~~~~~
      |                 |
      |                 long unsigned int

Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 tools/thermal/tmon/tui.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 031b258667d8..ed736fef1fe0 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -213,7 +213,7 @@ void show_cooling_device(void)
 		 * cooling device instances. skip unused idr.
 		 */
 		mvwprintw(cooling_device_window, j + 2, 1,
-			"%02d %12.12s%6d %6d",
+			"%02d %12.12s%6ld %6ld",
 			ptdata.cdi[j].instance,
 			ptdata.cdi[j].type,
 			ptdata.cdi[j].cur_state,
-- 
2.20.1

