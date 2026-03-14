Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C07245031;
	Sat, 14 Mar 2026 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773516352; cv=fail; b=pKFE8rnODend/OMTUFbe/puaRyct36T4PgXuKEtZLTqvObclhS6/5o4CEek6Q8vqBJp7RzXkUykBaPoiLyzRkPJpybdDVuQNjYGglRMqes9CYzowsCtC1/ImE1E9mwYxugo577ZLXPBwNsSOE6g5pY9RMJ6wy7j785a4gtxqBzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773516352; c=relaxed/simple;
	bh=gE4c9oPWWNuvcpc4eLuyKHjyOguZfqvyuF5+cH/VMvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M0w0krsfwtD40pNRJwbWEBQXBld47Cqu/0GrDuoEKsbDXNV38aIMV2DAQf9dVIRbyrr0DeMChd3Na5s8dcs6VxqGaW8Nxfe+r1OLQMXY8mDy8Gig7cRlBb9WYFrFf/jyoe/JrxAXsZOExMHp6CjdFZtUPHiiqUrraZESLYrFsqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZSsrGH/; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZSsrGH/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmYYdydxDakgxUyLjy4e0cEIDs45kXkyx0qIZcT4pgbhAxOwHDOB4+w1WlReLx1AVOyjuWZqtv4ZiZlzwllOrEXLP+JRk/vPBbvhuVp4kolKueZ+RSk5adbVBYfW1VCLFgrTgC1dWZs+G4HJPOB18O0+EYst3rTB1bfSktyODTimaYXialLaAQoVPRcmrgHTxQE/Py+u39Qtc4d82PHOeni/orHqsHsvKSIeJyXs+NkHZ/oDcPOk+BBNxhGS4H09klKNzijV+PZJ39Kk4p94OYr9Lk4LIXN67u+iG5Gs1cij/nnLvHVTbtFrjnEB78Xf9aeva5sQ0vSwKu0tC6gJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxh6g9JV1arFHXyWjBZGroDcL57xdrRPc2jcPEbK/fU=;
 b=EkkzAGlrbq/y1TFlGD9LGPrgL0XDf9ozcfCYp8h/w2DRGEruNLk5LlvrotlzH6mXo9otwx4eoBT4v3vWzjnhiw9zt12R9YS8+dkcbKtSdxmBSOTGJhKq0ZIvJkgFM1dVdadN55BbAoPQJx45VfuImA8FYlBdxSRLGTRpM23NoJktXgRuKT4K73JSZ9Zkn2bz1m+TrgThXVYXO4nJd3KHgNgvqHxYb5z9ZonPnRCpnuC8+JFCpBDpiydtP+T9NHxcBwcMXKsGjMkaiILzovo8xqGrSSTeLxJEgROvoYiYwI9aJUV3iyD6rZoX8auUJ6KxaLPUMb7019B8H5ZpxWDXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxh6g9JV1arFHXyWjBZGroDcL57xdrRPc2jcPEbK/fU=;
 b=XZSsrGH/Hov2HxzOzm7NPZ4Xji1/vDMLuTeRxQaJMC08omycHsOpwcryG8uxQQdYIHPuR79R7NKxiq4Np/9SYo5/OEW2hPRiAzabGGs3cd/bBSp66BE8veEVHz7Rf1kcXDhL45TESPqopG4rbNOGXPo3r/pRjEHtRst6g69ROrobfU1WOrpmFs8/6oPAmXpqM8EUKOM3ayuaaWwqkGoL4UhylIft1Gnxc24zC/MEZnBsRXsHlS4JTD70Fvs9wbCGdSZM/CP02i9wzszvfpGF6hHRCsXMZtO6YOxcRhtXmQpROX2V8Gd3qO4rYGJ15SM54aC8x+yez74V7zriC/Fkrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.8; Sat, 14 Mar 2026 19:25:47 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9723.006; Sat, 14 Mar 2026
 19:25:47 +0000
From: Yury Norov <ynorov@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] cpufreq: optimize policy_is_shared()
Date: Sat, 14 Mar 2026 15:25:44 -0400
Message-ID: <20260314192544.605914-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:408:f8::10) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb3b918-9fa6-434b-8478-08de81ff7ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	D78zSKOfX6Y1o9InDiaw+wpOFdNz/UEHLEnaLQ7aBqgw/3UN5LDfqtYCmdU84kcGW1xV9cY/4OToBXvNOAIlYGDVnV+gxSpIDCEv9/RVuE2G/JwKl31uDTz1KD44blsjNQghJkzwd3UZsvx8DQiYWVnEoG/LPFEFeV+VnyRlWPxXu1k+JTA0sp+MZ25qJjz7etQAOP+VxtS8ns89iQGTjggUmJKady8v1H4LQXMZXun5QgOJD8qWLohIAGpT7YZziQkv7SoI03RWDBeLxn2ISijGETjIZ6yPYMslm2Sup/D3wvt9szDH35iZUJu5O9lZ0n6zDAShD+rgnD7KLi0AWQS1ORG6YPJvuW1SJCJCkzcx//avGYtpu903lPJy9tVpat9Xng97yF+F4VCnrEzepE/8IZUvDaRfOKBKct+fy6Qwaf4aPf7Rueq/hVWysSl8GIbPYMdfL4lgXoc9ugEAK44IhAApW6DI0czr5GQV27K5MjX2EF/M+2sVZoB602tyDMxVvnPobgP4pMe+rcufgHfSilHXFfc7j1mDtIYXx5LwJHE6xGmd4syMwRZSQY4xkobDyK4vHXnpDjj8grOs5XLmRRxoOfwCnRWtEFa6y59NrpjzANY/o8Mf2FM8KRHOqK1BW0Fct6dkGVPudWExf7nCYn4OoOX0S8xci03HuvIo6+DFVP7o1RuSUaHmB+tD/ddVXcn7+O4vpJufKe6oHgOCeGzwoipQD9Cig3zbsgk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oggBb3AOAM8x4EqsNnr5PoyGb13BSQD/K5lHmA5z+TrngzUYsUr/YiQbQK1g?=
 =?us-ascii?Q?+2aGqsEz3obbOJGo4ZwvOVTa4d9rcTlIVoHazlkC8cIF/7u9nojfy4aRBVel?=
 =?us-ascii?Q?ZQpaRhxlHNLPelLsERHxFN6Gq+CSyujn9H5SWFJxj8TFBCtZeYbrY5cHhqOf?=
 =?us-ascii?Q?r14T3h7Z4rRe2IUUV7PqtD4DTP5mqLaPaz6FWRqw3uNoDVwT5klFH9udzpa0?=
 =?us-ascii?Q?hHUzXknP2noyOklaG7fzULlrPnCM66q6YGMSpxN6cMRYc7Gtb+7cc/kx700p?=
 =?us-ascii?Q?jcU0NIai9z2GiIQ8qQ4rDtpM+lQHpmWle9Q6KKWZ1kZsly3C4nbHhe+X8dmM?=
 =?us-ascii?Q?yGGnq9viBQp5ZbMHYDeOLmBAqlq42G/HzPuAD4YxqV1BJ5nCMBju1WEynzU0?=
 =?us-ascii?Q?N05MLRQiEFL1qB3F0yTSyD49Ph9q3XNNZYs7RwY1H4V9CztlLr7feqKOTQIG?=
 =?us-ascii?Q?Iv5T0zt9nxAtEdrn7ShBpW0D4ubf7jGSggWnRJwNF09tTVi98Z23R+iZ+sud?=
 =?us-ascii?Q?YWHLPg8E6r83mQ9UFAo73YsITwrtT7RxV7RzmPHesM3nU6mGuePd1irHyjG3?=
 =?us-ascii?Q?ppNIt6TG91Qu0vB8/zjflHLA2a/swdYKKYtzv/X3LQyyNO5sZAIypJU4O/zU?=
 =?us-ascii?Q?5gKrhIMfYpwMsF6rJdiRDOagjiWEWyc+vCG2DHHAu/tq9fNa5H6CS2ApA9QE?=
 =?us-ascii?Q?5N3dY+cL4DChlUbPtEeEDUFuSYJ3oL+mLLhPlXnpd/t+jk6yoqJu2LsI0f13?=
 =?us-ascii?Q?+HkortuZv1e52iyN+6tvQOWqnZx6325XBt/FM0OVqrej7VSR5PN/7xxDj9v/?=
 =?us-ascii?Q?4c2B5fVmgYExDSAXjlM1F6jilYtvOEGHQ3t5ocaP5AkWkTa+PLkyE+fJ67qk?=
 =?us-ascii?Q?9WHmu+/ndEkUPh1mU0GruB5lgrcddaceL58dRjzZ+M+iufLrDR4YrZiPexOO?=
 =?us-ascii?Q?vzBylr08UUGk6QVQViO49bsbJXlW5T2+13BjIO6/1cCr3R66zNHPsmhJTYin?=
 =?us-ascii?Q?WzEaOj2N1GU0dgnb0VEfwDzxdPgVAAdH5U9OYUG7oXccBVc/hoU93xvhA7Ce?=
 =?us-ascii?Q?V4ddvU9YYi39CzeBAfYIz2F69zDi8agqCZ421wqHSr1sKLOuBrXCUWI2joHG?=
 =?us-ascii?Q?BAcFjunprCOaZpSU2i1OGWceNHuJxIrBN9LsERT+6ItRz8yhcYIOWU5vAAlS?=
 =?us-ascii?Q?XAXQwX94vrrkdP4OA0AkN5f9A3fQJI0Z5nyki05f+PLjx7cBipoSf/rsC0eb?=
 =?us-ascii?Q?kyBVsLr02LcPcVGG46AgJ1vRCGq9PJKm/NSOXRr1qob7KV30BHfwhAnYgulv?=
 =?us-ascii?Q?neznhhHCPNOrJc08hfBSRm+Mbvv4PR+wxR3jgUfqWMmJDc+OzzUIrvGMZ1zq?=
 =?us-ascii?Q?EUkbpYgdGgf948hs6Sh1FMEYLoYaHuGxG+Ct5PRrjB879yMWrXlpmAa7sh8j?=
 =?us-ascii?Q?Dx9h/M1dRL0fWL6hwgRAVE9yr0TwL0WHWT1Sq6MAWPRUgsysF34qr31mgXmO?=
 =?us-ascii?Q?nurcQX5/BR/X/qkr5bbTyH38Rw8wO7ay8PHpaaINNr7ikJCw7918XGkjErwT?=
 =?us-ascii?Q?nKZi9/EvK9I511KyWU5Qx5xRZX3kUkHyGgN7a9YRDGEyzhtJbPOJz6Wv9QH5?=
 =?us-ascii?Q?15EQWnIN66ZbvouJ1ukVh5ngepOTQw7zdChQW3/lcsxp+ulmPw0P+6bJOdb/?=
 =?us-ascii?Q?LjMnJPhCDl9Nq29od1MNqmdyCKR9SP1IyZ60oH1vyg/Bs2eQWmD3J8yH2dr9?=
 =?us-ascii?Q?pMnmkP+U9MCcxsvCBZfXNT2tuomRz+R7is/yYb/gt1ERbkP5iSCJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb3b918-9fa6-434b-8478-08de81ff7ea2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 19:25:47.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFAaVVaDM2L43cyJxPGbJGoytoOMTBzy7Rdk9LFcTpvJV5hxEtVcBr6JADzesy7rPjdLLciYL72i7iVIwRn83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062

The switch to cpumask_nth() over cpumask_weight(), as it may return
earlier - as soon as the function counts the required number of CPUs.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/cpufreq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index cc894fc38971..8ca2bcb3d7ae 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -232,7 +232,7 @@ static inline bool policy_is_inactive(struct cpufreq_policy *policy)
 
 static inline bool policy_is_shared(struct cpufreq_policy *policy)
 {
-	return cpumask_weight(policy->cpus) > 1;
+	return cpumask_nth(1, policy->cpus) < nr_cpumask_bits;
 }
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.43.0

