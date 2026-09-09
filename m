Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59105335564;
	Wed,  9 Sep 2026 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925014; cv=fail; b=PIbRJmYgC+YhX7JWJgbdQLraUkh2iYcGAx4BFrm5L2K0DKdJpALUUzOoRK2HVu6NFRSp803rM9jWMlWedJB4bdHw/0QjacU5l0clNPtI8iEpHRbjgycUgkGZFVPq5FT2VvVcLNM+SwzGX3iPTVdItc5Incj86w4fyF9EYYqAdgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925014; c=relaxed/simple;
	bh=Pr1I9cgA9XvSW5xrycLqp3N9cI7ghGbfznJOAI7Upf8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=REiA8dQUV6HQLkgDxs9kfrgTJDvwIzkSj8XfA5UKyTnjDPpepDMbyTVleV+pjZvXVwOaZ0rRCTHpkbx/DZWZxfz16nTsPZV/ysvfE5mhfR8jS1M4Hx+EeoQ2gghOjYGntq4BKEs0bssf6InBxgkVxddGgzcXwrg7ifxnQa2nb9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xuWUZJLA; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xuWUZJLA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8FMt4RIqsCZXBvpOr5ob3w3q62CYu6XshHTiACeTbPVrMXK84K0ug0DdcrGoGHMk6+tWRYGxKRo9J2os8rzXK/3iszgXYsORe72t1TqmK5Q6bTj+57bt19pwjzLP558iRqsWi0nn+Vbfw8j0gD5z0men4e/d+V0pgHYnrAn6VOgY/uPr/xasPA1uX+e/a1w+2ldcbAdcrdGKS+Mgge4P53n0HzkYF+FL83gV17mA3EJlS3SvgXKBsIbOYorEl0xOgkm1+64fvaUZzIQMRyTW3vaanDC7iR4jMlpRNiXmOZhv0I7X0jANIyr82mJOq8o78ltsNz6jJ7F7k8BbzWFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMn2q9uP3sZI07zgLvKQo++NfIn7DkViQpDDMsohs4E=;
 b=xwkt3rdot0qzU9mGJ35INLamyGuaw9gyJdAsJN8eXMR/Nr2lnm8ReFhcq71fjP2ye8TLPVpnaKfi0DOWRoC7n1pG4DOM7Q8ZN5C8fdV7ILBbtvLYlcF2K+9zCifqKLMomMV9DCluF1uulftLSngaAIrxbBPcsMkXs9VWKNsyo8ublmt7e3oZYp0bJkYbSRuvHZZU/tN7sk+qjHeSebERwRSfp1ABye3UkvifKlRS9Q23HwCQxlPc2e60F4EUyxhz8iXKCSbyeOzVgmCaysS1/DMa8Ds/b+LxDCFUPjci0jJA47qcdhy73gkJO2NlbJQaDtIndxFr1XSiFRMLzgDlUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMn2q9uP3sZI07zgLvKQo++NfIn7DkViQpDDMsohs4E=;
 b=xuWUZJLAQbLK5prQHzYzA93FfiyX/7iC/MOpyYDQXaRsFcUhC9+ja85nZcL0dhVHpVYPSRIBlDBJsRf27W6BXmIQxUuz8RPcC9xN8wviueIrANmRLhCVKU8vqrfFYEPpeVrRMGU0wcGA8m9zXh9DEeAEKcLeEuBfxYuIKPVMykY=
Received: from PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::19)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 03:36:46 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::61) by PH8P223CA0005.outlook.office365.com
 (2603:10b6:510:2db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 03:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 03:36:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 22:36:43 -0500
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 22:36:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 0/3] Add support for Zen 6 client EPP tunings
Date: Tue, 8 Sep 2026 22:36:20 -0500
Message-ID: <20260909033623.454449-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 2297055b-9499-4630-2abe-08df0e239275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2bR+XVOUuZd881edTKaDedZjXplBRh7jBNKvPvcPi/RU7ALnnTuIrAJVhLY2XcasbHYy7W5uV5Wu02UbbP8YmZKY4Q8IMm7LHP0c4M53m/32QcRRZFbWF4bjUL5HdwmpjjlQt3eMwR+0bx9JdNj3oeYq8tcLZSrzXN7zY+0TWFj624sW0XDjbB5x5xIZ0TmV6Xpacrt+T3fAg86sIEw+LbqSteaOPSxDpr7ShtgzMONRF+irh++y+ib3FbLc8RleCYE+N/Ffal4RNMoHUI7vDK2MTJTt5+xtLGYEo0hHhL7RtCK90SeMxI4b2gbYmmpmndXYOoAX7JHkS7jok9Gfkho6Q8/bgoJCs4cGAEYrpsM1ZL+rHywrJdA9vA++wH0CgdXTZ9YoamPQNdR5sozH+kIQAyui7Q4Mv0jFWhP/0TnEnpoTj+7QDW1d9W29QejuN/byu+yQD4J5lZBLeK0PW598hxRV1mdmihmo7ZsM0ouh5z7UKf3HG48E/Ep/NCk+liDgUe/jsVhBirbsHzmDiAo7yf6v7FfTK8bl2fxZehC0k/k2ijpD+Eix9NYkFOiXoORAlLar6v1eol2BpRldOougGB9bDIdIwQI8XOSz/DxJ6Ky6nq/0C7B+iC0X3tkgUDBdXHZ0U5x+fTYAgiFRYKOungz0aZNKbdNTCujH2VFfuD2aV6xV8tmEGF/BCACCukXWoHorcwlt4w+rYiNBQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zyFhoSLAqowHwZ7n83JvrsaSvAbGEiNJ2JuFU+cQNya7TwxI/tZKECCDjKSzRo34S110cS+2i9C3J2HihxRrehHm5KqOrq4uU95FDDYkQox1PCpCSdM4nxDZz5mnuCHA/6pGWOyuwSxclXk0C+Qg/UskkcIhwUuMpakawCHUUVF+x/6GnTjvWI7SUh7DxhcmrmBxo/tzPehehzpc6yTiCgA86Y5agdb5Mo+dpPfLIsUAf7EurXHQIIVogosTtvGcHnQGy1IjTMMULn39RaWmGmKkq9uW9SdJ4wXtpIaWIP6MgFDLSAw4+om+u6B6KcHyKauo0STInjnl0cT1MU7kuhnOeE9vOd0YDhZJz0/3gd+SCeRkQsNo/hUR6pZoB7NsoBJqAa6SEomAo3b18pVTfeS8XCgEZpAL4I2f1K1s+w14au4L8QRAIYGQMKXwxV6t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 03:36:45.3077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2297055b-9499-4630-2abe-08df0e239275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640

From: Mario Limonciello (AMD) <superm1@kernel.org>

Zen6 client platform firmware uses EPP values differently than previous
platforms. To optimize performance and power consumption tunings are
applied that match platform characteristics.

v3:
 * Enhancements suggested by Prateek to patch 1

Mario Limonciello (AMD) (3):
  cpufreq/amd-pstate: Show a warning if missing EPP tunings
  cpufreq/amd-pstate: Add per SoC and per core type EPP tuning values
  cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms

 drivers/cpufreq/amd-pstate.c | 213 +++++++++++++++++++++++++++++------
 drivers/cpufreq/amd-pstate.h |   2 +
 2 files changed, 178 insertions(+), 37 deletions(-)

-- 
2.43.0

