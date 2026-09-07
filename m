Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6B45D5E4;
	Mon,  7 Sep 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777211; cv=fail; b=XlKGs+6qvtThewUfN0HlcjYZM5BpUz0iGz8zj3DN5Qre1ZER8Y2GHdWnHR3Ibx3wqk6nZf1AKnwvuqdcxWd6j3JaF19rq+mZANDr/qRK3dmd9TYxfBhZgoqCNkYLfdbQgX/EDPEFYdKF9F5aAtmzudk6eHYIrFBQWltvHWQRBOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777211; c=relaxed/simple;
	bh=tJeIrpIiC3ZtTS9XtSBuH1oetQZpQnsfbNnQ1M7LfIg=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=Ae1SiMM9IGZrVkiWEjzs1M1rThFsqgUSIzHAmzr4o3lwh5fzJvbpwLF9lME4+XFW0U52zBgT7Ufe1oINpoSsQ0hLbNTkcE1Vu5MRjG7PJAwy3nPdq5wrzJBANZSdpaxRH05iuH0VgucH2tZTxBEONlOrYTG2XO1M6CM4ApuSu+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eWHaVaXV; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eWHaVaXV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLar5+mW2uowN91mUKAPgulPzzrIaCPil+cpbqqiW6jPk350ZVzHUvQj2E3IMm1P9N755PxT9tS1uytwRbN3hoZgDd+TKfMqH5RhDgFEiuMkyKBSaCR2PcnGcpKedm+ozBYtKgZx6TkRbcLxzBTl12pcoXuU2mA9NfZjsv9B4OZrP0Gxs9k4Xk4CU/maR2DJBtkkWYGp92n8aXlBGn1lKqeoqv6QYSjwgWM2/3HMDbweX/82iS2QLWY4ffs8KUDf0aqPTvvgzgKc4PuMokT6O2ogXvQPQVuF/zqRVxs0igWRfwl+aUkK5pFfFlJoj8+uK2OoSq9tM11McpNnYPmJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSPfpeyUEZ0JPSrfxKtjpfvFIYd+85ILWECB63sUo8Y=;
 b=JEFIoFC/ypVkAyrmQPua4WchW5eQ6eDidH9VfimY0g/OTwkawSy1x4W1ThLB/clUYt4HvjC+4kl8TR9BC2GhIFto+4Bq55MO/QWhnKkxYmGM3UkWwY4YTIGIKbegz61HBYdkIFjrdIZe71jGBNiZcLKKO7MKSZmNLRalQh0zrfg5wZNi4WcG649ZsoLGRKrRE3bxUxVDwgrxLvuKNXuyan7zKQm+fdzjMZz4eMIN7JDUzI5RTXyfTn7y4pSR6CV2C5sU82syMhTIt7lTP8NKC2C6etRneLiYbIOPNkQpNlljR1VOAoBcWgU94+ja5t+TWUkxwMzY2hfeOw682Moobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSPfpeyUEZ0JPSrfxKtjpfvFIYd+85ILWECB63sUo8Y=;
 b=eWHaVaXVhBZ0EXE4+8dvE1WLLY/fKjXMURe3p9PxtoBpsNxc2JQZ/M2eaJS7CXAwBnFNwP0btRbyoKgQ33NKE/yZlTdnPLhB6/XICHAqeo/YVwsrN8xj1f8nrM+TFVwP6Wgb0gfStgvu//5TkmYHNxvpNCsfVCf8hoPMY4EzSAC1fSsmCHrfydvP6ONKC8E2ppYw8FZGKtLNQNXMfhKDLF6svxvg3eaULqoqjyv99J+R7hdg0XFXW4Qqgs6rKqI7lR9Fzih+27wMqDz0b8SSaPHVVsTZ8H+H6fjMJmwrLEbGL25FsLQs3exwYabRNP+FSDykZ5/lAr1m25l5ieSfJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:33:18 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 10:33:18 +0000
Content-Type: multipart/mixed; boundary="------------vOUzAA7cuoMZxjrSOoeawUWX"
Message-ID: <55a5c9fa-cfd3-4000-b3cc-52c343841c9f@nvidia.com>
Date: Mon, 7 Sep 2026 16:03:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/15] ACPI: CPPC: Clear Performance Limited without a
 stale read
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com, Sashiko <sashiko-bot@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260830115644.2056983-1-christian.loehle@arm.com>
 <20260830115644.2056983-16-christian.loehle@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260830115644.2056983-16-christian.loehle@arm.com>
X-ClientProxiedBy: PNYP287CA0102.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b9::9) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: b9162dfa-577e-43c8-6378-08df0ccb6e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|6049299003|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|4053099003;
X-Microsoft-Antispam-Message-Info:
	l+T7McprAHSnWRVWt8hR6dGIMkZThd9vMBM4SVeblqZ6nqJforEKIq2ukSVv7EOi6W+uAi7eZ0g7AbGP35nJCjLHYKmXDr4UULT/PgL4SBOiulJEs/ChBC4PJAsPA36BwuFnT7QS4Vkr70UzQgNP8/JkJVOI5AMN8weeYrpIoRtum2iAsQbNXnLzj5K/4i07SjWY5n2rYFdX1/Od/eZzbRYe3hzE//xEKtDv5AGV6t+l5P2p9DbWxM3tUPZIue7B4M3A6pcHNpZm6wbGMhT/dkyPo25FXsK06YXNVpKxAHJzctrlK6cMav8rgZ7OThA8plSGqb7EtuJ3hX0Ts/hkskswEWlC7fjZ5SCSzAO6WbYMXKpfNGw9jAieAcR6mTaD+vThWpM6/0u3glTParYl6Ai8W2IWQbrMnBwqF3CiGVkPIYKmHAVhVpzz/RIiAkjAxOsJ4ag4sO8BRqwgyQc0fkmB4jbGwY5XpY4q97yix7herQYCIete6z1AgIoTHL5FYHje5xbz+VuK7T0wOu/UdPMYW3jMhcpgxg3N7viHV/Mn+/GqHf7bR9kAhiBvh5vv0ZqUypnx+0Iiy6G6li7IzMtRrjTCZMPgxe2F/NWGJ7hIuiFfKhjXtb6mVFj9BaEPyGv93Rb6qenofwwdLUXxanlpd7xmOWyDdmy99IESaQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(6049299003)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2NMamt3RjRLemJYOHZRbitvNURMOEo0b09Bd2dCQUF1SmJxRWdDT0dHelhB?=
 =?utf-8?B?aTRablA5WWVtZlZXUUs1U1pjMnJKK2VuQTdxS0ZpUGQvNHdyWVZUb0NlbkRO?=
 =?utf-8?B?ZXNMUDJDeklnWThVTXkzYTRCWmZBSHlrUnNLLzNiMEpteDZQQmI3V0NtN0lN?=
 =?utf-8?B?V2RtRFB0MC9KdUJKdWZkdHVvVkhabGtJSUdWaGtzQnREMmFZMWxBOEViQ0Iz?=
 =?utf-8?B?MTdlV29OSjJTUVp4ZzJHbW82TFdhRldMbkluYityRUhOeDBKZXFzQjhJRld4?=
 =?utf-8?B?c1RkTFQvT2FWMTBROC81QmxKTGc2dDIrVGROd3NsSkNZaHl0aDBJK0NYUzM2?=
 =?utf-8?B?ckhBYll2LysvUmI5M1NTTjNJVmtSbGw3RnlWODJ3aTRBVEU2eXZTdDJSKzUr?=
 =?utf-8?B?VDBXa0ZvNFc3V2F5WWMxaXJLOWpEajRyTmlXVVR6dmxKK2Q0ZTRZRkhBOW4y?=
 =?utf-8?B?RE1CUmdNSGpzdm04cDlhb0VodTVQVFJXa0tNS0c4VE5yUzZtSWRFT2N6K29x?=
 =?utf-8?B?SmlFQktKZmFZNFpYbCtVRlp0dEpNazJYeHpCTmNHWjZpcktNWlhhcm9XTnZR?=
 =?utf-8?B?eURsS0JBSWFRdGQrT1EvZHhtZVpvWG9OeGROVUVrUVY0RFplQjR3Wi84QTFG?=
 =?utf-8?B?cHNtcDF3alZ2UTFENkJMUzZzY3dha3BLSkgzcEhPTWJRZHVmU2lDb0hiOFlh?=
 =?utf-8?B?dW1XZUJ1UEZKZWQrK0d0bFM4S0pGL0UxNkJVamJTdDc3NDB5aHdCdXZ0d0VQ?=
 =?utf-8?B?SEFuYUh1ZnA4MXBmZTkwWlYwWkxhR2xPS2UycGJ6VHlQS2ZKOGdqMkZYa2Jp?=
 =?utf-8?B?RGVqckVyZzJlRzJXRVR0QXY4d2RUd0lCUWlHbTNlazBaWlhVR3JBUnprNEJE?=
 =?utf-8?B?TnhDTElaNTc4ZnhHYUV0YjNhY09oWFA0b3MrQzdzbUxtZGlXZUE1RVlYdWEv?=
 =?utf-8?B?VlJnTU5CQlpXRldhWFdSVE5ucHlCOGV0eFFLREUrSWNGMTZPdHpNb0t0OGZ1?=
 =?utf-8?B?YmZtRGdPSktwY29wdTJzM0NXN3dKU3pQUmc5c0RzVlZYVlhCOXVFcnExK1V5?=
 =?utf-8?B?QXBPZXNBV3hrUkRMUGxYMjdPMkttUHVCM0thK25PbXpqMDVkeEFMVzk5cXFK?=
 =?utf-8?B?L0p3Si9jMzYvdTh1cEpGTi9FeXYyZFd5M3dDZmM2b0RWbjlxOXpvNzNxc2NR?=
 =?utf-8?B?SXZRUklTbHlWNFUwQVZMZkZsTitPeHRHTFhDRTZBOVZza3Nya3dtSzlhemx5?=
 =?utf-8?B?MDRGVWVZUnFxbGVXU2lZY2lCQkZPL2hEQ08zYmtBNUZuQktNbk5vRlRFd1lT?=
 =?utf-8?B?MHoxNzhzQ3JqcEk0dm55RklJZm9EMmtGZDdnSmVWTGZ5Q1NGY0pvcEd0aU91?=
 =?utf-8?B?ejR1RmxMeHY2Q2VrNzZiUjk5TDM1SGtIWVZyT0hSL1M4b2ptSXJjb3BOL09F?=
 =?utf-8?B?b0FDREIxTGdqZGl1UHNQdkNEOGFqYmJxU1BzM0JNZFdjSDZSdlE0Zlg1MElI?=
 =?utf-8?B?SFk1LzM2bHk5Sms5WS9iY2VidlRTR1ljZGx3VzMwM3RJa1RGaVdYZ1BBTDdT?=
 =?utf-8?B?YWRYN3lVNDJGN2JLZGNNUkwwcjlQeW9YVTlUTEw4R1BMcC9xWUNuT2xrQUdD?=
 =?utf-8?B?V3RJakpGSHZuUERabWFTaWJ0bWhXWlVCMTdzYWYvb2J2OTYyT1hjaExrZENV?=
 =?utf-8?B?OFMrdldZQ1RjWENLdnY0WHhIK3RjY0ZZTDdiY1hCd2ZUeTMvTS9mL1hJNnVG?=
 =?utf-8?B?Vy9DMVRiVDJkUUxmakZDM3M0RHo2OHV4cFpoODQ0SDdOc1BldllWM2ZVcisz?=
 =?utf-8?B?ZSs4N1EyU01CNW1LMkxRY3VQcisrNXRhK0hSTk1LNG9SS3F0bUhIcDRBRDkz?=
 =?utf-8?B?elVZNDlrUGt5YVpPV0k2Rk5aMmhPZFRwcTZWR0wzMlRuMXpUbnpuVkN6ekVH?=
 =?utf-8?B?N2RxRFVseWh1SUhtRVFobC9jeU1DcGl5ZDFyYmZXYVdoRXhER25HYkFCSTlq?=
 =?utf-8?B?Ym0wdlJ1K3dzZWR2UnVTNHNIUVRIQ3R6eHZ1OE8ycm51VXhpMTluQzd2bmxp?=
 =?utf-8?B?cUVUYlJhbzZLbkpQOENTRVRGeEdSaHJFRXUyaU1kcnRrNkRSb1BSOHBqdGdy?=
 =?utf-8?B?Z3RFU1BvVndiSlU1eWQwRjhJWTl0VXRGdkJJTzRxdFlXblc0aWk3NTk3c0Jo?=
 =?utf-8?B?Szl3NHcwaFYrZ3dJTFR5Y2tLUm12ZUdRak5QbE1wZFlzS2pQUjlWaTNiSG54?=
 =?utf-8?B?MGEvWFd2eXNHWXFZakRYTlVjRk9yQXNOTms5RGd3ZWg3Ym4zM0gxdGNqQWZH?=
 =?utf-8?B?UkVyU3FXbmZGV1pRV3A1dFBVbDFRSEIrNGVJaE1aZFMyYllqbnFQdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9162dfa-577e-43c8-6378-08df0ccb6e4e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:33:18.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRVH3Z4rfCcDU9VTRv/n6yHPw/o6k9Mej/AySbN7V99EKcNTWcRil35Dqw3zW6g42BEShaHHUoMRnCLoCLVkGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457

--------------vOUzAA7cuoMZxjrSOoeawUWX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

Continuing the discussion from v4 [1].


On 30/08/26 17:26, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> The Performance Limited status bits are sticky and write-zero-to-clear.
> ACPI 6.6 Section 8.4.6.1.3.2 also requires both entities to use interlocked
> accesses.
> 
> cppc_set_perf_limited() currently reads the register, computes a new value,
> and writes it in a separate transaction. If the platform reports another
> excursion between those transactions, the stale write can clear that new
> event.
> 
> Write zero to the requested bits and one to the other defined status bits
> directly. Keep reserved bits zero as required for hardware status registers
> by ACPI 6.6 Section 4.6.1. This removes the stale read window.
> 
> A partial SystemMemory field would still make the generic writer perform a
> read-modify-write to preserve the containing access unit. The
> per-descriptor spinlock cannot interlock that RMW with platform updates, so
> reject clears of such a field. Keep the descriptor mapped and readable,
> because reading the containing access unit once and extracting the field
> does not require RMW.
> 
> Classify a field as a writer during overlap validation only when its _CPC
> semantics permit writes and its validated resource remains writable. This
> allows partial Performance Limited fields whose clear path was disabled to
> share an access unit with other read-only fields, while still rejecting an
> actual writer in that access unit.
> 
> Also reject another writable SystemMemory field sharing Performance
> Limited's access unit. Its RMW could similarly replay stale status bits,
> and an OSPM lock cannot serialize against the platform.
> 
> Also reject 64-bit SystemMemory descriptions on 32-bit kernels, where
> generic readq()/writeq() may be split into two 32-bit operations and cannot
> provide the required portable interlocked access. A naturally aligned
> full-width QWord remains supported on 64-bit kernels, where the
> architecture provides a native 64-bit MMIO accessor.
> 
> Retain any inaccessible Performance Limited descriptor whose conservative
> physical range is still locatable, while marking both reads and writes
> unsupported. This includes a QWord on a 32-bit kernel. Skip its mapping and
> the flexible-address-space capability gate, because Linux will issue no
> access, without hiding the asynchronous status range from
> neighbouring-writer validation. Both the interval registry and pairwise
> overlap test use the larger of the access unit and logical field span, so a
> malformed field extending beyond its nominal access unit remains covered.
> 
> Performance Limited status is not required for CPPC control. If firmware
> describes it without even a locatable physical range, disable that status
> register instead of rejecting the processor's otherwise usable _CPC
> package. Report reads as unsupported rather than returning a synthetic
> zero, and emit a single warning for each nonfatal fallback.
> 
> Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/acpi/cppc_acpi.c | 76 +++++++++++++++++++++++++++++-----------
>   1 file changed, 56 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 25bccd4cfb34..a07440ed7f80 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -443,6 +443,22 @@ static int cpc_validate_sysmem_reg(struct cpc_desc *cpc_desc,
>          if (!cpc_reg_access_aligned(gas, access_size))
>                  goto invalid;
> 
> +       if (reg_idx == PERF_LIMITED) {
> +               if (access_width == 64 && !IS_ENABLED(CONFIG_64BIT)) {
> +                       pr_warn("CPU%d: Performance Limited register cannot be accessed atomically; keeping its range reserved\n",
> +                               cpc_desc->cpu_id);
> +                       cpc_desc->cpc_regs[reg_idx].cpc_entry.read_unsupported = true;
> +                       cpc_desc->cpc_regs[reg_idx].cpc_entry.write_unsupported = true;
> +                       return 0;
> +               }
> +
> +               if (gas->bit_offset || gas->bit_width != access_width) {
> +                       pr_warn("CPU%d: Performance Limited register cannot be cleared safely; keeping it readable\n",
> +                               cpc_desc->cpu_id);
> +                       cpc_desc->cpc_regs[reg_idx].cpc_entry.write_unsupported = true;
> +               }
> +       }


Agreed on the generic behavior. With Bit Width 2 the remaining bits are
not part of the register, and the driver cannot treat them as reserved.

On the firmware option, I confirmed with the hardware team that
bits 31:2 here are unimplemented. They read as zero, have no side
effects when written, and are unused elsewhere.
Future firmware can describe the register with Bit Width 32, but systems
already shipped cannot be updated. For those I have a patch which widens
the descriptor to the access width, so the clear becomes the single
DWord write you describe. It is pasted below and same attached.

Testing with that applied uncovered a second issue.

The commit description says the status bits are write-zero-to-clear.
I could not find where that is specified, have I missed something?
ACPI spec describes the register as Read/Write and requires interlocked
operations, which reads as an expectation of read-modify-write,
but I found nothing defining what a written one does.

Here a written one sets the bit, and the hardware team confirmed the
register is plain Read/Write on my test platform.
Writing CPPC_PERF_LIMITED_MASK & ~bits_to_clear therefore sets the bit
which is not being cleared, and Linux reports an excursion the platform
never signalled:

  #cat /sys/devices/system/cpu/cpu0/cpufreq/perf_limited
  0
  #echo 0x1 > /sys/devices/system/cpu/cpu0/cpufreq/perf_limited
  #cat /sys/devices/system/cpu/cpu0/cpufreq/perf_limited
  2

The read before the write avoided this, at the cost of the stale read
race you describe. Clearing both bits would still need no read at all,
because the value written is zero in either case.

How would you prefer to handle that?

Thanks,
Sumit

[1] 
https://lore.kernel.org/lkml/d5f1ea9b-53b7-4db2-983a-b5be8e71a371@arm.com/


-- >8 --

From: Sumit Gupta <sumitg@nvidia.com>
Date: Thu, 3 Sep 2026 20:17:42 +0530
Subject: [PATCH 1/1] ACPI: CPPC: Keep Performance Limited clearable where it
  owns its unit

Firmware may describe Performance Limited as a field narrower than the
access unit given by its Access Size. Clearing such a field needs a
read-modify-write to preserve the rest of the unit. That cannot be
interlocked against the platform setting further status bits. The clear
is therefore disabled, and writes to the perf_limited attribute return
-EOPNOTSUPP.

The generic code cannot do better. Per ACPI 6.6 Section 5.2.3.2, Bit
Width is the size of the register while Access Size only describes the
transaction. Bits beyond Bit Width are not part of the register, so they
may hold unrelated state and Table 8.26 says nothing about them.

Some platforms do implement the register alone in its access unit, with
the remaining bits unimplemented, reading as zero and without side
effects when written. Firmware conveys that by declaring Bit Width 32,
and _CPC offers no other way to express it. Describe the register as
owning the unit on those platforms. The clear then becomes a single
interlocked write with no read, and the status bits stay clearable.

Add the NVIDIA platforms with that property, matched on the OEM ID and
OEM Table ID of the DSDT. Only a descriptor narrower than its access
unit is widened, so firmware which already describes the register
accurately is left alone and the fixup lapses once such firmware ships.

Reads now return the whole unit, which is correct here because those
bits read as zero. Overlap validation is unaffected, since its range
derives from Access Size and already covered the complete unit.

Amend the descriptor before it is copied, so layout validation, the
read-modify-write lock decision and overlap checking all see the
corrected width. The descriptor lives in the _CPC output buffer, which
this function allocates and frees, so amending it in place is safe.

Change-Id: I4817d3d0a08a02603d925819b733428f96ecf0d8
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
  drivers/acpi/cppc_acpi.c | 40 ++++++++++++++++++++++++++++++++++++++++
  1 file changed, 40 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a07440ed7f80..1985e19f9eb0 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -330,6 +330,44 @@ static unsigned int cpc_reg_access_width(const 
struct cpc_reg *reg)
  	return reg->bit_width;
  }

+/*
+ * Platforms which implement Performance Limited alone in its access 
unit, with
+ * the remaining bits unimplemented, reading as zero and without side 
effects
+ * when written.
+ */
+static const struct acpi_platform_list cpc_perf_limited_owns_unit[] = {
+	{ "NVIDIA", "T41", 0, ACPI_SIG_DSDT, all_versions },
+	{ }
+};
+
+/*
+ * A Performance Limited field narrower than its access unit cannot be
+ * cleared, because preserving the rest of the unit needs a 
read-modify-write
+ * and an OSPM lock cannot interlock that against the platform. Where the
+ * register owns the whole unit, describe it that way so the clear 
becomes a
+ * single interlocked write.
+ *
+ * Widen only a field at Bit Offset 0, so the widened field still describes
+ * exactly the access unit.
+ */
+static void cpc_fixup_perf_limited_width(struct cpc_reg *gas,
+					 unsigned int reg_idx)
+{
+	unsigned int access_width = cpc_reg_access_width(gas);
+
+	if (reg_idx != PERF_LIMITED ||
+	    gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY ||
+	    gas->bit_offset || gas->bit_width >= access_width)
+		return;
+
+	if (acpi_match_platform_list(cpc_perf_limited_owns_unit) < 0)
+		return;
+
+	pr_info_once("Performance Limited owns its access unit, using Bit 
Width %u\n",
+		     access_width);
+	gas->bit_width = access_width;
+}
+
  static u64 cpc_sysmem_access_size(const struct cpc_register_resource *reg)
  {
  	unsigned int width = cpc_reg_access_width(&reg->cpc_entry.reg);
@@ -1861,6 +1899,8 @@ int acpi_cppc_processor_probe(struct 
acpi_processor *pr)
  				goto out_free;
  			}

+			cpc_fixup_perf_limited_width(gas_t, i - 2);
+
  			cpc_ptr->cpc_regs[i - 2].type = ACPI_TYPE_BUFFER;
  			memcpy(&cpc_ptr->cpc_regs[i - 2].cpc_entry.reg, gas_t,
  			       sizeof(*gas_t));
-- 
2.34.1


....
--------------vOUzAA7cuoMZxjrSOoeawUWX
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-CPPC-Keep-Performance-Limited-clearable-where-i.patch"
Content-Disposition: attachment;
 filename*0="0001-ACPI-CPPC-Keep-Performance-Limited-clearable-where-i.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4MjI4N2E5OTQxNWZiZmE1M2VmNGZkMTA3ZGM2ZDE2YmJmODZkNmQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdW1pdCBHdXB0YSA8c3VtaXRnQG52aWRpYS5jb20+CkRhdGU6
IFRodSwgMyBTZXAgMjAyNiAyMDoxNzo0MiArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSBBQ1BJ
OiBDUFBDOiBLZWVwIFBlcmZvcm1hbmNlIExpbWl0ZWQgY2xlYXJhYmxlIHdoZXJlIGl0CiBvd25z
IGl0cyB1bml0ClgtTlZDb25maWRlbnRpYWxpdHk6IHB1YmxpYwoKRmlybXdhcmUgbWF5IGRlc2Ny
aWJlIFBlcmZvcm1hbmNlIExpbWl0ZWQgYXMgYSBmaWVsZCBuYXJyb3dlciB0aGFuIHRoZQphY2Nl
c3MgdW5pdCBnaXZlbiBieSBpdHMgQWNjZXNzIFNpemUuIENsZWFyaW5nIHN1Y2ggYSBmaWVsZCBu
ZWVkcyBhCnJlYWQtbW9kaWZ5LXdyaXRlIHRvIHByZXNlcnZlIHRoZSByZXN0IG9mIHRoZSB1bml0
LiBUaGF0IGNhbm5vdCBiZQppbnRlcmxvY2tlZCBhZ2FpbnN0IHRoZSBwbGF0Zm9ybSBzZXR0aW5n
IGZ1cnRoZXIgc3RhdHVzIGJpdHMuIFRoZSBjbGVhcgppcyB0aGVyZWZvcmUgZGlzYWJsZWQsIGFu
ZCB3cml0ZXMgdG8gdGhlIHBlcmZfbGltaXRlZCBhdHRyaWJ1dGUgcmV0dXJuCi1FT1BOT1RTVVBQ
LgoKVGhlIGdlbmVyaWMgY29kZSBjYW5ub3QgZG8gYmV0dGVyLiBQZXIgQUNQSSA2LjYgU2VjdGlv
biA1LjIuMy4yLCBCaXQKV2lkdGggaXMgdGhlIHNpemUgb2YgdGhlIHJlZ2lzdGVyIHdoaWxlIEFj
Y2VzcyBTaXplIG9ubHkgZGVzY3JpYmVzIHRoZQp0cmFuc2FjdGlvbi4gQml0cyBiZXlvbmQgQml0
IFdpZHRoIGFyZSBub3QgcGFydCBvZiB0aGUgcmVnaXN0ZXIsIHNvIHRoZXkKbWF5IGhvbGQgdW5y
ZWxhdGVkIHN0YXRlIGFuZCBUYWJsZSA4LjI2IHNheXMgbm90aGluZyBhYm91dCB0aGVtLgoKU29t
ZSBwbGF0Zm9ybXMgZG8gaW1wbGVtZW50IHRoZSByZWdpc3RlciBhbG9uZSBpbiBpdHMgYWNjZXNz
IHVuaXQsIHdpdGgKdGhlIHJlbWFpbmluZyBiaXRzIHVuaW1wbGVtZW50ZWQsIHJlYWRpbmcgYXMg
emVybyBhbmQgd2l0aG91dCBzaWRlCmVmZmVjdHMgd2hlbiB3cml0dGVuLiBGaXJtd2FyZSBjb252
ZXlzIHRoYXQgYnkgZGVjbGFyaW5nIEJpdCBXaWR0aCAzMiwKYW5kIF9DUEMgb2ZmZXJzIG5vIG90
aGVyIHdheSB0byBleHByZXNzIGl0LiBEZXNjcmliZSB0aGUgcmVnaXN0ZXIgYXMKb3duaW5nIHRo
ZSB1bml0IG9uIHRob3NlIHBsYXRmb3Jtcy4gVGhlIGNsZWFyIHRoZW4gYmVjb21lcyBhIHNpbmds
ZQppbnRlcmxvY2tlZCB3cml0ZSB3aXRoIG5vIHJlYWQsIGFuZCB0aGUgc3RhdHVzIGJpdHMgc3Rh
eSBjbGVhcmFibGUuCgpBZGQgdGhlIE5WSURJQSBwbGF0Zm9ybXMgd2l0aCB0aGF0IHByb3BlcnR5
LCBtYXRjaGVkIG9uIHRoZSBPRU0gSUQgYW5kCk9FTSBUYWJsZSBJRCBvZiB0aGUgRFNEVC4gT25s
eSBhIGRlc2NyaXB0b3IgbmFycm93ZXIgdGhhbiBpdHMgYWNjZXNzCnVuaXQgaXMgd2lkZW5lZCwg
c28gZmlybXdhcmUgd2hpY2ggYWxyZWFkeSBkZXNjcmliZXMgdGhlIHJlZ2lzdGVyCmFjY3VyYXRl
bHkgaXMgbGVmdCBhbG9uZSBhbmQgdGhlIGZpeHVwIGxhcHNlcyBvbmNlIHN1Y2ggZmlybXdhcmUg
c2hpcHMuCgpSZWFkcyBub3cgcmV0dXJuIHRoZSB3aG9sZSB1bml0LCB3aGljaCBpcyBjb3JyZWN0
IGhlcmUgYmVjYXVzZSB0aG9zZQpiaXRzIHJlYWQgYXMgemVyby4gT3ZlcmxhcCB2YWxpZGF0aW9u
IGlzIHVuYWZmZWN0ZWQsIHNpbmNlIGl0cyByYW5nZQpkZXJpdmVzIGZyb20gQWNjZXNzIFNpemUg
YW5kIGFscmVhZHkgY292ZXJlZCB0aGUgY29tcGxldGUgdW5pdC4KCkFtZW5kIHRoZSBkZXNjcmlw
dG9yIGJlZm9yZSBpdCBpcyBjb3BpZWQsIHNvIGxheW91dCB2YWxpZGF0aW9uLCB0aGUKcmVhZC1t
b2RpZnktd3JpdGUgbG9jayBkZWNpc2lvbiBhbmQgb3ZlcmxhcCBjaGVja2luZyBhbGwgc2VlIHRo
ZQpjb3JyZWN0ZWQgd2lkdGguIFRoZSBkZXNjcmlwdG9yIGxpdmVzIGluIHRoZSBfQ1BDIG91dHB1
dCBidWZmZXIsIHdoaWNoCnRoaXMgZnVuY3Rpb24gYWxsb2NhdGVzIGFuZCBmcmVlcywgc28gYW1l
bmRpbmcgaXQgaW4gcGxhY2UgaXMgc2FmZS4KCkNoYW5nZS1JZDogSTQ4MTdkM2QwYTA4YTAyNjAz
ZDkyNTgxOWI3MzM0MjhmOTZlY2YwZDgKU2lnbmVkLW9mZi1ieTogU3VtaXQgR3VwdGEgPHN1bWl0
Z0BudmlkaWEuY29tPgotLS0KIGRyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYyB8IDQwICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jIGIvZHJpdmVy
cy9hY3BpL2NwcGNfYWNwaS5jCmluZGV4IGEwNzQ0MGVkN2Y4MC4uMTk4NWUxOWY5ZWIwIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMKKysrIGIvZHJpdmVycy9hY3BpL2NwcGNf
YWNwaS5jCkBAIC0zMzAsNiArMzMwLDQ0IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgY3BjX3JlZ19h
Y2Nlc3Nfd2lkdGgoY29uc3Qgc3RydWN0IGNwY19yZWcgKnJlZykKIAlyZXR1cm4gcmVnLT5iaXRf
d2lkdGg7CiB9CiAKKy8qCisgKiBQbGF0Zm9ybXMgd2hpY2ggaW1wbGVtZW50IFBlcmZvcm1hbmNl
IExpbWl0ZWQgYWxvbmUgaW4gaXRzIGFjY2VzcyB1bml0LCB3aXRoCisgKiB0aGUgcmVtYWluaW5n
IGJpdHMgdW5pbXBsZW1lbnRlZCwgcmVhZGluZyBhcyB6ZXJvIGFuZCB3aXRob3V0IHNpZGUgZWZm
ZWN0cworICogd2hlbiB3cml0dGVuLgorICovCitzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfcGxh
dGZvcm1fbGlzdCBjcGNfcGVyZl9saW1pdGVkX293bnNfdW5pdFtdID0geworCXsgIk5WSURJQSIs
ICJUNDEiLCAwLCBBQ1BJX1NJR19EU0RULCBhbGxfdmVyc2lvbnMgfSwKKwl7IH0KK307CisKKy8q
CisgKiBBIFBlcmZvcm1hbmNlIExpbWl0ZWQgZmllbGQgbmFycm93ZXIgdGhhbiBpdHMgYWNjZXNz
IHVuaXQgY2Fubm90IGJlCisgKiBjbGVhcmVkLCBiZWNhdXNlIHByZXNlcnZpbmcgdGhlIHJlc3Qg
b2YgdGhlIHVuaXQgbmVlZHMgYSByZWFkLW1vZGlmeS13cml0ZQorICogYW5kIGFuIE9TUE0gbG9j
ayBjYW5ub3QgaW50ZXJsb2NrIHRoYXQgYWdhaW5zdCB0aGUgcGxhdGZvcm0uIFdoZXJlIHRoZQor
ICogcmVnaXN0ZXIgb3ducyB0aGUgd2hvbGUgdW5pdCwgZGVzY3JpYmUgaXQgdGhhdCB3YXkgc28g
dGhlIGNsZWFyIGJlY29tZXMgYQorICogc2luZ2xlIGludGVybG9ja2VkIHdyaXRlLgorICoKKyAq
IFdpZGVuIG9ubHkgYSBmaWVsZCBhdCBCaXQgT2Zmc2V0IDAsIHNvIHRoZSB3aWRlbmVkIGZpZWxk
IHN0aWxsIGRlc2NyaWJlcworICogZXhhY3RseSB0aGUgYWNjZXNzIHVuaXQuCisgKi8KK3N0YXRp
YyB2b2lkIGNwY19maXh1cF9wZXJmX2xpbWl0ZWRfd2lkdGgoc3RydWN0IGNwY19yZWcgKmdhcywK
KwkJCQkJIHVuc2lnbmVkIGludCByZWdfaWR4KQoreworCXVuc2lnbmVkIGludCBhY2Nlc3Nfd2lk
dGggPSBjcGNfcmVnX2FjY2Vzc193aWR0aChnYXMpOworCisJaWYgKHJlZ19pZHggIT0gUEVSRl9M
SU1JVEVEIHx8CisJICAgIGdhcy0+c3BhY2VfaWQgIT0gQUNQSV9BRFJfU1BBQ0VfU1lTVEVNX01F
TU9SWSB8fAorCSAgICBnYXMtPmJpdF9vZmZzZXQgfHwgZ2FzLT5iaXRfd2lkdGggPj0gYWNjZXNz
X3dpZHRoKQorCQlyZXR1cm47CisKKwlpZiAoYWNwaV9tYXRjaF9wbGF0Zm9ybV9saXN0KGNwY19w
ZXJmX2xpbWl0ZWRfb3duc191bml0KSA8IDApCisJCXJldHVybjsKKworCXByX2luZm9fb25jZSgi
UGVyZm9ybWFuY2UgTGltaXRlZCBvd25zIGl0cyBhY2Nlc3MgdW5pdCwgdXNpbmcgQml0IFdpZHRo
ICV1XG4iLAorCQkgICAgIGFjY2Vzc193aWR0aCk7CisJZ2FzLT5iaXRfd2lkdGggPSBhY2Nlc3Nf
d2lkdGg7Cit9CisKIHN0YXRpYyB1NjQgY3BjX3N5c21lbV9hY2Nlc3Nfc2l6ZShjb25zdCBzdHJ1
Y3QgY3BjX3JlZ2lzdGVyX3Jlc291cmNlICpyZWcpCiB7CiAJdW5zaWduZWQgaW50IHdpZHRoID0g
Y3BjX3JlZ19hY2Nlc3Nfd2lkdGgoJnJlZy0+Y3BjX2VudHJ5LnJlZyk7CkBAIC0xODYxLDYgKzE4
OTksOCBAQCBpbnQgYWNwaV9jcHBjX3Byb2Nlc3Nvcl9wcm9iZShzdHJ1Y3QgYWNwaV9wcm9jZXNz
b3IgKnByKQogCQkJCWdvdG8gb3V0X2ZyZWU7CiAJCQl9CiAKKwkJCWNwY19maXh1cF9wZXJmX2xp
bWl0ZWRfd2lkdGgoZ2FzX3QsIGkgLSAyKTsKKwogCQkJY3BjX3B0ci0+Y3BjX3JlZ3NbaSAtIDJd
LnR5cGUgPSBBQ1BJX1RZUEVfQlVGRkVSOwogCQkJbWVtY3B5KCZjcGNfcHRyLT5jcGNfcmVnc1tp
IC0gMl0uY3BjX2VudHJ5LnJlZywgZ2FzX3QsCiAJCQkgICAgICAgc2l6ZW9mKCpnYXNfdCkpOwot
LSAKMi4zNC4xCgo=

--------------vOUzAA7cuoMZxjrSOoeawUWX--
