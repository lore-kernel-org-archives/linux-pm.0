Return-Path: <SRS0=9s+m=77=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14671C433DF
	for <linux-pm@archiver.kernel.org>; Thu, 18 Jun 2020 01:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D953D22201
	for <linux-pm@archiver.kernel.org>; Thu, 18 Jun 2020 01:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444580;
	bh=aIu6WKywcY2fBDSizvJuVK46Mwibxi9VcQs36OCkW9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rk1Db+T9gNiZJnVQA6H78cqk4asn8GzKLqWJ+Q/n71RJQDzGTN4JNdySbsoeop2pk
	 Sgb/pezyiNA0PAUl2qgrUe1iKRUbS+vlVAso0cEcXvlOzyinPnU9oAlmUc6KkhQdA6
	 ryvrng2MchPn4+ev3BzH77o6kjQtCavu2ZE7uvX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbgFRBm6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732258AbgFRB3O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 21:29:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC7C32220A;
        Thu, 18 Jun 2020 01:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443753;
        bh=aIu6WKywcY2fBDSizvJuVK46Mwibxi9VcQs36OCkW9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+3aFdkRmhvG2w0+WtNHWNqYqyltwFaRRo5P5WFo6RdBnkTzcFSNH48vtq5PPLt74
         IuK/9+clksCcTo2pIGKEKXZJIVeoicchpPCUM7/c2qcYo+uTBT7vnkwATrJJ9Wr+ze
         +ivsTnjnlBDEwMh11lzMoO1cMfcyN8pOGC7HWxm4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 41/80] power: supply: smb347-charger: IRQSTAT_D is volatile
Date:   Wed, 17 Jun 2020 21:27:40 -0400
Message-Id: <20200618012819.609778-41-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit c32ea07a30630ace950e07ffe7a18bdcc25898e1 ]

Fix failure when USB cable is connected:
smb347 2-006a: reading IRQSTAT_D failed

Fixes: 1502cfe19bac ("smb347-charger: Fix battery status reporting logic for charger faults")

Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/smb347-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 072c5189bd6d..0655dbdc7000 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1141,6 +1141,7 @@ static bool smb347_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case IRQSTAT_A:
 	case IRQSTAT_C:
+	case IRQSTAT_D:
 	case IRQSTAT_E:
 	case IRQSTAT_F:
 	case STAT_A:
-- 
2.25.1

