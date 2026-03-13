Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C763A2567;
	Fri, 13 Mar 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412165; cv=fail; b=sWtd0GM43ApTbl8KtSpvDdHDPQEZ8ThSFJIECF35tj1k+dsbjWhv6lssZ8o5/6A53MhsK+CZoxkpn9uuNA5kk0PBdMjWnD1xxCeZRnzGUQ5m+XiCVkEmZZD9Pmihnp4lAbVJ28UJvQiEbtYR72btdwEfXbOo2xHM7Jvu8vIkDvY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412165; c=relaxed/simple;
	bh=TmBQkLDC/nekPNYsZtLNtcipbi95/iKDYMFY7d+VNW0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExZi/EteM9fDtEIkosSEHWTliAkS7kIqOxv/z6FyB2nAh43mytALa4jwQbJ26axo8vPAMiDBMR714F2uNY6arU8891XBDMLjyEFz7lI6aTm1a11dmpfBmCptEHrEsCsWtYGzRCb5j/EhctRwB1PaNH+ENM4NIyAtWVzJSduiG3Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XEk3wet4; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XEk3wet4; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XEk3wet4";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XEk3wet4"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IGQ5oZr6LNp+3GEoMhW4W5M9PbfdNyyAE4DOkQR4KJwqONwCttQvKYgOq1saHhK0ajGs9KhKPoWfgeSlPweAyQNWlHxGy6+1liHVdJ+a55bs1RUppgEwhtnPhFqxGxynE+7AUfDII52T0EbTaG5RlvaX2KsDAnug9UkZBPPkakH3AqvmBb8kUVeG0NIx1AQiSQFPiYQm6BxpiHbMRWobq5SE127L2FC5+Lr+f+1YLGRwkX9LxchQva80NuhXR3EKUjVQvsxbHdKeoHk7oWTzcQwMCphpw0sV7+6p1/USfmM4szAj6z70/1hExwIhOFZFfMJ8ops+mJPMY8Ho8fXO+A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVlOVDYQYZ4IiIAKwxfjktiP0F6INNnS8+r00MBAczw=;
 b=kx/FEu9sVm9573uDGD5q6PLdBzXZ9nKK4FWtkXOTsmCXBV7C6QZK8VIgia5fx+CqsjTuCSCJ4ZRJ/8SdAs+34KjZLEI0PbKpeL/NSpdvd5rEeY9R5IFTAPHD90Z+u4s1iSCDkpOJeEYiS3diBEN5v8Z7cpUP2OwA7w50emsLQysV6PJhOkClkn+ok99jD8aenzb22jLrhKqLt/+owgRIX/NaZF6xxfLiGc8/71mG+exZn0gzg3U9EQhz92B+7gw/nrh6hB2+HaFI3L8Rpp2fva4afuAvpTGcLonFxA00EcbCpP7PJj9YohkRQEaqljFjJnyZ+6VYKt0IiZxGZPnuJQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVlOVDYQYZ4IiIAKwxfjktiP0F6INNnS8+r00MBAczw=;
 b=XEk3wet4bwrmN9cBkXw4NrRv6b7ouMBTeAm4pckZaVrkPCGapMDBUgI7GkwkywnOj+LIqsPvRRGGMoynUjglS7bOOs0eabS9lSQAF6AhWkOnFG7QkbANMXCt1cL1iRTYvnJg6qdEjJ7BLomnMQ43QPj8bDi09PqqY6XjCOu/up0=
Received: from DU2PR04CA0290.eurprd04.prod.outlook.com (2603:10a6:10:28c::25)
 by AS2PR08MB9224.eurprd08.prod.outlook.com (2603:10a6:20b:59c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 14:29:17 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::4d) by DU2PR04CA0290.outlook.office365.com
 (2603:10a6:10:28c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Fri,
 13 Mar 2026 14:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Fri, 13 Mar 2026 14:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JL3iOwhgtQwqaTLEnEnXFPsAUvQTcsWCBMeBbUAFdjum7oXl1tESfZd2+yOhnxF2Dvrl+/EXjKTviZlp2Bb0nXpOwc71Q89M2lVF+QlG3lBAJ8Q9Y3g221QTXL5NjmYzMOuPpD+qTQc/36FVIOfd9vRVHJFA5bJt5deGHPbzRsv5KS4UJEsuGkJQtqFeL2XekewRPeeKJvbjDDJYtQE31S+kdP1AUnzbE9z4fsHU5uHgTlhNv2H6sVJefrFroUykXvBmJvGvtMKEsUpFa14hFMdk/33muc49+l8uMluBm7sxBInCt1cDgbnYr9qbkNu7YAO1XuOsAo4x7Dr6j84Odw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVlOVDYQYZ4IiIAKwxfjktiP0F6INNnS8+r00MBAczw=;
 b=CHx1+066g6xl0jySQDGyxGnoKi3tmAb11V0OKZ4jwpsNWcHWtuUfsQlf4/OlIMEzHbwyH/WO9DINyLVNWmAKBVuaCscaqBtcacxaPdrn+PY3oXRtJ92FSUAHTsMqoQkVdLHC8fx+k0oEod0FxcWHrcYKGLwO8lDUtYJQbmXr3nZJ3g2p6pMMC+iCFznCRWTVJO6DMAZaKIVOPH0VxjRmZB+ejURXh0fTWfHWlQcU2+gHs6h6zBDq+NTGMInmoGA7IUQQXngzA3NXuOfZ8PojYiRq+PWF9DJOcheVPYcd6bBDeYuFGSr6o3uaVmwRIWRpx62YjdYKqMsw4bEQuYQmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVlOVDYQYZ4IiIAKwxfjktiP0F6INNnS8+r00MBAczw=;
 b=XEk3wet4bwrmN9cBkXw4NrRv6b7ouMBTeAm4pckZaVrkPCGapMDBUgI7GkwkywnOj+LIqsPvRRGGMoynUjglS7bOOs0eabS9lSQAF6AhWkOnFG7QkbANMXCt1cL1iRTYvnJg6qdEjJ7BLomnMQ43QPj8bDi09PqqY6XjCOu/up0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB9290.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 14:28:12 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 14:28:12 +0000
Message-ID: <b592df57-dd51-4967-8af9-a17ff3fefb97@arm.com>
Date: Fri, 13 Mar 2026 15:28:11 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
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
In-Reply-To: <zvk6qqwde535fiimjrtwhkyjnhymliv5acubtho3ge5hgj7y5g@3wolynnix3gz>
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
	VI0PR08MB10391:EE_|AS8PR08MB9290:EE_|DB5PEPF00014B91:EE_|AS2PR08MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4e03bf-4699-4f64-3dbf-08de810ce832
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 5fJHwl7nEq0ZZvWybo3dFx44QUty9WtdK65QdiNrjHoIH930/Z59J096sxPZ9fpDsnp7KPK5Na6K3vtm10PTT4FlrwGcimbqDmEuYVtblUI99E2xUYQHyaXoRj8g5k0v2/OLz7+D6HvV8I6dIDSaZLmtOSVvnKXDLHDnyhF8dap54zhKVFJqKQ09vD2brBdlKuZINH8JTKJErqeO4vXzsyc3rgDpWJM9e4Cil574Pu7LQH4VE88vIqlgwTzTGXrTvsgs9TctkBjU5LXOLxsGj9teiXIljPacZPNR+m2AIBmLAF4dr41vtw9O9J8QE8iiSNbDOxTxhxTN53bGRcFijZTBZlBkJZtsUIq5+QWCuwt/AXsMbFe+H+J3uQ/7LUEJNw18NdcuUdxSXsD4t9eeC2Cf3zQNl8sd6+eP+TBSG8WBM4K6ca/1JEqh4gUw0KhRL99Dok3zfCsRifaE6zqwMw7ONeTqdNJS4INlNXDn9i4Cg+82QOjZxV6jEm78lR9rw1oksZOSKirUa/6Z+QmezkDXauDZJy4O/4MonNcdk4YWX5F2Zj3eyt7QpZUExnueSqayCO2omzzuDWNxuPH801pfpum4LzCSWKP1Ai0JFd+dTuUzifPqz17Enz2z+lXOcZ+Ba1+veDAeU4JaEZkVdUs9QJFvS+61wb+LP6xTkhaaYWAdr9SkmC8xRCJ3QBhA
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ISRmDQhueQamupOjRtLSp46aduUK0yHKLxQ0ySQKhoPj1yGughDLlO50KUwiFMtwHlNfBe9Mh8V7XLqarbSIcyW9dJ89lAQTk79XQxnFlA2qe6LZpFYNhvr89LeiM4jAYvazMmG+0zse+vnPrVgAP14liigyf9sLc/BfUe2rcbCp2MwDPuCco4vqY4Ahl8vMPaaNdi+d2y+MQ67UQnVCBG/p5dUC+yTDof1W6mm3gWIT6HSUUiX1ZPCg/pgrcwFuaI4LIEYnqf/FTfeFrhVkRLFby9koBnLLypVgR+0VqO2BEcfIyAIKbiibAwEXPHKapHOJ0caCaIw+abpVpmibZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	db84afaf-1a3c-4652-6db0-08de810cc1c8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|376014|7416014|35042699022|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DErFqmHRGQjbW0bqOdPCH9zAKnnX+s8pA6twxPgm+6k4FaVdhHNEu9O12IoQ0Ka3TZBLkLgKxY0Anfqfvmy+CGdQFi8tpRifH/qi2HVN1uNGImBPfgYpHhTjqOml2qiecb0ldc/xpg9+HhFyztkhD8XUYhxpdgA/hbLvYO4mERIqzUsMjOYHYQshZueDTjjVjVr48EDtnIiJpWiP1dCqGxmor+uuanOWFyKCA2r9v3rJwMbiSp3Jvqc0QcbFlypz0b0Arx/nc44ve+DvPeyysfI/OoTrZWheTCa7r6f0r1NgcoTJwYo5aNDbJgQr71ih0GmcsGC93IKHvcg5cuFP5q/uKr6H9uSZfPUlh9m+d4KsX1x58GxbXVROAgnh4Fc7sgxmW50jI0a36gaduz5K0o+su9EuDZ660YB7N1u/7otCisyC9YfyxzbD+r3GxB6YNnJS68m8Q3R1jWsT7bMjqX/uzE9+e3I6OIuXFZVwLDhf7tIShxV70gaudeD9lIivUNO6XZ9jAYCQsuOnL9qOvlxaXH5lFWMifeb5GrySf/oIN2lEF0m18t6+DdxVYpjS/Tkof+8g+YkkxOwj/4B5NKaLDoIrGXxqBS+JwNyqYNYoscwX3dsQt8g4jBV8P7vv1Iy1ya4bcDq6MbizQhultm7yl+dx/y1mXgL9NOdrxMonNTiuv4rS5nrmE0ORU9Yqgmc1EMS+rChSCmLxQaGGxhW4FAij3XSoI/RiLP0ZbVo=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(376014)(7416014)(35042699022)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MFMYPpgmuw1zOihNRIWBuwO0OX6Is3R36nz31ThKoDfXHQjwrrRhSh55bCyGh4/1/Ywz0dWEHqtB7yADyeADplrv4rdj5RjAFkD5Sf03N8a6R5GrUJe+YlqR0iXu9Ba67heiaXqDfzEwFZoRuZQojCJUCpskDrRhxs3Swmk9jpwTWiXVc2v0GpcmT6TEUhOPHxCI0O3VSX2cUzOUDlDFLK7nlsyh/DiBRYTnnylsji71bYq4S5I9a4wBtAr7UIWbKR//Cuh9xDdaGMSiai61r02If77XF5qkMceiS9QuRyTWUNxknw7XsdauCD3hTBnTWmhf1Onc/tpbAI6Fzl7T4XAxRjT+hzND+0iVCeQVWLa5o9+r9N2PynhveRE+C4xmG/dJVTphOwvFgIkFidEUsa6jvFwRRWqksB5PBFjjvJ4oBtOR/BvLXH3ryC9z5RSh
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:29:16.7365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4e03bf-4699-4f64-3dbf-08de810ce832
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9224


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
>> Reviewed-by: Lifeng Zheng<zhenglifeng1@huawei.com>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
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
I think Lifeng said the issue was not present anymore:

https://lore.kernel.org/all/8c174633-4005-4e52-bb6b-9e9c6181b12b@huawei.com/

I ll check if I can reproduce it with the base kernel.

