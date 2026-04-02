Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5EA3019DC;
	Thu,  2 Apr 2026 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137977; cv=fail; b=gbIXvarYMeonExaL9SPmr+0FZmrTMKFek1yDVFu3H3WiCaBY6tmCeEj2cHf7Zhm0fVjhsrP2DL9vYxPs3x1ToZEhy3BzaiTmkw4WszCUlhHpZx8GixYLF5hq9j+/+YYruD8MS3Ee5u3SSjBQ3gD20VW+XVW8lyfmiliEGs6so4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137977; c=relaxed/simple;
	bh=fQYgex27XXq+afen1HBh9+KYDhdKnp7smplgo0C/sY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSo213LMgVoREaR3bIIZUdP4aEJCh3bOBXjpNf3N3fKyK7kJuB5Bt0jtW10jOiyMx3oWOw7iqptfk5WjrNKF/tn3LkgOoE0qFkQMHhQ1Tzwjog/GB+zCxtFvii2BB3BTKV0qhPte1cqj15KXzsoKT1Qx3ls5SnMECUXkTNUL1Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rPFkjbJo; arc=fail smtp.client-ip=40.93.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rPFkjbJo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjsE8LA2uYOOwkgan2y4Q1sI2dSN6xrnnuw5yGxih04AX5Dmhbu+QwTW4jmUR6zaX3W+BLHcCrRsyDEBZGrOMNhIihbv1kVWbuAIDg5i/GhJDKc9mBrax1I8fKlwRINuNpi2HOaoJ+UER4MIKVcwVM/SXPpWJyTXe+JJ8JMVaPx9Fd38uaj25AlQV0D/3HhpcPPNd9uKZdDsuvW989lTRJbLqBU9uy0nK4rLdEF+Le0jEer61Sf0k74hoQMmRHqwPESf08RDfxuvWiXcwegWuWsFC3yfh58V6ZTx3dtePB9+pqHBTGP2pme5yE0PhMH0Yre7vmgAcNbI6n3yG/N6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0lu5KA1J+RdzuDqUM6T5s3+jNGB6PIv2paKc/emYI8=;
 b=sYu0ZPxRvIgl7DEtYNltkD/C+yYkpJ0o6S7CasElovaGICdk+Uznxnh6TQ4WmIB/iDRfmZn74XuQTgHrmxP4OKkwhzgl937cSyndfIeUGsIaEW5QAEze74YrhJhEsVwIpSfG5GPXc8mw4sKIb0wfgb3HlZ3X8hVAmtGivOfm4CoonBCRS2f4ybPHQcbh0wio3a4NY2u6nz8z2Tt5x+t5V8lwuMtQEZBRqHtnO/zfi6l8Ka6UwsSKr5QpGYC5PFsKCTBvCb1mmuycx8PFsSGrxXH2cKXniaS//EN3EXrEkVrYe6CGQP3i9XY55p5rlfUXg3Oyy0fOLwGNxQVjrFRBgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0lu5KA1J+RdzuDqUM6T5s3+jNGB6PIv2paKc/emYI8=;
 b=rPFkjbJoODH2HAF0l+/s1B0jGj3SMQAaAErpPBCgmBx4RQhqZAS/XymJ8GAqErCZQQDAX0Hn4GzUNYBkdc2DSsGOHZKqaPoCEQQHQgQOLjBcZS4pnSTCnJpPcrsi3YZfs0x1G1SW5JugtFzybbqP25eGauiacmKTUYE7ZUf+We4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 13:52:50 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 13:52:50 +0000
Message-ID: <178f3a55-6faf-4070-9e38-85c547b27a03@amd.com>
Date: Thu, 2 Apr 2026 08:52:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cpufreq/amd-pstate: Pass the policy to
 amd_pstate_update()
To: Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Mario Limonciello <superm1@kernel.org>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-2-kprateek.nayak@amd.com>
 <hin33mzxwjjycw7oonq4klqmgmgavqpoe7r2ml6qalytxfpntk@me7d6q6yiec7>
 <4bwfgnjiywkm4dyslhzmk6lvar3a6rhvtcyyruc7okybckuwuf@mkdc5dlconx4>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4bwfgnjiywkm4dyslhzmk6lvar3a6rhvtcyyruc7okybckuwuf@mkdc5dlconx4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:610:cd::34) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1d4372-1199-464d-ef92-08de90bf2103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Hh5miZ0bsY6v4hhfH8X4wj3jEXKXWZp2Y8WMg6D2r23TPLcg4/fU2oAPWKGIShZRMocHOKH/fiTI8mgK+D/MofsrGZY3Yb0/WWPejns7ztJYAQYzWqlN3wBrfOemHbGjIaFqwRisUWZ9567VU8HLNSjiJBvOL4GhM1mEjPMw2Hc99zazsN5wMqDn81yfIfLO/Qi8Wzba5XQO4pf2piqyn3ccdFXWxHe2QkUbJBgwTQLAixtyL4tHIzsrTe5XaFoBsT/YJzt+WBkWhEe8IhdugsHiPZnCcRcPkTZY0r3pHxEADNhg/7ottniLgXu8hEh44Oy8Nk5hr54SsaRAHeFrixeiOGC7xZbkFx3reF6Oxsuv06L3G/KYQPp6txjJyy39i8Odgh83vyQJh2rHw3XYYlkrD+OzYX/DyRj3Mmr1zmvimDeJtRnBCB0QCHwG/YXHOYnr+Tni/aXpR0raoer0JQX8Eqd+rXkUcY8Mrj2mfrhEBPbiavH8RG1hQh8CawnrLOs4/uU0VcbQZRjnM9lVxUeP1yu0nVuhE6kcclIZtmdYyLg3SslAB3A13x3CIuFb5lGA5o1TXHKqVqjz45bYWoaBjHe1CPnFoJgY+xtX3jfibf8hN40Pv6AM7MJ5sl85Y6ScsNBOosd9MuW3gmVtmulpsM+802HfB10hlgXCsltV8wFID+TLhy8fvTVWV1iLMNYVk46qgWQC1clEzXvloh5H3PBl/6eEveUqOeVf7Co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUlPSE5CS0V3WmtiaVdPQ21oSGFtbDM4TnFOaVl6SytIeVVreVFpTTdmeGE4?=
 =?utf-8?B?UldzVlp4eE9BMkNRWVV3aUU2dko5ZFk5YXMzVGhRdDRZamtBa2hyNG1weXJx?=
 =?utf-8?B?cWt2MWs3RTdPTU1rL0hKQ1N0Rm1KTFQvT2VoaWlIMTR6aU1mek5FS3hFd1da?=
 =?utf-8?B?T0w4eUZVQ1NCcHdZbmQ2UldFcVJaYTRZYmVSZmpIK1FNdklrbnhzc3NyMjA2?=
 =?utf-8?B?ckJSeG1ZVGFKT1lUc2VHVk9VQm5lV2ZUa0VLTDQ0cC9sNjhwRXVwY2cyb1lN?=
 =?utf-8?B?SUdtUkRpaW1iRFBWUGYvYkFoSHVocFRqYUJFZWNhSjdjMGs5QktQRndkQ2Rs?=
 =?utf-8?B?d1VHNjR5RFY0dVN1M1dJMWlWaHc3VTVQTzFFYWczTysyY3JQMmR0OXRWMGlp?=
 =?utf-8?B?NklXd3RLS1Q5eTY4Wk1MZ0hsMTlqRS9uUmRDYXZnOVY5SFNTdHRQNCtOTGg4?=
 =?utf-8?B?TVJIS0hZcDhMNy9TZHRVMCtSbW9Dcm51NjRKWFB5ZmR1RzRjZUNsMDF5YzAz?=
 =?utf-8?B?ZkFEUEdOZEI2OEtYR0pUMFd5cGl2a09UdVBXQUNpUVYzNDVOb2RWYnFKM05o?=
 =?utf-8?B?QnJsRjdLMEZpaGhuN2llbTQybHFBZjdiSmZNMlhvdnlkNmNCSEdQNHdCK09F?=
 =?utf-8?B?Z1dybTFFdkpKSFZIcDE4cWFIYlh5U2xwSDRjWkhDSEFmenVKM3pNcGlpQ2N5?=
 =?utf-8?B?OE9EbmlHL3lXSFdINjVvckxzUjZjbDlmWTFHUks5NnNNd08xNTZUZVptRlpR?=
 =?utf-8?B?SU1lOXFjSnQvNVd2Sy96ajFtMUltWGc5Q0piQmpHMHZxanFZckJMNTVSaGJ6?=
 =?utf-8?B?NFdBT1lrb1UwSlBmWTRaRmZDUlZ4dHZxeVV5d0U3ako1VjhXOE1KV3Nvbko5?=
 =?utf-8?B?N3pNMXZaa3VRVzRJbnl0clZHdXN0TG8ra3FNRDV0QkF4bk8wZVpheTdJOGIr?=
 =?utf-8?B?MjZWdDh2ODhFQVczRjgvTDFjcGFiZEhwRmhJYkNXVC9kbVc1MmRsMjI3cDB2?=
 =?utf-8?B?R1QweXlHVDhlUjFjSjc1T0FhTGhCMmJiWEU3MHJIMm5vSHUxWVNhbG9oUEIw?=
 =?utf-8?B?SW5ib3BVN3c3TVhoVEVzMEh4dENLa0pQMVRWS2FudWRYTGR3UHhYQXF4eWFz?=
 =?utf-8?B?UWo4MXVvTXQ0ZnZBdmtvdEY2ZDBybmtTTlRWMVMrbWkwanI4Uy9aa0VGQkFk?=
 =?utf-8?B?cjlXbDJIdXd4Nlo1WDBVK3lzNklORGNjV0ZaQ0owdmpZS3JEd2VGYnVJaGY5?=
 =?utf-8?B?MENpSFZURGFXaDNuNFJqMGdBNGdEWDNyQlpaUnh1RmtSQ09uR21xVUxDRXpP?=
 =?utf-8?B?OXpQaS9wWVlPenEwTEFpZFVrUWIwWjkyVzNDZlBqRjNCRXgwM05QVlFSdERr?=
 =?utf-8?B?RjU5Y2xQMGF5Ky91VHJXTm9qOGV5Ryt4WmhlY1lNRkhCZGFhWG9zcmNzOGtV?=
 =?utf-8?B?YVpoYU1LQXRWeW5NQS96MjVBand3bm96TVFBeWxvcnNHdWVYNWxJbjh2K1pR?=
 =?utf-8?B?WW53MGl0dkVwSHgza1g1elE3bVlVTjZLZGoyLzN3cTcrZnowazB1WXJ4YzFy?=
 =?utf-8?B?RXBDaEF4KzlaOWI4aTA2aW1HN0NrL1o1SWhHY1Z0U1dGa21JR0ZVaEYrVHdL?=
 =?utf-8?B?NmJZZ3MzSkJ6bXpxMStWWkZ0RFpEY1pwalA1VGhsa1l5QkQwYWdhZm1aQ01H?=
 =?utf-8?B?NXBJZjl5UUtMdGRPcTd0NWlSdUJ1ZnpuWS9rbzJFcWlJdGppdU1Bd1RJQkds?=
 =?utf-8?B?UWdYVjk0ejJYak45Q2h1ekR2T0UwTXVxN29kM3lNRW1wZEFCMWROTEdaVnNz?=
 =?utf-8?B?Q0I2K041aWFpelV4ZXhvSEd4cXFFM0ducEJCLzdkcFNKRGtXSkpnYy9xeVdu?=
 =?utf-8?B?dVdUVExyRzRmWCtNNUV6ck1FNmI1bTRBRm5Ma2xRdmRCOFZkYkV2UTdlTVFO?=
 =?utf-8?B?RHJnTXVOUEM3ZnVUQVAzbXluVTNQV0xzS2FBZzd4KzBVNXB1YWdaMDZEK3Iy?=
 =?utf-8?B?M1NBcHNLWWVsdTF1emoyR0JtelJWR1EvK3NrZEJZQmN4SmRwTll4VDluZWdo?=
 =?utf-8?B?LzFhTkJLK2dsMHRHTGJhcE16czlzU3pUWWhGUkxoWkJ5K3BjVFhSU2txQXNr?=
 =?utf-8?B?aGxSbmpSM1BaT3hYa3BrVkVGamwyQ0RtK0xvUjF5VlpmQk1yZXNEdDFDZTBV?=
 =?utf-8?B?YnR6eG1FTTEyMjgwTDZzWFpHN0lCcE9pdWRPblBUeVF0bG9qaFl0Rk0zaW5T?=
 =?utf-8?B?bmExSXJQdytsTVZPTGpLVVp6RXVseGRSQWZJUEV4QSs4djBKa1ZUQmtJTGxN?=
 =?utf-8?B?L1o2bmdkTFArMDl6cm00UUtvV1VTbGFnemx0TkkrVXpYUWVGSUlXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1d4372-1199-464d-ef92-08de90bf2103
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 13:52:50.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wpZi30a0NuZ39Ko8RTKdKhsnKTdAP53ghG393S87QnVNZQdFxDeZt9PTkMsrtozJXGmqPk601fj0C/XTMEPRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757



On 4/2/26 01:39, Viresh Kumar wrote:
> On 02-04-26, 12:07, Viresh Kumar wrote:
>> On 16-03-26, 08:18, K Prateek Nayak wrote:
>>> All callers of amd_pstate_update() already have a reference to the
>>> cpufreq_policy object.
>>>
>>> Pass the entire policy object and grab the cpudata using
>>> "policy->driver_data" instead of passing the cpudata and unnecessarily
>>> grabbing another read-side reference to the cpufreq policy object when
>>> it is already available in the caller.
>>>
>>> No functional changes intended.
>>>
>>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> ---
>>> changelog v3..v4:
>>>
>>> o No changes.
>>> ---
>>>   drivers/cpufreq/amd-pstate.c | 11 ++++-------
>>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Oops, I already Acked it once :)
> 
> It is ready for Rafael to pick now.
> 

I'm sending an amd-pstate PR later today after some more testing.

I'll pick this up in my PR that goes to Rafael.
