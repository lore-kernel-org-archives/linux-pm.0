Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F03A1E6C;
	Fri, 13 Mar 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412181; cv=fail; b=CoRgH9/4EwrlVOLxKKpCEnwkAq6ASBHSL36AQn8vzBQfdawDiieC4xlJBkCMp3zXWdeGxhSIwiODT3nzxyOkOpbYuKkoIsquG2Uc7BiaO1FDeHwQ/Q1cB/R42htmptOzw0fx7YUvUZZtynjLRO55wensm/TPXKhgUHejzvPO5vA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412181; c=relaxed/simple;
	bh=zW12s9QZc5YeBrS5+bmExIwgSPGQ/w5xaBP0Ky65Wek=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F83vJcnebB+XUOU2Ay3rA9mi/9O+bWonpmzJuZTm0N7idaZ/D8Y2lPNgBQVPMjefzLXev7K5nCf80E1YoDQZBqLuH749EylokS7qe4AB2JXihkf95O1QN5c7w3B6RUkaWpGGrkbrLkUsJFXQTNBoDp3zUL/yghO+/MCFEZCrPH0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SWaLZnNs; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SWaLZnNs; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SWaLZnNs";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SWaLZnNs"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AaGH1pTqIJ7DQ7Dog4LBu0gklK2A23Yy6f8ddz3+zYkTv/PVfjJuQY6joKIdkagxCsOfddm6OY0Itfpo3OGMmJF4QKuP8BwUMfZ290H0T2tv3VRyd5sNAU4PJttAK2/pWoovbyZ7N0xtHyfNi8F7rv8ZuWfNu5ksiSCLGQFP8r40UK6te+Lu6cpPO5hJJYAmhzt9k5+JpdJm4mRkwZgdLXI8XQR6HcYg66ptcq+PklOoI3ZYv88wsNVNU/H2K7bKprq0+p5rfiXPr4U45GmmxW8AQ2Fkq1yz6Lqe+OhPVoYTtyotPSGDhgGOWMehZIGAVNLMXfeaYkBFLyMWH8WGNw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw/xof0yjF1A+PDH9zBXwhZTpl2S8i7NoXK47TTMw60=;
 b=fYLJP3bdr6OXrt8fQk3Fyna06fc4qMOFUQInXVlWXOKgt6N6/5j8IrIJA09CcZa5wSFAJfXkOjxd2OY75JeTJLVg4MLwYU0OzhSXs20W6pBeFerGbngSbVs2KbMRKgmBOXsq4pYkxBTd5Qsg8eoZQYxT5xAe2TjJv7kJ9xJi2BtI4cRI7iM2SbvU/XI6oZAGybgZnyp6fXRln0H4pcIIv6BYDzbxa4m2gY1JP12je1xTDiGlLWK5mHYYPWWUBlP0vE/QEsCQcUA4ia5Q5e63JMcSfbEB9HnkZE/+xRZ8JcrKKodv53YPjRxKYraY5/VtAa+2hl3jv2bBF/vA8WS0qQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw/xof0yjF1A+PDH9zBXwhZTpl2S8i7NoXK47TTMw60=;
 b=SWaLZnNsk5aRfRGeP/GV4XVXhYTlQddYLSh+Ktp2byKcT8cAuQHfZXXxF45KB+UvC7QuJ1849Qzd2MV0pwUh6nOvoJppAC94h3m2FJCNZH/MpOP6F/RJZZGQCtLqBDOxF8C6AlftCXFIXNA350iAp4UWLXq5OEFV4LGIgS1LJ/Y=
Received: from DU7PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::10) by AS2PR08MB8748.eurprd08.prod.outlook.com
 (2603:10a6:20b:544::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 14:29:29 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::45) by DU7PR01CA0031.outlook.office365.com
 (2603:10a6:10:50e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 14:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via
 Frontend Transport; Fri, 13 Mar 2026 14:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIfqDYSF00TbwBiC7zWabnXzw3mItGXeDOxn5Z++JLqhhatcCjxO+++1Xqx7weiV/BZxXPxY9auAcKJPsBgLvuoE2leJUZ4DmbKm1sc+KUg3DsyYl55tftZeFJDNf85wTsGESQALPZW3Jgah5kzBuih9VuLCjMROdQ+OBiOdF7owRrvMEaCacA7OFWkLAovQHFG+xXDYhcNoQg8DRuxpUIZFG7Ob6vDJujEWPUzLyrvJt5l8tKbuRfCzagRapbdTNTS4pXeD7sJtBI+TGFxxgzSnoUVklvvWLe8y2wW1cIhRR71RUFI1VBZGt8cCFtLQLdpEEwBrpJcI/cLT1ns4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw/xof0yjF1A+PDH9zBXwhZTpl2S8i7NoXK47TTMw60=;
 b=ljniGSu4hoQQ3oIyCnowBISczLFmAIwQHot1W5hLM9A3Dda5LJy5vrIdSUCftFYEibtr56yTPc/FGFpFu5uP5ssn440zVCezkgwhZUe48+K/DfsSvZzhvSMPyDNe0RBbKw3xAUL+GWiR6ChHedrC5sUcbNiQiiSGVZFHMUoHlgbDvjjjFWlmNK3H41UJlFoOfj9ukCxWYqMwPbm9XD+3Bb89pd+ZMXks5XavEd6jHUsoxNh6I4pBQzUM+XzFgcierOztTeM1Za8pkXYz1C/3vd1zAk09d3paSGLUtX3c0foswkhapYm5QlefEemiQwltnySKjEy0dbyF/A3kzXtJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw/xof0yjF1A+PDH9zBXwhZTpl2S8i7NoXK47TTMw60=;
 b=SWaLZnNsk5aRfRGeP/GV4XVXhYTlQddYLSh+Ktp2byKcT8cAuQHfZXXxF45KB+UvC7QuJ1849Qzd2MV0pwUh6nOvoJppAC94h3m2FJCNZH/MpOP6F/RJZZGQCtLqBDOxF8C6AlftCXFIXNA350iAp4UWLXq5OEFV4LGIgS1LJ/Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB9290.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 14:28:26 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 14:28:26 +0000
Message-ID: <686195a5-5ac6-42a1-b73b-a94c56775eec@arm.com>
Date: Fri, 13 Mar 2026 15:28:25 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [RFC PATCH v5 6/6] cpufreq/freq_table: Allow decreasing
 cpuinfo.max_freq
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-7-pierre.gondois@arm.com>
 <CAJZ5v0gzVGUWW+qgqSPY2FxJq6F4KLicx=jYriuVrOiekq59XQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0gzVGUWW+qgqSPY2FxJq6F4KLicx=jYriuVrOiekq59XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P193CA0008.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::13) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB9290:EE_|DU6PEPF0000952A:EE_|AS2PR08MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 04145d7d-3f1a-4d64-db9e-08de810cef9b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 4zmHKCnLwguJw5Pm6J1D0+G8IqAnG5LYNCet0lkjNskQKB3uRKmnfoSvZxBQs+FQpwi2IgWar0CPFT895fWwW5VREGwfHYWtIrAsYo4iYLbJ4E0Z0OfjyvZnp2kVOoHFXcDmY6aQOYDQaYBZIWDBXnGliTQevMkPhFPCEpdTniXNL37zTcIF2kfK8L0pRlfg8zKh3XkwJoYA5EIYp8e0ILXnPTqJmYwQvl6UL9nsZ3TF0cI2bWoupQOfOYhWmPAVt3gWZN6f88LqGIyUUmuIII4rfz5V9aywOJw5WaaEKj6OIFCKvAGVzv8KgsjqtlNPlhLo9sg8z0t8I5PBxTdVE4PFD2DH+DHDNutXL9qh2JCUrv4MtDq/ME8pp5NgGQ3RNJDi5o8q03ooROHjAGBojMT8CT9RnIgjqp96ay7C96SsXgTYYTb8f2LKbE01l5qfAIg+7lD4r17Wde0fTmbow83QeLmmB8oWXddRgWTWZRGDNySzF0ML9YEmj+sFiHtOLzXlCgPEfykivCqzvOFkAr5liAQRLrih8NA5IgXuYSRR/E2fk9dxnhQB+O601dqWvjW04hqSQuw19EYRehagO/5K1Tm/oc1usMPS4mon4qBpN0sYz9PJpFK8AyV6pZMT2e867CZ924L+W32U8cnoHSJEQ+AEwIPrX60WLQL9X93it37l/FkMSpEuxfDxv5NxY0905aLBOqnMCkLAlCLJvOCJfntIRD/bpRjUEpl0lQs=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 v8sbEtc2811BHAmpZ5fS0DX8hyFb9Qi/oinoxIZZG6kCuzahfyHvDYJdYYCAWjRPddIKEknZGhsZLhFEOMgeMtFz0kTmFzq/hTGVbLt5BmKmPxr0H/TK7tpvYXYIP7yKCxz1Ku+L9LJQBTbkDz00WqcmAM9HPfSjAibmSFkn7ajJJy6tfldhEryeo1OSRDbB+6KPv2k5Mqb2b98T2Fs0+OLnw1Cw4vicYJGytuoEx+gNWuQAsB4+JmVNSkCY8vZRj6tDbS17hoNtHPGu+jc5Auuk1OECeuIBTAmayEl275zKiVb/Z7rmd70aT2UxdrhE5bBoVtvQTqJA1+nFmEbKmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c9103c3d-feac-4514-4d6a-08de810cca22
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|7416014|82310400026|36860700016|35042699022|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aXTv4SlEKYG5LbbiGbjq6x86atQFhFkUW6iORtT90VHr7FB/sHO+dKCegbxevCuzxo8iX1EB0f5eSZioKsj20Qck8lZOMKkxpxDt9BLveMNgIlFzDLC8IQ0UMNRZFbEu1JGYBBmfaBUnDHHctIyS8JfygUVPNUdPwb93lfSQiypLqIg9BUIwFcUZXEWgY5QfgbAycUGfyTAuAipxKh3Qv8ESRoC96xtglmZhYW7xIB6DYTAFYMmYC5+pe94oFjoONw5c0kVhMsIFxXjTuXRRqtcK2XxkajuI5HvYykPWKWmh7zPzEotoGIJ5Q0NmLaCNek8wm0Ej04dFsTKJ04D1xBEThQZoQF548DrvGSEsy+WHmQcJn7Td9AOP7hvcP0FravTKKLhmLIbRIn/R4ARIVEgmarZF5ffmtdwwznNkR1UsNrlzC+aZIDoV++k+V4hOgqSueBwm7Xr6rC1zAm7EP/7PNFnynqGaaXknid9HJP/3jzC5d00QPkKIj+V8BloM2OJgJkTslnx4srK6eQwne7tbkYERr87Mwi/5LZ69oqMKiTx2gTt5Tm9Z+ELj31S6NZuY6pHoSqwm6OJgDDOhF3ZTdx9STl7Y8Y9n2r3pZWd0vjxzJgmbDsBy4EsMizs/szBtcPBl6n0oT7f/vgZnOkZeNDyz+IPHAZ4KtmjKyAuVZkrY5iaztmGvKs9lE90y8pWZL7WHCXIzkHrpbdx744SQSVPXiGYBJ0+VCJtcfIBfG1NMtb5+7rKbLDBD5eQcnDy9o6L02ev0Zs6dfcYFgQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(35042699022)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b71Uq6eBHcLoFiBAW1uo5QmyE1RkzHl1Rahnfo1IMU/HHesU8zodQe/fCsMDJ+ReKba1rSLufDHyzM9OX4dqpdRBUOPJyl6vFHr4OXhFHi+89IErW0msbvW3RFpg/olMYAdWY/DOVSY1V7cMLgsEz+/pOsYBMqPc3utawYaA3g/jig5oFLhvy2ZN5IjRDN9IocuqH6AnOhys5ASu7QQQtYaYZZxDRGn8UYfHaaRQFOoDxNmHn3DBLe9imdr1OBgDlRzUvnANMXDH++JUxe6y4JG+GT1BkRwIPfu85Jjc4uCaeaYDIOvsaFtHnMIasgMav2ZAh7btMSlV/OJIAm7MxTZL9x7uhZcwlK7f87EMvd8svMh/XWJ305eeiOe8EiinS5v4W4wvTCEKr8VMIafEeTbFaKzFb8fPGYA/nSpSP+mAKSoZ5cOsPKu+GeZN7edj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:29:29.1771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04145d7d-3f1a-4d64-db9e-08de810cef9b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8748


On 3/11/26 17:24, Rafael J. Wysocki wrote:
> On Wed, Feb 25, 2026 at 9:50 AM Pierre Gondois<pierre.gondois@arm.com> wrote:
>> Drivers not using freq. tables update cpuinfo.max_freq in their
>> .set_boost() callback. E.g. amd-pstate, cppc_cpufreq.
>> Drivers relying on freq. tables and supporting boost frequencies
>> rely on cpufreq_frequency_table_cpuinfo(). cpuinfo.max_freq is
>> only updated if the new maximal value is higher than the previous
>> one.
>>
>> Using the scmi-cpufreq driver which relies on freq. tables, enabling
>> boost will permanently increases the cpuinfo.max_freq value.
>> This patch allows to lower cpuinfo.max_freq.
>>
>> Note:
>> commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
>> if max boost is known")
>> favored having cpuinfo.max_freq reporting the maximal boosted
>> frequency of a CPU instead of the maximal reachable frequency
>> due to regressions in the frequency reported by cpuinfo.max
>> and scaling_cur_freq.
>> As stated above, this is not what most of the other cpufreq driver
>> do. I assume that the following patch:
>> commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to
>> cover boost frequencies")
>> was correct, but might not have tagged the boosted frequency with
>> the CPUFREQ_BOOST_FREQ flag in the freq. table.
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/freq_table.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
>> index 9b37f37c36389..bd08cbe9e9ba3 100644
>> --- a/drivers/cpufreq/freq_table.c
>> +++ b/drivers/cpufreq/freq_table.c
>> @@ -50,12 +50,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>>          }
>>
>>          policy->cpuinfo.min_freq = min_freq;
>> -       /*
>> -        * If the driver has set its own cpuinfo.max_freq above max_freq, leave
>> -        * it as is.
>> -        */
>> -       if (policy->cpuinfo.max_freq < max_freq)
>> -               policy->cpuinfo.max_freq = max_freq;
>> +       policy->cpuinfo.max_freq = max_freq;
>>
>>          if (min_freq == ~0)
>>                  return -EINVAL;
>> --
> How exactly does this change depend on the previous patches?

Without it, the pattern in the cover letter:

# ## Init
scaling_max_freq:1000000
cpuinfo_max_freq:1000000

# echo 700000 > scaling_max_freq
scaling_max_freq:700000
cpuinfo_max_freq:1000000

# echo 1 > ../boost
scaling_max_freq:700000
cpuinfo_max_freq:1200000

# echo 800000 > scaling_max_freq
scaling_max_freq:800000
cpuinfo_max_freq:1200000

# echo 0 > ../boost
scaling_max_freq:800000
cpuinfo_max_freq:1000000

doesn't work when using the scmi-cpufreq driver

