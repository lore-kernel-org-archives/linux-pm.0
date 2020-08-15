Return-Path: <SRS0=9a4i=BZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D13DC433E1
	for <linux-pm@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA4123142
	for <linux-pm@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hoSO6p9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgHOWAF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgHOVvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2020 17:51:37 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1804C0F26D1
        for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2020 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1mv06P/Fmb+hv86TbcEFiG1+z16o6FdI5If3i2x/DyE=; b=hoSO6p9bS+kR8vbBuexHU/cSA6
        YmNuj+3iFwr08A2WOcohKj0yw0Q1WW+VDLfZiHk3dewzbesob8LVQijRzMgRS3xFxmDpPD/6KQV14
        9EsWs+eRr6x1Fl2zEryJUHvSXNH5CdHcAaLer0g4ZMFeVrPTfrYKHpNvXdNQT8q68ios=;
Received: from p200300ccff3e9c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff3e:9c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1k6zTx-0007JG-VE; Sat, 15 Aug 2020 18:56:38 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1k6zTx-0002n2-Kc; Sat, 15 Aug 2020 18:56:37 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] mfd: rn5t618: Add a power supply subdevice
Date:   Sat, 15 Aug 2020 18:56:10 +0200
Message-Id: <20200815165610.10647-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200815165610.10647-1-andreas@kemnade.info>
References: <20200815165610.10647-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RN5T618 and RC5T619 both have a charger and a fuel gauge, so add
a subdevice for it. According to drivers in the wild, things
should be at least similar, but since it is not tested, add it
only to the RC5T619.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rn5t618.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index e25407ed3ad4..dc452df1f1bf 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -25,6 +25,7 @@ static const struct mfd_cell rn5t618_cells[] = {
 
 static const struct mfd_cell rc5t619_cells[] = {
 	{ .name = "rn5t618-adc" },
+	{ .name = "rn5t618-power" },
 	{ .name = "rn5t618-regulator" },
 	{ .name = "rc5t619-rtc" },
 	{ .name = "rn5t618-wdt" },
-- 
2.20.1

