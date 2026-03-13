Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E53A9D99;
	Fri, 13 Mar 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416059; cv=fail; b=QZuF1Qzu+pKgyRkSkdJv6y8P6FtJTX0nTbYAw5g1AmkmvM83we2IBooK0zQRl3kXD13M8mnE5K1/w29YX5JouHhj1dRWqeEK94+rorjOBaxJrLrCeB1XuQXQeFBi7Tu8kXog15us6HMeEo9dFNgwlTW4lggueIlJqiMNmcFe0AA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416059; c=relaxed/simple;
	bh=KosKyOamNTXoLd/J6oA4/sNHwDAl0hP9oNpUgjXZulc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r65rTFQGLxxr6MHAxZ5DRcrR9+oLsm36yIBeY+6JdlY0r/tPYTd+9tu67I7q4PdKxrbHDYt3IFIW2bvE3QC904ytT8D7bKIs4aHyCNBsOO1acThzH4ypB8O4R1cbkRa2NuJVrB3XprjFzzO9rWAn/Sn8FQ44Y6c8ISR4CAIB4uI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WT/hSoxB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WT/hSoxB; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WT/hSoxB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WT/hSoxB"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GZfAD/Xw/A0k9PMaUNUlje2vF/WVA+7qIHaDgyeRxcFWcq8cEl9HkKnxH6LNq897Abf5LMq1mbKduMARiy6GVz0sU5MEHrt/UqOuNL3YpPaekclN0gHBscTLZ8D6QzXILUUoDSk7CU8ifJFMkFZeT48GY6d37UhjWoBc48sfHd/rIvSjlsY8BntkETywLIH32dA0hEj8jISg2VP5CwUNvTInHBaMskhMioNYgf5/O+v6p0wU1ItcFxJeRdUPjbEQ9bfX2IoDqJak0dNkLKOlw2tNwY9H8GZTjGpvmYhEhT2BElyxnMVlK7HfWCTc4q61qDoj3CltCx2eZWEqkFTEvA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voq6kz72QbDVvHFzgpfkScWKDepfHCpQi6WhHfXUvZY=;
 b=UFNw22ue8pNc6oggZbbLjvNqS/Lp4IauEdGpDMUN7Rqj3ZX5wsK7m3PxdK1I6IY7THmbm2XqNU1/Xao1Hn8vLg+RwEQT1wsYJvm0uzuWokyhW6rUeHaHIikT3n/1B+qQUY+MhhhVTF+XY9xhWO3QX8eilrfRepmZ7khtkfY/pek65Ww+/8l5zdWVP5wYwREiBIc5xHJzUX2GpAQRUhiYmArZsKwO9Z7G7kPoN8vI5UKoq45w8A6icpGI/7CHdEAHasmnk+iyvsAyfkzQWkw1CBxgyvp3qIrOzaba4DFo+zsSmPYqFk9atqss7DVsdG6aeKbQimOyCL17XRTeGk+HEQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voq6kz72QbDVvHFzgpfkScWKDepfHCpQi6WhHfXUvZY=;
 b=WT/hSoxBAKKcwuh6Omrj2Q/73U/MRuuukEVjRKj+7D76KBCJoGz16odgmR2nUvYP8JQdY6//NEVhsb/n+aZnrbS92pxKv0AjIcs1gyRBWBok7BInL0pRHc/ymAFArvfeFN4LTtpIOhpdJZdvxgZWbW7vs7lHrr1iW4w9a0WO16A=
Received: from DU6P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::6) by
 DB9PR08MB8227.eurprd08.prod.outlook.com (2603:10a6:10:39f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Fri, 13 Mar 2026 15:34:11 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::67) by DU6P191CA0034.outlook.office365.com
 (2603:10a6:10:53f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 15:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Fri, 13 Mar 2026 15:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhyayOYqBawA5D5KF3umCwMvOVYtJuO+74z4jjpvCEb7CNiWSA8qCa0TQ1KKSArbYIAR3ee2wilw51WftzA5klFEWItopsdmrVvVorY2KYhUyui5ezLY6YpX33GVZSTOKFKzj6pGa6CfU6sZy/3jgVm+9UpbFM0BCXi6sfGY93YcWltIRRhDfmhitatHmmp26tnUTPpQYTN8cySzYHkqebX7BDjXJc1pOa6huPlU9FpYdurEihwvtWMNRc9oE+ceEW828QFxPvLajKVRKcAtzMea0rFmaaJdtDfyXxNl8d/zV7Qg8W3tFO5IgBIJjCDuQsHNKWiMDx32dn/zi/3Y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voq6kz72QbDVvHFzgpfkScWKDepfHCpQi6WhHfXUvZY=;
 b=loHwzv0aArkROS5ef6529Zxq8NcLumzYHaPWsWiC3C6CWiOlpVQ86VZid/L1lkTuKUEMKHR3I53brHQZe8ZJGNnwiG6JJhzs8lAhtNIkvg5A87/zEo5rt8Rwb3QEHO1B9AgLi/uahNcl2mFk2xgwvkR0Q0AvqdcD6yzT6mV3c5GxrioaV4pCjSCctoMNVqqSv9RpDry/6lHs4uX59BZvxgkQbgARfla5ZRQrVYYnSxAZKReRIxYheb/BvHJ2cW0UyvnI4bOIk5bTkdSgqL0yCFoalsidUTWsdOnbLl7jDis3bcL6dJJWXoOR1DOPITxnnb5qUGZjeAEEgCMkviVhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voq6kz72QbDVvHFzgpfkScWKDepfHCpQi6WhHfXUvZY=;
 b=WT/hSoxBAKKcwuh6Omrj2Q/73U/MRuuukEVjRKj+7D76KBCJoGz16odgmR2nUvYP8JQdY6//NEVhsb/n+aZnrbS92pxKv0AjIcs1gyRBWBok7BInL0pRHc/ymAFArvfeFN4LTtpIOhpdJZdvxgZWbW7vs7lHrr1iW4w9a0WO16A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PA4PR08MB6093.eurprd08.prod.outlook.com (2603:10a6:102:e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 15:33:08 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 15:33:08 +0000
Message-ID: <dc575a54-ca5f-4df9-9875-fca68b109c27@arm.com>
Date: Fri, 13 Mar 2026 16:33:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] cpufreq: Add boost_freq_req QoS request
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
 Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-3-pierre.gondois@arm.com>
 <CAJZ5v0iLEBiQE8GEyBn_RFHyojQOyrf=jr_CbPdG6dyvoqXBiA@mail.gmail.com>
 <CAJZ5v0hH7jGoJdFrdh81woh_GVk3WYAeB+OM7nbu0jy0O1j47w@mail.gmail.com>
 <b740cefd-cbfa-4b98-b3ee-8fefdaf8e322@arm.com>
 <CAJZ5v0jE0-tP5hz8yMrxriawYJ3pQyQs8rYMn_TA5fm1umb84w@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAJZ5v0jE0-tP5hz8yMrxriawYJ3pQyQs8rYMn_TA5fm1umb84w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0053.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::17) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PA4PR08MB6093:EE_|DB1PEPF000509E9:EE_|DB9PR08MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: c53f90eb-3cea-4103-7db6-08de8115f95a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 Ho/PRU96P8OI1pHOKvJyH99u/tHx3Ul0p2mV7nRbuAUJxws6bCNEcI2fiwGPuh3DiHzgZs2iLylAuTe8DL9BOIFoFTubl3JQHjsvj0Aj7H7+Gt0/KUBAJoHVWpSuFtp3INqlz3Qmz70gFYWN3nBqnx32f08/CtwI95XAUEZ64WE8krGIqaq7xuLJxBLw3QmnfN5yp9Nfkph6DhwIbS9+pAx+1KMUdlAR3Ddss71o3rDURlej2kMs1Vq9WOWIdswm0pXlWyhYABABMkOTuL+QvzMCc2+6wm2PjoqZxFNMjTefHLRRHdqxa2oIvAxRs7cPFqI5Yd3iRW6TEr3zWE5hFAvk5qP0w9OFmPVnOZTCN6eXj9SFJC6xBXzjZK7orJ899Cs/rxgzEchyJ7wo0ABpMd3lb5q/ciEDcBIsbYW6imW7V9FAvCWPz2p+eDWzboeS810XzwyvkV9UEq2gE1C/FBqYRt6Fwa11V8rTv57qxbpRoBxF8ainK2M1auN7IPktEQYeYzjIwgjzvUpWmQStIvT1nSpIXNEwvmH7NqaxqgSJ6t23i+oas6QzSGAoSucsE34TwJgJvX7zYj6vz1jXZbow3/ovvnjrsmy1OO/UjlgsoBqJ/X+aTxuCkGkbVjZdb6v8TpcTb7unA8TVTui2pC9kz9q4FgntD5Wo4eiZExhVxNbgb0Vb1f76XHPIkXNysFK8uZTHgtHwETJOfpJiF4ED4WN7KidY1KjikK1ceyQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 WoYMLY5sV/AwDcVCtTQ+TW0t1ll+p97JA5+ylfAZr2P/CnLckrIojA0dTCLijHKPAzwXD+uVv9bP5jUdnQgb6/mQo+cVAHFGWGn5S/+Zs9RrWK2+anRaT+l60pXs+Oc/OiOxgEZaQlElJS5pEjrukd1JyvG9k09uecavSo4aJMCw2YqXFRRe5dnJuATtFud+R78SmQ58M3zFXlmG0Njon43FqTeuRwH3tUOCI7/+U8pW7lEdXaHVPtkM2zTLWmgQPJPJPTYeVMoNTg/rPq0ZxiAr73T/pekMwTErvhkSngUQkYeU9xaUMM0IFKlZ3ad6aiGdWP4wZe4BPGd/6E8+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6093
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	25a7c832-3c4b-46b7-e18f-08de8115d3f4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|35042699022|14060799003|36860700016|1800799024|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	aqU4tVgSLTrTnP7H/pO6mcEwkZEG1agHVOw55/nyLutTwipXPtZJZ+NR7nYUbwXfpNhUfb/cEknqKcNvAlPlT1za3IlqnPDZmLQQB50Ivy23CtduJsrZEn3MVesmpOoeZfVQ+2MFnyyUT7a659QszMCwXmFFhVhq66OqktGkrTLN2XeDgwHeYlyAhAMJOOGw66m8Gt5tmWQEVB64IBxihCWkvVW8aG0ZIknDoFh4htMfLOoGjC97w8fYVow3AtghUrS/BtCJrsExVVL85PVafQNRyHZg3ADOlDrkEWBKkJ8MuwBtSjeEnYoUa9m5R2OIKAKvBKNHC/8OM+HQPebnP7n0ag8etS2qRg5g8XiiBk+R9YNAFCdrxNLm8MzGPpvNFjO0qnPa96hTtf2XskofjPAo4qL5CrWgV5YAryPELZJT7q/hJAc7YNQwkRsRv1Hl7m8yu/blxcj4rW0/JA37vkNcheUnwAmK6PWrRc/X5eS5ZLzJAs+IJQdn8+AuAomUF7B9GGPD3bNVQSWjhqEv0wlDCM6O4w7eCi2dGwPEYEUcfuRcsfizRj1NNeprFFJq3Igo0+nlgS9Ond37mrKQ0j9/7tdrYKMGvMNEn0uYVJnpnAv2axYbcjuOK+NfZyWhh9A6pYgvXDjRmecCFz4SMtSviTQQRjMhMEcORUpihmzcCykw0b5MAWMfQ9VpolU8f8fokOJ0o0tCJUrOZzh/wtHET+y6zDUGSqJLwaCmzcprpy1G0aC6Md/qOV3u1xCWBmMj+BaBve0KwP0/MU0JoA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(35042699022)(14060799003)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hiSXd6prsYVkxZA8ZuS6kDzzvfZzrDFVlZXS0b5ONfilcDdn2tAHoW0tP26a/YZm+kf+lUU5iROrDpFbkgNQpnZEGtsdSxrAVlw1l5lUsOMlVfo2lOrS/oz8nbv00cIJlMrZa41cZ5xOyD45cAKTRbwa+3a3PCJU8VANj+M4tZS2L5Be4dzKTaynbfC5ibsMZmM7iZN4TsOE7PkvZlmvZ6B8YuWlN6vCj+CcS52M2Y34rQ6+ncwMORVINWwFxoCVLoB9Wh0kt3UdS+jZvHW3BwMFGwI7OVlodXtsagszrwgwFdptGHiEsQ3fxB4YoX0clPqZEwoCnsDWRvxQYach6v7JDBFk87A1li5twDK0bowz6iCbWALJlqtLit8p9a6aD2NtOZeA5E3+0DECv7skKPMX70yxclFvCpapc4Vbr7i1RDSsvQasdwgkg6Iin4KB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 15:34:10.9723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53f90eb-3cea-4103-7db6-08de8115f95a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8227


On 3/13/26 16:31, Rafael J. Wysocki wrote:
> On Fri, Mar 13, 2026 at 3:30 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> On 3/11/26 14:57, Rafael J. Wysocki wrote:
>>> On Wed, Mar 11, 2026 at 2:52 PM Rafael J. Wysocki<rafael@kernel.org> wrote:
>>>> On Wed, Feb 25, 2026 at 9:49 AM Pierre Gondois<pierre.gondois@arm.com> wrote:
>>>>> The Power Management Quality of Service (PM QoS) allows to
>>>>> aggregate constraints from multiple entities. It is currently
>>>>> used to manage the min/max frequency of a given policy.
>>>>>
>>>>> Frequency constraints can come for instance from:
>>>>> - Thermal framework: acpi_thermal_cpufreq_init()
>>>>> - Firmware: _PPC objects: acpi_processor_ppc_init()
>>>>> - User: by setting policyX/scaling_[min|max]_freq
>>>>> The minimum of the max frequency constraints is used to compute
>>>>> the resulting maximum allowed frequency.
>>>>>
>>>>> When enabling boost frequencies, the same frequency request object
>>>>> (policy->max_freq_req) as to handle requests from users is used.
>>>>> As a result, when setting:
>>>>> - scaling_max_freq
>>>>> - boost
>>>>> The last sysfs file used overwrites the request from the other
>>>>> sysfs file.
>>>>>
>>>>> To avoid this, create a per-policy boost_freq_req to save the boost
>>>>> constraints instead of overwriting the last scaling_max_freq
>>>>> constraint.
>>>>>
>>>>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>>>>> ---
>>>>>    drivers/cpufreq/cpufreq.c | 37 ++++++++++++++++++++++++++++++++-----
>>>>>    include/linux/cpufreq.h   |  1 +
>>>>>    2 files changed, 33 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>>> index db414c052658b..50467b938668a 100644
>>>>> --- a/drivers/cpufreq/cpufreq.c
>>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>>> @@ -1359,17 +1359,21 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>>>>           /* Cancel any pending policy->update work before freeing the policy. */
>>>>>           cancel_work_sync(&policy->update);
>>>>>
>>>>> -       if (policy->max_freq_req) {
>>>>> +       if ((policy->max_freq_req && !policy->boost_supported) ||
>>>>> +           policy->boost_freq_req) {
>>>> Are you sure?
>>>>
>>>>>                   /*
>>>>> -                * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
>>>>> -                * notification, since CPUFREQ_CREATE_POLICY notification was
>>>>> -                * sent after adding max_freq_req earlier.
>>>>> +                * Remove max/boost _freq_req after sending CPUFREQ_REMOVE_POLICY
>>>>> +                * notification, since CPUFREQ_CREATE_POLICY notification was sent
>>>>> +                * after adding max/boost _freq_req earlier.
>>>>>                    */
>>>>>                   blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>>>>                                                CPUFREQ_REMOVE_POLICY, policy);
>>>>> -               freq_qos_remove_request(policy->max_freq_req);
>>>>>           }
>>>>>
>>>>> +       freq_qos_remove_request(policy->boost_freq_req);
>>>>> +       kfree(policy->boost_freq_req);
>>>>> +
>>>>> +       freq_qos_remove_request(policy->max_freq_req);
>>>>>           freq_qos_remove_request(policy->min_freq_req);
>>>>>           kfree(policy->min_freq_req);
>>>>>
>>>>> @@ -1479,6 +1483,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>>>>                           goto out_destroy_policy;
>>>>>                   }
>>>>>
>>>>> +               if (policy->boost_supported) {
>>>>> +                       policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
>>>>> +                                                        GFP_KERNEL);
>>>> Instead of doing this, why don't you add 1 to the policy->min_freq_req
>>>> allocation size when boost is supported?  You'll destroy the policy if
>>>> the allocation fails anyway.
>>
>> Yes right,
>> this would make the error handling much simpler to follow.
>>
>> On the other hand Viresh seems to have acknowledged the logic,
> But he has also said "+1" to this one. :-)

ah right indeed


>
>> so whatever seems is better to both of you.
> I think we agree.
