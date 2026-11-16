Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794842727;
	b=HcdnSQY5AdqEo0br9zBHYOaRBR7lHwnBHHhIWoEPhRejgdZaQaL1SytMiSLuPbWYTgag
	 lAmj7t01kVoEa4Ri1e7vq7NI6S8iVmg8Oo+o24fx+0aUl7kO3mdE5+C76oXTcgeL3zukT
	 LOe7IKg3xuxpOAaSU4RcmiG6VqcBM3nr0qLQfCXcDf3fOUUSLi2JWTk3r7LH3aZPAC0ob
	 VdHiwwUHsJUhOc5Ocx5Zbalm6PZBqPubzIc5oQY7xeaniokAx2rPZ0cCrT0S2cOl6ogA0
	 AbBMnE3rkwW8Rpx6nCdaqqSFtRIwT4ljmN9M5muMa768eqbORnvHanJlep+fcYr3O1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842727;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kwU0aqAfTOVb09U8gKdoBVAG+8nbfQGFHmI2srC8srU=;
	b=0QPAyrUT0g/1dKys1/o40bgVYYug1rOF2Jfji4IBDvWZMBRgumglw0FEwsmkA9Mi4Ypg
	 yXO/1YkqrCyS0FQd/XSSZrAuWkK/OZmpJxngCrALlsMCi5eN/D0gAthSmijiw9LQHExUj
	 lJwiuXqpJVtN8yO62JirsIxVuRqB/OhspVKt+0yHixEEqwEpIZqyp5UGSvynPkU5CCgCC
	 BklUuPWn5PeQ4G/JrnaLNAmk44nRZae7J+TksonEdyt9wSTpL+C6Bhgs8AMihUfbh4EV8
	 DjKrutGLf/lyqW91aHw6dMcZOyfrekBkon6e3+1DeJIYS5KTgUkqfScHMhceyI7Nf9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kyQBwJEV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.8
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F9606A338;
	Mon, 16 Nov 2026 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D50F9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kyQBwJEV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3R9oshvYFZPDrPduCwrtF2mf9HZ71pIkecFZDfWqXJY+S3lC4qFOyxD6WjCWegxCtlXLpH9wVDv7tefSMiseu1kYud9QotU2QtHnrLZJ/ygnPPs6A57t88kSprGwUkQ2dB8IpLoD1N38KqF/M4x+EmtAjd/iskvSVlwpM2RhFjt8062Q+9wlIYm0uMF4wY4gU3dWfTWdZ6L4ZYPvZ9CFjFnLlXCBMXj2cehKq/LQjMz6b+NIaED8a4DG6o9JfR8/y2zk5HcGQJTzJWZ45lvH5ztk1cHszk593OOe6jvtF/C/9oi0YhfugPTCLq6aM6kFMKfbLWSHQmXalfc8dMmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwU0aqAfTOVb09U8gKdoBVAG+8nbfQGFHmI2srC8srU=;
 b=H2m6YXooq56e7YRPyIwMiwvqAU7SZ06xm+J3jTqoG8NqVofgEV20PqcjOzjXQTPVOzz5AZqdVd01MflRa/rPsD1AO6vXKXOq996r5DWRCSgehu/58YnAca5WBMaCZSEvyMZVpNKn2rFV12fr53NWtsBadnn+CKso6zc6GO1F1pFzPeZ6PxWBWSM0oCKY2zP9Qez7u3mb9IX56M1WQWPffoewyfQhqDMAVurLi4pCM6lIduQcD/MV9WC3NSb0iNcnmmdLU85jUMNLWYDG8EgwNVRVJkAd9G7pZWhr5Ol+j+GEAOWxZ3tU/EHXNEhcMPX5mKv/qAV6LenvrTaCFo/DQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwU0aqAfTOVb09U8gKdoBVAG+8nbfQGFHmI2srC8srU=;
 b=kyQBwJEVUZgO0EPw99NbJvjoBp3KT2Gpg7NsZ1bkFUKBzj4z2KMEPb0u4jqu+U2Maa3Z2SUHD+IQqKYc8A6+GGlYnN0eQUbPp7wSXN7ztSRkY4NUKTSVxwoi76Vf42rgUC4l655pS0dhFkuYFxJ24oqSuD7tlDSCCRu4Y/IcCIVSoccNpN/T4Us/py3dZZoITMCfuyb4que8dS/gcTxdXd36C7bJb1lDnR8hEjiwYad2BaMlLMkdJ5P8wtCly8Dhfi7cZzcaLimNLryvEZdKP2RYrn7d0G2HhldiSQQQe7323CKD3xuNqpVbUuMNxtyFS9azSCk6CwEGhpPWZA3iUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU7PR04MB11161.eurprd04.prod.outlook.com (2603:10a6:10:5b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:25:22 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:25:22 +0000
From: Frank.Li@oss.nxp.com
To:
Cc: Frank Li <Frank.Li@nxp.com>,
	Alex Elder <elder@riscstar.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	"Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Elder <elder@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel" <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guan-Yu Lin <guanyulin@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 1/2] PM: runtime: fix stub pm_runtime_get_if_active() for !CONFIG_PM
Date: Mon, 16 Nov 2026 10:25:10 -0500
Message-ID: <20261116152513.2676573-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU7PR04MB11161:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e94d89-9953-4c08-4f4e-08df43f5d4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|366016|376014|23010399003|1800799024|18002099003|6133799003|11063799006|56012099006|10067099003|261022075727099003|261022105027099003|261028144727099003|261026121527099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003|261009223327099003|261009221227099003|261009220027099003|261102123227099003|261009221727099003;
X-Microsoft-Antispam-Message-Info:
	kiz/bkm1v3jdulKiQWNUyJNwErxxuNx2eVWey0BIKtzfA2g5TuGrOJc0aNesYkW/z2K0P81/euDeDl0CMXEzYfENpZkSYfhL+WQoweGNvsm+NWsgwZqdfEQl6QkiNxd1u28yYb45sCCmjesSQHnqwfmHNKiuH0cd52Yq1zg6wh1OMXl6pGfWb7ykBsVHPWfLrOb6H2YHpFY8HSskTQyQgjhCzDNti+XV48LSSNljSBbxSTWVHH6HTeKYYSqF1a4eIsDsH2q5fmq8sO8xku8fKxyjV+GkxqdsfkzT8cNOOg5esY8r0xBZIWaNVdaY2oGlHUTZFxC9b7eVxP0gtUSsASmuTXa00M9zb4LnAthR8K6ZPKs8nZF3J1D6fmoDzJLS8rntVRVHUdwyoECqQlkxyXgmJ65oLhIhi6C3/WvauOXFVIHQLnDh4VMK5b2NslfvIE3eSqqVdZBRTwNau65ZHnTWpDLlT01FyjpmxH1lfmKd7iHr9oVnWJDye0tKZkT47pczFVyjuaIfDJepknCm/+50FOAf9Y22I7XAdNTAR8R2rPl4/LWn5lVNOi7SlcW3BNYEfnX/6tDkU7a2HcqAfMm1lzvenXyBqIePBHoSzg0MT1j2PR8GkgI17PichB6uEGHZmJo5n7jG+3BG/1qxe2+tCwV4aicvzkRoNC/OYcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(376014)(23010399003)(1800799024)(18002099003)(6133799003)(11063799006)(56012099006)(10067099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009220027099003)(261102123227099003)(261009221727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jjsXZKNgmbHP6THel3p6tv7fU6QECNyoCn6OPDoZdn06gAkTkbZGFIF/nVB3?=
 =?us-ascii?Q?MxueDqZePQ+GLQOIReLcN8T73fshjhDGuBoZh//36tajDhEgGCzzkEel7A+p?=
 =?us-ascii?Q?Bt10SKtbUFwvI+twGCcyB/vDUKaLqoivQU7Xjj4oMA01Tr2gmKIFWOYQLJUF?=
 =?us-ascii?Q?Go4LWEc14xikn4ucaCN+ovkarlZuEwiSVsvZqCfO5PxlMd5Y/QZjY44bRxrw?=
 =?us-ascii?Q?JTqJyNU1Isd6UshhFLigtDtJUgpUinzmz096COr9wJKucWvRrDvLP/frNhZd?=
 =?us-ascii?Q?Pms9PoHjeS9x/oK+vGjEvRpVZt0Z4iGpkHmdlAh0HlRJRNQrtcXmFBjbcdzP?=
 =?us-ascii?Q?qvU0uWWRdANCfS22s8c07/ytR6iWHXkXGK4B/uSI4RhbjIcbclQWeSkROW7q?=
 =?us-ascii?Q?N0dzlBha6Soq5tFpAHZX+CGntbSz9gf7N6MzUrP3csqzXn04J9a3GuiD5ihS?=
 =?us-ascii?Q?78JKkP/DfsLB+l1Ai32FckrFfvVOB5VF3eqQbOfx5ZJZrehCv3fIUFYkLVUT?=
 =?us-ascii?Q?Q1yGA76aFpUaIkopiu4Z3kdpWse7cXvU9gZ+C8oagcxp36pL9oUpQV/CStxq?=
 =?us-ascii?Q?04UdlTES35iqy4pxoIAoIWkkehbt1w+QAAsor8rr8TfBqrg1i2qMwKc+LcYn?=
 =?us-ascii?Q?1XepXumUPd++Kh9t9Mdwj9pJtRzvJHw/YiJoF5Sfs7XxW654laf24Uv3QtZ6?=
 =?us-ascii?Q?mBw9bCmbOTTpgbE8N7qNl5xeWRiZ7tIod6Djn9kF+SF6lGjLIWrnPrPfJk5X?=
 =?us-ascii?Q?jOGH8RciVDVFWfMBx/FnyO0L2G8xKWzbG1Jst6UMV3lU9TE6Qiawxj5KBGp8?=
 =?us-ascii?Q?cpjd7A1ab1mgzSxQ6Jr6NYv5j9cgiQjG7KYTXCQPMMs4v4dKQhiWxtiMH/dD?=
 =?us-ascii?Q?iy75LEVHkC5wliTwcRIST1M3Ossy8rjEArne0IQ9dh/iWEdXrOrvPXGb2BuX?=
 =?us-ascii?Q?qOga0f2ZhbP5wvo8qkqdk/4h4cYEffCsOEtzAJ03dHWHIcD8k75nIVxblYNo?=
 =?us-ascii?Q?m9LaxodBXkbXRCt/r3aLdBBk2I4O3mLaY6uBNuAzEfca8Zm0QVdcWw9yhFdO?=
 =?us-ascii?Q?IW0axWzIygqgAWefwAnw8qz6wQ3BDO6ENLAds7CJcWNSixwTCfH8Ys+wcnBB?=
 =?us-ascii?Q?KxSYK9p9xvurRheAbJeOIreqqIfdexb8rIi1/Lv1FACqgyHpdehMOvflQuWY?=
 =?us-ascii?Q?UE4nuqeW1BLW8GK29WDOHq4qyqwDNdJmaVsnx7RDOEY2NwrTGgiqx5dM9e9q?=
 =?us-ascii?Q?/kN1yKFE57lM5XjuGcFfg6zD9+lXBaAK3yHAuLrk1urE/Rw2/CZA66YUkCPD?=
 =?us-ascii?Q?5YYv4/adfeHPW7Bo7yxdqkHClDLihrx6AkjmOwKrPcF4M/H3koj4pqGRaiBv?=
 =?us-ascii?Q?Ny+K5E/WPR96NW7+eSZIoEJa2LJSyOzmhDrT1XUsmiz7P+LQiAsOlhzP86UF?=
 =?us-ascii?Q?LkQv66VaMQmRVq0/zdLkCRxW+pCvqVvwykaAsvfvnP5tyN/hl29VEiwcCOTr?=
 =?us-ascii?Q?u6DERBybMWVRecCjuxwdvc4HuIqACdeAoVvC+40kD0tBoqt6denC+o4TcRNf?=
 =?us-ascii?Q?tlJMLbOuGmaCzWRl9fGWm4EFb4tKM/u/s1xKhlgX+LH5zKtMBJ/2YIwCOiyP?=
 =?us-ascii?Q?HX8DdXBJ3MH8C6DhxnBs+lSCMte9aW+8X17cvoOWTKBHmbsGACx0vFBisfoW?=
 =?us-ascii?Q?EbC+9ch/T5ijSfbZ/fgoYXgZJa4qQOJRQsqWND8V/IAQGelYFrsX5HouQJiz?=
 =?us-ascii?Q?WHkpW34wLYAzDHAXk8kP3Mvn0CdgjxU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e94d89-9953-4c08-4f4e-08df43f5d4bd
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:25:22.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHBCqLzXO7YQGxkxz3HqKE+328TOvnt2XmPv9gZq0bs/gPBtsNe5U0uXHwjE4X/CNcRBHZi78qqihf23AUTM0f4jkeE14AeF+W9uXFWtlZ0hDstg+Hb1+ENfOauEc3Cv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11161

From: Frank Li <Frank.Li@nxp.com>

When CONFIG_PM is not enabled, should be treated as if runtime PM were
enabled for the device and the runtime status is active.

It's a subtle distinction but the previous behavior returned -EINVAL, which
means "runtime PM is disabled for the device"

__pm_runtime_resume() returns 1 (called by pm_runtime_get()).
pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
should return the same value as the stub pm_runtime_get(), which is 1.

Analysis of all callers and their behavior with old (-EINVAL) vs new (1):

Pattern A: if (!pm_runtime_get_if_active(dev)) -- no impact
  Both -EINVAL and 1 are non-zero, so !ret is false in both cases.
  Callers: drivers/accel/ethosu/ethosu_perfmon.c,
           drivers/gpu/drm/msm/adreno/a6xx_gmu.c,
           drivers/gpu/drm/msm/msm_perfcntr.c,
           drivers/gpu/drm/v3d/v3d_mmu.c,
           drivers/gpu/drm/v3d/v3d_perfmon.c (x4),
           drivers/media/i2c/gc08a3.c gc05a2.c og0ve1b.c ov6211.c,
           drivers/media/i2c/ccs/ccs-core.c s5kjn1.c lm3560.c (x2),
           drivers/media/i2c/s5k3m5.c thp7312.c imx283.c ov64a40.c,
           drivers/media/pci/intel/ipu6/ipu6-buttress.c,
           sound/hda/core/device.c

Pattern B: if (!ret) after get -- no impact
  Both -EINVAL and 1 are non-zero, !ret is false in both cases.
  drivers/gpu/drm/amd/pm/amdgpu_pm.c (comment says "allow access"
    in kernels without CONFIG_PM), drivers/pci/pci.c

Pattern C: ret > 0 / ret <= 0 / ret != 1 checks -- FIXED
  drivers/usb/core/offload.c: checks (!= 1), old -EINVAL caused
    -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
  drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<= 0), old -EINVAL
    spuriously triggered WARN. Fixed: 1 > 0, no warn.
  drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<= 0), old
    -EINVAL triggered error path. Fixed: 1 > 0, correct path.
  drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
    Fixed: proceeds correctly without CONFIG_PM.
  drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
    (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
    xe_pxp.c) now correctly treat !CONFIG_PM as active.
  drivers/net/ipa/ipa_smp2p.c: power_on = (> 0), now correctly true.
  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
    executes stall register update.
  drivers/staging/media/ipu7/ipu7-buttress.c: active (<= 0) early
    return now skipped, correctly proceeds.

Pattern D: explicit -EINVAL check
  drivers/hwmon/prom21-xhci.c: checks (> 0) then (== -EINVAL).
    Old: took -EINVAL fallback. New: takes (> 0) fast path.
    Both succeed when CONFIG_PM is disabled; functionally equivalent.
  drivers/hwmon/eic7700-pvt.c: call is guarded by IS_ENABLED(CONFIG_PM),
    stub is never reached. No impact.

Fixes: bd3d245b0fef5 ("usb: core: use dedicated spinlock for offload state")
Fixes: 7806bad76ac39 ("accel/ivpu: Prevent runtime suspend during context abort work")
Fixes: 9d58aa46291d4 ("drm/i915: Fix the GT fence revocation runtime PM logic")
Fixes: 1524c28b99527 ("accel/ivpu: Show NPU frequency in sysfs")
Fixes: 30c399529f4c6 ("drm/xe: Document Xe PM component")
Fixes: 0d08026ac6099 ("net: ipa: kill ipa_clock_get_additional()")
Fixes: 70892277ca2db ("iommu/arm-smmu-qcom: Make set_stall work when the device is on")
Fixes: 9ad65684b9285 ("media: staging/ipu7: Ignore interrupts when device is suspended")
Acked-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v2
- add fixes tag for patten C.
- add Alex Elder ack tags
- change subject to fix stub pm_runtime_get_if_active()

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Alex Elder <elder@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Joerg Roedel" <joro@8bytes.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Guan-Yu Lin <guanyulin@google.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-hwmon@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: imx@lists.linux.dev
---
 include/linux/pm_runtime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 64921b10ac74f..de9e7518ecef2 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -280,7 +280,7 @@ static inline int pm_runtime_get_if_in_use(struct device *dev)
 }
 static inline int pm_runtime_get_if_active(struct device *dev)
 {
-	return -EINVAL;
+	return 1;
 }
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
--
2.43.0

