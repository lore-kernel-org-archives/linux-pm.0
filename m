Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554264266B1;
	Thu, 30 Apr 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559111; cv=fail; b=rsmgQaBGGdEtVd6WDyJ/aVVe1C4zLT6VAsYDeBsqyQwnf3KQXWLkGEnkj/AVDCIUOWZR60i+SCVV7GpqGrJQGnCc+BTnkuatjgwZnIgffGbpFkhmIGlEUF86BT0Ted74tTGPJii0P505f0Y+O2mPIDDW2KIzqYth5+U/F8AHX/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559111; c=relaxed/simple;
	bh=knKxvyicbAOvPcM0x+tm5iEdmKVj+3JFnGlUotndIFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mR0echlZqkZX0/OWfUK3SRjQbvv95Pl+qi/E5oQwKm9ARIIRIFA2gVL5hkPGOCLg03YCj/t60GA0U7MXFMY2ILGlm4DuARoiYiKLB/vKoRuiUwqjZlyREk8kOcT97jEOPjin64lleJdlfrqtZmiUzUzz91ErAf3RvCstzL2jUak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WtcqQsty; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WtcqQsty"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEmVPg4gu7Vy2xffESMqmW0MaET095fEmt/8Sc9dQFbnDkaQW+TqM4vIfCPQcssa8Ff5IkCf+O2Ak+F2Cp0AQqRxOt9S943qKz5RyEbJ+EpGMsYXpcl340yNuWPxcLAjphGs6ri1Vf2Efaz6fMyZOkWbTk4rJhUOljVb27OEt07rk0x3SWU4bFHHIfY9dTY5/O9IAuOAHv2lONwxIgl4irinD0Vd43RdC24I6Myge09RHohsfROcQ7RALHdOWajy5Xi6RGHRSyk0ncE/H2Upg1VzRp1UL8SyNoHQjca68UImCy1CXOTxrnUWi98KMhwUOehUmguE4KY4fT9Zz0UcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBaPHeg0LF8n7R2JavkwJL2MeIRZvdGpJmrhUI0ZF3c=;
 b=QMJ4evVeNRqoejTfRMmAuEDgjjObf9hgFE+xpmrZlxM/S1d/VflXnTtCF/8NDZHU3Tsz2p1ziGBjkH5RnI9tvpgCD6rqyZRbvqGyXEHMT/nfzBb+FoZNh3KwY2Weirqq4dlgyHhfDq+ZV7b+qItAuGY5/jMX6L7hTss3t3oRJ67ZkyXLKQozhDzy0V8xLqwV5auKuGMj6BPjmdBjSzjBPnePpaxcFyGE3iqDDsIBhd97ViYDdid//XLfVuPXeo2mqoS3/ct8RyxjJS5SQ1QPFyXZp914mws66tYGkmrZrI8t915vCfNu95jS5inyRXxtcxXxUaBeSEqA97WLLuCS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBaPHeg0LF8n7R2JavkwJL2MeIRZvdGpJmrhUI0ZF3c=;
 b=WtcqQstyp/rtXDvjUmag1Lx9BqP1TWKmORXB0DjT4OpGyRwTjNN2GSHIKnzLBBYEkZvBaYK9DygbdE7y57SPNZD1Xs1MbBYtmJCaTGK0bGWcOjlFQxwxXe8qyVVkP2uVnbIqzo+TaAFBTQQzBEWfWbm3dENxav7BAddlLlyo2oFShATPVyaSbhGEknplpX0MYg7DpnSY5jRAntZdnYBXq5UzIXOdjn3aRgdq+1LDzp7HCF99Hoi7/FeK0lJjqEuM7/CbWTw0JQu/qj1MSn2uOrsMy/OlCi1BmS6y9phgaF62ilXVg+LeoslWikMfsO095zQ1A7ofhiW8oj0y0Er4ig==
Received: from SJ0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:a03:39e::34)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 14:25:03 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f7) by SJ0PR03CA0299.outlook.office365.com
 (2603:10b6:a03:39e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 14:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 14:25:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 07:24:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 07:24:39 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 07:24:34 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v2 0/2] ACPI: CPPC: Add CPPC v4 support (ACPI 6.6)
Date: Thu, 30 Apr 2026 19:54:28 +0530
Message-ID: <20260430142430.755437-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2689cb4c-36f4-4ed8-88b2-08dea6c4447f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JtlHuTG1eC614wpXnKs4OFddBXY4Zg7DS1q1jIWLeEQa40WyGAmOBo75qZ9/Lpr+Ey8TOyQzvw90dieAXRF0VRZNVNSKSsOZSFP68aievm9mMzqyvhKB1nSxAn9JAySsEuMUkX/iTWHIcSNRRrMnOYe1qW2oibc63glmH5YHj7vlCfEhSpdN+UmhgmjOE7iJ9FwiBs4VYBpC9Q635Q3dnoMshWLoEmGGk0vQ2221jnebMYNKP6xgERl1mkRbWg0APZ1fsOTY4Hei0yzfWEdzBfqmF96onI9pBKEgyc+zOUChVpWnjK31sX1MJV7u7gTUWJfH4O7/VxTlURHZInlW0E8Pb5ifWbo73vlGyoetYXlbyqwJ0uFrx3nKB6owEJyyB7x6Oo9n8SAxz8LkJz7kUMCRKHqq/98i/Eg9pqNaE+hYYNlOLUAK/icF+6QpMqNJqS7IhS5laF6yGgCxo7xXm0dnuVoipnGtbD5WHA3FP7djb2lrDRRW7GNDATbCM0uQGBYVSR7zcuinX3wunxm6RfzgwOp4EEsLijAneqbO83kDez83ZSLILRyqeuETXVP7lzn7TOdBQEbRXIPug2HxNGQEO9NIjv5Uwe3JmaQiijJToh6yN2uaMLHbJsDox8oF+BP5cMJGwBWz4WzyIYeUfXwqCCFIgWMUlMyRZfbHGlTMf0oV85k05XVL9+LnQ9Oq2FE1+wVa8L+mUYoSW2uEr5JVmnazvr3rF2Wxm1V5/J8os5tIa0Im8rNRzjMqrd8z3L88ug+IuKP5lrRzkpMbtej/07R4vIuhCCMg45i7V5X+GlQFYKacnaav3sAgxsWM0E8Pv3uTy4BFOwANUjMOrA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fJfGp3042flLz8D4eWSg56ISECxJAlVSo0dOVsDG5HFeVI5FK6gYCWo5QBi3DM4cd49UkNJgn3/L5Zu9snzQjEWSqqXkhB6LHtW8mp5Sbcwo6J5v5WTZ+H5tfUGafg1DjM5Kq9Pt+UvtYslLRXj9qXTqzswRRaN6l6TLkbAd/XnIcSABfuz7CQftsrSBUGn0dQJEximQCwrOdMLd7CHyB8IpUX/wtUCnpWimy/YyA6A9lH4zS5yZ9pNLD/FZAWKXnLDJH9132qnrBauibE/NjC+bugek8JgbPci5daE056HgD/F/HMb74SvkigGwMxnQOUzpaIGQomXjIxYwve3tZH97vHVpgy8pCZ8GU18KHARThKXCwfD3qkhyLy567UEU+YynE9Ab6iH7Yx8dvm2yROBW6tKAezq9VNLXqVlWbGI2Q92hfDr3Bv25Scc9kAbG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 14:25:02.5285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2689cb4c-36f4-4ed8-88b2-08dea6c4447f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142

Add initial kernel support for CPPC v4 (ACPI 6.6, Section 8.4.6),
which extends the _CPC package from 23 to 25 entries with two
optional fields:

  - OSPM Nominal Performance (8.4.6.1.2.6): register used by OSPM
    to tell the platform what it considers nominal. The platform
    classifies performance above this as boost and below as
    throttle for power/thermal decisions.

  - Resource Priority (8.4.6.1.2.7): Package of Resource Priority
    Register Descriptor sub-packages. Full parsing is not yet
    implemented; such entries are marked as unsupported.

Patch 1: Add v4 _CPC parsing - validate the 25-entry layout,
handle the Resource Priority package, and mark the two new
registers optional.

Patch 2: Add acpi_cppc/ospm_nominal_perf as a read-write sysfs
attribute, and initialize it to the platform nominal value
during cppc_cpufreq policy init.

---
v1[1] -> v2:
- Patch 1: added Reviewed-by from Mario Limonciello.
- Patch 2:
  - Make ospm_nominal_perf sysfs read-write; cache last write in
    cpc_desc and skip redundant register writes.
  - Validate input in cppc_set_ospm_nominal_perf.

Sumit Gupta (2):
  ACPI: CPPC: Add support for CPPC v4
  ACPI: CPPC: Add ospm_nominal_perf support

 drivers/acpi/cppc_acpi.c       | 93 +++++++++++++++++++++++++++++++---
 drivers/cpufreq/cppc_cpufreq.c | 10 ++++
 include/acpi/cppc_acpi.h       | 14 ++++-
 3 files changed, 109 insertions(+), 8 deletions(-)

[1] https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/

-- 
2.34.1

