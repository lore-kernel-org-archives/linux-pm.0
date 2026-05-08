Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B61B6527;
	Fri,  8 May 2026 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217510; cv=fail; b=HuYj+jbijBuL+x7o3l+akyqRUBMlf2jGTbnLoUDugMtERPflGLnZAinR0J8VABWcJ8foDnZqeZOCffkJ1q2/vdEyziupHL30TbjNXmdrumWtlZm8P8d0gOXznUeHv4GEH7O0Px4/FRBqpZKrmsCo582eMyafK1CsHJPISZFdPE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217510; c=relaxed/simple;
	bh=y300o+0eqPhW+1VS0aC5cATaTRaQUbTQLPt9jhqM8zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktGr0Wra5D1aDU6jvuJQ6N89LPYM/PwiwB77gF3bVj+6w4fQkcJd6pmIDy0X9Rlfm7nQUm5KbshMrsGia/cmzr/RlG31L7mZbxhH4TvAUwp2u4YP0UtW8TbpK0d4GH3+1agRXzZEMCtBBuRaBUlj7N1f1oph1Tl8jMZq+uKYLq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kBF7DR4O; arc=fail smtp.client-ip=52.101.53.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kBF7DR4O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSvQ+A03yq5p0Vl40jG/DzjdZgh0AwMPqXdzOBF2W7nPpgMN4wqo79wI4nnBzYTRq+JzKTu4aBM4/HE+rl1D+WudyUZs4PHHC7Jww+MeFOdzEksMmVfVAkGO6toDNRHANUui6g9pGDCaVCBWWHY1mZ9Bp9OCYHei8MdlRdyWfAuEPzP7AbbRpTutminwMmpFj4iRkmn9yJ40LpD1akw37zHLpZ6Dj93GwMnS5J2Ify78xpUQDfFUCsIxn7tpGFdXxEEB+/mRoszRBcAu4iCZunZkiYo3xfKVi9ufeWnjeOOI5+5tlo7X1Prf0ekqTCS1jKHBuOhSKYbAlgWvXL5D9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCYZozA+TK1+YqmiNmn9axd4zB8Da1snPn/M6pTLtH4=;
 b=SOPEvfQztoLgDKPIvjZq82Bw4I3gra9xAWloJz6lMtVOjHBakPlllAGRKVai+Rph+o3M53zQvS8HaOsmJlIZwSLtWhQ5IC7wFSheT/W2v7ZaYGnIFeF+z15uPANdMkn8Seenwh7ub4tvm1owhDwZgUAWzRv6K0uPYrAZ5Lo8CIch1IzSh3rJF4phvqXSRVaD9Y3YwA3uvyruYJTcmcKCwSLHm364ZIfgOP8KSBQ8bVdiGSK7Chw9A4+FvZerbJHYv3I3idLBz8BMdK/Yr2mXzhDLS/z+aya6bj16SUyTVOG/+lTd/Ffjxatg+yAACqV66wdIKOliF2RxeicAcwOZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCYZozA+TK1+YqmiNmn9axd4zB8Da1snPn/M6pTLtH4=;
 b=kBF7DR4OF4Ju22IgiqOnD7KupdcYniLg7XT9RmXsX9cNJ+OMt602HTw0QRUu67nG7JuiQQ2P8hFZWV8AySrI7efh5xMCDb9zf2EpCTvdhKtco/C+74kA2jQ3wy/f/HkSH1ri1HX34sBn3LQSfOoshXr5eWc/k8Sf85f6NcNgt7o=
Received: from CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26) by
 IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Fri, 8 May 2026 05:18:24 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::5a) by CH2PR05CA0013.outlook.office365.com
 (2603:10b6:610::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.7 via Frontend Transport; Fri, 8
 May 2026 05:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 05:18:24 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 00:18:20 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 1/6] cpufreq/amd-pstate: Grab "amd_pstate_driver_lock" when toggling dynamic_epp
Date: Fri, 8 May 2026 05:17:43 +0000
Message-ID: <20260508051748.10484-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508051748.10484-1-kprateek.nayak@amd.com>
References: <20260508051748.10484-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: f798be31-c605-4831-dac4-08deacc13a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	m348JwaG5h1lvJ/7rd0zaT9H07IJCmKhQT7kdi2JipUlI0Yk+a7YQGRERiDTSepJ3CO/iYEjlCJ9MxsIfUaXq53Yzx+Wnu1pHoMLxqY47y3V76VBEyP8e5r4D1qDf9NnLKddREQyenMTcGxOlFYPVbtRV0e5/61HqcpuM90K7cHoIuoWnjriAQ2lxY7B/7p9Kw1xlCHERQt/xze4fF/0uQEqISXiE/K7SPamfp4clhD2s1w3FpW4e8RLKCOs9YZ0pLRcWQ1JnTO+gwaw1yaqDOmpFqjTR1ijyJs4nXVbaR4NAtkTKTp2PqQWF6bSHnrpqU4l1ut+IyohIKLG4+eckDvaxR/b4nQ6oaZbwk9PnbNhqF3izxTp5JRA7NTuE2ovhE2qOsWVkjFSdoeiN8+pjduzh5xLU/A8KWj6R2H9h+TJT2afGV1tkYJWr8ygBPDsXoP4dMN7JmxtGLboNfxGAd/Kb4yXGa7ST+XXk2xc6vyfy8IdQL2IXKMj2Y0fsa0f9sd38EH685qFFqgHrBfkwFdTheyqzMEyowf/3+/eo+m0DeKhdhBFLs8hfKNwcOJs+gw3zmuiBwjLpjBNxWJlzff91ALsc31vgI1qnByRxnlSMr4016D6hdvRrs0EWkWUQ0O8+o+Fi8ZsLnjHDHvAXwQAtOkZf7t6p+usOXuIUwmIV50UOQFM0Q16O64LSTBktM32BmRMppFX4CkJOOtCRzoO6apiFYLMpmqIDd33Xco=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qZCeRQnggdLBbPYRqCP0A+g8kA2RhhFUW5bseySExsLG+QLIiFzq20aCPOL6QNJMUWi2xbxQyXGaIOXSjrxkJ9CglmV6FUE4Op3C5ATzH/htkv1PomwvQTrim4hwIrl69r/Rj39NGaqS6gSKKE6gxjeBx5Bh3p4rkPtiOYwFL24+L7b32HCWYIwbCbpmQI7p7lxieSy064DW7b8pzkB44immEerkaW1+a5CxahWs18XdYVrByGTTwlAAzBGhlLWq56RoUUnqZ846u9j6aR4GeEZ7cVBVbYOuyG2730tenfj13ikoim9+0Pm0hESPWDp6RbMjkBM/hbr3uEDkl+gqHTH0jwTtGwOSIEbDaEI21ZIEFG4/h0MizJtpFWCX7YvqeWQE2GgsQhrt8QhP9ANu6+c9aH91kVdtD4/Gq8mF36iZgAY8Zsbs6LeSxo8mHXWr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:18:24.1448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f798be31-c605-4831-dac4-08deacc13a6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079

Concurrently changing driver mode and dynamic_epp with:

    echo passive > /sys/devices/system/cpu/amd_pstate/status&
    echo disable > /sys/devices/system/cpu/amd_pstate/dynamic_epp&

hits the WARN_ON_ONCE() in static_key_disable_cpuslocked() and hangs the
system since both sysfs writes are trying to do
amd_pstate_change_driver_mode() without any synchronization.

Grab the "amd_pstate_driver_lock" mutex when modifying "dynamic_epp" to
prevent the two paths from racing with each other. Add a lockdep
assertion for "amd_pstate_driver_lock" in
amd_pstate_change_driver_mode() to formalize the dependency.

Since "cppc_mode" is stable under "amd_pstate_driver_lock", only reload
the driver when in "AMD_PSTATE_ACTIVE" mode and reject all writes when
in passive or guided mode, or if the driver is not loaded, since only
active mode operates on EPP.

Fixes: e30ca6dd5345 ("cpufreq/amd-pstate: Add dynamic energy performance preference")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 453084c67327f..5e2d28c73294d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1707,6 +1707,8 @@ static int amd_pstate_change_driver_mode(int mode)
 {
 	int ret;
 
+	lockdep_assert_held(&amd_pstate_driver_lock);
+
 	ret = amd_pstate_unregister_driver(0);
 	if (ret)
 		return ret;
@@ -1821,6 +1823,13 @@ static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&amd_pstate_driver_lock);
+
+	if (cppc_state != AMD_PSTATE_ACTIVE) {
+		pr_debug("dynamic_epp can only be toggled in active mode\n");
+		return -EINVAL;
+	}
+
 	if (dynamic_epp == enabled)
 		return -EINVAL;
 
-- 
2.34.1

