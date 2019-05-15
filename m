Return-Path: <SRS0=mZbj=TP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DFC04E53
	for <linux-pm@archiver.kernel.org>; Wed, 15 May 2019 15:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEF42084E
	for <linux-pm@archiver.kernel.org>; Wed, 15 May 2019 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahkSRxBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEOPR5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 May 2019 11:17:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44061 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEOPR4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 11:17:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id c5so17404pll.11
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAHUDYZkdhULLcucnnLUgbccYgIZiPFo4xY3J+mzctQ=;
        b=ahkSRxBe1vu+lWav37YJt5N0U5asYcF2uPAoS6zRHqHqAHwz4vGzjMSQSEI+uYrbdV
         EW9iDi/kB58YiXAqwj6pTzuhU2gQ1kzwCw6lgdycSId9HG/L/Qb+e4sZAXlpucidQbs0
         7Jz9CCVZSAmbD/4FeSfUJUyeMf1MY83H+krGY05c4tt1bZwUufdQuUUgjgyeIyPbx8uh
         g3yENoOX4awf1CmOaNDKtdZqd8OqneoX4i5U4ZTIBIiDagK2zGU8bAdWW/BnQpiSTGSy
         HruVOqLp8eIc7SIE1vutPcdA0Wzx5Pz5i62/sk0i5jYik84kYgHam9CKcUcY6y6aiWec
         Kc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AAHUDYZkdhULLcucnnLUgbccYgIZiPFo4xY3J+mzctQ=;
        b=c5j6ExB6dC2K7OS6CeDf6gpzbXVQVMbtQXBCvCE9634IJ8fx+zrmYmKtHVW8TxZAJ2
         qJnrOxIejkD5z2PdLjfvVJjlTyT7rzHPthN/Z4T4XYps1orUN+K1lwSzVlJyZQKUZCHM
         R04KWfPsSYspPJwsJkdNm/isp7sMD0XkcVtE16bw6nK02c/EdNLz4s/U/lkBLz0/64px
         R1wkRTB/pkycp9cv8BJVYk2S0YmlZGRcudlesVKGp9+5UWWrH/tHM/mpUqNW6G5fOltY
         UOwuT/PM92qfbop/JbhjTo0jdu4L0xmIWo/0igvS/CHOK42yStvqXxAAHN1ZizeSmlTu
         v90A==
X-Gm-Message-State: APjAAAWwSZbWwjHq7/113IB/+uSLA/yrZKfHvGRPUFLk7RIrBWm3W4N9
        w7JPeZXQ+5FKl2QQmtlkgpo=
X-Google-Smtp-Source: APXvYqyjlLMYtvgXNvW6tYuCCT6M4A1oaWzzxQSqmAW/AUfYkBDmETvP9GU1MZGbp+qd+mvFtv3M6Q==
X-Received: by 2002:a17:902:424:: with SMTP id 33mr44204514ple.102.1557933476093;
        Wed, 15 May 2019 08:17:56 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:b16d:d4:d5a2:4dca])
        by smtp.gmail.com with ESMTPSA id 85sm5544888pgb.52.2019.05.15.08.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 May 2019 08:17:55 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/2] nvme-pci: support thermal zone
Date:   Thu, 16 May 2019 00:17:17 +0900
Message-Id: <1557933437-4693-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables to use thermal zone interfaces for NVMe
temperature sensors.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fad5395..88a25dc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2470,6 +2470,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
+	nvme_thermal_zones_unregister(&dev->ctrl);
 	free_opal_dev(dev->ctrl.opal_dev);
 	mempool_destroy(dev->iod_mempool);
 	kfree(dev);
@@ -2553,6 +2554,10 @@ static void nvme_reset_work(struct work_struct *work)
 		dev->ctrl.opal_dev = NULL;
 	}
 
+	result = nvme_thermal_zones_register(&dev->ctrl);
+	if (result < 0)
+		goto out;
+
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
 		result = nvme_dbbuf_dma_alloc(dev);
 		if (result)
-- 
2.7.4

