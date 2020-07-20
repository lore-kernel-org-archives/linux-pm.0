Return-Path: <SRS0=NsZF=A7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD14C433E2
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jul 2020 20:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5C22C7B
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jul 2020 20:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VziS23T0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgGTUoV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:44:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39092 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTUoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 16:44:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06KKiIol085956;
        Mon, 20 Jul 2020 15:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595277858;
        bh=pNY14uoreEMb1N8k616MvSldr3BlysWH/SPhuew/hCs=;
        h=From:To:CC:Subject:Date;
        b=VziS23T06fyIEppKICvvFJnJxX0Cb855seVmhP2McWwXvq3CM9XUfT0TsnsZhLFbU
         et17FCsJh9FpgvniM/ufsgU+7t+ZBwSrQ5YYPEQnGLWIHcXub9CUGmbNpL4afNAAAd
         LG1RlzW4M88ZgMp+EyD8baa+DT5dcKLKnACl5wm4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06KKiINE069802
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 15:44:18 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 15:44:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 15:44:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KKiIr6038674;
        Mon, 20 Jul 2020 15:44:18 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <r-rivera-matos@ti.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <sspatil@android.com>
Subject: [PATCH v17 0/4] Add JEITA properties and introduce the bq2515x charger
Date:   Mon, 20 Jul 2020 15:43:56 -0500
Message-ID: <20200720204400.7351-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.27.0
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

Dan Murphy (2):
  power_supply: Add additional health properties to the header
  dt-bindings: power: Convert battery.txt to battery.yaml

Ricardo Rivera-Matos (2):
  dt-bindings: power: Add the bindings for the bq2515x family of
    chargers.
  power: supply: bq25150 introduce the bq25150

 Documentation/ABI/testing/sysfs-class-power   |    3 +-
 .../bindings/power/supply/battery.txt         |   86 +-
 .../bindings/power/supply/battery.yaml        |  157 +++
 .../bindings/power/supply/bq2515x.yaml        |   93 ++
 drivers/power/supply/Kconfig                  |   13 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq2515x_charger.c        | 1169 +++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c     |    3 +
 include/linux/power_supply.h                  |    3 +
 9 files changed, 1442 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
 create mode 100644 drivers/power/supply/bq2515x_charger.c

-- 
2.27.0

