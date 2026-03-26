Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309234A3D8;
	Thu, 26 Mar 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512730; cv=fail; b=aeykPH6Fq6WCdHy8AJr4oXpSMFoz9MVIusycf9CoDBWGqdUcYKZ1QtziGtlDY9rs0uIuSlQrwyFWeAqrqmWVhDhS9wTmohsrvClOyRqaKWy6EUT6ZWTww59lg5SayZMzYt9BiLp0uqnMBdWnoWowxgl+y8JBCVL6YOpmgW083G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512730; c=relaxed/simple;
	bh=/2Z+C4Wye21qJV/F8225qPjO0vkvMEg2u3+Jx5F7m3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sQ//czirLXcLtz88GByK+nIqGuvMw+d6QgDKzU7ffp0f9GPNQoiD2LIXnJ42uUJS8iwkrthJM4CHJbWHskQEFCzeb42xwicUSxrjMs+K++Qghf09IBWEThyo9wMx8wLuwNx/v37B0nnr2/IUns1aKibIEFHhr4G7D9oc6z9rjv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dK4U/Dq3; arc=fail smtp.client-ip=40.107.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dK4U/Dq3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNbsoEIrddph04mBr2mlqd10nFUMqDR4YQCuLsVq7jK629v/cxtCj5LA7V/lmtFo/VdYURn8FLwza6hRU2s6Dot8UbynfLYs37E9Kgyq8inEFN83unJyBRE5hhYyseLsh4doHgxczTLXe6erJQwByzJ/ywoz955Q1DY85Ue06Yh64VpNVeIvH7MsUvQUJdH6wxCZqtMXo29mVXMfC2Q4lwoUWPXeakKJxwrFYUHbs1W/yio0xrYVFv+3R3/ZF2dQp5AkOEDQffhq82eXK342CG9jQ6fD1hbwsW4XFrYVsm9RTq13AiUFhj9PrRUuWRgqhqFuzTmBtjNq11UPDpud0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5OoKwKcc4UzF/12lbbRNAeKJ+Uh6Xn3LTNlySPmlW8=;
 b=VqsbSXvIilrd7rkZZcYr9Bsl8nQFxy1ofC8I4WuRjfNQBpoYVFMjE4Ey43O0LU0Z2bDnNyYiivclmrjDWbIDCzS7dbxveXyUSs2e1ObwlD9J4VXnZW+kOUxAKV2dPXektkffkX7JUk5ypv9ny9vuL95VrFukqU1Y6sqJ961aGLHSofX1LVPeUQUm3ghA/3VcQg9Eekpoi2jAYywd4e5yE8E4VqkG+gtE2Z/HowaPf218X+nRFFO0ruK041j34CK/Ji+Fi2OGHF897MJe4NzTDLcD3QuorZkSnZlVWe+eztdiujbFF/UqsuaeGftrG2awyRWXVWMi+3vPs1Wl32IlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5OoKwKcc4UzF/12lbbRNAeKJ+Uh6Xn3LTNlySPmlW8=;
 b=dK4U/Dq3eLGUvgznjCcAw8drcpgrTBsZCK8QcqJcoqOWwc2Xf//ox5jtBiKYpAL9gfg3GHuJ21koCSLRUU8LUVR2kMXV4BQRqTEmV2Fw9JF14Q+7ac3BmZ56jhp0QRciGVCbz84ufMbc6ihEluYeyVkX/b2KUYLFAQNV5cgTUD+ykStdSe9D+4jjbmq26osorOCPbXzIu8YB2f3smHFbTwyzCiFuYZqmfT50S6ef8F3elNUW+uZm+9ZAqj7SEr8Wb9QSayc//u413aNIS4x44syjNjawTTu/SVns4ok8S0nqTbMi1veruSrC0GuwFNw3C4FGXmJ+HUhqqEbUk+EgZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 08:12:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 08:12:01 +0000
Date: Thu, 26 Mar 2026 09:11:53 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, valentin.schneider@arm.com,
	mingo@redhat.com, rostedt@goodmis.org, segall@google.com,
	mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	kobak@nvidia.com, fabecassis@nvidia.com
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC
 asymmetry
Message-ID: <acTqSVd-FhywPQ6t@gpd4>
References: <20260325181314.3875909-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325181314.3875909-1-christian.loehle@arm.com>
X-ClientProxiedBy: ZR2P278CA0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 1306a8ab-6382-4977-092b-08de8b0f5bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KQrteVk668kLyNXxutrSukB16GbPBVvM2scB8oFXYfNR7oTax8Q2qFOqBZ+cMIVZQtG9BTnaqnMCmXudl0zewzNSX7SdSyVcMsyntrzrTyF4E/4d1MweXkJ6KG2RhtHozrypRnYF6xNAlV/BKkHmFntGU880fi9Rk4/npXlnISlwRdt60Ww6oSIbclP/6S4AlbS0+n3RltOfKuKkDvmez34mg8sLcyV/2PootQAqotUEezAOS3sJCQVuvQZG55H3N9IN89TRnS/ImHKrp2Kvpi9PtFEtRggBaVu/VpLqprMg26Shw0k0EL4xORzQAFxLNM7WkLKUo028a+3xlSxZFf4k1HyCnXLfKfDvxvLlr6PM0tciJpir7/p+jbS8hHnBO5vSFnLTmWYtBwNfkAW6ACpohkg+ap5mduFQKsZtbTBCOFSB/6TKrZfg4PvWufUZBBVuHeNhKppZvW0UUIFKmJI5sO/LH+o9wjYrm+43KYFBPXpjjV2jgriCJNgoTHfR/cs9+94Rp8+pRAOjqDmmY3dOlUxwzpWKAJXvSBK0Qd6XSX77iLqX2MtUk+JRMLygK4cRhfLkJEkHtUdUC5onBCohSQO0MQ2tani92veT3VJpqbtZ6+pG4UzlMiGnra7SYkCbBchW+Qrh2cIPqpUqaYStGlrxWAnlHPPfSt3bEcsfBbNHaSpOkybGvVKhoYYSCnPS7KVCwlF1tbySqBqXLXol3Ic/+0uk2CIsfqHZgvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OfRrLkBzo9HSn0ihxkLmYhcoUsJ/aCVc852gW29V0um9RRVn1XKGtsVo1QTD?=
 =?us-ascii?Q?1O1S5xXKpDoBvXjshELHY42hOXL4LP3q69C2Zl+cK6iOQm2ZoTZFi4uv71vn?=
 =?us-ascii?Q?vY2Tx87vZBY8f+kDeK2gehGatyIPD6B9/RtQiEFeKIOpInK+WL/h2JwuPS00?=
 =?us-ascii?Q?LOXh+f95eoOqnLvjrJb+8CXZmg8kkw7CZ/0s68xpjqwlOjqtxZhQWNU16mS4?=
 =?us-ascii?Q?OStetjgC0Fzhxwz5Kwz5ibwl4UIA26TyDSgqE/j9HO45U9PVTH75Qsa0Hc38?=
 =?us-ascii?Q?wi9IgREnXg0upEetV1gzstg8sqnuD1xQprb4dwZVleYv01Nz1pslWaWveSjz?=
 =?us-ascii?Q?P+VHSZySPK+1xVlzHXONGzfcw03uf133g0URePYbL+zC5iaU2AhLo7zz+rJy?=
 =?us-ascii?Q?CIXp1FLMUlBf94PBOgXWR9jScQi8It8V3h5Cy0ZOoN/7INh1vOURQxI0dPCS?=
 =?us-ascii?Q?ewVEPWvP+3olUQLnuOZpey0uTF+Dt7Dg0RZ1UEM9/lGq95JMWDnfK0xi1SPK?=
 =?us-ascii?Q?7SqO1bZIuOybdjkS5RkA/X6k8mzFEW+0J1Rgu3s69D6HQXsI5TzQHxa0H3FX?=
 =?us-ascii?Q?C/3rEjPf1abYvZvj49WtB66qzXgjK6jJUZpDC+lLHjFNAuwL2SmE1QLLWPT3?=
 =?us-ascii?Q?M+JczKfbz7QmSnpnG27eZOI+bXn/2y4SN2h+MXnOyoDg/RAcpPf2CgXFcnJl?=
 =?us-ascii?Q?+9eGK4vkzdg0MK2LmKvHXTahde07HDjq4ml0mURQXvwxSNgHE9c3xOF6FzZN?=
 =?us-ascii?Q?6lPIMLQcDzAYR029qm/ltgLt+/IGw1QXwVxjS81QJgEnlEYdEjGxSGbdPXUk?=
 =?us-ascii?Q?0zemDiaEtaj9jZxL45zEi6uvrf9pfpy2r7+w1OA0s3bLsItmz1IYvZOcOeP+?=
 =?us-ascii?Q?IR5I6JFPL/4S9L18aKfM9LPSaqKK7k8ZkE1TiGt2v4x8vtwGEfaqFuvZJk3d?=
 =?us-ascii?Q?eKsRtVB+A5JA4IIdnlx9+C3a8GciuW1qLlj518aCGFPARnR7ZJCa6WfZL9yk?=
 =?us-ascii?Q?CoyUdwIJLVdYKA5a6R1gOyzHSgOAfIjCmgI5VpHpqIbaZcFKiyAihWlMuUmL?=
 =?us-ascii?Q?oRWK0torZOBhoAvnvXaD1SZswtMMq1n9II3y9sXpW9YOJsjWAZe2bZjHoJvL?=
 =?us-ascii?Q?RtxwXZDNCDRlO7IUiU4uiKMfezjy45+g45KQvVmxBbrMxKGciTEa569AesQL?=
 =?us-ascii?Q?DUTr70Wxac8vRV1EkxEC6leEh5K0R0tEgdFtA/9e329mx45VEAlfUt/18hBs?=
 =?us-ascii?Q?hXo+UoiXzuWdW2gIcQXjz5No4ctOBZM6d6eriYtnCu5ToX++/lhyj5FfsNMT?=
 =?us-ascii?Q?YPmt8NqFOycrJJLhw1jc5mL8lTxTZumgNngChi1W2STqnzP83CP0pjiDcAyi?=
 =?us-ascii?Q?b7Jm1wHs5pKqiF9UyxsudLozYEoDHSDq8BQU7/zguDBzYtzI8K5xNGmJV4OL?=
 =?us-ascii?Q?tb4eLRZxpJn1JXGf1bT3+SmJR8Nfz8/j2wHlwEBdHSsbzyGd3QeISOg3iXEz?=
 =?us-ascii?Q?nZURM5ufaIgqsUbgha6kWrv1zMwYk4LSxggWIkbaYqgy+FsrY+bzUN0bR3NJ?=
 =?us-ascii?Q?HUcfpGRKfJrcyIVy15Atq8xPXGwCFoW6K2xAzdZpGTR7NxRBp8WPu/SdfDti?=
 =?us-ascii?Q?M/d4HFQ4p98MqgZsIJWHqxygO1D04f8JLlMYTL1aT2L+8bF5+lE99PEFtZEy?=
 =?us-ascii?Q?Y48UFDiedGNopS7AOAExb8jbHqhTLVspmCZotB6NYuBYTbTxBwbM7OkWeC2c?=
 =?us-ascii?Q?oAeNam4PFA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1306a8ab-6382-4977-092b-08de8b0f5bbc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:12:01.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W97SSkEKTCO87NYofRe62kiogvh38CSdTGnPw4s80SaUHeHKqzGPYtB2y0KCUljcNy2K0cp1KvhF3h7jE8IbUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734

Hi Christian,

On Wed, Mar 25, 2026 at 06:13:11PM +0000, Christian Loehle wrote:
...
> RFT:
> Andrea, please give this a try. This should perform better in particular
> for single-threaded workloads and workloads that do not utilize all
> cores (all the time anyway).
> Capacity-aware scheduling wakeup works very different to the SMP path
> used now, some workloads will benefit, some regress, it would be nice
> to get some test results for these.
> We already discussed DCPerf MediaWiki seems to benefit from
> capacity-aware scheduling wakeup behavior, but others (most?) should
> benefit from this series.
> 
> I don't know if we can also be clever about ordering amongst SMT siblings.
> That would be dependent on the uarch and I don't have a platform to
> experiment with this though, so consider this series orthogonal to the
> idle-core SMT considerations.
> On platforms with SMT though asympacking makes a lot more sense than
> capacity-aware scheduling, because arguing about capacity without
> considering utilization of the sibling(s) (and the resulting potential
> 'stolen' capacity we perceive) isn't theoretically sound.

I did some early testing with this patch set. On Vera I'm getting much
better performance that SD_ASYM_CPUCAPACITY of course (~1.5x avg speedup),
mostly because we avoid using both SMT siblings. It's still not the same
improvement that I get equalizing the capacity using the 5% threshold
(~1.8x speedup).

Of course I need to test with more workloads and I haven't tested it on
Grace yet, to check if we're regressing something, but in general it seems
functional.

Now it depends if SD_ASYM_PACKING is the route we want to take or if we
should start addressing SMT in SD_ASYM_CPUCAPACITY, as pointed by Vincent.
In general I think I agree with Vincent, independently on this particular
case, it'd be nice to start improving SD_ASYM_CPUCAPACITY to support SMT.

Thanks,
-Andrea
