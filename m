Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7E3C8737;
	Thu, 21 May 2026 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364778; cv=fail; b=t1AvvwvWPXDlEUtR4Q0+KHy3J1w5SFJtLHgYuA6IB3ZS8uOrAywOV1BSwX5/rZMc2ehYqeURMJJwuIZaTVh77RP6vSEXOMu+KxNtaMogzcVzxuYbkTGdW3vfoLpgx5x9NULtXK4cUXEGoAh+XbEEd9X6LnPgAFnN8CyAr4J812o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364778; c=relaxed/simple;
	bh=u0r330Dy+qZacSkXtn4v7Ei28gN4bFOjay9WHY0Ka9w=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/GV0mLuXU6fIFniHfD/9t7xEobz2j5T2Sv7mBNINJWLrAK1EpPE4dj6YFsIPHYU2Y294+Fk3uDUb8emR64fgMreUCdIdcEzyqIYQpjgV5qcMnOThWGLrkeRwrXr0g5LqSFr6H530YNk9Ibeljr7exahU8beGKLDiFqWNR8ywkM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fGVDLWzg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fGVDLWzg; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fGVDLWzg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fGVDLWzg"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MyDR9eAC6TxBWZx+6CxLYCgG6xTw4ZIN63PDtt5nZi5Z/1LsiPQkmSPhUquDRdZA/GqyCc/QRGYjfXfil+I3doVcpUCFQxJE9QTJ8sOhN1kcMV2otmBE0NVv1YvyMMUel5jECY68Vm1jdg27yw6jDQSJDTf9749fsmErM17xot/Mn6in09kytFUK8IAbktY0v/apQ/uww9YqTsp4JQnscq7zDqzIsZqzPwXLdz4ZpLeX4Ry3uMb/FYbqKWJwymTywPGlTdKu/rV4pyA5no/v4PBnorkqC9dwAaeW4K91ADpOxuja5/O2FU1/FPMN02CLnlSrQqTvFjDtqOSKlXC7Ug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZoHky0Cf3BEhRd6XYDK8gb7FfJs8MwC2NHexjjq30Y=;
 b=g1ettkMI5UIc42JBpELvBuNaEKmrNSSbYzSflKHebhRVXYGvvHYpq+DMWsYVsqOzv3974cqcpcNRAdgB9v3a0UDSvuTBd/riw10g0VLQMqDwMu/RSyXK0MoFAm8AwwbxxjHpAF1S1uwxzsqKMRiEI/3+9H4zXbN74g70Jwb0EiUABfonW4GfOD1PTr5B31gAK8YQL1a1P4UU7/vgnhmPYvdW753WH1wB5/d3L9/zFJKVX7N3rwh1G8YtUm/xyPrREBCaViWyGPfgjtdizAAO5+6i35MzOtv40Tde6o66nQZ7V3OneZ6mj80zmok4NqOifhD/kDXyjXLPeQYVM/ae0Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZoHky0Cf3BEhRd6XYDK8gb7FfJs8MwC2NHexjjq30Y=;
 b=fGVDLWzgtrTkGzvxTT200uGsUmR0j0sF68mnR1mGm6Qlfj6oEiqBsj//uficvQcuKHrOQluPiZEi2UryCQ8971ATciAsBKG5GWmOPZJPwQv1BYBVkx2gXytD73zqCRbilVoLPTW5LiNptWgo6xC3ZaVeHCa085oitG9jejoic6w=
Received: from DU6P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::23)
 by DB9PR08MB7817.eurprd08.prod.outlook.com (2603:10a6:10:399::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 11:59:29 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::e1) by DU6P191CA0019.outlook.office365.com
 (2603:10a6:10:540::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 11:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Thu, 21 May 2026 11:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmLWDZXl8qpfG1iYKuu8Z9zDFRjIpzfPK++zvFH7afiiyInYHku4NKkhTOl5itEbA09x6x89PZxVtIiF3vEl9ilIeHAxOB0oQURxb2aJ1q5dD3LlePL6sVwrZHCDNuG7L8Rnoo3FeS52Tda0qyzMOJaZWQEmPNMMQ/8wK1SUYU8EGylasoXAUsCsBXOHRZbxzTBaJmIUyJRdZDYeRvwxA8dsaAm77Xm350NLUuCunqPandnVeqe874X0d/IHhylmYKFSa25t5AA8aMXSZZISvoMTzgqndDPl8MmDvLX7Ly5sVu+0p/7G5v82JMFyQAZOerELzeVmYfi09GrHyexB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZoHky0Cf3BEhRd6XYDK8gb7FfJs8MwC2NHexjjq30Y=;
 b=A6Uu44by42Iq+a0g1vFQFrzsKLRaMdaRUVDnwQkO/FynkY7VFCm/ngr1xFTJIxiyFWT2NPqy93T8z+ugBxLlmfl8EKPVwmmeV6mvSAe3GZCZ6TPleIMZCrO9VytNi/Lx/bmWFMf0G05nKKsZ78/7bOcNr1wjozCWA8UCmz9v1dpVdcfUAXPJm8rhF1dFBwE79ITBycb3SsWuKkcQdJG3QssVQ0dbvlkPMoPzskk56hyNXNh8r9r4B4ufZmQT2BDqySIqbHvsAUbVyEbj4oWb7qr5z+oyVxpri+Fo+Ke3PPUN6mDdI6CQbo49vabh/g9lyXWqZmyPD4s5M6tEqxzlKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZoHky0Cf3BEhRd6XYDK8gb7FfJs8MwC2NHexjjq30Y=;
 b=fGVDLWzgtrTkGzvxTT200uGsUmR0j0sF68mnR1mGm6Qlfj6oEiqBsj//uficvQcuKHrOQluPiZEi2UryCQ8971ATciAsBKG5GWmOPZJPwQv1BYBVkx2gXytD73zqCRbilVoLPTW5LiNptWgo6xC3ZaVeHCa085oitG9jejoic6w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DU2PR08MB7344.eurprd08.prod.outlook.com (2603:10a6:10:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:58:25 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 11:58:25 +0000
Message-ID: <0df47687-d743-4be5-bf21-488fcafc2139@arm.com>
Date: Thu, 21 May 2026 13:58:24 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 4/4] cpufreq: Use policy->min/max init as QoS request
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-5-pierre.gondois@arm.com>
 <05a5a8a3-7153-460d-86f8-d2be04062d6b@huawei.com>
Content-Language: en-US
In-Reply-To: <05a5a8a3-7153-460d-86f8-d2be04062d6b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DU2PR08MB7344:EE_|DB1PEPF000509E2:EE_|DB9PR08MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce40627-bbb8-41db-9149-08deb73069b1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799007|11063799006|4143699003|56012099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 27WpRFofMta+xGQE5iM65dW+xkdg8mWvjPfrjN1PyVagu7UScM7EsPwE++WbaRcCiFmFoISfU3B2Rc6V+cQqnYdoaedIlnor61wFsMrvl+CehS81I9DCiQ+ieiIcZ0BIcWprwGVHN9LxrJRas4V17pgNcUeichO+B5A6hHcemxu0T6ILCaOyqrxjr22jsSh3y6A84fY4y0W4FgoPGlt3qSAnsWNI129WHplsG0vKguJs2YdhebuksZeFW5T95fz42CdrLVJ/oz77YtjK6VkZ5M4NGshn2MOFGddl9/AtoqeixAbZ2uPH1kvZ6h9Ukn2YJ5zVgCCZHK0wL+bpES8fTLqGOdXTRdRd9PnT+3oTaZFBDa+r8KKGq77w8YSKGyZHRshLtOE3X53g2ARFwTtKaEuOWRCUxRK/3WVywrzbEAbJrhk6qr1gWQuHOtuihr2ozwnoYmFZGgkJLd3iOsvSP8To/Gw/ghOIApWpLc45IaBv/8WrtGckc6XPQZ7cinB+bHPW5sX324ReyxZGQV4sbeMS9PdWXilkXXAbjcomKHyFFngdxcGLCtZ5XeDdnM931jblrWqcCquXydlzIYqBhhrLCKZEaQrq49gzuzlgpUukHeZ9CXKYuHageedlhmhYVRZR5pBLInZnVTAnJubnIfMbKuzLEyVOeIIzlCPd0lPGG2/XZY4yuWQ2pEXA6kkJ
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799007)(11063799006)(4143699003)(56012099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 CflLJAsyVjJR1aU80T9SpI+62RUGgS3kMy/CyMkxM+kBEpcqjUFojT6N4FiRNtH0JkaWW7XEqcEV6pxumVss7PtTT3Bfm05ZYlB08M7wUGsbTn2bkrEC8IKa1cHRnWgAzDNtwNji6lTNx/YDtwX18bTV/DCWugnmST5A6kEJIhUwKh4IJxaZQmEmDK3XYpKkBPrf+NpVKiScfZr6QRloCRy+aybF35ouTFOZ1TsbU6sfvSTUjw/Bp4/2Vw+W0GP89bONOI46e3De+K6Bx6r6HKVLDpezIdpfYuxfBaYTQd1Vf8XWoyd0inmrFIRozESn28IiUPoyQGc+gY9wI9eigQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7344
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	78ec5b48-9433-48fb-c1d9-08deb730439e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|82310400026|376014|7416014|35042699022|36860700016|18002099003|22082099003|56012099003|4143699003|3023799007|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	SCkUXAKrvB2oWFfS0JP4TmqU0yXqRYdyy4xFFdQ7i+tJGxXHR85AHYGg+ZTaByK9kLFjqBWKszr0RKnp18nXSrxzrYsQ2XI9KdxAF3FiF1AQNAMRlEfZJiX/tBfWAinROD3T50mPJSIdVGZjQIjYv16X5u5cTVDl9J+XgcEw2NkZQuCRN9VypedFL3yC8wbrlpMZItLfrzH7V/oyyZRglmE+U/13/LZIu89bq6iujjKLV/h3WtU6udO7DbANV+Fux4NWHRY4aN1X752C8Gl927/sQJO9wetda4hR+YXYyoOB7oJnp8AI7K9jBuG13DQSE/3kAUfH2XLNkoPuquSPJrmCnlzTtXlM3aPvkMImUdqoNNYcMVieY9eNmwnK9h+oDiqcqvtDoFilVNvvyczEVjLSHZZEZv8LYcu+MU/QDZBRiDA1wG1xxCBwG6qLUi28ZrHeoZapyhL826e8QtRGo86COb2Pxi2hrljYuwFDB42kiAJrD/NFPUjO7Q2pQr2AupJpdb7EeVeGaZbVxmdhAZyjhWCjbF4ieyO+V00iStv4waL7ZyYD38MR1/o7487d4oFJ0BFGMFlnv2ZBllF2obMCZ/1Z5VL3Ld7UO+0CzqdJD5Bqf0f74FQV/kGzGSSBm+p3yG0HhsVnPbRUdTOnXX9BgP0okpJYGq8upUc4mascPxDCrahw1OQNunKU0CLgceyUKA69ANOC3yB6b6vSNAJEnXqSgxXq0HEgkw66b0s=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(82310400026)(376014)(7416014)(35042699022)(36860700016)(18002099003)(22082099003)(56012099003)(4143699003)(3023799007)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zP1jTWwKs6Cc9VAssE5WzZCULxuVzlLGDMlBBnkwh2aal37UzT+qYY4rCS/IAWQUzxpuIzyg5kZmtSV7aF9qrl9RpTb28nAzfzo6oIBRSJfxPSn5Ccm2A4jNXhbC1r3p2xYkpjopACiDMt0x46oGc3tVw1bmhi9ud92X2nIPQ9HvUueYRU+FjU/3NfakYx79U04nRT7BWlTF4NoNfgM5FztopMwCzPG8ACvVGjOo9vkeX9ba6g1hVnEbHsRZmjjlHgOcqQoYibIyMNsrzYi7m1ZNiG9a9VE6LTeVKqwnu0Xr8/Yl7cevYUOR3jLYTmYTGuwptyt+Wx6/MhQVtK1Fu9OXHL84ca5fzQgpsc8UFbAidRot/Kx0voWCFFs+1TIHssIOpjKdOwyi8381LE6qe4W0+XwDr4VcIuKvhQcegi0fCr3046//ybhWlMPtfU20
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:59:29.1755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce40627-bbb8-41db-9149-08deb73069b1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7817

Hello Lifeng,

On 5/21/26 13:26, zhenglifeng (A) wrote:
> On 5/11/2026 9:55 PM, Pierre Gondois wrote:
>> Consider policy->min/max being set in the driver .init()
>> callback as a QoS request. Impacted driver are:
>> - gx-suspmod.c (min)
>> - cppc-cpufreq.c (min)
>> - longrun.c (min/max)
>>
>> Update the documentation accordingly.
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   Documentation/cpu-freq/cpu-drivers.rst | 10 ++++++++--
>>   drivers/cpufreq/cpufreq.c              | 12 ++++++++++--
>>   2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
>> index c5635ac3de547..ab4f3c0f3a89b 100644
>> --- a/Documentation/cpu-freq/cpu-drivers.rst
>> +++ b/Documentation/cpu-freq/cpu-drivers.rst
>> @@ -114,8 +114,14 @@ Then, the driver must fill in the following values:
>>   |policy->cur			    | The current operating frequency of   |
>>   |				    | this CPU (if appropriate)		   |
>>   +-----------------------------------+--------------------------------------+
>> -|policy->min,			    |					   |
>> -|policy->max,			    |					   |
>> +|policy->min			    | If set by the driver in ->init(),    |
>> +|				    | used as initial minimum frequency	   |
>> +|				    | QoS request.			   |
>> ++-----------------------------------+--------------------------------------+
>> +|policy->max			    | If set by the driver in ->init(),    |
>> +|				    | used as initial maximum frequency	   |
>> +|				    | QoS request.			   |
>> ++-----------------------------------+--------------------------------------+
>>   |policy->policy and, if necessary,  |					   |
>>   |policy->governor		    | must contain the "default policy" for|
>>   |				    | this CPU. A few moments later,       |
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 9e2d9d3fc5351..9a005367ed87b 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1399,8 +1399,16 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>   
>>   static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>>   {
>> +	unsigned int min_freq, max_freq;
>>   	int ret;
>>   
>> +	/* Use policy->min/max set by the driver as QoS requests. */
>> +	min_freq = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
>> +	if (policy->max)
>> +		max_freq = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
>> +	else
>> +		max_freq = FREQ_QOS_MAX_DEFAULT_VALUE;
>> +
> Can't see the point of this. Why not just use policy->max and policy->min
> to init qos?

With patch [3/4] "cpufreq: Remove driver default policy->min/max init",

some drivers don't set policy->min/max. For the max value, we would end-up

with a max QoS constraint of 0.

If we were to use cpuinfo.max_freq instead, then we this would bring us

back to:

521223d8b3ec ("cpufreq: Fix initialization of min and max
frequency QoS requests")


>>   	/*
>>   	 * If the driver didn't set policy->min/max, set them as
>>   	 * they are used to clamp frequency requests.
>> @@ -1418,12 +1426,12 @@ static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>>   	}
>>   
>>   	ret = freq_qos_add_request(&policy->constraints, &policy->min_freq_req,
>> -				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
>> +				   FREQ_QOS_MIN, min_freq);
>>   	if (ret < 0)
>>   		return ret;
>>   
>>   	ret = freq_qos_add_request(&policy->constraints, &policy->max_freq_req,
>> -				   FREQ_QOS_MAX, FREQ_QOS_MAX_DEFAULT_VALUE);
>> +				   FREQ_QOS_MAX, max_freq);
>>   	if (ret < 0)
>>   		return ret;
>>   
