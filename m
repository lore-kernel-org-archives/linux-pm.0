Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E4366823;
	Mon, 29 Jun 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747906; cv=fail; b=QzX+XgbW+ONAH/+2qbqLFhrWooYbslGLIiQtZ9fb1PXL/SDn3olmyysnH29EdUQSoGCOKly+SNSUjB0eGYXq+qWTmyf7WCv02OhUP9ZSDXFXt9LxbI4moXgqGj/oILX7RBrk3LqZqDaexhBjItLU/hErVuv5vjBKXIrQjOJIyqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747906; c=relaxed/simple;
	bh=76IeTS1rmYVdQAbkdA+EDKcA8GG2mzuIJQ3mp6HAzj4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=o9AZqTzwsx11JMVWQL+Jjl6mZk8O6UWRKqzJ1a3plIJVhNUzcFlC2/Eod/kIlBFtktcn//3+PTJWsfTHE2ZeDunnbNbOf7rsONyliXoWXpB8tGfgDBdRye67Bm3aOntw1I9L1+X1xWM7eyD2zt5Qd3E03TwZ0dVgUBDGA3HFemk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=pdnRL+x/; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="pdnRL+x/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/NprQRrVFwwMUTYW04NB2EQC/QyGyKrNzY7i7LJG6BSwu9PCEJnwb039r4a3UdyEbdJ8XdMEsqESWD5093rhoUTf7tPYEaNd1SKcKb1rL1kXSXRjQ0CkbbyYpHqK8WzuFq1NLew9vMGpUWVq6970v8xIg9TtQFpiIHlC1EBFdXJ9ukdvBVdEtfGlggh5HqEO4jlmc27o661RRzldZzTTTy0onbpO1Ri44dNCQ0AFwpKnn7UJ7P7sP+R4LZgVTba+P242hbnAMaNOWW1cxBhkFCWSYNXTp0dK8QmlEBDvpMpxRH5mwtLpdp0/mdbKym9tzQgywYhb48k74KzCY0kpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca9BcygwwZ88tsBuo9XsndLkXmww46DBP7ve9tEJkUQ=;
 b=yW7CJp6h3eOT4WKOZ6MbmhykLfwGWypRlwFxKXoFfTwiTqpPbpz6GZeCgqee4phzzL2GNbyXVvh5twViqwVTfl5NSSFF9uAxO9UHj8+8IZRxGBp0NV2QI9Ymn8Bf/dvw4EbF0bO4AI7IFFnLaaJL8lpcGh3VlWsweZ+RV1/EjCxrFQasofXeVCe1vvb6QVebbmZJFw0+ojOFJcFZaUqtnUra/5i6XH38Sv6ZUx9omFZ08MxzG4+B9J5x/woquWRl3u8pP26jvlEwL5qrcHmID70DTZ2Ztq2bnJPobixbr/Uan5/EBn1Te1sfp90FW+U9slGSVhJdQOMMt6ejHfExjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca9BcygwwZ88tsBuo9XsndLkXmww46DBP7ve9tEJkUQ=;
 b=pdnRL+x/g4tsDB5d6YwMRKlUwM9ztTQL57lrXJUSMPal/kDKmPa5cTLXSsSZe13mqWJeADTQyRoSD+J3xv931NYNo0iChOBFyi9ECI3k3UyeHkQm0/AJfwwx+/9tAm6sWr6t43EdG6TzoWJjUiZ20sgyufikabzH5ohR8f44a9U=
Received: from DU6P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::17)
 by GV2PR02MB9520.eurprd02.prod.outlook.com (2603:10a6:150:d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:44:58 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::73) by DU6P191CA0026.outlook.office365.com
 (2603:10a6:10:53f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:44:58 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 17:44:57 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/10] selftests: power_supply: Add tests for load_switch ABI
In-Reply-To: <cover.1782746851.git.waqar.hameed@axis.com>
References: <cover.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <ba5b6b47c4114a183e1729f98a653fdce7abfaf4.1782746851.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 17:44:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|GV2PR02MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fe2eb2-3d31-4ef8-20df-08ded5f55ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	S33IH39vcfG0Csa68fKOzkg/kalyLzLGCbBNkij7wtB4CKYMAeBRWuNXM+UXK4KJ9LAUVM6wgm0KkUqXa3GLTvvCujZg/jDfZnEo2Xz3K6Zf0NzQGUGNhBjqnqSGlmrv3lUwcSQkV5vJ4TGn6wrtTHsCUBKpD+2OkUbiWqzyaFnJavk725YBPQ5Y/5llPHIbI8G29vxDWFLLRCAXI3Y3L0rIzsoeQG+LArPcniN1jPpdjXcc27KBzDzzJbR0Kd1yU2F15fYWkEjs0OCUeC16e044GFlt4voGjVXTisSCtGU+BftzYbj3rmb+GwI74fOND9DgUFaEGo6RF7ujBAd3KRANoG2keiHOCBBQS7xLpPEfWGQcFfttOZXzuNFXZtdHzCx/Jj1CII4lwfZFpN3LWEPEn5r6wHF7miencIZF9aKOGX9GnsZcLR7xyJnU02IQ5gKK20YraIGzkkMn815bBXdhV7CFMbibOXRbp8wFZzhykRt2/yJ2Th4eyOIzuibdRFH1Lfdhb/hpTIXwjwIjsy58U5ACZ5+T6p9ncquFTs5yP9kpsrQzep3kC7qBF0YOG9lOGRB0sK31OYq3pe52GB6rrKSnfqKbJ9cr13siInx9uIXnvtZKNcrbW/wy7UYsM/6ArXjKlHv+PDIlC/Pd85nt1qV8hXFko/mUoO3ty9X2z7OHxTvD3jE0I5mv5HfZJn6o2dVmJ+hb487MHha79g==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m7Qs7aDojIesgdGTtBuuRvsRothEFg96WUQPoeRNqL7sxWMh8ZAL4Z0l5Tnb3u8H7asa3+tFGz/dt+gj/P4bwxbppqgXiXAzCn05/qeC5xUIs69n44cizK1AqQfqtGeHmq6m3L8bO2EGHvBmpiHhrlrsYyMiBINJ5pW9/4jcRBOiYE8eVYpdk+6HboB4y8tWrFBjnpz3mEsiXWV+d/OSeckpnKpZFE7+CDQWf7u2MYyg5bbhTwHhp/PEEGEIJx/zBg6UtDy8GbxUmnX8E1TpM1rwnpVUGj/ms6z2pk7Hy+KZEp9jQqswZzOlkk98hBTq4m21tYSK6/US+7hRwUVMiopWHspHxVmt3qfmvKzf15O8m1VkV4iwhrEeKDHnxE0ypuSgtUj2YYO1I4B4Vp4yhISK9Ex+kcj5V8swC3ss4t/GAQg8wTCUPxVeyV8FR7hi
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:44:58.6550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fe2eb2-3d31-4ef8-20df-08ded5f55ff9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9520

Test the different valid values for the property.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../selftests/power_supply/test_power_supply_properties.sh      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/power_supply/test_power_supply_properties.sh b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
index a66b1313ed882..d3a546f95ae67 100755
--- a/tools/testing/selftests/power_supply/test_power_supply_properties.sh
+++ b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
@@ -80,6 +80,8 @@ for DEVNAME in $supplies; do
 
 	test_sysfs_prop_optional_list scope "Unknown","System","Device"
 
+    test_sysfs_prop_optional_list load_switch "Unknown","On","Off","Standby","Ship"
+
 	test_sysfs_prop_optional input_current_limit "uA"
 	test_sysfs_prop_optional input_voltage_limit "uV"
 
-- 
2.43.0

