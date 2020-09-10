Return-Path: <SRS0=M6ZB=CT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A57C43461
	for <linux-pm@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A0121D40
	for <linux-pm@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KpyFds9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgIJSnl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:43:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58620 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgIJSRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 14:17:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08AGjjV5057212;
        Thu, 10 Sep 2020 11:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599756345;
        bh=mGo45HNyVsJh9MrMbASyD3eQepVmN2osS7RHtgRFbMM=;
        h=From:To:CC:Subject:Date;
        b=KpyFds9ngk+ftnoC+TNLyXN92cT84SbXJLXajIAYTz5FwsG22luBX0DJzURyLg39k
         DOU3fmROxeT7iO0daUhdjutxiS1zpkPVwcxM8//FFHyHKjtg7w/fwZh9sJYLNGEWNR
         ALut7W1Tc1bzjnKbO2TBzapSPgQ5C5m3RuS1qVf4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08AGjjoe119473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 11:45:45 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 11:45:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 11:45:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08AGjhP7022560;
        Thu, 10 Sep 2020 11:45:44 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v3 0/2]  Introduce the BQ256XX family of chargers
Date:   Thu, 10 Sep 2020 11:45:32 -0500
Message-ID: <20200910164534.16987-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset introduces the bq256xx family of charging ICs. The bq256xx
ICs are highly integrated, buck, switching chargers intended for use in 
smartphones, tablets, and portable electronics.

Ricardo Rivera-Matos (2):
  dt-bindings: power: Add the bq256xx dt bindings
  power: supply: bq256xx: Introduce the BQ256XX charger driver

 .../bindings/power/supply/bq256xx.yaml        |   97 +
 drivers/power/supply/Kconfig                  |   11 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq256xx_charger.c        | 1769 +++++++++++++++++
 4 files changed, 1878 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
 create mode 100644 drivers/power/supply/bq256xx_charger.c

-- 
2.28.0

