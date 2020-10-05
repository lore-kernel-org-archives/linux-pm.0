Return-Path: <SRS0=LE0X=DM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC985C4363A
	for <linux-pm@archiver.kernel.org>; Mon,  5 Oct 2020 21:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D5320870
	for <linux-pm@archiver.kernel.org>; Mon,  5 Oct 2020 21:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="snWzWs4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgJEVrO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 5 Oct 2020 17:47:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50244 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgJEVrO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 17:47:14 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 095LlBef090828;
        Mon, 5 Oct 2020 16:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601934431;
        bh=IzNDb+Sqr84pSnpY5Wb8vCOpype3sqlW9bWo7BJh3DM=;
        h=From:To:CC:Subject:Date;
        b=snWzWs4XP/YczbD/E5/cgXnirgxvjLYD+YVgsXCTDCCqQpoyba6hjBM2Addz/qyFc
         K21vSsjw0W0EktMvz6IDOCVe+1BJ+R5U46IgS37v8ZoguSoIZpCFxUCQFDAU57V/3h
         hPkGrB4cdjiY/oCU+ZC/f2JVZgDQJ5rTis68C520=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 095LlBsJ038585
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 16:47:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 16:47:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 16:47:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 095LlBC5089657;
        Mon, 5 Oct 2020 16:47:11 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v6 0/2] Introduce the BQ256XX family of chargers
Date:   Mon, 5 Oct 2020 16:47:07 -0500
Message-ID: <20201005214709.10924-1-r-rivera-matos@ti.com>
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
 drivers/power/supply/bq256xx_charger.c        | 1803 +++++++++++++++++
 4 files changed, 1925 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
 create mode 100644 drivers/power/supply/bq256xx_charger.c

-- 
2.28.0

