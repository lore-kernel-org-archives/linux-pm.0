Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1315E8B;
	Fri,  8 May 2026 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268117; cv=fail; b=MCNgkFv/EGENtXrNcNsH9Rlnhv5LSFo+DWcc7+7m8GCy605M4lwvg2txu5BGh73GdmUrtEk/yhNx9PhWNcH0kzBLe8Rz2sxdMlAGbEfBe2vRXtXnGWDGgd/RzIVSldn90s0gO3PTaQTmrRzlMoy7ETpXhbWlgd6F3dg9zMJ09nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268117; c=relaxed/simple;
	bh=NR+GIm+EKYXGJTXS1616TOyGH4Atuxs0fEdSUy6oZRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CybzJd3cxlWXH5lsD3/hl4maS0XUQss4cHzRe2fZOxq7uX+jn+7fKqwDR4By3+QGlKZAENUpa6p+QRak1XxoyrrC2Kk2PEegQKno+628mpd3czk/4EzwgUi5RwCbu1+IUsU+siLn7AjTqWQDjqhTDOJNvnELSNVnOqE2ic6rJ4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KCt/Fr6A; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KCt/Fr6A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNIH2pJMqegvF8KhJ3Wlw4zBpZJGp9ACv7k7P3Rr7/wHMiAXdyRY9lv2XfrWHwaMOBpvpKx0uvUqIGZUzpBR2nYzyDV00MLzBhG4YvDoXFYmdyDLWzfjSFSjvSTzGsu5nyw7egtMkvzyxxRRd/5xuqg7wESLviQhBJlNwNHSupvm+yRAqJLWnBSqBTDKECgD9R7jOAFeh9Fm4lbs3/3M8oh3MjXhozS+W3frmIyW2DLPB2FmTCO1HIYApgD0zxD7QXvcZlQ3SarpSuBtUHhVge/8zxUcwvadncafw69FgPCi4BMMLfTr5v8cIKN2vBvIRFA7b1iFw3qZhW3Q7UbKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu9MG2JscksneQuhvlniPYieT2JrPxnEkw1mcRT2kZA=;
 b=KgDFVEWBOPTPlu2oac4xOozjw+aTgpejDZ/zChYDwtn7pn5irg+IEaLv3aIeDrSuSfoYRfTwHN0O0TrB+9hUPR+GUGQrscjKPrdwXNc0EQ+Btg89hv11JUMj/Hirk2R8RREqIPNxiPOXgnM5uhr6hNHP8rn0EK8MgzFtbqnztWxPwW/qLTMGDl5vJmI73rwfJGOKuOOf93aFu/M+Wk78Rb5rmnY7w6u8x4C2AupxPr0Bsbzh/vNW9KryQxnLuXh34uy2NUxBIEJbdlUZvlwxNIV/1pF3laED0uS2EzmTkaHFHQr1nbBntVj5uMFocbTdapDavVVx1Lnen7Y8ph3xsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu9MG2JscksneQuhvlniPYieT2JrPxnEkw1mcRT2kZA=;
 b=KCt/Fr6A9DIPlfeGq+nbw99+KR2vs19J1n4UQ0wGOz8jZPZlb4l7BLhhnr1GGyKontsJLnbPIEqG8K70voMp0ARuvX3gEHC95yGAOv3iAkp2GSSki50yb152gzxqSvAvMPFrGGNHMoXAVQY57sM3+bJ81CmdwlijAfhSfCT5e0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 19:21:52 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 19:21:52 +0000
Message-ID: <0cd54a26-9a36-4b61-8415-5691411ab027@amd.com>
Date: Fri, 8 May 2026 14:21:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] Revert "ACPI: CPPC: Adjust debug messages in
 amd_set_max_freq_ratio() to warn"
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, Kim Phillips <kim.phillips@amd.com>
References: <20260504230141.484743-1-mario.limonciello@amd.com>
 <20260504230141.484743-2-mario.limonciello@amd.com>
 <CAJZ5v0gBTxzkQU1EduyBNx2fCYfVU92XcNU8+AbSZziymBdJJw@mail.gmail.com>
 <8e2c9db5-fd24-43a2-af0c-cb2cb54f5102@amd.com>
 <CAJZ5v0ima4+ieyE1Jem=PRpk1JgZvZQ2sZWBv43=ARWde8jipg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0ima4+ieyE1Jem=PRpk1JgZvZQ2sZWBv43=ARWde8jipg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:610:e6::25) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f170d0-1a24-4821-6293-08dead370ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	c2tHNoKT6oxerWTHx1+HyE+duaZEIOGungvvC4qp61yOpRMABP/QZnyJTfubuIgD+BYZCGY4SJ8eJz0FmpIv3VlUt3cvZTemRDRfgguVd+zi5t7L3LM1HGqOg0PPi9eNhwQ3wruBT0BeYRR2N4Gfr93BoydbrXXtXoL7at/53b4XUxbwj7WrfDUXnfK+JjvUYWvJUzqhNOtzSVLVCmTM9hpIiRgE0WYnFbZJx8CNp2ZqX+p8bCTNHt9fc3k0sjWnanA/+063sCljAsRZzIfMFdv450MIXT/99zQf+6DpUCFhSe3brpFp2GyGWDEWKhhDU2ceHyyXDznoAdsmpd0gBza9Qko6CL4X7fXJpzHGTzAiQuPUr7fTufCVMn49MZF6kcwgq4r85sQCgkwamo1QOkHSUcplxCGhA7+vnfMoU+wFX2YxpAqT9kp7sxuaSFlBtqY/a0fSO/paCqdLloON0EmRqNcya4DxfY9Owi4gaREoyBNB7GKL902Bc7m0vrcXAtiLi/fInz0GGs6eoiLk86eaDs616MihWzNE7+ba1Ha3Zo7hJiVENoQMzWq5vtaI6zu/B7KvSqljIwgnpq1D4JPfvMAOYvVYU0JQFHBT7S4co2fUQmD27w5dVnEyWw4/pUOp9ykvmO5RILY+ammDEn+SaZrHwQk+KXPqYvfjzkxF5O889jHEZT3ycEQjztLN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU5SMTdiUE1mRE1JL3VjQmdtNzg3c2xONmZwdHF5bVBnUWFJdzFQS2NUS1hG?=
 =?utf-8?B?MllqejBaK2tHclEvL1JSbkYxWjUrM1BuaHY2eWxoVEZMa2RHbVhlajBuRXZn?=
 =?utf-8?B?d1VEUENwb1Z5MmpEanI4RWgzKzJ1YVdKS01Kc1g4clZ3MlY3dW5oK25OR01Z?=
 =?utf-8?B?VEZhNzN0eXVMYWFkOWdhZXUvbmpRVWZkdVVWWkRyOXQ5bjB6OTltS2s5UjR2?=
 =?utf-8?B?Rzl4bWdZL2ZsZUJyek15QXRHWFE0MVNZemhVNWo5bXBoQU5oMmh3eHRBa1dM?=
 =?utf-8?B?M01lYUVSNm9vRTZCdHFCWEFIN0IzR0RsR2lkc2lGY1VXcWZhWm9aVFEvUnZL?=
 =?utf-8?B?d0xDUlgwejBObEcrSHdlSEY2ZG4yU3plMDRuelR1bVMzb2ZGWUl4dVVhT1Bx?=
 =?utf-8?B?YVRFd2x1TVhqdmVKQXo4UW8xOEIwYzVNOUpQODliTUdYSEN2dm1hdDBnb01Y?=
 =?utf-8?B?OVhUZTBQSTdseHp3YmtCZTdUTEJTZFNocEZjRE1wT3MyWE5SQTJjTml0akY3?=
 =?utf-8?B?OWxlYmU3NkVoL0tBVERDdG04TldkVDJMVEFlTklqWTBZVS9nMXAwbXdaTjgv?=
 =?utf-8?B?WnVOdVZ1cm5qZHZRNUo2UVR4Z1QrTnRmUFpCUWZZYkUzamtYUzQ0U2NVQW5V?=
 =?utf-8?B?cEFoUEUyVTlnYkIweit6bWFoUFR4enhBVVNGYWpUY1VlL0g4Q3ZSejlIVjVH?=
 =?utf-8?B?VXBWdmtMTm1Mbk0vdGlOVHplRVllaS8xVTZ2Q3hCYysveERYS2pYVnMrRUpL?=
 =?utf-8?B?Rlg4RlFBVWxrUHVRU3N2VVZtRjdHYkJLNzZtZElidVMyUTRsMW40eHMxMDUx?=
 =?utf-8?B?WEVNVlFsWXo5MkZYTG8xT0l0Qk9OdkpybEhnN3cwS1dVMGRLRHBTN29MdlZQ?=
 =?utf-8?B?eVhOMUFpWjEzQUxvTDVIOFpDMzdIYXIrV3pMWXR3c2E5TTVhcDh5YVRzQVBo?=
 =?utf-8?B?VG00eG51WEVTbndVRTN6NmhtWjEwVExEcVVhZm10eDYxVlhMcHpEMzl0Y0w3?=
 =?utf-8?B?UkZKcG9Rc3ZyckVVakd0UEI2ZlFUVjd5WmMxMDlRMmZ2azN4QnZ4UG02Ym95?=
 =?utf-8?B?c3BhZnIxTHpsSW50WnZIYklDNk9jeWNvSmxTMitwQ2RMYjlyWkV5ay9BYmdR?=
 =?utf-8?B?RkpkTzJiNko5T2xVVVZrMkxnZWhocGxWSTZiUGxhclRocWlXL000WG9sMmNP?=
 =?utf-8?B?cEhBQ0VvOHdRK0ZLM01iaGdvTmtNQjFsMU0xQUZzQnpiQnhCS1Y1b1o5aldz?=
 =?utf-8?B?T2pJSnpEK0lhdU5pNlZCbGdLcVJUenZuTGk3Qy94UDRLYVpEcmpRK2MzaHJ3?=
 =?utf-8?B?Mm5EYXFVMHJJNjZLZldQTjRaY05IcTE5VXg5d1RkRE9STGZ5Yk8xaHZJNHBU?=
 =?utf-8?B?OGs0VEd5Tzk5QmFRc09VTmpneGxsNHQveVJ1VGlNWEVIVHB0YXhUdmxYMnpv?=
 =?utf-8?B?RHZ5dHNDRkIxM1lyZHlrakxEWDJnVDVzU3JuSHhjdndjdXliSkZrYTNJdG1T?=
 =?utf-8?B?c2lSWnpyT2lBQVFvWitnR1VJeDRtcmZiNDhGQ2ozMGxKcFR4YUF1dXdHZ3RT?=
 =?utf-8?B?UzZKTit4eVo0c0tVNU0vVDQvT0k4aktwZ0Jqd0VvbkhwUHBnVUlaQjVYSlRx?=
 =?utf-8?B?SU93blZWYzc1RXlmV3F5dngwNnl5N054YVd5aU9mSndGRDJOZUpjaG8xd2Ew?=
 =?utf-8?B?eVg4eEFaWGYzYmFVYWhhcW5sWDZ4TW9oVU4xTW5GUjZlREVQSWJkTUh4bkhG?=
 =?utf-8?B?bEpGaWNrTCsxQVdpSXlVSXJLOCs4U3JtWHQ2M1d2eXlYOXFleTlTN2g5c2NJ?=
 =?utf-8?B?ejduano5a294d0ZIWU1KSEFEL0Ruc3dMRDZvSlpxckEzSDNuM2NZcGRCaHhS?=
 =?utf-8?B?WU01Rk0ybVNwR1RPdUQxN1pQcTNNZ001dEZHVjFDczFzdVVTY2FOb252TGVL?=
 =?utf-8?B?ZkVkVHgyOGs1VzA5eFBCYkhnMEFhTnlnQVVKRUtpZ1czRnM1YjF5eWV0WkdU?=
 =?utf-8?B?NUxndUYzSDdOSU5nWlFmbFVOK0krTzZ2cGE5SS8vRTVFMk51SEtzNG1VWUlm?=
 =?utf-8?B?RGNzcGlFTm1rUVprVFZDTGtwQUMxQ25wNzlQUjkvV20ycEhoR2VYNFM3anM0?=
 =?utf-8?B?b0Q5SFJDSFVPZEk0WVE1NXJBSDVaR1lzM01lT1IwVmZocUZvYWhEN2NLTXJB?=
 =?utf-8?B?Qm5kbUYwQWJEaFJBVUdRb0pxWVdhUE5IMSswSGUzb0p5eXpLazUvR3ljeGRj?=
 =?utf-8?B?Rk9QZTNLbGNydWFvYUhWaDBuVU9TaWVFbG1pclJQeGdjQjVLM3M1L05uMk15?=
 =?utf-8?B?ejBUMUZtMXpPSGd1aWM2VU90UTRhU3JZbjNxd2gxQkdVaEFqS1RmUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f170d0-1a24-4821-6293-08dead370ef2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 19:21:52.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTVKkB4o6gNaeSU35aPXQ1XvInPKPfUW3oGwo82h1/g4QbGAJk+o29Gsv01zzxNZutKMJIkyfq2L2NOPWBgLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626



On 5/8/26 14:17, Rafael J. Wysocki wrote:
> On Fri, May 8, 2026 at 9:09 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 5/8/26 14:04, Rafael J. Wysocki wrote:
>>> On Tue, May 5, 2026 at 1:01 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> Some older systems don't support CPPC in the firmware and this just makes
>>>> noise for them when booting.  Drop back to debug.
>>>>
>>>> This reverts commit 21fb59ab4b9767085f4fe1edbdbe3177fbb9ec97.
>>>>
>>>> Fixes: 21fb59ab4b976 ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn")
>>>> Suggested-by: Kim Phillips <kim.phillips@amd.com>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    arch/x86/kernel/acpi/cppc.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
>>>> index d7c8ef1e354d3..be4c5e9e5ff6f 100644
>>>> --- a/arch/x86/kernel/acpi/cppc.c
>>>> +++ b/arch/x86/kernel/acpi/cppc.c
>>>> @@ -88,19 +88,19 @@ static void amd_set_max_freq_ratio(void)
>>>>
>>>>           rc = cppc_get_perf_caps(0, &perf_caps);
>>>>           if (rc) {
>>>> -               pr_warn("Could not retrieve perf counters (%d)\n", rc);
>>>> +               pr_debug("Could not retrieve perf counters (%d)\n", rc);
>>>>                   return;
>>>>           }
>>>>
>>>>           rc = amd_get_boost_ratio_numerator(0, &numerator);
>>>>           if (rc) {
>>>> -               pr_warn("Could not retrieve highest performance (%d)\n", rc);
>>>> +               pr_debug("Could not retrieve highest performance (%d)\n", rc);
>>>>                   return;
>>>>           }
>>>>           nominal_perf = perf_caps.nominal_perf;
>>>>
>>>>           if (!nominal_perf) {
>>>> -               pr_warn("Could not retrieve nominal performance\n");
>>>> +               pr_debug("Could not retrieve nominal performance\n");
>>>>                   return;
>>>>           }
>>>>
>>>> --
>>>
>>> It looks like this could be applied without the rest of the series.
>>> Do you want me to do that?
>>
>> Yeah; go ahead and pick this one up.  Thanks.
> 
> Done, thanks!
> 
>>>
>>> Also, do I understand correctly that the rest of the series depends on
>>> Sumit's patch set at
>>>
>>> https://lore.kernel.org/all/20260430142430.755437-2-sumitg@nvidia.com/#r
>>
>> That's correct.
> 
> OK, so changes are requested in that patchset and there will be a v3
> (at least), so please resend this one when the dependency is
> finalized.

No problem, will rebase on the v3 for that and come along for the ride 
until ready.
