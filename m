Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54383F788D;
	Wed, 26 Aug 2026 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774195; cv=fail; b=F6nehjHaALKbr6LSR7+TMu09wzHeAo+9HmF3mKvfw1KcU3iq962g3Kpa6wTaU3cfyFydjlHlf3qYn4wsfmvyY9hcedx5wcxEo33v4Z/yu2m02AlWdAxXryUqNYgO6lXZG8ptWFwLxMVlNx0YgTAguNtPJyUYNM4JfkzYBwF2uLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774195; c=relaxed/simple;
	bh=YSCJHnUXTfgvY3VrPpxz7ND5udJbybhFKsP3kDQpsjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N71TXVmPbvEJl61PPpCqCWQj38bQOJDz0yvh7/T80MwbPn0onKi3EToqI+hIpZIBhX6+ca0VcH9qRXMzabsEWDNl6bUSzPDFenbB2xlT044JXtvOmHzAPpnUkLx3tqItYMRnY/3JE91INN0iGXl06erACMGNWcsuBce2Pvm3+B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OFqDjYhT; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OFqDjYhT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR+IrBGKNDY5rM1l6nXaVJtV00QxgoQmW4csoox7mogiJsit+KRPPBwMvVo+6mc2axY+bfMVC76dziXPWMGAQWFHTh4sowNDB/aw1OehLi+KF4aLO2RB42RkvBH+YSc/RnaKJRsNxMi8BoZ1Zf3yVPk2Q+Z2Z40gffw8isO9Xj7/oE4zjW5hMbzyOj6SeezYybiSbK9XfK+QPXbzbme4UW3KRdZmBSXXGNMFUR7/Z1vMQMhbyhWTxId0BwQToALCCIRbIFt0t9Fno56xFRnnVlAB6grsLbGpoDNRyAHGYxhHihA5ypTncTVMPBDT8wdHiJqm02M+UBUX3j2WWPj7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddbxz4gK8caIuwyS6OPC7ig3R0pqszzlcIStVgqGjeg=;
 b=JUSPGxBUKZVz0vfR9g98P7Im9iVT3JuqwbMBaAWFZVFXa50xRiuFcTi9PZaj0xN/8eyrhsEqLN2n8K9Z/MFsWIl9ZOoKqmsPnLuyKpWbixSi6tGU+xXASNxSUTPK6lITaQeQ7c6Z15HkYByLKwqxvfsc9BqRI3J2gTCGGXsYcwoTpBxrXL7KpBU28mB5ntKVofU51gkU6adRLNspoiTK/kLnrxlSAZP4alCHxrV4+Xf5VZcMWclZzPt4zTw3BQeqPJ3KS6jUyKoyyQeHUB29uGfeoy3eMPL+zQa+beyWHj6bX/lqDYeW/KbZ2dVp54twNxlnOy6gzWYOQtpnXV/ZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddbxz4gK8caIuwyS6OPC7ig3R0pqszzlcIStVgqGjeg=;
 b=OFqDjYhT5AkXBihZA3vA/GdwJzWKBEwExTXNX2fiSIcN8Nz5zB4q6WL/1YXwfmzm3jscgxoH8TTrH0o2+jcMvxmb7CfW6isVjSlXFI4jLk/eY6Bp3Pj2T8yp5tdYxk//WZ/fge0pnzqagy+bsa7SVvUU2zv2C44n3Ojo/HXcU6mX2i529is2Dc3JjmOufQPytqh2Fojev4y7EBfldPgRsrQT1MCprnXib7HPXm+YCbgAv8A5U/CuarEP742jGQHZzrL73YxRAykG0hUiOwOuOchybbUd7qn6/ic85OwDeBTtln41iPHXX6zkT36V25eLw/QWkNn/BXngRjdkJO1kPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 19:56:26 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 19:56:23 +0000
Message-ID: <067ccb72-5324-4f4a-b21f-d1ce87f78ad0@nvidia.com>
Date: Thu, 27 Aug 2026 01:26:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260806200857.601152-1-sumitg@nvidia.com>
 <46d81167-1548-4b6a-b6cc-38542b2d093e@nvidia.com>
 <146a49c4-5b2a-41db-90fd-6dd2028d2d53@arm.com>
 <CAJZ5v0hMRNTZbhb1tR7rf5+65Oes-7K__b1dLg5kGkm7NqKvWw@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0hMRNTZbhb1tR7rf5+65Oes-7K__b1dLg5kGkm7NqKvWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::16) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|DS2PR12MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: bb640f6c-a0c3-4f6d-268d-08df03ac1ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|6133799003|5023799004|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	MmcvF92dl6S4iIbQ3RbGXsRTK9RZjvX+NZisn4SpHtksvakHA2jncU+v43z5w1A3ofJ5E09MqrkwFkob4cPCZEVxaEonYZc7mkPdU/Q91N6hXLQtC3gagkpHrUOk1iV3G52pbl918R58J68OklNij6B8r1EG+t6nzfgok36ztPhfOrYM/hoTwDs6nUUay4pV8ftDebcoS1+qCH/o4ivowxOiJiesfxQzGOsqiSI3OjdXLqqmJzmogBqbt15j71JRF9OXR4W1eKrfiVkMweu9GKFB5RnFbrfUqfEfzCxEzAhPOEp9tby7UBdo2DgTTqin4qEvP6uqdLNY6MX54aFJRQz3HQtOe3pfKjXyjKt8bJYDiC6vucPaXkoNzZ57FLAlBXNsp73sXYM9QUGsiBK9P/YSuKp9zL/6TnG62KCzoCkULMX/qFxY70rT27BUZNwZurZuXKJ4/Ls52xyEXiyf6U91l0xGujptR7o+4c5X0jXXO4Z4qW0oPAUEcXtRWqgAGgpYdX3CFQXuvUC3HUJP5S7pEOgKXGTHJp5/uumqhM/2GEOq5Ees9T1BB1F59TxbtK0oefnNN/U4udFtN1QMRJPp9Dcj5NXbG4U3IwpEMETZ1F9lenLLwuACuPP1gcoGBB8E1VVBGtSb9DnLJQgZOQ+8tW2tLt1CZVq6YU5Qe/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(6133799003)(5023799004)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGdVSENBUjFMTFAreG0wTFltTWhYZXd4S1JJWGJlWllldFFRVUNYUU0wQUJQ?=
 =?utf-8?B?d0xDbStiNUxDdEJkT2Y5eG03dlpwRGdoZTZTWHN3M2tFYVVmeko5Y21XeWp2?=
 =?utf-8?B?RXFYUllyUW1GMmpPd005VzZhQk5tQ3hCWU9GNmgzNE9ja1RlcTFXRjBhY2th?=
 =?utf-8?B?aEFTN1NndmVYMTB1dUo1RHdqcmF6RHZpU1hFMXBrRWVTbkpJRG5qbG1tdXh0?=
 =?utf-8?B?RGV4UVREOXdyTDZYZE40b2FyeXU4UDFUcFZHWUFMbFBvNFB6Mmw0ZE1yRGZ4?=
 =?utf-8?B?cGhqVTRybUp3Ylg2RDZjanNLdHFFamtZc2d1eWQ1MVl1ckhGR1FLT2dUSmcv?=
 =?utf-8?B?aTlneUF4ZGpodjN1VFpYU0RTOS95RjREWXpDMjZ2YjdUMG9UUnRTSzVhcWxC?=
 =?utf-8?B?MWNWZjlxbVRPMEhXRU9rTFNEQjNzRE9MNzd3Yzk2WFhjVWNtOUVkTkJJbm42?=
 =?utf-8?B?a3pPTEovblJWUUo1bk8zWUVTSUh6dmMyOG03ckFyZE1MdXVSSlROcGh1VVlE?=
 =?utf-8?B?Zm1yZXdqK05qb2pKMXloRWU3aXdmclE5c2tsR0pvc1VWb1BpZThYakI4bHNW?=
 =?utf-8?B?UEV6eFVqaW5WdmFXdW1UVXhBcXFFUi8zUTRHTVo5dkI3OVB5RGpXLzR3Q1hw?=
 =?utf-8?B?a3ZhRm9DQVRVMEtBbU00bGEyTzBSbUFlQjZZU2dQVDlLSTZYL1dZeWdOUDlp?=
 =?utf-8?B?cVQ0bFFoUklNMzA0UE9kVFVMQ2F1dFFrM2trc01DSWRMQVVwQUUvcmdWRFFG?=
 =?utf-8?B?QmtGN3ZmUjBRYU5QSGduRnh1am1VUzYrcDA1MEdGUFVNNEFWWDVyOFBpK1lD?=
 =?utf-8?B?bVNFallnQXMzdG1mVk9pbkk3Ukt2QzlBS2I3T0Fia2tNNzRXcnpYTTh2eTdC?=
 =?utf-8?B?S25JMjdUODJ6MWowRWhEcHJSdUhrbXRldDlZbmloY0FNKzlpQkJiakxRSC9G?=
 =?utf-8?B?TUR0bGFqbFJaR2ZiekVCWlpsdkxDN3p4SnpobHFDSDI0TzBrQmhIZE1XazUv?=
 =?utf-8?B?dEFKVXhCUG53cnpocEFtYmorNmVvRWN4VTF1VVRreHhzK3lJc2dIanl4LzlC?=
 =?utf-8?B?V1UzeG83SzFGcmV1QXgyMXdZcDBHL0dTbWF0QzY2QkZPbEl6MXdhNFd2MXM3?=
 =?utf-8?B?Zlk1RUNQNW1YWDhuRXRCU0htVHZjSWkvZnFSZ3FEdWFLVUZJNVE2L0d4cDcv?=
 =?utf-8?B?RVpjUVBOOTNpWUpGMktwakxqMHZHdlV3cC9uazdvNmlhUnJla0JzYi9rcEVX?=
 =?utf-8?B?dFREZkQzeFFyT211aFJNZmFwdjBJWmc4M2I0RHFJZmxSRTRCS0h6dTlMVE82?=
 =?utf-8?B?c0pQZVV6OTFvNy9Pbmdxai9xTVZxeTRBcU9oU3g1RWZPaGtTeUcrRlkyenZi?=
 =?utf-8?B?VENTTTVRYkdMdVhYUm05V2VzVHdPQW9hazUzWHFsVUNRcFhUYXZZaS9vbnli?=
 =?utf-8?B?WTNScythdnF6aDZmOEI1Q1BQUWNuZE5oT1FrSEozbEJqNG1uSmpuVlRCS2lS?=
 =?utf-8?B?YXZOS3JyRHBxaXRvdGhKcFArdlREZmpoRVRpOHNvcnJMVmJLYldLQzdBTlhk?=
 =?utf-8?B?SHA3N3UxTndZajlOODVmeXNjeFRtOHI2MVFrZitwd0VDNjN0Ty9TZDBvUWpH?=
 =?utf-8?B?S0dpSkg2WTR4S2REaURkRjNkbFhKWUJNL1p5ZjZ4NUdaNk1ybTk5ODR5ZWw3?=
 =?utf-8?B?UndEa1NRVnF2dURXVUhLZzF4emdXQW03S1VjaTNXTEJla0d2Q1FuVHFXeGlz?=
 =?utf-8?B?SGl4dyttek1iTlB3RzdOZkZMWkloemplU1BXSEVwdEE0Nkhmc25sLzFkTUpI?=
 =?utf-8?B?MFQyR3JENDd1STYyYldoN1JFbWV1bENoSkY1UHFlSUNwNG85ZkZYSi9nU2F4?=
 =?utf-8?B?MERKWC83UEQxdDgyTHFNcmdXaXBmZGRjeWlyYTdoL0lqTlhCU0NYdGlHbkhx?=
 =?utf-8?B?QlJOOFd1QVViNWJST3JjSGluT1NWZWJ2RGozeUZXRjFDMXVFN2xXYkFnd1Nk?=
 =?utf-8?B?QTdaVHhsbDF5SG5wNFBVNndpQnBvM0l1aHV2cW8rY1V0Rlg4dGlKRXpPcmVn?=
 =?utf-8?B?MzZHVzV5M0JBaDhONC8xUVlDSm9FeVhkVXdqTUxUWE52aXBQU2lXa29QQWdM?=
 =?utf-8?B?eE9kcGJGaTVBbXQ3ME5ZQmRVSTdOU01BMlN2ME1TNks0QXkvZ0NmTlBIaVJm?=
 =?utf-8?B?K0g3NUlsUjJsSGNPc2FyQ0RyS3AzY0JlSHY3UGdPWWtrcnUvRjRhNkZISlpj?=
 =?utf-8?B?RDR5MnBYWUxsZXVIaXMxL1pPQmtySGhocHM5b1lqd0xlWU5CUWxsenljbGFC?=
 =?utf-8?Q?Ckn0edoPhhCZP9mbSo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb640f6c-a0c3-4f6d-268d-08df03ac1ab4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 19:56:23.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f/w5rVtg8UbH8gNGQAJxIf+NuB+Ry9LCAX/bRLViDCcd65HcmekSZe0VxDWHflEmQoRMi0qz4vCmUOfY1brjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710


On 26/08/26 15:57, Rafael J. Wysocki (Intel) wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Aug 26, 2026 at 11:07 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>> On 8/25/26 22:20, Sumit Gupta wrote:
>>> On 07/08/26 01:38, Sumit Gupta wrote:
>>>> This series keeps the CPPC cpufreq policy alive across CPU hotplug and
>>>> preserves the OSPM-set CPPC registers (Energy Performance Preference,
>>>> Autonomous Activity Window, Autonomous Selection - set via sysfs).
>>>>
>>>> Without online()/offline() callbacks, the core tears a policy down when
>>>> its last CPU goes offline and rebuilds it on the way back, re-reading the
>>>> CPPC capabilities each time. The values written to these registers can
>>>> be lost:
>>>>
>>>>    - Across CPU hotplug or suspend/resume: the platform may reset them
>>>>      while the CPU is offline.
>>>>    - On driver unload: the driver-written value is left in the register
>>>>      instead of returning to its pre-driver state.
>>>>
>>>> Handle these with:
>>>>
>>>>    - Patch 1: adds online()/offline() callbacks so the core keeps policy
>>>>      alive across CPU hotplug instead of tearing it down and rebuilding it.
>>>>    - Patch 2: makes the autonomous selection register helpers take a u64.
>>>>    - Patch 3: adds a table-driven mechanism that captures each register's
>>>>      firmware value at init(), restores it from offline(), and reapplies
>>>>      the OSPM-set value from online().
>>>>    - Patch 4: extends the same save/restore to system suspend/resume.
>>> Gentle reminder.
>>> Could this be considered for queuing if nothing further needs addressing.
>> FWIW both sashiko findings look legit to me, the feedback counters one I
>> wouldn't consider that drastic, given that these counters are expected to
>> have 'fuzzy' readings anyhow, the second one is worse (losing sysfs settings
>> on cpu_online())
> I agree.
>
> Besides, as I said elsewhere, I want this series to go in before any
> other pending changes related to CPPC:
>
> https://lore.kernel.org/linux-acpi/20260826063019.670240-1-christian.loehle@arm.com/
>
> and I really would like to get some tags on it before it goes in.  It
> clearly is not ready for 7.3, but it may be applicable early for 7.4
> if people care to respond to it.
>
> Thanks!

Thanks for pointing this out.

I did not receive a Sashiko review email for this series, so I was
unaware of the findings. I have found the web review now. I will go
through both findings and address them in v5.

Thanks,
Sumit


