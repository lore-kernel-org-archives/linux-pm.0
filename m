Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5AC361DB5;
	Thu, 30 Apr 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567964; cv=fail; b=CoL1vycgCzSLxulhbufKtM52ZG/MeEx8KtVfxdHaGCuuf6tIBVRaHilGEuRgopG+o1JES8ae7GZZNVMPwnaH9FpvyBqkMTV8HUJ+EsdOJDZ9YCA/UW3TxPw/1nc+fWjepZkgPBuIq0NXUDj9NBdMQj8Pt5OSUWgrhrkwICQohEM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567964; c=relaxed/simple;
	bh=NbyndTpcQ7Ic3+bn4ZvY0x1sj9qptHviTnYBppmISd0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sb3K9KOlUziPRJs4EfoRv5J7dbU1wDvYcjvjUOJauSkOarqGJREUaNj//KWlsc9iiEl/V/lgwY98NzAvlYBSxe863urx9vWd1It/UoQd0Zk231uO1wNNg+fqPDnsLcd+M+PvgtxgKuSPApz5k33CM0qvUNBqOIUTqApbnNM+cwg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dm+5csB5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dm+5csB5; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dm+5csB5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dm+5csB5"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lH8QBsDEyw4dKzIlPbcfb9srr1bYEdZJlK5nQ6fs9hHI5LNzwbE6Th1l+9UolaNIaP4F1r5uaz4ST19xhnHga+cTN5XHGfpy3FluOy/044TQix0+k2BhMt6Q3/pslaicBj3u6ReTk61zvfnENanigiFsgYCrU2ELZpfUB5uSd0eQnJfGKdIS9eptQimHZ7FayjOXdFleGO5AHD5ih+ix1MXWw4UinM2LeCc7jTPw6tBjwdUenC0mJQxgKkrGu/0P+OwXdd+YQAq/5uJ6yuqH4jRi6GdWebiLORO2BXN7CVUpI9rhyyaVpiKNZgnPdOqnPV4PkIwGPnjwLs1KJrcanQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4zjTQywTSUxqekJVBpHpR4yVIDx/t8dwT7vB2+hnMo=;
 b=wyeYQ+a4zL0NLg6+TSRvtE0OxsuQyjuHJIHqnFQfiI1Zj2f8/LQeDKQDgs88ptACpdr81Y5vry4Z7cNOv//r6Xd79QCcEKHuRB+6Qh5XxhYljJ2kU2+Ibbsj6sig0ZzYE7YJ9m++9kWyn4vcMqJlrYpSPOZlZMdM0mTW0lLeHYJVQlzX9vOuCcC4jRDd9miDtUOa0IZLxWSPNdRT+/93plxr6C/DnCqRm73sWBtMShvS38lSCg5GXyNGe2YoV3loOIBQSfRlS0H0tMpUiwcfDs6wQPgXF7IY5MjUtOvROrG1m1IGH03S5J0ttLiNQJ6IVhtM0EnO1pTBFCXz1peC1A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4zjTQywTSUxqekJVBpHpR4yVIDx/t8dwT7vB2+hnMo=;
 b=dm+5csB5sxoyoGxHdmSpp7IoKZT95F0k2AEuQZi8r3K+3Gc+k4DkNFS4QfIynbjFUmzUYbv5zS1nZ8hOsdBRUXBcC0kkcU/dn0UBqaW5mPsyWgYFDXKBYklCR8pA7bZ7y5JqQ5mNCpXlmY3tDupFlQkmXt0a2OoQiGyxzsCmx8U=
Received: from DUZPR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::7) by VI0PR08MB11268.eurprd08.prod.outlook.com
 (2603:10a6:800:31e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 16:52:35 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::1e) by DUZPR01CA0056.outlook.office365.com
 (2603:10a6:10:469::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 16:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18 via
 Frontend Transport; Thu, 30 Apr 2026 16:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2pBy2/DSSEys6hRDiMTsEABeJdOzuTHq20hf+otFVvNQvKFEviF6hjROLUO7X9j2SdDDYFjxP5RnLPhejTuVHDqNGs9xaICTUbtQZe3hBSxytf4puoq35Rbl1ScOhkVEOrRkjjuYauHzfsVwdTfP+WMa9mgUHZg20cPGwq7qLeBTBo/348Ds32n4RuKTqHDBgXGjrDFRPSAzhnlFM1SiI7o7LyW5/nOi1jJ4OUe1/DmCoqERMrCzELFYxZITWRqtqNETEhy23geio6pqn6azlvRMch+WFpGXlSvjeeHD5USMtFhPok8B9G31BuW+N5TouihkYhuieccfR7lr+v1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4zjTQywTSUxqekJVBpHpR4yVIDx/t8dwT7vB2+hnMo=;
 b=ipvZQb8N4of8XYJIa2t4vARp9KEthB8q6DuSdA/9RkKR3Xjy/GPK/QmYz2/x1Ed9ryO+aMrMcIe0E8YiRmKVDW/4WO1rngG1Wy/bvjwXb5zQeszcf8Tvvng8hk9R3ZxLfC87RaNww2c4bd5EG88YuFlo8ZioQclaudFYDFVxvwzJiUfBdwzQxxd455LvWlFSghyBBCNFKG9yImDb2frw3FWcr9H8QZiP/Lfu1cEG+MfPXeuQsoXnCRsWyw52u/TSe9Uyv7WyvH6D7Py80SdtItuVnKXFJT0AkF4cmcgydYA8wNjVFaqorWASBf3EzdenGZie7TZwwXgmUrdFCIOucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4zjTQywTSUxqekJVBpHpR4yVIDx/t8dwT7vB2+hnMo=;
 b=dm+5csB5sxoyoGxHdmSpp7IoKZT95F0k2AEuQZi8r3K+3Gc+k4DkNFS4QfIynbjFUmzUYbv5zS1nZ8hOsdBRUXBcC0kkcU/dn0UBqaW5mPsyWgYFDXKBYklCR8pA7bZ7y5JqQ5mNCpXlmY3tDupFlQkmXt0a2OoQiGyxzsCmx8U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DU5PR08MB10636.eurprd08.prod.outlook.com (2603:10a6:10:523::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:51:29 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 16:51:29 +0000
Message-ID: <52b98025-fc66-454d-b75c-d784b8836836@arm.com>
Date: Thu, 30 Apr 2026 18:51:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: CPPC: mask Desired_Excursion when autonomous
 selection is enabled
To: luoxueqin <luoxueqin@kylinos.cn>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
 sumitg@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430092250.380996-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260430092250.380996-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0371.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::12) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DU5PR08MB10636:EE_|DU2PEPF0001E9BF:EE_|VI0PR08MB11268:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e025ff-76cf-4b2e-cbe2-08dea6d8e089
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 CRNE/9LA+0cTjS3pVDq5Xv70DWFjIi9ZBMhUq8PwsM/tt2dcFGKeb1RXjhQSY/XdxuYcydFTgg/fm5EsMVEI5qTT+b92flrthrQ6o7KQzEw+30wxbFuoadm/va5HeWwOvIpbtQnT/oueqvXvK3xhi3wKz5gUoUD7b3jrTlsXazd3eEfJw8S8d40c8x0BNC7/4F3KZlXgW5Zc0qa2f+l+T07v82etSVkLRntmLYIBHp04cEV48+0IsY3sZGfwZihYm2ytZTdw8ScLPy8AG/UHbti1XWZKSIR9/wyFB9GzeRsaF76gaNS+Hn6CXtnxK8M7c1+iwELwq510Bt5X6Op8weewHSzzoUnlbSg3lyFo7mAP1n6eN+DW2u0/GGdQxDReNaFdz+tC10LrszXZrgR8jw5JiKvuuS2OND/CwVQP3tj6y0nh+9FXfXw5Y9p2MK2ff7VfbUzorvTVXb3mCUAT7UGe9YHs1dGeOhsejVkbsamdNAMLMp/54J9xT/kkSO9NvuQ55Pjn2QgKXYduETBBcXBipj86b/+na5o6wpkzfQWAxZaGlLDfCwo+PjaYhIxUnyAdF8IBAitK5EJ7SoD4sRkqz2St6HBwh9NW8THAyit3W5c3B61ch1GO3MD+lIO78GAlko+QJ69+Xhc+XoK2EScI4EBMpvIQNr7ZxbSl1BzCK3uF2dsNwV5pTcN9GOyTsiC/OhsSOqXYPmrRfdKEHpZg+mEEbCpEkNqABzaOC6M=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 gYIduE0EQqSOB//DG7p6BeQmiv2tUdTjzUZ+ON3c7qIelKSPN3xpGuslw9jLfJbenO8U8g2H5DI8vvFZxaEx0aEFtRg9xdx8aJZz7qpVqlPBlmutCzc4YumF/sKYertgVdl2Zfi6Ql7Dug7R9WfprxL7KbtTKyfWXsFUtH9RXrTPr0NDs6iqakRcaN/HaY6XUdcoTYJiScwBbiYXybrLa07p2yU/3HsEtii/RU50R9a0eQGXB2VgAv7K6SndBd/CiHJZ/0nCDTDmQqWeRXFaOQu6lRTFBAt/D49yERfLtuSs1tAqHI4u8DyhBZFhDYDG3N6OYPtFWr0VtE29k5AYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10636
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b62abb98-3b4f-4fc0-7a14-08dea6d8b9b6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700016|14060799003|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m6/q3WAx8KSfoyvMRQnY8LQo780hQtTHCE4yBH8FQMiPDKBic9b5qG0xHRBE7nDc1CYzsKYjLJugn5sVloAw3uTzZyxtLOPZFv6Bhqs+VO0Q0SsxBt+iTgZhh2mbJfGmTcYfn1Ax1krUCremAFDKoWzZKQThXW/XFUI0/AMwSknAG7VK09E/4Xy+aQO6a7AM18dxfcqZ492qKWKQBEYwa3apab4lsAF8gQiLx2R+BUF+dE7IZU37ATreInwW4kfYvz4FiS3ZlftP/KRgTGpDLZJguX/QjTTO63RgwFDLb4AoR8zUygIQEeIPMN+d4TPTC4eCkC2NmB4DjUBjbhItxATEWDTaGPf8qogPAbb/IeKUHUwPiXE3PZUiKLLxsRFzmraIs4PWyJzdvPfNyscFRj9ixc/GWr6I3+hIGP7MyhJmlCGV14Buhaz1lxCEkWCN7jHYt7QzgajN4IJUGgP7QgndfJlM6HjTTQIfedRfaWyXGR9iiz9c6jevPtHgaPKCVQ2E3RlD/Vs+xKvgP4Ivs3OHDicaFvQIcDHTyihgicjvE2uYPGB2qE96mb3OxvDOrKz6STu87GkE7j73phuYo72eEayB1DSO7aapmUcFYfmVoImQBTGiRdlcnD64vcfwRJZYnRWIuJrQaoeJloy+DiNWrVCSBvLVb9leO6JlLPJvY8F4kAt78NYDmCaTSnHjFRKpR6pVcgJNB96WalQ+Jd6SJtsNdR4bXGmAscq1UL2T9jds7cnZnSnCbZh1Yn2DePJ2MGbdLRAGl9d4/oGJAg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700016)(14060799003)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XjCIv6Yec97L7dTbXFQsxSN62LA4JRKWi6USiL8xjTuit7jeAplXHAew3tFJaChz6ytVEoq/KoTnCUEzfYyTXMvVE0KJsjvU5DHHdi2VG3mC/kONV9RHb9ROOBQ4971onPKGul7gs7E27MWueSdW/epr4lKcceXGKAFnnF80Gk4XdOwZQo6WLFZh0Ufumdf39sZXzEAKxjRmRmY3z5qItDXjjV8Vpi0sfhlLtMPRbUR3lnoyMIiQtSsOAybg1yVQaM8iIxhYpHfst2gx2vVHx3T25ltKT4v2/bA6PMVKLmU9IWFtENxeV4vxhhBxdgNqi6D4hzaTrg4SFusgBKF4p0Xg8idYoWNxTwpBxouVqdATOf3IPYcHT8MriEcgwC4aWA+sd05nUYQg/4vO+/Arp/KD7NkjgG42fAx2C8573rjHGxAZexlUQoPvkbsmTXK3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:52:34.2481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e025ff-76cf-4b2e-cbe2-08dea6d8e089
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11268

Hello Xueqin,

NIT: The patch only modifies the cppc_cpufreq.c file, so I think the 
commit line should be:

"ACPI: CPPC:" -> "cpufreq: CPPC:"

On 4/30/26 11:22, luoxueqin wrote:
> From: Xueqin luo <luoxueqin@kylinos.cn>
>
> According to the ACPI specification, the Desired_Excursion field is not
> utilized when Autonomous Selection is enabled. In this mode, the bit is
> architecturally ignored and does not carry meaningful information.
>
> Currently, the kernel exposes the raw Performance Limited register
> value to userspace through the cpufreq sysfs interface. This may lead to
> misinterpretation, as userspace may assume Desired_Excursion is valid
> even when autonomous selection is active.
>
> To provide a stable and semantically correct ABI, mask out the
> Desired_Excursion bit when autonomous selection is enabled, so that
> userspace does not observe undefined or misleading values.
>
> Writes are left unchanged, as the field is architecturally ignored in
> this mode and write attempts are harmless.
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>
> v2: update subject
>
>   drivers/cpufreq/cppc_cpufreq.c | 40 ++++++++++++++++++++++++++++++++--
>   1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..c7444a6ceb55 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -982,8 +982,44 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
>   	return count;
>   }
>   
> -CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
> -			 cppc_set_perf_limited)
> +static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
> +{
> +	bool auto_sel_enabled = false;
> +	u64 perf_limited;
> +	int ret;
> +
> +	/* Get Autonomous Selection status */
> +	ret = cppc_get_auto_sel(policy->cpu, &auto_sel_enabled);

Would it be equivalent to used the cached value ?

cpu_data->perf_ctrls.auto_sel

------------

Also, if the perf_limited register is not supported,
we are not emitting "<unsupported>" anymore.

Maybe we can keep the CPPC_CPUFREQ_ATTR_RW_U64()
macro and replace cppc_get_perf_limited() by a wrapper
doing what you want ?

> +	if (ret) {
> +		if (ret == -EOPNOTSUPP)
> +			auto_sel_enabled = false;
> +		else
> +			return ret;
> +	}
> +
> +	/* Read the Performance Limited register */
> +	ret = cppc_get_perf_limited(policy->cpu, &perf_limited);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Desired_Excursion is architecturally ignored when Autonomous
> +	 * Selection is enabled. Mask it to avoid exposing undefined
> +	 * semantics to userspace.
> +	 */
> +	if (auto_sel_enabled)
> +		perf_limited &= ~CPPC_PERF_LIMITED_DESIRED_EXCURSION;
> +
> +	return sysfs_emit(buf, "%llu\n", perf_limited);
> +
> +}
> +
> +static ssize_t store_perf_limited(struct cpufreq_policy *policy,
> +				 const char *buf, size_t count)
> +{
> +	return cppc_cpufreq_sysfs_store_u64(policy->cpu,
> +					cppc_set_perf_limited, buf, count);
> +}
>   
>   cpufreq_freq_attr_ro(freqdomain_cpus);
>   cpufreq_freq_attr_rw(auto_select);
