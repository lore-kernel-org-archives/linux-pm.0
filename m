Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61D42846A;
	Thu, 30 Apr 2026 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556543; cv=fail; b=tsG9oqmw8iFpQZt8b3Sbl83HKrmZ+gm2O19ioXAVbCj+H2mgxi7mMZDp6EG4D4/Bzc+MajzX6zgnC2a1AsWb31M92jl8Na8QQKhSrGEov1KryzSJwhfe4ieOYmPn+ICa6MPK+MWDlYmapZa8Lm8WGIRAkxK7/rx+oghFZIFqa0E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556543; c=relaxed/simple;
	bh=Oqbls6eEbNPurB9ozIlULZFuAb1TlS9noRWvWe8M9Ak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6lXXoUVL6a19vUYJvAJhDpiErhJRGbuG1gr3dAP5si5q1h7+i/ZjD6rp/54CKkpFqaVrcTXwdj/xKP4rgQxNCgw6e4y1idP4/8QyaPRM8C1p3frvNn1ttn5S3IpxwBDmkUr+AMs7b+5CC9UnP7WO6pNKpo+Qe64tY4lIKMrEtE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xg/oByhw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xg/oByhw; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xg/oByhw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xg/oByhw"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PTQJS+uGOUbwwPl/mtxv4aQP+wkDMV/tZyv0I8LHfR+KWjzIqsOXTQ1d3T4jIhmnVKaOlaQjRPePs/N3dMorpPZU0zTYP93vwujYyfS2KjUG6epqAaibmDHjQGk2OxfaYwyBXhwSucgCrAhzilYTbjH7WdeAKDQW8Q2UgF4pCXdKEClJ5+L9DII8IYWMCbx1q4Kajzhd+cNTVvp2JoKu5j2ZPhyfMYDQipK1046ICU2mh5ILNPFAFx3D2o9uYqtU+gMxplYXHumLEuB/Ckbd2c59zTRNqwDPA9nDxB6eyBw/ENxbx3IfGLXUf8Xkhztm8iEAZIzos0+QkQ3fMpLO8w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBHqKK31tgFSJZCE9aQhpOe181ee4pzI3L0nti08upA=;
 b=KlvhonqrcwqIeqIRhUXIc0pZ/gpWOqBuGIPLJ9K2/ztTFuPiKboga2YhM8lZZ574ykt5IBNmyJiXnQLJpuWqJl7nInt5tcBgPNHvOiNw0bYcFxBIgWIT64hvAbXss2rSQL9+chMAIYArE3h7hTac3yamRfjoyDO+RiQOt3OPpcZBnob4wRTItQe2FE8E0QC0XEaraMS3aiSSFLsi615Y3bwa3j3vNmO3OsarjucaDzSIjD/YcyG4zQChMgjnkCi9nIHyPGUcArs3R5Cev0ao1xifL1mgB929iKOritysWMNLzHv0HeOFw6xg+J1dasf6JbofoI44gi0lMbaxLvUGTw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBHqKK31tgFSJZCE9aQhpOe181ee4pzI3L0nti08upA=;
 b=Xg/oByhwumedlj3eXSX3MdgGOyJ4zUJr+5xsUZNhPHVzER2FVC6vlc2sZqj8lxFmVmNRxV9MAumTcvAHTNgzM2eI9lIEub+ty1TNuhf9IYWXpkMcAtZHwMXAiM7utk9PHCzv+E3/2bhGmib1s55r1UrSDsk9SsUW8cpqBymAlr4=
Received: from DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) by MI3PR08MB11905.eurprd08.prod.outlook.com
 (2603:10a6:290:77::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 13:42:16 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::24) by DUZPR01CA0049.outlook.office365.com
 (2603:10a6:10:469::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 13:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18 via
 Frontend Transport; Thu, 30 Apr 2026 13:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEdbh1rUNRWXQPxEJ9rAa67R1pm6LuDTQY3qeOES+mljBYHOYAXRCiI5xTi4mFPbUMTSj4gt4agipZlgLChJ8rASkhJW5WSNwAK+O6Sv6AVWTG2Z6u1cLZtzzIyGxS0ZjjjR7ojdCR07eGxkIxqSfI3DuKnm0oO9pjoelPzbDyO8oJZ/Vyf8J97oR2KjKGRZ4a1h077K+ShJoZueHhVQH5hYNw67LpDdzbj+5ZO57W6N1VZAkRssOtMAaxb6B7qAu1eRwZuHzVJSkGhjvfuCUwq9ItL5a+aJKxWR8Kybi7BrUR4mYaaxLsH/c7QWAnmW4dTU/zEpQR8wb1YlKeeivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBHqKK31tgFSJZCE9aQhpOe181ee4pzI3L0nti08upA=;
 b=SOQm7rnqdJhoIXfjFc+j7p+062/T28lTi+nGxpboNxyCT/Jk5TuasrmQB6XaQ6CgrJwJKsaOJD54nfCLOx5J5Yn9VpKO3CAaCcaYxbg/v6A5K6jQevz/6ndLewfKx9t+a2GuB3Ol2yyidkOLCMXPjyZCH77Bv1si8cMzwJByIJ9r+Emnq91o/cPTiO9whIRnPQnU86j0hdErG1GXA13trSKk862Zr/Te+rgel8053GCXahY/llOvAuIZOhhafMUA+t3Fbjvq2SiFps2ZOfFDp5Uxb2HkHZashrJZXKJnj46gfV+Qkfu28dStyQmLYf6INovx98Hihn9UlmZR+Y9Zyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBHqKK31tgFSJZCE9aQhpOe181ee4pzI3L0nti08upA=;
 b=Xg/oByhwumedlj3eXSX3MdgGOyJ4zUJr+5xsUZNhPHVzER2FVC6vlc2sZqj8lxFmVmNRxV9MAumTcvAHTNgzM2eI9lIEub+ty1TNuhf9IYWXpkMcAtZHwMXAiM7utk9PHCzv+E3/2bhGmib1s55r1UrSDsk9SsUW8cpqBymAlr4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DBAPR08MB5592.eurprd08.prod.outlook.com (2603:10a6:10:1a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 13:41:12 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:41:12 +0000
Message-ID: <3efe318a-52bf-4c92-8b86-03e0bb6a9a93@arm.com>
Date: Thu, 30 Apr 2026 15:41:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS
 constraints
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng
 <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
 <20260423084731.1090384-2-pierre.gondois@arm.com>
 <73fac9ca-451d-49f0-b9c7-5ef6bc0119bf@oss.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <73fac9ca-451d-49f0-b9c7-5ef6bc0119bf@oss.qualcomm.com>
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
	VI0PR08MB10391:EE_|DBAPR08MB5592:EE_|DU6PEPF0000A7E0:EE_|MI3PR08MB11905:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d5f74b-35e7-4599-4a90-08dea6be4a56
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 o1GTLeO1HjVH9b1OAuRm9rFeBPFcxkyl5X3vtIZF4zLV8V6iwgGdHCgss/BbY2pmqTp+xBr8TY9yrkkv9ssAqJBmEz2SUEK/TX/IGW8T7kXbm7GQtK2ms7m0JfyA+m3yHK3oxNORZW7LBqaa3Xitr8DgrTyfzo+0NbD0ynnHsU6fzK2T3XAb8tjz7dQFU9/EUfmzOxd+BLmqXOe3ZrsSsda1qEkhD9OMux86V6BMCYdolsbWMyRIRwNvPUKYysAYe1gb9ghW9o/0UXMej0C+NETDI/uFA4Tq/T7M4oAHcOlPXaA76XM3ZLx1ykOUDsXaR1cHQYXxZDaDMlE/QgYOcCqSjk1BbIW2juIT4C2W4txNOtbBd9D+nUqcz1Ri/mE1aaQLY9bEFEKTuAiGoih6I3Bs2d/u0kSOUBA9iyYaz/np+XDvhin+DN2lyZaiXQpmiWik7qGVFZ0AzJ4Fzt/D7CVed8wR7bZVQSPd/tVL5UVPIyK0UxJ9b3Mo3L1/C1VyHcZu8Y3zq/G6wDRZKsjnJCdeSu4STromzOAgsHShD0JSGe2jXuMWakYsnKbVyugxNxBfOc24xArWBgmxCLtJae1TFVtB4BpKou8q/6yxLW+G1D8AedY2tPbFaz9yROOEvwO/d9VSxBUASSSVYeoH1/2rhBwrwINna5Ki7lH9co3EpHt5Y/07RLg83gs2Bm2qLo2KNjW4Eo/CChugJX3l6IYehH2mfD27S3AGw1m2PDJr6SHMbArzZ5ZpYcbqQjqE
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 GWRS4F4Wz/J9pV1c3Ltye/UZjkR+druqM58//4UlsagfOUacHmqLmyFzPoy2oPwndZrKltFHUeqwF80vVwJLo/BaVFLQNaM1rv3n1M6ga3il6T+xq6eCqLBXsnjh6IyDcFZ6MQ32dkfgG9Ye26SqQ7ehbYzPNVUet8rdmmmMNoIeEonhwUMMEoB9RJiFGn7GFsbt/GkO/5pioSxzqPJ9CqRS5t5ePb3AiM498GLhR3H1B/ZCpiSrQHjY2L7acMfH1D/Go/txcsmBO+ZqP7jSxn8BRvbL56Yur5Hila2WOnX8Pcd4GV/+muS9WhAEsBihMJF+Zx551s3yq1d2rAa9vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5592
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	911db8c0-ee9d-417d-ed80-08dea6be2462
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|35042699022|82310400026|14060799003|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q8DrfsRu5RIwVmupRxkcMx/3VeSpruK7t3uY5ShhwTR28A0HvmpMB5g1V2HUtGz1Po0IxVyS5S+fxJnukgd8/48Y7FvV0sqgSSW/uv9ccv1cYRGWhpkYZrTHuGOCEuLTDBUM90IhxH65AAASDNY+sc9wQ89jj+bOSgmYhj6y2OEObrpJhQ+L0MYAryqH8jES+h0EleM2umR8VuE7zxpEIB4t0iCiDrnaD5Ap3BZ2a8whXH1ID2ikWsoj6fskAUgaFD1sqIjPhL+x6gED10BbTd2J/ZU78xz7/V/IGjJcZgUcNrnIiEf+bX/+teHkZo3X47Vy5nwnQbFRf0cr0F4w/Sf2+Cqi1EGk+WQ8kdTuTadk/nYbG4CFW9Y3qar0RxU2c9r5Up0SqPwXWZWlXJMnXFcrIgbpaaZTYUXbgBJUjHTffSa6OKzIIfnylDs7KZlMGagUKbX8Xsx/6l/ZTGMv95zSjtmkDspcgGleN/MnG4GT19eociN1c0P6J8Db1GzAKMxeFBLa5BHeOQMVRXhA4fT/64KRALQ5NODRXxNCNwgaBumJLQ9A6G6YOyd61aXYEHB9BNP9EyxGjiJVOefZkk0/PgD3+4yyPGW2Yqy2NtJuw3cw3Ok3qD/QBVaDErvTAMK0hVQ4u2HNnjgzS/8NEqJN0oiuUHZC4iljz9gMxCvTkgXq8N2BrD4y6nEAbJLH4RfD5OY/7T8StUoJpk1JqHlv1GEe7yxBWaFojPwPLSgFVnyTme3XvsgRbpzwcIn7Vq6fKD2/JH4rRUWvx1ouOCBIz0MLzMrmZrWw534hQ9Q=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(35042699022)(82310400026)(14060799003)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iYpIt1ObgCYkK5xOSvwcs3NHLoDAyOO8nqRTMUGjEz3RjFwiu8gbryURN6Lytg8zYzmNK/pyVelur9zEnbgp24RDgMYwT10iJjnd0IbTY9yznRJN1jYj0j3Nbq7VjID+Qd4SvuRqzVMJS4IXyWlYVns8PQcfPqmovYq86LyQBdLUxoiFXODRs9uaFtaAVdJVvaxISUIoHKzvq6pg9lmxbcTdGOKNTMAq6scU+8ClafnU0JS97tRpFiuYkubNyN3PNZ84wcM9KE2eZSE5NcecH/SzXlzvwzC0WQYAs/crnbrDFbrzvlVlSZ47AkCoZlUqJK+HDqoFsDsbl9YHFDwx662M9vjlsdxWMY5CkFRI09Ybe78Hh1ijhFThuPJOqO4i3anyLyETwDsmNNQ6ApTFgLLImF5O6xMJmYcQJdzAg8X26a/qrYAaX6X+wdgf7iVE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:42:15.3226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d5f74b-35e7-4599-4a90-08dea6be4a56
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB11905

Hello Zhongqiu,

On 4/29/26 15:00, Zhongqiu Han wrote:
> On 4/23/2026 4:47 PM, Pierre Gondois wrote:
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
>
> Hi Pierre,
> Thanks for the patch. I have a few additional inline comments/questions
> below.
>
>
>> ---
>>   drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
>>   drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
>>   drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
>>   drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
>>   drivers/cpufreq/freq_table.c      |  7 +++----
>>   drivers/cpufreq/gx-suspmod.c      |  9 +++++----
>>   drivers/cpufreq/intel_pstate.c    |  3 ---
>>   drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
>>   drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
>>   drivers/cpufreq/sh-cpufreq.c      |  4 ++--
>>   drivers/cpufreq/virtual-cpufreq.c |  5 +----
>>   11 files changed, 51 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 453084c67327f..1ed4bcdcc957f 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1090,10 +1090,10 @@ static int amd_pstate_cpu_init(struct 
>> cpufreq_policy *policy)
>>         perf = READ_ONCE(cpudata->perf);
>>   -    policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
>> -                                  cpudata->nominal_freq,
>> -                                  perf.lowest_perf);
>> -    policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
>> +    policy->cpuinfo.min_freq = perf_to_freq(perf,
>> +                        cpudata->nominal_freq,
>> +                        perf.lowest_perf);
>> +    policy->cpuinfo.max_freq = cpudata->max_freq;
>
>
> It is better to update doc as well to avoid new dirver developmenter set
> policy->min / policy->max again?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/cpu-freq/cpu-drivers.rst#n102 
>

Yes sure, does the following works for you:
(tabs might not be conserved in the mail)

diff --git a/Documentation/cpu-freq/cpu-drivers.rst 
b/Documentation/cpu-freq/cpu-drivers.rst
index c5635ac3de547..12dc4dcbdd5a6 100644
--- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -114,8 +114,14 @@ Then, the driver must fill in the following values:
  |policy->cur                       | The current operating frequency 
of   |
  |                                  | this CPU (if appropriate)         |
  +-----------------------------------+--------------------------------------+
-|policy->min,                      |             |
-|policy->max,                      |             |
+|policy->min                       | Minimum frequency QoS constraint.    |
+|                                  | Can be overwritten by writing to     |
+|                                  | scaling_min sysfs file.         |
++-----------------------------------+--------------------------------------+
+|policy->max                       | Maximum frequency QoS constraint.    |
+|                                  | Can be overwritten by writing to     |
+|                                  | scaling_max sysfs file.         |
++-----------------------------------+--------------------------------------+
  |policy->policy and, if necessary,  |            |
  |policy->governor                  | must contain the "default policy" 
for|
  |                                  | this CPU. A few moments later,    
    |

>
>>         policy->driver_data = cpudata;
>>       ret = amd_pstate_cppc_enable(policy);
>> @@ -1907,10 +1907,10 @@ static int amd_pstate_epp_cpu_init(struct 
>> cpufreq_policy *policy)
>>         perf = READ_ONCE(cpudata->perf);
>>   -    policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
>> -                                  cpudata->nominal_freq,
>> -                                  perf.lowest_perf);
>> -    policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
>> +    policy->cpuinfo.min_freq = perf_to_freq(perf,
>> +                        cpudata->nominal_freq,
>> +                        perf.lowest_perf);
>> +    policy->cpuinfo.max_freq = cpudata->max_freq;
>>       policy->driver_data = cpudata;
>>         ret = amd_pstate_cppc_enable(policy);
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 7e7f9dfb7a24c..c6fcecdbbab0c 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -645,6 +645,7 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>       unsigned int cpu = policy->cpu;
>>       struct cppc_cpudata *cpu_data;
>>       struct cppc_perf_caps *caps;
>> +    unsigned int min, max;
>>       int ret;
>>         cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>> @@ -655,13 +656,15 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>       caps = &cpu_data->perf_caps;
>>       policy->driver_data = cpu_data;
>>   +    min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>> +    max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>> +                   caps->highest_perf : caps->nominal_perf);
>> +
>>       /*
>>        * Set min to lowest nonlinear perf to avoid any efficiency 
>> penalty (see
>>        * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>>        */
>> -    policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>> -    policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>> -                        caps->highest_perf : caps->nominal_perf);
>> +    policy->min = min;
>>         /*
>>        * Set cpuinfo.min_freq to Lowest to make the full range of 
>> performance
>> @@ -669,7 +672,7 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>        * nonlinear perf
>>        */
>>       policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, 
>> caps->lowest_perf);
>> -    policy->cpuinfo.max_freq = policy->max;
>> +    policy->cpuinfo.max_freq = max;
>>         policy->transition_delay_us = 
>> cppc_cpufreq_get_transition_delay_us(cpu);
>>       policy->shared_type = cpu_data->shared_type;
>> diff --git a/drivers/cpufreq/cpufreq-nforce2.c 
>> b/drivers/cpufreq/cpufreq-nforce2.c
>> index fbbbe501cf2dc..831102522ad64 100644
>> --- a/drivers/cpufreq/cpufreq-nforce2.c
>> +++ b/drivers/cpufreq/cpufreq-nforce2.c
>> @@ -355,8 +355,8 @@ static int nforce2_cpu_init(struct cpufreq_policy 
>> *policy)
>>           min_fsb = NFORCE2_MIN_FSB;
>>         /* cpuinfo and default policy values */
>> -    policy->min = policy->cpuinfo.min_freq = min_fsb * fid * 100;
>> -    policy->max = policy->cpuinfo.max_freq = max_fsb * fid * 100;
>> +    policy->cpuinfo.min_freq = min_fsb * fid * 100;
>> +    policy->cpuinfo.max_freq = max_fsb * fid * 100;
>>         return 0;
>>   }
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 44eb1b7e7fc1b..b30bfa3e27daa 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1453,6 +1453,14 @@ static int cpufreq_policy_online(struct 
>> cpufreq_policy *policy,
>>       cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>         if (new_policy) {
>> +        unsigned int min, max;
>> +
>> +        /* Use policy->min/max set by the driver as QoS requests. */
>> +        min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
>> +        if (policy->max)
>> +            max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
>> +        else
>> +            max = FREQ_QOS_MAX_DEFAULT_VALUE;
>
>
> Nit: Using local variables named min/max is confusing here since they
> shadow the common min()/max() macros; renaming them (e.g. min_freq
> / max_freq) would improve readability and maintainability.
>
Ok yes sure
>
>>           for_each_cpu(j, policy->related_cpus) {
>>               per_cpu(cpufreq_cpu_data, j) = policy;
>>               add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>> @@ -1469,18 +1477,25 @@ static int cpufreq_policy_online(struct 
>> cpufreq_policy *policy,
>>             ret = freq_qos_add_request(&policy->constraints,
>>                          &policy->min_freq_req, FREQ_QOS_MIN,
>> -                       FREQ_QOS_MIN_DEFAULT_VALUE);
>> +                       min);
>
> It seems that the current patch is not merely a superficial cleanup; it
> also changes the policy->min value in the GX driver, setting it to the
> 5% value expected by the driver. If so, we should document it in the
> commit message.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
> tree/drivers/cpufreq/gx-suspmod.c#n137
>
> /* gx-suspmod.c constants:
>  *   POLICY_MIN_DIV = 20
>  *   max_duration   = 255
>  *   maxfreq = e.g. 300000 kHz (300 MHz)
>  */
>
> cpufreq_policy_online()
>   cpufreq_driver->init(policy)      /* cpufreq_gx_cpu_init() */
>     policy->min = maxfreq/20        /* 15000 kHz, 5% */
>     cpuinfo.min_freq = maxfreq/255  /* 1176 kHz, 0.39% */
>
>   /* Before current patch: 0, not policy->min */
>   freq_qos_add_request(..., FREQ_QOS_MIN, 0)
>
>   cpufreq_init_policy()
>     cpufreq_set_policy()
>       /* reads QoS=0, discards init()'s 15000 */
>       new_data.min = freq_qos_read_value(FREQ_QOS_MIN)
>       cpufreq_gx_verify()
>         cpufreq_verify_within_cpu_limits()
>           /* 0 < 1176: clamp to hw floor */
>           new_data.min = cpuinfo.min_freq  /* 1176 kHz */
>       WRITE_ONCE(policy->min, 1176)  /* 0.39%, not 5% */
>
> After current patch:
> freq_qos_add_request(..., FREQ_QOS_MIN, policy->min)
>   => new_data.min stays 15000, no clamping, policy->min = 15000
>
Prior to [1], the policy->min/max values were used as QoS constraint.
This patch effectively set a min QoS constraint, but it should be no
different from what the driver was setting initially.

I will add a reference to the patch + explanation in the commit
message to avoid any ambiguities.

[1] 521223d8b3ec ("cpufreq: Fix initialization of min and max frequency 
QoS requests")


>
>>           if (ret < 0)
>>               goto out_destroy_policy;
>>             ret = freq_qos_add_request(&policy->constraints,
>>                          &policy->max_freq_req, FREQ_QOS_MAX,
>> -                       FREQ_QOS_MAX_DEFAULT_VALUE);
>> +                       max);
>>           if (ret < 0)
>>               goto out_destroy_policy;
>> blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>                   CPUFREQ_CREATE_POLICY, policy);
>> +
>> +        /*
>> +         * If the driver didn't set QoS constraints, policy->min/max 
>> still
>> +         * need to be set as they are used to clamp frequency requests.
>> +         */
>> +        policy->min = policy->min ? policy->min : 
>> policy->cpuinfo.min_freq;
>> +        policy->max = policy->max ? policy->max : 
>> policy->cpuinfo.max_freq;
>
>
> Does it make sense to set policy->min / policy->max before the
> CPUFREQ_CREATE_POLICY notifier, since some drivers may use them in their
> callbacks?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/cpu-freq/core.rst#n58 
>
>
>
Yes right indeed, this would be better.

Thanks for the review

