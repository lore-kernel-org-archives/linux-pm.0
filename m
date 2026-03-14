Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CB28E0;
	Sat, 14 Mar 2026 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773515426; cv=fail; b=oB2MUwz6WGLWuwinafnxKxdc2y6DB9+Y6M834rN3YRHW8QopxKGqS4UK7+tLmQuLAls4KPs+0rGYl/dn6AqZxmIL/6ww/HzAiB7hofESnICsIM2onkxFMk4n1hgWlUMVRyvfyUUG6No5Hs+dA5PmRmEfC29tgUUrdbmAO6DNBN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773515426; c=relaxed/simple;
	bh=DnMjD69A/J8uGJk68dizBSoNHus9v0gqXpAZMx/01Xg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sb2nuZR/TaRHYpMIrekmOQVXrMktFLPpPDj2qY0jT1Np58zwIz4E8iEvuj+DC1aIYnqsrq+wGGmLAjGpyzqvtPj21sXeYZmkP1KApOobr6x6dtY54gfTVnCSuOeNaYxXOAM4UVaSF01t5ZSVLLK8XHuV+dwnKHygs5lETqGd778=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tTXAQCLc; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tTXAQCLc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVYbsF3nE8yPEt3hk0y/LDHYSU4Wa8AWmtxelB+bVk2A3ZHyDmiV1oGl8eQAilz0PO65cxZtG9aF8zcfHM8SCjptkDJy4MS67vBVSv2wjybSyeoWR+Ha3o4KWmsfpYHvl+3wX1TNfvYjh15nnVuWqRCaF7Wm7xhxInElIc5EG+ymMCZF36PyD51SeUHyEwTnGVdl9JFs4HwSqmnM63qxEVRZ2JG7WIm9dpT1S0jwH1L48rnGUT9IRO3bN6S/7W2MRtWIlfYPKGqPzSYcON9aQwc1rnXaA6h3vIy0C/6wjXFD9YpDdVFrhhoNAeOFfEBKPKQVfFpcdSSd6k/vU/GSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOsmxmLunwJq5NxtCa08vXryT638nj0hnKe9Qqzlxo8=;
 b=uwOVsI7lyQCuMpkH/YlV2HOUlyTjJ9y+AO/0f3QucP6UQ4mURSy4ezbspXOkxL/vt7qSp85h15Ti3xefPO3CyIhcLAdhe134/NrHSglh4nvBTDfLu4zBSUnSZD0y33k/zXX+w6hOWtR08CNir5tlcTt67XnzPVgTqebB/2H/F3VuDX7bCI9jYNvnoRMTBmhKvsUwux/dXz2knF0EK5LCBI9Skknm3N7Dr3BKiUL2i34h47OKJpr0zAMhQqayjnqiT5Wq9sgzZTCSsXf7ZZFeko+o4CQqpQm9pnIaazVa4Y9izKpRCSU31KyhUlMClZcFizs8HFRx2/6FAlDEBYYiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOsmxmLunwJq5NxtCa08vXryT638nj0hnKe9Qqzlxo8=;
 b=tTXAQCLchdU1bWAz2YK3nncXwpW8idgleyC5woPx0rCe1rmu2uXyNg4RPZFxV6PgSfl2RnwywmCjjGLg5v2PG6kCQzGpjiJtrEYcQBkF5I411zzcPr06lRkXH4JnojRqft3nEeI6+pzPQC26XtNRzvPy3YVRpNJPiyHE4KhrhlTmG9ZFshfAvgw3Gsu8/MtaoNWz9sowiOAkG2t6MJBDAYDhR4rshJOeik+nrw+0A+5Z8z5yos6lT6MSWojKR2K2J3vORiCTL1CWER1uW1Ibb9NfbzJRVm+AdVXC76VQ0jx6gT5Q1wPrHRSmL2SNIPckGe4WW2UM/AZsD+/Ygge4vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.12; Sat, 14 Mar
 2026 19:10:19 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9723.006; Sat, 14 Mar 2026
 19:10:19 +0000
From: Yury Norov <ynorov@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	Yury Norov <ynorov@nvidia.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: hfi: use cpumask_empty() in intel_hfi_offline()
Date: Sat, 14 Mar 2026 15:10:15 -0400
Message-ID: <20260314191016.603067-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:408:f6::22) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 208881df-54b7-4ca9-6b75-08de81fd5515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	KIG0jPsdBDXw2M/lpyRAf1tJcYGbitkwV7B+rD+2VmsDZmq19ioxDDQHxIYif/7Dl58ufdgqYiKYym7Vn3cY8Q4LHyzV+WYDxwApsvX9GvP4nnL0HdMOFPVzQMK3q51pVS1QaQNTnJAOLnRMoUCCXBwNt2DEpJR4PBwIWaL+rZULm6V+RrOgALAxB9U8Au7XS4B7U0PEtPEY921n6Pedcan7L3xPNN6JpfKWEPZBHeGp/iWtRbLri0Aiv0rCdULaM7cvjau1LF5NZs49twWcIAnlk3maaT8OA1+n4oz1Tj7egWo8v/fCgyl74KRDHe+ADD3L70YJOir6QPr0/tnAy5DIwDAMXWQQKzqhsZZQAo/kqg5e0NXO7xkDAp4KviDFqMKLh/nlXJ+TjYxqgtV7oI/H4xirqz5C/2KreL2JPKsYfcz5Zrz6QU7RU53miEmGwsK0Ld2/5mZD2VAW0m3s1o9HfjSEyaBpX6pnfvlEbPe1AyP4Ux2ngsDlSpKJO48r4bZ9xaXH8/i1ejjeVB1L+vyifqo8wn1znozDgXZsV0iyAMYDrTpgoBTKB1VOf54gkDW6q5LvlVX4oz5FRjrnpMhs5Moi7tnpDy917BJ3d/c+Uiq0z0cC3xlq8/SQoXtfSAI4uszMv0UfdDE4RdVAwN/mIb3biiEKIt6q5hv7cjUCxAZrv0fmh7McFGViFLDEZvKUZSfizMDlcRPRcupdhdaWTCLu+qgMTnm9N79ZeuhBhqPtGzbYq+th41qXSetN56t/y9bk2+cdCzj64hswvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GxljQoDZVHSYAjH8MNV9edXhgA82YbHjP1a/cxfPkPrpg231TP3GdT9b4n0w?=
 =?us-ascii?Q?35vPIuBfLMhGeFlU1nwWTAm1a4ZCIEVTtKvt0kKRc6Ll1XRLYN3LIMftP6mN?=
 =?us-ascii?Q?RzkhH2TDtBFjoqCSU7jtQhzxPd0vaZCXcTCQXAk3t908knzeUN0WR2fq5utE?=
 =?us-ascii?Q?5uyFlX5Er2Pf455jlT0K/0uqV1GCFpCgV8wpJr336KHDclR0Kz0Ctt5CV3xP?=
 =?us-ascii?Q?H3t2+RgsGIKA+8z95nFahf46xEOVRBcwTD/Y+Rr7PJgWFp95ftzkb5VRE2hL?=
 =?us-ascii?Q?Y/9XzIliL7Q8nryuKyXJR9EG42F2Q9PNwt8Yo26NHYNBQbojMrMDvAvad5DW?=
 =?us-ascii?Q?pv/pzfpEnLBiZz7XWFRiGXn+9N4SLP2QJ7uMN8CzYU8mNKjEMvG+aDc1QWEr?=
 =?us-ascii?Q?bSUJaUu4bdCG+zQyVEa0AjamC5znJPJYSX1GBo4DPDp4+HZKIE6+lJwywpKK?=
 =?us-ascii?Q?Rs0taQ2fUPkBwwFj/rKWeK2OifYf2C00JQ4I5/O2e0cUUpjPOORu/Vs3MTYm?=
 =?us-ascii?Q?J0czv2PRCM2AgCqlM6wUkMIPkQhvJO04bNz2zF+J56+vk78U/cwVDDv7zqnI?=
 =?us-ascii?Q?ksvh7mbkX3Jd56Fc1VfT76u2MbqiOqz0qAoob82J8/uBdOU2Qr6RASCE6LVI?=
 =?us-ascii?Q?WbWw7H8cU/xaIihKmbvo4TH6xNoT+6YWWZ+NjJg6rhsusZaEa3NzyRFz5+Rq?=
 =?us-ascii?Q?N8iNNZ+fd7m1YpNM6IMlYzYh5cfA3lwhgn/libpumcrJ4J+COKEy1ZfZpDPU?=
 =?us-ascii?Q?aO+Mlev86EgsFl9lUy9TqsnEZeOf27tJqzwUvCwqwwgZAFRu66Ivykr5lHPn?=
 =?us-ascii?Q?6yjcLvXsTUmuIZqufIBhzt2nmnfukCDUjaszWTNDvybXWagatykX38A+N2X0?=
 =?us-ascii?Q?f5rwwz7swBp+Sz3wWJ+rfI8xmhv/LMw+qc+n4N1W+AD2/63HRbHlWVPTlN3M?=
 =?us-ascii?Q?iHnZeDBP6F3xoYsjOfBpvK/5p8ySV4WO2AkEsz7xe0qLjGzZp4Pwm/HeFeQX?=
 =?us-ascii?Q?5znKQjVdFcoVZ7X3FEjIt5WNCAtn0koM19GNytpafequIX6bNvuhuhK10sax?=
 =?us-ascii?Q?ycNNfcJ+6t9l/6j/ScJaCaX+qwkdCThW9QfcjlSg5JZIR3Q481y188rpzpOp?=
 =?us-ascii?Q?TSB7R1vzxZepx03PDVcysk7g9N5un6lpealPTn0PhuE6MHmUr2wiLknK1BaO?=
 =?us-ascii?Q?JTfhHJIXKnd6JmeGMl19kkGxG9tpuuq9tG4BN/dE7fr4FvRRp0DH6Gi8Iz9U?=
 =?us-ascii?Q?0XaGJGVSCK1z3b0zrAv9gMpLdkSJ8OTrllbchLhMgoe9WlIoQ3qHKHgPVyAi?=
 =?us-ascii?Q?EYv+KYezWRlbi7MSJxvjnR+PqbWFTt7o9JyjhMVknWd+PQFQRsjuNpeo/+o/?=
 =?us-ascii?Q?HF6gnUK9gfIvBCaZyJIVw0831Sf01IOb334kTvuuxoL/gOXfXi03oIP+7G0Z?=
 =?us-ascii?Q?uTdKi7dH9y0pSFeRYtl5H+ECI0ZAJnkKj4ciBKnSfSoLU2nuYcHIYhbpKWpF?=
 =?us-ascii?Q?LOF9a0efLnCW6O1E9ISjsIl2y0V24MC1cl8J3cN+NoIXPqEsQyJ0aaBoRjwM?=
 =?us-ascii?Q?9MHkBI7j8SrgP6cOfvCzxuV6eUo3cVDVkuEhb16NP6kXrNm/NfjhTIPTtY/e?=
 =?us-ascii?Q?O7zGyBwwQINvSmmcJqq755JWrJTd9jiocA9T7DNUlLfb7pravaZgA6Jz7E4C?=
 =?us-ascii?Q?rjej6o/au1oeqNCEHVtzJ90BHLB7JweBXuJR2VeB37GPemIU84qec4HJzzns?=
 =?us-ascii?Q?9/YY9QpksRGpDTnhrH6RBi9zje0tDmISlI16mZyTx1prn44ICSQJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208881df-54b7-4ca9-6b75-08de81fd5515
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 19:10:19.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f27qW+aiBQGnWEVJ6UQP1FvBBmbRsRqKBUyEosU4ep1IovwZzyTEwOSNGLF3AjfW1s58ZkzteoLSiGz2ndXp1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194

cpumask_empty() is more efficient as it may return earlier. Switch to
using it.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/thermal/intel/intel_hfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 1a1a95b39405..8c4ae75231f8 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -526,7 +526,7 @@ void intel_hfi_offline(unsigned int cpu)
 	mutex_lock(&hfi_instance_lock);
 	cpumask_clear_cpu(cpu, hfi_instance->cpus);
 
-	if (!cpumask_weight(hfi_instance->cpus))
+	if (cpumask_empty(hfi_instance->cpus))
 		hfi_disable();
 
 	mutex_unlock(&hfi_instance_lock);
-- 
2.43.0

