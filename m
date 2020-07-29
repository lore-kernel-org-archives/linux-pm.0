Return-Path: <SRS0=Xm5K=BI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31227C433DF
	for <linux-pm@archiver.kernel.org>; Wed, 29 Jul 2020 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3FF2084D
	for <linux-pm@archiver.kernel.org>; Wed, 29 Jul 2020 07:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596008635;
	bh=Wg9pd3gugixREFFJWJ59cuDFGcbYxjerHh5c6rdj/iw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kC1z9+fMcnUrOowhsCiLdg80f1WC+Sg9Qv8UgSF75VSF8MBawBY4AidrSWhLuBwt0
	 Orsm+03uBJ5tXmf6dS2iiWcLSaEYIJi+Hy9yvuPkm/65nq+VBisbpJ3jfeFLvKCUbi
	 B0g6zj2NTLlFNhllrWhWES9Hfqn/HxGyt2mb6rsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgG2Hny (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgG2Hny (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 03:43:54 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC66920838;
        Wed, 29 Jul 2020 07:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596008634;
        bh=Wg9pd3gugixREFFJWJ59cuDFGcbYxjerHh5c6rdj/iw=;
        h=From:To:Cc:Subject:Date:From;
        b=yGsgbS/gHEgi+9i7K7ejRFxeAHqcsxSjEhq/lGmXEPHEYScVsvpjuKLti/mXGDI2y
         i3tsrvyoPsMaTnisjDJQpdnVwfIVEIV1/g1KAs1lPiIGNGGZr0reL1E4lITTFZS7fo
         /GEnQYdJSSMddQBlaB+Kao9ex0irWyBUSBu31kBg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] power: supply: cpcap-battery: Fix kerneldoc of cpcap_battery_read_accumulated()
Date:   Wed, 29 Jul 2020 09:43:47 +0200
Message-Id: <20200729074348.28317-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/power/supply/cpcap-battery.c:292: warning: Function parameter or member 'ccd' not described in 'cpcap_battery_read_accumulated'
    drivers/power/supply/cpcap-battery.c:292: warning: Excess function parameter 'regs' description in 'cpcap_battery_read_accumulated'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/cpcap-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 6e9392901b0a..90eba364664b 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -274,7 +274,7 @@ static int cpcap_battery_cc_to_ua(struct cpcap_battery_ddata *ddata,
 /**
  * cpcap_battery_read_accumulated - reads cpcap coulomb counter
  * @ddata: device driver data
- * @regs: coulomb counter values
+ * @ccd: coulomb counter values
  *
  * Based on Motorola mapphone kernel function data_read_regs().
  * Looking at the registers, the coulomb counter seems similar to
-- 
2.17.1

