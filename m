Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F56345734;
	Fri, 27 Mar 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627754; cv=fail; b=eu1jVH+q9Z2/f/ErAHPApjBuNvwtdQ7y5VjRuYan/tTm1wm2IxNKSiAa6ZAc442MqCJrbBjCcka7kC2kr4tBaON/u89HnbZN92GMCfWcwhOL0C65rsLEuCMvAO+KBStkdEtHIQCW08PdO7HSKiK6SXuiSKQKYNYjDYWdtippR3A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627754; c=relaxed/simple;
	bh=PIemVP+U/ovaNRe7UzU8VJ45N0YgBxltmMonMX2DJas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GQDJ13M6KWLIp1eWsT9aYzoff1rXZHoR5NNuCumMtqEiPUK6Ex5292gaB3xL8rYhtB9CerBQt7eSbdfwPiT73WEUw940KsUg0Kdy0FUoQE15HWPexJ9TS+kdDYgpdGsfviZP6nRUW8GiaOV0/W30b1JoyigHuHGdgL83gluXqOo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NvIUmm8Q; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NvIUmm8Q; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NvIUmm8Q";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NvIUmm8Q"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ic9cauTAucqdCGeMQ97V6cFn6Pg5sn2yRGGCc4Xjl51AOdn26BTi+VBuNhz3i0s8bKDzM5UsmOSp9UTRtNPiWIhKzLeSFIoWj26eg5G5Z58seXvGmfHnYUQS4zBYpFfJYC7pWivc9bMZ861+TaQM7QNEuGgVfvYvEej/e5xIItoh+VCFS++iRPIGN4HyAKx19rdzAYifYIEfVCRfU8uivThIpnxyXkAHdw4/KJ5UWy62EreJrYLp4RVHj4CT1GMrtPXGeKODni2UDpTD01eZUVURo9reFpcrv7AyG14W7TMQeu4sXixpgGJmqJZzoLVViWLLkHXwV8WCmlL33z7AYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOHiDRpXozvprTgQog4QFqGgvIPjmCxuNjvbxORw+yQ=;
 b=gDL5rtMn9XcMg4s24iZuN7DMvzzfQEixYTnhE6yJUN0m0TpZJ4KEt8K8wSAqaUuXo+lxXK1zcI48MmfMD9vEm3o4WDAYebMXDtNXgRohcdqYM45B8+SFpMnNYNnoItdUzWfNyLMOx/lONU21P66sowQ2iduqn1XktMKJd+2xF4p49aVK6e5LumSCD8jtutN0nOskynbL7BYE8WI+G0vjjvn+kHRVIiDsdNaW4GcBZWjWHJ0q93T7ewcFEJ5jk40xNUdBkA+nlh0/vr5vowl8ueC4aJC/AMz9i1VMBmAhtWE4LyNurP6WXkCfL/+b07oPQWzALo+AeJQiXMeFdggTJg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOHiDRpXozvprTgQog4QFqGgvIPjmCxuNjvbxORw+yQ=;
 b=NvIUmm8Q/b4TCLGIVp0ZDCY/i8g1bliPVSKa2qgwZI62IkL6d9/JkEC6DJuoP58iVD/HK7mWA/i885w9nWu6kw8MEz8lvKiJhvRq9cwqKnCq+5oeQmwBLvYjpgTao/cKeE6pLNQRg79YAVMtUFx6AoxxsqXlB0WvEykygPPiQro=
Received: from CWLP123CA0003.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::15)
 by VI0PR08MB10457.eurprd08.prod.outlook.com (2603:10a6:800:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 16:09:05 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:401:56:cafe::87) by CWLP123CA0003.outlook.office365.com
 (2603:10a6:401:56::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 16:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Fri, 27 Mar 2026 16:09:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgsJRiUgWDzcp5YTwSOWDxxSJVqrYP+qXn4JUWpTxoL5V3n1iH0XaIOedmEpp988C6/Ngij2/3XIOSGnN+L3fmwiCpz/wcJXbdnRqNVtNGdNofVy08+MWn0APZK5gOhzdw2kkldCSG+BSBg2oWI8DqA5NtQUDntignBUjh6S3O2PTUCXrU1F8Q8sFnArm5EUfRPBRq4lsNoFLFUOq8twnb0ft5Wj2/YOKoJX5nSSwvMF+7i3A/sdjQS73S46plRQ/IkSvtHD2JQ+Pyf5oL4k/6FUvLRPpJYXrobIZYhuqKFIxVW+BjLgsqI6KohjVri3b9KptyU4t7YbRmlluT1TTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOHiDRpXozvprTgQog4QFqGgvIPjmCxuNjvbxORw+yQ=;
 b=Vejvityo5f1iEgo3FhdMP6sJjONBxPIZ4g4XSVzOP5l1/bgGfgzZtw8lFS7QEQiWQvZof0BuBVYpQbMEj0qBfFWgaPcsKE0bjhuGjoazrFSs/QvZLv5VKiaWKLC5F8JSDE5Cmm1n1dyGw4UmFIUr5PG1czND4Crh8O9JyhfsedLvACszvXaICS8ZGCz+rp5BDg1/YtSXHhpWNT8d9wJ7ubqRgBn6xlMd8tGfHKPkDjHGVIam4LACsahYJmXQjMBlGAu6dOEDszbRmwETFhE0MqZASSNSy6lAEjE0tbecsTLfL8bMjUA9+8nOv1JMz4bztDZTUHTQCcXPyFs0dkPI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOHiDRpXozvprTgQog4QFqGgvIPjmCxuNjvbxORw+yQ=;
 b=NvIUmm8Q/b4TCLGIVp0ZDCY/i8g1bliPVSKa2qgwZI62IkL6d9/JkEC6DJuoP58iVD/HK7mWA/i885w9nWu6kw8MEz8lvKiJhvRq9cwqKnCq+5oeQmwBLvYjpgTao/cKeE6pLNQRg79YAVMtUFx6AoxxsqXlB0WvEykygPPiQro=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AM0PR08MB5332.eurprd08.prod.outlook.com (2603:10a6:208:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 16:08:01 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 16:08:00 +0000
Message-ID: <d13a7a60-dcee-483e-8ea8-a551ca2db467@arm.com>
Date: Fri, 27 Mar 2026 17:07:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] cpufreq: Introduce boost frequency QoS
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
 <mv7ham5nlret74v6kvstourb2f7d4zxurbgpqm57w7c3hzdw2c@w2rx5r2t5vyg>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <mv7ham5nlret74v6kvstourb2f7d4zxurbgpqm57w7c3hzdw2c@w2rx5r2t5vyg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AM0PR08MB5332:EE_|AM4PEPF00027A67:EE_|VI0PR08MB10457:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b36dbc-53bb-4301-9664-08de8c1b2b70
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 c6hO741geMIg9rBth90EJkgcNwpJXPqq7Fmqi+rARih2FrUDVjDlcwyNkMyn7XOI/0ZmOT+NAC42s8wKtOnlp2626Xn6tkvRdBEp/svOZBKRnFLEw9gnMtJ+v0ufVCBx1CcDJ/Ep0AdHgTpJ2IMVQl12n50h7uaFLaC91FZEoQgdBpKyJEUduathle2ousVx65sfjgjk9lPesjuug1rEXR+4l56HBHubdpc9DMofg+QF/ajyYLMld6KSvecHeKiL7aySUhU2TxGMpm86N+/sV5E0hwR2vTC4rWtYR8X59wyFN5mjIInspYP7rxCWGL7QkI2svrKUsAlrXD69FotidHXjXwJkAvhoI41rQhwF6TFhwMcFfGZI99XD9CSmhicr6u5L0jx9fhGj+EjE9vC11v46KWmz/bpZ22Zyr4ostRXAk1LZnSuPl/xn9KlHVKo80Pc/6phS+bOJnTNrFD9VIAXWx64tDFcmGSzv4iaBn7bLRYHQ+EEHfy+2RxI4ncejn0/jOP+UryRIfvauVBeVv2VpSLq3c/dZhx35iodoLL+I1tRS8dYxYEIkAC7KPFVhmzNLvHMGST9edJgZiD2XBtEj1pOJOJYh+bAkl83RTlJpjRKTI1AuzJGKuIxd0ALzlyU5hzlOBDCN7tSfpnw6d3krX2kCS3LE01uuf5nrXurfMOxyndWeFxHawyMYfOySlBki7jkvBSDRSp3Ekzu3RJ5GjXZ58HrYm/mFkBmj8k8=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 p8Ur+YOWIOGER05QrFX/nop42bjfL0/0tBVHSAgS7id2Kp97NuAv355F0kQdvyyItZm+BUnuPyjf1Bqvbpb/SXV7G8NehD+dLbPGQaRQzESErCzRP/fkVwQWmzxObMGWOft4zFw3l2iMy4ry8oz9REmy71r09rjrbXSp7QSfRpR6xrDfWBUYQBf9yUGdtELS95CE0y+XT7QkEmTQXzo8f/MoFX6Xwj0FeuT7mOZ0ST/MI4NcjYkXpVwfZhhktUe3M49EhLov9zAoAmAQIXcX9b/lT/cJZw61kixB4RaL66J5dsZ5Nt0My6Mdt6GgPSuiKkozzbhNhZGWJ1gell0Msg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5332
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	96fd7b60-a2df-4f18-7114-08de8c1b0482
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|35042699022|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hzDPjkC3kRttTrIxh+twrTtTZqLXdGuWuC01N/xhyNJXlUsAistEylI74nrrlsrobOHLT9G8pTPNHBm+3v3efUFBXsmuIWjUUqFnwfteu41UKJbcYVlg0ErKdq+bW6hW4sZkox1VOzh3hXqXyk+soORP0BS+ty2MDZPh9RBuFzkSwhNTdkICKt0Jv1YAgSFsN0bS77Vqfc9wsuQFoC/40v6YeqDSsvV7EfbLWfsnoIyRsqYPhEzW2pL06JPfNFHhQYOYZ721a4Sb6g/p8UCcDt6SVKob6kxv7vrgWExrudrX8IXlND5op3v3qV03oqWyGTNkSeUKqgSwCYcSOuWIPhfmYeiPvy0jPf51f/ibX8kZZ+azLtdjwMsA9D2x7R78uaeoavi1Tp6f2ujG/cm9UWb3dpsFXx2C7BeGJcpdppAdLGsg0o+58FSyVtbnLJ6NcNFCoqJ+h0VkV5SJehCLaefyL6H6DPbZLLzhpUFHEGimL32s/DgQyn5x2F7Fs2QzqCR+8EAoxABco8/XFueFEEMhxyMWETNBX1zlHj86qEBvTPM0gS0kyYjpEeSsSEYH/M9Ihl9C6MKc//BGVJAVSdW9ia+r5yPg7aJSmH3wPImE0fLK7ryAk+18lowPBnfbJjfWo5OjuV170pVrO4dHyfNHR5gbX5T5TMCM5YVmBLr63sArAdH52F30P+osd+Eim6LIC6/ukIVG+m6m1Wd0IX1I2aXo1ONkJVksSOE2Vb/+LBb572doUU5ic2ruBhDdrqvlTUlELZaUjiPdfH9foA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(35042699022)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VatXygg9Bv0d7ddZgroXLZ1iqLk1+Xnd8KohJkB3EnZ0tI4fHCW69umVgcFeIx7AvoK8jbBCMOfuDi9V+DYupus4/fUEPHrMc/5V7QNqtrNekPHwfriSvq9WOh/GAKsL0kSfVPeWo4JqZNhVeqnp2JqN8GcpuzappRa/SUUpH+1YhWdb2A5olD3tHy8gmI+07WVPAfRGPxWHRhG8Q6WBPnrFUxDNLq+tNbsc4eqztgwySueBnDKmFCu3L578L0D7RwUgSwHRRpJYguPPjkXLxaZQawc/YrPp7y9Ga65Qh0e5Xqyp/RzOTC0wFe5RRvl2kaLnANj70oeq1s+4ecMGydC7+SI5rzii2d7LofER68PR6wLK0IN6FGCPnOeMJj1IpdDLYv/HL4aeH6pGaDOUW/e4m+gqSVNau6Q2EuWHVgw1/6KMmBk0NvCM4KFlZ9tQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 16:09:05.3030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b36dbc-53bb-4301-9664-08de8c1b2b70
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10457


On 3/27/26 04:43, Viresh Kumar wrote:
> On 26-03-26, 21:43, Pierre Gondois wrote:
>> Pierre Gondois (2):
>>    cpufreq: Remove max_freq_req update for pre-existing policy
>>    cpufreq: Add boost_freq_req QoS request
>>
>>   drivers/cpufreq/amd-pstate.c   |  2 --
>>   drivers/cpufreq/cppc_cpufreq.c | 10 ++-----
>>   drivers/cpufreq/cpufreq.c      | 50 +++++++++++++++++++++-------------
>>   include/linux/cpufreq.h        |  1 +
>>   4 files changed, 34 insertions(+), 29 deletions(-)
> Thanks Pierre for your patience.
Thanks for the review (to Lifeng aswell)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
