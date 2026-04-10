Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BE72631;
	Fri, 10 Apr 2026 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828904; cv=fail; b=MiZAuSwzfwXiObX9B/rygMdwxtw5+semJ55pHf+eZvDjF0XGtMW9mjpKLlIx0i6DvkE+fAn95wOMrO/0K41x6ZVJOcvc0851jvPAdJIgBtHpsBmuNSOtdpo30/1f99yBiOzPxH+0xC+vxSRofaF22lkmFncnhxez3YPcqJUZEKI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828904; c=relaxed/simple;
	bh=EVULKG8+FlpzdZa4Q80YxtdWJc3cD7Yb1YMX0l18W44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F90HGstKXSW7LRs8eO5qeD/1Tb1Rekz08JLiEBoxgt/C8Gpwh4YlLskQEvbr545Mfi3XcazSr0JG/fop68cGkpr1m1Y15a1KtqFC+5pk7HRNdGeBoneyitTtCaJvhKdzH5ptHQbfonb/3llBpcjpJquhgJtvI2FhKo8BT7Nn4GA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Rdrf5T83; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Rdrf5T83; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Rdrf5T83";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Rdrf5T83"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qY6VAGKGxebc+u6jl/PEfJmcIHNI9D3oTFedPD3vaZrcppepeNM8OUumLlhZULvBB3xJeS1j1WBBNYv7J7GiEu8PnywrDJkktfR8JAT5atytvaSkwSVq8Bl93HMj2MVJi3sPbdrIxLxfhbU4cuwkAU4rUmG8vuTs+1vEOSyHFrT5latjC8xlkcpze+IrDvjadrwEMzLSZveaxdxzYOCJHRBZS9ywhoPSzARtF1tqvDtveQ3z1qDmKjQdx09pQEMolPFxzypb8Wx4Ds/49dvmpyZr16U3EqO1Cqu3KAygMGfzYrzx+OACf/bSmArDs+XQF2ikCv1zw2EEpmaQ+0hO5A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+6ZUj6dov+vlYwscuqF6X6mA3uPPA38Lq7evScRndw=;
 b=MqWCroUN2ckQwlDkgWuzSqu6BB0aUu4LkOYAYmGseFuuaoFgkEmUtdE/ZBad2fmhnUXCIUiHG93EFoYO6+qEP3nqvyScEF5qAYslyT+qAwnpDUaG3v/6yVdLD5JvC4qOyTO7pywSEvF1RUn86sEl3EK/4B7pdpMDC7N+VV+ndriG82AqbbUFlGMfwa226b0dSMt3ZjUkGv4R/0oxccr6mzv+8qD7CBn2OMX1xLJCiYYa7mY6n0AFtCHGpd7U/u7BzuA8iqzXiu96lCeq/P9ryCi2wAgB3f2kHj5XAqzinq9nW/VFSlaTOxOgP7y+99eRYfUvjY7V6gN1T51a2gTdZw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+6ZUj6dov+vlYwscuqF6X6mA3uPPA38Lq7evScRndw=;
 b=Rdrf5T83jBZIuzshhNFz2AdCTtAGkVomDQRpEZifLxrc89ASPl+s6FwoJ3FazUhXLv8+HDGESz+lT4KOI97Z53qYW/lpKYL5sSyes1xmZs/zL5b633TXmcBUvUBrSX+Qrtw/U21eprsCdJOxD+4Nx2kDiRLzI2HwMRBhbVLk1yE=
Received: from CWLP123CA0216.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19d::16)
 by AS8PR08MB6024.eurprd08.prod.outlook.com (2603:10a6:20b:23d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 13:48:13 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:400:19d:cafe::24) by CWLP123CA0216.outlook.office365.com
 (2603:10a6:400:19d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 13:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 10 Apr 2026 13:48:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPDxNrcSEJXHJyzPdeE03BEGKa95K26EtwhGhcBKlQDtAF5aYtZp3dj635KsoDHN7cndUx7a7MvoGXWB+g/hILZafkyuwYc2uXrWMHpIryb2OcOx9CELPwnB9kUnVI7Stm2cbbaRj3VtfIxu1HcyGBHv1sYFBaq7KaHfnGLvGh8Ooe4tgDuLJIN00E6A703ehIiZPfW7MAoFDeFszHGRxh9QHkpCcJr3RcdEvRVTn5lfBQ5w0KFn8otaGnI+bNzYGE9DRNgLomXebcVIdSMRXRDzfTpOSqyYoGqj9CY4FJIdE6kpM9Wa+B5QhhjWIotzqOSJotXuo9viyFrYNnW5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+6ZUj6dov+vlYwscuqF6X6mA3uPPA38Lq7evScRndw=;
 b=qu8IxZoLgLQr5MxIrDDTynIEmFb66Ofoa+Y1ztpqJdJSItI9ZywWb6JPoEahyX8Hte7qS2v7lT8DyLYSLQOHffbvzXXZHeAxBK/k0nUgmv3iKeiHEjUNaJJEke5wqd2Fsr9aMluAD70AJ6Rt/iyqvda1+7dhGLHy18ZR19xcpK7TUtre4qaAL513JmX4gIfSRAJGGUFMiVOc/61YprQf8x2Z0Aa7XXBSNW2LxhjBCcFbjtgssa2tjHVrkzrKONBiZRCR/++jXDKXCMgOa/ZY6NEyJQzklzlTib6dxB9uVyF8SaN2gC4970TzdYia6ckWYaYOje+wXfpp3QmtvDFuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+6ZUj6dov+vlYwscuqF6X6mA3uPPA38Lq7evScRndw=;
 b=Rdrf5T83jBZIuzshhNFz2AdCTtAGkVomDQRpEZifLxrc89ASPl+s6FwoJ3FazUhXLv8+HDGESz+lT4KOI97Z53qYW/lpKYL5sSyes1xmZs/zL5b633TXmcBUvUBrSX+Qrtw/U21eprsCdJOxD+4Nx2kDiRLzI2HwMRBhbVLk1yE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AM9PR08MB5907.eurprd08.prod.outlook.com (2603:10a6:20b:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 13:47:10 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 13:47:10 +0000
Message-ID: <208360b1-36a5-419d-80f4-431914407f61@arm.com>
Date: Fri, 10 Apr 2026 15:47:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: add autonomous mode boot parameter support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, zhenglifeng1@huawei.com, treding@nvidia.com,
 viresh.kumar@linaro.org, jonathanh@nvidia.com, vsethi@nvidia.com,
 ionela.voinescu@arm.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 zhanjie9@hisilicon.com, corbet@lwn.net, mochs@nvidia.com,
 skhan@linuxfoundation.org, bbasu@nvidia.com, rdunlap@infradead.org,
 linux-pm@vger.kernel.org, mario.limonciello@amd.com, rafael@kernel.org
References: <20260317151053.2361475-1-sumitg@nvidia.com>
 <4b1f100b-e699-43c1-a06b-5545056d174c@arm.com>
 <b8debb30-67a5-4d2b-8c08-8fd287f7258e@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <b8debb30-67a5-4d2b-8c08-8fd287f7258e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0078.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::18) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AM9PR08MB5907:EE_|AMS0EPF000001A8:EE_|AS8PR08MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: c80b0062-e79d-4334-1629-08de9707cf87
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 7GYBxqhNdqB4ya67TVzpLIB/A3RFOtTD8yOW0z3ZZxoDNbhJwY55SdYzuK87XuN8Q7eFCSzQiyW1h0aUion2esoP+v1bZZcr07X7RTDMRD0nB4eRpaH+h6dVP6bqET6kVzQGkxi68UmRV8jqU5Zlpv024T/C0ErUpZi95+M6zlkKnTVnlvmZqFUrPsIYiA+XAV0OT1cvAN24S+/82Wj4Ed2LPmRrqFWEoaqKYnCy1mYI96mWSPPk8QEXi1jxdgWQUTMySzhHWJG65A3b8dYbNO0BXoQjworukcBQu7ZI5szkvUgsu2gig/PYtjEBn14GbeHT2nxPIZTC7FEWa4WsKpBHGb5oGY/HHct40cZaf7K6rKY6b8HxCIRBi9aeLXzRuiYfrVHNHl+d/RaoX1shGkcLs1Al/onUL78luvhBeKQ8vRrINiilETzOM1gaR5xgJIfFCotdeWTf3Df3HkhlkK8v+DAVoldMx/KfRASL7zDCPPS6miuMOQvy99kfBcRVnfOzfIHhHjyktZS4vUQJFBCxwr9eOfvA5OzRmo2tfua/0XP2Uq+6pOiJitRd5niQGVXrVDMlZnx9o08VUD484pz45EPfQZ3tJXKauOVwPjai01dIxQLtlffyQTyfV+L1Os8G20cHjsnOd6+3hybK0oKXxPLKhpo6K1KEd7ChVLXFb1D6C+RBo7tOYBiIPkn+
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 SpYHFdnrbltzM1VHm4Lhh0sptbgvJeS5SfEp27HHSydhbmrFsRd4ajqKd0rxvRRtHLRI0O/KMOT4bRGluTsQPLrbatDjl9UiDrAHG1/yAagMnnC5/0n/LqPzvcXdfMffAr97d4rQKCVQjasfksWsJgtnp5ouwnYCcbobdJLzpafyKAwQxOlsSBqyUe0tH179LfT0shTbDtPwbTgX/ZFvUd9OG8aZI+jmLPalevMCAJfjSwJgaXmu6rqd7HqhxSZw/K1XZgHcLNO9AOl/rkEAMMEFk2ifzY2F2d1oaLtLIz0tDE3QpXT6q5rkxaPfqXy/657ckz6KOcQ/EHxUh18gdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5907
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bc17e881-41c5-4bf4-8ecc-08de9707a9b7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|1800799024|7416014|376014|35042699022|36860700016|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qxE5GD+W6QMcqPe3W2XdZpGG0+WMNBL0TEuhRxUSrhpmoLlT+Awn8L88EM9Um0QwImhi1N00sPxiatdYZWho/YLT9vO5YH3AhSRFVe8gABpcTlaqbV0H2LaxpCx2SGwAwzRmO8dU3ps81xQxR+wuCUl+DTPUNWh4Pmboe1j45NqOaOtDCSRYap8PMiPdrhaE8qB/BQzn14Xos2X4W0AF9HDsBB8x/ZjiJbzet3CftubQBAmWZPShtf2rAblHuXL3RH9DfBGQsDQWNgbNtx3isq2etBMdwXK1q0YofyOlRaJ0mfH6/3a9+TJOAsX0gn9+Rxnu4m4Rl+5Hr/gD6WWquV3+w/+ky2+V6rOQVXaS8lXBuJqlBjQgDninzaPqHpCGbEGP6befv1SOxSZD4XvlOkuxnBpmGx5nYdYF7KOF3DiuGtnMAu6tfx3PNROwAMYSjpFSr53qaE0mm4JWoKqhvq9UvBRUhdkYG+bl/BUOETTxPEZRwQXzUlChDe6O9VnIn777O4NrPUrMkeMC90geivt4n0G3e373nqtdVrqt1L3dqKtXwihh5Ko4I+gFyfGsVQzDCgnizvZhgsdO3j5wz1FE1W95Xp5xk7icHZhxtHjVKIW5Tg0xi5/YbsPGxshfD0OQCCqIozQlvIZRFrWXtE8CUxBGo8JopM4cJBl59E081yWsKnrHk9rUyV0PLTAgm1iSAjA497IMlvts1FuSAfjZW78fnVAyCSrB8vnYcJI=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(1800799024)(7416014)(376014)(35042699022)(36860700016)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MgnzVdpoz2k0KWYg1PXuBu+sXs9RuF70p9cuW4xewgGvtcxGpCB0hwAZYIcDnbZTdk6LDTM1588oWI//AfM8swT+Pl77g2yA1dNIQdlLZZdmVFrFtRuxjYmBUgjuE3kVITZco8boeDFKU/EyWBf6FPI7GyaW1C5bnmEp7sym2iBbVGKbPqq4bB4/3709w7cN+cOoEJW4REvxWxtzIAl55NnWQU0d2bexn52oQcjpYizUfGVKHb3G/Xlr2LS6fP+h+C9fdG74+98RIfeqPMuWfr2oxIdUDMyo0dHQtaHNDVSPEk6hXvh2PjAj14+TT10YwZeLWr5r8iPlGy5VnlAmBfDWnTwt5Y7ATJoHOd1JYwcOV5TUFpvflYF4XbTU1Xf4eWR6DVHUZ8paKyhh/xajqrX7RLH2K9gUQoMu/9nPv4XT2ms9Wfffa7CIrApbXf56
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 13:48:13.4508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80b0062-e79d-4334-1629-08de9707cf87
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6024

Hello Sumit,

On 4/6/26 20:08, Sumit Gupta wrote:
> Hi Pierre,
>
> Thank you for the comments.
> Sorry for late reply as I was on vacation.
>
No worries
>
> On 24/03/26 23:48, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello Sumit,
>>
>> On 3/17/26 16:10, Sumit Gupta wrote:
>>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>>> autonomous performance selection on all CPUs at system startup without
>>> requiring runtime sysfs manipulation. When autonomous mode is enabled,
>>> the hardware automatically adjusts CPU performance based on workload
>>> demands using Energy Performance Preference (EPP) hints.
>>>
>>> When auto_sel_mode=1:
>>> - Configure all CPUs for autonomous operation on first init
>>> - Set EPP to performance preference (0x0)
>>> - Use HW min/max when set; otherwise program from policy limits (caps)
>>> - Clamp desired_perf to bounds before enabling autonomous mode
>>> - Hardware controls frequency instead of the OS governor
>>>
>>> The boot parameter is applied only during first policy initialization.
>>> On hotplug, skip applying it so that the user's runtime sysfs
>>> configuration is preserved.
>>>
>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>> Part 1 [1] of this series was applied for 7.1 and present in next.
>>> Sending this patch as reworked version of 'patch 11' from [2] based
>>> on next.
>>>
>>> [1] 
>>> https://lore.kernel.org/lkml/20260206142658.72583-1-sumitg@nvidia.com/
>>> [2] 
>>> https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
>>> ---
>>>   .../admin-guide/kernel-parameters.txt         | 13 +++
>>>   drivers/cpufreq/cppc_cpufreq.c                | 84 
>>> +++++++++++++++++--
>>>   2 files changed, 92 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>>> b/Documentation/admin-guide/kernel-parameters.txt
>>> index fa6171b5fdd5..de4b4c89edfe 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -1060,6 +1060,19 @@ Kernel parameters
>>>                       policy to use. This governor must be 
>>> registered in the
>>>                       kernel before the cpufreq driver probes.
>>>
>>> +     cppc_cpufreq.auto_sel_mode=
>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous 
>>> performance
>>> +                     selection. When enabled, hardware 
>>> automatically adjusts
>>> +                     CPU frequency on all CPUs based on workload 
>>> demands.
>>> +                     In Autonomous mode, Energy Performance 
>>> Preference (EPP)
>>> +                     hints guide hardware toward performance (0x0) 
>>> or energy
>>> +                     efficiency (0xff).
>>> +                     Requires ACPI CPPC autonomous selection 
>>> register support.
>>> +                     Format: <bool>
>>> +                     Default: 0 (disabled)
>>> +                     0: use cpufreq governors
>>> +                     1: enable if supported by hardware
>>> +
>>>       cpu_init_udelay=N
>>>                       [X86,EARLY] Delay for N microsec between 
>>> assert and de-assert
>>>                       of APIC INIT to start processors.  This delay 
>>> occurs
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 5dfb109cf1f4..49c148b2a0a4 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -28,6 +28,9 @@
>>>
>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>>
>>> +/* Autonomous Selection boot parameter */
>>> +static bool auto_sel_mode;
>>> +
>>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>   static enum {
>>>       FIE_UNSET = -1,
>>> @@ -708,11 +711,74 @@ static int cppc_cpufreq_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>
>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>> -     if (ret) {
>>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>>> -                      caps->highest_perf, cpu, ret);
>>> -             goto out;
>>> +     /*
>>> +      * Enable autonomous mode on first init if boot param is set.
>>> +      * Check last_governor to detect first init and skip if auto_sel
>>> +      * is already enabled.
>>> +      */
>> If the goal is to set autosel only once at the driver init,
>> shouldn't this be done in cppc_cpufreq_init() ?
>> I understand that cpu_data doesn't exist yet in
>> cppc_cpufreq_init(), but this seems more appropriate to do
>> it there IMO.
>>
>> This means the cpudata should be updated accordingly
>> in this cppc_cpufreq_cpu_init() function.
>
> In an earlier version [1], the setup was in cppc_cpufreq_init() but
> was moved to cppc_cpufreq_cpu_init() to improve per-CPU error handling.
> Keeping the setup in cppc_cpufreq_init() helps to avoid the last_governor
> check. We can warn for a CPU failing to enable and continue so other
> CPUs keep autonomous mode.
> cppc_cpufreq_cpu_init() would then just check the auto_sel state
> from register and sync policy limits from min/max_perf registers when
> autonomous mode is active.
> Please let me know your thoughts.

FWIU the auto_sel_mode module parameter allows to
configure the default auto_sel_mode when the driver is
first loaded, so there should not need to check that again
whenever cppc_cpufreq_cpu_init() is called.
Maybe Ionela saw something we didn't see ?

Also just to be sure, should it still be possible to change
the auto_sel_mode through the sysfs if the driver was
loaded with auto_sel_mode=1 ?


>
> [1] 
> https://lore.kernel.org/lkml/5593d364-ca37-41c5-b33f-f7e245d6d626@nvidia.com/
>
>
>>
>>> +     if (auto_sel_mode && policy->last_governor[0] == '\0' &&
>>> +         !cpu_data->perf_ctrls.auto_sel) {
>>> +             /* Enable CPPC - optional register, some platforms 
>>> need it */
>> The documentation of the CPPC Enable Register is subject to
>> interpretation, but IIUC the field should be set to use the CPPC
>> controls, so I assume this should be set in cppc_cpufreq_init()
>> instead ?
>
> Agree that the CPPC Enable is about using the CPPC control path
> in general and not only for autonomous selection.
> Will move cppc_set_enable() into cppc_cpufreq_init() or outside the
> autonomous mode block in cppc_cpufreq_cpu_init() as per conclusion
> of previous comment.
>
>>> +             ret = cppc_set_enable(cpu, true);
>>> +             if (ret && ret != -EOPNOTSUPP)
>>> +                     pr_warn("Failed to enable CPPC for CPU%d 
>>> (%d)\n", cpu, ret);
>>> +
>>> +             /*
>>> +              * Prefer HW min/max_perf when set; otherwise program 
>>> from
>>> +              * policy limits derived earlier from caps.
>>> +              * Clamp desired_perf to bounds and sync policy->cur.
>>> +              */
>>> +             if (!cpu_data->perf_ctrls.min_perf || 
>>> !cpu_data->perf_ctrls.max_perf)
>>
>> The function doesn't seem to exist.
>
> It is newly added in [2].
> Don't need to call it if we move the setup to cppc_cpufreq_init().

Ah ok right thanks.


>
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ea3db45ae476889a1ba0ab3617e6afdeeefbda3d 
>
>
>
>>
>>> + cppc_cpufreq_update_perf_limits(cpu_data, policy);
>>> +
>>> +             cpu_data->perf_ctrls.desired_perf =
>>> +                     clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>>> + cpu_data->perf_ctrls.min_perf,
>>> + cpu_data->perf_ctrls.max_perf);
>>> +
>>> +             policy->cur = cppc_perf_to_khz(caps,
>>> + cpu_data->perf_ctrls.desired_perf);
>>> +
>>
>> Maybe this should also be done in cppc_cpufreq_init()
>> if the auto_sel_mode parameter is set ?
>
> Yes.
>
>>
>>> +             /* EPP is optional - some platforms may not support it */
>>> +             ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
>>> +             if (ret && ret != -EOPNOTSUPP)
>>> +                     pr_warn("Failed to set EPP for CPU%d (%d)\n", 
>>> cpu, ret);
>>> +             else if (!ret)
>>> +                     cpu_data->perf_ctrls.energy_perf = 
>>> CPPC_EPP_PERFORMANCE_PREF;
>>> +
>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>> +             if (ret) {
>>> +                     pr_debug("Err setting perf for autonomous mode 
>>> CPU:%d ret:%d\n",
>>> +                              cpu, ret);
>>> +                     goto out;
>>> +             }
>>> +
>>> +             ret = cppc_set_auto_sel(cpu, true);
>>> +             if (ret && ret != -EOPNOTSUPP) {
>>> +                     pr_warn("Failed autonomous config for CPU%d 
>>> (%d)\n",
>>> +                             cpu, ret);
>>> +                     goto out;
>>> +             }
>>> +             if (!ret)
>>> +                     cpu_data->perf_ctrls.auto_sel = true;
>>> +     }
>>> +
>>> +     if (cpu_data->perf_ctrls.auto_sel) {
>>
>> There is a patchset ongoing which tries to remove
>> setting policy->min/max from driver initialization.
>> Indeed, these values are only temporarily valid,
>> until the governor override them.
>> It is not sure yet the patch will be accepted though.
>>
>> https://lore.kernel.org/lkml/20260317101753.2284763-4-pierre.gondois@arm.com/ 
>>
>
>
> You are right that policy->min/max from .init() are temporary today
> as cpufreq_set_policy() overwrites them before the governor starts.
>
> On my test platform (highest == nominal, lowest_nonlinear == lowest),
> this had no visible effect because the BIOS bounds and cpuinfo range
> end up identical. But on platforms where they differ, the governor
> would widen the range to full cpuinfo limits.
>
> I think your patch [3] fixes this by giving these the right semantic as
> initial QoS requests. With it, cpufreq_set_policy() preserves the policy
> limits set from min/max_perf registers in .init(), which can either be
> BIOS values on first boot or last user configured values before hotplug.
>
> I will update the comment in v2 to reflect QoS seeding intent.
>
> I see that the first two patches of your series [3] is applied for 7.1.
> Do you plan to send the pending patch (3/4) from [3]?
>
I need to ping Viresh to check if this is still relevant.


> [3] 
> https://lore.kernel.org/lkml/20260317101753.2284763-4-pierre.gondois@arm.com/
>
>
>>
>>
>>> +             /* Sync policy limits from HW when autonomous mode is 
>>> active */
>>> +             policy->min = cppc_perf_to_khz(caps,
>>> + cpu_data->perf_ctrls.min_perf ?:
>>> + caps->lowest_nonlinear_perf);
>>> +             policy->max = cppc_perf_to_khz(caps,
>>> + cpu_data->perf_ctrls.max_perf ?:
>>> + caps->nominal_perf);
>>> +     } else {
>>> +             /* Normal mode: governors control frequency */
>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>> +             if (ret) {
>>> +                     pr_debug("Err setting perf value:%d on CPU:%d. 
>>> ret:%d\n",
>>> +                              caps->highest_perf, cpu, ret);
>>> +                     goto out;
>>> +             }
>>>       }
>>>
>>>       cppc_cpufreq_cpu_fie_init(policy);
>>> @@ -1038,10 +1104,18 @@ static int __init cppc_cpufreq_init(void)
>>>
>>>   static void __exit cppc_cpufreq_exit(void)
>>>   {
>>> +     unsigned int cpu;
>>> +
>>> +     for_each_present_cpu(cpu)
>>> +             cppc_set_auto_sel(cpu, false);
>>
>> If the firmware has a default EPP value, it means that loading
>> and the unloading the driver will reset this default EPP value.
>> Maybe the initial EPP value and/or the auto_sel value should be
>> cached somewhere and restored on exit ?
>> I don't know if this is actually an issue, this is just to signal it.
>
> The auto_sel_mode boot path programs EPP to performance preference(0),
> not the firmware’s previous value. On unload we only call
> cppc_set_auto_sel(false); we do not restore EPP, min/max perf,
> or other CPPC fields to firmware defaults.

Yes right, so loading/unloading the driver might change the
default EPP value.


>
> Thank you,
> Sumit Gupta
>
> ....
>
>
