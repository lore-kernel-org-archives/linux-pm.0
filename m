Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1F3C1996;
	Thu, 21 May 2026 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364776; cv=fail; b=FPoQ0Jt1LXHsqJrQPkULkUyN3aJLpntQ/Ujw3Y4VZXCZwNz7h1GvKZxRu6MT0mUedjP/YNSDxdgB/WwO+qj5xv1T177jhmAZAxd+CCUUFvMoZKcEb9G/iSprAtpgvYX9C6B69EnHOu7EMDZtwSGDang7G1OXIRMwePUCivOrV3c=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364776; c=relaxed/simple;
	bh=tH0gWJCp243i84rspKcg8Xz+kLb5+ld59KuFZAzqqCw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KP9WKpwJu+QsZFux//atqLrgWTSAvWOa8O92DtxhvUDMBV4CSVb5/akb3Ao8Omg0EUXlqeIdSnhrSkoRk5oMq5wnt4ZQ3L24T1QijxMxW+OMbiyUzOUVYSEy/ae/eeRcJMn9s4PWTBL8z7Iv43CBDds+z0DYSh6m0AfriNgKoNw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WX1nOtVb; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WX1nOtVb; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WX1nOtVb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WX1nOtVb"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OowYPAizyKbcH5lWAZYWEhCGmGJHtT5IEH3wzw/BGdAofD2G4sBszWrbf7wrlgdm95WQzEl3pg2aebOuL2soOgz1o/MK2X+i7rNLbLiDILgjSTiLDUg76rdKKqr5Ctzf5DmzHWhgoksGmY2R09zuhYhkq59BQYa8wnOWT7BTMIbF0rORSqc8UlEJmIUAtYfqeAssPh17r+3ToG/99CiCoGdtE4ueZ2YIv818CXlycCInfGDCnulb9HGlGdI22dywdntfRHgVF7KY43BsrEiQpg9VEKGQcc97D9o6rDLXq7nDTya5NfhHKceo6L+GWHM9pg2KVDO8aVkt7CDw4TuM2w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfCLxpbxf/i2gzoTOYJatDOvOw0KOIJhwMKf3WQ28us=;
 b=fmt27xJTgGzzS3V55rjPaRO2kXhTZhORsN2u0OH9D1XbOhX0nnbEJN6iuAGsJofcA3E7FE8Rn8IcZIaG/TG6n0fBrNM7+ScDDzZf1ZzCpuheBnriq0TdlDW7XGGor1zZw6pJfrlle5GjY2nTUMYIMT7u3ydU00J/hpK5OBvwZ82/+W+5f+ZiFTyB+DlRI9A11tpmX0RmDFtRy/MNbwImiFKRZHRZQQS24cne4rL65j69t6Qcg9YBDnz76GkNrH900wQnhyq3ViT8w5mYydVFBjViBwT4wBsuya0y+vK1GvYrzDERLytMSg0n0Yxi3e4J7DUJMT5nrcIbvzVkTsV1FQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfCLxpbxf/i2gzoTOYJatDOvOw0KOIJhwMKf3WQ28us=;
 b=WX1nOtVbW2IFM502sFZt9f9lgM97GkJtzcZL7pO5H3a1dz9rN9ZzoP4E9aa3TNgXgDZT+3pvc/6utxQT+j2bXMN95TuZyAV0Zl5/zy5PY9a+GoRAElk1yXDztjeQyNFhT76gKQ7I8ydwWU+vsiit0d1h6eSzkQd2EO/h3XEJDnE=
Received: from DU7P189CA0025.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::32)
 by FRZPR08MB11220.eurprd08.prod.outlook.com (2603:10a6:d10:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:59:25 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::5e) by DU7P189CA0025.outlook.office365.com
 (2603:10a6:10:552::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 11:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Thu, 21 May 2026 11:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrpv/dJ4Q7XBE6qRLAE/VqtmV7f34JmnSNXx+ja71xZMj/9gjdGR1uc3yQ13yjv7+hYyQmBbgIp4XH5hu2sm4KZUEcHhflwubISjlRzcbLdn349fO6cqOikaadUj/j3eM3w0qtH/hRb+UDLsj3dNhREak1VQdOKZd94o9O+owSoq0SL3KQPDUOI20L3e0u78nj2QEwP2wNegUad8+JxtJLyErCgG3SVcxlCH3lfxG17m6SYFTTfdXwuWjCRhQPtpRTc8b5oVmBAuSpmifxmM+Jipb3BUxJ1QwTD8YKrQ9GboXjCShrjw1ULstKzyZvnPErGazir5P3u9JHyhEDBoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfCLxpbxf/i2gzoTOYJatDOvOw0KOIJhwMKf3WQ28us=;
 b=nn3Iggd7fzn5ZZyfkhSbngWzr5U2jZep4im71qIYzKzjYUwATbH641Sjl1mXy5Uigeg9GYTnShHiyNUgMGmasSYscl0W5gtcRRS4tvY6ufEZn70YVBow9/8s7oVpJINa0G4tFC9VOsqOhp/P0+XeUDwnnXRMNr4qr7K461563MXM68ceEod23VVDImdoTc9zG+X19gPahBTnUhSKVOWmkk7/QUnOZVw+3SifsunCubkryuOsfw5Y5JOOj2I2GBCL/WcTWD0nye/8Yh+h9MUr+rYxuqOXI3IzVzrDMrHJWM8wp7nXtumFYFmnDrd8CtfCQ75sfA4TqO4Pe9CRpWxb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfCLxpbxf/i2gzoTOYJatDOvOw0KOIJhwMKf3WQ28us=;
 b=WX1nOtVbW2IFM502sFZt9f9lgM97GkJtzcZL7pO5H3a1dz9rN9ZzoP4E9aa3TNgXgDZT+3pvc/6utxQT+j2bXMN95TuZyAV0Zl5/zy5PY9a+GoRAElk1yXDztjeQyNFhT76gKQ7I8ydwWU+vsiit0d1h6eSzkQd2EO/h3XEJDnE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DU2PR08MB7344.eurprd08.prod.outlook.com (2603:10a6:10:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:58:21 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 11:58:21 +0000
Message-ID: <99eb1963-dadc-44e6-9e67-814ed7089379@arm.com>
Date: Thu, 21 May 2026 13:58:18 +0200
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 4/4] cpufreq: Use policy->min/max init as QoS request
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-5-pierre.gondois@arm.com>
 <bflxwyho5epheovbjnzlsvgvoitaqjbiv7kxcwbnoiz2nlmuvv@dtunrpupeyie>
Content-Language: en-US
In-Reply-To: <bflxwyho5epheovbjnzlsvgvoitaqjbiv7kxcwbnoiz2nlmuvv@dtunrpupeyie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DU2PR08MB7344:EE_|DU2PEPF00028D03:EE_|FRZPR08MB11220:EE_
X-MS-Office365-Filtering-Correlation-Id: e270df44-49e7-42e2-fc93-08deb730676c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799007|11063799006|4143699003|56012099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 eKb8n5Ax7etHlTdUX6XiohyeJJQFCOOyDvqqElBw1DOuANBXy7vt1oqVQyGzOpHyT4D3eG76fERpM+BEH4HLthBs/dvr6tdVhCCjUn80xyO0hDw7m+h+AYNvgZWeo6wL34ZMLVkbcAbIDiosFdIfelfYygy1tYRLG6E1mHCPLKGjvyp56IqKhxcn47GMwC3cRAPLgCXeUV+w0wmdcUXTWJcFpU0w1elj9vZWwD3sUUHqE4TM3VwuNIkaLISY18hGiy82tDcrXUxhaffMTX6gwihEpgfZvJ1RmJhAp/OQcavOrkRKwLEFKC6I6T4NEs3UPKrrgod7ciskVSc5aJ7R1XUEYZn91uLPHcYRzotfIvm4mkblL0/MrAHB+BbQZspz+hKGePKiIeIvBRJOqRksPjJ1GPGjTVz7pU6f7d+27T7FkYNDebyVcnxnDgN34uWMXSOgDf+vGk84L5ybmeu8Mg9jnOI9kWQ5wqvbcMHWjpaEQWEK5Pc1gAMR2dTAY/WCB3oLKC60M5UJYEi+8WBoAAVKFPfuWNI6yrZ7cCLM/rORqyNCuBgrvRHMQWrkIasPylnS4pBPyIvQ/xvFNHiu9C/sKYESbMO/cDqHQpnmZi1K0xnHlYA2sAsIv2LPsO7eInS2QYbtnyjFturvdho3BnRka1U5bUUyIyOdh+5cTiOAtvia/5YTOuYEKk4Pf0lVKJS9WyWyJor2EFarX+LdNw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799007)(11063799006)(4143699003)(56012099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 bQE1URxXxScdHXGcKTJR3dAQaekRGpgrh2gpFG7UWhZCMeCzEJlJkPiqhY50itk/DmbdKRWdCDuPc9X34ccrY0YB85fFYICTyFJikXtC111xhCkCzN7xwh8rw0JY2UH1yjVPA41K/OhdgYIIR+lPRoqyDTjuwpm2iBLYXHjNMh45/XSdoiT2e+hHFy96bB6fgvZ3zDI2UFX4w3FusPjojxlsVJxrPByq6cscmwXbG6h6DKGyssEFuFjw6vWEQc8GhNnxl7BzxmDSFj/wyZOwQMOO1ieKOknaxt1c/PK6sKvXqlI5J39c7Ov1fgcCRZ670ii+2Ea+Bw1gWciumg94JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7344
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6f344953-9915-4d74-dc39-08deb73040d7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|35042699022|14060799003|1800799024|13003099007|4143699003|3023799007|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	U0VdM7wPYq45AUv+CpCrglPids1z2dg1d0xavvYonEVOtZffepfEe2nOaa8dLkKcGuTvb45YfidXRUEhmuFZv2fbi6RgSOzhTjYJK30HrOSpUlkDioYLqZCzUot5MZsjuxzHxdVeT+Ea9pxKjFxnofJDJJkNieLS+xlT0+cGm4c+1wJ8xgJlzBRIzZK6D8rDuDV35v4hHYvE/VYbkHdfzPASe+9l6Kk/lqzMhQXd5UhLtSknVsvTuvipst0iFhGPB94UujGiFEu6SOWRZFbx/o4d/A4KbjG/FJNtAtulhsX4a1FaRitxFnvSNVhAhpJ9wMs8WgkbjnA2/d/S+nfyNmyQ/WGU5na2fmoB85JBq9jjoX7SSjgsF5d0mezloFMhtdh23W1lL5IDCUcBCHZ1xQmt4bNaCq8rddEvHTttIzj5IXbo7sUIzL0WdYaXS9jlT7qmGK/ai6BW4zt6sQxQn1yVP1FN5nmIsUvIs+tmV3Q3UIACYsi1ymt5SFnDhGUI+Dyh3xb3RHYH4ZTuMZQNYHryDcHtZ6ZB8U3AQMLQ28JwEt8luyjX1LPrPAQAZDFlMBpCrCcuMJAtVFpS6R8i8rLBzqf58jKQwWEs68zIgPlOYEaKnnqItLMknlSlBV/izVfgGDr7wVAhhBjqt8jRVWpuGGb8kU0D9z79JfTRwDxMMfz4TV5FcvrymPDPtKvlhJ/BjZASb4i45DAZ39khZIt36r36wEjx55oHoWASKA4=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(35042699022)(14060799003)(1800799024)(13003099007)(4143699003)(3023799007)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZEWG03O1InW+rbjr7Dsh+idnuSZFFPqE6vfKnqTti0lGnKFSOWfC65fkEGdV05cSLszi1Yx4q/01w9m8YdA0VX/9uO3v3vr7Uv0CMAjKEaJ1siMUt4h5IfDlfqoWJ28id43HgciRfkBGGK//z1cD7GdNIILIJc5dWVIngtJ0Db58AlcS+wInPFQkQw5iQfIVRu+fPZZqLTMFM06fJeZ3a8qO9dG1S6K0elyuBgjdM08tIHvPDcn2TCpuh9EaF5YfdAy3AjynvXQz06KHpTfqeSyZUS1QKFBCwKfvXzL1PgWT02j8cllhHYnrXZInQebroTxhnCTzdCDa2WbRWD0NTho47GhCoiZLaCM+i57M3BPNTJjX7H1KgZFSYyAWRoJDFcp+kUZMoyYudnuwAM11setTidzZe98Hpqa1qrjBm6oOH897JXwLWFulpIjmPdjA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:59:25.3685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e270df44-49e7-42e2-fc93-08deb730676c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11220

Hello Viresh,

On 5/20/26 12:03, Viresh Kumar wrote:
> On 11-05-26, 15:55, Pierre Gondois wrote:
>> @@ -1399,8 +1399,16 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>   
>>   static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>>   {
>> +	unsigned int min_freq, max_freq;
>>   	int ret;
>>   
>> +	/* Use policy->min/max set by the driver as QoS requests. */
>> +	min_freq = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
>> +	if (policy->max)
>> +		max_freq = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
>> +	else
>> +		max_freq = FREQ_QOS_MAX_DEFAULT_VALUE;
>> +
> Why is this required to be done before setting policy->min/max ? And
> so I don't think patch 1/4 is required at all.
Sorry if I misunderstand, but if we do:
"""
/*
  * If the driver didn't set policy->min/max, set them as
  * they are used to clamp frequency requests.
  */
policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;


/* Use policy->min/max set by the driver as QoS requests. */
min_freq = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
if (policy->max)
   max_freq = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
else
   max_freq = FREQ_QOS_MAX_DEFAULT_VALUE;
"""

then drivers that don't set policy->min/max in their .init() callback
will end up with a QoS constraint of:
[cpuinfo.min_freq:cpuinfo.max_freq].

This would bring us to what the following patch tried to solve:
521223d8b3ec ("cpufreq: Fix initialization of min and max
frequency QoS requests")

------

About removing patch [1/4], Zhongqiu noted that policy->min/max should
be set before the CPUFREQ_CREATE_POLICY notifier [1].
I then thought it would be better to save policy->min/max values
that are meant to become QoS constraint:
- as close as possible to the cpufreq_driver->init() call
- in a separate function, to do all the QoS creation in a separate
   function.

[1]

https://lore.kernel.org/all/73fac9ca-451d-49f0-b9c7-5ef6bc0119bf@oss.qualcomm.com/


>>   	/*
>>   	 * If the driver didn't set policy->min/max, set them as
>>   	 * they are used to clamp frequency requests.
>> @@ -1418,12 +1426,12 @@ static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>>   	}
>>   
>>   	ret = freq_qos_add_request(&policy->constraints, &policy->min_freq_req,
>> -				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
>> +				   FREQ_QOS_MIN, min_freq);
>>   	if (ret < 0)
>>   		return ret;
>>   
>>   	ret = freq_qos_add_request(&policy->constraints, &policy->max_freq_req,
>> -				   FREQ_QOS_MAX, FREQ_QOS_MAX_DEFAULT_VALUE);
>> +				   FREQ_QOS_MAX, max_freq);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -- 
>> 2.43.0
