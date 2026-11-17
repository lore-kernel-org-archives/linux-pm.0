Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794882355;
	b=ngqtkjAVMh75/k+qMSE5rrAhVDM7M02GvcBdZPnP3Re27P7UDOu9ZUu684q+Ycz3Hg/l
	 ZXPoA5AZJDFkkMuL27CZSOk6krStFWB+pa7QBxki7hE4yO5R8uBTiXFfc9nVqMQ7SjUvO
	 judOgaS4q0G5KuFJBz3l9m9mbrs4l1EVxNwA4+CfRrtUxdIpXyE2loWsI+UiNh+hXuuoo
	 V5jX0GKPZTNsAs6mZVs92kZxwhjr13HnTKPIS5xiQ7HmnUmYlqq8CEnEgr54Gho7EjkYl
	 g/xznEyp3yxZ8bxp/4uru8LTVWBcljnhSK/z+CkoFCHVSMNmAej7adM+/ZwvzVFnRKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882355;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ukql6M0dlSxuh1hG1jBYQ8+R6/OJD3Lqf0iG87sJ7DQ=;
	b=Rbp+SfF+K1dPYKnaq3SWnL5D6tiUZUmjxkiofNocXeNsp0EbntGaDbeVwAZ53do66N+Q
	 exvR3RrkDCzmbulVSdk1s0nFyT8su6x8nbVer0RKVAuzzJ5dTu/znJ9GCxhRGu5909bJr
	 xG4Tiza01VRAK7PDa0cJLzp+oaQPIOIlv6zSlgK1kiLuoXnw/GY7XmqzTFiEfJh4P1Gd0
	 5qSyib8yCThtWvDjRVhuCjJ0t02UZJPN+U7fw7fs4+QKy8vbyivEAEU9FKKqwCqkMYJ3A
	 cXi1B5KtaajrkkkvbRaDg5Oazx3eUVw/6j5ebZEEwPoH+NkBUWG0kej+CJW0Cttj9nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Q/WseBS/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.22
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42A606A336;
	Tue, 17 Nov 2026 02:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC42A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q/WseBS/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khtPwaflQDqTq7a04rYUBtusFNwJUSCemMhnWLvrwoHdO0Ad0cDpx/GrD7DHQ9b1nsR5p48k3ZzI0tJ7MlkAKw2dqacrUaqU0hcV9TixCTVqeHRUU/030jIPdrpSwN35kpB2l0akgMWtrmb501E5U2kfGnY6MvDkSgMkZl/PDqctnO9wReH2IziaQNIZia9gN/dl2bcKwYkOfRQ4CsIQrBiRmH2Ydtnl0F05ZDaASeBcONu6PDRWvPkZZTqRXn/ORISGD3dQps24Vhr6o1LQg36dBuZIE0JwTrQvNjJx5pzhbBI7wcZQ5aTSs/lwiqZEVzHhtMS6gsm938zBlYXV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukql6M0dlSxuh1hG1jBYQ8+R6/OJD3Lqf0iG87sJ7DQ=;
 b=Ojn4jyIhWgXSDc8pOORfnIKmrQzWPOEB9lu5+rbFPJ5DyUsQuBVGHfB6GyoApHFNb/8yMG3yiVmSQdBIVJiW0+u3YcoICgsrgVLU6c7NBebMIcM6XTvJBRH8HlFf5D8DMGdgpWf7GgDY+3IQ1R1DJaf1uUCndhGLXJp0zwkaAscVmWtVT5hKpIJxbz4YtdE3N22ydVwLQz4LbH0S+h4JJZCRx7zz1dWKkiqYL6uEuZdnsH44oGRaV02WNZcO54rRlePXLWTDkOoxtaeGlaGPoYGfgMRbV2ZPHHe1MtsUyd5kVFFPLQ9u9vGd6FDP2LGbqLhA/p+dWwn+rqeRiPax6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukql6M0dlSxuh1hG1jBYQ8+R6/OJD3Lqf0iG87sJ7DQ=;
 b=Q/WseBS/jTxMatd4Mm76vsDZdA3qjZlP9V6ATAPSBchKXZjuMXqFyBmZVEAqJhgiR5PYyAgDTYu8Ndj9wM0l74pJnp/ZAm4C35cpOXt6CVHWfI9t3YLGS+yjJzlw3jI4HG9EyXu1FgXK1JT1mBhUsd6GIRaYoOA/X4EOV7PVz0apPzrgAVBrvi2cNCTzi+K4+z4S1A899zm3/SyzmqFsUo5Njd+GASYwHG7JMx6PnT78N4ldTjaGn9WLwdrDhIlsEefc246OxVvyb0rwiWKSuspPc7bS/unjlZL4C6c4dteSG9KIKpI7sMFZ9yNQiSmovLafO+2XaM4WqePcIjCdDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 02:25:49 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 02:25:49 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Wei Wang <wvw@google.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>,
	Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Fushuai Wang <fushuai.wang@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
	Mel Gorman <mgorman@suse.de>,
	Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH RFC 2/3] sched: decouple preferred CPU policies from steal-time accounting
Date: Mon, 16 Nov 2026 21:25:40 -0500
Message-ID: <20261117022542.863028-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117022542.863028-1-ynorov@nvidia.com>
References: <20261117022542.863028-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0015.namprd14.prod.outlook.com
 (2603:10b6:408:e3::20) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec76e1d-a420-4234-40cd-08df445217ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|18002099003|261009223027099003|22082099003|11063799006|56012099006|261028144727099003|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8tGS0wLiUn4TeX81L3WQa93phcZ0FNqpbPrOkWdtgFSxeqxuXJX+OQMkCWRl03wzxVj8JkN+1xg+qpE+2XOjsILSJe5kxjFOz0Dw+kONny9PBc9OMy1BqqcOLY/epEAN2t+CsnYyP4T5Lu3fV+3eZBL6z3NrJ7Sb8ZtLnT14ShZeKJfLZ5WH7Py2diR4qRKzJabvceugUiGEdjjunt2NOzKV3TTns6WUT7hNCpsG1ROjzrhWznFkVk39Ydhsz9EDCbwilZRP7HbxWsTexODRbbcDxCU4ZmQwvfr+qrDz43zp/2QXqT2ymI0ha2VVUH+MF0EHBP0A0yXHRWik2Q365nB8jeEy3ErTH2CBGXP00oZ9BDr/JexqwIaL04t3HPSbTr3C8Oaj1Mk7r++I1J8EPbFiRSdDdFtYliHit0N+DYovHvMqnh6fa/kvkeuwFEbK4p1KcypTh7rpZQfALqIPfoUOK5TMfZqqy97d3JccpQJYDT/Kn+00alflpmxHDCxIABH+NI/OTVV+H7d8EaNkvo6dwHG3xYeHZStvlJLZPhZZTOPIqzssu0ue1uf+zMHnG4Ra3RUdsqRfvecjxEc1kHegQ8nBFxJ7j8xFyaE2a+GoY/fJpP23XoAfwBKKS6Vth62OzLHG2uIYYVGRq7+w4tR93jFYfUgQUYwOdrdFFxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(18002099003)(261009223027099003)(22082099003)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pzPzHwmtssgL0vphULopKtPIhY/8N2UeMjzR9YhiiGpOHDuWaR0w8HJ1DgER?=
 =?us-ascii?Q?Z3nLK8LvM2OY9Zg7exa9DIvCz/ofLwTm+lGzuT1wqtaVByJR2OI6jXEmwjqy?=
 =?us-ascii?Q?KexdKMdmBLJB2cVOddf6LGzwTLwsuSrQV7a/DlrLms1h0P0L6FsI+3iYakzL?=
 =?us-ascii?Q?H3F04sV5/BSDFzNeODDUGY54mLrn8VoNRTFesQsWCzysMHMhHU1zvrIDY9BU?=
 =?us-ascii?Q?pnncTqmzBzYL5728f13sjqh7F0kjE+v37JYuzZ14HieDSi7rHQZW6C4RUe0Z?=
 =?us-ascii?Q?GSJT2K/VgAXNAkqtwTgmzeJziu5AJizyt5NFxNMLMjDowStncHPLk7w2c8c4?=
 =?us-ascii?Q?J8KNaqv5A30+5AgzWGSYjLgEGnyc7cu4rcW6Q2c9WYlVQ8dSvJsLyrge0skU?=
 =?us-ascii?Q?CtxqZJeuyCHeDUrC/6J9LFk48VF621uWu9f/O+3DwdO/0yFMWPs6F8KlQds7?=
 =?us-ascii?Q?L82sN8pO4R++ZSh5fNmlZV9kq/GNB02bofJzCYUC1uJrISOxCLGhL0cRMP35?=
 =?us-ascii?Q?bjfYjl+CxWbMe78hZdt56McgYgK18gsc7CKyTNAFwTJ35/s1wR21Hx9gYD6Z?=
 =?us-ascii?Q?aRCBgeo7x+WKnSsq5Iar+BqOyy6IrJr+2WCLfBTJ1DQTsT8NgGdSQmAe15gh?=
 =?us-ascii?Q?bGaSdqYfvqc/BQJLXjvsbVCZVcLL3aOkrxQCknzgMkdYGClN3OQy1IkK56NC?=
 =?us-ascii?Q?Q06LXyxMALa2z/mTbQTRciGMICJK3eashrvXn/Bkt+pt7VgSr+gLtftOqlR5?=
 =?us-ascii?Q?2Q4VHzahvqtBx/qs/lXRzdZh9hc3x3LNNafK7Rq87gYJ0E5e6DvSZ/di4eLA?=
 =?us-ascii?Q?3Ok3JUUFeeVUUwGdheP64x02h/aFzFrT+Idfr9leAlAB0hwZ27uY1GE28Tpk?=
 =?us-ascii?Q?uLqyBkpNhSVShKo/+n8qsd/mVfovfl9E9hpIEjuEPDVbkfi/SdbfdLMyioYl?=
 =?us-ascii?Q?ei9C370K1D0+MUzYI2wIT3uAcMLjsDjBbeUW1GFBXdw3l1oY+2bTQL2AYUFD?=
 =?us-ascii?Q?adKZm/pEwEqqva6bt0IbutcGhnVlFmpBPh0h8EZZzYGzWhAIRurSBaB16WFe?=
 =?us-ascii?Q?k0B4eyUzLN946gui7FA1NODVyAOSHTem4jjNwjTO7URwGDPwKP1p87cQwn/6?=
 =?us-ascii?Q?XRnu3ychFjzLOLzsYjUQDymRy72wl7FWwrcrPe1vW5+T8eVvvLbkvl+Ojwbb?=
 =?us-ascii?Q?+YinLK0CVDt/xoemhxlnaVg31q5Y9b5IS3gMl3qp9JtRz7iy781oEzVEiEGK?=
 =?us-ascii?Q?lielxO3b11jHm2d0jO3nMFSSSCRUNCSj3oTBKA/St4A4gx2VOTwfxwVmH0L9?=
 =?us-ascii?Q?2xWI7/Gqt4XF0wvBp2j4zeMDPizOsEH/+iwCRQ8wq2vqW0LUeScDUUE/zsMY?=
 =?us-ascii?Q?I6D+HjuEaP9anGIncjodtnJwOQTv1eLBBtxxhvM/k+8VEi02ovcG+Tz2o/Lu?=
 =?us-ascii?Q?UNK4Rn0SNQgIRqvJp6KwTpXkmNZnF7VH66/j0n3c9GJBmOm2mRhlfpY+gAG0?=
 =?us-ascii?Q?G6Jy9qLIIKlq2JsNTbxRgldiupIuLRaJY/65ce13EkMlJLdigkaBkyZCjFtp?=
 =?us-ascii?Q?jbriKz76clW3Uj7ErLrSeEot6zUs9Nr0JOAQZ0ABOttNvcuftFyBfVbBdJDW?=
 =?us-ascii?Q?jO034CcdEkduA5JWHrnlgS54C8gXf61UkNyP59yLb7wfSYOQCZD5Rp8H8Ol6?=
 =?us-ascii?Q?+hk+kVJGFc2T01Wq9ArtmZHBH/ZYO5xGbJHflYFYuXkErvJOisp7fSz1RMl1?=
 =?us-ascii?Q?Zz/4QBmqA1bvesk2fCuNHxntgnVHCYQeZ7/HL10IG2pN3icBgEKK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec76e1d-a420-4234-40cd-08df445217ce
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 02:25:49.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEHcSzA5EA/PF8BjlZTrAp3kr6ZOBOXNINF36DqRVP/XMpLzNLizrMau+hpXB028bmb/Sxzfpnn2cMSa39U5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

Scheduling on preferred subset of active CPUs is useful beyond the
paravirtualization scope.

For example, thermald can trim preferred list of CPUs as temperature
rises and restore them on cooling, allowing fair tasks to concentrate
on fewer CPUs without changing their affinity or taking CPUs offline.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 11 ++++-------
 kernel/Kconfig.preempt                             |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 3bf89c7c4b91..828c5173c3b4 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -821,13 +821,10 @@ What:		/sys/devices/system/cpu/preferred
 Date:		Sep 2026
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
-		(RO) the list of preferred CPUs applicable in
-		paravirtualized environments.
-
-		The steal governor driver dynamically adjusts this mask
-		based on observed steal time. Scheduling tasks on
-		CPUs outside of this list may lead to performance
-		degradations due to underlying physical CPU contention.
+		(RO) the list of CPUs preferred for fair tasks placement.
+		Fair tasks whose allowed CPUs contain no preferred CPU can
+		still run on active non-preferred CPUs. Other scheduling
+		classes are unaffected.
 
 		See Documentation/ABI/testing/sysfs-devices-system-cpu-preferred
 		and  Documentation/scheduler/sched-paravirt.rst for more details.
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 0cbc697202dd..9736c6e291d8 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -197,7 +197,7 @@ config SCHED_CLASS_EXT
 
 config PREFERRED_CPU
 	bool "Preferred CPU scheduling"
-	depends on SMP && HAVE_CPUTIME_STEAL
+	depends on SMP
 	help
 	  Hint the fair scheduler to favor a subset of active CPUs.
 	  Non-preferred CPUs remain online and can still run tasks
-- 
2.53.0

