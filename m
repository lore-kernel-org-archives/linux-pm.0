Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAB40FDA1;
	Thu, 30 Apr 2026 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556539; cv=fail; b=M74naJLbF2QJDI/GS3HYmHlIQqrqrrDUbY3jOYcyQU6VIxA3qo5cu1hBEa/kTIh7T/2M/j4yqUbSd1A2IbT+oW0NJV+uE2sARjbYLIWsAb8BBsh9WRrvA6OddNBSnZRqcPQocwXJyqy9ubc1uubac9K4jxWMnWRKzRNqvYxkKW4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556539; c=relaxed/simple;
	bh=ubRx6K9782Sem+bLVJUSq/2CqkxRmceeWeccJUm6DLE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cx150uDOytORB6QLkgafSvgv7qExtr3ZjWAul/FofDe89cBEnyh2d5YLj9xsH0HP02tsvYfzqHhI+v4R7m3BTlDnU+7dDJE9Z4W/LZ347FguHseRJ1f6AJlJcPZEvdpkvfVIBDpytAMg/H4UFUclBw6Iv/C7FIlA+5ln98GF1Lo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rV0xfpex; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rV0xfpex; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rV0xfpex";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rV0xfpex"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mkchzxV09Zh0L/3gIgfP1menpGR6wrDtBvOr9NZrcOENOSFf6PJIcTrUWV+vbdNNkAa6P1EUf1XL1PP3y0N61kU6Dtakc2ur/L4wEyM7v1lrDHGpbEswKE/7TQhEtkugELLFWNef2dyYGBtkem9BY3KSAkMQ0MjSiVQAukCW2WZQloOxfy/8+PGadrOrkgn0NLB13LW1Jl0yIExsVeEBMMP/F/v7S11QTClgvezPiHo3MY5GVgU1fG15Y9k1MveFh6gSmNs9XwEWERbBW5q9SNfWfJrK3GH/uzT3nd98Rc8qgZjTuWEqGP+z5iYAP4Q1bzjgzLQ96f5R9fJ7t19EIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubRx6K9782Sem+bLVJUSq/2CqkxRmceeWeccJUm6DLE=;
 b=wF4kjZ4KCpBFvEXozmt+D6v3C2m6kG71ixVc2lf9eqEKArYrjq2WR6ZczfftsxZP/WOAfnDmKqT8MQ6Q7md/9FaPM1eCU2LiJVfb8ARQl8Bh0pZXU+hUbrrTJxpzfoR+Xt609KidzRT1n5OCfjCnOoleN+TiV1eGuKF1Q0Lq7EV0Gxy1tcLhMrGE/ACKjt4ygbJjqktpdizOmcJzjFb4+aQuUrRESyEbaQYm7tIsRgFONb1dflF074+/pswpgShD6US6QUkiEn5LsMKC1x8RMjyQqo7HYoDFdfea4L+98ydyv5NUUZpd1LBCfG0tP1LrStK7rZryy5Lb6OOi8ndG7w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubRx6K9782Sem+bLVJUSq/2CqkxRmceeWeccJUm6DLE=;
 b=rV0xfpex+h+rzbqOTQ6TUYUllyPE1jy+LH77v8DkrqqjVTkH1eqo+at59WWWT3JCZF8rIK8MwzUFbVysj4YCl/8hVqLOm2TO2NIhPAFPDnkzY6VMy/Gmb5A1QF3uRNZOz3/xVQxd6mnqygdjkod/R5XvZseuhFFUFqZndIp3lg8=
Received: from AS4P190CA0064.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::16)
 by GVXPR08MB11012.eurprd08.prod.outlook.com (2603:10a6:150:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 13:42:11 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::36) by AS4P190CA0064.outlook.office365.com
 (2603:10a6:20b:656::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 13:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 13:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgLHIf3XHi7IMZXPBDbI+BfCrWJgI20F+qMpDcrJCbVWzN4QWXYC2ZnbqPWb+o9NFoiQPCbmHgnuWBRazMxDfSk7U0+myyFJOnE724a0apzhoaYZN1jSeOGLCykiFbbxrwtRdMwxOV3791ttSU86zRlWo7+XkoJRc6v9Wfi0bA3EgufgufFxNM1DwdmCZNG9PbcxnaBpkbbois21b2Bhs7VjSGxGtQNvDoUf7Ib/AMsVEGO3VedWOdyl7SKHgUiFWabcOMfLA/s5C333wMUKmBAxTHJ1cocA98sgaA/r03fhMLYxoS1FxSqmvjJbiKdkoVQxxxjDr2A8CmslqgpsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubRx6K9782Sem+bLVJUSq/2CqkxRmceeWeccJUm6DLE=;
 b=SV2RlDR3Lx9wg77dOfMeHG4AGiwLUvh5GJAUNC+J5+42PrbvCM2eC6tjFESw3HYsufLmlvMicwHxUaygPMV8kKqsGoSdj2p2mSMFn4nhBkumSbPl//pc0k/6XDU58RCc42EOzAVFI2m8jWEk8f6PnzwfYjif0lnuHCfN2VbgOkz73Xc+b8nhuqytKygvbwrIUEdBhdLvidqcn5dY+ZnSKyc8s+7wJxlTB/2KotfMiLhD+zal268bsWtyBtDb+EqfEKdFR8g7YvEwClxRhOouMQapewXkCvQEgzH4cM9UMzNK37iQJmY//AV8li9BxYFWCECiWi6ob9vqtQLwC3UiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubRx6K9782Sem+bLVJUSq/2CqkxRmceeWeccJUm6DLE=;
 b=rV0xfpex+h+rzbqOTQ6TUYUllyPE1jy+LH77v8DkrqqjVTkH1eqo+at59WWWT3JCZF8rIK8MwzUFbVysj4YCl/8hVqLOm2TO2NIhPAFPDnkzY6VMy/Gmb5A1QF3uRNZOz3/xVQxd6mnqygdjkod/R5XvZseuhFFUFqZndIp3lg8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB9409.eurprd08.prod.outlook.com (2603:10a6:20b:5a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 13:41:08 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:41:07 +0000
Message-ID: <5b4bdb55-705d-43e7-b871-d6c4bf87da95@arm.com>
Date: Thu, 30 Apr 2026 15:41:05 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS
 constraints
To: Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng
 <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
 <20260423084731.1090384-2-pierre.gondois@arm.com>
 <a7b7c4b6-59ce-40bf-91c0-de630ba7a638@nvidia.com>
Content-Language: en-US
In-Reply-To: <a7b7c4b6-59ce-40bf-91c0-de630ba7a638@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::17) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB9409:EE_|AMS1EPF00000041:EE_|GVXPR08MB11012:EE_
X-MS-Office365-Filtering-Correlation-Id: 1812ccab-c53d-4b19-3498-08dea6be47c0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 LGB98zGdlIgQHGhE5u5GrzJq8DMeFEs4/APXR9U1d58Gm2fJozoAyfGFEkNZUgxumfl7KoRdp+CrvlzNPpaV6TnrWP7hO+s27F6XE4uugZwwcD9P91LSNFR+fE0t/LgR8NpWCn1eCbs+8yjktudXxv7Z+bEUWapra4KoPdNjFXx3H3cKPzbZubwUto5SSvlk4PYYFSmEQJyGhqxFjuMSzReV+sPu/S+cnR0z0s3bSOb1ckqwKSH5Zi4ImnRxT1w8MUW3xFjtk4oHwpYWWdnSDu1MsajmLZhBGvGtKEbFgIjo/Iuga5pLPQCA/hyZo4chyNc2RmPxg+iQ2hIlJdTyjLFG3lKvbROHKI/XpBfRSe0swEA2Ovx2c4yz+uJmXvSzixtzs23N+IYsrxZmJcDdoWFNJj0ijwNsNAFgHZN9RwPwI74Vk/yOqvemaxDd8pDXlJv5mx29Ut9xviCtQ9a1ayb1yujc2fDegTUUfkpqJkSzWEMbygzENzYNLPD/GhALgfRlUU68BjfsonGLJL9Hluwri/W6MZs5T7Woz0DUrIF7Zl2nrXPq2ldxPlmkQ/ugTjadfIflhjfDa+UopCRpEvN9oLfvRz09rhvYKFBXbQhSBnrhzX/Wyh67iDnnQsGGvKBnMqDz2z347Zirgc1Wn4l8Rex7KvJw1iMkTgQUzquX+4Lkzt/8KnbDddadu4Hhs54+BFNlj5Bj3xxfS/kIHGoqhbjVNokXpJiJUxd4QcA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 wDThv195L5lN491+f4jlaXOrT9xYUh3VH6P8WrcoKqmeLg2cl5uJhJPqo34k1zkUrpGBTTDbAYRBjcidujwO6NVMTSDe021eNxqP/sV22KCTeU2bo6T8/9vp0AzK541RMSnMf0G0v4RK+iSQ9xg3fhJcL8gwcjeoDM4uMp8EuNAujmPsDMVC5ANyi/I4sjMMOp4tr04hElB/AVmcIhSxcvUnrhIDJS92Kq8dHNvEAU/Dup3/vIuLoUnyJmkG15DscIUcqYys8ZgbYOuzCZtcuhtf5JD6a3l39Mab944kPOTycSN2Zh4CJkB43GgJsRGK2A5I0YdBDAbiTdbXDKwtWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9409
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bf74069e-9c64-4872-8dca-08dea6be21ce
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|7416014|1800799024|376014|82310400026|35042699022|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	HJCLY8mmILVsMLfsZ7t35FAPGbMqeZTFE57eQeI5NqWBjwjOgojMwANtHS87TIRI+nzDgnXoxms7PQGfFLWBrq9b9VXAcg5K7gHXkNTJJ6QCmz4/yeZM/+9UtJAibF28A6NBYDDBSGgoN2yXv9AV5e1iw8+9VckCf5A1MdRFFAhtQ01ByApBZUIdGWfCA1vtIPGHR99tZqg23gSnQQ4FIZySI6PBTv3hbd7Zs4G5VLfCdLZn9Gf9/DTWtOJpLGKjEKSvkHf/4ZSMlSlrYvIURZbK2QgG7wpYtXThlLDrHddtnZljBWly3drvMUfU2cunC/7eY3mcfiF6J1QrGo0epSDe58aBJwM648SY/Uthu3GSpLA4zW9iikakrVOFXf7PoYiI031emfDBuZv09uswt/tv2jVp2o4Imlw76d659sI459ENvtqaWaNVCDzvLBsKf1aiI/CEQpdMMUZ+8P3AZVcGn6LN15KUx7/+U6hlvyByZkOcNdoMP5DMEaeNbi8pCvT9keJ6UJOZh1CyJeYn97qqFqNZoln3UnvB+BHpwP1FNaNCqYiutHChivCXJz0EjbNwitXrm1qpYa0qJjwvtt2F8/ygkxGHVXN/hQxVbHS8vzCeBL+8Dm5UrRZVrG0sZkBJDsvxKw30j/XJZfGJO0y2GnhAcd16YbY8p6MhLCHycK6AqfV9EPBYlOpuBDA7DMa+i1WlZhEFy+xWpgej7LHg4Y+xuRFzVKIhUjR1SvhJQifTKBCO2hzg8Z/fWOqG2PazlKb+c6+IsQT9xnToFw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(7416014)(1800799024)(376014)(82310400026)(35042699022)(22082099003)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PP0ZOj90Yjo2+bmzrJqW4UJSK013+rhUIMsXLRsKKyC1GiGbL9fmgmjqw0Z0v67YBTWO4Is8GaZFgW1amSjgDiNi7YgMR3fPs+Ak/1QZ7IIABSemHY63UDDYtpBqjHqqr73CDJfCYXBlaO5nCZPTRKecQ7RkoJ6caYcu3ol6c9HZ+7TM/GuRAtFE4wDI0MmEiC4j1UYpF8Dvvex+oQbqY5UodF71QlS3Vaa7dYR6XZFouUpb6vmbGSrEAiBYfJWZapbuALeIoxe8Q7361Ie698ElaT6TLjzaCZ4+aMscj+2nChyxvtrGy6knLj6gRQfqHcaXnyDgVs0agrEijAUhrJFeQhcWj4Y7tw4SUPMeXW/+Ogu+s3eVl+RHpR6/UxHNkyDYsTXy6HtKak8MljSceOUyHxC863Aq/ldhQ3PXuYxn6X7IQXze5IwgN/w7nrNs
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:42:11.0053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1812ccab-c53d-4b19-3498-08dea6be47c0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11012

Hello Sumit,

On 4/28/26 18:37, Sumit Gupta wrote:
>
> On 23/04/26 14:17, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> cpufreq_set_policy() will ultimately override the policy min/max
>> values written in the .init() callback through:
>> cpufreq_policy_online()
>> \-cpufreq_init_policy()
>>    \-cpufreq_set_policy()
>>      \-/* Set policy->min/max */
>> Thus the policy min/max values provided are only temporary.
>>
>> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
>> cpufreq_policy_online()
>> \-cpufreq_init_policy()
>>    \-__cpufreq_driver_target()
>>      \-cpufreq_driver->target()
>> is called. To avoid any regression, set policy->min/max in cpufreq.c
>> if the values were not initialized.
>>
>> In this patch:
>> - Setting policy->min or max value in driver .init() cb is
>>    interpreted as setting a QoS constraint.
>> - Remove policy->min/max initialization in drivers if the values
>>    are similar to policy->cpuinfo.min_freq/max_freq.
>>    The only drivers where these values are different are:
>>    - gx-suspmod.c
>>    - cppc-cpufreq.c
>>    - longrun.c
>> - For the cppc-cpufreq driver, the lowest non-linear freq. is
>>    used as a min QoS constraint as suggested at:
>> https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>
> Tested-by: Sumit Gupta <sumitg@nvidia.com>
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
Thanks!
There might be a v2 with some small modifications.
