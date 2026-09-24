Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEF1476045;
	Thu, 24 Sep 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253935; cv=fail; b=Ogv9b2a2AlWlsyG/AwzX+GOY4EH23nOOuMxy+GKZuoo/ZQLavqglADvtiU/Qbt6xpKqUkAf+8LS0Y8Y26VwJ/ck6ihd3ae3YMAsBgiHTUwd3WMAHBVNNWhAdlSvnr8g9UtsY1hu2I3AoCJAb/+qJsBH52o1M3hvufsHmwn4p6bA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253935; c=relaxed/simple;
	bh=iIc4ZWOSM33/K+gyzNfvmrfL+NsnZC0lqNU+s6/yCMw=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=akSrCG+Pw9ImanqX0BH7lGJnF6Z+6Xzf+Vl2SPu0unHoTkMWeR9jy35RhDOVNDTRfBbcZwsd+vprGB3YCA05AsCIJBjNhh/fQAKGNK7wc8ijCE3XFnIEa3wgvKkorA5Srh50Cb4Orjq4H2ugtYtWCUy0+AuDHxskGr/begcSGec=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K/TbIBzX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K/TbIBzX; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K/TbIBzX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K/TbIBzX"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XUsHXc6H367q22Sk2LJzc+i6D3xn6xgD5Rq9AlxzDNx6U76P028nzdnvaaTZbV4uVX256HX0tTDOwVSEXEbOkIqhxmCRGqTg7IHGH0tjOCVgF5XVLx9s4OVQjQRzaY64O39ELU6UpF3o+7L+RMf9NNffvHuIz55lNyY2ygvS635nPFEjiAg2Jcu5Km7i+pUALaWVFotaLYeCu1zicYq0okW9L0QP8qQL5cA58OIky0YNOUeQf0q70C0PecWuSUd75tnSQlaKOyw6DZ+cX8WkLCukPUV6mytewdY1/+AB2GsMipakjp5jsv8RI0d3Yra3ckNd8ihmDtMzzjiA2WAacg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7sezX17o3UIM/n5R+Z+x60nWmnkcyjb9K4iKGmX8nY=;
 b=KBk2riwYMbz3fvxrfLyfXgaPlbLypVFECTt2/q/3VdZX4ymMHoPNeCkYSyl/Uumx+VX0HcRyeWVQckJB8kAmRYKb96L1kWnidhxGKCwHrZc8Y3R1j4Vy87kggvTWqH5elhkR9UcRqvvxCJU3BW4yG1xpxdzYhS5lZSb/03ItRfwJ53o/efKM5hnzrdi+4pOnQ3sNTtOP7OUdYEC/2j0HapQw6dO4+h5+4mXMpk8USK6l4oolbgZlqw9mqAsVZDxXreiYe6IImBIU+C9YntB8/tJpfqNZJCZoOHfCbpkaEzc1h4jC26QWsmLs9roGNhDBCvpaR1eLlwOPRoovBvuPzQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=goodmis.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7sezX17o3UIM/n5R+Z+x60nWmnkcyjb9K4iKGmX8nY=;
 b=K/TbIBzXtm/MAB1joGHHjb5NQfyrkLpZ8RIoPNDadU8aDvZYl1M0lzt29ZVSQGkgRC8qagb+FEwan96mfNGCf+6jiWvW488d8Or1FqsqE6t9YaqG++pTkjkL7fMoeNQZuP/MkT818lhqkcAhF/pROt5mKBNAgd+0e9HkgymCkRA=
Received: from AS4PR10CA0001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::17)
 by DU0PR08MB9909.eurprd08.prod.outlook.com (2603:10a6:10:403::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:45:27 +0000
Received: from AMS1EPF0000009A.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::a) by AS4PR10CA0001.outlook.office365.com
 (2603:10a6:20b:5dc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 12:45:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000009A.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 12:45:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9j6kFfqB8ubrYG3Ry9Vor77TFBm78AT/JlKWJ4NxaynSsGh1CDt33t0LTQwKAfj3iReT5ce+VMdDTfE0J7bOvMBf2JXgnE8aJguty5MJxFQzq6BErX56aJt3FF44Llezsz6bn+v1MHlVZtTtvMwdCt96v058ZyPvtsW1FIZt2DHn3Y6PeqvTgZ1PeoJknGn305VDsHT9Wc1Xr+7Xww3N/5Wp/+gedwUHLzkRKehRvF1pVyZ9QUK3yYY9rsWSPwcWeR+pd0xr21uYhW0tN16h/nMdXMp8yuXOzAAh3EIVavo11lwXBnMu8V398Rs07UM+YLT+SDKNYOmvu9SOf6sdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7sezX17o3UIM/n5R+Z+x60nWmnkcyjb9K4iKGmX8nY=;
 b=s4xU49WP0kTGMrXMzfmARgDceHTWRVN5qj/RzQ8pXDJ7s1FuMWXqQBQvNuLx4PSIZykDGZraPjQyLlhzRpGwyWr42NXsDhXjEKRvGqDwcDH5zvrRJ4P9S7/qOcJ3+7pj4+R2a85WfWTlSfU1p9rv9qge3x6jUXXLnJJ7novK/wz3WAoGV0DK16ShOB5EgA8W9uXDqCcH1FA/Vw7BIJAzu/1RbVwVYJLOoMuEJ4guhVAA7qAbFzwiRko/A+V4k+IkFhjXSx6V9HhJhbqfGaHLlKadhgaaCml0oallwYCcIvntawTb3gVbh4zDAxUU/bKWFlw6puVfA+ZeSzOztGB3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7sezX17o3UIM/n5R+Z+x60nWmnkcyjb9K4iKGmX8nY=;
 b=K/TbIBzXtm/MAB1joGHHjb5NQfyrkLpZ8RIoPNDadU8aDvZYl1M0lzt29ZVSQGkgRC8qagb+FEwan96mfNGCf+6jiWvW488d8Or1FqsqE6t9YaqG++pTkjkL7fMoeNQZuP/MkT818lhqkcAhF/pROt5mKBNAgd+0e9HkgymCkRA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by PAXPR08MB6381.eurprd08.prod.outlook.com (2603:10a6:102:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Thu, 24 Sep
 2026 12:44:53 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 12:44:52 +0000
Message-ID: <c918c068-bf55-492f-bb7c-fcf02b8c661b@arm.com>
Date: Thu, 24 Sep 2026 13:44:50 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Beata Michalska <beata.michalska@arm.com>, Elif Topuz <elif.topuz@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Shubhang Kaushik
 <sh@gentwo.org>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/2] sched/fair: Randomize equally shallow idle CPU picks
To: Christian Loehle <christian.loehle@arm.com>
References: <20260916100116.701206-1-christian.loehle@arm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <20260916100116.701206-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|PAXPR08MB6381:EE_|AMS1EPF0000009A:EE_|DU0PR08MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: da289838-0720-4ca2-b79e-08df1a39b4fc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 z6JkB2XcQ5nWVkYItp8TPRVzWO2sEWc4pJ8i0nn75PiwyACuLOOHhG6KcoGeQdEyDhr+gPJ4qqZK+qVZqhJY9x8pm8ad1yHhgNCA3WGp/I+xbDem/9ZdGCV7AItChSqCXzugFqOKTLeqs78uyA0g9cILgEi5xowlTV4Eb5foQEeVEOyiQQGt/8sbV9wtI91EDtmjkw0qq3eF6wiuLg6oQTnUhqHOE7BTj6MoP/Jhq4FXM234ZXViyei48zwSHcPhASaZXbgyjeauTbYLjSVRTv+iSpD3xRk6RKpXEWukkesjcz5sI36ncJaHh06A7OJ2INDH3cKAZkY27opSjQrcyDvLy0H0OzMfuEQzW1jU2E4J0fOoa+j5PPq2CIPwvMQ0yzSilfADJQn0m+5t7TTYNE4QAzEl3Co6HifvMxhO3uc/r0ygkQkhm76Qmq3rI/FmmLLyVrMwzn/nUseV+Cb8nT71S4zRmkEdI0yuMBfdVyXDXV/B91/1L38u7lbIjdlOw6mIq575WmpubwpEGXR2/J7mVUElD/A6yhdJfvRSrBqUO37DDNsYd5x1QEr14EdczEo7hje6L1rc+Ht1gOY1MoR8RPWNUK9scCcx0AfLFyKpljqA/YgpRP3gAd68IH40WCL7Hm/Bw/mYJNwJxAVi7CN4a+X+nHgaFI2PyKlYDQY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 zwi1MTrS1phiDNIonCNBMRAG2AwZU8dDhDgFwXnn2x1wlDGBf2VlvIFhwDgz3EK5qfTQJpQBJmKdVj6zyRUH/RhT1N6Y+pCYr+CvG/ySHM95snmKWVYkSreNPpAYo59xPev79U60ktEYcdxT35Ia4JSfUcTO/Ghukr53yxHDQ2S33hvAvycx9jM7jIqcWbLj4HoTvXGnjI0VFzLG8W2b+1sApXTEMibMK9MBmP2BfpFn1UEtdtUvoxxkWrYh0gJC907UmcufuFVPSvCc32Aom0T9PV9u69LXOpff9XuW8lXamz02pu8juZlliT8bXLyq3i2pirzfHVW5J8KIQi9oJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6381
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000009A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4fe37040-e9c0-4a06-a1ad-08df1a39a073
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|7416014|376014|23010399003|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	inNqmH2C0jeVj+02r19J0Ge6iGcuJmKrawUVa8oWG4RVaVKSBygHCDpLhc06j//XMuixZTo83FBDhNKkdjetzjX4eDU8dHPfNAPsywH/LfpRQtNzZZE2H1fPN5Dbi7rhpFU+unAl64HQlNcARziAYPaGtMdPxmEddJNju9NkSZ8Ece/fXdrKU4hawf1YMGFydnXIPxLywTcdAWN4oPLpa1y2IqgaGccEts2vuLDKjZkyffMRx4tJaXWzm8Pfx/X9eW+jTipgaqtS0Z2rZIwoGlx0B2CnA8+D7ORY7EeJox7042hyM5Y6ZybASdtaR7ZEy5+yM8p3xUd1y+4yYDgjb+VpicGIg66cXbGh6uV2APJOH420GzLv0sznI0njj+k737TGayQQgr2VZLZlPNf/6UPokAjKHz9qSloPy7fwt2VgdR4NYH/cT3Wp8VcHsiU5Tv/V053iWkeC7YcqZucg289wg0228SLlAVwdXJbzonjkEDvzm1F6aNv8/5X+epZP6l8bJj+mcNw0UTNq6k2GQgdsdurYAGKDloxouHBmGC0vEUfd2R3gkaDek3NIP9X7Vj7KM8LHyDEYJSoCMwtN7t0CZ+JeYF80Pz0OwJKLZ4+4vRPjUq1gu6wktdLBGfE/GcGPe64ZlJPJkYKSoWKWCF9BtWt1B/sHkthwIvtb0b4yTAm5ScfjWQsZZ3WlctyJ2JBmaKqr/eGo0C63beHTtA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(7416014)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hoxH3DuKB2AQgNzSK2F/zB2sykTui4uSKErTqQ5drjM8kpW9DyfFLaBYD4gyz133g1jdJf0sr0fveITOc6OG5GtZRVVKCYTK5vS1v5s/2y7iWbKZrAyK2i061QXnf3RV/az6KNjJcmp2mMKhJoLEy3q6muGx5TkDRr8+JKzQyuC088w8KSc6U5uqzAJJQZHZHIq7JeoUXoSflb9CGnjwasxash89XyQUpDWMvKF/OWLygB3FlwYffYtRcf+WmAw97SSwLK6gWVZmgOfyGOOfLdIziudhXh42ChM5II9GiwEejuEmwgOUR5rYQ0UY3FoNmRw04XGs4UQKFiVzvtw/6099ZgOAzdd3mDFcN0Q6hN81hCMSlF1K0XpS2J5uHzugLf4BrOhnE5f9je1e9P/4nJTMBgmnK7QsQiRk+sfog71I/wF6ZTdBtXDmZ+LqZKZr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:45:26.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da289838-0720-4ca2-b79e-08df1a39b4fc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9909

On 16/09/2026 11:01 am, Christian Loehle wrote:
> Concurrent slow-path selectors can converge on the same idle CPU before
> either task is enqueued. Remove the idle-recency preference and randomize
> equal-latency choices in a single scan.
> 
> The testing platform 160-CPU, dual-socket Altra has unusually large 80-CPU
> candidate groups at NUMA level, making this particularly prone to stale
> idle picks.
> 
> Median stress-ng throughput (bogo ops/s):
> 
>   --fork  --fork-max      Baseline       Patched    Change
>   ------------------------------------------------------
>        1           1        779.19        811.38    +4.13%
>        8           1       2958.32       2960.18    +0.06%
>       16           1       5070.95       5247.63    +3.48%
>       16           4       7692.64       7831.60    +1.81%
>       32           1       8662.82       8643.39    -0.22%
>       64           1      11880.47      12096.69    +1.82%
> 
> Separate instrumented runs observed lower conditional stale-pick rates,
> i.e. a busy candidate at final return:
> 
> Workload                Baseline       Patched
> ----------------------------------------------
> fork, 32 creators          0.771%       0.407%
> fork, 64 creators          1.242%       0.672%


Fastpath runs repeatable Linux kernel benchmarks. Higher is better; (I)
marks a statistically significant improvement, (R) a regression, and an
unmarked value no significant change. These comparisons use a zero noise
threshold and Fastpath's default 95% confidence interval.

Results for SUT Class aws-m7g.metal:
+---------------------------------+----------------------------------------+---------------------------------------------
| Benchmark                       | Result Class                           |   v7.3-rc4 (base) |   v7.3-rc4-chr-idle-v2 |
+=================================+========================================+=============================================
| repro-collection/mysql-workload | db transaction rate (transactions/min) |    244098.17      |        -0.02%          |
|                                 | new order rate (orders/min)            |     80570.33      |        -0.08%          |
+---------------------------------+----------------------------------------+---------------------------------------------

Results for SUT multi node aws-m7g.metal + m7gd.12xlarge: (Pleaes note that these two instances are not placed in a placement group so networking could be a bottleneck in this case.)
+---------------------------------+----------------------------------------+---------------------------------------------
| Benchmark                       | Result Class                           |   v7.3-rc4 (base) |   v7.3-rc4-chr-idle-v2 |
+=================================+========================================+=============================================
| repro-collection/mysql-workload | db transaction rate (transactions/min) |      231145.00    |           0.03%        |
|                                 | new order rate (orders/min)            |       76208.00    |           0.05%        |
+---------------------------------+----------------------------------------+---------------------------------------------

Hence:
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>

> 
> Christian Loehle (2):
>   sched/fair: Drop idle recency from slow-path CPU selection
>   sched/fair: Randomize equally shallow slow-path candidates
> 
>  kernel/sched/fair.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> 
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780


-- 
Thanks,
Usama
