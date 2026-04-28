Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012074.outbound.protection.outlook.com [52.103.11.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716FB391E7E;
	Tue, 28 Apr 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384954; cv=fail; b=DLrdDMpq18mNLXZ0pfUC0tdy0t8t9vedTGQAP7/IXahVMqC0+mPOZ/rkS6kTOAdSQc8NYHHYFYa5LSERReNEJDp3XtzPXSzv4kHRP95fAAxQZVq1tfLAJ3ZElAVRq9+S9fIJRCZwL/wvnwfq4v3/qhM44sZDXpw2L2PjVrKXx8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384954; c=relaxed/simple;
	bh=2KZfDSB9E5wCTkxAEct1WOzLlb0zfbZz+Ai9ALJzQ2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JE2yH+KyPP8vvKYkmO2wFaSC930g5lb7c+8/n+HCbDbZfMq1PpYPfdHfxKhnfCu2eUwPmQLw3Zqv86/LVwbo0UNgUjb6OUHZVO+j3a8MUbV3xYXNys2kIw1LBWlfdzrD1p3Nu9J3asHGgokUIws90TgL+u/uY9TcgsfCW07xL8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=BFV5VmbR; arc=fail smtp.client-ip=52.103.11.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="BFV5VmbR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi4Q/JTAl7osfomFXdIJexuqi922RSNYnbhrgw3cE8/w/mMZiSOjWlbCVMHQRMnpDPg0dDYH4AaB2ERDnfiDz7dgJi3NeDBo4MtaOcT0lRlfwkz3+i5zEubVtmDN2TfACc6Q8VoF4D0JqS3QwVlxYp7ay5hQD0BZPmnbu+S2f58ar2KZ1YF1RAcM2KUIg+sXnuuWzxS3lvYHbnxnv4x1djZuEXLntbtilRdtiGAPCZd0dBG4nVagAJxGwp8W4D1pQrVrhGnQYiqFz+OIoQakz1BOZU8GhaZn5gIig5rAx4Su/o6n5X4jC6n0ADtgc0kvHZZIC6q5W88P8ztOPrJ9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvgOSwnpHpQMziZqPwCFco8ggE4sUL2s2Kol5x78wOY=;
 b=OGqGBDXcOFfKNkO0DbKPBbjcuqB63rUp4e1jo6ZLIEXYEoANaz4hxdXduS0B+eZ5RAsZp15/+JfkdA2KuW9NKcvqfvV9phOlfUlwqm5O8qCgqAuib/9EWhv1ds/hzM2LNk2IxMt/iFG6StQe88a+wnZQy7qyq/fHwucfdYFmxZu7CIyIHd7eH26lDQ1jelqpDb110aOOf1w83dycUNZJ0h/bfhF7S/OUF5gX/v/qSb9wRjPvV96rIoGw0AEzRUvBhGLBMoPirC+oo4nc+LS3x4qxItI6WYmQ1FHnNC0zyp2P8gD+VrkVNbZd9D0mM+LtTjmkjVXMOpHeln3mbHpJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvgOSwnpHpQMziZqPwCFco8ggE4sUL2s2Kol5x78wOY=;
 b=BFV5VmbRy1K4UAXzTrbBDA/QmSiHnsobKW4xuTZo48qFUhMFoYW5mXslGWkIHSQ4OPt35gJgbiK2V0oMar5CiB9fOHf+H2xxGQi7M5lmPEBUt1vTo8W6SnrxR5akTZu4hkNNvU3ekri5utgs0I6H2MgMNKUTPMb6hjvBLxVHOVUQezmiR5Gqc1xJbJo+yuo1pTt7QW0nQNE7ASRLE0TMjynUHrI1CRARHhTHB5257jb4tKQsusL3YJhn7CXfPx7FYKLixE3d8E2bVb/UVYDyTDX0LmneoYwRlMRIwuty4sRcWzBeyBPLSMgQnxBLSbYZNyGY4DZahaYWNYdx4fMLHg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DS1PR19MB997375.namprd19.prod.outlook.com
 (2603:10b6:8:495::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.27; Tue, 28 Apr
 2026 14:02:30 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 14:02:30 +0000
Date: Tue, 28 Apr 2026 09:02:26 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>,
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	xsf@rock-chips.com, sre@kernel.org, simona@ffwll.ch,
	airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com,
	neil.armstrong@linaro.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: arm: rockchip: Add Anbernic RG Vita-Pro
Message-ID:
 <PH0PR19MB997338E281101ABB457FF8D655A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-6-macroalpha82@gmail.com>
 <20260428-vigilant-grebe-of-tempering-0b5e14@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-vigilant-grebe-of-tempering-0b5e14@quoll>
X-ClientProxiedBy: DS7PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::30) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <afC98jaSd_VWsgyH@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DS1PR19MB997375:EE_
X-MS-Office365-Filtering-Correlation-Id: 364628a6-f569-4eb6-fc14-08dea52ec9c3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|24021099003|37011999003|25031999004|6090799003|15080799012|5072599009|19110799012|8060799015|23021999003|461199028|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/vfC1WGWPZehI/J88HbiPdOzj6v7ZUHqXhKcyUJFOkzCHevwIdH9kSaZW8Jk?=
 =?us-ascii?Q?wohL3oiYjJzYnaV9JR8KgT2UmSVKy1hrKJHGvWZYkeZdC1EbTHED0AoYJDrq?=
 =?us-ascii?Q?n+Gpm7lllyIA/oF6jxd5PyG92y8YUTbODBoq869P7JZ/tRl5M43sOfNedKMh?=
 =?us-ascii?Q?BEMVl7YOFMje+yEjoNb7YXG91LmfKjD4jwFaGn+CU4q1BMEC9QUeEYInnjai?=
 =?us-ascii?Q?GP+5mKmrPqtb3yAKRJgBnyvK20MyAwZavIHIMByovUvCwvgM/p3nPrtO9ZFK?=
 =?us-ascii?Q?J6iAz939Ecj/+Bk3aeB2O/UjX0dsVBIDGFrG4LZClnlxTDl/MoqonAq/ZbjW?=
 =?us-ascii?Q?HwdifmKPYBJo/fu8/TtdYbSMsFoqWTnQkt1H5Z1FQFAcz/zz+1zeiFd8HFqA?=
 =?us-ascii?Q?rUgi4pI3W7s9tWmBkfHYVpRCsb84+Q3+fbDkMuABgM+2W/B1IjvYhIcdX9rh?=
 =?us-ascii?Q?3qBWqbn0egUT68Z/J4VDk9IPQkI0Ox6yZ8dndmwZwJfXyJLTAMXtJ5wpGZM4?=
 =?us-ascii?Q?SbAQcqejnppuPt3XN/yj3HXfwKM5/kDYFPdErmuUeKv9b4Xh3cRs2OYSYRYl?=
 =?us-ascii?Q?iFW6tDTR05k6k83qwDLgwXBpeZiM0+qvA92WliaQ2TIaQQlfW5S3emleetPu?=
 =?us-ascii?Q?XNFf3fd8tS8kRKXAfp36in2d4L8B7qn4KkYnrbgWj3DLqgWCuAv2YE1+csJz?=
 =?us-ascii?Q?nJfCxDV0FxLWc3OFFjJMBqkUXJdXEV80+YH8sZEg9RN0yQycCMbNMD4vmrlj?=
 =?us-ascii?Q?eEWhrmi1oOkgOn47Q4GSr01heuBZSqaEK/8iXG6M5ZzebJJHRMLa1nrdps8p?=
 =?us-ascii?Q?UxfZWUD8RyPgWcjGq1KLN/2EMZJsXKx6GbXDD5SjJBi475caT/GbtZvJO9b+?=
 =?us-ascii?Q?9H3bS71QfnXLIw4GWLgvjD0bBpNWaH7F41VgQmh96kcsMXCMyYtm7Z5s7eRv?=
 =?us-ascii?Q?2dnRASZ8OfFjz2IdaAc3nEmRgopXPVWX4RB9keRCDDPIbyrVK9AyTtXQc5rc?=
 =?us-ascii?Q?23Zdct5XYrHt3nIR3toqBKZOUC2P2/gCgqyQELG/WaLPHNg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tgh5D1Q6FGgCgwTohL0A9+yHxjZ5OSioimdcCb0hyr6UVpTbKrREZ4i7pEx6?=
 =?us-ascii?Q?mwPPatUp/uIx8d4lSL7mr4jZBuL2M0Z7dma99daeN4fcjtaBMSg4ModbMiBH?=
 =?us-ascii?Q?BkU66LmJMZN9ysaGUn0OG7q7XWyZOlTtkPnVUnfHGIjXB+LL/cYygL9LDpUr?=
 =?us-ascii?Q?fpBvMsvBPFCp5JP9+lKxqFG3mR04hLUyLN+5ZZ3sc6H8fYSRa5IZ8EHAzgic?=
 =?us-ascii?Q?E8udRcZkHPww50X3XC4XFJVJmWOYRcKvN9Qg991ry/rJc+j0/51RLTgHzZJI?=
 =?us-ascii?Q?xmjB2FTp33xM1BfJINGz3HinEAYFFXlzRRiKFVgYG81+0odhdVg7J3PB1agU?=
 =?us-ascii?Q?4kjrrZ/U5UQRCAeYQK0Jq7GTwPi0Hzxi5ZnTTlnasIKi1+bVojSyzTt146UI?=
 =?us-ascii?Q?o2YmUQrZ2Rp4LGsq2OTnBXbIbwpAeSlMiIKuv6LLFfPPEi6aJZmooLHedZtE?=
 =?us-ascii?Q?P9EPvWKpDBvEB70sSWrpMRPTvjnyhGOZBmFu0pKYbEd7/yPq30Y2UOrh6lVV?=
 =?us-ascii?Q?/ep8FeE6h8Wy3R2Q4O2a0AI+TUYtAxW62/giYoXmpkoiHRM1d1xBmy8Wt38A?=
 =?us-ascii?Q?Jem4LE05bMLXrVg5yWgogjlrG94x6ozR4DI512JSLgj6gQqZrcTQTmfiUobt?=
 =?us-ascii?Q?LyszHEDcK26qv/7JdfMPlbr/3m+J/zkttdw4R7np+jjWCeQHJ1sq4G0nXveu?=
 =?us-ascii?Q?koDV2qL7LoNeeDPD+7xW37nIhTmpI+x8H+qDSlrK72ClMh9LC/du3ozTpBkY?=
 =?us-ascii?Q?53GjlBc5hmg64KI4N0Ie1dQkNpTaOCenYi9jovTCvsK4Chm9aH6do4e1fZLy?=
 =?us-ascii?Q?VJrzzBvkRDtSRwxDuEyADJkafuy1KOQMRATJyveZ6B60W/1Mr3qQXf2Xm49o?=
 =?us-ascii?Q?oJyqd1fEBwuSNIPWaISz6tODmachzp0BbGAlyzOw4GSNFV/nr8ylwIPcVL2T?=
 =?us-ascii?Q?844s+WFggc5khRDM+gvVXYtkWl7gcEhoOsHWA4Q0XgWtq1xWoebljqI1dbY9?=
 =?us-ascii?Q?oWJSWdBLfKKOU6q53RzxxFLtWRbUckdhHD0Nk+q9DBxrXCWwA1GcZ0H3scRT?=
 =?us-ascii?Q?gORnXxCWQ/ifv/jYdmAG43T/I00h9IT/1xuIiiOlzXzidUZ6Ssg1Co0Wj+/K?=
 =?us-ascii?Q?rBiwpO6k6MwVfeiDqtmrg2YMdbwdtseRove28KvddxchCuyiq/WO8SdqxLj9?=
 =?us-ascii?Q?/IEFAGqmXvelj995VApLvpK+XGxYmOs5buPfxMxOE9uikjEqH5GxhXq+QgxO?=
 =?us-ascii?Q?WLXOOnwaE9TWdjRX3dr/QAEFeUj9XY30NuHKnVtzejcm1yfzXeVa1AdUpf3O?=
 =?us-ascii?Q?KSjPPB2sDntS6VjfnOgozTesq3UDdrVATKjBKiJIAeSMWijlTr6QtO1CJvFG?=
 =?us-ascii?Q?abqu1LCbL19WnnMAhnAXf219oxapx2hMkgTYHy7eIfJtlTZy+A=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 364628a6-f569-4eb6-fc14-08dea52ec9c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:02:30.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR19MB997375

On Tue, Apr 28, 2026 at 09:48:14AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Apr 27, 2026 at 12:09:13PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add compatible string for the Anbernic RG Vita-Pro.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> 
> You combined three completely independent subsystems into one patchset.
> Usually that's unnecessary burden on our mailboxes and instead of simple
> shazam of entire patchset maintainers need to pick up individual bits.

I'm sorry about that, I will only submit to the maintainers for the next
revision along with the Rockchip mailing list. Thank you.

Chris

> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof
> 
