Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1E36C0C6;
	Fri, 13 Mar 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412154; cv=fail; b=OTLBxCzMYaJxwkv5z2QOukYRdqjqftov6lcgSSBTptEnKV+UvBACYLW6u4tmIXYb9iAOxZR7MFMDGdwDu7Z4etg03yQP/G9gkiV3zsCu86BfN1Y/VbuD57zWsHyNzYglRmfLWv1Hhz/RPH5k90IkNaa3iRJNEHnvFxn+KcaBEkA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412154; c=relaxed/simple;
	bh=t/f0ImKNI+Zr3/6OweASbou9H2In5iBvbW1DXhk/N20=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bLtimBiAV0Mgs+9wm8MEy8EpZ3UUqecARuzDW1SjVZF66ZP+aBX2K5FhXdWsXNFMUKShctw+7RuMX2xtDTQpn6r6oD184t+4SJpZyLbMPxX79zY/ShB7o810UGWLdzxNdLd8qZnOvtPV9PG3IdNNqotnfyB5U5y2b/zGOrCyJ2k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H4qZwVdj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H4qZwVdj; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H4qZwVdj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H4qZwVdj"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=krqSAyNCiUxU0zmWmcC0vG2Dmtd+tp+IXRjvSAvYIxMO10JxoZbnorDWgShOO7Xn9tVhaSj3JR7V5InUoSnm/wKBn/ViU4TLXsZ2BvFwrUKHKL/P/cNmwqt2vVW7IvalbI4F2eDrU36ZAuCRj5aCYOm7pLYU8+XV1U+j/Lz/mTwXwQNdk6Weo3kI4PrnmDErj/vuXSCRbumAD5392J0JyUKiOZXHbSO6PfY6XjDsNmddzkW+ayJ709+KB3mSL86bm63Swv73EH8hDuVxWbdGPG4AcCEJIbZ8MbE3urE8IBa9lX33D3ZEqX1r9s2+8v1nHKXmXNMnjKm7BHjSYwFG9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fh1mX+Jj8pAAA6lDYzKP9HMt+Gw6qfloBIgtmPvPdQ=;
 b=Gjvqlbitigj5vVggPEpDOiN73XNu40fYUMdLtC9iPNnrmzWRjCwYCp/E4pXUiR0ERj2Z73pPEheDlByf/WYoKjX588kPBvBo8q/xUeCwUabwhgPKZvYvlsFZcywRURCk3z7uXZ6kwIvnvjMfrAvnWv7kzDK8JnDkYJoe9NseflS92sN+CRcdfY52C/uK3Z6DhEBjx7M2YUuttF0xHNnKaZ9LTDV7jWqQ0lHAWXocvXZfAa7HgKZlNUVAQOmYXWm7k6ntX5y42ndtORlFaDQgqazKLPLCSL2Y0oF8vIs/oWpct5DRZpqmJB8pJ8UfYaY0Ry2K3kxcB6ogZcAf/ps1tA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fh1mX+Jj8pAAA6lDYzKP9HMt+Gw6qfloBIgtmPvPdQ=;
 b=H4qZwVdjkKOzNAdJAaCe/yWVGoPHe/6mTub69zb6JQxiB0c8jMEVW9jJi0QOML03R++3xn6EwU/hQ3ruN7yt0ELJNe7/Xwo1wnycPy4J1H1JV/h4GkjT9V16AOk/VibKkR3G7IfQvnIzx+etzhUCch2h3ujCdY0n95i8UE9mmB8=
Received: from AS4P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::13)
 by DB9PR08MB8202.eurprd08.prod.outlook.com (2603:10a6:10:39d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 14:29:06 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::3f) by AS4P192CA0003.outlook.office365.com
 (2603:10a6:20b:5da::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 14:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Fri, 13 Mar 2026 14:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbIyyIr0Hd2XrtAvicQsoMEraJ5sKjf3qNHJKzfx83apACRy5S5RpwVAsSgRwldZuYpDEALvMiGk1QjPWJBfM34UJng1qxegTk/mSmKBGCKk2dMxl7wwMoEeJjRkDBlCx5smSbcKTSCJ3KHkZFJFnVlZiw/3TUy0dsQlEMtf3z3mWKqag38+nd/lvcl0+ychxpR3akLTM38PxJ7y7Tc0ZGHf2Nu7Bz77zq6ZuCI7Sexn4+wSNlDo/5lUHszAh186ymaHnjucwh/a1w1KTeiuu5F51dqVxL6aHCKW23WPKgN97M9V3yS/oh+hfJplMVYdAjqsJVRBlOk6XPLfX+b4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fh1mX+Jj8pAAA6lDYzKP9HMt+Gw6qfloBIgtmPvPdQ=;
 b=DP9xUZf5cicj51r9EaROpvhAHnxLMhD36D72oQri27YaBSMVxqG7MUUjUdZW3noRfWJ0o4ihCslwCOJhygfjF0ux0BYLfM5VHtNBKHr/SWO880DkOA1h2phRHRUZDTlRqu8a+1b/CJf0ZinQ/m/Taq0L07hMTIwQYD545YN2uRCarpUscEqRO2uEINPZPRxvyuOIchxQQYVOngELCbntFvrEvDPOsb6Um9Ol5Rk/AWBQwPlsLho0MIQ7fmEkDYJdf4ECUZy8mBrM4G8BX0sstqB9W/RXdwWkgOHBohEmF3WuigO9oRH1SM5ca1hiQx4WIcm8po4qDNXsCU7GGlw8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fh1mX+Jj8pAAA6lDYzKP9HMt+Gw6qfloBIgtmPvPdQ=;
 b=H4qZwVdjkKOzNAdJAaCe/yWVGoPHe/6mTub69zb6JQxiB0c8jMEVW9jJi0QOML03R++3xn6EwU/hQ3ruN7yt0ELJNe7/Xwo1wnycPy4J1H1JV/h4GkjT9V16AOk/VibKkR3G7IfQvnIzx+etzhUCch2h3ujCdY0n95i8UE9mmB8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB9290.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 14:28:02 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 14:28:02 +0000
Message-ID: <9780dd5f-9c44-4348-94a6-3610a4b35222@arm.com>
Date: Fri, 13 Mar 2026 15:28:01 +0100
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
X-ClientProxiedBy: PR1P264CA0072.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB9290:EE_|AMS1EPF00000046:EE_|DB9PR08MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c93062-1d63-42eb-cdc2-08de810ce212
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 xXb6s1a0c3F6+IVu7FSxwp/QKKBXNgXII7Tw3E5r9cQU1odiQGfmX26bOfDbtAQG+2nxphsZy4kcE3SR2QA4Ug8Pr5njm+ExU8UyqfIBKv5c0BEbGethtWNnU6FbbmfSrCSJNGi18NdfT0wlyDzi/jf5/iyKqcqotEkHUWFI1hHMzwFK9P1U99onurR7unIcXG4K9YpEieIyUr3AI0hfANwVphFkP4JK5aXU2ZKyw7rsvvlPZY48MINMucOwCCeFNIIzjGMNIKMPk0299PznlFTRzL6rY0TEdlPJPdFeN+Q7CIuMbSX6TPCWe4Nfg4A0i5knbuPEsGf6MXa8JttbShEfDbH6+5LTpNyQgHxfcI1sUNsNEQn++0EhHkeruEagkLkscSItT7N8+ppHTX/SSo6deOl6YergoMkW74YsxamAxEZcLHuIilKbTURu6omLnXFh7ZlLaEjjiBCiLgbfUL60zpUxXRpA9loljCLBTN5PROJbR5urwHlhg0Stn04Gmr4keMRqT6G47NOXHIijX/k7EKlvSx4wNiAqrQC/taVLiJz/uxikgQYgU78Ye5WUEF2RUCoJL5f+RmNgg1Nr2RJEXKMc5QJcYUne4hCccnjVW1c1gqHyOwQ+u1aVVcR/U0gaOWnXa9wCwXMs4PAC8krqNKZd/GhLV/CIJnLOCMeVw0Ysi0N3BVu6XbG3T4TcDcg/4RGfeeWHmYNUvR8JZSa/AwMI7NIPNEG3pAkVnLI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 qCIkkR1pt03gTyz+rkUoKCrIJGUYb2J1gQ2vKiARLOKKqSYZNmZCV1EorRzqlREctIacjpqPy9QFQ4YvwaJVhK4JlDrIbLHQOw+/3rvEI2Ljq8MSMbW+qoUKKq71RPRMKgkFLDPQ2QBndB8gp7/RkavuVhrDakIg6jqkn86mUedBBhIYEJbw5WlN35P4RDOD9Q6emnsGXOFp14rfw8dERsVQg135/4pk2EKQ9AGS/Gzd6xxUCY0s1jSDSaFWxMMNOv7T6JAjydmbnuUhxJVxZ7hh9X8HPnYDIAB4glKzTG2Wz4jKoO8qD9g/yBOMD3VtJ5J5TM4NhPGchAppnvXc9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f3b8c813-9692-43bb-c46a-08de810cbb72
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|82310400026|35042699022|36860700016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O4dKgKN7dEkinVlULq4em66bFC04XYEm0rsDwsqvqwitslvaSl9V1SD1l5hO66ERDTCnZT1ECdNULHHozn5R232uarbpxXz7rigivsxjtkYlPiGWN1hZaDr9eBiuww07JyhuaC7F3/A678V9h9OtyC4hk2tziaOcRP7WA3pereIMdbSqnzotwmlwLsAJ8ozMxepUQ0iZuwZUojbdO08r8EXjPWdt4pO2X95qfYJQStXXU0sJ8Cp+yiveN9ZWxs2qGy+V0IPD5Psr/aCfTo1M2SuypLgIEZYKWtbWgwv26yrMcqhqupUz6xKEyBex4mkUalp5G4Ksn+Nw3myZJXMcX0uR2+Np1kWxrbDJUsIlJdFiuHRQvEzX7vGvgZmo26ifBbrMwcw7lYDziRNu+TI9/eeWVBx3bGa9fknUKgHY2H9GKnTWGoij8mxri8R8bilWXc8XqIRFvuryZ8LwulGzJZYfrSgLj1r0/kHKOByqRyqajJobMu/2uTcqdKNMYIm0mhIdu74E9ApXP4/lKjmeBfjRrDBwj815UYLgvDF5mEhLtORf/S5F/dqFu1/euNNap+wRMTwzbgHteocoWImSCfopYJ2xzTpbGv6J/JXRBJf91pRH+Ui5oVWc+7lZxeIi+cBfWTnQHYJIucmyJ9OGckMTd/krULiQ/iK12mHPQUxH1LRbNmmXtTDr+wLejpyZL6StUe9yNx4YR2sVzL74eq4ubiwf4IQ/XHlxl1mbHeLbbJrE95iLA8AOGS0LFQHI5gVJ2dsQyGLueQnOInlQVA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(82310400026)(35042699022)(36860700016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j1mooaVrz+3YstWzdKFnDSdd0juWgDKsr87sHYG/JKkofT+9psoRlNGYI6n7IHC9gpxk4NofeGcR9t8kiB6nprugUJo39LXDlLNtpqj1eW+DORxAMYSTfNxwI2asnsMb2ASJA0YSq1FdKPoWul5nxdoeaObCHLoWBDEkVbfAFakPLhmFb3nXTaX5aIECfhJ3lSfktPWdyHnfJMXydehCJs8NiZzmR+R50nMzgS0iKRaWaDy+gVhm8Al8h90OGuWR6uDx3YqboyCWCjB0mF9C9Dkh5BqtYH9jOctTR0LoY17BWSpQPXND7UGiO5zinkxOFd2kqx/wBdoByQqF6XgkJZ3yrObY9H5aZbo8oiW5yYMVfBOK9RTjMwGyO0BbGJo0VQvPt+q5G6wZqBMA8ND1WE+1Vms3+OUFAmrONV/N7MKB6y3hOlQlz4AJoiP9DN5J
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:29:06.4669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c93062-1d63-42eb-cdc2-08de810ce212
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8202


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
>
> and you can then drop 'return ret' from the if block.
>
> And yes, merge with prev patch as Rafael suggested.
>
Ok sure.
