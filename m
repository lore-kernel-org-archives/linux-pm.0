Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F93F7884;
	Mon, 11 May 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507843; cv=fail; b=lTQdXXA6Fba3/UqY/T72lUNk5DY6gKuB8KWg6Bmk/teDBRJO7x53PNDZnIGU/ocVPWQeQAUzqqvgdBOr78/jqDIgw6+tBo0mlgJ67APpuRTjZ8qUXtnv1HL2GQx/NaimAXBFT9vsOEGOHpHIdj+eRGpH5XQCE3aD6C/ifw3Pwjk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507843; c=relaxed/simple;
	bh=ZHXe0NCRBNKtm3thTnhN7BwQb7lBcvc/8WEDtcdGSx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2Cn9wJ0XxbRA+0WRliLoXoOZnb5pGVu1rFXL6KJn9cOU+MUtfx1/wb8t8eWE+2A8aTvvyvsSaOHPiGroPhLXmYhYY1rKiy7DkZtLJacq7Huguk2XJou7//WAnoDsBYY4RqnOp6ZdrfM8zNzJZeNlgM8+lr7tlz5HBcoGbK3Wp8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=R4mjQmne; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=R4mjQmne; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="R4mjQmne";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="R4mjQmne"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QucZpCVR8SduOewNIsPpkXKlzBfnomqpR35gzy6LhIx2CtQJSAmpm9Eke7LdMjU8WiklBCo0Eb/JRAG2QEDYme2cVDCM/fOgK+aSwcy9mhOZnLil+Mm150h2m4PKc0v5TS1vNyzKHL0tbgXKCBHs88pPxrbTPDgAt1OW7x5t+G4wSxthiSxoiKWgQVy+JsVB66/fNNVNR/zG9gwzKB6hKu6S0tg7XNE4XCxZpg9kbidiUm6yQ/vrav2XVQSnW6r3mUu9vghXNkWcXKd7hqpcVe4iR4rujCvnL1ja0rWdriko9fIXbjue86SO5rOL48lrcO7FKws8HYODTVQmTdcp7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07mBho9YxL11rQTqCyrNbOO+2zuIDQPjoWxOoQyMjik=;
 b=eCDs4TTq+k4uZYbvOX+ANfwpKdjrMBt+BGDkebfXXnDxhYBvWjqoC8tlMN45WMozl+qf/UAnR0L6aOSkAII4FjdB6SvUt3y0+lK8tg15QqGZU0HlkrlTZiulNskg/ADMva60VxksF2n018dB4ozUrbz40VxIfya4+63hH93LZqmtVejT8oXLFxf7+0W+sMAcFazIsgoJuuWs2y+NDV6U3bY/fNLyWvCM1Alv9dXfKDZF6+SEZVHpEPeUOP7F5s9uxQy1kU3XSFOo9Na6P48Ah9asymqVQa/SpzATDL5f8TZnyWb1d1XonOC8WsIOCkKEish4LzBfmfKgh0HQDdf2YA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07mBho9YxL11rQTqCyrNbOO+2zuIDQPjoWxOoQyMjik=;
 b=R4mjQmneX3xgvdcES5RomWEVmEDDWB6X5GgiPshaYya7J74mRjgfEDEaRNZwHjrYVwDZcO3UL6o/A4y7hKe22KbS3Wkmex/iYdeDyqJwBs97bFP9RLOme5vAxJY0hidsHO4wQ1Ryt+V70I+t1T2apdrp8dpfs7sZajL7oyk9mLE=
Received: from CWLP123CA0195.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::23)
 by PAWPR08MB11158.eurprd08.prod.outlook.com (2603:10a6:102:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 13:57:10 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:400:19c:cafe::94) by CWLP123CA0195.outlook.office365.com
 (2603:10a6:400:19c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 13:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Mon, 11 May 2026 13:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP5H5jAJe1+xbYW8ymkP/Av/mByuZ0naww1OMGWqrACCYW5hSvm0Lxd606PI2hP2n0AnmQBVDMgFfKz/aVkVrDZXUMkKALoKq+rChOw4N4VHFaGXv/5SPnnNnss3qfnonblvEwqiFc0mZb5kgjyO9tej81H5NdRHTBUKpStiJ+hv8tXOiF29roO62rIXdZ8IDJ+XFLH0sPdpsdtEFYj3lZxDJSfMwocrhloTUs/BhDxJXckFVuTiBfu6mDoSrD3VCgIjJ5OGm7/KCTxtDWeU0VByibGLFc7L0LwBTR99m7ZRMn/+vsLbhelkE3KukFhp6C0OvQ0J+NB692My4qAyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07mBho9YxL11rQTqCyrNbOO+2zuIDQPjoWxOoQyMjik=;
 b=TInfXBKNQaXGTrmq/OdlT0MbcaWQWMWHD4xFZZXdWMKxOMNAQfZMB92nEgdoHwjOltF1eCnO3YBjCJtajKcHB5h9kxrH2hl8zOXCz0KkT/GKrk0cwCZC61qJ4yIiFUX8Pg8h+GFf/Um44ffLwwvTNMp6uUfIMIg0R2D/zfhs77Ru7Hu8Abf3NE82cXWyMn3hnJ7wXwupWODp4oJ2S/2O13J++Y8UwlfWyv88LeDRBoRjHjxlvmizHQIXR3YKNu3YkLSfCEl5JedY5uiik+yR6H8l01BbWisW5CMuRD2MdJGNnsYVJ5lfZuFVkDWgEkcTjWINppHqLyhGSyGBnKhjqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07mBho9YxL11rQTqCyrNbOO+2zuIDQPjoWxOoQyMjik=;
 b=R4mjQmneX3xgvdcES5RomWEVmEDDWB6X5GgiPshaYya7J74mRjgfEDEaRNZwHjrYVwDZcO3UL6o/A4y7hKe22KbS3Wkmex/iYdeDyqJwBs97bFP9RLOme5vAxJY0hidsHO4wQ1Ryt+V70I+t1T2apdrp8dpfs7sZajL7oyk9mLE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17) by DB9PR08MB6731.eurprd08.prod.outlook.com
 (2603:10a6:10:2a4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 13:56:02 +0000
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::11da:2693:8a4b:1e29]) by GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::11da:2693:8a4b:1e29%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:56:02 +0000
Message-ID: <066010f3-9973-4076-9ea1-0c675dc84420@arm.com>
Date: Mon, 11 May 2026 15:55:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS
 constraints
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
 <20260423084731.1090384-2-pierre.gondois@arm.com>
 <6cq7e26levlhwh6aoq6aii3vsyjqtvp2ksymovkosfhuuunv6u@cyab7jjd2fgy>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <6cq7e26levlhwh6aoq6aii3vsyjqtvp2ksymovkosfhuuunv6u@cyab7jjd2fgy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::18) To GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB10408:EE_|DB9PR08MB6731:EE_|AM1PEPF000252DE:EE_|PAWPR08MB11158:EE_
X-MS-Office365-Filtering-Correlation-Id: 080731f9-cd2d-42db-64a0-08deaf653229
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|3023799003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 9qiKOw4Zqy86v0soHuN5OR34707PAgXsGfubo272aBsfTtOgN3WDCGC0fhgkpmlb784fdGjLDkrWsAhQOXLdd03DnM7VuTemN+99mI6boG/STaoiJ4sdWQHhKBAezxTYgqjkt+nDEAqvSMKnXR1902ulRBvjwI2WkRjk1YBk3JyX8H3SFyq7cBwYBGQ/fWf8aN7tHZaW0CpOT18THt9M/T/r3q11bDfGpJGMUmbWN9lkVFMBOkPYSwfxqI2se8A8DKeUHFVKQ8Qk1IBt8UOhWw1QTrgW6YDElLQQD4fu5kJscUIuRU7MQX9lkh4FY9QcgOE5uf5w6dQ4Mi36WTOUMPw1/d5xyFAVaXvYslyx1AuADIwPYP7wsdIX4LGwkQwAyB6yHCLoCotNKDR4HJps7krI9qnLZH2ZG25jgEjZTqt02PVZnhUR3ZsD0pXqW7HlGHBpfALCAeSxa4T07oP6i7LN2Wsaqe5eiL46zwZsfImXcDArMc4Z37rwnuLVLjDVc1QJwGL5VBSZ68Gr785mzZQZVdzRQ2ulr1aWbugnVsoGe5PnOaq2FnqD2pJ4dzWd87798Dd739Xm0j51m3/AdpNiYZyDSw1vJA+jxQx/EYJE0dzDQJpjOnY7xqwQ+BjIiBuU8Q7ZiL9pbDonQSgMB5Fpx2rnowZKR2U9v19h5FV4v6idrDMt3XAGp78lHWdfJPapC2Bhb+BZsAhuePxjZQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB10408.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(3023799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 B6oD7/1M3h5C72m/LOyl+Kcbcl33YWb9ZUrl/OceLmNb95y3X/g17s54OBRrzdk767NbPLzXaOMFKfA+uw4KC/ther4O+TJy+bXrodPLPWM+I0t5YjiIv6oOxptPke7QMZld41s0+c2Oto/+edL+EYWK7q8Bk6S+zsN7mKffkOxaTvBcf9ShcGwv9taACBtIRhUUtBNl0inFGCXSiV22dHodF0uxEiw4uAQ7Y0dYXgv6fEuZ5Y3YBfhsRa6kAFZFNSJq6i3OjiXcR0VRcpJircJf5OgtygEu4s3zEf1wZ4E8k/Z85oDK4rnM8LLYkqrC+iqp7rd+wFnTxYdeYzhQKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6731
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8b31d650-16ea-43bf-f761-08deaf65096e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700016|35042699022|82310400026|376014|7416014|13003099007|11063799003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KgO2ilHNI+q9RxeDQ3a3nk6RqXsmY26SgxcXuo0ue7EbdEQFmRmJXZZoDLStuRv5ZFagC/wsur2FWT3hQU3j8tO680FKOC6d9OFbDV12m8wRhAW4AADvu5JRPKN8AYWX2LGZt+0DqZNAETXa7RVnlKDOQwweZPKSirzqbK6ZCS8TWBVxE2PkvELTIRBrXUcaQxbTVhyHCq/yoITgcKyNto32m+HjeejTq9hWHPBopea6VySFSRV+zJByff4eODdkyD0gfS+yQgMdrjpyFqtit2NYvQnq2ur0w3oxNj8X2iTO7t+1V1YFZTHXgFl+DxLsau3XG4P+zmmFpFTTMuCXHXzB3lqQ1KPeTB3bKPAEhGtBcDtts+JFvtPhql5G4c71uptTKvbPyR+1vpFKfQA+bhFaA0EpTvbcmkVZx3054GV80zfS4KSw4E/nrzDRiEehb4ro3hL3LS53OHRBx0PG5PUAnjkLQ+hOOh24DvHfgjP3GNnkjvkYzXOeUQzBY4jonONVAZ5IRKu2lvX0l+lTLnQUsWUMHCy8yntxOlaBjhFo+idmqK2PUCPQ8jaXsbaUtgIaB+9flyeq9l9arlLe62F5QCt2sxY8xHHqmk/MCQo3hQNobGnV4+bAARqTk+3MhdK6VwXVoDPebHtmbvpKnj30ZoFWLTNMrtCzpef55T4mIqniON7c4yhRUmZedo/iAVZ8Z5iIvYkNf9OX2OSXmvqbqIZJJlAX4PNuCjPsUI0=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700016)(35042699022)(82310400026)(376014)(7416014)(13003099007)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aAU93RI8YbXlRmPFUSYPsAo4dSChqvHbr++T6YKvpOBsQdwQaOg8J8TyOHT1PqCafflA6JS2X1EAoZTzb1Nj4rlAw8gcRVHlctsEOZaRWTcaiqzRTqSQsJw9I8SpOJMwVJ4DVpXiXeVA16z6VyDCoCTusRCzDySeeP6+xkifAItNVLkif+2QQe08CXg7quKRkfK/L7+arf0UTcXOdvhafmaiUdTDVXcO/9cVEObwZafVQ+rtyI+kedFRzyVFpUKoh7wazQ0RPO/kRwb9Rb9MqacDqn9g7JQriO1AuJHVqueDPBN/6XKKgyl+9MDS66yrYY2ouPr46tbVTfHzOt8ufrNRx31h+xFeigmT/RNQ1lApc073+ztqn/2M/lU5EKqnIgYwtYt/zsGylgxhFvNxBh6lvUI//HAd+bin0aWflQZIFI6L97yIySk4xmH80VkJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:57:10.0216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 080731f9-cd2d-42db-64a0-08deaf653229
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11158

Hello Viresh,

On 5/8/26 11:47, Viresh Kumar wrote:
> On 23-04-26, 10:47, Pierre Gondois wrote:
>> cpufreq_set_policy() will ultimately override the policy min/max
>> values written in the .init() callback through:
>> cpufreq_policy_online()
>> \-cpufreq_init_policy()
>>    \-cpufreq_set_policy()
>>      \-/* Set policy->min/max */
>> Thus the policy min/max values provided are only temporary.
>>
>> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
>> cpufreq_policy_online()
>> \-cpufreq_init_policy()
>>    \-__cpufreq_driver_target()
>>      \-cpufreq_driver->target()
>> is called. To avoid any regression, set policy->min/max in cpufreq.c
>> if the values were not initialized.
>>
>> In this patch:
>> - Setting policy->min or max value in driver .init() cb is
>>    interpreted as setting a QoS constraint.
>> - Remove policy->min/max initialization in drivers if the values
>>    are similar to policy->cpuinfo.min_freq/max_freq.
>>    The only drivers where these values are different are:
>>    - gx-suspmod.c
>>    - cppc-cpufreq.c
>>    - longrun.c
>> - For the cppc-cpufreq driver, the lowest non-linear freq. is
>>    used as a min QoS constraint as suggested at:
>>    https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
>>   drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
>>   drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
>>   drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
>>   drivers/cpufreq/freq_table.c      |  7 +++----
>>   drivers/cpufreq/gx-suspmod.c      |  9 +++++----
>>   drivers/cpufreq/intel_pstate.c    |  3 ---
>>   drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
>>   drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
>>   drivers/cpufreq/sh-cpufreq.c      |  4 ++--
>>   drivers/cpufreq/virtual-cpufreq.c |  5 +----
>>   11 files changed, 51 insertions(+), 39 deletions(-)
> I was looking for this series to be divided in 2-3 patches:
> - 1st patch would set policy->min/max from cpufreq_policy_online(), if they
>    aren't already set.
> - 2nd patch changes all drivers to not set it anymore, unless QoS thingy.
> - Last change talks about QoS and default values.
Ok
>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 453084c67327f..1ed4bcdcc957f 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1090,10 +1090,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>   
>>   	perf = READ_ONCE(cpudata->perf);
>>   
>> -	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
>> -							      cpudata->nominal_freq,
>> -							      perf.lowest_perf);
>> -	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
>> +	policy->cpuinfo.min_freq = perf_to_freq(perf,
>> +						cpudata->nominal_freq,
>> +						perf.lowest_perf);
> This can come in two lines now instead of three. Similar issue at few more
> places.
Ok yes
>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 7e7f9dfb7a24c..c6fcecdbbab0c 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -645,6 +645,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   	unsigned int cpu = policy->cpu;
>>   	struct cppc_cpudata *cpu_data;
>>   	struct cppc_perf_caps *caps;
>> +	unsigned int min, max;
>>   	int ret;
>>   
>>   	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>> @@ -655,13 +656,15 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   	caps = &cpu_data->perf_caps;
>>   	policy->driver_data = cpu_data;
>>   
>> +	min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>> +	max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>> +			       caps->highest_perf : caps->nominal_perf);
>> +
>>   	/*
>>   	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>>   	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>>   	 */
>> -	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>> -	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>> -						caps->highest_perf : caps->nominal_perf);
>> +	policy->min = min;
>>   
>>   	/*
>>   	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
>> @@ -669,7 +672,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   	 * nonlinear perf
>>   	 */
>>   	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
>> -	policy->cpuinfo.max_freq = policy->max;
>> +	policy->cpuinfo.max_freq = max;
> I think the use of local variables isn't making it any better.
Ok sure
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..700abcb3e2e0 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -660,8 +660,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>           * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>           */
>          policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> -       policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
> -                                               caps->highest_perf : caps->nominal_perf);
>
>          /*
>           * Set cpuinfo.min_freq to Lowest to make the full range of performance
> @@ -669,7 +667,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>           * nonlinear perf
>           */
>          policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
> -       policy->cpuinfo.max_freq = policy->max;
> +       policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
> +                                  caps->highest_perf : caps->nominal_perf);
>
>          policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>          policy->shared_type = cpu_data->shared_type;
>
>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 44eb1b7e7fc1b..b30bfa3e27daa 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1453,6 +1453,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>   
>>   	if (new_policy) {
>> +		unsigned int min, max;
>> +
>> +		/* Use policy->min/max set by the driver as QoS requests. */
>> +		min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
>> +		if (policy->max)
>> +			max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
>> +		else
>> +			max = FREQ_QOS_MAX_DEFAULT_VALUE;
>>   		for_each_cpu(j, policy->related_cpus) {
>>   			per_cpu(cpufreq_cpu_data, j) = policy;
>>   			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>> @@ -1469,18 +1477,25 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   
>>   		ret = freq_qos_add_request(&policy->constraints,
>>   					   &policy->min_freq_req, FREQ_QOS_MIN,
>> -					   FREQ_QOS_MIN_DEFAULT_VALUE);
>> +					   min);
>>   		if (ret < 0)
>>   			goto out_destroy_policy;
>>   
>>   		ret = freq_qos_add_request(&policy->constraints,
>>   					   &policy->max_freq_req, FREQ_QOS_MAX,
>> -					   FREQ_QOS_MAX_DEFAULT_VALUE);
>> +					   max);
>>   		if (ret < 0)
>>   			goto out_destroy_policy;
>>   
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>> +
>> +		/*
>> +		 * If the driver didn't set QoS constraints, policy->min/max still
>> +		 * need to be set as they are used to clamp frequency requests.
>> +		 */
>> +		policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
>> +		policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;
> Why aren't we doing this right after cpufreq_driver->init() ?
The above code can be split in 2 functionalities:
A. Adding QoS constraints
B. Fetching the min/max QoS constraint as initialized by the driver.

I think the main constraints are:
cpufreq_table_validate_and_sort()
\-cpufreq_frequency_table_cpuinfo() [1]
\-policy_has_boost_freq() [2]

[1] policy->cpuinfo.max_freq is updated
[2] Boost support is detected

So the QoS logic relying on policy->boost_supported
or policy->cpuinfo.max_freq (i.e. A. and B.) must be added
after cpufreq_table_validate_and_sort().

---

if (!new_policy && cpufreq_driver->online) {
} else {
   cpufreq_driver->init()
   cpufreq_table_validate_and_sort()
   // [3]
}
The else branch is executed if the policy is not new and there
is no .online() callback. To avoid initializing multiple times
the QoS constraints, A. can be done at [3] but only if
new_policy==true.

---

I should have sent a V2 which does everything in a
cpufreq_policy_init_qos(). Please let me know if this
seems reasonable to you.
