Return-Path: <SRS0=Imah=55=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60562C2BBFD
	for <linux-pm@archiver.kernel.org>; Mon, 13 Apr 2020 18:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCAB20737
	for <linux-pm@archiver.kernel.org>; Mon, 13 Apr 2020 18:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbgDMSjA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:39:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33346 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgDMSi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 14:38:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0BD5D2A12E4
Received: by jupiter.universe (Postfix, from userid 1000)
        id 567DA4800FD; Mon, 13 Apr 2020 20:38:55 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4/4] power: supply: core: Constify properties
Date:   Mon, 13 Apr 2020 20:38:53 +0200
Message-Id: <20200413183853.1088823-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
References: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

properties is a list of properties supported by the
driver. It is not modified by the power-supply core
and drivers are not supposed to change it once the
list has been registered. Let's mark it as const for
improved security.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 include/linux/power_supply.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 0392c9cc8f1c..6a34df65d4d1 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -225,7 +225,7 @@ struct power_supply_desc {
 	enum power_supply_type type;
 	const enum power_supply_usb_type *usb_types;
 	size_t num_usb_types;
-	enum power_supply_property *properties;
+	const enum power_supply_property *properties;
 	size_t num_properties;
 
 	/*
-- 
2.25.1

