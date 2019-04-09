Return-Path: <SRS0=kGmN=SL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6813C10F0E
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 06:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CB12083E
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 06:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="EnNtFCQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfDIGUF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:20:05 -0400
Received: from mail-eopbgr740048.outbound.protection.outlook.com ([40.107.74.48]:37664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbfDIGUF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Apr 2019 02:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc8h1TYD1LLx5p/A8NVCGqt6pl85Ou7r9C3lUSmjOS4=;
 b=EnNtFCQFqCFfRvtiLVgqH3bsCUnjtBNFSRZ70X6nz13JpQOk2emiag9qVBKzt3Xi5W/44sZGKF9/4RxPVKHfUxMjzwlunLxHYWkVPN+7sTA2PWjdpCC7gBJVsHEdH7FAN+ZMxoIyQXRwATWBVVuvKCM1F3+Hh7VPdHhy7uIir7M=
Received: from BL0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:2d::34)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.13; Tue, 9 Apr
 2019 06:20:02 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BL0PR03CA0021.outlook.office365.com
 (2603:10b6:208:2d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Tue, 9 Apr 2019 06:20:01 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Tue, 9 Apr 2019 06:20:01 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x396K1vX018635
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 8 Apr 2019 23:20:01 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
 02:20:01 -0400
Received: from localhost.localdomain ([10.44.3.40])     by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id x396Jv9H008379;  Tue, 9 Apr 2019 02:19:59 -0400
From:   <michael.hennerich@analog.com>
To:     <mike.looijmans@topic.nl>, <sre@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robin.getz@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v3 2/2] power: supply: ltc3651-charger: Fix device name (rename files)
Date:   Tue, 9 Apr 2019 08:24:41 +0200
Message-ID: <1554791081-10950-2-git-send-email-michael.hennerich@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554791081-10950-1-git-send-email-michael.hennerich@analog.com>
References: <1554791081-10950-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(189003)(199004)(2876002)(77096007)(478600001)(86152003)(7636002)(2906002)(5660300002)(76176011)(107886003)(36756003)(6666004)(356004)(72206003)(47776003)(48376002)(86362001)(4326008)(26005)(126002)(49486002)(14444005)(186003)(476003)(110136005)(106002)(305945005)(50466002)(2616005)(51416003)(50226002)(11346002)(246002)(336012)(8936002)(8676002)(16586007)(426003)(316002)(486006)(446003)(106466001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e11bead-6336-46c5-6102-08d6bcb365e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Antispam-PRVS: <BL2PR03MB5452C86AA1E8C4783B3331F8E2D0@BL2PR03MB545.namprd03.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2lnugHSJNJybikWRK7evNtzw0lROrJDJat0Eu6mvgHS4iS83yooCBn2LlYouFf1y5bCpCd731IdTu2VR1TEMyCmzZh2Y6fyJWsMJKQ8dIXrUV6MxsNQUviIj75nYHZvzZXJwigzsc/8DXLyUfIT0ZaHop6NQ9a5gyB+fJyrZUkgma5WzOV/37G5N+wy1URfONXVqHsRYxUM0YcgYv24qAZ+CeWbotYIeXOHOuSBRojd+27/SZFFygM6kkVet3PkohKs8KcUQsF41Fd5zHqmm1NFN2cESymc9dmtlJUKMqQaevRMGU87sM9Ij9phE4ZjeWoefgPStqFuLTd+5+JpepJSJv0nGZUdNvVwFc9PIbM2OLD6Dni7w2OQqHn5HHE6YRzdGdx+ZX3iB7nW/hX9y6J+Ko2FjwqkBXiukGVt7hLY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 06:20:01.3317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e11bead-6336-46c5-6102-08d6bcb365e6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

rename only - no functional changes

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 .../bindings/power/supply/{ltc3651-charger.txt => lt3651-charger.txt}   | 0
 drivers/power/supply/Makefile                                           | 2 +-
 drivers/power/supply/{ltc3651-charger.c => lt3651-charger.c}            | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/power/supply/{ltc3651-charger.txt => lt3651-charger.txt} (100%)
 rename drivers/power/supply/{ltc3651-charger.c => lt3651-charger.c} (100%)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt b/Documentation/devicetree/bindings/power/supply/lt3651-charger.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
rename to Documentation/devicetree/bindings/power/supply/lt3651-charger.txt
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 714c602..a2b3ab1 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_CHARGER_LP8727)	+= lp8727_charger.o
 obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
-obj-$(CONFIG_CHARGER_LT3651)	+= ltc3651-charger.o
+obj-$(CONFIG_CHARGER_LT3651)	+= lt3651-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/supply/lt3651-charger.c
similarity index 100%
rename from drivers/power/supply/ltc3651-charger.c
rename to drivers/power/supply/lt3651-charger.c
-- 
2.7.4

