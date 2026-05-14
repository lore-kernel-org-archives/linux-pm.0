Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022080.outbound.protection.outlook.com [40.107.75.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156738D68F
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753952; cv=fail; b=Du/bgUdLboUncqT374FlwpsfbW9bq2KI8fZ0s3UP91Em44VSICNEXat1x5BbriAdS78811shymhNd+5R7QpYjGXjErJCCf649RIJvAQYA8YXpecY8+CKdeKGhZ3TJPbq/AMakmBhSGemJMzjaG4EeBE6ubdntECQ3AWWT69lBI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753952; c=relaxed/simple;
	bh=P35MVfcDb/yafvhC7JpgtzWGnKsKGrOMQii24vIY1VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gz0yL+ViRG4wPlbny7Q6SevPkpi+msqbaotkg/HqtdncL5/5d5FkkElBHFsq5s5dURvFcc5QOlho2vT3K85ZxktRLmA0pghN7gay6ZrSlQk2/Z5HnCtKw3CnBRbT5EP3RtASdxgTWQCIvH1gEupKlr8IzuqsaVY4cVuRYOOOE+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=KeTfzcL2; arc=fail smtp.client-ip=40.107.75.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="KeTfzcL2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0Dd4TzrfF7yCfbjAVkhSI3jcgPkP3xgS8whhiarY0lYCZWcQKnOuYomISg1SQMm4D8+YYaZShoo935opbRGwWaBiqqdr945X26X642ABYgjBoYadMobVgCs/VrjB9yon3UuTgskhVzhuA478PRSOKxb8bS+hQG+EmutOTjE1bGJnUsuYtzEi1xZi+FfeRGaA+0xKlFUxtBsLVCuHBwrWlc3mHoNCZ+7JAkdZfQ63AaCHfhLW7bl8qRghpVEGJ0qyk4iBDlKcD66rvziuS+CUjluZUDUPaC9FdQ+x+cn6H/hwV6UnAQ+Vwh2DkeEJdxGap6Xeb2pqXWiSLZ8zrZOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pST3tmZQ0J3TjkFfWrIf7OutZA/jo+kshjA7GtFAso0=;
 b=o+vmlb2QIqFWuO0gLNUX4pshsgHBmNwi0z3yGVo7MSIjOEDe5OET+Ea1uJ5fCmHddl3HdjxvE6oI6yft1EqVAgyH/3wi6Oe4GTOaN3GVGHszaZgrS4gGBOTaE4cBV/6+Zfc9X1/blLyrCx14H/sreWf6utyBSI5HZaGYwAzeFCe2/EQusE0TO0Wcfy8hidKJcSQdTy0hKYR7FkT1AiiwldgoCZzD7QjfPKWadkSQamP8kR2A+KQzN8XiYifv4kRN2lhTdeCHBnWuiMVBX1JeI1pzbGRdA3a7ugVqA4uI9J78XKBXReGSYUfZwyAkFBkmjKydWOSsjY4KL9eQ4TrZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pST3tmZQ0J3TjkFfWrIf7OutZA/jo+kshjA7GtFAso0=;
 b=KeTfzcL2UF9JrrU5c5s6QgEGeDbOmVL8AEiey6yH8RDh1LH3Q7+YzoCsnXDxsH5t61Xc0hMPzKG5yHgbhb0ZeTy6t5Mrep/SZ7IWboX9Dg3EjHiSi/FjXss/Z6p0P/tTFlP00BkxK6gAQhH2mxlREZTNTe0SOafYqTnq/WgKSu1YHlr0jxNYs5znB9UObCWbD+4gRhCFwrFetk7Ph3TNyNCvSlPwQ/fO3du8w6k1vo+gGFHu7t6RCw1FqRzvNcbeJoIIjGVI6IjSowpIPzaPqWsHIxtFmuco4v2FEw8SQmnb5wJjZx3WVgnMAPlDqEwgJNkEDClTsbens2VciKYUVQ==
Received: from TY4P286CA0111.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:380::6)
 by TY0PR04MB6192.apcprd04.prod.outlook.com (2603:1096:400:32b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 10:19:03 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:405:380:cafe::77) by TY4P286CA0111.outlook.office365.com
 (2603:1096:405:380::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 10:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Thu, 14 May 2026 10:19:03 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id 1FAAC158;
	Thu, 14 May 2026 18:19:03 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Henry Tseng <henrytseng@qnap.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Use HYBRID_SCALING_FACTOR_ADL for Bartlett Lake
Date: Thu, 14 May 2026 18:17:58 +0800
Message-ID: <20260514101801.834968-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0iR1WFCh56SGFRnkae6hNtD7oBn=5BNKGT1uoPz4_=6JQ@mail.gmail.com>
References: <20260513102847.75179-1-henrytseng@qnap.com> <CAJZ5v0iR1WFCh56SGFRnkae6hNtD7oBn=5BNKGT1uoPz4_=6JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|TY0PR04MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: f14d6192-955c-4160-ae50-08deb1a23966
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|11063799003|56012099003|18002099003|22082099003|4143699003|55112099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Z+b6LE3pZnK4FpL/3qNhp5LlWlYqbEGZJdcEX6Uq9UrMuAi9WvwWyvE8cKDg+Hji9PfdW/YEcPalTDLvUfLr/1asFcphTqpZYRzykRVB28NRBgOy46A2gQY2VsAXVrscZyPLt7DbPtUHzuAzw6tIP96JpBVwhgjrn+UOW4/2wHw6BO8ATpgXhxErKdS1LzaWXrNPrfU8qhCwvuAJl8nGW04OVvY1MFUtxGie0/SLoFW+ENtzrQmH1HfBYo91NhF9Xwm50pXC/aDzSuQH9aOdaTtnM+jckawb7EGrDwN12rgYsWfUcSyO6ATn+xshy+Qe3nCoA9rSAS2Rj26roi9yVsvKeqUXHL5uFtUGNrJqu26r+KxP+xxVYMTIJRlAeiHcgK157dDQ2gJTNElrO4rVNhU3C0dNbuUfnegYf07Vqe6udAZUeejbqucf79y3F6inbOnMxIxMqBUz7fXM7WSJZVvza6N0KK8RTNUkl4fP3o+ANDcWU5IqtNEi3ActXd2MWon6BO7LpTpgQ1RPnP1XoDKQQGk7iW3LXBGkAdiYLXAF8//Hvxk4tr9a1iE2nIYaH+pHISx7fpvCChEdF2v1m9eBrAp47BrH30M68qBZjQmJV0BZf0oD/wHiJ03qz/jJhIQUhu8ke0vY/5MAL7zGEoqmUlPK4/VQVy40okqzLWvlC/hUBsFLrEpr7V8RkymOF83JVDQg1sXlpp/1SqlqdZiQ6bup2oPlUf65GDbw3jc=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003)(4143699003)(55112099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jg36CtH/q1Kgd7HV/LPYtltWzB0EyNnlYTQexTLPJTXTD9F2lQoSFJtO/bHZyiQTls15tV19rSq8grvDhsJdhrXqsKk21AcPmVwhyhuc2MgHjIog1j6RiRv/NN6EuyFpxjTAmxY/VhL8UMBkMnI2NuLWiV4KJDd3AXN9cGawqx+R8NWdGN2yz4fF//Yl2/mkchDpEwTU5ONwdaMi/ODCRV0D9BcROUqVAkZvfUxuOsdwFHBU5plVDy6fDr4JswxdFqTc+CLCCjLqQ11qKRA5Hjg1nAnCqODGGcgYxFyF1lsZ7EsCxA5P8FIa32I7I/maQNEWSfUoJbfpZBl6zfpAr0EZz6fvyaZF1EcEvQjIWqNcQQ8UHmJ8AEYPt2iTivjNtKH8s/FjsAauG5cnC53lWwNMd+/lG2Y97U/TEtq8BEQR3WzObI8/WNRdZdwugscJ
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:19:03.8371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14d6192-955c-4160-ae50-08deb1a23966
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6192

On Wed, 13 May 2026 12:40:36 +0200, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> On Wed, May 13, 2026 at 12:29 PM Henry Tseng <henrytseng@qnap.com> wrote:
> >
> > Bartlett Lake P-core only SKUs (e.g. Intel Core 9 273PE)
> > do not report X86_FEATURE_HYBRID_CPU and are not in
> > intel_hybrid_scaling_factor[].  In hwp_get_cpu_scaling(), the
> > non-hybrid fallback then applies core_get_scaling() (100000),
> > producing cpuinfo_max_freq values that exceed the documented Max
> > Turbo Frequency:
> >
> >   intel_pstate: CPU0: PERF_CTL turbo = 57
> >   intel_pstate: CPU0: HWP_CAP guaranteed = 30
> >   intel_pstate: CPU0: HWP_CAP highest = 70
> >   intel_pstate: CPU0: HWP-to-frequency scaling factor: 100000
> >   intel_pstate: set_policy cpuinfo.max 7000000 policy->max 7000000
> >   ...
> >   intel_pstate: CPU12: PERF_CTL turbo = 57
> >   intel_pstate: CPU12: HWP_CAP guaranteed = 30
> >   intel_pstate: CPU12: HWP_CAP highest = 73
> >   intel_pstate: CPU12: HWP-to-frequency scaling factor: 100000
> >   intel_pstate: set_policy cpuinfo.max 7300000 policy->max 7300000
> >   ...
> >
> > Per the Intel datasheet [1], the Intel Core 9 273PE specifies:
> >
> >   Performance-cores:                                 12
> >   Efficient-cores:                                   0
> >   Max Turbo Frequency:                               5.7 GHz
> >   Intel Thermal Velocity Boost Frequency:            5.7 GHz
> >   Intel Turbo Boost Max Technology 3.0 Frequency:    5.6 GHz
> >   Performance-core Max Turbo Frequency:              5.4 GHz
> >   Performance-core Base Frequency:                   2.3 GHz
> >
> > Bartlett Lake P-cores are Raptor Cove cores, per
> > commit d466304c4322 ("x86/cpu: Add CPU model number for Bartlett
> > Lake CPUs with Raptor Cove cores").  The Alder Lake and Raptor Lake
> > P-core entries in intel_hybrid_scaling_factor[] use
> > HYBRID_SCALING_FACTOR_ADL (78741).  The same factor applies to
> > Bartlett Lake.
> >
> > Add Bartlett Lake to intel_hybrid_scaling_factor[] with
> > HYBRID_SCALING_FACTOR_ADL so HWP performance levels map to the
> > correct CPU frequencies matching the datasheet's Max Turbo Frequency.
> >
> > [1] https://www.intel.com/content/www/us/en/products/sku/245717/intel-core-9-processor-273pe-36m-cache-up-to-5-70-ghz/specifications.html
> >
> > Signed-off-by: Henry Tseng <henrytseng@qnap.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 1292da53e5fc..2737e51cff34 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -3734,6 +3734,7 @@ static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
> >         X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
> >         X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
> >         X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
> > +       X86_MATCH_VFM(INTEL_BARTLETTLAKE, HYBRID_SCALING_FACTOR_ADL),
> >         X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
> >         X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
> >         {}
> > --
> 
> Do I understand correctly that
> 
> https://lore.kernel.org/linux-pm/4523296.ejJDZkT8p0@rafael.j.wysocki/
> 
> works for you?
> 

With these patches applied, it works on Intel Core 9 273PE (Bartlett
Lake).  hybrid_get_cpu_type() returns 0 and cpuinfo_max_freq matches
the datasheet.

Thanks,
Henry
