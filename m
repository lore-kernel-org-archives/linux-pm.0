Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002E283CB5;
	Tue,  2 Jun 2026 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428815; cv=fail; b=RMg8eqjh/dnVxpdg0mVZrlbcZmZb03a6N5P2D4w9v9xDlpTSD3mTvwlPQvkLvgXT3xpGr33olcqGKHderdnic5BMcF9QprZ5W92KVnh8j81F8Cunyjiiozs6Az0WE37EFIZ5QL/XjXLaGUDoNLSBdTE9ZSmwQfQrVuSaOQJeulE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428815; c=relaxed/simple;
	bh=jLBSk2F5A25x6obAliNm/lhi5fCXc+eDgEA+ZmzTk9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGMOFQhiRly7y8ezzN/tuhW0C13Jcu+8AdauMmCiQbpfFn23/6+aAVS5V5eaS6ruLEqjIGhn/7OvVL57b4qQaDbU0FcIsiJTlSVKoFL48IhLyMRI1iJKZHmaeubPNwZUpw9zDR7d/M7tIydvD1XOBPx96d5Ziw9UcN4VB+v2s50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=abXlLKwp; arc=fail smtp.client-ip=40.93.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="abXlLKwp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EipxzlvzfSumKBe3DmtMTCZXD2fKGJeXzcJImzbf460jtMlvnyreECclw2GlE5wvG50v0uiGz0iIuaHwR5W0Tn/CqFfQbPa8KIRFw6xC7jEu5cse57ivA8jv70scG/WFeubTD6HDA59vfO87e9UV4NXou56gerPLLwyxLh9E/RPdBu5LAziBqcWVrxbuwXsAsoutFsTcMeRXapZHeF19de+PfpI8ll2vGN1g+XD9uATIkelKAJgbGcn61r8mTMlwvAiH8ajRkDzKNOKiYKqr8aSQEWCX4TNyWhgoLTuYFPo4gg/C4O5ibV3dp2jxS0oDuZorM47MyaZsccyXPCwGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5Ceq+TPfCxVlVuotE9zAr1aEUVhmLnYrGV3Km+DZTw=;
 b=and3OfSX94U9zoUMarBtonbIJY4R0r9q3UJ9eegDqE8J5EH1xahMmxG6x6DngJsySHAjMxNYOEJUj/ZIDo/BTftU/WWrt0rKCl9aeTbCf31jjNzQ+kYmFOVHPnGf9sG+6eXgW409ZZzRtuXZ7B4WNKAHrcQlGnw74s7wH5us/OU7dcK3+E4Gkwq72TgivjADq7lPWYs+pKpa9Hqh1F5fs3zfzispxlZH0oK14WqIMpRITmDr+Q+ljb0N9PreEKyXEzfuvXLUlB8rRygBso/l/7bPcl8FadirBY7c0MghTF+XRboo19mjrUsGrcAiTL1X0C1hgdWI/8njylxGAIZkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5Ceq+TPfCxVlVuotE9zAr1aEUVhmLnYrGV3Km+DZTw=;
 b=abXlLKwpFsWD8MhCzPBNVWpnbVPQxQmlKowPmaOyiD+PEiuMIQHmsHoC3tYppm/1Ql5gHJYopHyeMaaTJpmuPu4MlF80yOnM7NSia6x9ji/VIicXNY+dcbcq2XjWJW/gTPjVrHZLazTWspYdvufInPrWt0L0Gy/1ul9HvHUZkbvQCtTFa1KfJkHI/76wAqRU8+vE+p25zjOed2DD2yttLLo6AVgbpTeDEf/hU50GhEvd3VF29E7pI8tI19LZx/RJ2NOZti4fnTq6++PgegzsLIhs/dBqHnow8ZLk5hDl1I45hlzA5Wma3Oi6EPBbdQ2ZVSoI5K6Vd2WkASNtH/uiaQ==
Received: from BL1PR13CA0158.namprd13.prod.outlook.com (2603:10b6:208:2bd::13)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 19:33:30 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::91) by BL1PR13CA0158.outlook.office365.com
 (2603:10b6:208:2bd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 19:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 19:33:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 12:33:06 -0700
Received: from moonraker.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 12:33:04 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Ulf Hansson <ulfh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>
Subject: [PATCH V3] pmdomain: tegra: Add support for multi-socket platforms
Date: Tue, 2 Jun 2026 20:32:48 +0100
Message-ID: <20260602193248.443101-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 017bfcbb-9a43-40a8-1fcc-08dec0ddd3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xmtuL56yL4NntKBG2++f75/LDh7zXNh9C2rtGgrPM4DmdVg1sy+LlJ3F0gXLK9pUjlq60kucmOqX19dbPOTY5K+EisIxTuR4Z3VURa0I85kuuptXCCxCff2miXEDm2lOZ9iuz7KejkBqZ2skfX09xz2CrynGMMllGczO9xEvxx0TXaR7Fyn5Ml/KvNrYDdm2pipMqzNROZfaDI7NYLRCWvu+miuj866xLj67pFbpW3dP8zzRarkQ2t0Pxr0/hkUQb/KeyRMCDXVhm92KRqrF46UfAG4Z07M9CwAyeeM/OtNLnqdMtMPFJii3/8ZdfeXuz0QRuzpmis48TjbUWPXnNx3ZCH56EG6j86427JHl18kTAx/FzN5ReFlV4uwT9O6xwkD2juDpfgFJWNzb+TqGeiMKtDAulM6eu68HXKIW7+DKNCB5rVG2XrIYu8xGHlfDFUjOYU1J6CVMAI3AHy8EQkiE5V5AkJp14Hni3RCz/OVjB/PgSK+361hqg9xM5DgF9LDcbvvjkhONd/TdMEQEI4A3CvTHW/0Z3vE5t5QUOYJZWWw3wqZvvaJvWB77EL3EIdpH8sw6zjgkUTBQJXul5qAgZhKYTQv+xSf4jJBX63tzh0sggv8ciHz/vUoHq3x7VZAznTS654Z/aDbo6M6lp44PBXdmRc2mjEdvM4rpf+SlasHT426bnsX2VZ/ReRPlohtk5HZTRCYB11wVjRgUddMyQ1O2+zcdlthVb9GmrWg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MRDMej/FztQ9sEPdkhiynFf6k57PS3tuxllelSdDTdQ0mFxEnETWHnHUw6XMUl0qjLeM1YuhAYYdUCQPmVLghz+kX2IF4I+Zf5g1s07vzaPYT4ejuv3SenfdkMikZflPOqHmUAG05VsaARXk8VdueC0nnsVOdItzwIEQ4Ypd7xwEw45AMAV/MqO8j3BEVXTyD15zm0Pk9KL8xsAhSHK9Z6GYPGUCCelq2NzMNXq/GwjBehQTVgVHf1pQnsKB4S0XK48+VgrvuV3SYVKZHEkLWcQ5md59v7IkGuHkXOSzh0/TU1f4kZ4uBNQ7R7Trzi1oao3vHWB8wqmYbB4b4tpJe/7G8kGVl1t8vMz3j5J1ftTo5b31rC7uRThUB5HT6XBkTSd4VfewC0oaKdO7fv1FOFzola8cto7vMKisQ2xHD4YWC1q0SyryXjSuQh9fWRSt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:33:30.5473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017bfcbb-9a43-40a8-1fcc-08dec0ddd3d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

On multi-socket platforms each socket has its own BPMP that is
registered with the kernel. For such platforms prefix the NUMA ID for
each socket to the BPMP powergate name to ensure there is a unique name
for each power-domain. Note that we only add the NUMA ID for powergates
that return a valid name because an invalid name indicates that the
powergate ID is not supported.

Note the check for the NULL string is moved into the function
tegra_bpmp_powergate_get_name(), because in the multi-socket case we
must only add the prefix if we receive a valid name. A NULL string
indicates that there is no valid powergate associated with the ID that
is being queried.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V2:
- Moved the test for a NULL string to a common location that can be
  used for both single and multi-socket platforms.
Changes since V1:
- Use NUMA ID as a prefix and not a suffix for the powergate name.

 drivers/pmdomain/tegra/powergate-bpmp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
index 8cde4f384846..e6a7e025b012 100644
--- a/drivers/pmdomain/tegra/powergate-bpmp.c
+++ b/drivers/pmdomain/tegra/powergate-bpmp.c
@@ -137,6 +137,13 @@ static char *tegra_bpmp_powergate_get_name(struct tegra_bpmp *bpmp,
 	if (err < 0 || msg.rx.ret < 0)
 		return NULL;
 
+	if (response.get_name.name[0] == '\0')
+		return NULL;
+
+	if (dev_to_node(bpmp->dev) != NUMA_NO_NODE)
+		return kasprintf(GFP_KERNEL, "%d-%s", dev_to_node(bpmp->dev),
+				 response.get_name.name);
+
 	return kstrdup(response.get_name.name, GFP_KERNEL);
 }
 
@@ -234,7 +241,7 @@ tegra_bpmp_probe_powergates(struct tegra_bpmp *bpmp,
 		struct tegra_powergate_info *info = &powergates[count];
 
 		info->name = tegra_bpmp_powergate_get_name(bpmp, id);
-		if (!info->name || info->name[0] == '\0') {
+		if (!info->name) {
 			num_holes++;
 			continue;
 		}
-- 
2.43.0

