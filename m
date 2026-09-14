Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2E477294
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400017; cv=fail; b=l2qCYZh0M+Qh/ltXsbOVjbqTVnUEdgnoOzSY124iaAe9mRKL/eUEimrhplxAdDxF2eYLE3+izzRxAeiPak52R48HMnVjycZDp93YjZJLLc5q7CWkqUNC1UkU710gKzSSFCBzLHHQqm5jmeh3SCWUJeI8TfvnpZFyPeSIH96+FHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400017; c=relaxed/simple;
	bh=54LOQMN4s1tcYLLe7p3R0eJLaQY8snDiYSf03V4gBKc=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=RSrodXOja8F3RMcx89tyaer0JsdBPKGAbE/UxD5WNEWy4FmrDhk8ZcV4wk4GtvzUviZgx9oxBozN4lrmkb9h2/T2P7gbOCkKXMnGQmp4Xr4RHiGI2DY8o6reESuS7traKVhwF/orOIwArScxWL06eEMGfe7Xe8hLLsW5wBl3w/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AhUhHUVN; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AhUhHUVN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKC2X74m59eyrwAYiBaUsEI59m8epzsdkN1PfGNxBPs+PaFtUVvSu1/8ZnhySZytlxDhH9sPhC4eOdDHdw5DpR+kfnaHAebLYnIH/0kuQ0LXQa1OjZjbkHVzC8lkLhmw8dtWv9cnkgCHJAiouuLAjTAWZt+KcOj/8nLZBVv+ACJ3+QuSEOFxeG065fZsDHt4DclO2ZXcbPCrYllWdYckK35ogiOTROnQQTpNHVUAV5OHE4YT2662xlMZeGQi6s+Z8Cuc1BPZIE0tyGyx/fZgI3V4lWT/CEOw4UVjLBNL/n9CydM4VDNXVn6Z/X+O+COXrVIb8Ld0P0bwB1lZ4KM0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9ftHG5tLgxGgAvjACLxLzhB3i99BPLpQ+ggRju7gx4=;
 b=m469pislU8DEfRWcVR1+BNHMX4NO7B68a9wDyQvNYbB3tVDfhnfC8PkBNaPZ7Q7I8f+1ps/pppgVPTxn4MlX2/flsFHfdE49hXIp8n+wt7kBFSfS1EfWeisbkeO9AWvmg36/9hHYc0cQs9a1DiYEbc1GMkWrV2EV4j1rycNp7ksDdB6sxxibumdrzhtv6bmKocl873zV+4gkhx7jDRGr90hSjXitPVNVqTwFsVBNlJtSVa+2geuuJYVUVJelBVno4P5a8Jx2h0DSZ9oXS0r/L7y2GJ94hhSsqpL0ReiCCoSYQfk9WVYPmJVYNXRRx1TMBOrXEKLKdga2l0VgFcplVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ftHG5tLgxGgAvjACLxLzhB3i99BPLpQ+ggRju7gx4=;
 b=AhUhHUVNNtRDukTXsk9v7ATbMCdVz36Tx0L04DhFnH03MJXCVw2bIh2Qk6sblRu7D+tQ3mMPA3ToEXA7ka5AXXJJ3+f6sGUCYiM6hMFR1GSXyg8Il/V5AuD5lk0XVhfzgub/IHLVhpygXcHCBC8HMgOMT4yNZAfioRMzMvcFuS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Mon, 14 Sep
 2026 15:33:32 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:33:32 +0000
Message-ID: <03c0a0d4-20d2-475b-ab7c-5b1a3742cf92@amd.com>
Date: Mon, 14 Sep 2026 10:33:30 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [GIT PULL] amd-pstate 7.4 content (2026-09-14)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:510:325::28) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM6PR12MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: a16520ea-3f98-4cdf-c3f5-08df127588d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|3023799007|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	dhl4ZVIo7CUo9I4Fokq8Npfah7C57y4ShpS3DraNOdXPYHuom7PenmRK79MiegmzJUCc5Azhlbc+D01gEzyRI9gn4DHqhkUEvesRifmrtOf6XONLQ8Av9SJjnNCbAg8rvNqOjuZXBS2ExYVaoXDgcQe6CzZaojplL3Fthaa98en2evlP5p8ANVebholeljcaVJHOKg/0tOwLqnC8o3jPQuUratp3CBQanUYeV49E7cwuxBCGB38vhluEnVrho9ZyxTjO7ZvlRlfVujbTq+3LuHLiQ+809hemwmDNei0qh49yp36GzpXG6CbWm+rJW7F6VuispDUm/+76AJug0dX+HeB5rJGM7JagBQhegFdGup9a7XkzfSrrfSW8tK7i0gskvz9tSws2SAiFI1gXu9+ej5gb12E/4YvT5nPL0w07y2+JV3iAFsyDbvpAXwsEAJJr6JS3YpGvMJMbBFX7jn4jV15Yao1o1Rq8uORvT1ZmyuGzaEvW1LqpH1r7tcEtpLhuS3e9qH0TiboDXFyWrLo6joev8MR5rOWhQ6GPZmL+SPOcQ5Yf/BhWkXnZVoYxT141PXU3dFoCYfWHd7bEED3UdQGuphhQldlSca0FtAatBcrFIG5cO+SZRoFQobGHdUGv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmJ5VnJJbmRCWU1vd3hYWDFGS1M3SXF2UDl0SmdEaHF6Z2syMDhSRjNXc0FR?=
 =?utf-8?B?UEJIcnczZ2tqTnBWWjdtakxnZWFmNjVDdjdlcHBRclNMRnFsempldEpacHFt?=
 =?utf-8?B?ejZFVWlwK25iekM3Q0RtbWtDdmowNVZYL2MyQzdVTDR5cWhZclpSNHBUdW1G?=
 =?utf-8?B?TXJwVmFGWkRnelorL0RESytOWUs4YU5LVW01bVdpZWZoY3h3T3RTQlA1TUVR?=
 =?utf-8?B?OUxLUkZjejBqbkdaTWw0VlNsdm1IS1NiWDFycWNQNFRpb3kwREdPaXlCUk1B?=
 =?utf-8?B?dmZ4Skd4bUpEK2RZbDJNRytMQlo5blhrNlArVkgzTDlRY0NHR0VnUmdaQ0g5?=
 =?utf-8?B?S0ZKZmg2Wng2S3BDZkRtcmU1OUM3bTVtemI3QWZYb1hSMVhNOTZOVGRLd3py?=
 =?utf-8?B?bVhPd3B6UmFWTE10a3Z4cEloN1FMQWJ4T3ozbk5icTljcmxOSnVNN1V4UEhi?=
 =?utf-8?B?N013enBCcmlmYUhjV2JtOUg2YnlFZWFtdHVMV2RFVzNwZEZzRlR5bndHeGZG?=
 =?utf-8?B?aThRajltakE3aEcwQ3N2Q2NPd3pFa3BsRmdxeUsxVDZJMFRTSUszNEU5Rys5?=
 =?utf-8?B?WGo3VklSNnNENU5XRVBONFZGaUNPd1ZGVzNjM1FDL2RaYlZET1l1UGhWcmhv?=
 =?utf-8?B?K0x2UzdoSHNKWVpla2haTVA3UHUyN0dNVXNwSDFVYUNPVGQ0N0NueXQyR2Y1?=
 =?utf-8?B?VS8veHhLR1RacFlMOE16NGIyeUo0dXovRnlMVDVxZU1md3F3QWljci9yUkhX?=
 =?utf-8?B?L1plblB6Vjh0RW9TVmRZZHFuOEhUWFR0VU14SEZ4VmtLdGZMaXZFeDZWT0xn?=
 =?utf-8?B?enZZSWVycVg4WEhxM2xlWHJ5dkVweDVqQzdTR0Yyc1NIYkFBaVM2cEV4Z1lR?=
 =?utf-8?B?R3VuMkJrdTcrYXRPY0NSeUgyZ0huZlV6RXJ3V0lMZXVKVnVYREhVNEpRYVUz?=
 =?utf-8?B?MTdiSkRiUDU1UU5yZlZvZ2ZvZVpxMno4QlRQZ2Rqa2NuT1dYaGZibTA2clow?=
 =?utf-8?B?eU13ZkNBY0FtVGw4dytKOUV1MXQ1cFkxazVnS2xldjZuWEtZWklLdEZadW5L?=
 =?utf-8?B?MDdxNDZVaHF0RzVWdVhQdmF0d2RGdUg1VWpJNEpHSjRPWXY2MDNYcnMvQ21i?=
 =?utf-8?B?T0FtMmVEdkIxTzlsbCtYNDlMTHZwcllZMEJuSGNFMXBURi9UV1k2WEt4L1N1?=
 =?utf-8?B?UGdtbGFUTGxsWStJc3JpRXZJOVBFQ1E3S0I2RGJxdEhvUE5lRHAvQnNobTdH?=
 =?utf-8?B?OUNBWnBrdDFFM3UzM2MwR1E3ZjZJamZnMVoyTDRDYVpYTVEyVTJhbnJMQ1BO?=
 =?utf-8?B?bVdJTTVnN1JFQWs3dlJXcUR4WW9nY2RnZDhnQ2NURWdXRGpDMkYwb1JSaTZJ?=
 =?utf-8?B?aEp2VUF3S3E2K2UvYUxqK1M4b0tsZ0FYTmJzcVB6K21qUjlaMEJDUWxXVzBr?=
 =?utf-8?B?MzhKNkpSeGo4ZWpiQWJEbHltWHVBUE5MbEl6QU9CWGRqaE14c01XelZwUUl0?=
 =?utf-8?B?K0I4dy9EUUNHL0dWM0hTMWdSb0hlNE5MU1lyS1FJa1llanZvUzJ4TCtjeG4w?=
 =?utf-8?B?cE9rTlBKVkhVMEI4N0gvaUNSRTRzOG16NjJOMHNwRkVwTlhhV0o4WGRKSksr?=
 =?utf-8?B?ZjNDeHhnNTVOWWVXbENrZUtBdUJGY2lqL2JPdllsMHM1Z29ZYmtvdVh3dS81?=
 =?utf-8?B?ZjArVmU4cFZpcis0S1ZTbFZ1NGp5ZlJDQ1U5QkY0b2luNTdjMWQxdG9sQS9u?=
 =?utf-8?B?YTVQS0FzYk1iR3lERFpBaXNNNFFMVnlBbnFLc3JxM3lVVEpCTDJjL0VoSnJ5?=
 =?utf-8?B?ZWQ4WUVmb2k4UUttNWV2alhHck9hRTk3bkZlZ1ppKy82YWFMMjg1a21VRExp?=
 =?utf-8?B?Zmx3dlZHUXg2R3JjZGJGSXJ5UkUxWTluN0Uxdktsdy92ZktMMllJUHFaZXZQ?=
 =?utf-8?B?VjMwMWpPajdYaklwdWg3Y292azFReFhkOFM0K0VEaWJFaWV1QXJXcHpvcDhu?=
 =?utf-8?B?TGV0SmFzbUc3TjY3NXVEeGxxTWN5aFFXSzRtcTRwajFxbGxZZTRmTDMvVldi?=
 =?utf-8?B?di9jeDcwamd5OFZVYjV3SWpwZS9wV2xsRlA5WU1MYS9EQ29vZnlQT0pjS0p4?=
 =?utf-8?B?MEJhSEJHbVB5anhWNGZiWEtKa2pTcjBrOUxmK2FrNUNod1pEZmNQazFnc2Ju?=
 =?utf-8?B?WDl2VUZ3Y0hVM1ZJV2hKYzVzQlB3Rk5PdjZKc2pCa3czdVVmcmZwdGRNM2pX?=
 =?utf-8?B?UkR4T25ndWU1QzRKQVpKNmd2MldFSUxZWmRGQ2hiWFk0YmxTdGhqYnozRU81?=
 =?utf-8?B?UFN5YnNZUEo3cWhQNWNXajlSZ3hoSmFUUmFBU3FaZWNjTlZ0VHRQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16520ea-3f98-4cdf-c3f5-08df127588d2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:33:32.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJllLiJI6LY6ABUordY5Z8u58pIUcWs8uEb3TqHulyI+rR1xE+MTNBSskyotYgGkaQbT/f3x/TJQsXvMO7E2dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

   Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v7.4-2026-09-14

for you to fetch changes up to c8663e0457e6e6c72006478f4b6da99060030ec1:

   cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation 
(2026-09-10 14:33:59 -0500)

----------------------------------------------------------------
amd-pstate 7.4 content (2026-09-14)

* Fix for amd-pstate-ut with 'Requested CPU Min frequency' BIOS option
* New Zen6 tuning values for EPP
* Documentation fix

----------------------------------------------------------------
K Prateek Nayak (1):
       cpufreq/amd-pstate-ut: Fix amd_pstate_ut_check_freq failure with 
'Requested CPU Min frequency' BIOS option

Karl Mehltretter (1):
       cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation

Mario Limonciello (1):
       cpufreq/amd-pstate: Show a warning if missing EPP tunings

Mario Limonciello (AMD) (2):
       cpufreq/amd-pstate: Add per SoC and per core type EPP tuning values
       cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms

  Documentation/admin-guide/kernel-parameters.txt |   7 ------
  Documentation/admin-guide/pm/amd-pstate.rst     |   6 -----
  drivers/cpufreq/amd-pstate-ut.c                 |  23 ++++++++++++++++++-
  drivers/cpufreq/amd-pstate.c                    | 226 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
  drivers/cpufreq/amd-pstate.h                    |  16 +++++++++++++
  5 files changed, 214 insertions(+), 64 deletions(-)
