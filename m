Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4635F61E;
	Tue, 24 Mar 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352472; cv=fail; b=h2ggYHYJ7dv9GtAARmmHilEgoBPjPbrtQpvelriMxBBo+yB8pjpuZ/glfB7gkVWgKg5xHNlnGxO26V/llLXraiQ3RA6iIg6IeI6RTqEx4VlZwEc6OHh6tg3WkOMJUXNK3NHM1oAPj3RLkIwGrGgyhboQep0cAoijU5nIsZcXnS8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352472; c=relaxed/simple;
	bh=9YICpHLuy/qTYZYbjIVbtcI/WBwsybhKmycfhXxopeg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Az3s5wsPsT3w2fjJYsTZX+XNI2Dt9zsLMPxW+heGeOVWek9hC760zfMvHcm04giylvo31qqHZNujt7QA+dV7jEJ95QmkLo2tGXDxy31M0sIUp6g4YR7Uupn0lYpXk4XqSq/245yZZa8Kiyi8X6/jcduRzhTU943dVXtXE7F45TY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=paTfN52u; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=paTfN52u; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="paTfN52u";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="paTfN52u"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=U8YRrCW6g05spW5eQq4EYTUAtYUlVCnEXdTs/r+Ftcv3yjwBDYabqe5C03/C+HVvGTw+Aeklkkmt8sFm4l7Gmh+M/w3fwJmUsn/GaGMJgBZj7ZN1ERniC2LGyxMImNc+CKUzqAa79ft3cp7/0RnJoQ7aUOHJSLw0qHV4vop+hi5ZfYR/zvhZb1IrvaKroIAJvxHwpZORETfvftQiAp90AdXi0b70NBQ8iA6ttBjkBUJXdSC89+DVhAGnZ3E7Ur4PCqS+227QgaTAz9/STe3Uo1h+tAC9/jk1ynTfC0RcH74wIqZ6SEUw85W7nCwAv5aA4d73fEkaufVkintjLIWbeA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxrjJFIZ1zx7x5s3UsG6ZIY34Eg9y7CoV064emNc5J0=;
 b=Rf6hmbJvAaQsz93gqYWtvnuvJDeEaPI14IRSNkskl93oUUs3qVey3j2R2+WuZp3p6Fzc5KXGVfo9B2D+4y+rHs7E2VLr3NSm25JOezJWNwr+5cR0/LfxkfCc2UqBofbliD41oWJig7ucqhqc6Dwcg1WvtcD2PGP4+iyevm2mfZrYgwfvd8QBy4oln//s2Z+TOGs+OztMbHk7I8UK7mY/dd61PPapjryHQGHJNHShpqHBPzIiKCFf7xWtcaCnKywDuIBwWR8I/gx1WWCGz05mfvF/3oRRRelVXZ+pNwpgHGm/NNhQsYNQdsvR22oMoZcjSGkWHtxLmOufjnK/dZ1ypA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxrjJFIZ1zx7x5s3UsG6ZIY34Eg9y7CoV064emNc5J0=;
 b=paTfN52uF4lIlEx0QbFAWDNd8XIYoY81aZLHD+6J7UBYCLv0PqvFafnfWW2QXUaqn2orulXdXvJdwvH25HS3NirY1Wp9kGkYJFHEBSTIK0w0k2Y4fBFsWKjOYL9gfYYRzLsXCLccuV9rcI/s+nprCsp7xpXyKudQAI3UhnTLwKE=
Received: from DB7PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:10:36::39)
 by DU0PR08MB9488.eurprd08.prod.outlook.com (2603:10a6:10:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.28; Tue, 24 Mar
 2026 11:41:01 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::1f) by DB7PR05CA0026.outlook.office365.com
 (2603:10a6:10:36::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 11:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via
 Frontend Transport; Tue, 24 Mar 2026 11:41:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt99LemKlsA6bETUwMy+hAICj3Nj4LgDQt9HVg0eFaRHus2lAXTu/rMKo9CE2sDS+dbNGdR1+xlWoWMAGqhQY4g29Vfc5zEBam+nV6LOaXXPh5kxnZi0sDLX8Le8gajZLFDJpfXR6PUc4DYZyfK0BLB9jmtYYZsWXZk2KIeLdqzE1qH8VFex/bguBTXq4nVjCmbBJxQrCIj+bVT0kbVpop2bBsh2DXrkVqGIXW3vGlmjJGitqwo0ea+DZ60ZJIDlI6iik70kVL8XWrtbqgrzFYui4tmjXOL7j94115U0uNXAPFQtWe5k2LrpyqGEi2cRB+yel1J/eTTX0r+U3xBL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxrjJFIZ1zx7x5s3UsG6ZIY34Eg9y7CoV064emNc5J0=;
 b=Oc/cFlwyoN7eS/X2q/N9HKeyKbOtQnYmHieAEaf0AHYbLzOvsrJDv/VYwgzzIX4byxRt54mdds9lWisaIbx3bja/wJURmlTLobp4TBI8Dej8zVYmzGV0DbMS2cTGVyg7dM7C0G6DWoRPsRK/xb0ugXH6EjPaMFyRZeqfsBbU5V2a1lxPByFDfwvLogPgf630//UOMx5LQ6nIXku6zWaVxz/0yEujtJULfXinK5Jg1kx/1jnGq5giaD7x+GhUxrH4EGvQHutDCkdcWBlIuIxDnQCc2/nHQh0VJ5zqibbZ62RwHSKcZYt/jhFSbsPxt9+SCW01T03KlyCCp3cl45u+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxrjJFIZ1zx7x5s3UsG6ZIY34Eg9y7CoV064emNc5J0=;
 b=paTfN52uF4lIlEx0QbFAWDNd8XIYoY81aZLHD+6J7UBYCLv0PqvFafnfWW2QXUaqn2orulXdXvJdwvH25HS3NirY1Wp9kGkYJFHEBSTIK0w0k2Y4fBFsWKjOYL9gfYYRzLsXCLccuV9rcI/s+nprCsp7xpXyKudQAI3UhnTLwKE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 11:39:57 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 11:39:55 +0000
Message-ID: <86aab895-5945-47a1-bc58-12747c7d8f48@arm.com>
Date: Tue, 24 Mar 2026 12:39:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] cpufreq: Remove per-CPU QoS constraint
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org,
 Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu
 <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-2-pierre.gondois@arm.com>
 <46wu76e25pscn5tkes6uabtgsqxev6wvi5pihrlozobyadmuqq@ffvqv43nys23>
 <ad23c89f-776e-4788-88ee-08583c0aadaf@arm.com>
 <5ulxqpnblsbxhcg5m2rfscrvkokd43wwg5sihml4oytcsswh43@lqdwn5tqopf3>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <5ulxqpnblsbxhcg5m2rfscrvkokd43wwg5sihml4oytcsswh43@lqdwn5tqopf3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0013.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::20) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AM7PR08MB5381:EE_|DU6PEPF0000A7E3:EE_|DU0PR08MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 935a5e93-a721-4dfe-728a-08de899a39a4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 a5/Lw5HAVuk5/b72j/9KSnpT+EYQPHT0gwgN2eth//OvkDjjufL9Sm2NWW2s5my3CtbYw6mLRCNjF9DRAbR8Ly3bhI/2X3baNrMVEpYAofbIqKb+3sGgDVWeTVK/w/mAadn6dG1yPx6AiORI6gSCv6AOGzgOF15AsEymdyPCIY3oCEMvL1llRR2mBFVb8ongyEMuXxI1Nl3oXGHMMoonj1b8+er/7FK6DTJAOokwwRcFUAaV8Qd8ObeEqYuJW8vM0RZG7iesy6y8CSb0moKdTjNXIfsNOaOjoH6bPYTonySGVsADx1qvdsJ8+b+wnDktUhvJxZMrni8i9zDo5ALVsIes6Iu0U0t13cTVjjEVTyAHvvnFwAfJ/1/SC1let4cmm9DyW6e7I6QG6VyGX2hm7c6yTXnxVaMR54HczbnOKfwpgaYy7eueIcTRHqNVmmEhZfVeO4Fz5NoGaqzIXIQP+hJ589ANPDFzYU0KLxk7+aw0hAl486eGrpQoHolK1GqfjT7OAtrL4I88FqFjkWIj5VNmOW4VVSalrwkC8Of3s/7q9SbfOcMTaDTNUJCeNI0UGXzT32/XTHeOKh0Yi8m7P6KWSvM0arx/RrcOLtxYjJKn/MKeaxCib6szFiF6KOd/8PfFHmRMGtXL5St0MoLkSMhpk9H6L11NS+h5MFa16LwyOcOOiC4vPcftLvM4L4PIddciA641r8fiUTkxWnf6/U33GSyRTGoEnx/tWdVx8bE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 kUByh2Velb2LpykINYqAQgEY5T31EJcDE9PO6lJF0+mWYoUMoE3q4jbB1prN/3c4MwsskKojBKd1dQ0hgf9wuaWfZ0m3ZviR4uR1UbEiWuz33HbKhNjGnzByrXOrXXSKZxLgbzev6int6DB6hpWsK1tkhJWM9m53GOqUnajWUUaJsanPulNKPJEE/ExIYroBk59cmw3uxDC6QsALekA+1uGJwntKfbpMQGJ+txyOmmrXiyp7/4LL0O90fXmazV6GGOdW62ySRH+xydxs8hoN+cB/wRK6BMwO5a/xCggJydrQYYrgFZimzj3F0m1B6KoAXZ3CT200RqLGL/xD3X/WxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d72d5ba6-3f6a-4b4c-785b-08de899a11f7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|35042699022|82310400026|36860700016|1800799024|376014|14060799003|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AC8ILbh6gZuOuvgKNeyyiLuDa3sfdxmOOuWy7yrGPmTy9Ic+c6/YQsiL49sXFX/rTwC9qWPclSA3kmS0sKECMNrcylRJNBQrw1Rl3CDAqjJi/ow++CNHbneP4ep2Jr1VvrddQvtN29xmEVlnUCW04uIpm6pRZOl2a152kEYeajfE4Wt+3+c/YZTi9AzVj56ztnT6l5ZgLpxAdz52wBFZy1JEuaGyWSwT0Lv8HLSxKMDdXfWNe1TUmI3LLZOLg1QNCnmNfdqorOtt0hrKfZT9IoFIfNQvojfR+uJmdwjoeYaHw/VGFaYQp1rpRSWEyEAqLTuIBcN6comQ2QFDCFO5VqoubjCCkHZpQO/zqi9zd0IQ0Nv9K6+CTEC2ByNhBCoKPq/YPMDrK4nBOhGkftJ+YcuWAteFA8zDWaUTdVhHTdFFdiXdLz5auZOqs78sNKpetKcICMUcFfk2CCCY564GfRpKfmIj5Q46P4L4H+ab3x94lAxrkBoXx/mKN2DEDI+nqATa7i9EyQFlD/O0KsLxdWZvNWDu44qa9VDXctNmaVMeu6G0usAIX7ynI13kR69EsgWTcJyjUUyFyqOD6rXFh+P9TB53V6oPebTBsAh4qRwSoK0Giooan12JgUoHdcv6RfYpJ/FaxxA2gAwtKdCJNZo6pfYZYlNX4sTLrJMmVd+7tboWecPCQqCSAZfFVZlnM6NIlW4R0ZqljWq3nkydmZg4HdkGUcJkaicHAB8dEJtBVqNwdBhK4XvKe4mH+f9FSo7+UjO8Nxin5oCXXayFTw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(35042699022)(82310400026)(36860700016)(1800799024)(376014)(14060799003)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nNWMRtVsZ14WvfhteTcXdk4LH0sLrnwo18SHRnsAlGhbQtIFiEr5mdD/ZfaoIWu6R+8lT+FEO/4rveprzowspbzQDJvwTZv7u7pvHa20A3lSdTxmO7xvmIMjvQIUAPLQTzMQVdZIOBx2bwYtZNiGxIjK1EsF9VcoNJzM4OPosvyTlnAdkZ1pqadq3MH/9QgPH2qRPlr3smMZnCYZK8XTmArokgrmRJWHs2sccTRM3exSeQu3BkdiDPVPewQvAWZRreyJVay8Ob4mg/YXquXkryCue+rpxXxFgwdNlWq0BO29nOHeCRpxJ+vvjHDySF7uCpCAXa2DAkYIIay+7ksYUMjf1Fj1MqfSVXwc9BB3/UcWYRJE6moo68ZI4/cevWY5wdln8qCzj9h1SknamFPSaPxJImvaKTswkiYxhQi/TpWWLNxd8pJrj68xU2nQoADz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 11:41:01.7144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935a5e93-a721-4dfe-728a-08de899a39a4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9488

Hello Viresh,

On 3/20/26 10:18, Viresh Kumar wrote:
> On 19-03-26, 10:30, Pierre Gondois wrote:
>> On 3/18/26 12:13, Viresh Kumar wrote:
>>> On 17-03-26, 11:17, Pierre Gondois wrote:
>>>> policy->max_freq_req represents the maximum allowed frequency as
>>>> requested by the policyX/scaling_max_freq sysfs file. This request
>>>> applies to all CPUs of the policy. It is not possible to request
>>>> a per-CPU maximum frequency.
>>>>
>>>> Thus, the interaction between the policy boost and scaling_max_freq
>>>> settings should be handled by adding a boost specific QoS constraint.
>>>> This will be handled in the following patches.
>>> I don't think the above is required anymore. This patch is removing stale code
>>> now which isn't useful anymore. It has nothing to do with a boost specific QOS
>>> constraint.
>> Yes ok
>>> And it would be better to know for sure why this isn't required anymore and
>>> which patch exactly fixed this issue.
>>>
>> On a kernel based on 1608f0230510~, and replicating the
>> process described in the commit message of
>>
>> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
>> a CPU")
>>
>> I could not see any issue regarding the values of:
>>
>> - policy1/cpuinfo_max_freq
>> - policy1/scaling_max_freq
> The commit message (of 1608f0230510) is confusing. The issue was discussed
> properly in the following thread.
>
> https://lore.kernel.org/all/20250120082723.am7rxujmdvzz4eky@vireshk-i7/
>
> The problem is that policy->max and policy->cpuinfo_max_freq are incorrect after
> the sequence mentioned in the commit, while max_freq_req is correct.

I experimented a bit more and it seems the following happens:

1. boost all CPUs: echo 1 > /sys/devices/system/cpu/cpufreq/boost
2. offline one CPU: echo 0 > /sys/devices/system/cpu/cpuX/online
3. deboost all CPUs: echo 0 > /sys/devices/system/cpu/cpufreq/boost

cpufreq_boost_trigger_state()
\-for_each_active_policy()
   \-cpufreq_driver->set_boost()
doesn't act on the policy where there are no more online CPUs,
so the max/cpuinfo.max/max_freq_req is left to the actual
boost freq.

4. online CPUX: echo 1 > /sys/devices/system/cpu/cpuX/online

cpufreq_online()
\-cpufreq_driver->init()
   \-cppc_cpufreq_cpu_init()
There:
- policy->max
- policy->cpuinfo.max_freq
are set to the maximal non-boost freq., which is the correct value.

However, max_freq_req is left to the boosted frequency, so this
is effectively an incorrect state.
Also in cpufreq_set_policy(), policy->max is set to:
   min(max_freq_req, cpuinfo.max_freq)
(cf. verify() cb), so the incorrect state of max_freq_req is not
visible.

5. boost all CPUs again: echo 1 > /sys/devices/system/cpu/cpufreq/boost

As the max_freq_req value and the new boost value are equal,
cpufreq_notifier_max() won't be called, which means that if the
CPU needed to raise its freq., it won't be notified until another
event trigger a re-evaluation of the freq. selection.

To observe that, I had to:
- use the performance governor to be sure to select the max. available
   freq.
- observe scaling_cur_freq to see the last requested freq. for the CPU

So IMO the issue was actually fixed by:
dd016f379ebc ("cpufreq: Introduce a more generic way to set default
per-policy boost flag")
which sets the correct max_freq_req value when putting back an
inactive policy.


>
> I think another commit has fixed that (incorrectly and unintentionally):
> commit 6db0f533d320 ("cpufreq: preserve freq_table_sorted across suspend/hibernate")
>
> @@ -1421,9 +1421,12 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>                   * If there is a problem with its frequency table, take it
>                   * offline and drop it.
>                   */
> -               ret = cpufreq_table_validate_and_sort(policy);
> -               if (ret)
> -                       goto out_offline_policy;
> +               if (policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_ASCENDING &&
> +                   policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_DESCENDING) {
> +                       ret = cpufreq_table_validate_and_sort(policy);
> +                       if (ret)
> +                               goto out_offline_policy;
> +               }
>
> This skipped calling cpufreq_table_validate_and_sort() completely on online and
> so max/cpuinfo_max_freq, max_freq_req are all in sync.
>
> That change should be fixed with:
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 277884d91913..1f794524a1d9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1427,12 +1427,9 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>                   * If there is a problem with its frequency table, take it
>                   * offline and drop it.
>                   */
> -               if (policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_ASCENDING &&
> -                   policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_DESCENDING) {
> -                       ret = cpufreq_table_validate_and_sort(policy);
> -                       if (ret)
> -                               goto out_offline_policy;
> -               }
> +               ret = cpufreq_table_validate_and_sort(policy);
> +               if (ret)
> +                       goto out_offline_policy;
>
>                  /* related_cpus should at least include policy->cpus. */
>                  cpumask_copy(policy->related_cpus, policy->cpus);
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 7f251daf03ce..5b364d8da4f9 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -360,6 +360,10 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
>          if (policy_has_boost_freq(policy))
>                  policy->boost_supported = true;
>
> +       if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING ||
> +           policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_DESCENDING)
> +               return 0;
> +
>          return set_freq_table_sorted(policy);
>   }
>
