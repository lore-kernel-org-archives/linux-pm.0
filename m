Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629B34F27F
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 04:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787546238; cv=fail; b=eCyldkDvUVOVE7SMKwFxSCHftsXFVSmnRl7uwY4pAH0u0iL3XzqnHztPxqvBxNrOWCPrKKEUQN88uxlz2BXc9/72B2wTVGvKjNcmbH7N7TFSjdGtUeC4AhlPEXs6UevP4DyiQ3W28ojCLcm4TZfajMXmk4xuW6l0VjQ86UGt4M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787546238; c=relaxed/simple;
	bh=XONXAuOxjQs6VMivIpIRxQr5GqN8CXSJEBlOMiemPXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EvMRPBdcByP0un8S7cnJIlXzD0jcTN8jTgo7xJdCOkIScIgRSQ+ZB8ER/LZmaCu8yJhtyKOsnajeys6YFWBb+DdKYlkijvGL4DFMfCUeIVA6wbXWwxQ4AR4F2HI1Vbi9IsD3Wsj3R98bWSM0yuL/QZCF+/7N03enRaUnHS4JvHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ix//Rqf1; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ix//Rqf1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQqYMhewN5tVTIWVq6EfMaLImsPHtq9QHUF+H6XHO04G0S9SdUNG79SRUzk7zF9dO3YTF6OkYkdeD+Ve8QXmnTiXdUhEWEatJdw19VwTh4dc4Jgb67EFTfstxmpODC1Ubx9JdOlx9MBKZipeRfMLnvidw1u1+dhJgmpNFtA5dSZFBIxq4zIAwstHrkVrwIqU46Ald99CR7fFgAKLGL3JyYoe4nS+eoT4s92EGzuoqRRwlme1c2neiSDOa8tCzzRPyNNpRieTyRm1cYMjGXAKKuhl/qBGb33swKRP1Rhdysxnwc6gKNsfIKw8DSQ5eDYE2Flbp5+mbBw6JEQCkHs/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJg58SkW+lexvpbRFo8YlEY3QuFR1D8vEIu5mHVsGaw=;
 b=IDCYTjPdUSBU1/LhKOsz4LGKwr1Q/+DZyNkI7FnAJt/mSt6agsdjO/tMwhN5Bwh+A7u8C/9d9ILmZxVoEiW/2nprol+TNHjJW141LTT8FbExNIRg2HwIha7EtJIdMw1d9ZJqt7EhRyitERuxTEG/zPLYsJfqHKYcfkvnc9zWCrcIsDMcGxXdqXejm/XPUWgTERql3f3XreY24QGWUUOJ479yHjVP7ihDMig2I4mamwCq6mHqCTTgjpXTjA4yTZ0jfxZoSzf4EDhQW06D5Ov/dWZUbkhxuKbKm7MRs8rpohEDSXHtwAO7aGJxDzke7AZmQAH2sw1AbYzlzdukslN5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJg58SkW+lexvpbRFo8YlEY3QuFR1D8vEIu5mHVsGaw=;
 b=Ix//Rqf16pesLOUcVBXeq6y9AGDhlVnJKxYh93xGdep5pbn4xkd81Ea2lkEDxWapaN8T3vET0XxKsEBAB59c+jc+KkW5jUu9P83/vLksyFvLtOC6r/VQlrsr3eEl0UyTubN1kZGx7s7ZhTBwHimETbD7IoykaxYKBAfSF40QGv4=
Received: from SA1P222CA0181.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::28)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 04:37:09 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::71) by SA1P222CA0181.outlook.office365.com
 (2603:10b6:806:3c4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 04:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 04:37:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 23:37:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 23:37:08 -0500
Received: from [10.136.43.157] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 23 Aug 2026 23:37:07 -0500
Message-ID: <a5789fed-14c7-4760-bd45-dbc26bfe8df3@amd.com>
Date: Mon, 24 Aug 2026 10:07:06 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amd-pstate: Cezanne data fabric sync flood on DC gated by CPPC
 max_perf
To: David Smith <smithd98@gmail.com>, <linux-pm@vger.kernel.org>
CC: <ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>
References: <CAJVKnz-nj2rk33U9pNMaxzKDOvqZNaQBE5otdCc8Znt8m97anw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAJVKnz-nj2rk33U9pNMaxzKDOvqZNaQBE5otdCc8Znt8m97anw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c40af69-b898-4dd7-0032-08df01995bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|13003099007|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NnsbRQl6YBYDlFDv8gq29uAxwRjn8E1ShMstjx2iDFcvUYRYhaiWOoFJ+gpyJx5IUxR1y10XB/lbp5Rd66pdUQYQu8lL8/HBg6QFIR90YUTwpMUP7S2ZmEl6vpu78oXbn6Irm1KmEW8Xz/et6eBce+bYO5ulrmAYp6VCOhvDOydeUkwgteGW/nIy/gPRK7sHbmCjn3WnoIG16iBUWcxh3V/Ttf3yZOwUrHpPZWHQUPdT0h/yPgypOtFTvdtCRVSymbCWXjofj6Y+w7l1j2qkOLZSaA0ryPE0ooruByRrnQ7Uc0ySoZMEvOppx2b1iAfCc2QOOhkXt8SFVEK5NVsZke+qE6GeOnzzloFLJCt0Q/jlR0WV27bD76RsSrZIQIQmackfDsyRex2Cqflj77AkjHfczsP+bxVXlx3uPGf2PwdaOoLw/H1jLyMfCDbIDTXyvFr7C4efk2AiUjJCw9lN5aeNy4JV5LEW+gh0+4xG9pB4zDrxaTDHOFg6AasysulcqiMmaQcWKus1xAnVaZsdfJEobWRHw7i4epy+SmT9eSnlC16sdFKkglMc1v2doRKN85KaPvJEDY/COUWcZNiRV3pv3cb4Q9FpO7r4Q8ziX6ZG/hrATLiZat/gkVpA+o6gn/s/wgvui1rsORQZzx/e3w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PgYWyUY2qLsyNC1VKIvD1dQ+NJYZiKb0Ip3d418TbnXyBU1dH/1Rtmk8cUDd6L4mWaml1zQjYUzHQdkMSGmXTfdp8SEOHwDoIqbpVxIrcEXdf4qDFJnktvEGd4U53QKidobx371KKfZq+/l9YCvD04nMcp6wbOldsxDmHrHwpVLDjso5YMhs92l/EHbhE4n+x29LhYTtXPxbwp/XvWavsxRoSdOmuHEXgfbRo65AHSWfbgZc3rHVJTYko5lD5TUknu0YIvpmL0f9oTgn9/ei95TPCX6wSiN21MWco8ssfiZ/JqjcnPvnb/ndJlItA0inqW63DSVQBB+HTqQfdBaCff5k/uzf4Yc5oiNqqCIvqcj1LAxRBJpWsmBW9StF7W098Mg/4M0CwWLu8dId9gV1qoC+lkPYabHXbf3+5b3x0+46U+X6+ZN/LoMEZefo9uEu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 04:37:09.0077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c40af69-b898-4dd7-0032-08df01995bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737

Hello David,

On 8/22/2026 5:16 PM, David Smith wrote:
> Hi,
> 
> I have a reproducible AMD data fabric sync flood (reset code 0x08000800) on
> an HP ProBook 445 G8 (Ryzen 7 5800U, Cezanne, family 25 model 80 stepping 0)
> that appears to be gated by the CPPC max_perf value in combination with EPP,
> and not by any physical operating point. 13 confirmed hard resets.
> 
> Bugzilla, with full data and a 770 KB evidence attachment:
> https://www.google.com/url?q=https://bugzilla.kernel.org/show_bug.cgi?id%3D221909&source=gmail&ust=1787484988593000&sa=E
> 
> x86/amd: Previous system reset reason [0x08000800]: an uncorrected error
> caused a data fabric sync flood event
> 
> Summary of the controlling experiment. All rows are on battery, same pack,
> same charge range, same workload (llama.cpp 128-token prefill, ~6.7GB model,
> CPU only, held warm). Peaks are from amdgpu hwmon plus RAPL:
> 
> EPP / governor smax_freq max_perf fmax vddgfx tctl steps deaths
> balance_performance / powersave 4508086 166 3617 1175mV 63.8C 12 4
> balance_performance / powersave 4500000 165 - - - 1 1
> balance_performance / powersave 4100000 ~151 4017 - 84.9C 8 0
> balance_performance / powersave 3800000 140 3748 1275mV 71.5C 33 0
> performance / performance 4508086 166 4374 1462mV 85.8C 8 0
> balance_power / powersave (AC) 4508086 166 4117 1431mV 84.0C 8 0
> 
> Rows 1 and 5 are the interesting pair: identical scaling_max_freq, identical
> power source, identical workload, differing only in EPP and governor. Row 5
> runs 757 MHz faster, 287 mV higher and 22 C hotter than row 1 and survives
> 8/8, while row 1 dies about 14 seconds into a step.

Thank you for the detailed report. May I ask if the same problem reproduces
with powersave governor + performance EPP. Essentially:

  echo powersave | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
  echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference

It will help narrow down if this is indeed an EPP thing or there are more
OS side interactions needed to observe the sync flood.

> 
> So: pinning perf high is safe, clamping the range low is safe, and lethal is
> the wide range with autonomous SMU ramping - balance_performance + powersave
> across max_perf 166 on DC. This looks to me like autonomous perf-state
> transition handling on DC rather than any operating point the part reaches.
> Consistent with that, scaling_max_freq=3800000 prevents it even though the
> workload never exceeds ~2.9 GHz uncapped; the cap narrows the range rather
> than lowering the ceiling.
> 
> Never reproduced on AC. Reproduced on 7.1.8 and 6.18.44-lts, and on BIOS
> 01.21.00 and 01.22.00. amd-pstate-epp, status active, prefcore enabled.
> Microcode 0xa500014, verified loaded.
> 
> Ruled out: memtest86+ 7.20 five passes clean; HP preboot diagnostics all
> pass; thermal (dies at 63.8C, survives at 85.8C); NVMe HMB (AER is OS-owned
> and clean, ASPM disabled by FADT); OOM. Also the battery pack, which is worn
> (~430 mOhm, sags to 9.48V under load) and was my leading hypothesis until the
> row-1-vs-row-5 control above rejected it - no battery model fails at
> 3617 MHz / 1175 mV and succeeds at 4374 MHz / 1462 mV on the same charge.
> 
> Note this is a single machine. I have not been able to confirm it on another
> 445 G8 or another 5800U, so I cannot rule out that it is specific to this
> unit.

I see you are on latest ucode but your BIOS seems to be slightly outdated
based on the information on Bugzilla. From a quick Google search, I see a
new version (01.25.00 Rev.A) available for your system at
https://support.hp.com/si-en/drivers/hp-probook-445-g8-notebook-pc/38228745

Could you try updating your BIOS and check if this is still reproducible?

> 
> Questions:
> 
> 1. Is there a known Cezanne erratum covering data fabric sync floods
> triggered by autonomous CPPC perf-state transitions on DC?

I couldn't find anything specific that links to CPPC autonomous selection
+ sync flood but my hunch is with DC + Performance EPP, the SMU is probably
misjudging the power distribution and that leads to an unexpected
CPU + iGPU + fabric power distribution which causes this.

> 
> 2. Is the DC vs AC asymmetry expected - does the SMU run a materially
> different perf-state transition policy on DC that could expose this?

Yes! With DC, the operating assumptions changes since the power envelope
is more limited. Plus, there may be additional tuning from vendors to
make a trade off between performance, thermals, and battery life.

> 
> 3. Would a DMI-matched amd_pstate quirk clamping max_perf on DC be
> acceptable upstream for affected platforms, or is this strictly an
> AGESA/PMFW fix to route through the OEM? I am happy to write and test
> the patch if you tell me the shape you would accept - I did not want to
> send one cold given amd_pstate has no AC/DC awareness today.

I'll let Mario answer this since he may have more background.

> 
> 4. Is there any way to get a fabric-side error record on a platform with no
> APEI tables (no BERT/HEST/ERST here), to identify which agent flooded?

Again, I'll defer to Mario since he knows the features on the client
side better.

> 
> Current workaround, if useful to anyone hitting this: cap scaling_max_freq
> to 3800000 on DC only. 33 ladder steps plus a 35 minute mixed-load soak at
> load average 29-34 with zero resets, against 5 deaths in 13 uncapped steps.

Thank you again for all the experiments and figuring this workaround.

> 
> Happy to run further tests on this machine - it reproduces in under a minute
> and I have it instrumented at 5 ms resolution. I have the full boot ledger of
> all 13 resets, per-crash triage, and the 5 ms RAPL/hwmon sample sets for every
> row above; the bugzilla attachment has all of it.

Let me go look more at the data there but re-checking with the latest BIOS
just in case something already solved this would be great if possible.

-- 
Thanks and Regards,
Prateek

