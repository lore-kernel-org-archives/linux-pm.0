Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B85314D35;
	Tue,  2 Jun 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389640; cv=fail; b=ZK/nho7nFguttAZxt4OMIbs962pp3s6YTyWKuAmqvcJyTC4n5S9ltlzjUhhNd/sSuOVsFFD/AGn0GlnMsdhs+R/VVZ/7KMFEvg8aDBnFrieYandb6amLZwTwBy42ardKQQpjMT3xvX1IYlorP4gc/WXP0tFXH8U+YBAwqMOdXxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389640; c=relaxed/simple;
	bh=oTUlfjvhSqMjb6k7qHExplV71dVC4jRCId5VYTscTVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uRXO23YZC7xTpM7/hoXrz7SvoqT68Af1L8gZPKMTPN/tr0nZuk3bVG4QoKUqncn6JZbyH0HSBYcy/n9oQzTdIx/BUs3Lqmn9mi1L4xlFnHwEtioVlYZjLzGeYC4EeKIj1OKY+o+OoXGwkkWFc0/cxgaYVIZMx61EpHTYq2S4stw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UH94QCjm; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UH94QCjm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3Yhmz3j61mHBgdFeFPAtrQNnTIS5hFyAfDN8EqVB0yPDBN1svWorZLIJbWwF6cWGRsi3CrMSgkNxUs4d+y70dW7qEHhgFWZOqIlKC+x0oSz2ETk2n8PRj/LSzZE/F+zfcRfZJAkcsx4TitoC5EdQyoFuBGszTR1BhJH1BJplpJWaj4zawh0LnN3NzPCbE3Shkp0eM2kkoNsChZzH3yryWqnb+wsAtyJOvaf80xAkqeYuAOrTgNGDHbl09vqY3VFXSuCO+C754wbGGbsWR38IyDgMQQxuzbwCpHDrvoTmKRUT9XqUlnu8iS/0Op6Ox355j2SU38DqscgWAe99lM7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS3IOvQZgfB+bnURb0EdD7UEJ+QORThdqlGPPE3zFtg=;
 b=k1cOIhRTCYTOUt4D8E3aFDdt/0T6//ZnI5oUUtxIz0w74qFSivm5FAkx+nHcikvEkaLrGnVUpJ0d2RNiMBARRx7q0vXsbpZudpEsST7i7ydTp40QqVxiHRLKnOhHfdXC2pejmftj7dRd6+7DwEoI467qhNftRKUFn18Md1+JZw6P5Qw+1wMophSbJO7k6ncYene1F921MNkBQY/fnMS/cj0p74owXhBVZdtBHbFNBCn//eVah5ipwuc/nltvMMYRMjo0/65sKpM+7aPydNlJ2uikRcFYaghstWEI6ws42Nqrdgs0+s/JhY5xHrrtPpnGrgcSsgjYVMUuGou0lmDaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS3IOvQZgfB+bnURb0EdD7UEJ+QORThdqlGPPE3zFtg=;
 b=UH94QCjmRky6S/o7QQSnrFvWEeV7XimT6tls6A68VopH5nspOk+r2ufoD/SYIZ8OX5zEZ1b4rUKWyeEGhVfSjOlqDgWleIBMdEoZxeiTPW1q1pockIDZBZI0FVyKTxc1Bc7ecxECfBRfTIC0KEgGh1x83ySeP76iziwnSd9SJ2QuSYFSGHYfpIEiTa/N5a5Ki4WZ/Fnq/KulBu3+6r31P9G4Lls1lTbhUNf3EJlVKpRDnQuRpXcId8NmTwpXyvkpPuLJxVEIo1fRdxSYq+X+DTD2XJo6aShjnII5rATK6tXXLWIEqcmPsTxTuwoSU3usv8JzhMmyIrBpnF1WkIcUEA==
Received: from PH8PR20CA0024.namprd20.prod.outlook.com (2603:10b6:510:23c::19)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 2 Jun 2026
 08:40:33 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::35) by PH8PR20CA0024.outlook.office365.com
 (2603:10b6:510:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 08:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 08:40:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 01:40:10 -0700
Received: from moonraker.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 01:40:08 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Ulf Hansson <ulfh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>
Subject: [PATCH V2] pmdomain: tegra: Add support for multi-socket platforms
Date: Tue, 2 Jun 2026 09:39:59 +0100
Message-ID: <20260602083959.350689-1-jonathanh@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4deb2c-c85c-4945-e65e-08dec0829c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wL7PhDTkPjohuTHN9i3HQGRryIh0bidltKCq2IyNapZqGfhtFhgBgo1ZI8ndT9cEx5v5od1QB6fcg7QWEaQtOC4OIg1uhih205Mz7csEaIPh4qXa4veZrAlCmcIXSc4wPR9YipgaV5oggmeqDQ3OxoBwn5hMiR6ZS9Z+YIDru1VJ/PNtiLJLgNb8oQia1y6+DSu7zV8RyZSzWRbLu8gAmi/CO189fxXV+eruZZho4+5Lzg3usN3vLYl4G/6VnJkff9MGCsviHK6N8ngy7dwja2eiGk5He6bHNnngbU5riLKJvykUGINhkozS3+BZ3ZbEKa1Do3vTmwzPDrsQwhu7fT0rlpYFhrFwtajm+JPbsXrIL9YUth4MkIuNM6x9S6Pv1Usjx2rV1mQTfQR6uq8wQfJl31cEEfmG4aTJMrNGsBR9tFXfXBAeWD8y5lQNLvo9DQZsZVg5D5Uic0xVOi08rNERY9L5RwSZYijtz3hoz1au+RSHTn7L+91AQMRav5lntVVfhqUokYJ6s0szwEQyQTinxSPtAAw7JBu1asuUNMP3tbHLKCnC1I9eBan5cWty7N1sBY5DNunNOhoiYcg9rDTdhcrEIyf4W40I7iZ8+qpL2elQiPq+OoB6rQ7OJS22rKyOveZj2qhW8cjOi7E2BMbLTz75g0bmUklRqv2HfbGsFiH3R2+o3LrbGqhj6mCTZLArkG9TfBGbD+yuQuK0AczAACQf/rMMBMCmVXgo2kI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AUOo/iTImzmHNisKrWcK02guTjK1iBIoAGcHwmZhgKaWYp08K6XqYt/ou9RNaY84nkDBsYhGVvhprT1L4zwFYZn1hlZGsUdy0lHPnZSVEqQdozS1MiwwQCOmYkdXcbYSJfhNk2XRd+R0iLQItPewSEtQfTEmKfXvxfb0o9egXqfXAL/hIsBCe1gbKEBHs9dK1i6XJy3uZoOzIib4L0pFiDpPK8M0drkGe50vnk0r8XyTuqPwuewKgb5Vwhm9wXZeAcDJ+3FfBNei0w+ZYPcjkWZi1572F1psv8WhCTwRjFygfzer8BuFHtiNP8ZgcRjxfUnuCIqtNyI2M2ZS7A7yi3bpTn2l3AHIrOd08KOY+IU0MrPDb5CsQ8wlRzZj7Skfn0e/hshEF6tT2JjYKd0k9i6zC3fntoACIF548HVyEOcTOgaz6UsIytPibYufPhYR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:40:33.1779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4deb2c-c85c-4945-e65e-08dec0829c3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013

On multi-socket platforms each socket has its own BPMP that is
registered with the kernel. For such platforms prefix the NUMA ID for
each socket to the BPMP powergate name to ensure there is a unique name
for each power-domain. Note that we only add the NUMA ID for powergates
that return a valid name because an invalid name indicates that the
powergate ID is not supported.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V1:
- Use NUMA ID as a prefix and not a suffix for the powergate name.

 drivers/pmdomain/tegra/powergate-bpmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
index 8cde4f384846..5e869b0eb96e 100644
--- a/drivers/pmdomain/tegra/powergate-bpmp.c
+++ b/drivers/pmdomain/tegra/powergate-bpmp.c
@@ -137,6 +137,11 @@ static char *tegra_bpmp_powergate_get_name(struct tegra_bpmp *bpmp,
 	if (err < 0 || msg.rx.ret < 0)
 		return NULL;
 
+	if (response.get_name.name[0] != '\0' &&
+	    dev_to_node(bpmp->dev) != NUMA_NO_NODE)
+		return kasprintf(GFP_KERNEL, "%d-%s", dev_to_node(bpmp->dev),
+				 response.get_name.name);
+
 	return kstrdup(response.get_name.name, GFP_KERNEL);
 }
 
-- 
2.43.0

