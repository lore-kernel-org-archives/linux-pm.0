Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4153A2543;
	Fri, 17 Apr 2026 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413780; cv=fail; b=Hw/VxBOuIGtUPYQmSpMm/qpynO5YIctRj08WZY6tgC+WtOKbLYedbFoo1OLOULEjVxZt9itxrhWp3zwUan7Flpwm9fERPUU63+OhrTCf2u2wJ2f2ggx4JgkN/56hs/ctVolPirFAoHqZ2mF0P9tjQRv5IUEWSSvktU2GP51eSFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413780; c=relaxed/simple;
	bh=PIFglzm7lsm+YK7OGfTdUAV0XBG2iIRgbzUVCYC6lbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZfb+fBU4RyRB+w5C6RzefYJpakCA7glZyc6x0QMCrruSv16R3QBsD0i6KvD4FlJ/k0hnKcByzBBGirN9zWXLXU3/zbSReOzd2DOHb9atkG8j+cbIQy36f8HkoNnLTjq3zAvdIcYbwLQppE+SRIIoWL3KaVDbtitU/MosGHUjeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iWVUlRbh; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iWVUlRbh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4nP0SKF14J4nk0lj4PFuhDtzXj4YnEEXnKVLdBskEGw17IgjC74iknVMYE2WE+ww6KhQAYQ2yfK0E/Webo718YJwBf2DiiZi179c+DbsBaF3emu4QOLf1LSQSBEtAwOJnSFpMtyAWSvPn9LnJZ+e4ijOE3laKwyWnyux9JIqbYXFPMw5uWcTv5gpJsoQwyhU2ZdIzBmnyIIWvthKoLQ65A8fzvKp3USs3l7UU4XxuMYvumGB8mgHaTYDeMoKAx9lXL57soG6SRyBlfEV0zsp9YfTol2vGF7wSQkfCc3EZ/3gbMcNeShQ0dtgph0G++tSUDfy100fdXIiwONQsGRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIFglzm7lsm+YK7OGfTdUAV0XBG2iIRgbzUVCYC6lbM=;
 b=p6pf+Ivq4y9MSYgIZq88/GpuwoZoexWOrobFexTSpAC9jci69hHyY3+XzhCLo4I7V97428pIhkYo+QMYp8jHbe3FgojWjDq5nnLNRHFWHNitV51ROjKgDSXy271rhNghlNEfz8loye3UrOHWcrxAqycxvAuy0Y1VlgvtTAxGRT9oiNVkui8QJhqfhWJxAiMdPvokJFcEJupZimbur54XX00XtYuPE2tGAtgW3bDfZ4qKp2WN5iUqgU8SMORuT6zwI8KTl2E0iktV/Ttlc2qZBbg/6hfippU2G1nSTRAP04VL4ySJAKELfcTMd4ODlFwA1KdLifcBZsjgex06B8tvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIFglzm7lsm+YK7OGfTdUAV0XBG2iIRgbzUVCYC6lbM=;
 b=iWVUlRbhSVEajG34zcyleDZXNrOeGHhjAsQpRvtAI6QKqwxx9ieRmc412M+Rgf5eArvMTJI/7hDmKibM4FKYCbKI5mCbaYBRsJRQvMS2n23cQuMiCG2llLUKrpX5YaIIEIYG/VLD2qlUOLN64gMjthDS3jKZ51/6ymcGCuzWknws2GB3tl8+OaOVJhR4YWfYayU3rh8+oFarhuHQ+9F0vD93da/zu9fkvdc2wWW5pdA1bJvtMgkC4F13C9SFjJVPYfxAeged/OM2ZJYCU1J6wyjCsxOn7ageZqvoRgPu5bJ9+o+xdqb/QjnPMN0lT8ChpK8UIdzsi3oU2L3NTn7azw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB11524.eurprd04.prod.outlook.com (2603:10a6:150:288::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 08:16:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 08:16:12 +0000
Date: Fri, 17 Apr 2026 04:16:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] thermal/drivers/imx: Fix thermal zone leak on
 probe error path
Message-ID: <aeHsQ3_FUa3LzqKn@lizhi-Precision-Tower-5810>
References: <20260415-imx-v2-0-aeacff9e72b2@gmail.com>
 <20260415-imx-v2-1-aeacff9e72b2@gmail.com>
 <CAN4SLj3rH1q-jd6ccdo2qVNuNUoqfpsiS0KXJ3b=b7m_bh2QBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN4SLj3rH1q-jd6ccdo2qVNuNUoqfpsiS0KXJ3b=b7m_bh2QBw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB11524:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3379b2-d392-41ea-becf-08de9c599694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|19092799006|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	7mh6rMbErWg4CzA82LhZVXJfH1nFJtUdhAdeBmiFeASESMmTsQs8awugACmWKEy0v2mk2r2UToqPncfMJx2k1eUZz3rjSqbovutxY2t5WervSQSrWXM7qMNHnsrIuEAj0RHdu2zijpcHE06t4K5wGFb3mVcxakDZwxLx5HILfP24qLeUsU8A0DSIW9giqGn1BBW2d3SSKskFexIwzfen6bq8/ZNIPGwjbhuqlRyUnWOLIgxz2idPq4zRr28hdJ9WUOF0yOdyO0KaFpd/xaZtsySLjug2hHP27zzikN32lDI4KBuvgWjgGNHn81kgDyLafOk3zhbhRJke43pcFOd4xwGcy3SiXQ3sK2b4e8/fmxmvrJ7ybr5jISaCVCe1tBmnyqBInlfsrz2AQZZZ0KNao1X05qwUCwQqyE3yR622h6ZA2DNE8RGtyJQeSO9oltQlehfUOxs+Hu2csg5DWi5R2ePnTLAwxlHquM0fB3hmtWk5qGWSg001SrhtpwhIDTUUQ+RjeVoIbcRrMX9dCIa2Qj1gZlfuBNxzeIu3QziFhrO4JPnzUVEBjuRVixyj+NxhiITWJwZf1FbKBk09mS8gX579RX+veT4MThoblMbH2UD6okPG5WVFRIuTHz9/JG6xcsdorz+d9Vu75k5Ak6Giglsp9l5DRaokWXaqlAr8xSu20YQxT+nHh9+FwPJgVYPX3fy50s8S+ObZtYDEGLEP454fB8fXj1Fh0qiB4OpI0Ya+8Yc5tcZ+/cKCd9O0cHY9jdkZ8rX/KwrpgOuU3n0aARRt7jwh6PNSF0XQKr48ZiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(19092799006)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmpvWGtNMGlMNHducWlER3U5d0N0Q1ZLRzYvMldUOEllT2xVdTcwQnVxRDlx?=
 =?utf-8?B?UnpMMU9MQUY4OTIyaVVSNjdCL0trUFpUT3kyakZ2Y2xWS3dkQzZDNlF2a0Vn?=
 =?utf-8?B?MnlXdkVhK2hVVlh4TStVaTlLUnN4UWlqS3pSSCtmbHEwekNJMVpHbUFXTita?=
 =?utf-8?B?TnN2eDZDSVpBeks0enB1aFVvb2k2ZndPYmJWWGhJVFpZcFdQNE9lQnI0Mkpz?=
 =?utf-8?B?ZlhteWhsYy9heklnaUtQOGFDTnFoSkVPZkg1cGo5ckk3UWVkZ0J6VGEreFh4?=
 =?utf-8?B?THlBcmpweXJ5Z0QwaVZKUmdvWGFXRWFPNTZXOUVZWWYzMTNaOW51UGhCeUdS?=
 =?utf-8?B?VmJpR0svTDlYbnBqT2pINmVkKzJ5QVVmV2c4NVM3Nm8xWVBkSEdXMG1BVFJ0?=
 =?utf-8?B?UFFVY21PTy9HVU9Sb2U3UUN4NDZRQ2lNM09Ga0Jma2phSENVbjNVT2M5NGpN?=
 =?utf-8?B?QlpNb2FKbXd3UU5PdytlQVFIbjA3a3lqU0Z4eWhsR0Z1VUlqZmxDdmRxalhF?=
 =?utf-8?B?V3JPMlpYSHAzY1ZIa290dlJza1AwWjZSNEZDQ2ZmNkYrbTZPK2sycTRWTVNC?=
 =?utf-8?B?VnR0RkJna3NlTHN1ZnA0aENzeHNjOUZLK3pZUTFJcVp4Q1NjRnhjZ3kyVndP?=
 =?utf-8?B?UW5ERGRRZU1kTUUwY09JMU9pMFZPa2puNzBDNFQ5K3dCZDR4WkZ4ZWZscUZn?=
 =?utf-8?B?ZFpIU1FPN1FTaVJJYk5VRWw5cmlvc1I3dEwrcTNTSkZHcGhiR25WMHVpeWxC?=
 =?utf-8?B?WFZlVHF2cEtiNVNWeVJKWGppRUdheVl2MjRtT2NkUEg4NG0wK3RwMVBrMHNt?=
 =?utf-8?B?UTFoVTBPUEhrdHo4UjZManY0NHpBUG52WVdMdEUrRkgva3BwNXVXeWRqcUx6?=
 =?utf-8?B?SCtEVGY5VXFJVmM2QjhzN0lDM0g4MnJ1UkgzaWpSaVZFZUkzb3liV3FBYnh2?=
 =?utf-8?B?dytTVGtseTFZM3YvSnU5MXZiRzhTdzFUdTArSGNQNS9hUDFTcHhSVW1zbWhl?=
 =?utf-8?B?MVA5RVdpSkxQcXpRVFBPUW5iZHB5Nmx5MDVxWnhxb3pwbTBoTStWNWtVTVhL?=
 =?utf-8?B?bjlnUGtVNGh0aDUySU9NYk1rN3NCQkN5aDJ6cVJKTFQyNHpKdjFYQVJod3Az?=
 =?utf-8?B?T20xUEtjNlRSL0hOTkV3SE9weVdCS2Z4M1hDL3VmSDNUVDR4OGYvM3RDZXJl?=
 =?utf-8?B?VzVHZnhJYUVXNS9ldWlHRUdiZGN2TFNUZEg1TjRVZGRKK25xdFJRMU1JN2o2?=
 =?utf-8?B?ZW4xQVMrWTd1Q3FTNldrK0J5SFBmc01lTGRJeVJXVit6TTJzQ1JST3hpZHRJ?=
 =?utf-8?B?UlVuWVFpNHNpYXZJMXcvQVUzbFliTUx2QWVrd3lWRWZUS3VsaVo3Y09ZeWVx?=
 =?utf-8?B?dTdVZzJ0ZU8rQ3FqWjF5cDc4cmluVFM5YlBqQzJrS0szb1NlUURuSUNxTVNY?=
 =?utf-8?B?cktMVUk0c1hGbUJobmJ3MG5RZGtwNXVLSDZVSjRGWGd0UHFJMGt6UFoxU0xq?=
 =?utf-8?B?a09uOHZsOGFGbGhSZ1hsR0lJU1ZDVTZDWHMxdkJJTFMvNHhWaWgyeWpVUVYw?=
 =?utf-8?B?bWtkYk0xdCs2YXF2cEdlQ09IOXQ2LzdOY2hnZGdmMDIvYzRteFY3STJrelZr?=
 =?utf-8?B?c0NQSEY4T1k1c1FrV2tpdm1PS25hR2xqalVTTTBISlBLemNWTVB3TWJ5VDVi?=
 =?utf-8?B?V0ZwWE9oMWkzMnpqODE2KytvSmdHc3NXVjh1SEQ3cmk1cmdsdkxDU0xLT2xE?=
 =?utf-8?B?UjB5SDZWdkdKUjJ4Nngzcnd6R09RZjBBVUJ3SWtrUkFSMUZQVjRBMm45Sjgz?=
 =?utf-8?B?V2FabzUyZFdvRXh3ZkRSK2JiNENUbUZKbEhmZkY4UnZIbmdVNldoT2ZYNjRz?=
 =?utf-8?B?Nm9zRGl5WXcwZGdrU2RRMlBhblZJSUgyMmxyYmtqQ1hBY01BWm9kVkVDSHhO?=
 =?utf-8?B?QVZkdUNLOEVBZ0lFOWx3dWJtNzljc1RreU1aZXJXZzV0TUkzR2FONWxhNHhL?=
 =?utf-8?B?YVo2N0xHTWFaTXFSTzZ0VkdnV0JmTDNSQVNQMHFDd290anNvR2g2cnpqbGF4?=
 =?utf-8?B?aVg4R0xTSWo4b3Z5TGN0VjdsWnduUlYwMGk3WFEvMHg0dCtQTExuUndNU2lt?=
 =?utf-8?B?NUpuK2s2T3lkakNWWHB6dGlFNWZVY0dEaVB3amhXYXJ2N3RKYjBVY21wQllp?=
 =?utf-8?B?QU5OWnUvUm5oSFA0U0Vka0VuaWdINWFqTEhXMjhBN2Y3eW5XcERSbjRCZisv?=
 =?utf-8?B?SUNxWExkbVNEamtoNUl4UW9tbldEL2g5SkI2N0dGMnE2c012SlJ1ZklZWFdu?=
 =?utf-8?Q?r/vmU9KFbcrVt7Qg9t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3379b2-d392-41ea-becf-08de9c599694
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 08:16:12.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEtxBeSHRU+pa3dn/IjZEwdqSfuTtnfzHUs8J7keM6N4zHbDK8pvZCyi1zZRNRrCMlmqPqG4ffjyEZNgXFp2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11524

On Thu, Apr 16, 2026 at 09:04:38PM +0800, Felix Gu wrote:
> On Wed, Apr 15, 2026 at 9:10 PM Felix Gu <ustc.gu@gmail.com> wrote:

...
> > 2.43.0
> >
>
> Hi all,
> This patch has a problem, I will fix it and send v3.

Next time trim context to let reviewer see important information before
scoll down email.

Frank

>
> Best regards,
> Felix
