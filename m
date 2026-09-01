Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2A237DEBE;
	Tue,  1 Sep 2026 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299975; cv=fail; b=nvInkGQLm3MVEi3YTGN9F64H3vWRUO7UVUjjDg+9K/6rpxm2f2YMKuzxriVE8VCsZUn3WfNBn03drXZOZnecfEAko0LauFGgXuNXc/Uv760VEpY9uYfVoKv5g9/vWjAYQJp51/J804utZWu7kk6wAX86AdtPhG5+4bMrJPBfGIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299975; c=relaxed/simple;
	bh=c5KK/xObCzutN3TM9PLFk4rtWgUxZyl5MTVscJKQBrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a0PA49oMC2yj8NgUCft+D0LksXuT6qqha+bq6AIjtS2JLXKt0PX/wfW6FrP3yzVdrMA9FAD9R360s1DWk6H239pZ+5L7kS3R7Qe/XN5Vf4F4OqdYMm7usdduJYNuknmCqZ28Ip+YarNmqMMJjFK6b0Xh70frkc8M1C+newMSCX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C8apLIpJ; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C8apLIpJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzUTRtV3WYvk3GSqmLAeEXGlX8GiLcuiq+5T1YmBEhUHA4EJPlHLPr8MVLmTR2e+5IFzw892ozNmkgC4JXQhJK73wGQVE/w+0eajxqywEasanBRTHGMIt7HnzuGqAk+Zs39t0uV5ruu/tGKuXsMKIwVDI76Z/hnrp95cLMxWpSAps4/mRc/EIPFB3kxmyaGJY3bLkJatXTOTIjXgyGdsOQ5yfL9U6b5DmeJgnPNW3sz8LURurjDTfb2hoLVsuqxTIs3TTX8saYJzJx50v4eW8AsKXIrALtpzzaDWSSHjq0CDQzerLljbCAuMDBMk1Th8oKv32m+o8nOT5JXf8LCyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZkpXvCEH4azGgXXlsNf5Hk/6I+DokV4pB0PvPmN6Bk=;
 b=RFtF+Ko8hzaEjo1XPZvvNairXKJdDoLTRdMvrpV5NRb6teq4eoOQ5oX+LAtzzobP16a5O3J9yL12cbzCuf+qz1zGqlBvceS1hnbsJJaMBFlHA371Vt82vPfYFS+GO/RIzLyJbLgMsJZRLHdvXpJjmN26Win5qWnTd/uVv7Yc9z2uund1vE3pgvLGXUtS+4S5siPpvSzR83M52yMoxquFrLASspXaqv12gIorXN2Dbl20lLb3Bo6og2FLkHcrFnDEf3o9rkNBtoK92PFMTFC4p1BSK5UNYSWPMYzYi+be5b3IBW15K/Pi0V93xbvCqfOi981PEFuwBvwH+cnJotNrcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZkpXvCEH4azGgXXlsNf5Hk/6I+DokV4pB0PvPmN6Bk=;
 b=C8apLIpJuYzIM1ep5Sa0FeIiw2iP/8OCzQ3GiKIjtNXtWE+0B8iWjW8+xKdHkBW9OLqZYOBAFYuzQUxVJOS+0fsJeenQ4p6AX1UsamzhEQ1+H2GDD1+exJcW79hts5bUtI1/IwrCl7UdQmTeXLMW7JaT3cnAmk/SisnGiaYPgU0=
Received: from SJ2P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::15)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 21:59:26 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::2e) by SJ2P220CA0011.outlook.office365.com
 (2603:10b6:a03:5da::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 21:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 21:59:25 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 16:59:23 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Vishal Badole <Vishal.Badole@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 0/3] Zen6 client CPPC
Date: Tue, 1 Sep 2026 16:59:09 -0500
Message-ID: <20260901215913.3042182-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: e548c3f6-a080-4222-0be7-08df087449ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	bvshpEEEALbwXUk7ktubmpjNzjBzybkTMv8vzkwukHCUrlM5Qj0tAq3V0QjOvv13jzNRbA/Vn762KzzeNJqrhIE3bHKowF3v6nkp729kZCrJUcBsSBN4+vQD7WoszPYhzzAP/saxqZC152W34HfalPeeZ7kSly/eCjvPDynUhiHRxk27mZozTyWAws7leX9etcYFxWiDZg6rXrCkoFdmgXudGmKh5J6b2LOV3AQVIgcaGKYq6RFFDdI9JgNj1fzRAsG14XnqoI4yGcmBmyPDe9hZolpl9BE+J5s3vmtZQcGKxNfurq1XRXpqj3Sd8mi4uLI60CGdxCrxWWjHZiLdSogYK0wq7wp4M+SZPhTicrZ0b66atQkeyZySQlE/bTMfqx1oudH9GDAEeXVgZxdB5TIMnQfhwXs+bwuyaH+09t31RkdfSuYzIDgtgI07PYR9BfIclTNcNIhAvc4J3BA2E+5LDtYxRYJblYxCi4tEJtsmp6oYKswOX/X3uATruc++BYe6OvL2oSgAIhZWzeUBiOqifBYDVI+vywDDniE0jiers6P8hKqMaQXeQz/xiwTIdd3mMaiP/nxrDl8VKd2iYI0VepSA48eaz02X74Dx6zNMXLnWu/rmJMq/8qs25tS+rDm+mHxBE/JUyIqEYKX1JErgAV/tvCszxl+sp5USluu1NCUgay+23GV49tg9mw8qzTqL8LQp2yC9RYJorcZD8Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Q5H4ZDlXWgjNGw1CZlU87EIyMvfP30QZVqfR9BYmExlXTWEpXoSWigSpYZR1sU8N5vufIYXbFwELIYKMBPfPt8I3aBy+85/YZhxVeswL2odl9ORM4KzyVTFCWFGH0JATLMHzyeKtgOHF879pyvmXPNsJYMqhXopD6O8uzuaiDZWNpfM7PxkQiFkfePWwmW6OsztAsfrZmcotSNsPpvs0p2huTGu7ybvllWuktg57xGfYPxWaQ4ILa8jK3aWTuSO62NxIjgUKmboIOMbJhvNvotFvqVMamcxkEMJRN89kHeQeWnePZJ/obEJub/ENS3KXf10tcSTcHIj4/gNNuoJ8/IS9i4R47SMAAzGG08CWMngWRBcWFTVTkRxEoFk3KgPg7kYvFo+mjD6hKBh2z2xa6NBIuR9MnzahCfrwU6Esa4NYrFBtcb/28pa5DUdlFgK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:59:25.9237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e548c3f6-a080-4222-0be7-08df087449ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434

Zen6 client platforms use CPPC differently than previous platforms
and knowing maximum frequency for a core type is needed for capacity
calculations.

Newer versions of the ACPI will introduce a proper interface
for getting this information, but for now hardcode values so that
these systems perform as intended and to unblock future scheduler
work while we continue to wait.

v2:
 * Rebase on v7.3-rc1 + [1]
 * Add tags
 * Use CPU features instead of FMR
 * Use Prateek's suggested fallback path

Link: https://lore.kernel.org/linux-acpi/20260830115644.2056983-1-christian.loehle@arm.com/ [1]

Mario Limonciello (3):
  ACPI: CPPC: Refactor boost ratio handling
  cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
  cpufreq/amd-pstate: Get Highest Freq for a CPU

 arch/x86/kernel/acpi/cppc.c    | 166 ++++++++++++++++++++++-----------
 drivers/cpufreq/acpi-cpufreq.c |  17 ++--
 drivers/cpufreq/amd-pstate.c   |  20 ++--
 include/acpi/cppc_acpi.h       |  14 ++-
 4 files changed, 143 insertions(+), 74 deletions(-)

-- 
2.43.0

