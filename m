Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C692DC433C1
	for <linux-pm@archiver.kernel.org>; Tue, 23 Mar 2021 07:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2DA619C2
	for <linux-pm@archiver.kernel.org>; Tue, 23 Mar 2021 07:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWHe0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Mar 2021 03:34:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48144 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhCWHdx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 03:33:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E6CAD200E01;
        Tue, 23 Mar 2021 08:33:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 33ABC2001AF;
        Tue, 23 Mar 2021 08:33:47 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 098F0402B3;
        Tue, 23 Mar 2021 08:33:40 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 RESEND 0/4] PM / devfreq: a few small fixes and improvements
Date:   Tue, 23 Mar 2021 15:20:07 +0800
Message-Id: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few small fixes and improvements

ChangeLog:
v2 Resend:
 * rebase to devfreq-next
 * drop original patch 1 & 5.
   Patch 5 will be re-sent later when dependent patches merged.
v1->v2:
 * squash a few patches
 * rebase to devfreq-testing


Dong Aisheng (4):
  PM / devfreq: Use more accurate returned new_freq as resume_freq
  PM / devfreq: Remove the invalid description for get_target_freq
  PM / devfreq: bail out early if no freq changes in devfreq_set_target
  PM / devfreq: imx8m-ddrc: remove imx8m_ddrc_get_dev_status

 Documentation/ABI/testing/sysfs-class-devfreq |  5 +----
 drivers/devfreq/devfreq.c                     | 11 +++++++----
 drivers/devfreq/governor.h                    |  2 --
 drivers/devfreq/imx8m-ddrc.c                  | 14 --------------
 4 files changed, 8 insertions(+), 24 deletions(-)

-- 
2.25.1

