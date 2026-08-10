Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8642B75A;
	Mon, 10 Aug 2026 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386697; cv=fail; b=TFpafPU5xGJpASQnEPJ+mXTrEsXnE4/DagxmXuQLCDrm/yLrrIO+EMdLK5oXymtEZsbvWRgw4wmRsRPx3UV4D2+5Pw5pjr9gzrf8O3kjqA3BYg6L5juuUWyU09sOU2bWTDXLpJ/4a3hegT4ky4xz3hZbPoH6de2fltwOX5UQhcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386697; c=relaxed/simple;
	bh=R7sX9HtT9uJNIrYa8rY+45Qro3uehxTmOSc0JIdMPC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aipJixCEYxEn6kT0oChBGe3PmS+Ys3bzgVShMp8EFjutY+XRMws8x5IS9kjvW9F4ftxttDwB/hb2zpTXejqD7vHzZQQanCs4Zr/bH9238jp6yHUFYR5YogIqskmsnokKogh+ZC0cCVgJ5JLe3Az2iNGcaP/1Q+uz2xOFMt8Vwjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mM8r0WvY; arc=fail smtp.client-ip=40.93.198.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mM8r0WvY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjHGha6VLKb3Z6A88TQu1IGqIkw/C2RRwx3eM9IEL95ByR2oV3Hx0CRk9lxeVdDjsRMIrPy84fbU1P7dS+cQCduK3DymmI3MOHhgDMw5gYiuL60DP5R/YSD86aqyFVEmd/YXDPmS9DR5PQaXtmFsKHxRMU8T+CZhpHiRTRRbm6IjIDmc/mMsVaVCiGdAwlonjLqTYnP2MOtWt/fa+FMIuEi+Tk8qzOINU1q2amp0pWTf7WVRSQfUFj4OvNRNewJNDDTp3yQCLUPXGcw0AalqLiA9Z9vA4w4MGG8VjWr7uqBvxQhEH99zsXjbh/GDzafNGSlQqYVIeYsuF+xCGwRIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YDp/mqzsfQBxvzrZsVyoPTd9Nfy+LNMXISBSzdK+c0=;
 b=NO+gdwDVw36SAq4WycfGmrhPit8AQ3PeYS8JuzkZWteCx6oLhfrvTqWsq5UM5JIc+2H0J/DkA8x8lwJKyvnvucOcWnoNS7mXlDKf8aPtNI1vU5YOKiPfZVB0ZCiNpkdv74r+THa3RcyQXfLYCa8F6HEFreyFoyDPiHo1xJOVCptrLqhrsXEOJdLdFf0GKxxdDo4qFHkWH1QqEb4Nm/rHaKTmaXRKhH3gb7cS6dV1YYlygHb5ppbEVwLrjHXEGzdxc1jp/PZe9oU/BdsfTVRlhvTPFfusLyNyMv/H3XJQ1M+OPmVD9qr28EKWslYcH31CA7SGvSuROrrCof4Yl7wFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YDp/mqzsfQBxvzrZsVyoPTd9Nfy+LNMXISBSzdK+c0=;
 b=mM8r0WvYx0HoK97ktXL08h7TtRdmV0X1b4yuQzjdpGP8ho8TQ51iGgCj3pUnIr6rdkBdq/dGY8ohIVqawQ5JIWHTb4gmeaBOcaX8RAEK+JKcRo7RNunhCH1KJM7Ho47NFAbeBnQsbN2Q2Rm0DoVYCD34TkZl2qGHExUkPrgkgCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 18:31:28 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 18:31:28 +0000
Message-ID: <131d39d6-c2a9-4d80-99e9-526d347bf608@amd.com>
Date: Mon, 10 Aug 2026 13:31:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Sean Rhodes <sean@starlabs.systems>
Cc: x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
 <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
 <CABtds-0MUDmxK_Vd_P8CijwzUhQEV4eWNzx1+DbN2wfnY4dbrA@mail.gmail.com>
 <20260806012923.GEanPjc0w24EdEquDk@fat_crate.local>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260806012923.GEanPjc0w24EdEquDk@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::20) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: a97af044-010e-4e44-bfcb-08def70d9781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	opEgUjhqezyiVmERzdkChK/Sy0uAkiBb5ovkZJXmpyiaqN/FajqFDAA6BD1Bpn+hF+x1MU9+Pb1VMLA7Lyi+njvwjkIGGXjo/W1hc9b2Y6ar2Hn4DaTtoIcbl2AAkQb373qLAlB3nNOqVF4dq6HHQerwDOfy1MPACLa6MhVBhFmr738oKzHpoOpTVvU8AAJydT+Q6lXKvVEcthKuN7HcvaASouLCI+6FCnEgcCbzKvExlc2BfnfrnE+Q79xn25YL0OETDREbdvbxuUbip2zPq9W/u03kvdcx4pVulY2YfTs5S7frLDDVPpLIhb+ACIjzsUrg34EMDYPFsdj7WdODgc5TBDdMIrKB9eMJlgVuivEz8OlSXJpVN8ES7Srro6HKad3WUBgDAv5Sy+PztYmq7ZqskDXt6BBO2U1GKUSw3zhfPBJZCqLVUmCGn8YxdvffcdybbFXvGW1EUBWKt9uX71qFJQt/GKTUg64dbZwDX9NW5smcH3bzRvzJQmufliT4bF4KQWBmptcXvNZ0OhaKUPN7mgJh2CK+Bul4kRYb3S86rkn+Pf1kjE2heTtdCyw1JOTEddOR8xAOeCE2ISwtWQ9puzZPkB4MNfoGOIwT6uQ7lSGqKt26XzELJuh4vOSP/Tjiw9viCXvsnw8CYysWYWkaaKjgXUI0sWRFUdvOfEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDRpWUprUUt0TWRpZEdvS1hJeUVjUEM2djUyWjVHNzZWK0lRMTFMQzh0M2xh?=
 =?utf-8?B?aEVOVUlEUlNQSzZRRTJxUnhFZEx5Z0RQWFNLM09RdE9mNFJUSC9ycVVMNStQ?=
 =?utf-8?B?ak5PM1ZKTlFaRnVKQ0Z5ZUZIakxqMDdLVkNsdlkzeDFSQm1TWGNnQkdsYllV?=
 =?utf-8?B?NzdZdVhrbjF1ZU9wZStnTFhodk9ER2tRZkdwR2VmalMrcURuY1NDcmVYem1U?=
 =?utf-8?B?bm03VDdFWDA3NUFWQnhlRzhjb2Y4M1p4dzhPR2g0TnVOUUhBR29NUWthbGFL?=
 =?utf-8?B?R3RZMFdzN0tkcEY4cDBaRDBHelhpampLeGN1VnFlL3pwbzdvTlBLOG1xOG9x?=
 =?utf-8?B?cDRQRzFqeDErTXIxaVFlaGtvK2Ixb1Q0VXNPM0ZsSU1ISE9OS3Fva0lQWExU?=
 =?utf-8?B?bVBhRE5qWEp5UnZDZStjN3BPNzdWNFZtYythbHE2VGhsNW82c0FUUzEyYVlL?=
 =?utf-8?B?RzVIVHV0dHNnSGd2MlFFRlJ2UG1ka2dUdGVqYlh1NmNSSkJUaW5QdklkTGpF?=
 =?utf-8?B?ZEQ3Ym9xTTNESmk3L0dHNFNWVTdxclBZcG9QWk5COVR3VFZqS0Fsei96cXB0?=
 =?utf-8?B?Y003Y0pRaURHYktqSUhNS0tSQ1BvZmJVUlJsQmdBT0lRYTJNTnhVOUh4MGU1?=
 =?utf-8?B?Mi9mNkg1ZWtBYnpRaW5wVi9VTC9qWVNVaVN2ZStucDI5cmNXV1lqMWwzeDRK?=
 =?utf-8?B?YjJCNzhNdHdiaUdlTllIaTlmUDl2ZCtEQjJ0eFNDVVlabmJzVm0vOUVJZDh0?=
 =?utf-8?B?Umo0OE5UVVZHMjk1Rm01WTg2eXJnUmlqdUJvYWdESjNEZVBRVXFFaUJqZ1Na?=
 =?utf-8?B?VlJsVTZCbFFRVEhXM1p6U2grNWh5clZ3cXNQMW1LWnpEUFF6UDdjQ3hlY0Vs?=
 =?utf-8?B?aXdkbEZ2TFU0NlMzVFFKWTdtZmZuWUZtaFF1VVZ3UmtLeW1xYUxhQnFKTkQv?=
 =?utf-8?B?UHROM0ZlNEZ1ZGEvdmw4d3JSY0loMkw4VXZkQTNONGNtUUU4WGFRZlVubnhH?=
 =?utf-8?B?Sy9RV1F0ekcyNzljZFkvbFZrS2xnS0pBNklNUDNRajhjcUZ1T1U4NDUvTmZS?=
 =?utf-8?B?ZEVOWGlnRmNxbXJrSUR2Zk0zNnVyeXI0THAvSmdScVRFSnMvWXRkbHhwbDgr?=
 =?utf-8?B?UDgwRUhpam9CSkFob0xkR0dUbEJiQkdmUnRHcm0xNVpHTzJKWUtxalVaQ3pN?=
 =?utf-8?B?NFRtMk1FVDFhYTRTUEV6Q0J4VjNZZG03akIvYVJ3bXBiTVBPbnppSzBnbmpo?=
 =?utf-8?B?TXpVRWdSWkszM2VDSVBjTXhZOVU2T3NMSUJ1MGpvNEROa0lJN0hnWWlZcVA0?=
 =?utf-8?B?V1lrb0VqMmNRcE5Sd3ZjcU9vQzFtc0hQek5sZHJQOG9yaTVOSG5KOFlFUHoy?=
 =?utf-8?B?TWRoUWd6bXlLVDQ4WlRsRzczTHozVU15eHpQZVgyOWtKZWwyZE9pMy8xN0Fu?=
 =?utf-8?B?Z1Y5Z2hvUWFPc2ZSb3BZcW42RGFhcXlIQ0VTR1IwcElKazZDenY1Y3VpV3Bm?=
 =?utf-8?B?ejRBb3dLZGcrOVR4MzZLSVRtNjY5WEdnWVU5N0NaL0FWQ09sdityeEhXeTVS?=
 =?utf-8?B?akJBQ2ZnaW1oU1YySHErMEpIM2VPRVNJU3RJWUJJaVcxZ3krY0h4UDVDYWlm?=
 =?utf-8?B?WVcyV1V1dFhZcmxSTXdmS1BJREFLd3dyRFVFOFQvcXBBaGdUdWdWcGVTUVJ2?=
 =?utf-8?B?U3luRDFySm8vWktXaUM1eHFsS0l2OW9UOXJYbVFUbEFORHFjNVZBbVNtTGV4?=
 =?utf-8?B?Um1JeUxQTi9Ub0tmaC9WMkRsUE4wbVFyaUdBU216YjNwK3VLMTJoNkRZUG1r?=
 =?utf-8?B?aUl2TE5WYm1SVkhzOFlCYlV4aWx5Z0cvMFpkdUx6Z25wQ05Md3VEdmlvL0Mv?=
 =?utf-8?B?b1Vpc3U0RFRiOTBHTm0ySHFlMEJ5dWtWY1NTa3hsa1ZUeFhjTCtMMjhPbmFL?=
 =?utf-8?B?SVA2dlhha1p5OUk2bkFYaFFWZVd2dTZQVnJJT1U5aUJlSUl1TUZ1TkY0TzRB?=
 =?utf-8?B?QjNZV3F5THRFOWdwQkdjY1hvN3ZLWEZZSmxsMFUwam1naUFPbXhETFk0dFcy?=
 =?utf-8?B?QTZFY3lTMUxYWDVYT2tzOGtyNGVscUxVTkxZN2tqbWc3OWRodmNLNWR2QnBv?=
 =?utf-8?B?ZjdGV3ZXR3M3T3dDcEdWc0lIMTAvVnJGTVkwa2ZtQmNrMUx4TEZ3TDhhUnlk?=
 =?utf-8?B?THc4R3BnMEE3TzdvUmNhdDRTTkhmZGdnckVRNVpTTlRMVlNCMHl1cUtYRVJH?=
 =?utf-8?B?a3Q1bk5xNnlBS2VWRXh2dUYxR2dEM1JoTTRldmlCUFFNbSt3VVJCZDdxVDRx?=
 =?utf-8?Q?OMOO4L+uJUc+a4MEZj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97af044-010e-4e44-bfcb-08def70d9781
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 18:31:28.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmtEEuOZqdzjKLQ684c0qykQ0Gx3dgOJVSSMg7tAG8wPAw/6+CVn4QP1GwNwnvsiJhrzSNvzk5NwIX+b0RXvwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825



On 8/5/26 20:29, Borislav Petkov wrote:
> On Tue, Aug 04, 2026 at 08:22:36PM +0100, Sean Rhodes wrote:
>> If you're saying that because there might be a firmware solution, I am
>> all ears, but this issue is present with AMI CRB and coreboot+FSP -
>> hit a wall trying to fix it there.
> 

Does this only happen in coreboot + FSP?  Or it also happens in latest UEFI?

Does it only happen in S3 or also S0i3?
How about S4?

> I'm making sure you're using the latest one which might potentially have
> a fix...
> 
>> Why not?
> 
> Because we're not fixing three things with one patch and without a proper
> justification for the other two.
> 

I would expect the restore of this register to be the platform 
firmware's responsibility.

I don't know right now if this a BIOS bug, an suspend/resume bug, or how 
wide of an impact it is.

Your fix might make sense for "this single platform", but we don't have 
any evidence it's needed for any other one just yet.

We shouldn't make changes because there "might" be a problem.  We need 
affirmation from testing or an assertion from the BIOS team.
