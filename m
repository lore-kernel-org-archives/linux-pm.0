Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266E399013
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975128; cv=fail; b=NgSbXIVLDTy0csnQQZMJDvi6g9+yhST+wltGUJIhqDdmghN0QDDy/rmGD9rDtinOe83M8Oz3F6w8dh9UQ97JUM71iG+HMZen5ZUwJlSe8eYQvytb9vaDmDul73ZXQJV85rIezFzxqJDbccfFMRsYN9oXSbX9cyK450F5J+s9WhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975128; c=relaxed/simple;
	bh=FPROKE6qPG9dw77ThEV31HbWDqkqjOSGifSKTA+1EzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kX7KFBK6ptl/D5L562sobIaO+RNJIEkdmSxJ8dMbYkgNmJaGn1N15Z+TQ2gQ8s590M8/Iks6CUsNPqQtjT9m7++MQSzvAT6FCiLY5uUoXamV6FC23mjQwGBbj3RBOHJQTyknQ2HPWQaI8tiCQN9Bj+2auuRUlzNQ/nXRosngbbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j2eF9KVo; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j2eF9KVo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjNN19KuG2RZQcevAELgpVu2h6fBXcvlN9cMUsMvchBJr+4Asxu5IzJUyERBV8d+IWk/QCk3SKgsb35296ShQ+FWOwNGTCLVaKpJ7pi4Wvy02q5ojoor+93SPSa8Dfegv2axFg6Ms3osrhdN9yXneWql5NBQx0UvvGUNMjNLQRoDjqpPRnOe2ft9RahSrlQ4wnoLUD3SKqo2wXP3bBMZ1Dmq6muS6gNgi8GgLRGwHfKJljVyNKXMzuBrq6LyUIIkp13PT3Oo8ZkwxXgIxlPEcJdxlYy2TcYaeZfRm8h0KRMBxd4/vSyYQnl2Rdolozal8vaEYe45LlAxL8OuDCeihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+BcYxCfo7Kx7GsPShvrp7Wo9u/D51ABPNIEBawYXvg=;
 b=Peh0f0q+7exxgWF1sTtA5BX6N4HD/XUwTWuosqMR5v9LPW/JhLviOECxmzzTRd1tFaev3sn7xZPNwVc4wouHCruzjPKdzF/JMf/nqPyf2WDi/Ky7938sFDqyXg0CFZsXKzTkcZ/XO2tf1AybnRMOt8eBokf5+L4Uae4yNGrHkkfDHg5oM1t6QxTeFNMEU3NAuy/7GETyeWzqC0lUdJ743LuRFMZSQUJ6s/i05urSo3SQxALz7mjgQH6S7SYuIJklsY6IJu79/9L9f8/ISsrUCyPCFCjQEMyijqnDmRb4mfg/O8ehkUNiLG50KYsoLlc1cqfUVYi3cS0ESuxAQA2Rpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+BcYxCfo7Kx7GsPShvrp7Wo9u/D51ABPNIEBawYXvg=;
 b=j2eF9KVoWv+CyLWJGabt6G1uVOM/gttqkR+UuAHYlOojouiMTBMOgF9xDTImukQ0A66mxu549mtHUcPx6p8HWAR77ZDG678TI+PBxV0o8+5Hb3+hw+Uh2RrDtecGl5FAJGnE9f+TkA68b9juzc2GDEFDili3de4lIxrEvEx4TW1YWy8VDhFwzcyERkDLGyOAI2otTAXvGMi3ZPaTYjW+XeneUQYaDbXXz+jrOuSDWZt03vyjuqleroNDesNa9X/t7KBig3xi41UKKrzsPckI0UbsVRqfGsbq7t+BjZpuEwrxQZwQAg83v1ol2Qj3VPyOWGynLyrUKRSr4ZJ2P81Vdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 20:12:01 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 20:11:55 +0000
Message-ID: <d855d43a-2b07-4e3d-af61-7254ea08527e@nvidia.com>
Date: Fri, 24 Apr 2026 01:41:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control
 micro-conference
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Pierre Gondois <Pierre.Gondois@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Armin Wolf <W_Armin@gmx.de>
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
 <CAJZ5v0juVDm3R3rffQsV3gQeC6zr=0q8y+KSpOPqvToyWh7vKQ@mail.gmail.com>
 <CAJZ5v0ge3q5JMm7fdySqLeD+TByhgqDFnp2NNF7ATSeHnBjPiw@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0ge3q5JMm7fdySqLeD+TByhgqDFnp2NNF7ATSeHnBjPiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0881ff-0722-47de-58de-08dea17490b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ogTojuw1mQoc1Q3XeqrlgQOQiBMURmYhhoI1fi1dafKb9fZEXU2vMNn4igzeaQeRkvCK/O1CnwkH0Kt5MSiA/DoXQ45hEeGkq29IgQpqh5dPvoId+m2J+JRDaKEDs2BFnpa0Wi4qxF31qQhwiN25qdF6a4vNueqAvtianEYpz0rWOSRNelJnQj/V0MAo9TSxygmSr06Ft3Wh62hnMnL/4aMa0EC8czbbk2UOpPLpwX/UJOSc6qpKU/oUmgt0cume/Pv2b5mEcb713x4tMn4aUGfQ6yArtfkKNEKsigGfYAMgo1AFKoWuFqEk/QlS8QVq6AuOX5Gl3cuDtu54AgKLgQ7Sa5BZhokZRlneXhyV58A+KfQFYjyf7Nx/zOV2V8FB6CxegZAeNgN9F6aVywbvjGrJ0Y04fbNho+ytINTjzCp5Za1jviUMRdOSqXF+KDtY9/FDwR8YLA97r91vUiEfazy1zq1o+tJJTeFYnpqmWa5sZRGBxpOwk3AtOWtNzrumrEALMfzZrrwzrh1Cx45PTHD/9hB1U0ANhe4opaqoHbMRPoHUtUPoaIIF2ODkYwub8NLUr6waxZ7PEdZF2mqFCe/oXIKJ+zSXDrhEN9ulWlNOVK8E26eJD7zheNct5fWHjbdNwoGKJm1vEQHVGIisMyRcXikKRDJJfjh0bPfhw8Emu9NsI7tPRApgkMtvcjB4tcWZicfRX7w8RIvmu8u864xJmTCVwNhu7K8uD/RzcBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG53ZkVEa3JUYU9aOTFqUUQrWDV5aWdwREhnV05EbEZlQWEwNGtkRnFtVGNB?=
 =?utf-8?B?K25sMTJJVWJMSnVSSDc4aHFpN3FQSUFzM3V3TWFTWnc2TWRmczZ1ZVBpalVH?=
 =?utf-8?B?b0Q1aWROTGtsTGRiUTUvNjNtVmxuWFRlaVhucC9lNG0wY1VnQVpXQ2JhTHhK?=
 =?utf-8?B?aFhRcHhwK1liOC9la1VLbjdiRGM4cGx3TzVoU2lEdTVIRDhuRkpEcmZUOU0z?=
 =?utf-8?B?ZnpTZ2VRZ3I1QnNOcHovY1l3NzltUDJ1RFZGeStuM0dGRlh1NERhUkRvVGZO?=
 =?utf-8?B?dnRhdXlKWC9MNG5US1k5eEdJVXkxU0VYdTRhNUZwUWpnd1hSaFFxckVILzZH?=
 =?utf-8?B?b0R4M2xDcVc4OTArTTZUQnZzWlVSM1hLZHlPNEdQU040a1o1OXhnbEJKVjFF?=
 =?utf-8?B?ZS84WEFaV3FIVkh4b2ZLclVaS0pkQlR1T3d2NEswVjN4SUtldEVHc2NaQjQy?=
 =?utf-8?B?QnlPTVFNWlpzbERLeFNOTlVpcFFIcUMyZ1NVT0tVZXpQd0NqZ1JjdmRDU3dP?=
 =?utf-8?B?Nnc5U0RZWm1EM3NNWnRiOFZRYVA3Tnp6NmtPbVkxVzRyTzYzSXZ6VHp6akpQ?=
 =?utf-8?B?bW9RNEk5TFdjSGY1alduZ1JQWU5yWVR6ZkZmelkyaCsvTjE0TmhZcE90Ymwz?=
 =?utf-8?B?bnU2cE5odGpQc1Q0bG1TV2lhQXI2RDBkZWlxT2pKZy9RWjdSK29ZcGV1cTdM?=
 =?utf-8?B?NW9zeG5sYUZrSFBYV2lNUk5YUGRlczB0TFZRTjBvLy9jYngwU0k0SFA0WW1l?=
 =?utf-8?B?RVQ4WW9sQkdDd0dzeXNYMksrdmNOdG9IQ1JVSFJaSkE3Ry9sRkx3QmxzQ0VS?=
 =?utf-8?B?Y0Y1Q01VekZuQ2d4bWNNNGRrbVJ4LyswZ0VXeHI2SzU2bjRJQ1dxSXcvZlFR?=
 =?utf-8?B?b0NrMERreXJGNSs0MWVDQU1hQS9xbUpmQVUxQVlzQjk1SitMcnc5SGF1akZ6?=
 =?utf-8?B?VVZIYU5tL2ZWQkVKSDR6U2NCd2tGS0NkY3pqdGMydmJzcXZvazhob1NNUTNy?=
 =?utf-8?B?UEU0TTNGYVV0cHp3dlU1amRCRzhRSE5WNVpkU1lIZllqVzFBeXZDaVE5Sld3?=
 =?utf-8?B?MEFZem9wVmVJMWhaQjF3TkZ6Qk9EL1plWGZ1M2lqZUlaZ3FSS0IwRlF1YkFl?=
 =?utf-8?B?d1NjMlFWZzZJOG9XRUlpNG1sK3AySzlWbFBzcDdndWJWUTkvTzBUK2RtUC9I?=
 =?utf-8?B?MDFDc2pQUE8zNDZGSk41RG5KZTVtVHRjSHB0UXlwL3FvNTA3Zm9hUk11NE9T?=
 =?utf-8?B?R3pEOG5EM2p3M0VvcmhXd2xGNnovb3VXdUczSW5DT0laTGxoR1ZGSDJZWWNS?=
 =?utf-8?B?N05IOUpMZjJVVndoVFRpaXBCclZWdFc4YUpXdU9aQ1BhWmJ4VlhwR2F4cUVQ?=
 =?utf-8?B?cXRPR0JsNjhiWTdKM0ZHeGlocURNOEtnNzZNNVh3NVZZY1VIeE9RbHJvYjdt?=
 =?utf-8?B?T2gvSnJ3S09DR2t5M0lkMEg2VVhnQUxKT3AyOVUvZ29SSXJxbFJwMzZyTUhO?=
 =?utf-8?B?Wk9zTkQ3amg3TzNPb3B4NTNOdU1KamRDRlFSM1lDNHAvMDk2Vk52UE0xcjBR?=
 =?utf-8?B?WWlzWGZ1OUdrWU9SWHdWRGZUU0pmTEVGcWFVWnhFcVBrREJCVzAzSVhHdlVT?=
 =?utf-8?B?QkF5eFhYQU04b2NCMkNyNit2RW8yTUVRNHNWOVJwSVFSUUpreUkrUlpKSFJ1?=
 =?utf-8?B?Uzk0YzQvODdpVnRXZ2NURHlDWm9oMDNZWVE3aXpPVmdJQi9TcDVZclJTVThR?=
 =?utf-8?B?VVU5SkpFcGFLSTFKUGkxREEzMldENXBQR3VsMGpDRHVvWDZ2Y2k5M2N6U2Jq?=
 =?utf-8?B?Z0tnZTFva3BlLzIyVWZuaERRVm9rNHJkS3pNOG9MSnBUZGFkL1djQUMwM0RB?=
 =?utf-8?B?bk9NSEYxQ1dZUFZPVDY1bDN0akx6d0pIYWhQUFJIRFpBNVEvU1ZVam5lRFE4?=
 =?utf-8?B?cStmTjJQWUZMd0pMdk9UWE9xMkRZM1hBa0w1YzN4M09CeldrejJOV01TYmkr?=
 =?utf-8?B?UHI5VmlNUmp4KzZnTGdCTHUwUm5BZ0hQL0M1R2xTRUpVdXlQRXg3R0FtNitY?=
 =?utf-8?B?NXp4LzlrUE0rc1VvajNyVDRJNXRRb1pKYjFjekFmd0N2MkVaaUxhZ0xsQW52?=
 =?utf-8?B?Yjh6c2xhSmE2QmJTRXJoZVphNDhJVWJtTWk1M2FIZGdqcDBLSEEycVFRSzVN?=
 =?utf-8?B?VlcyYVJob2Z2R20yR2tLVDVQU3hLRUpnNm41TW9sQ1lwZllOSWZERWZYeDU4?=
 =?utf-8?B?L0VZMU5MVVJtVW1DaElLWkNXR2E1cDJRVVZkMnpWMzBZOXZZYWlaRDRROWlx?=
 =?utf-8?Q?YMBkaZVcMWddHm2wj/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0881ff-0722-47de-58de-08dea17490b4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 20:11:55.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnsQhuCD/6E3Ot6GTk77cGN+YSLMYE4jyRIujyyQEcDoLnEMR44eZyZnCfj2DJeq9zezmoVUo+xQWRz6V/UR1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569

Hi Rafael,

I would like to propose the following topic:

CPPC autonomous mode via a new cpufreq governor -

The ACPI CPPC driver currently enables autonomous performance
level selection via an auto_select sysfs interface, so scaling_governor
no longer reflects what is actually driving frequency.

The proposal is to model autonomous, performance-biased operation
as its own per-policy cpufreq governor, with autonomous state
exposed as read-only in sysfs.

Related upstream discussion:
https://lore.kernel.org/lkml/66f58f43-631b-40a0-8d42-4e90cd24b757@arm.com/

Best regards,
Sumit Gupta


On 23/04/26 01:18, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Everyone,
>
> On Tue, Apr 21, 2026 at 3:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> Hi Everyone,
>>
>> On Thu, Mar 26, 2026 at 3:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> Hi All,
>>>
>>> I'm looking for topic suggestions to be included in the power
>>> management and thermal control micro-conference submission for
>>> LPC2026.  The deadline for submitting LPC u-conf proposals is April
>>> 23, so if there are any topics you'd like to be covered, please let me
>>> know within the next 2 weeks.
>> Just a reminder.  The submission deadline is on Thursday, so I'm going
>> to send a proposal tomorrow.
>>
>> This is the last call for input.
> The proposal has been submitted, but it is still possible to update
> it, so if you have any additional topic suggestions, please let me
> know.
>
> Thanks, Rafael
>
