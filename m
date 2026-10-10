Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F302DC79B;
	Sat, 10 Oct 2026 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601067; cv=fail; b=Sk4TaeF+L9VBakLCREBiqwTNZN5XQ2D1sFTR45ey907+L67rz7LeaiYyJJ2BCPCHo58LRjreewsMBOU0ilhuGC3kKeW24UMcdkyfBf2VsHLWmEvF94tkSy4HJ5IIcj+BXU/g3EAK8mLtBhrag3asCK21EGOlVRKLqfkS8XSiIzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601067; c=relaxed/simple;
	bh=6q1G+3f1PSzJ97aXz7xCRdv+qJR8/S5wfyuCHw16JbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kKIfQncUx2saxDP4nL7EMpxq43c6Hi+yMgmwNAuUMsVkxsYIATbdb4c1xs23FplJzuDoSYbbfyic4fFNCZAk8jL2O52QmU4hcF9xD+wr1lNXIpsvHPp4B8m/bYgwoWMAs19n+xi1tyCe6hWFnS7q5rYElh5+1toVI5X7itZjxo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=noLEXLZz; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="noLEXLZz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xD59+79Ynlj9DvHj0l2du5ii2W9h2kbuKu5hhpxg7S+OI3Q/u3106ya1bUPPJ7yB/DvS12lMcL4Wts61HkGX/J7D7k91Ui1hUj6lOVvLM9BtK3OUPpqI/u0oWodU9JdsaSMKfOTyRW+jmKUwL2QT3upeZDODYtuezOBJzaBYnkjTtkuUFYVJsQWjXWnyG10u6ciX14S+qcpOR8yZFR7DTBVBAXG4bPJHzRD6NBloDULqx4Xm0qW6lMbr5aDEd0yzDnzKhH9v0eN1s9xAH1ACjfFb2PCzV8jhScOD490s4+U6+Eo6bWaIph7jtnrvrdtRkWjP/6vvyhXW31SMdJoEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q1G+3f1PSzJ97aXz7xCRdv+qJR8/S5wfyuCHw16JbQ=;
 b=CB/smzCPWmYEVpka01L67oPFG4kTDFgzAYMbs5DqJHY/69WH/CoUrlXZRlCTG7Ow1bV1km5IzHlLnwpwn8FDGQcsknRTYItPR02pHnVY3k1i4By0sNnHxwe0Ig719/nj9rSy2KkVtFS3v5qxJ4wLzNahfQ/VlFPZndnrcc+pNl2z53OkHxPcCYI9e8h3ydKsFYz5KR+8L87S8oMDHchaIcOu08aiCouwdPSxkrz2IblkH9I7sA6Ios5+OqN14AKmXCX7lW6h+ergWd5nMzmTbInBTKJcNZnBlUmmH7MA0hkkNUQLp8AlQ2d7bYMrZQscclqFqQo6JHQZ94W/bzs8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q1G+3f1PSzJ97aXz7xCRdv+qJR8/S5wfyuCHw16JbQ=;
 b=noLEXLZzzEPeF9KB1w+FYm+JxeCbqe0REiUfiUVelzuOEGimw9En6qI0eiOX7qPkUEN9zt3DwLvixTBPRlamWr355GgPxPOk8TGMujLNlvV7pT/HQlQC+QqRKw+xiFnd/SYcT6LsH4KO7vtY8JTAL6vq8EnG2gKDXL3fiLPp/3w9R43QE2wcr+LlAJ+MzBO4MAfpw1fqetxY61IuaUzbGW5j1u2iLZMP6LFqGT0/TTHzpQh99mn6D9btWTiV8/pn0woCrSMOpQZzWwG+SqE+piXasg6cK+u59C+/HzpVNzWu1oY6s6aE8FBsisuz0mFMldRFgPxDtaVe37L8ZJDGqQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12630.eurprd04.prod.outlook.com (2603:10a6:150:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 02:57:40 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 02:57:40 +0000
Date: Fri, 9 Oct 2026 21:57:36 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Harini Katakam <harini.katakam@amd.com>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v4 2/6] PM: runtime: Add pm_runtime_if_active guard and
 conditional variant
Message-ID: <asmpoK1AdF5FAT4i@SMW015318>
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
 <20261009-adma-pm-fix-and-per-channel-reset-v4-2-55f5fe409c55@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-adma-pm-fix-and-per-channel-reset-v4-2-55f5fe409c55@amd.com>
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12630:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ac12d2-af64-4162-9d70-08df267a3fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|7416014|18002099003|261009223027099003|11063799006|4143699003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	oMcDVvnw35qojQ/m0+nujsEqiQkd75+5UKN+O0gMx3RDPMn3e03s2EgCsaj0Sph23hje42HHR+uqQtcFMQ7nO2B2ysacGIoC0GXDQzVZWgypKt6T033tbsgwpjVU+eVgfpBmphgeY8eb6/VlErQ2Rtv3azMU+VRTEL8KYiH8Dw+oxxuBpBUkPFK1xRtnsJwmUt023YiFr6cCZpZdhnz/lbv8FqNgnDxNaXUcNbJFzF+aB2YJQsDywt853SbK4Tqj8ZLYfnY4BmwwO76aN8qydR0a/dJTD5+UuGdWnPw7kCYaGgxAf1HKatTOFdV6iaIRzhS62c/VjDxUarBtmjIidHKFSzad/7gklLpQ8wTvvRA7wqigJRd8pTQI56Z4N+4JNR7kwGfKKKmhWBoE8DEo6vx1A3/Yjy9GK+zIxY7hK6mK93TMGsCZQxeC2MVZMMTzqC3m1tRCkpsorI4/pPd8BUNiSBNJwv+mpAr/sx8eCJjcaWXHhjoia/ZF1ZvJLwMeSIkEXTzabOHnOj75X9guPMXqnJRj2DvO7Jw3aMJzy3k3ip//p4C8eJVnPEX7Od0/bTAcBjUBmzwgy5IPy6iqzrOaaihnT9yXRDEfBiFdneV2icDQ657/eXy7lZGvdOKBt8eVNw4L+IEXJJ2YB4gbkZadl+v06GHvHsYOdLMnMg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(7416014)(18002099003)(261009223027099003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C3FRM/NiJnkuIe6+72xB1dXWWEDfiDdoemeofr1w6n/GhrCKenPrvvQN0KBH?=
 =?us-ascii?Q?q/rXcNGaHpLo67lNJ+BzCg1rXMuGvKlbPipcHaMzK7YQBU+k9D+rYTJfpWL4?=
 =?us-ascii?Q?8mu1LEQU0B/il61mcvczw5KVolbVPgY/iWm8FnQVGf9o+G3E7SkObiSqlHKY?=
 =?us-ascii?Q?53gAIrh/DteAK9aUCEASOiLgyngwy4jg+56b/Twg28UeRirKPh+4OEmvGNk8?=
 =?us-ascii?Q?En2yXQpr2E+ghv7mS9CZv6aat+ARujYcdtQLA+2f55bH25MjmtdWUY7EBJU1?=
 =?us-ascii?Q?EYosEbPKbliW2mdfNXT/ofm2W3EgO+/ppXX3KzTIBy4JihEEh4mqFPpa2WqZ?=
 =?us-ascii?Q?4M4dAROucGZy8qy4coBK/ACEo1ANVZqbTKHGY/Z2csTy9ArvB6BgT8PDNWDX?=
 =?us-ascii?Q?GcT+1K1EmzyuAj9AAKyVBmlEpAzc9dldlh4Krly/WyXfDzAHkHoKw5iXHPUr?=
 =?us-ascii?Q?ZdtwVLnITxuDWlUqgaJKH/or0eDtJPtGVnmxSUasl76Qbu3uWcwBtzLPLLc6?=
 =?us-ascii?Q?BnxjzdGjmp+TiV/A812i2fVCDi8N9+lbtVOAB4ubP4wXUapssI2S6s9Aa/4Z?=
 =?us-ascii?Q?ZgkQ/GXhNjFvv+MRuuPSwW1ocMcY64nZzHUGSD6IRTBtJGbtq+ExvadBApAB?=
 =?us-ascii?Q?Kkz7QoN7As6utJoY6EJSjpCefPiDo5frFfHaZZtDejKQS3/wQR6mfPQp46Bm?=
 =?us-ascii?Q?1/j0cF9YgnO6Fh5zrGBVc8zuISR46mlJr03faTUJo2+dTSNsXTnmmILktYX3?=
 =?us-ascii?Q?zaaOw0cw05o8FAucAjtaJv9SslFkQiqk8Y3pxtrRTyNj+lS7l0U4FX5bEwZs?=
 =?us-ascii?Q?U35IUQbHvyyrWcEfcmTuuISx/KwI845l5AlfKIPFu28VDh1ayH5cGzx3Ilqm?=
 =?us-ascii?Q?EO4EM5zhMTidFBnD0DF9db/dNORUkZo33u8mOV8PeGBZtZwlX64nkCBjSM8N?=
 =?us-ascii?Q?xRCYsf2Zd5VICbrRVKD3mvnCkmUXBlKvmMn8F5hcfjv6ebHHbsNOqJzsPi7w?=
 =?us-ascii?Q?iQkBNy6gOgecPMPAPcSLmN1avPYaf+JGlIMfk9yoTaS/V/YCcq0oo0i4DtWS?=
 =?us-ascii?Q?pAAZj8vOT0927tazoxlhdgn2+f/Fk8QGMxt1/lhLqmuLZMSZjnx+oSR4jgBm?=
 =?us-ascii?Q?Sz5dEH1i9Y2MID6zD7kl5sIM56r+KRdJCmlnI6pD75ITk/h6PN9tSZbKwZTV?=
 =?us-ascii?Q?ldGGTCs6PgrlVahomoBZ2yN75VmVdqHUiMBhF4oMJkGnYKqUDOz8MDtZQUcO?=
 =?us-ascii?Q?Y5i+/XgKbLH9Ly5rtOGDSS7CXeTWgzkN8Qr/7nniGyQKHBsOxkWdO7KrTJFP?=
 =?us-ascii?Q?vqDF5vdRG32E7Xa1bqtojErjRXTyAqRqZ6c93WzYk7p72Q8he/841b8+xKUV?=
 =?us-ascii?Q?JXts7+IXmM07JjV4B2ql6bxEHo8ia1Vb7+HdW1Sw3Zuzyf2XOWEhgyqjxyh1?=
 =?us-ascii?Q?Pe2v4FaK3MgAN+IWlMCyonc8+6uS/HBpm8F2M0dDq5Pvw5Ki+ew/4M88pwQs?=
 =?us-ascii?Q?e5eFYctDTS29j+leG2bW2Ws3qHUroYKduvO4xQeRnsYkAv1K3krsVWuI8fcp?=
 =?us-ascii?Q?lAkHnXixl7B0yF7DzElL+leEXXMC3PtQnMbOs7WOnc92EbB2iwETealBih4k?=
 =?us-ascii?Q?jZp1eaZ2k+JMcEhTEVuAaR+Q7Y+VCUSxwSi3OMxkudaMxQc3Y8/hAewvnfjs?=
 =?us-ascii?Q?IMP0E2CO/8nGzeU1kCJHVcSev1Z9+nDIdLJLLumlvjkuan2u0czZJjpoAaSC?=
 =?us-ascii?Q?SnJ5XtE81PGg2EtnRu7o6CUg36NH2KI2cbvJNTPIO6wSyi3cFkDV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ac12d2-af64-4162-9d70-08df267a3fb0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:57:40.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNeab40A4Ce7AD67L52zHzUow4WN5uw7xW5iDevN5BYRb3sx7Vz80L+sLcaJq/O0U01h1oCxtelcOfVlJPfbmZJRuvoBs/F4Jm8dM/vQJNAd1NgETndDKrPUgL5qlyfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12630

On Fri, Oct 09, 2026 at 09:30:11AM +0530, Golla Nagendra wrote:
> Add a pm_runtime_if_active base guard and its _try conditional variant
> to pm_runtime.h for drivers that need to conditionally acquire a runtime
> PM reference only when the device is already active.
>
> The base guard must not be used directly via guard()/scoped_guard()
> because pm_runtime_get_if_active() only acquires a reference when it
> returns 1; the destructor unconditionally calls pm_runtime_put(), which
> would underflow usage_count on a suspended device. The base guard
> exists solely to back the DEFINE_GUARD_COND _try variant.
>
> The _try variant (used via PM_RUNTIME_ACQUIRE_IF_ACTIVE) satisfies the
> _try API contract that guards must not produce an error when runtime PM
> is disabled for the device. When pm_runtime_get_if_active() returns
> -EINVAL (runtime PM disabled),

If only resolve PM disabled case, I suggest define DEFINE_GUARD as no-ops

Frank
