Return-Path: <SRS0=Pjfh=5C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B8C10F29
	for <linux-pm@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CA720724
	for <linux-pm@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584456918;
	bh=K2CqNzyP9Xh6nbedN69NWDYulb1KlpnZ6sAC5LNYrkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TFtvi4Kgj0KB/sNthSQjH+2J6XzH3fbdJnGMPx85hcGUfLWBwLhLOVvksT04e/tn+
	 Ed0n3CWfl6rGVV1jWj9WIr6kS0Lp9d6jGTnPU6wlBsm+tnvsXwESWrFuX/FCm3rfya
	 4NkmxmksQ4ninpR9RBaZOB6ZpkiOaM5LR2E4oyHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQOzC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgCQOyb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:31 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726E420754;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=K2CqNzyP9Xh6nbedN69NWDYulb1KlpnZ6sAC5LNYrkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1120EDb2wo2SIYejqvQfRjQsM7ALh/h2AzM6/RJh2K9AXE0MTo28Aa/K1k4Ku5doy
         cABfV9piTVNeIRwU5bZNi0nyyqVzrk9MQk7XHIN2bflt2BsaqgjDRUCT1rbiQupD4r
         EfGH2ueTxJCAaWfuTXdlnMZjnxoHUZGRcasmHdtE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000AMX-H6; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Subject: [PATCH 05/17] devfreq: devfreq.h: get rid of some doc warnings
Date:   Tue, 17 Mar 2020 15:54:14 +0100
Message-Id: <c013b308c08b47d1208c22362ec1034ac148c1b6.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mark "void *data" as literal, in order to avoid those doc warnings:

	./include/linux/devfreq.h:156: WARNING: Inline emphasis start-string without end-string.
	./include/linux/devfreq.h:259: WARNING: Inline emphasis start-string without end-string.
	./include/linux/devfreq.h:279: WARNING: Inline emphasis start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/devfreq.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 82630fafacde..57e871a559a9 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -158,7 +158,7 @@ struct devfreq_stats {
  * functions except for the context of callbacks defined in struct
  * devfreq_governor, the governor should protect its access with the
  * struct mutex lock in struct devfreq. A governor may use this mutex
- * to protect its own private data in void *data as well.
+ * to protect its own private data in ``void *data`` as well.
  */
 struct devfreq {
 	struct list_head node;
@@ -256,7 +256,7 @@ struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index);
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
- * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
+ * struct devfreq_simple_ondemand_data - ``void *data`` fed to struct devfreq
  *	and devfreq_add_device
  * @upthreshold:	If the load is over this value, the frequency jumps.
  *			Specify 0 to use the default. Valid value = 0 to 100.
@@ -276,7 +276,7 @@ struct devfreq_simple_ondemand_data {
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
 /**
- * struct devfreq_passive_data - void *data fed to struct devfreq
+ * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
  *	and devfreq_add_device
  * @parent:	the devfreq instance of parent device.
  * @get_target_freq:	Optional callback, Returns desired operating frequency
-- 
2.24.1

