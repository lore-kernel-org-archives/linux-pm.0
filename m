Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47734C9A6;
	Thu, 26 Mar 2026 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512722; cv=fail; b=QggNF1cwB6RVd0gBjMGeNCPPOT3ggv4M9aVEyGJhySjsEBFnjr+SYdhqkQEQKu23g/25qfbhW+5a/4OmQZMgGeK8iHkSBNwhd8jq7t7KqpGpjqdf92tD8fU+rfSytKdtN3G71/KFm1hiDTP6yN4GLV25GyGg1HIZkCNz0FsdATo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512722; c=relaxed/simple;
	bh=lwkjI9mCwrmUE93CP2WkxP3McEbwRcRHwb+ULYod2kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hA60V0znY8FlFp1JuwdIUeeY10C5t5sOL3EsifodLAqW2YX/JIUTbYexby2isbEXE3iurFimyw8WcWPeovTpIYrEEEzU67DMKK3mGTXNAMoRPVeB1zMce0C3XyWleJgsGTMMzJ8WQs5goYnvfx0ZnLQrgIgZ0fl3LBhLu6TEhdk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ocKHAQn5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ocKHAQn5; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ocKHAQn5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ocKHAQn5"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OWC7iGcgrFgbEOiTt34ACtzaAU5AhtZ+ZfOVLdBe/acJD7suIIbDAGdKMIU+VpC7m/lPEge5tqFw26m1iPsQqgMYMhtjs5iu7MlJpvT3shJtcGlNlMrzYnDty2pukMNNbuF5pR5Au8i6cbwULoDx3pmlLXhWC2IJCvvSFXvBBTy+Bd1IWugPZimB98aujc2UlsYfaGZYtUunnpQHisT3MEbFIl3xlRduIoFdlSYMaPHEBB1IMB4m/T4bU55irdKg1G5pcn39/sq/INLG9asaEAkkcF0xW8HUOGVoXuqMKLFueqaZEKpdcKXogTqgZKdMCzPO+0AwboEehkgnS3XY+g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwkjI9mCwrmUE93CP2WkxP3McEbwRcRHwb+ULYod2kI=;
 b=E+wmHx071gtyy7wNCMWjEzWjp64JGtomECKZXtdVVVhxYlbeRW2/Gg8IZGQ68u/Xo4mV9sGvVvBytzoPbEh5Mu+bT+5EejklgnUBTKAkCci8mYcUiLaeQ+4hGVvO6HoGnJ/67momGl4dWmmrtjfZZTYks47l0uJIsSD3mCznN97ZIfSVb33slsXXlve2kKZgXsEOd9Df1/o1aYwdW+H8H6HPATjZEv38+O+6vQRkP/4p52Z0Mm6iFLAkRwznD3ukhlD19UbxIcuHCz13daFlIDXknYuUEG5UOjsDeZXS0JxV9GJgYF45qhXaCtXsRAH9nr2dV4Gp32kiNEiRzD9ECg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwkjI9mCwrmUE93CP2WkxP3McEbwRcRHwb+ULYod2kI=;
 b=ocKHAQn5aqVs/sTGYYwj970wGyKuaGnjUTwJCBPNH83O1QCgABD1Lex3wTnZX/b5HqsOdoFqOwvZympY+e8yl7qgWIJA1ZMzhFhw4CclgDPMysxUNuQIVnYmEuAhhDnPQVlchiKhqvaArT3lGeoLevqAwDddXTfSkluiNhoF+P0=
Received: from DUZPR01CA0329.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::28) by VE1PR08MB5776.eurprd08.prod.outlook.com
 (2603:10a6:800:1ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 08:11:54 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::7) by DUZPR01CA0329.outlook.office365.com
 (2603:10a6:10:4ba::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 08:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Thu, 26 Mar 2026 08:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvCDgKpDBelsPyGW9WzH5P0pQp6D4p4f8v6YA9YLXdm+V4WfFV/TRy0FKUfkpWu8XF8Z+22sU5Kca+Q+zvVO4HNXY23mc5Mi13GF54KEU+bE6Kwi5vkXvrUZZLm5p0LChY/CdBYjwCGG29wB660Kg7cleN1NSF8rwppTmuqfvy/zt/74dOok6o5AseHASlk2DIjt/udhdIOXmcwepQIP6w6oyavjXXuCPBKSZ16TMAT1P+pgzIzASlHK0vP7iMssdiPhvHJ9W5Q8ZPEjSln8lPkzg3Y9Do487m2fvGgCABNtQUAr703tuZoxUcizhGjOx9ju4FD/FJKDdcHF8Z3VNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwkjI9mCwrmUE93CP2WkxP3McEbwRcRHwb+ULYod2kI=;
 b=uYcgv12SKQvjLcELgpDmHh5EpjBv9qJfylEiRBxkPWwcV4aehM6WcJRIWuuRIJZTR+KQsvwz8vO4HdWy9S4r/qaZ47bDhBrdPkVjcKMbMjIJL/dK47khJfgZYwYhcwlrwPE5+nfc58UFIDOecUf8cjZxEdoveS1bXJalG7Ps3HMdCXKIQJURLD515gSRPEHeOMIKPBxqSN+UWrWEGQABSyQYHqx/BRUOZ69qga5285VxokjUSJC1qG+t4RY4nXVoUxmo5YCd5cs1vNH8BJDUkbg/1iMC/m/LxejCRn/BpME/R2jFRiKSvdsanuufQRiPvS0FIIiUEqKVfVj0/1aKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwkjI9mCwrmUE93CP2WkxP3McEbwRcRHwb+ULYod2kI=;
 b=ocKHAQn5aqVs/sTGYYwj970wGyKuaGnjUTwJCBPNH83O1QCgABD1Lex3wTnZX/b5HqsOdoFqOwvZympY+e8yl7qgWIJA1ZMzhFhw4CclgDPMysxUNuQIVnYmEuAhhDnPQVlchiKhqvaArT3lGeoLevqAwDddXTfSkluiNhoF+P0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS2PR08MB8574.eurprd08.prod.outlook.com (2603:10a6:20b:55d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:10:51 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 08:10:51 +0000
Message-ID: <c72288d2-8020-4bef-b96b-6fb0fb8a5565@arm.com>
Date: Thu, 26 Mar 2026 09:10:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] cpufreq: Remove per-CPU QoS constraint
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-2-pierre.gondois@arm.com>
 <4e2ui264m6y6u6xmixvt5q2elvxsenco4r2e2axdtue3xuuqf7@rs3qofhtgq7o>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <4e2ui264m6y6u6xmixvt5q2elvxsenco4r2e2axdtue3xuuqf7@rs3qofhtgq7o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::21) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS2PR08MB8574:EE_|DB5PEPF00014B9C:EE_|VE1PR08MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd5f880-a30f-48c7-fbe3-08de8b0f5742
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 s/CUHDEXZzNsEff4qXuivrj1YDhIPhfHao24Z5bHRn0bK6ZLfoEYkNaWg/oDtKaArY9WHuBFVh2NO42xnsQsUbQXUESKTgeSyhRsquUYGFBaVLxqr+Ed8CoDYCOCJXdA0+QnEaNqjyNa+ueDT5vbZ8J1iEk2Ww9p/IPb/KE/zOzfW1Ce7LRUK3kIFIaT6OH8RGOogHEUnDLAYs0bK1Vi9J+CJhq8J3ltUAMGnRwcMxhq8vFxt7f9wYPT61l3yrshH4Gq0n2hbN7gi/NiFFid8T4UNYEuwh7lK2hDb00q0w9yOIyzL2dETEcBACBtA5sHqtI7exdnl7YOmznJ5J+jmJXlr0XpiEXwfeOFvQ/Uq1CrVziRqCxEhAwNcCsBz7hzZ7bIFJZF6C2W+3jNzECAW139bhFHPfLzJ7wRCS8QSLVeNBPY3LED3JE40e04m5ZFcP0H5GTN2omyD3Bc+r7oOlrKxVIpkZzVF/h8wvKn0Q4W8yO4MeX2E9EdV5t2zWrCiarA2mKxd2M++rHxtMvRvluhRPauLXtDNbDDVCH+ohr7rA1ii7q3k9YQA+ASJJZcNpdQwRjkBLVUn5fNwBWuiQFAGODAFuVuOyK763p8lrJr9Y4lP1Q4JFrzaH6B9U4OWaqlBw/KdlRSIUir8K1uYh2j5D2ix2yH1OY7xtzqqfRYNsXmaghFPVhufmagEQ0VRw5wvljSMHhlj3w4lIk0K337HSdSod3KMA43ufXA1K4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Rer/lfSIt5NUWVOQDUvapkNw/ns63WgTAzxO6XZXIGICtSrSobiEzhNykXkgy7x0AUff6xdMjU7Wcr9dCCv0N2QRGZE5qJxs1JE2wKGr21nsjbc7bt6jkaiSGpXuEv8OJyWqmSmF0MhRRBGecdDWOIEUbbgCUHc5K9kBKaOHdtnzXLmIEKP4e3cia9ieEiL8DE6uBPggVqRFFF08tJmGKWYxl0l6pPNOmobvyX4bXoACTj0bwGyEbo5FmJeEl/Va58PFIq04VAMucFW0TVo2gNwEh6aRaoe/DbuEofV8acFajiWvTeLpw+FHaNkrgfK5X5ePv12SgQicgzLj0k9SbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8574
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ef613943-17c8-47af-077a-08de8b0f31a6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|376014|36860700016|35042699022|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Kz/0YTq8pIqItXzM+2UXRBu3shn4CQneU1eXWsL2YjcAMqu40ffyd79N0WGsXAZk8PRCe0fWB12ZAEi8W7Ppw3s8HHTXBtEUytLQkD3jvOAAIeoY/UPr/baNcWUx19NQeUUfF7pgvxbNY3ZXxzxOvrpUATcQebnIdSirM2c3+1eAeBgorT09ZJ1swHM7RMJ01WI4hJzBV0mFj/QDAOXl5mCI2vofrC5uLT7VRBcxgiZCHI1A+Moo6YK/lmGYVM0+EL3yIQ4vvXmmSiT1f3onDkR/6xNCzf4vIAIi9IAm5mWq5fLsYp54EDwclD7YcpR5w6WnAkZlgTvCxqtD2NL0mGz8uWK4ITHGsOfzjFlhJ5JgKGP7xx6Yl6auk7WiACMQaILx7jCWkO/NI/GskKYfgxMg2UnRQnau8YEj1uNVtb+wWBy9AX8grBp/6jLileW+v/dlqnR1Y7oRUbcZPsvn+BwEHN4DPDxnlUUtkb2KENppk7vr6makuy45IwUDEsoHny6Y1pxtSc8M3u1kVs0eV6cGOLhscpGv5Zi6Ivrr0BQuttyaV6cfbANDwfpZYXrOMc0H9xjxu1I1U6RLgNGRr2T8wObqboebLojcfeTVNkZq77+6wQd7andh5mYV/6W+Aqs0R8jKR7FauSF3L9bCJMOfIPDxMakY9U1DwfrPQlXazVTZN8f0I06RQmyg75Z9E3TutfWSSz6T4nmDQ2K37/9lSXcQVzFrfNRyEz78tFpCiBMSNBLa8enDm/C5InoXC1uN+LjQPk3PBD8zL0/XHQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(376014)(36860700016)(35042699022)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xmM7Pm7kvnoyTgzG2Wrc56hqkc3XIcuN7EgUeJhLbPjaryZwCg9EYv/w1jPj0Nnjveer1MQzaMpSWz5EPPFVNKK2nFJxVte1zQ2QSe5lmXcErd5tgdQaFHU5dkyi2MAL8a5Drop1+s5VgXfl6VKOnEuX1IQp8HudebgaHWWK4cEsJcBpaMxwzrbjbV5YQnXzslYu+8ieRMP5RFqOXk3A2UAiSEPv09o1AhnKqjqP0mz8xK2ByqDarJ/DMrq/p7r6diLkGcqAgCPderEVUN+aFbBDvowzeOQ/wUcKusApFscVi8IBEnjWohRHQvRoJECb3XhHTrEjU2h0lYO3Fh2Tf0vvoWD+CcLK9Z+1ccGyNZKiM0RHb1fCePHSmKTBbXWThNuxllxvjQnV5ykxVo+6WsMda69ML5jRB55ONmKoo7sBbGi7NDOOtuiAzfRg0jFI
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:11:53.6891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd5f880-a30f-48c7-fbe3-08de8b0f5742
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5776


On 3/26/26 05:37, Viresh Kumar wrote:
> What do you mean by per-CPU QOS constraint in Subject ? This is per-policy
> constraint and you are not removing it, you are just avoiding to update it in
> one of the paths.
Right, I ll update the patch header
> On 25-03-26, 17:52, Pierre Gondois wrote:
>> policy->max_freq_req QoS constraint represents the maximal allowed
>> frequency than can be requested. It is set by:
>> - writing to policyX/scaling_max sysfs file
>> - toggling the cpufreq/boost sysfs file
>>
>> Upon calling freq_qos_update_request(), a successful update
>> of the max_freq_req value triggers cpufreq_notifier_max(),
>> followed by cpufreq_set_policy() which update the requested
>> frequency for the policy.
>> If the new max_freq_req value is not different from the
>> original value, no frequency update is triggered.
>>
>> In a specific sequence of toggling:
>> - cpufreq/boost sysfs file
>> - CPU hot-plugging
>> a CPU could end up with boost enabled but running at the
>> maximal non-boost frequency, cpufreq_notifier_max() not being
>> triggered. The following fixed that:
>> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
>> a CPU")
>>
>> The following:
>> commit dd016f379ebc ("cpufreq: Introduce a more generic way to
>> set default per-policy boost flag")
>> also fixed the issue by correctly setting the max_freq_req
>> constraint of a policy that is re-activated. This makes the
>> first fix unnecessary.
>>
>> As the original issue is fixed by another method,
>> this patch reverts:
>> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
>> a CPU")
> Looks okay otherwise.
>
