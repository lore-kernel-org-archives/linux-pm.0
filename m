Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5733A63F8;
	Tue, 17 Mar 2026 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743405; cv=fail; b=bOIvnJXEa6N3dw85zf9XcnwBEqSIah41x+1ffChuIf7odn8CoKnGViySBh98tM38e9sokU+v8ChfApBPW7eNRyW1hnJsnPMzBCQAey34/XgI87pXHPomNsuCjEHdPjvAGgO7jTNUKfwUXdtxEQXxJT/6Ay9xqqEI0rhqcXB7Cow=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743405; c=relaxed/simple;
	bh=SvJ7lnN5LwzvTN02ostoTJVUBGGAW6iLj8BIqj+/kZA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LtL7QIzGpmxK6dDBoTWB9FQkpZDmSN3FLvAaFd6EGbU/cbWBC/hG51bO0JGmUfTbHUeP9x4UXzl/9F7pDVo6ZDaDjAN4uc3onbVa5Xnq+rWNNEYs4EwxukuuA7WsOW5lo+hTsKXScTsFbZui+YB0ZG0XIB73wqsREfPFBXkTgNs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ALJVwdMh; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ALJVwdMh; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ALJVwdMh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ALJVwdMh"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yCKjOg8E7QLeV/cNiaHHKSEhYBwEycWdRnf4b/M7ztA1bhDEEivyvq4ZvfuPdle/1ckTR9kFQXggpW1jt9WGWxOsRQxROpVUzmIcnM8qVX4pqyiSnjkNcrZSPS54la+V3wrlfqnQkdN8+/U1vd8dGH0waxm/Tkk3UVpA9WIcgfIHMdRUVYN2oUIT71SNKOggk8dtsZPT5aNfVV4oWZqVVaj5BWkYiw31W/bqbVrybsQ5jdCAo80GDXk7EKs2XMkOmxfXkDXCQd9UII/KxkjWfGMV267Oxgrk/WOK9KhFOBk8xzv3GmvGFJpayl2D85B38rS3JPwDvAQoKFAs96YPIA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IG+1iEQwVLhBUoRgiOiSSm+w6piu/PL/wYJsV0xEwA=;
 b=LhECgV8y6Jde9XWuMFk4g/1Et/c5XLfyIsMML6rmxfMwHWm/MR5OLGAchXGQdoDn3ivhGsH/tPXkeXdEjj22e0TZt8rnNe8nMMNHMFTO8iY/j5FsB4wV8xhYnn0I5d1ayvjldtYggnAa/LqzHlgDIe0iL2HOQ08TMcTcVl8kF4I6f3ZjsnPdbhI9dce9sQ8GS3sfZLsNhmRGZyo6FJVLvbVD5gvLpdtSdBqKJmukby6Ak1+T0n/nfkxJIE/lPgEtJr8003jDwE+vLzLwOAFqss7KLZJIU1XCP8Ra42lh8K5dW8eJdksEVU5tuWVG36Wvk5+8A9htwqtin0sKoruTrw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IG+1iEQwVLhBUoRgiOiSSm+w6piu/PL/wYJsV0xEwA=;
 b=ALJVwdMh7ygVMCh8/EysWCAtj74A1p4SYQv6ddHnDUJ8yf5c3lZNfwkjZfOkdVc4hkEW1vmAb/S+Knaq88kIf69ibklBbsuXrXdJFMTm3lxuhqJ6EewIqAtTie0cAjxTYexC8RfGful1KiL0EhWxeii69mYggT1IBM2Kn+Dkwrc=
Received: from AM0P309CA0013.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::34)
 by AS2PR08MB8382.eurprd08.prod.outlook.com (2603:10a6:20b:559::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 10:29:51 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::f0) by AM0P309CA0013.outlook.office365.com
 (2603:10a6:20b:28f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.9 via Frontend Transport; Tue,
 17 Mar 2026 10:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Tue, 17 Mar 2026 10:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFrMF4cKkssCsY8vFKx2tnB0WbWswjxhtI8OCe9y2NmBGBF6WaecRMxjnlowF3NpUuclRHmOuNKG6PMh/Du9nkwrnX6LkKgecr16W3Ui9ENefHvq7h6DfdDhElO1WUMlp3rVIjb4WNmJzNnhyPRFYKdgZhlABd3+HicN6Nx44xTUOVSJVG4ZqSojwrF08/8Te7e6MxKAlaX2DWoRmVH9GA7oPw5+mdIRxZajaNAvMuoXnq/CeG85JtysT3NZFrlcHLICW1IFCp1mvfcnT3zxW2E1EhPiH5keXXXo0dPE3PYiPDCpMXgnz5iblLthChiRfh9QDD3uMPsxjwzVbt4qHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IG+1iEQwVLhBUoRgiOiSSm+w6piu/PL/wYJsV0xEwA=;
 b=QZq61kzg/KOV2wc/8nIS78XYPhAaCiZIoJPPYC08JwmYBtmYCEDoF+KvrWnnzCIkKgjj4wX8m+0kc3XfZJzHE+mpuvdP5hdgSd+6+s9gNhroA/T82nBf6n3zL7siCPQ4DerpNy38x25xkN52OfoV7kFbi3FGbDQVVREtppAk0EVbZczww3sP+WfWWMwZl52msX8lzvVJvmhneEZexHFiWRSjEDBVXFuKKlimwaCbGPEuuej+T9SqRXwaYaxVP5pAirCwPLHVhiZc7yIysbnAF4sL/ZpqEPGQUv27CU3wF8w6NPm5XN6yq4wKgSx+18Xm2Q0pki/kSTnsJW288AXX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IG+1iEQwVLhBUoRgiOiSSm+w6piu/PL/wYJsV0xEwA=;
 b=ALJVwdMh7ygVMCh8/EysWCAtj74A1p4SYQv6ddHnDUJ8yf5c3lZNfwkjZfOkdVc4hkEW1vmAb/S+Knaq88kIf69ibklBbsuXrXdJFMTm3lxuhqJ6EewIqAtTie0cAjxTYexC8RfGful1KiL0EhWxeii69mYggT1IBM2Kn+Dkwrc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GVXPR08MB7703.eurprd08.prod.outlook.com (2603:10a6:150:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 10:28:43 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 10:28:42 +0000
Message-ID: <29045913-845b-4e04-aea3-3d680d456ceb@arm.com>
Date: Tue, 17 Mar 2026 11:28:41 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 3/6] cpufreq: Centralize boost freq QoS requests
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-4-pierre.gondois@arm.com>
 <uggew5u2bjhgfxt5tlt3bjqg7aks7oab3iqnlayol2f26otchn@2xlt74ywbln4>
Content-Language: en-US
In-Reply-To: <uggew5u2bjhgfxt5tlt3bjqg7aks7oab3iqnlayol2f26otchn@2xlt74ywbln4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0249.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::16) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GVXPR08MB7703:EE_|AM3PEPF00009BA2:EE_|AS2PR08MB8382:EE_
X-MS-Office365-Filtering-Correlation-Id: f47fff1c-300a-4204-9215-08de84101f04
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 8eQJJI02EHN4ykHfRAelPj8Pe+L9LucmNZCPTH1V4unRq+S96PZRxah7NSpNiUY11Uxjd7IHBEaRTgcZCeHm5YVBVIYV0CYFsT0Qt03c+jZD35WPbXUorcMMvrCHNveEWmScIaqqD5MKYMbu1MB26dF+0WD/7qti0LP8uNKAVmeBzV52R4wn5tS5qChrtW8TFR5sMfzLYHYRfkKrbTjB8LIEQY+67yVvnnU3f6LIAaC9GRHKB2rkc2JMAswCIyYVUxIvhc0HHZ4OszWCBUrlTLKGyYE54d2wVrAXIU0vaSqmT7MZs5OBwlymrjw8bsVmKqYNQW46o34AD+96EaIJupNzjNowYXEdqUdALs6rjDObqK5/wtIFgNqhluq/i9Anz/9LlrLF7+JEerB7WyeNDJOVNQs+F4sE1A8jn4z7qkteHDWm2e7kHrrgWXBO86IC+vbB34D+5qFGe3cDOeZk6KgpTTtdCSYhUrUhea3b5xoq1+6Q2T6IFbL8gBFYHgLY71ammRwyEZB/pm2fLmc+yZamNIdDZObV5xJWJqFaqqGnOXSkXjIk7fLQzyuhAftsVyxWfoigDn5CRS2tKxs0qOKJpson9bjvsD0Fr12XEOjno4b4jwRHfVsnZkzI121gjhCGeXArFHtBcctZS6X928uUvcxvM35q2knci3ydF6nKQ4jKqud2M8dS8oaRMQYg4OpsBZ1IeGWOhFuKy7GBWi6wOuO5DG5jd4ZeshsUE6Q=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 YGGLCDZ/dSf2aEmZRfYuGS7UrxfQk+iHsznJnhdqJnD9rOMVuTZpsRTJtIwAvK3BqXAGw4/Xg1EJM0IVRJgtVt3OoWtb7XbmSVj6jHXrlBVZe11wVvImM7ni1shKP1uPi4HJui8RexWYTR4jftJxi/eoSYCJxVmNrX97rusafX5NSx/CwYsg7DGt2G48uobo9yuoJkKh9yWha+ooOAVozWapZ92fDViT3aWvuslKuAH4PophxIz4UGtCvPz0KuVBkAe/RLpSkusvr2asVqfGJFo4QgbMe98Kd0SWnCJTB+XP1uLMt6IE221yQBbNGsXF7XNNntdDoTjUL0kkUZKxPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7703
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	40c4f9ad-c590-4e95-03b1-08de840ff659
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|1800799024|35042699022|14060799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8QdsszqbqHZIRKJBPcUJqcdLNkHrsp85+gjJKSlCvqSHkRfptot2rD4liejvgPmfUD1+3NlIzJCu/3mM8UtfEggUB3JcBJ3MD/f0F2vY+Y0lDhZMpv1ptpN3kHbPm/3AKdn7oJh9iOZGvW0y2qf0AewO/2ka3rASGR9ukonIKrWZez75Fi9tx1FiKLCiPRB/rrFo59HP9Ibg5Pfdf1Sm9xoRTO1WQvLOFuBHcE8JyDa2Wv3bSH1sZVMcVAD33dxtFSZI6ElGE8aO1Nq0IT1VxaUURj/46GggmiqFvtHEENnYKllGjItOy+fZzmN/HxtL/YpWUPaax3y32cwo/ONqBSQH6uLsK5KWeT/tNbdVyxx8z7b9S7/QLmHmtABWKkqMzzG+eRKje0tvguN5jwF7S6VVEaf4fMVeqq9XWvh6IWto1e1H4BDrwS6KANr860wi3/dacE4rD0Rq6VNrOFt6HGR6z+sN6XSJASl/2v++VF0JPatsChJPdhf3AmT8VPSeHTYxV0+GkIhdmShmLvvy5c7INPLV8olm824OcKL3+Inov5BqvhOBPKuUwDGlAo6rTVix8hw7zg2GMTy4mTIV20k2ORqoPHF8Omn7+QrPmm5mGCIzb2QA9DPENEDVBaSSHRoxNY+xy0ZDhO6BiGq6r/FCcC2w4nHNXoE4HmsSd44QDQHXtvA2GZNwP4GXmZ063gJoJBeVKJAL5oYSq8lyGKIQRBWKTTQpPmwDFCXc835DbTa8v/Z8hZpVywFZzzg4eG2/42tCOzhSekhv4C7Asw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(1800799024)(35042699022)(14060799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hk3aDUEeS1GI4cAUEQKJThvwm5hAmmKJ4JeSJOHAP7YxwLqB5ApfH3aQGsFCVhE83UWlnbnGoz0VPGbKb3vUCk6JtjrRwF1rHcit5Re4vW6AAmCQF9iaGVip7YEYC8eSDR3W+ATD8LNOEhjmI23XqYLJTDUQ5Te6MiYVsf/IHcDwM4jsAjn5IuSNDNIV/UvZMUaymtoTnxRRr5l/7KYwmUF+osrO3jRPrKksfadxfeLOJcoKDx9AuS7hE3hroBfvRKNJCimdaL9Nbfp1ffflGx59eHoHdq5ZUPW2YMINjuB0dgFdOrG3Gc5XTfog5HPHV4WlbfDVFLhDWKaIP7MgcAAoN/m/v9y3gdL2WjgjZRctgzukhz+lKhL2GPrekx88BGeUXDddWY2LnNKhdLLcuM680t3YWR4fU8+Jub363jSjC5hYg/k+frf3zFf43hJZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:29:50.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47fff1c-300a-4204-9215-08de84101f04
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8382


On 3/13/26 10:22, Viresh Kumar wrote:
> On 25-02-26, 09:49, Pierre Gondois wrote:
>> policy_set_boost() calls the cpufreq set_boost callback.
>> Update the newly added boost_freq_req request from there:
>> - whenever boost is toggled
>> - to cover all possible paths
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 50467b938668a..42de32488f422 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -603,10 +603,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>>   	policy->boost_enabled = enable;
>>   
>>   	ret = cpufreq_driver->set_boost(policy, enable);
>> -	if (ret)
>> +	if (ret) {
>>   		policy->boost_enabled = !policy->boost_enabled;
>> +		return ret;
>> +	}
>>   
>> -	return ret;
>> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
>> +	if (ret < 0) {
>> +		policy->boost_enabled = !policy->boost_enabled;
>> +		cpufreq_driver->set_boost(policy, policy->boost_enabled);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
> This can be:
>
>          return ret;

Actually the caller expects 0 for success and
freq_qos_update_request() can return a positive value for success, so 
the code above should be used I think.

> and you can then drop 'return ret' from the if block.
>
> And yes, merge with prev patch as Rafael suggested.
>
