Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23643DA56;
	Thu, 30 Apr 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566393; cv=fail; b=sNrwicrbrLIfU7C7ta6Pl5aEKokcw5nLOrIy0had4tsFcmJx/XQ+DVsgA3LkNRckG/g132tqwXstvDfgWoNfeU00IOnyPEBA1QV405NHyOvm/KxNyA708C0UpCRRar3AYPWVlePk3v9rwmB8IhtDkqRh/CMr02G9//OIIInwaKE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566393; c=relaxed/simple;
	bh=Re9alRvzVy7UWChFXIUV3OmhwA+vRWpHu5/f8b5AX1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sWH38auVZ6rQargCvvdSfbLJyZzPYpCsBlj2mtwpvzSNRso5ECo5Ug65bVTE0WNSge4jBnIVWWHNuqP8Z6LnSeuZSxbr5dsnI+JYXFcETjGsHf2lYswOWuxIDiS7gVX+4/DLSXLJ3cz6AA173bMjT7Mf6DS4YrAuaRmuY/xZxI8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S+/RhCWs; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S+/RhCWs; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S+/RhCWs";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S+/RhCWs"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ii0iCY52yc68ajXHRBVBYTjcgi6ceNP+F3YpRLlnqB5FwNMabful9WQiyLE5aX0zaPX0ngfBeGlis+HB8IloAz/+vEyJmtyxme6F0/oZPfz/wbpDfvTHb9C3XvYP4YpVvol62Pp5bNooKe8UhRi5nRWiMWLAcrCIokEYqTjT1CMe9Q2j+2XlEUBGtNNlDQD0tXyNT53iTXUuE5CTxztrBSoeYuhKqCnWS78qf03+qlUfj/0q0O8splqb4LbeltphJBwErTkbuDmCGZAzxdIVnhGyFCqMaFeSuT6RVdnukw0zBqlWu8ocne7RCZ3roe3t/oTphya2+mI0yIu3doVN8w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKHswm1FoJnIx81QvlnL9P1o0U7ycpIZlyGJkix0GdM=;
 b=G3dqSit+EVtphJTCDBJoNDQsUvH6g2jkQSP48V67kg4FRgd53niALUt1dct97tG7LDnKitMcxQGwT/WLtZimMkrMVtxeOEJ3mOjgHOC+PYLyLp+vXAixKo/fCSEZe1WBjTvZZ/SweYxhWzVnd52LQmlvqVg+SNQbmPV6CcEp5XdEJfPEOxg3x1ygpe7cJ0r2Ph0ejM+4wx2CLSzKSHIIlgqmlH67cDnGVKy/pFfpKkytSoR+2SCsirKp05xJV8zT2SLWqWmOT3lnPxivJSmu0vQUs8ec7JPzT6W/98g3cN0YIwJefmqP8brKwRJo3ANmVCJ/fRaJG1BwJqtezuKOZQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKHswm1FoJnIx81QvlnL9P1o0U7ycpIZlyGJkix0GdM=;
 b=S+/RhCWsPuIr0Sn0YVSdvCUr2CbVA34dYxus4LHP5EkJydwg9IJzaISm0bU8mOprk59L1Mm/SHFK+rerZmVStWoXz8aFMqLjNlIENkZgQo48t6mmJcEO3A5GUsaWBUJBJvMrZ9wbxKAZqPXWv761I9GAMkz1nXwRhAJnd4umMc4=
Received: from DB8PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:10:110::20)
 by AS4PR08MB7408.eurprd08.prod.outlook.com (2603:10a6:20b:4e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 16:26:27 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::42) by DB8PR04CA0010.outlook.office365.com
 (2603:10a6:10:110::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 16:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18 via
 Frontend Transport; Thu, 30 Apr 2026 16:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWAEyPA8/nP9rwYwhbA4e9zw0aQN6ymbJLah0kW4uNu02N0T0Wi+teNohj7BgURQh7aCYklHZ3amsstgTdUH/cxnZfTeEjwT+wgMLqb8IxxiO8RNEgijCcYFla6ZwCNhSpBu1ZafQMwWIF8H07Y6KLr2chfs/arf+bMZQi8c4dDGLHEhySu0VPqmoTW1yKhxKZwO9QNS8NrqntqWHszMVJ81FrxA4GKMGAoDQ5VxVV9g+sX3RuVcLor+0kmwiylfxj7Nsr5yVHskv2yIIj6DlUZwWHqn28j8ZsZH90xZv0CYKINxJNJJnAgEzw8DyIOsQnMqfP8cEh/4A7Z5vlHQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKHswm1FoJnIx81QvlnL9P1o0U7ycpIZlyGJkix0GdM=;
 b=Es+NS7UaCtATI6JICVFtCM4sYOLqYO2mThWznOW0KvkI5TTGTv6SCgDLUBisYw8DlCQS84BkUFIUc8K6yanQldybvtCB4mwkGjEEIUZp99mT3MRvJfoztSJ7nb2lYlauAPE639K98itCV3m8TNElOm7mfpi1YgnTbzVk1vZM3GeBrkOD+34GZX9BKAmQDRN/fZb2RKQM6zwYWTrcWVxVtWDabjNM921z9y9djApllTgiv3wEdGJ9NWq+ZKeUHmez8ALofEvDC6aUnknJwMURsYkh5u9v9UFpMGgtt3YLU0qiytanf5JcME2iXNh6UpE/E+iSbPLo/nwRjdbKThXsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKHswm1FoJnIx81QvlnL9P1o0U7ycpIZlyGJkix0GdM=;
 b=S+/RhCWsPuIr0Sn0YVSdvCUr2CbVA34dYxus4LHP5EkJydwg9IJzaISm0bU8mOprk59L1Mm/SHFK+rerZmVStWoXz8aFMqLjNlIENkZgQo48t6mmJcEO3A5GUsaWBUJBJvMrZ9wbxKAZqPXWv761I9GAMkz1nXwRhAJnd4umMc4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS2PR08MB10267.eurprd08.prod.outlook.com (2603:10a6:20b:647::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:25:23 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 16:25:23 +0000
Message-ID: <2eff2693-622a-4605-974a-ab138c75130f@arm.com>
Date: Thu, 30 Apr 2026 18:25:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ACPI: CPPC: Add support for CPPC v4
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 Mario Limonciello <superm1@kernel.org>
References: <20260430142430.755437-1-sumitg@nvidia.com>
 <20260430142430.755437-2-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260430142430.755437-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0051.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::26) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS2PR08MB10267:EE_|DU6PEPF0000A7E1:EE_|AS4PR08MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fe3c4e-5ee2-4257-748d-08dea6d539fe
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 Sb3IC0qo0eE4tiAW/6nHU0cX+fX+Vz4/XKE1OiwDn3+72xHrW9fi9N4EQSjw3Igxkp098WVgSkY9ouw84E2FYvJPPT2ConSCtGDcO+Ve1hF5lN4aJRustmk8T9RAIKjUu7V9wlGlFEpI1LQaPKsVyV7mq+mclOKQFWZeSHnKhzvjfRTc02xUk9yQBC4EP7y3JBlAyox3Y+3TVJl1UUXtR7NhTI3jBG7mTu+XkxHEhXBt0vha2NOL7hZwQUhDRLmF2gUmU/RR4otbIqvI7TI0h+X3S+jg/uQ8VKkdQe6ioAgLV0x4onySGCQoRYVtuE+cAczFBk3WBjJ7piSsp6aPkMYsRaMwv1f8LAf4Xfu0bN9lqZVAcO6G8BHkJfvTdyX8YQQ3ASSHMG3EM7ej7V5XEAdqLvd5uaL4wOJq8RbBwA7P9HDmPqxTVoKGsKfd26fQoc3aJ+E1e7iQ9MkYfjbUr0jI7kMmFAbSs4HrCdexzhkGsy6FQLCDEJ1hxoTaDI7oYWoScleVsjQRf2k0z6usRDxSE+OB9Ic5HMU4UmQlotlDcJQu+n2DM/QgaeAGnEVdzLjFuEIFHSdEU3UcxKWTR2TJKBJIUNxuUevVr4CV4hORMcLYDCST57rRWG34/4h5gA9qunfnMiQ7YaW8azHSNKnt5C07A/JBxhhhuwR++iubSee2uxLf/eQz0dj6YK2ixH0r9BH4HT8QvqEQaCjS3BdYG3Sbtr1kJGYXVbMScegKnZ0akYNdgiHgYJ5KLoqBAe+IO0t1epawCKmQ9P39gg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 HxSQySafJ4vKub3r5eJOVMxKD3LzqUCYbH+sBaolrlRHTzIUHfTbqZwzcbnA7hnEYq7BlWAZFInPmJd8mVq2QXLPk9d5Lr7VU1HQM5vxUHkv9oXp2tEfb+H3OJLoW427YY1Mz4IgjOfmP3aiUQS8w7FjyUxO3qoSMBLRRAlAGgGsRbWLAwus9AX33M8oHC8PRVJDFNiiP6J7A/3FoFqLilIhoLTRr0fyIHdZbPvItHYAL/1e0yxKqTQ2eiXy9JYJszlWRqLXn0l/QCY7GJ2buf7E7yJumJwRzM4ImGc+KC3aTPghxvEAsTwWSTvph78M0qKGZo4xrYHhlD+dli4SdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10267
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a204911b-9818-4288-379a-08dea6d51440
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|14060799003|35042699022|7416014|36860700016|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4snO3aZu+QFL86mBxsN2RvLBkbBECSNod8NJed72iQTWuQb/JiRXvHI4QAs0gLAxNaqc6Bus70H1XrRjMFFiOps0GITn5Jc0F8N2duDKPsEolDVkWD8kgrvmXcB098rOLTL4+hLOc6W24+igNa0b6LScYCCvyBQdjhcOK2INYiu7rc+VEQ6HaiFUgahdtO39Qd7/2qmGTFwkRSXGoMaVZhRa/c4EDpmvt9QS5simB5naz81ZgoYFdiGXg89muYaMR8LG6+eeYgE7U/L9Yo/fcL9y1WdpgUSbmIRykRB2CPyCPm6PFg0/po/5FdhJi6FRnPHy/lSNtyws20rhN+QlN4KHW6v1Ms+9eXHz9HLQY4y8dfnzZIlmlmUvef9w6xYqweQTRiS2YcmsqrUZYq/dyGGuvjOeatj8JRAuJdo5HUwilRedMDOyS72DgSN7z0oGQpvB46BtljFL3EbBnQeHAo5JUCnTEhIQz9sLsQmA4wYudfdPqAVhWMNLL6sV3G/o3WbVI94DfdWYvo+/JW1g9AW9FtagJpHtts+462mhUopCAiNInf6WBJv1Ly63W1rPz9WY78wSLMdh855R4JJ8dbQtyI0YkDpizEcXyVqlSFFCEOtEg+6DF+d6BEfuQkOvsqw2vXvVAw+g47T4f5Z3lDhds8JTSY6ZZfczpbm5zZ++6VaSvHHkruaioTWg2WoiaQK6zw+NUR0/KhC/Q44QDbyhBm9VWOMNBofxnLHfo9PBpGxonQaSOzbNXGm6c4Jz59UIzQ+NdZ3xJ+Z+X91/hVgba6Sj7hxwnzU8aqNP5XyANGLyXugNS+Is2XbGa37U
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(14060799003)(35042699022)(7416014)(36860700016)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1WOuWWbb6L1UUoegrrHRmhPTEMPHUMoKMfhYNxMtRyqNFkxtuK/3H01pgsZ34I3RLcX2BAtkUXBDW1xvnQutl+TPKzcT6B60+igtpf+cwNhAx7CxydtJnytcu2NtwccHKWgdV4xPke+fnRXOUccyUnZKsaw+7FqyYpAXuJtbIWVs7wDnOSpUO6iyZZ1tXKPmLfVK0rr2/tSWoXcY8XC4JUyNzEje6I/4msG9CHj/ob+LknS7stJbLK+IOlozsGJ+sLNvP+EG0q7zVIbylPe721h/TLqgFYIFG2LlmrT9NhiJ72ehyJ8W4OJyFqb5jKDCaPUkgNaLrhWgzAo3E5rLSlr/X+6L579b7owDZPiQurmDmc7t9nh8SFIEzq2rg6AIDU4bxurymIMgVmdvOxU9AGfXMVz3QksV/E82qcQCLxX00kHG3BhEKobueVziR7HG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:26:26.3269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fe3c4e-5ee2-4257-748d-08dea6d539fe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7408

Hello Sumit,

On 4/30/26 16:24, Sumit Gupta wrote:
> CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
> _CPC package:
>
> 1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
>     lets OSPM inform the platform what it considers nominal performance.
>     The platform classifies performance above this level as boost and
>     below as throttle for its power/thermal decisions.
>
> 2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
>     Register Descriptor sub-packages that allow OSPM to set relative
>     priority among processors for shared resources (boost, throttle,
>     L2/L3 cache, memory bandwidth). Parsing the full structure is not
>     yet supported; such entries are marked as unsupported.
>
> Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
> mark the two new registers as optional.
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

