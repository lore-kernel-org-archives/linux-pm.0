Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022099.outbound.protection.outlook.com [40.107.75.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076AD2494D8
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222290; cv=fail; b=Zn7KsL0yIAVlGpNcYSJwn+aeNtqK7ypQSi+TnJZJFH+h9fHY9c14/5uyb6G/RmACQ8CIZRVpuIXrojUwTGA+d+5z5ol2ztG4vaqMf2R9Ol2NzezIBDiHwgHDMmK5033Qq0JPYz7VRA1Bn7FcJD2mljQj4MQLI3tnLlg0ZHuCvuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222290; c=relaxed/simple;
	bh=lbm1i/FAk0s8fbkXNKZAAzqHFCcIGBRbi05HGD7pY7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eap6jYsXSgwL+YqpwYeAZ+rrb+SAg5Wcd1VmyD//Dl7dmrKWWMqAHwif3rm7ZM7+8OT5zqnHpwqlFVzAJCszziXS31NRMjHD2DmTMkHadikW32cUxH0yL87L2BVnCI57vNAq666r/jHzVNlVeWG976nK9LhipUFO44YhJELi4TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=jNaFlkBh; arc=fail smtp.client-ip=40.107.75.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="jNaFlkBh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwCz5v4jr5n8gq06GZPN91AhTywQPLz/ty4W6evCgs0qay9RWUSVbYZ0uIsF8o/0TuFPXczh01VBSpj7XSSmzHMc/TPJyFQKoA/EANJ+c0vnfuiXPI62DuwAl4alR0Wm3pze07pFSZ1vvXkX/Os/OB+oX5GPmW4YTU2QA0OZqUVj9FRRvwyNBpTiX4c5WZVaURjMf0FqcQA0g1+jzTq0magSE413FYi9VzD+DGN0YB0I7NJSIteYjIQro9rPMuuESSnloXW1iKC3lRF5FueQRiE2P9/sc0M3KUmCbvEIAMDWfi7aJidWmKyjw2KswgAzpZx0tdMUfiqNQfmc85UCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR+NQnVVF4P4PWgON2KmxTwMo/suUz03UCw42eYkTyw=;
 b=WDaMg5hwbHdd13Mg6FNbNuHPANZoz58m5ii9ZQt+rtrSAYUJL7rPkwUbnGSZsCwueOEECWYpmDuCe9/12hTqzs12KQE6IewlT11BPj/Z82Nk7064PeMoMPOoFKRLr1blb/LF44GuvrJ9zemzoCJOmKt2ak0Y2vTVsbitF/MemoMC+lgSgAJjCQ1m266vjAn+ItnUQGYVZCq6jcEpLsSSVlErdRJJzkCex8cE5UnUr25zobmgoBP5NnBAqScSZ9NxfNlVhnsdnWWE/7cYqzHiuJQignEOcYTV94Hhox5bBGlhQRMX5jUeXpldQnHa1xFIVi1pOPrXklSXZM3hUci89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR+NQnVVF4P4PWgON2KmxTwMo/suUz03UCw42eYkTyw=;
 b=jNaFlkBh3WxVphad0aF+bIQp6Y6c3EPwsHMBfexNPAZ/xft5nu5U/U3svaXjlKsTbDsUxSXrzf4iWHPJzAD2MQUHdeRRoyDztAIsE0hD/W/oA/HQGOZpAhSr10dUqcPUQRJHLwQrlVCmrTWaqd8/WA1NPwS1IF1hFQY9BPr0Pb4Q0YZkV6p7AGBV/RjddqNZlu0Zt/qMaY6J55oPg8Y9F0EAUkfLdgS9gcAv9hfirQx7vVxbktPe8eo2RH0G27ks74jX9alihq47jf088LoG0pybJCRi219MQJW/ierHOp7cGSwW7FnrCpT+O6aROpyLEQoCDEo+2rCtPh+9z14jQA==
Received: from SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) by
 SI2PR04MB6099.apcprd04.prod.outlook.com (2603:1096:4:1fa::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.19; Fri, 8 May 2026 06:37:54 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:ff) by SG2P153CA0002.outlook.office365.com
 (2603:1096::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.11 via Frontend Transport; Fri, 8
 May 2026 06:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Fri, 8 May 2026 06:37:54 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id AA397258;
	Fri,  8 May 2026 14:37:53 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	SW Chen <swchen@qnap.com>,
	Kevin Ko <kevinko@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use CPPC to get scaling factor for Bartlett Lake
Date: Fri,  8 May 2026 14:37:02 +0800
Message-ID: <20260508063702.3249414-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5ff02dfbafea7f5a9129853ae147e6de1cefb281.camel@linux.intel.com>
References: <20260506095157.1591221-1-henrytseng@qnap.com> <7d47a806110c750c47c4b473f45eff6d7f3ebc18.camel@linux.intel.com> <20260507092554.2631883-1-henrytseng@qnap.com> <5ff02dfbafea7f5a9129853ae147e6de1cefb281.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SI2PR04MB6099:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f1a80e0b-1ad6-4385-4c91-08deaccc5599
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CpfVn1nN3TdYvS3J7zFbubV2yYYysbbD6AnYnhYfjLfQKQdqaGPR2r6aWYHj2Yo40HVPFmx+ubrR4BNjKhvg30J5cfomwN4XqEZeamk4vQrDXof++6gl7MIYuNIbUs8i3swEHgLNOs8kfFVs1WvtG2b110k8V3j2l9t8oHKU2y099h3pUJ2Poi2Ivh0UMLdsUTAOzUt8Cd/L28VNmF3Gwb4SkWs+jcphJh8oc4ngKMDr0zVsB6JUOyUffD7cNDTLsw/Gc4Th+Ww2xb9XDhM8T3zw6G9YH87nJ+LZ8L/kOWc5KE8i/fP40i9ErTeRP0BNxzcAj7wlnfE3nvZ6M7HhJ8fhkiTjBWjWf1O1yopdu9I6mqJe9GA+vIZZEEUL+4GdVR4rJ6rxoEhy5KrvEB5Ofho26y74VWwTHaSJOHgyBDRa11iF8/W+w1Z+PPmdpAYafx0wm9y/Kl1XwH/29Deu/GoQretP81bjUWIzeIs+dpcy/6ohnUySsCC0nC2oFoItHK2ioQ2WVwwiO/GnDHgIlIHyJ8bIsWaIZPIsR/n+tMgTufpVzfIJJYYKAa83aGj5+wm0FHxV/LXXywztSxxG2o5hwQyK3ipljfHu+xcE33ylc5IW+Bz3+ESOtkmC/oJDmtq8kP0GCXfRCiC/xHzI+UraffeNwceaaEohPpfl7gpb5SAtl5bmpZcDv7m6Xw46gmJlJ5WLRxuHTmCIe6cMV0C++mYczYTJd48BuOs3oRA=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	clSUDPc9iWw3Khg4+GDkx1qOCWB+QyzMhJQeGuKfm8C5ujaD6oOYm7l2Flz1gjs9LkNDtAtGcMgQ9evH6j17jt/xic7jSFQtPZwNbkT6Y6McbqfTMXf5IGgGIhXCQkr97ljQ35Ejc7swiWXeT0ZHzgmcjH60Yh68+7uA2SRs2AD5wUg/T1lvg32pHg9mZ2jKDFcXJ5Uff45+GW6YyqkZ3ZxYtfDr6+p7V+BrxJMTVJvEc6mWDQsNk1qi2oc4vqdcqmPqmU1/+A3N94CLMdc15Af+XjMP4hFaXDWIZ9AMru3Az+F8dsNbaR/kZJvaayWdqkVKcE4YQ65NXVmH2nhUPAQ1Us8ksDOLOXjOdLU7qWv86RSTfjWD/b4KOOHV5WCzHPAXSv6Gp+r1kl4tERlYj/I0Wm/uTPprizfHH2a37PSsga6ckJ7+X5n+y90SCjmN
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:37:54.1250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a80e0b-1ad6-4385-4c91-08deaccc5599
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6099

On Thu, 07 May 2026 07:47:05 -0700, srinivas pandruvada wrote:
> So I suggest to send two patches. The first one can have 
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2273,6 +2273,9 @@ static int knl_get_turbo_pstate(int cpu)
>  static int hwp_get_cpu_scaling(int cpu)
>  {
>         if (hybrid_scaling_factor) {
> +               if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> +                       return hybrid_scaling_factor;
> +
> You can add Fixes tag for commit
> 9b18d536b124357fee56d82b1462c02f78d219e5.
> 
> The second patch with hybrid scaling factor for Bartlett Lake, which is
> like RPL. 
> 
> Thanks,
> Srinivas

Thanks for the review. I've sent v2 with the two patches as suggested.
Henry
