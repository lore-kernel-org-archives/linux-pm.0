Return-Path: <SRS0=ZSGc=DA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA6C4363D
	for <linux-pm@archiver.kernel.org>; Wed, 23 Sep 2020 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52938235FC
	for <linux-pm@archiver.kernel.org>; Wed, 23 Sep 2020 15:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AmBGqp+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgIWPYY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:24:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33132 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWPYX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 11:24:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NFOMFF022565;
        Wed, 23 Sep 2020 10:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600874662;
        bh=grpCRdaWz/vxXxSB9Kk3YFpzxwA3qYdw+2rcg2OXGVY=;
        h=From:To:CC:Subject:Date;
        b=AmBGqp+0O0LK25XvrmMT1IcF8zCWeLdQyR5LIxckUT6phxbryTLWaYmKgnZruvzCO
         Xa8sRwffKjz0PThlarv1Hszm6Avk4bVDikbnPKrwOMlVKIpNDnorIefs9wOvnq+9l/
         UuRRxu0ImZ1LTfFSdwZixs16UW4nsJjfA6L8zlKw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NFOMNl105518;
        Wed, 23 Sep 2020 10:24:22 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 10:24:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 10:24:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NFOL8Y015122;
        Wed, 23 Sep 2020 10:24:21 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v4 0/2]  Introduce the BQ256XX family of chargers
Date:   Wed, 23 Sep 2020 10:24:14 -0500
Message-ID: <20200923152416.24822-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

 .../bindings/power/supply/bq256xx.yaml        |  110 +
 drivers/power/supply/Kconfig                  |   11 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq256xx_charger.c        | 1769 +++++++++++++++++
 4 files changed, 1891 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
 create mode 100644 drivers/power/supply/bq256xx_charger.c

-- 
2.28.0

