Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCF284B37
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790463411; cv=fail; b=FJVNAMHYDcskvVhyjhopEqIxKmXAT22dUbEdAxCMEjYgo7FR6GG4NEbqT4HCI/8g6dWRa3rOvdMTK+NpV5+HPHNZfpdLdvaMJK0hi6lBIiSTp+oT/2Tpi/wx+2NCM2YfZK4baDVzeuJmo7L1+VYW79PTppnVqS5uYHRNw2IA5ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790463411; c=relaxed/simple;
	bh=xUPWQ800eLQQcyH5sZclyIiO/GUIeD0pODtikaZ8tv8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bu1HYQ1Pac4/oidOgqthVa2CCA5ghvBK2WiN0OBOR0nO5Qqoyg0q40XILnwIvpvyausCSgSsAX+k3pC3u8XUyLqP8Ll1rqN9t41Pk9wqGq/NCIzeToD4VMiVIRn3f+TWM32RleK2sMM1aOJ6mCiLbgZgZIjCfwzf9ua+bc+SRNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aqK64J3g; arc=fail smtp.client-ip=40.107.209.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aqK64J3g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+py5s88hKSIPqQa5uxWr2FLuywAbY76GNKa0OGDRy3kmKt2PX3WJf/iUHtY0MaCnhEsQbhz/9bUlGqJQuGp0rr0HXeXw46Myotxrn7aNCapescXslaZWhX7QE1IuYCCPKLWTV/WvQveklBq+oJeo+1CH7aYR++eqOYdcGXW1qVbQ+Fe0uV8J6fFHNewKI2AoQxT6zZIK/zuxY3kOWJUOStlCAojjMwlDg0ABiBJfTX75z08H9uTEssKCgY6+iDBcnmkXAsxELZ08oJ/9ZoAC8ML/nt2UEg63R1aTMNntiUy80LESFp3uFLOFvOgA5C+gq6OZ219DNMmrfEkULSIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BfJzFdOs5VKC9YLj1q4duN/TcmGQENRk69UGDSIRpQ=;
 b=puMX0nNRRp7peOEB0ObWH18jNhf6plmVvLEuNvMbjuS0QMYBc70yGNHppx81VbjX3gJ+BE1HqZniSkd34yr/tvQ4MARZzvKwf/5JI+cdDV+68lnzEltB0fx2uS3sY4VPCtwV/Qz8VOA6EIdmUnAqfnw4uDXTbeN0jQKPNgRDKvr7mrvP3SEQ4SZD3NbNNMYnfplLfKEbmvb15fu448uRR9DtTR3bi8TTw+EnclfXnqxSIX1LgWL9t9uXKtnefGr0yjQ4D3XOGs710EQiqABYGwivtk9xOl3DreEj6AMdO/glKVTzFxaMPqngQeu7ca6cosr30YMhQF/a5747xw5Hfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BfJzFdOs5VKC9YLj1q4duN/TcmGQENRk69UGDSIRpQ=;
 b=aqK64J3gzSj5gmeAPg8Jwn4mNP4kmLvY7uZYq60ZViGqmnzP+w6sQx7kKNRxF0dhcalCd3klqkDlzTFpY8DVmie8SDQk/mR+oSJJ69ltg2FMK2shUsgyebnrHfktJNUrrcf4wCwOGr2ByY5+pWQFGaA0JowNw0YtlcAYOzqiQ1A=
Received: from DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::14) by
 CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.19; Sat, 26 Sep 2026 22:56:44 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::4f) by DSZP220CA0006.outlook.office365.com
 (2603:10b6:5:280::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sat,
 26 Sep 2026 22:56:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 22:56:43 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 26 Sep
 2026 17:56:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <rafael@kernel.org>, <pavel@kernel.org>, <lenb@kernel.org>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, Eric Naim
	<dnaim@cachyos.org>, <linux-pm@vger.kernel.org>,
	<driver-core@lists.linux.dev>
Subject: [PATCH v2] PM: Add resume event mapping for PMSG_POWEROFF
Date: Sat, 26 Sep 2026 17:55:51 -0500
Message-ID: <20260926225555.2916525-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff9f9a4-2044-47f0-ac0a-08df1c216f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9BxH/jdJrcmv0DeaoEBgb2NPS0Ifz/USVf0icHoyErLqZTFDnB1SFeNrvg2j07g3bj9kHqEr8oe8mbWN6KJntn/jjMyQ7TrP6ZhprXpg5CQrqQ/KcP3KjheAkzETUdWB7nDyuUV4B2IQV5EaYZxaPGXvnPezcwcv36T5R0tLYa4oDZFwr1LkGPUi3Bb9D9o4j5jxMYpdN9lOpMPdLkaCaL+tdlMhiZcBG8DXEIHzhJi5hm7jqwAmjvMJJlocNJELQZbEQPAVcZQGW/paO8+Brarslwnwax3ixs7/BUwSSBvHCLYgxJ9pL59/jFaCgcG3tS/Uhohrky9X90G6wzXxiyRLEx6g9Wi60aCJ5yjAvSBLa7nCf/5K1XL3FmK7jPn8jUTwrdMTCBxPwGRRDAORR+ydxtu4YOGrC5TNgaAXTJ7WqppZXBKGePwKwpHHaYD+uLxxZyaMPlN/nZOXCI390zIHphLbm0De5sxm0DHXa6Iaq6r/Ry2DRztdrSfa9WhhRiC2/BT8adH/DjrbFbHcRtnyPZKPcf1vztQ3927mdFCF+DCA89vglziD5o+X9ouZRKzDesoa6T8nMllYjxWq/c633yQHwRQBFcflmdk3Fb/8ZZiSpIu3+EDwin6WIFujjCEN9nbyABm+iO9Z7GytbqxszXHjDigo9vyWeSNyF3h8591l0+ZU+9pm95zGZdaUM+oBtDc0gZ8nDuHxH1J2rQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ucx3tL2cmLxiaTF5bmXErqpFazBZd8BMrMEFZuLqgEIhlpd8GgO5zi7FVcOhDLg5C5xsN702xrnNXEaiTnhL6Ba1x6oPtvX5OFAwIUdt4LKAozyR0xjpExjI3/gW3J8PyLaKCGCNO2+w3ph18wbwhJjYyerDTFTw06YMjaKmzHmji+P2bobwpadA1XtMKS+1H5Fl1/UsqNrUjxIOpOyGzYva9B0bPn16WCp7QVca4b0nBrtW+xiQkc4vlO6HFyxnNkiREnNbClbc2oxSFdWKKfzFgZv/gKOFTxZPM3O35qHtGjZJOuekOq3JbV1cQuzsogOviYaFdTMwNaRAe3wUiKKChfchkzvfVH7nu6t+eVYUndms45Kaho+eMfjlCqeenWj1g5HBtHpD7Ck6pvKFbWvedU/tHR4m/vpx2JP5+j0l7GmI4zOieCHWbll7l7CD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 22:56:43.9995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff9f9a4-2044-47f0-ac0a-08df1c216f8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

PM_EVENT_POWEROFF (0x0800) and PMSG_POWEROFF were already defined in
include/linux/pm.h, and pm_op(), pm_late_early_op() and pm_noirq_op()
already dispatch PM_EVENT_POWEROFF to the same ops->poweroff*() callbacks
as PM_EVENT_HIBERNATE.  Add the matching entry to resume_event() so that
when a poweroff suspend sequence is aborted (for example a device's
->poweroff_noirq() callback fails and the PM core rolls the
already-suspended devices back), those devices are resumed with
PMSG_RESTORE and their ->restore*() callbacks run.

Map it to PMSG_RESTORE, mirroring the existing PM_EVENT_HIBERNATE
handling.  This is correct because both events suspend via
ops->poweroff*(), whose counterpart is ops->restore*().  Mapping to
PMSG_ON would be a no-op: it is what the default return already yields,
and pm_op()/pm_late_early_op()/pm_noirq_op() have no PM_EVENT_ON case,
so they would return NULL and silently skip every resume callback on the
abort path.

This completes the PMSG_POWEROFF infrastructure needed to support
differentiating between hibernation and shutdown sequences when
re-using callbacks for common code.

Hibernation is started by writing a hibernation method (such as 'platform'
'shutdown', or 'reboot') to use into /sys/power/disk and writing 'disk' to
/sys/power/state.

Shutdown is initiated with the reboot() syscall with arguments on whether
to halt the system or power it off.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/base/power/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e130da4281410..2ed687e3e6b11 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1471,6 +1471,7 @@ static pm_message_t resume_event(pm_message_t sleep_state)
 	case PM_EVENT_QUIESCE:
 		return PMSG_RECOVER;
 	case PM_EVENT_HIBERNATE:
+	case PM_EVENT_POWEROFF:
 		return PMSG_RESTORE;
 	}
 	return PMSG_ON;
-- 
2.43.0

