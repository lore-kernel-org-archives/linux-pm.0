Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793291469;
	b=iy9k1HSxx02Q5TosbQEUgqk++Za0UnVwukeJXUDwG4IR0I7SS4wTQ1j6k1xpTphpmn8Q
	 vAiBKQi/NQYgOePSRKMdPkF0Zpko7l74+ou16PffDIMxgmFidECEJf4YU2IGN85b/zzWA
	 L2VoVjGtp8myTHayx1C+1Ko47RN9oIkbAc71RagLOKHQGOzpHtuzq5g6GZhp+1a9+xzPI
	 7hnp+qJFTpFGz1uTAKVGDRLfjYdH8Vw0fpD0pQ6EafWMBDh1urh7bwg+5g0I/YC4AStQq
	 bW6mue9zMGRntE10/L3tXvzwjhtzax3FuPKDJ4G7OSue95UdIDP7rDEgF8Md86uq39A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291469;
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
	bh=e9PNCwj/XIJLcmHgICx+5abEvtPA2lHup7xvhFuDMGQ=;
	b=4G5iD23hpbM+pRkgcTMjZMD17lnHZ61aD71gEPEfnrlBVWfQJeSoBz2qeNCAfZGoEU2U
	 XBAIY3czcvWTIbdMZvIPmHsyKi/vmOwBSqKKth1/cYOfYrQXZRI4qGMLqvYuKnd4DQ5tl
	 SDHateG/OHR+5lxdbzFDqj1zsbkkBZOK7gi8D0xMF04dpKbrjsxJPVkhR1y+9ynet3kPC
	 nAxNyQ1qBzjibEKy4hPc79cfEz9fn7oWivWEWx29W5UHGn0LT+9htTXn/gk3+3b2ohHI/
	 vUu4ACDYd4A5v48022oKUB9RYD2Y2EpGT0qpGvVN6/jVUZozuqUyPfHsmg7D3RaICiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JoarM11I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.11
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22F606A31C;
	Thu, 29 Oct 2026 16:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B22F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JoarM11I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFcGcdLuRilahGmHTOlVeUEven84WEpaLKZjo2LNz9SOqE3SStZeBe76YyQMHC5RPkCjkWxpzK1uzPKSySr49HD9kRL/gBgP+7j17DlIIofMQNXvgTh5Abyhbbk06eZ3LA8wEUJ+1jh2R2+gsfAVyk9BLVgR+fquMQXIC0vC3n3FOLaeobxHBxkUXZJGOVh41qtQwP0RaQlj8uKwJ6igjSxNrqiSjA/KpXpaeDqRBMTZylLb5r5BPwpMue0a9dy3yAp4BVuOnuQ2j2mb16RVgqaTzjOiX0FVEEVUsxjVrEi6LVV08c2ZKo4uqv8rBBLu3yfJe1UFZTDGuKUheS4pFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9PNCwj/XIJLcmHgICx+5abEvtPA2lHup7xvhFuDMGQ=;
 b=SU63X+xS8D/Ie1j8dzN+T5quKU/SVBY8eJS+YLuFWDtnvm5CDwN04wbhIjZlSBpLVrV7dGIk8/p6ISqWJfsIhoaaBflp7v4ykvpi6O7ktllkOlqjtbm8GMkwiZPWTzhcsxYNRhaUJA1OyXYfTh5UysPEfjuGgWEpwtsXb2qON6m6ODc7xRt40Mpaiizywmpy5tUZLi0iObRSfImmFKUqGeZ4sjS80VPIlm+QHdeNDZkPRReb9QsK4mlxLnZAJkopGv8TnUj2p17v6eZ+NWm1nKBgV8PRhaTJyeQ02yFdko7Ou3p+7yoS/cgEeacVy0H6aViYTfzmY0Mmoqop+1Y1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9PNCwj/XIJLcmHgICx+5abEvtPA2lHup7xvhFuDMGQ=;
 b=JoarM11IFtkri4Sq++PddiCrRY03RhdV/zQMTeqDPLm6SUiuwz24S5Rw0kSj23f9DhAFyAgl6xPiHz4zY61tjRozMO3zCE+b/WPkvpQiZNCwe+ZtKnspfU67ZmtVABc4PemYRh5D5MU7FZZjA/FNhd9LN8D5L/5mbKv2TSk6+rduQSEDgDS+lbRv1NuKEZHTF/pBcS1UhsR5iJtR2MBryLwYH8PuUFEbDVePfkVc05XvRmzjS/VZp8dRGjc/eVKPTjaHwHns9RjteYtCmR+1GrEjuEf9yWrHr6mTyuKlaNAuzMTqH3S+GvfflC4VWm9JiggKxUL0W6AGMJl9VYtTFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB10046.eurprd04.prod.outlook.com (2603:10a6:150:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 16:31:02 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:31:02 +0000
From: Frank.Li@oss.nxp.com
To:
Cc: Frank Li <Frank.Li@nxp.com>,
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
	imx@lists.linux.dev,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active() return 1 when !CONFIG_PM
Date: Thu, 29 Oct 2026 12:30:37 -0400
Message-ID: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB10046:EE_
X-MS-Office365-Filtering-Correlation-Id: c82e6468-2843-47df-01b8-08df35da0568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|376014|1800799024|7416014|6133799003|18002099003|56012099006|11063799006|10067099003|261028144727099003|261021123027099003|261021121427099003|261009221727099003|261009223327099003|261009223027099003|261009221227099003|261009220027099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	4U2r5HKVzQxL9XoVisHoci6To+0AW9AAvXPaojbd7wtkEveOtxf4pRaYQIwfn1xXpbJc6gOcisQqX27DDe4CMklkRdDsWZjrdNZprBwHVrFQ33HHkopPOidj4bcDw3sT0ydVHaoGu4/hKHrxwH3RKJkGJyOAt8G6YNsjnL6KHaqieXiXyhoGwFwQGJ0clKfNp/AdTCVa5TopdTTBuxT0/Etm8UYbbHet6w+5OWcfntpNB58eWl7YMhs8zIWyDxoP7eM3xexTyWyhJrE34GP4s6y04oTsRzAW9C2yUAp7KAfEwNMD9STAlsoO6GdmkNHLkEDVLCE84NRjTJjDloQMVqiHTizUEqAnPnCdX7qMeZoul9GoeHs/W2y+WTlxeopdaPomwggu02vL3GA7B0UbXwe9RIlrdcopX84e5QU2m0DDCnpyghXpwht81sRKkC9gWJfopSp0kyrwNbYtJIlrMsJX9GWSvgwWInpC28DOMCNn/OV73S9VHhH768pkUAsQRJ2P/vjheDO7kZgYzH/iVQw58utlS+V2+PXjGMPmvvwCKOxqTjRt4chPSWhBU3TwNfFCnz8/2Usc9k3/x0hB45O7uOUinkM2ZX/uSGgrzc1NLxCSce7R4xVcZ77hsS3/rEjFAt5NiKylycDAToYA+PsVRaHYtML996XFcMvYhMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(1800799024)(7416014)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009221727099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009220027099003)(261026140227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PdUJudLuzgndgMBrstFMTSOSKKpy8Nv9mfyTLu/Ct4I2/N7BogkX0SQuHiCe?=
 =?us-ascii?Q?sdK+ls8AzCcW8JSPERpAMGTLhp94FxhqfDCAQ+h0FL8aJKJIReQzuITFuutc?=
 =?us-ascii?Q?/7rVdtx/srYC8EPf+d6GiINcU9tMWX/9BTgsVS8W3OwpkMPDZ1wBfPJuXElJ?=
 =?us-ascii?Q?1inKHOdvwGo1pNYH1m3+Z58oRgPQXV8XmZzOiccVlqDltuk8mGHYjzD/6hf0?=
 =?us-ascii?Q?DpMcfC7FpXLWqqcDRf8RTx6HnawVm0j8iJztdOgr8ONdxHOBQmstayKJPxjN?=
 =?us-ascii?Q?+UNIJk/sLuR2aPmF+TFaCbz9q9oBIGu6uRYTjNrsQkWQVAwXcpkkXzVaZ69o?=
 =?us-ascii?Q?efwg8TCmsLO1aYed++3xiVqZGgCta3aPTZg9q9zz8pbS0m1qmM5eEakhOAP8?=
 =?us-ascii?Q?o5qyhSKL9FIcxYSFg7UqGz02J9RiBdFzSH9BX7yDvLleKKyxCQ5eWh78QeoQ?=
 =?us-ascii?Q?bAdy8ZH041AruPGFhFBF9LxvP+JoWY/Y17LSHuyIewYb2RQ34MNMrBw/wIrV?=
 =?us-ascii?Q?VI+m/loG/XMlgfjuiJBKsP7tffnbBCQSehTEzBTc55MisdSpmnNUANvoBkbW?=
 =?us-ascii?Q?izu/hCPp50Ll0UjEYLEHKh+JlkmB/VV/FBgrQNETkTNZMkNGmXlo3fzp/hJd?=
 =?us-ascii?Q?izAvijIr68Pqk7WaqaCIUxmXsj4p132Y75UUcQXqh2G4xoS7j+36aC5RBgjp?=
 =?us-ascii?Q?Bx1io2OSvS9fHoauIFnjZ31noz3X16WVh2XLvEQyZSB62ms1UsTaxfmRb/a3?=
 =?us-ascii?Q?UFRTm8pZFvzQ/H32VKDV7dNN8eyzx8uDiMPms3zXbDv8vSfGEM1iOdeZtAoK?=
 =?us-ascii?Q?tuzTZ+ApH0xf/tIRxNL4WMT7JNHDk8cELtuiLaMP8NA1YHwHQ+1SWkK859tk?=
 =?us-ascii?Q?pwja07/Frse7aXYlEelpiNLIXKSBF3k0qstUay4XDAHVjxqyFXboIFK0IVI/?=
 =?us-ascii?Q?ysPSD3p9HKKx1wn++5OmKqC6kD4Dt+CCrlHsadHwAnh5G9WH+4Ta2+hNdg0H?=
 =?us-ascii?Q?yY1/I4xuQ1eoXvT2L4jQQBObH69hj0N4Fy07GqvH8hX8CNRmERStA9g5WGJe?=
 =?us-ascii?Q?efc7Qdt7W/eVEM21UTwUHJRO/tU/uGqtPvnrJmr9h6aBf+bxAy/rVaC7jFII?=
 =?us-ascii?Q?60ljuUHzNTbVayW6VtOEjH99ytHMsKp1mRR7z1LcTbXSPLsK8PxkzsnMwctc?=
 =?us-ascii?Q?eOBUNKWQDn1+kjdHjpFaRQ41NGd8IqAKmfFrJIfXrWgYWt0bASvt5xTLjcP1?=
 =?us-ascii?Q?LC6KS2MfwSBk2J3frSJQFiY/Os1oJS5MM8/g8fZVkVWvMX/eFJQkTSXQk9R4?=
 =?us-ascii?Q?Z9yTKW0JalgGrGVS3bvM1lIK4S3iuhz5Uo6gR0Eh+FdVpmNoPr6M6+pWek+9?=
 =?us-ascii?Q?qpwVe9VRnnlGAZ8/NLRA0nvY+NOA8RAorRwBQLbRrd0ON/XlYYmOZKd33mLS?=
 =?us-ascii?Q?tcM/QAy/T6ZYlEXPpAvb98cIN5I3YsRLBwNWFPIAb39p+LWC0UM0wTlNs5+r?=
 =?us-ascii?Q?43WJXGSOhpgKAe8KBaxN5Sh93ZwTz43sjCVO+q4inHsL8MHhQnK9nwOkNnPW?=
 =?us-ascii?Q?GkcYlJMciRMHazX9A7ogE12SHKvnb7e8nxU8vSuv/Lx7XoagLWbFrr3OekDb?=
 =?us-ascii?Q?45orQ8AmnO1FqBCqjz43zTbDKQmK0+ar2a/x8WCvdbB4SUAfZjjDi/3BFWWG?=
 =?us-ascii?Q?bCAldjIcqidzJfcjHbUbgpvQDDmHobX5ob1mTAQwftkR8zRNdpipPzgjJdkw?=
 =?us-ascii?Q?vnwQ1/4N0n3hGXPYeisgy6DrEjdE9IbAU4TKgXTgq9WJI37x7YTq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82e6468-2843-47df-01b8-08df35da0568
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:31:02.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqehOsuVKGRBcXoZfzfOpv1Ig0XTNviKWlwjaqHGvQy2no2bqwL5nrI2LSSJN6k+G8jEN99CU+NyGuQZs0ytCHei8wRMnJbglZg8gCzHwHMYPCoHJYQHm2pkDi+WxWoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10046

From: Frank Li <Frank.Li@nxp.com>

When CONFIG_PM is not enabled, all devices runtime PM state should be
treated as active.

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

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
Cc: Rob Herring (Arm) <robh@kernel.org>
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

