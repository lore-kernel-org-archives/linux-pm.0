Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4692D7DEE;
	Mon, 16 Mar 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672383; cv=fail; b=uLq8A8rpfNfbsCAODbevAFjf/pqBNWZijNMIXkzSBBFP4IhXTioBUUEohtmf9ruk+GvZWUSR7eqHVJHBUkR22p1KGMY1AdxjBgUv9bzpQAPjhRZ4FSt0GzSdG+36ctw3B02QKoKG/neo59bqIy3J5DrEz6X7870VM7wWNeMlcmc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672383; c=relaxed/simple;
	bh=qovJDaJyyE66L19nXVUjspNykoryxRExpVXXELzWztg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d81xcuhzNQcbGpMU+PvUEe+fGb3n6zLhcmf3royJqmPMyhi5Dz1GEeSlNn+R49wUnbdb2LxkP9TgQHscUZVmwry21bixepbm++Ed0fGLnxZUh/orVlgc2JnqjGlRB2aliIeElFIgfOf9CklpiiHJ5Qz2xahVrcsMBx/d1bmvFIE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VoCtK8cX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VoCtK8cX; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VoCtK8cX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VoCtK8cX"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CdpH07leC3t7SSVvohT2mwJ3QfWupmzC1Qr49OUpBrLWTeYXg9qvBpdcHGT6lyCgWMDK/03gmbJOl96F/dlWDa59WPK4ltMM3TLf18fOvOvNQ5Yh+skg8KIxXnKn7Rwx4QaqcE/fQ5+Ejdg9raB96dnxlZLIhQbksDiKUTGcriK8i0wORe5D8zsrXtShHAVwNy9OPCgMYRcFazD/MZ+nDwP8lEBvuQuOJvAlwbCffNT2hEUtlciwLd3rl/Q9QPEx7YiNsGHiOA4BYmoG4sn1BN/2VpA7G4vSVBwA7PqQCdfD8caHf4CiXXELEYZIWtTpjsUt4Thw5jJ4t6FKXkURKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29yOXmCx9i3C2BP6vvUCADhGN/vHQjghfVCuXCoefkY=;
 b=ZhJ1b7bxnlkNmQSq2Yfthz9FFvowqCEWQX1+VVC1zuqE3p4JL9J366Tj9DPNv8gJ5e6J3smHhI84JZRc/J9pvCfFbaT3TzQy2i9M4/9XTDmiw+1VtuCcvtCw8EMCGgu1xqO0sU2vpJ2TEr4U5IDurcX3snViptC2zOce+4r6Mrkvam1kBxnpMxGyR4pnUObBSaIVPl8c64BceCvaqvoEnGlgHMKl7D1q4MRtlddxCYsdsp0FRw1liLir09yYJ7KbKzvG0R3GxRKjPTasWIHD05YwizRfxJR/W6MHHcYETpYYEIVyJ+zvW29kYxRh/kLfxmJPMF/bndRME1qMRSXCfA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29yOXmCx9i3C2BP6vvUCADhGN/vHQjghfVCuXCoefkY=;
 b=VoCtK8cXIIiIinOJFKTK2fQ6S8McnWjPD/5JUICzUM/8TSChnQ4uCDtuJTDcZG0zO0OgeuYiz0q39Gj5+scf9JFqERlFrRMonF0biQzNcLpMd+w3rG5mdf+5mD8M8AqgKLpbyMWFDE7p78BmgAsJjMLlg4higlEILyeWtfNvh4k=
Received: from AM0PR10CA0021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::31)
 by PAXPR08MB7317.eurprd08.prod.outlook.com (2603:10a6:102:230::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 14:46:16 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::76) by AM0PR10CA0021.outlook.office365.com
 (2603:10a6:208:17c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 14:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Mon, 16 Mar 2026 14:46:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXo7FHv1mcqqOymOHfjuLEYIpbrsCV8UXv9xHyVr5TPkJUag7jbGU27Tr/v4WAjwr+gdkNvHuYgc4b/F3wN/57qVZYdIs01yd1yerQu4wzm5X3pBhyEJTGoVkRo5oeIdekhwgWfijY+1JM+EKRQTvAvlRbULOEC4M2dZl5CUEENON7RUQlT0OdQVk1LfNFRRcLfDJfje0tnm8C7Xovl2L5EaH8ThSbqpd0DNhZBbIppXkQHHW9GVbDRKtcGg/c6RtWwVvIJO3faPpAUtbB0t8bYJvMedXc7pC5jU8hhO250E97+Z7yr2eKtGSs1AFRQZ5Cq4XiJc1Tx4o2/6eN0m6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29yOXmCx9i3C2BP6vvUCADhGN/vHQjghfVCuXCoefkY=;
 b=S8VgnwrUgTsgRh91ugnIuMaSLhEukxS1wASGvOFmcLONgD1aZ/ANikHRzNTzE7nXG94KKwD8iwqsOP2EKWJNJ8pqbBVXsEC9mYwuaeZ9qEZc/9JHEtmgqQYiLQpCIhZ4VNBd8o5u8Kmf3xcETNq863WvQcIIIbdCEB8qbdeUTaCpPQH2RAw8GgkdtY5zneqKOF289hKh8YUL5g7rKVim8UuBs0h0otJAKWVHtdbRKhq8IHknZI1RWfOQMXA5ugFUHzB7gJLGgjKaxW4zpXEnwwjuW8bq5YETYzbwFHElyd5V7UzmvaLLyGrcjaTuft5y5jStTlscfrAm0jiD8A4qZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29yOXmCx9i3C2BP6vvUCADhGN/vHQjghfVCuXCoefkY=;
 b=VoCtK8cXIIiIinOJFKTK2fQ6S8McnWjPD/5JUICzUM/8TSChnQ4uCDtuJTDcZG0zO0OgeuYiz0q39Gj5+scf9JFqERlFrRMonF0biQzNcLpMd+w3rG5mdf+5mD8M8AqgKLpbyMWFDE7p78BmgAsJjMLlg4higlEILyeWtfNvh4k=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GVXPR08MB11154.eurprd08.prod.outlook.com (2603:10a6:150:1f6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 14:45:10 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 14:45:10 +0000
Message-ID: <de26c436-bc6d-49bd-ab88-e055f1665c2f@arm.com>
Date: Mon, 16 Mar 2026 15:45:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] cpufreq: Remove per-CPU QoS constraint
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
 <20260225084930.1692228-2-pierre.gondois@arm.com>
 <zvk6qqwde535fiimjrtwhkyjnhymliv5acubtho3ge5hgj7y5g@3wolynnix3gz>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <zvk6qqwde535fiimjrtwhkyjnhymliv5acubtho3ge5hgj7y5g@3wolynnix3gz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0005.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::10) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GVXPR08MB11154:EE_|AMS0EPF000001A4:EE_|PAXPR08MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 310f1287-3198-4c13-b77c-08de836ac70e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 7bt9rw7uVnC2Ee6oSSLpTlZNULgRa08DbTys1CYx2wkil4wJ3/VynQSKfeOqTPo03SLDwMgVnOAlZb0I11mgKzX0gLLA7CclBxC9Si2byUaqVkCablWdddECAZt7HGSMGVS9GvDmiaqeqsN3cQFzha9nsgy/EtbY6kMnx+7v33D7wlzr77tqxUNWpRWHHzn84fTd2xO7jARSvzPtbkjr9+2PWLW3iJJY+RhH8XCaowL53d0eO/ICdcuZmOXoHSB8ZXep93E0X7lSBBmfc4AU57Gog/cRhHG/cp9thLfD/ZPoGHP6xpbp6VXirRz7mad5pBZJDQcvlIqP5s8jlBkH9qbUuY+wflvEjmOCFlgJbNXgkbnaaEGepcSvJEIyNL3U62CtgduHsYGOHifgyJCmGqhpGbzLcHpT+GNVR8a3+te8y44GvFlTTtunlhYRxa7pkssSiYBIWrKMd7MQBTwLmqwFXW0gx9J7Q00temeRjiGyTO7+bDVcfLTkyDP36PEi1x8jR0g68zTf341U98yUehoaDlGeHXmJbGcOZjlJDU1qKInu3CflBe2kKUBaykBlwYGTzRm1we4AjpJih2mPQ4bfD1b3+U84kbIy1QTcoL7U53WLUOnI7MVRU+tAxBhQQdgfZyRRfD/8Bn4/wzEKQuEhnlSPyI77FfkgwdkOK/HkPrA9LnI+N9kVwdhxDxfa5UAdIXXgDuQR21eGTGP7/8wd3Jqt+4R6Yd18qPvTXCBze9s/XZQXFXC5ZmHBB2+B
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 lqIfKxc5Y7ow7bwZT2jlQyz/uQgs81ELnUOVUqL5KZWXzJHMisJ44KgujBwLcsP02wTLwkfUfyJ3puXXhBQKl5s8/k0NUfVpAjlx9XMnVwFZaDHGq/e6aW1nBR1mmgfBxaitz1dWJnP7C65wGmvVnEkxESG9nNEfmwLZT4lFkpBYDLRPOayJYOg6x5hUbi4DWJ2cf7rH2PuzYk+nR84OkJI8sJR7HfOnejFqcwoE8c/XZ7Dhkoo9CT45AUfL5Hc/AEIYPJa65WlFr5bgHTh5/3qdHLlEF5Y2vkVkI0DcYKuU/cgMoz0nPsRu7bRKyl01CsldbKfqjMDDjPa8EnD9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11154
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2050225f-691b-4c31-8f35-08de836a9f49
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|7416014|35042699022|36860700016|82310400026|1800799024|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/gHSETb9uZZ8Q2RQO45y2sg0fWepif+F3810DJlUCGTCkFXii/MPapEHXUyjItAFJ6YVggu4Q0QePPoLN/VzByq/Hr1VmxBqFCIokxUJhE6XXXu75RfM73d2UR4Kef6ihSC30EsqvOY4Zu4wtxy82JFfLBCL4KJR04waMZtizAk4wSQIiprNMTLaHx4/cW99XAj4k9jNpne3HYVvAQk6btpfjjF4mmxelDIMZZRklzuRxmN/FwVuLjeOOvJO1Vqnl+BdG2r34x68AXMLYMblREUDhuicJwSRnUCoLOYvRM1PVIv9Ij4cYkude//vVn/hMWeyIN1ZtdJwEHKX2BWM3MLxtrRxoN4JPe82O66RkV30JjEre1r/QIMtgg88lc2sDmPwPToquxDo0VmdveonAkznjGxYAmdMqKTwE491U589iJ1497OQj4SzPkAZwdPQgDisr9Fil915vZPMuABVz7qN7qwLDuQkrrN9vDEUVFneHdbMCnhsl1CbGRi538KLKUU/+qKo2Vosl1x2XjGmKhr2zbQVrw1Hs4MHqzOtJsDQnWh/q4QqTzlOT2C03tGzi7hzuxxUVUErXCI+WOHQoo70OS5HZk1dH0ZaZYcIq4vbh7lNeUFXTmL7Imh0fSUWsYpO4lmQ+okLJS5P6cESTI3mJhPoyqst9IKpm1gTboLhAIn81faSt13uR0V/0aET9/X5onJi9aRDvGGkBASSC7Kd1Z4CR5hdnVPFJAcXyjBLnjwX79WxTlOIO1jkjU/RY+mReR2yc9Q2pZQGVIBfBA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(376014)(7416014)(35042699022)(36860700016)(82310400026)(1800799024)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	osqbmd5U3bTcr0VeVWlGvdmkAwupCRcECcePfhkDrCNbQATsslJsqOZfWhlKy5RXC/RuhjbGM3x/CyW9X4NQ4Rwj7UKxyfGaPZjjuvu8JX7b7y5G1zjE+AV5mIEQ+GjW5rlDkAtwBKHvz6aerkMM2d9hkp4/zdJMyx8jFRUpPLJP3dZcLkEb3zZFYHSH/oMGJWd+vTJvTrBD5Zrcfrwot7DfRHHP2j/UqV3rFDs2J2bpL5bWZoLIxxa5WNL55cWcJG6hYTzdCMHUqCCBjKVJB7vkD/l52Qjo7z6Q+Iu8Y2ZyzaBCxb4Wsf9ehhv9vJG5aj8l/Gyg5Yvm2mPs3gyxbg2G1HbnqIZS5Mbp7ommUE9u5b1dlWrFlTgGSRGRDd/PE/2IQ4VdqPtKjtMU98tAwE3rAunnhjGL7WnZLpLKFxn3xGvnzajPy2u/yUWZnxCc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:46:16.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310f1287-3198-4c13-b77c-08de836ac70e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7317


On 3/13/26 09:57, Viresh Kumar wrote:
> On 25-02-26, 09:49, Pierre Gondois wrote:
>> policy->max_freq_req represents the maximum allowed frequency as
>> requested by the policyX/scaling_max_freq sysfs file. This request
>> applies to all CPUs of the policy. It is not possible to request
>> a per-CPU maximum frequency.
>>
>> Thus, the interaction between the policy boost and scaling_max_freq
>> settings should be handled by adding a boost specific QoS constraint.
>> This will be handled in the following patches.
>>
>> This patch reverts of:
>> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
>> a CPU")
>>
>> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 4472bb1ec83c7..db414c052658b 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1481,10 +1481,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>> -	} else {
>> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> -		if (ret < 0)
>> -			goto out_destroy_policy;
>>   	}
>>   
>>   	if (cpufreq_driver->get && has_target()) {
> Even if this change is required, I don't think this should be applied
> separately. Just reverting this will get the bug back, which was fixed by
> commit 1608f0230510. Individual patches shouldn't break kernel (and bisect) as
> much as possible.
>
I could not reproduce the original issue.

At the time of the patch and still now, calls to
freq_qos_update_request() are checked against negative values.
The only exception is when using the scaling_max_frequency sysfs
entry, but this is out of the scope.

So I don't see how:

commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging a CPU")

can prevent a CPU to reach the boost frequency.  The only path that
could fail and that I could reproduce was fixed by:

https://lore.kernel.org/all/852ff11c589e6300730d207baac195b2d9d8b95f.1745511526.git.viresh.kumar@linaro.org/

So the current conclusion is that "cpufreq: Fix re-boost issue after 
hotplugging a CPU"
was not the real fix

