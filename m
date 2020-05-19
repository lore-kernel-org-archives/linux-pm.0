Return-Path: <SRS0=iBKh=7B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA76C433E0
	for <linux-pm@archiver.kernel.org>; Tue, 19 May 2020 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545FC20835
	for <linux-pm@archiver.kernel.org>; Tue, 19 May 2020 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V5fQgwFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgESOTV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 19 May 2020 10:19:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35836 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESOTV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2020 10:19:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04JEJJVi060318;
        Tue, 19 May 2020 09:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589897959;
        bh=+YqheDvBm/tN5emqmsMckKPwgvtTPi+iG5bT6OZ54Bs=;
        h=From:To:CC:Subject:Date;
        b=V5fQgwFMer4pIZ7FwOCQPDtefs8ZV/e+BJvefXYLWotkaZAA6jP27YbZsuQ4QbilE
         CFkd60dJDj6KHKrHItWvGJ5dAo44YYyh09/noyM37YrHRm6aEAITYQtS7/VfUWlNVJ
         cnXFWcQDThYt3aBoXlu91uxJ7XogYWkLSWTP9cQ8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04JEJJ6a035936
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 09:19:19 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 09:19:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 09:19:19 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JEJIHO038542;
        Tue, 19 May 2020 09:19:19 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <sspatil@android.com>, <linux-pm@vger.kernel.org>,
        <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 0/3] Add JEITA properties and introduce the bq2515x charger
Date:   Tue, 19 May 2020 09:19:13 -0500
Message-ID: <20200519141916.28282-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset adds additional health properties to the power_supply header.
These additional properties are taken from the JEITA specification. This
patchset also introduces the bq2515x family of charging ICs.

Dan Murphy (1):
  power_supply: Add additional health properties to the header

Ricardo Rivera-Matos (2):
  Add the bindings for the bq25150 and bq25155 500mA charging ICs from
    Texas Instruments.
  power: supply: bq25150 introduce the bq25150

 Documentation/ABI/testing/sysfs-class-power   |    2 +-
 .../bindings/power/supply/bq2515x.yaml        |  106 ++
 drivers/power/supply/Kconfig                  |   13 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq2515x_charger.c        | 1167 +++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c     |    2 +-
 include/linux/power_supply.h                  |    3 +
 7 files changed, 1292 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
 create mode 100644 drivers/power/supply/bq2515x_charger.c

-- 
2.26.2

