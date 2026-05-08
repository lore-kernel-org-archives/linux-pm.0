Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023102.outbound.protection.outlook.com [40.107.44.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228222EF652
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221923; cv=fail; b=rJZvaI0pwUQ3lIHY3WkK+zkyqS57Y5CZacB4H62knTpvlKORk0H8YhSq0f25U2ys3v9gNjyxgGc02IG7edDsL7b0UcKfYhW+IuFWb8CoSk//aXIaBC5gYMA0wSrcdEuaqMb8kKEU7fK1DKLAVRVhERnoydiIHhKCb4rIiHt1KJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221923; c=relaxed/simple;
	bh=QG7POHGFyhTSKLMuHFzBGcvKPHpg86glzHBvNvUic3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lbKcaYmkNmKk23osx/7SGDB/9apGOhgL06x0i0DV0qcxqkwt02FV/6Brpz5RqdAFCGB2lsq2nROSAhFMzbDiQ3RitEDdlcDqt+6BFEntd6C7LnFmHSF7UyakYfQ6M/E+GIPwYBlVuSxnLCOzX1OZv9UnfoZziFsB7b+5kBsC2Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=ClfY97v/; arc=fail smtp.client-ip=40.107.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="ClfY97v/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfYLmhu7LD/rgoZpWXwNrUV1fDuaAXIrtI75kFXL9AgTG35CSoUlKnW/zVvI4QgTvDBPK9h9fpyEODIohhqc7ReB9J+OYdWb6FSLk/yhB9mM8v7VPsufLlZAamjG9bey4oBj9MZIGGRjbWelSdUf0q0X5T6FXqYrpKBFaOScCmZL2gotlymnVtjt/kJfyHfzxfTnLcFJcc4RbMCUX4wGWN4Omt9mV3Wip+kc30vLFFZySbBTmohRI6+NtMs4/B3bGmyj0c8QIbK8v30/fs/1hK53bhSlGq9NljwG/UMXvpBPRCkdneyFAKMQzRjlzBTOAxugemrbYoNGWpdkN2mr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZiko91dZYGeKt+uaRpmFLe0HRJpLh06uiBL+MWFt9w=;
 b=imdQ+qf67jV6tReQIViXYRz5eaR0je5Ujv8jhENCX7Q6YoG6pHtWZ4bOUXSMovhnviNGlwi0+S+ZYaWcCW8SSizK1rlH/vEm5skOyLvP/QTpSFKqSc9pW+YIcmJCawkyA36evC76LArX5hd8naKUWvwiY+Vr4JvMKS1xDpV4n7CykhFKbSVY61goJpP6qorzyJss1+zhaTk7qiNqpVfOAZme6eV98TIlkZxNpRU5mUf/Eb27bm7w4fm+muOZoQ+euO0CtyCI4uyO8f9q+6g7JI4yvzwIsaOmXpadCPsnPjxis/gBYGzO3rMKERQ5QAYTPt0f46TXWNQ0KNgu12gYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZiko91dZYGeKt+uaRpmFLe0HRJpLh06uiBL+MWFt9w=;
 b=ClfY97v/sFmOvm8YKTOXfAGDRcu9NYpKcR2RA+obdIXhNYoitWA/l2L2pHvmKRwC7ghgbUFCkFA2gvVdRE1Sn3soDCq6YzD8OVGqEMuBUk9n9yH01t+3d/0PjufmgdkFFT6+f4jLhRMBUJiMGnO5nmaqjKCr4WhdzWLd1i8w6bpu/rwKorJa71e9Lf92mRTd5BEhfyUHiEK6U9aBLUAYjto5Xs4VabX+SQxjYNjHSuPxzJY3jE2JvTSLYqPCrBer90CtcNN8ZMrOYpmk8skOdC4hdp+/RC7ccHll+A/TOhz4GcJDUdXMBskquZASvid7q3ZeRWG2jfbRqvW2/7S6cg==
Received: from SG2PR02CA0126.apcprd02.prod.outlook.com (2603:1096:4:188::11)
 by TYSPR04MB7880.apcprd04.prod.outlook.com (2603:1096:405:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 06:31:52 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:188:cafe::5f) by SG2PR02CA0126.outlook.office365.com
 (2603:1096:4:188::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 06:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Fri, 8 May 2026 06:31:50 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id A47BB258;
	Fri,  8 May 2026 14:31:49 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	SW Chen <swchen@qnap.com>,
	Kevin Ko <kevinko@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: [PATCH v2 0/2] cpufreq: intel_pstate: Add scaling factor for Bartlett Lake P-core only SKUs
Date: Fri,  8 May 2026 14:30:30 +0800
Message-ID: <20260508063032.3248602-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|TYSPR04MB7880:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d23287a7-3f0a-4e35-c8ea-08deaccb7cb1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|55112099003|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZOlbewEHGwNZ12elUnrT4+o3qlXlZYU1hi7/G0TRTbJFlMcwmq50nJNL15ZW6oGkyq/muqG2CvWUqztlTSiJVOESVbw8zBArwZ0TawGl+pXKfrcAypudJX6Tzn6zB3CP3b3MPXZ8WAo+pb18bAhBXSybzC3SBmhBsvKCNwlLE82fbV43+8WgwV/XM8GK2SjLVdjU1bmrIO5OCKrckvkHN+M4XDyidbJ1TC1T9OVFYBa7RtQHNs/osTcPtfAISwz6EtP7Rb5Om2Av/Jaz4xyQGZz+wlLaxy9EPAXnqaS0x1wNxgIy5SUG9uMvW5YtYKUFA/lAMNYIzlrDoamXU3YQle9chjLVk8IP6gB/FN2HD8WNFktmk8s6137LSPuKRu72A9RdnYu1DGd0E4vuzcPIJ34pzQ0dwFfVkLbdYBx6ZYoX091cud2sUCBshMyoTi8IGqVQFTu8WMirFHtWzn4aG9/ai8hywyoJ84QYvO6EQifMPsWOAdQtCVvwgPEs3U8S6RMI7eBXjgPacal2bQq+d7wBcaRd91y+P5UNXjMVsfaJgVP8ELiAV4dISn9YcYxuHPOE2OOSrz7RBoQRiiH0y3rZUbJ5rerpSWfMEUvnzD0K0AUPjuwAFYwCH24+l6AkebYtGVkSXXJ1cHGBmIpgFZ+0FlWWLb9ZzAIrMmk75s0UgTyp0YlLf97aMJLH3GC+pwS1IUuYS7h7WG8QAJTtpPixgM8H/4P9id/iuyArakY=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(55112099003)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e+lcqn1L5yZuunrssffvcfJZKr08/7P/0MLfqwTVPYltK/vSBZqgr2kgGxYQAYxc3xnoc38W1YGHdEEGnWLmttC+Z0CjCfscTgZ5Ha5r5L95XxeqgRZllSaF+TV+qI7/T8z22YqeySzWCHez4DDbBMH32DhC3RitNo8SLYMX2v2P3q+RWEvoCUusquUD0kjnaODH37mCcIWB3FLtv/hE6DRrwkabqfb3X9tdGMuN5fb1qafXZc5CnnIduFcrhQnRLYi22M8S0sF/LoZ/Oqo51ue2CEkXOtxaozlSp10O5lQBGnq4yL0ah3NdMGDUU0X2UufmGA8abYRh/ZLfKaeDhHMJ6XMphQAT1sBRrZH5ffT1GIm26ZmbMwYVPaJ82+kY2bo39XTK24Ru9Z2NLprPMAkKndgAosTVmf2b8241VcXt1DvxxcRFR/5QzUNlBLfM
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:31:50.2150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23287a7-3f0a-4e35-c8ea-08deaccb7cb1
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7880

On Bartlett Lake P-core only SKUs (e.g. Intel Core 9 273PE),
cpuinfo_max_freq is reported as 7.0/7.3 GHz, exceeding the datasheet
Max Turbo Frequency of 5.7 GHz.  Root cause: hwp_get_cpu_scaling()
returns 100000 (default core scaling) instead of the correct factor
78741.

Patch 1 fixes a framework regression introduced by 9b18d536b124,
where the registered hybrid_scaling_factor is bypassed for
table-registered models not reporting X86_FEATURE_HYBRID_CPU.
Patch 1 must apply before patch 2; the Bartlett Lake entry alone has
no effect on these SKUs without the framework fix.

Patch 2 adds Bartlett Lake to intel_hybrid_scaling_factor[] with
HYBRID_SCALING_FACTOR_ADL.

---
v2:
  - Reuse intel_hybrid_scaling_factor[] with HYBRID_SCALING_FACTOR_ADL
    instead of introducing a new intel_cppc_scaling_ids[] table and
    computing the scaling factor via CPPC at runtime.
  - Split into two patches: framework fix + Bartlett Lake entry.
v1:
  - https://lore.kernel.org/linux-pm/20260506095157.1591221-1-henrytseng@qnap.com/

Henry Tseng (2):
  cpufreq: intel_pstate: Fix scaling for hybrid-capable CPUs not
    reporting hybrid
  cpufreq: intel_pstate: Use HYBRID_SCALING_FACTOR_ADL for Bartlett Lake

 drivers/cpufreq/intel_pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0

