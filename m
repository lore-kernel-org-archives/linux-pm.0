Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519243644A0;
	Wed, 27 May 2026 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895168; cv=fail; b=H11WMIdyVdIiRi1cmbivfts0OQqhrrlEo9gIb/v3kyWYwXCQVzv54FkxAr8StAIYiyfXnSzee2zUii0VQQva0bdPTa/RpGCYPHjnWJKRMWhK7GZJhJwLIuQAAl1SPX2bqypLQ/DlWNETR2F1snZMw1j0q008QCOFmYGm9MwScC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895168; c=relaxed/simple;
	bh=9r8/DJkuSM12dPW5C1TVeaauU6evQvVZC1kvy2+g538=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ige4rQhg6QGSKdkh2qi76BjG4AQlrKs/WEqxv1QuyPCkO77XPXLj8wsFO2QSYtjEcteS3ZAbQrw4hO3181lE0qQxru7smsxJtmH+rNaWsF11VlTY2KdlANXVWyirFLkeJ1Oc5ub0+K6WAsMAEpFWS3ASUCxpF3b74hs/34v5/mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OrOeR/Z7; arc=fail smtp.client-ip=40.107.208.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OrOeR/Z7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWkBwa73UygQ99GV83ohwz75qF4M7lfHw3NnqpTFq/HZ7GmK46pguZIEgepFxtr3IC3P+p9ooQsEYct6viG+fc59fRoNwF5BHhaY4LnJ4pYFHqI3w1oaoSmdDCtC48Y+/eeneKprSstwAIreljLwGvF1awsE0Tha/I9W9w2QyJABxQY0QxMniL4KJ3OqxAatiHaVOVIDFaMX5Fy138zPakKpLgwCS+FMDwCAHAcUg/pgms4yh8hnbtGK3W2yIp4ZOuGrQ6cezf7Fo0soQ3xbFoWFFXW0ONSwIIOVm3lEsmoFJ7XD9+ZPJ8h3cUOmX63PkRMh9a/OWHm/NF/xIGrnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXxEB0kQBZRFk+TFGkOuY9amo7mlvMHSnALmHd3YtTg=;
 b=L+0JstcV7PAJghkOeOvKq4sN7azslNahhESAITatIrlsfNVanKaxTUXcP2d0av9d4i9rulT922BHGZd2+ZC80QyrtAkkAUz41dNDoknCWN4O/FbddXqm8Zo1B6yUaQ2mIeJyNZtCnCtUGKx5GaWXMCOFAa1ljfa84uJpxBEyXwbEJTCUYwgNzFri8XD+Q0RQ14PePM0UNOnpwbTyOMZvMwotO7s8iYgkz2/vNy4Tur9ueqHt29emgEyrJ+QP/oSPnId9W7HvQvFZ7nu3zZI3i3w++rxycJVg6yfRdVwt+d4lEI4uyfI7WWDuc6gvT+KWYyJIKKZVqu6la4X9hY2ZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXxEB0kQBZRFk+TFGkOuY9amo7mlvMHSnALmHd3YtTg=;
 b=OrOeR/Z7zdRs3f6QrIXpzERHxiFt4+haJuzBWK+d0ie1oFcReudXAYCAXpsrn0zJIT9QF4+/dyC5N5O1ZjwqR12O1U/qaJBbQqI9TrOtTDnDLz74IINcyWAQQAx0rMNxOd5Au5gzroK6YcULBQC3NmDXSxxLn5es0/uoRqyf28U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 15:19:21 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 15:19:21 +0000
Message-ID: <158d23ba-33b7-40c8-8d71-bc30f27e81f2@amd.com>
Date: Wed, 27 May 2026 16:19:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add CPPC HighestFreq support
Content-Language: en-US
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org
References: <20260514215626.35327-1-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260514215626.35327-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::10) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1f7dca-8ccb-4864-5e29-08debc0353fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	km81+BerkkGsl3bq1STt9El1R1voR3ktqfcK8ZpDT4057t/n8JcDiWmzuSVormqpgwjDPepabl4Mo6fBkrVJsPP+FXqK3/aVexF04aqK/AkluX62LZ78l5+HycnZypfZ4k51nIRlZVR/SYfHTpIDvnQMkuvcnzxy7YcSnG84LAFfoYH45c28V9pHoN+/fbVI2dNIQbCc8S3/X7a3bwCsgwUrQaTBrV/U5rvEheE553qkoKwb10OC9AcMfw+8muMroOWh4JzsF6s8PjDusBViRIUcqSduJ5cIHO7Z95B+CgxbSgb011nXJ5CFRjbuhOqIcr2rU9MK8kIWDUsBz72vNkl9pW5DpHqLFiaFAPrTFiX3YTamu+mMS/2G10oEsLJVpdj0vmN0idwX/N06wUUkliKP7hRze/h542lwCAgrykRKBpCkGdV1VOI9Isk12NtcDnsTXavCPaOzk/I7MoQA25j0WcU48TKQ3kZI7T0BJNLmOSVojR/NUQ15k78Hftnj+gkB9MlDi+bHmAUAZQNG198hq3FNpKx827Mo9MrZy8S5u5IUsKcKkBUIroiIi53p4YrtUBuNBlQhiCRv9mO60kZZ8pHg7gtzuyyBtdldVg2pIpsFMP6pwUr3zTxfowy8HJxw/TtUe3ovSPTl7m7Zll6mrPqJqKkJKxEDMkXaQ8rBWQHDlrgelqES4dYMKsHT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXpHR3Zhd2hVR1d0dWcyTWtGOGxLbUd1cXpUR2dFVTVlcGxtRXU0VmRLbTM3?=
 =?utf-8?B?WHVtNS9LQXdVcHFrUk8vMkNTMEhNaHdjYXEyUERkOFZMR2JKVHE3Tm1yVjNh?=
 =?utf-8?B?TFJBMzJQdmNJMzlmVXR2cWIzTEt2bTMyd2E3Z1pZS0R3UkVpd1QwZE1vY3pF?=
 =?utf-8?B?bk1JOWpJczJjWENrYXZqY2FuUVhhellnUnd0QjNucVZpTGFmZWRzTldFS0JO?=
 =?utf-8?B?OWlNYXZWaks0MTlaVzBWUEd0ZEZTd015ZFYvT0dVek9oY2Y0dklHUC9UVTNr?=
 =?utf-8?B?eWRSNVNRMHRmUFJ4dzRHYmx0bllJOGxieitTQ3djM3NySm9TeDlWS21aNnZj?=
 =?utf-8?B?RVFqVm1xS1FpNWRWL1hKcUxJVklJS2FRY1BKMFV3aHB4Rk5PUXo4U01TVkcz?=
 =?utf-8?B?WE5HY3JNN3YvRHNsT1ZPVHZoTHh5RmhyVE02V1dYRkVncERiU1BKdlFqOHVF?=
 =?utf-8?B?eFR5K3cxbnE5UHpFMWZHUkZsUGJNT0ZIRDU3UFBGQTAxT2NraVVnUUoxSys0?=
 =?utf-8?B?UXVxczNjZElMZUxYZ1pxZFN3ZjRlRlNzVFE5MmdpK2RiV2tHK2xTRlg0WllJ?=
 =?utf-8?B?d0hVQUcrRDZndXN0YVA4MjVoRTVVRlN2TnRoWGVvSVNTMGhJbkdIcGxmUGkv?=
 =?utf-8?B?RDF1WmZUaHNyazN5WjU0WGFyUnlaWHZmZ0hibHpzZ0hoUVU3WlVkU1lqaldn?=
 =?utf-8?B?dERubUVHQWRaUU5iU0NUY2JsU3dFQklrNFNuZ1JiNlhtbUROK0IvNXNpYlZB?=
 =?utf-8?B?cDhJamp2RnA4eWpLaDZiSnI1YmR3YmVLd1FLMnZTWkwzZ2J0TFVvalROSTFJ?=
 =?utf-8?B?UnFZVGk3ZVdwbitvY3hHZXc1QS9nOC81c09lQisvWkJXWXNUbmVZSi9jVFBZ?=
 =?utf-8?B?R0pOVDU0NW12WnlXM1BwQldJMW1nTGJKSmZRbU9YMEp3VlorRHVDb2p3eDdT?=
 =?utf-8?B?T0s0ZmErYnFGK3U2MlZWeFhOeWNMSHJLWjdic1c2WVc2aXNlekplUkZqcUdL?=
 =?utf-8?B?TnkxQUdob2NLcnNLZVlET0VPUGtjQVc2aGxqeEQxWTEzVDBFdkFFaFZ1RW43?=
 =?utf-8?B?RGZwNXJFT3ZoTnVRZDdxRGFId2EzNDk3cGJFUUUrZG01VHFrMjFtcHVJMjM3?=
 =?utf-8?B?S0FZOE5taEErV0hjUjZaQXBOZGtzL25vdXRXdDBzcTFNSHZkMktVeUcvNXE5?=
 =?utf-8?B?Mmc1Zk9kV25PQnZxOFlCQjJpdHNJLzQ5UUdhRjFvSHJzR1RQRUkwcEI3NE5m?=
 =?utf-8?B?TkFVYlh6QkVzY1gxYWc4aU5CYytQMUJVZjN5MjFYRDFCcXM3NExUYTVlSVpt?=
 =?utf-8?B?L2lNeGUxRGlQcUdlUzI4eHppTGcrSStSdmpzMzRXdy9rUjRlbTBwdTg3dzVN?=
 =?utf-8?B?YjdnN0pjRy9TcWhQajRwVEI2SVJkaEZCYUhZb3Mzd0hvTE8vazlaS0x1THhV?=
 =?utf-8?B?d3V1bmVkWmVWZFFKV2FLaHRLb0Fscy9yQnd0WmdVYTkwaHdNL0JPVytjRm9U?=
 =?utf-8?B?TnhWcURrcmJTNi83VXhGZ0QrZi90NGtzYVpaQ29hYXVXNUIyREpHWmZXSnMv?=
 =?utf-8?B?OExYb09sTnNwUVBraDhJczc5bDJsTnZNZ0FOOE5OQWxsRkt1Mmt2RVV2a0Vi?=
 =?utf-8?B?aktvYjBJS1I3Q0U3ck9VVS9uaHppQ3pKeldXSWdSZzZraW9OZnhyWjc4aXBH?=
 =?utf-8?B?VEFqeWZtTGFobTBZbDJyMGhGcDZubGtudXBmK2JGdmFiWWhxR25vQXZUQVVr?=
 =?utf-8?B?bDB4bCtFMmZCV1k1TzJhRHgyM1h6UXV6YVMxR2dJdms4SzlzWGVidjM2K2Np?=
 =?utf-8?B?MWVLdjhiWU1aNytySUtYRWxoMGZEcW1SQVVzbitrUVFEZ1JNakZYUGJ3UEx6?=
 =?utf-8?B?MlAyZzdtcXh5OHd6WER3N21oREo0eGFEK1IvNnM3aVhWSTNuRmxMK2hoQVho?=
 =?utf-8?B?ZjFmTGVZbDBSa1FEU01sYTFtcW94TjZUY05QZzJuZTA2UFIzMU9kZ3kzUHpl?=
 =?utf-8?B?aS8xamJiTGFMT0VvWEhLQzFEYjZpcFpycmdIYWVoRW5JenhRZ0MxNUVya2ht?=
 =?utf-8?B?Z3BjWWNOS29YOVluSExQNDB1ZjFlZ2RpSy9PeFMzdjdmRHFlZ25qMkl3L1g3?=
 =?utf-8?B?QzF1U25DSjA3bmJ4S3V4RU9CbWZJTCtNYjExN0VNbklnNUl0RW5qZFFOclhq?=
 =?utf-8?B?K3YvSjNHTjR6NStub2FTUXU5WHRmNHVwQ2VpbGdRem5INU5XYmY4ZGNzZkdp?=
 =?utf-8?B?TFNFUFVOZ2VlTFNWMWxhSzRyc3N5VTNVbTYzQisrWmVOQ1lURnBPbS9kV1I4?=
 =?utf-8?B?QVFkcnNxWml0aVJuVkVXblZNTmxQZVQydGZGQm1IV2huellnak9JUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1f7dca-8ccb-4864-5e29-08debc0353fe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 15:19:21.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uvPGrztvNluDcun15RH2tjCA9fYi6WJ3xQKaIrCcUIr8qTTC4Rs/XSrwF/GCyMBl5pEMPQHlfIMvz05RlYYHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758



On 5/14/26 22:56, Mario Limonciello wrote:
> On some systems, the boost ratio cannot be accurately calculated
> using linear interpolation of CPPC performance values because the
> performance-to-frequency mapping is not linear across all cores.
> 
> This series introduces support for the CPPC HighestFreq register.  This
> register is under a proposal with ASWG at the moment and trending for
> inclusion in ACPI 6.7.
> 
> This optionally provides the actual highest frequency eliminating
> the need for interpolation. When available, this frequency value is used
> for more accurate CPU capacity calculations and boost ratio determination.
> 
> This series adds support for the ACPI 6.7 proposal. It require's Sumit's
> CPPC v4 patches.
> 

Hi Folks,

Sorry; due to some miscomunication this series jumped the gun a little 
bit as ACPI 6.7 hasn't been released and it should wait until that 
version of the spec is released.

I'll withdraw this series right now and re-post it after ACPI 6.7 is 
released.

Thanks!
