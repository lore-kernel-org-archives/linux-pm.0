Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5736AB56
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800708; cv=fail; b=JuHjW5zHfH6ep2D6G87/maP8HfOTmfrs1Lcn1EZJAK8BebMQ5SmqX+kEpKM5SGdJABHoHWDwjRdTYWAhK2JHYSj015SPpkNBfUuW/+PNd34sbiFQgMMVnPLrWS+qrUI2nlL0MZIwsdUoZ/LVeqD//kMv8IbPmY3jdRTga7DrowI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800708; c=relaxed/simple;
	bh=YwdpaAvVeqNlxS3Mbs06Kq09y7DoCUEDIqWKB5bOJew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XTl8UmJ7WmgnEgCCflgyLO2YI08BUfe51AfjtciNkWUoYiNQce2vnh0T9T+awZbqYHImdvYvl0VvKSlRQbQqDE9/qGgrtl8/KbFJN0iCQK78nrkj5lwRedUVg2Z28OL2oRyQQqvUynYEDYaEUMTC8x3fAciy/QFypW+P2Ghf0iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kzvxEt9F; arc=fail smtp.client-ip=52.101.57.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kzvxEt9F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeKFvga8n1U3pk2EodObdvAWQfiz7dBYcksa5W5DJwmnPEisMYB7SemSNMS2jhLHwFFwJKYUwX2uu84SB0gL6KnPePMJu2myXYqfhzxUJnXbe04eHVF8UmRDUOhT08355Hst/LvyDwmgyf1sWN2ZiODknhc3wCzHHaytDqMRg+El7RBHo8s3yUtTTS7Kyv9KlXX5hf0LI7A3Qrl9dRVvM/QffMYTkNjuVL0mqkVr2D3FkRY20aOHv09v6zkBO7R43y9chwUUNmUwssACsWN2qzez6vpjOT0WhHEszNvYDaDFAKQxF2VtssuqYqU0Z6eTIKotHAcUaj/9YXhZJcQ9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50ULNAJvWN0ghLnO2t0dbUVXeQUcxoaDTv85EgH2Ya8=;
 b=EH1q+UPAzoGav6U/E2ZdsmK6qB/BQVqagrdg3b80BThDx5o2WimCVglDG5fX2qIc6K2tVJaGPzMJLn6Cn4B7ri5mLmYO6Bg8k9XQfT8LJEpBNuSCHsZMej4KxR1sSiYc1xTu4oct+ZZKYOZde9Arrdh3bnYsTGOusR3mi5dJ4bK/TbFURE32g4NMIQyDYKTYYXtT9GMrQCFhDXlTjmhxBphGXAnE65OOyYfuFt3ZBG611vUo5B2XeO7+hyOqKTbPxJymlrbsU95jIQ1YggHsPcA8dceGhFkXynYm230QwUOiGTGuYFb9Y3UJd1Nn09Yrmy6yc7moKMP/LJQXedF/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50ULNAJvWN0ghLnO2t0dbUVXeQUcxoaDTv85EgH2Ya8=;
 b=kzvxEt9FVGjhrCVpwJTOQiDfI2Y8lnE541MHte3eCzKmpmQqYyHFpamgO4JrsCLRR53/mRTdciqofJzxz2q/FvpXfnf9BfCPMZtsM9s2HmzCZ5E4HdSfjF6ASS4aoxO8+G5m7FZhEauv5T/lO5/szGL4YGf350sptfchhZKsegU=
Received: from BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Thu, 27 Aug
 2026 03:18:16 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::99) by BY5PR03CA0012.outlook.office365.com
 (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Thu, 27
 Aug 2026 03:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 03:18:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 22:18:15 -0500
Received: from [10.136.43.157] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 22:18:13 -0500
Message-ID: <9e49bb0a-d339-4120-9658-3c8e0c5f24c1@amd.com>
Date: Thu, 27 Aug 2026 08:48:12 +0530
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
References: <a5789fed-14c7-4760-bd45-dbc26bfe8df3@amd.com>
 <CAJVKnz95hAzJJ86xNkHNctnQbb+BwHtNiTkzPL5NGYR4GsZyUg@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAJVKnz95hAzJJ86xNkHNctnQbb+BwHtNiTkzPL5NGYR4GsZyUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: aec08a9a-f207-4ec2-6db6-08df03e9d5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|30052699003|82310400026|6133799003|3023799007|10067099003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gDkoqDOWAbjDMhWXmsBtocgPJNSkWz6OuQjtFB+lnOBKHYB24xVYrHEjr49Fc/DPO/bUHCpGc7Le5D1XnfXy5tWgxHQALKsWJAOSCnUJrIb/YbCj8LDjYXAi1xPQfXQhSU2DaP8N6Cafe0xrQ9f5WPw+YFkHlxEWHWihW/+g/ANKcC9TJzMutvd/xq80ccULXapLFStJASDQ71oSZKUO0crhC2t17ZnpEt/l8NZkuw/Kyra4EtL4HPUcL5x+FtMfXgl3Xhhqiww7074DeswxZSs9tjHzmCEsXgwlP24/g1hgA88c2X8vxjzoECtRs6MyDMfWavko4FjMdLqEvR8wNSb1/HDlWsFHh6WW4xvxyRXkXJThDruRT5VO4rdS/vs9f3DMd96UWNmTQsC553ZWZXmq/ZuXz5TasQn8uDSFw3jnBcbk6Mble7U3Wp3MrBKkokUjr/XltE8j2O3hNwG7epKsaRYbXLoVfvdGsF15cONPRsCMchBqu63pj1wswBmSTPMvhcwbiFmjnGqd1eWHdK1Tiy6OCzjpTBZFEE7V+pmx6gPRTAZS0tjP3JJL/sH1+VWzyxuH8qSRy+AK1QQDUyc4P01Zy0EFZDyePDBIi0HICpCI60A9VfVkRR5ORVcwDoDFpxVXX1PjzsH1xTNo6g==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(30052699003)(82310400026)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4oOjsZjcmtkyPud56CVLoJ7rd9+pQ2toAeOg2FukmpjVUZPpDc9VR2jItO5lqGbgoV88ui7kNbSu9fD1aWsrJZfop1JO4NAgDuVMxY6iIJKtp4GFAxHtQsvtPYgtIWiTBXKLmP5csEVdXYhNfJ+mFA61ze/03zQkQ3HJiFDQ/ufYsUyYw4cRHd6vKY3nw+qDjDgujcUoCkesTGT3ngHgd04WiailtvBIkUj6dJyWd5pECUoPSCqeko4EM3o1X2yIgoNuTMG16bbWEEQlQTXuU3P2hB94nGkqCj9NRsicTsY+5oMDhUySxujCuM1sdVW/zaYuRA2WPHWnZbyYPJ4hnrhQWi07/El5tFC/vbLYKAg3yAPquJyYlD+oWkEkEOonzW6vrQOb9XVY7CKfSO9uLSm8ui6jncE56m85OI9JIOUbK0xRbaALtX3TkGPkQR/8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 03:18:15.9460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec08a9a-f207-4ec2-6db6-08df03e9d5dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825

Hello David,

On 8/27/2026 7:27 AM, David Smith wrote:
> Hi Prateek,
> 
> Thank you for the quick reply, and apologies for the delay - I wanted to come back with the BIOS result you asked for rather than a partial answer.

No worries and thank you for the detailed report. Since the
mailing list dropped your reply, I'll retain it in wholly for
record on the thread.

> 
> Short version: I tested 01.25.00 as you asked and it did not fix it. I also owe you a correction: two rows of the table I sent are invalid and I have withdrawn them. One of them is the row your hypothesis rests on, so please read that part first. I have posted the same corrections to bugzilla 221909
> (comment #4) so the public record is not misleading.
> 
> (Dropping gautham.shenoy@amd.com <mailto:gautham.shenoy@amd.com> - it bounced, "Recipient not found".)
> 
> 1. THE BIOS UPDATE YOU ASKED FOR: 01.25.00 DIES
> ===============================================
> Flashed and verified three ways (DMI, HP's own tool, and the DEVFW image on the stick). Confirmed before the run that the operating point was unchanged across the flash, so the ladder is comparable.
> 
> BIOS T78 Ver. 01.25.00, kernel 7.1.8, battery 96%, uncapped
> 06:46:42 warm: RSS=6692 MiB, MemAvailable=5892 MiB, 26.8 tok/s <- arm VALID
> 06:46:58 STEP 1 (short) survived 1.92 s
> 06:47:08 STEP 2 (128-token prefill) opened
> 06:47:53 next boot, reset reason 0x08000800
> 
> 23 seconds. So this rules out AGESA CezannePI FP6 1.0.1.1c and PSP 0.11.0.85 -> 0.11.0.88, and everything else in HP's 01.23/01.24/01.25 deltas.
> 
> But it does not touch your hypothesis, and I want to be explicit about why: across 01.22 -> 01.25 the SMU firmware is unchanged at 64.74.0 and the microcode is unchanged at 0xa500014. The flash did not move the component you accused. I wrote that down before the run so it could not be read either way afterwards.
> 
> 01.25 is the latest HP ships, so the BIOS avenue is now closed from my side.
> 
> 2. THE CORRECTION: ROWS 3 AND 5 ARE WITHDRAWN
> =============================================
> Re-deriving my arm ledger from raw logs, the surviving runs at stock max_perf shared a defect: the 6.7 GB model was not actually resident, so they were I/O-bound on page-ins instead of running sustained all-core AVX2. They were not doing the same work as the runs that died.
> 
> Row 5, performance/performance 4508086, "8 steps 0 deaths": entered the window with 10 MiB MemAvailable, holding 5004 MiB of a
> ~6.7 GiB model, at 17.3-24.2 tok/s. My 3.8 GHz-capped run manages 30.7-31.2 tok/s. A run pinned to max_perf 166 that is 30% slower than a capped run was not stressing the part. Its quoted fmax 4374 MHz was a transient peak in a starved run; mean fmax was 2953 MHz.
> 
> Row 3, balance_performance/powersave 4100000: same defect, worse - RSS 38 MiB.
> 
> So the row-1-vs-row-5 pair, "pinning perf high is safe", and my claim to have excluded the battery all have no valid arm behind them. I am sorry for sending
> that as the headline result.
> 
> Row 5's configuration has since been re-run properly (RSS 6692 MiB, MemAvailable 12.6 GiB, 27.9 tok/s warm). It DIED.
> 
> This matters for your hunch specifically. You suggested "DC + Performance EPP, the SMU is probably misjudging the power distribution". On this machine epp=performance is not protective - it is one of the configurations that kills it. That exact experiment had in fact already run on 2026-08-24 07:46, before your mail arrived (gov=powersave, epp=performance, smax=4508086, battery 91%):
> it hard-reset with 0x08000800 during model warm-up, ~3 s in.
> 
> I have now seen deaths at balance_power, balance_performance and performance alike, and with min_perf pinned equal to max_perf. EPP is not the gate.

Thank you for confirming!

> 
> 
> 3. THREE MORE NEGATIVE RESULTS SINCE WE LAST SPOKE
> ==================================================
> All on battery, stock max_perf, with guards on RSS >= 6000 MiB, MemAvailable >= 1500 MiB and warm throughput >= 25 tok/s.
> 
> (a) CC6 disabled: died in 10 seconds. Verified at 0 CC6 entries/s (normal arms measure 3420-4403/s), so this is not "C6 reduced" - the machine executed zero C6 entries and still flooded. This also refutes
> processor.max_cstate=2, which is the most-recommended workaround in the community gist now linked from the bugzilla.
> 
> (b) Kernel 6.12.75 died in 20 seconds. The bugzilla now has reports naming 6.12.x as last-known-good against 6.18.x/7.1.x failing - exactly my confirmed pair. I gated the test in advance so a survival could not be
> dismissed: 6.12.75 reaches a harsher operating point than 7.1.8 (3.67% vs 2.94% of core-samples above 3.8 GHz). It died anyway, at the same step as every other death. Incidentally the two kernels derive different limits from the same hardware - cpuinfo_min_freq 1113443 -> 400000 - though
> the per-core highest_perf ladder is identical. Is the boost-numerator / _CPC derivation change between those kernels worth pursuing, or does this
> result close it?

Between v6.12 and v6.17 we began deriving the cpuinfo_min_freq from the
CPPC Min Perf and Nominal Frequency in the _CPC object instead of just
setting it to Lowest Frequency advertised in _CPC.

I've requested for some more data below on this point.

> 
> (c) I also have to withdraw my "range, not ceiling" interpretation. I told you the cap works by narrowing the CPPC range and that the workload never
> exceeds ~2.9 GHz uncapped. That came from an unreliable fmax field. Re-measured with per-core CPPC delivered/reference counters:
> 
> STOCK (4508086) CAPPED (3800000)
> p99 3981 MHz 3752 MHz
> p99.9 4171 MHz 3963 MHz
> max 4473 MHz 4493 MHz
> core-samples > 3.8 GHz 1271 (2.94%) 93 (0.21%)
> 
> The workload does reach 4.2-4.5 GHz. The cap cuts the above-3.8 GHz population 13.8x while leaving the median untouched (2336 -> 2331 MHz) - it acts entirely on the tail. The excursions concentrate in low-thread phases (cold load, page faults, memcpy, NVMe completion), not the all-core vector phase, and per-core counts track the CPPC preferred-core ranking
> exactly (the four highest_perf=196 cores carry the most). Note the cap is statistical, not absolute - 0.21% still exceed it, peaking at 4493 MHz.
> 
> 
> 4. THE MOST USEFUL THING I HAVE: IT CORRUPTS DATA BEFORE IT RESETS
> ==================================================================
> The last kernel line before one reset was a userspace fault in the compute workload, which the kernel resolved to a specific instruction:
> 
> traps: llama-server[34143] general protection fault ip:74fd9014dbd7 error:0 in libggml-cpu-haswell.so[e0bd7,74fd9007f000+d8000]
> 
> File offset 0xe0bd7 is inside ggml_gemm_q4_K_8x8_q8_K, the hottest loop of
> the workload:
> 
> e0bc4: mov 0x1b8(%rsp),%rax ; base pointer from stack e0bcc: add (%rsi),%rax ; += an 8-byte word from memory e0bd3: add $0x8,%rsi e0bd7: vmovdqu 0x10(%rax,%r12,1),%ymm0 ; <-- FAULTS HERE
> 
> The same instruction faulted at the earlier crash that produced the MCE (identical ip low-20 bits) - but that time as a SIGSEGV (error 4, page-not-present) on a canonical-but-unmapped address, rather than a #GP on a non-canonical one.
> 
> vmovdqu is the unaligned load and does not raise #GP on misalignment, so both faults are bad *addresses*, and %rax is built from two memory loads two instructions earlier. Same instruction, two fault types, two different bad addresses - that is a corrupted pointer operand, not a software bug.
> 
> Which is precisely what the MCE said: IPID 0x001000b0_00000000 -> SMCA_LS_V2,
> XEC 1, "An ECC error or L2 poison was detected on a data cache read by a load", Poison set, OVER set, PCC=0, on two cores at two addresses in the same instant. The LS unit is the consumer of an already-poisoned line. Which upstream unit sets poison on this part? That would let me trace from consumer to
> originator, and it is my question 2 on the bugzilla.
> 
> Control: the workload has faulted exactly twice, both within seconds of a sync flood, across ~14 valid stock-max_perf arms - and zero times across 43 capped ladder steps and two capped soaks.
> 
> So this machine computes wrong answers before it resets. Both observed cases corrupted a pointer and were therefore loud; corruption of a value would
> be silent.
> 
> One timing caveat, because it cuts against a simple di/dt story: in most recent deaths the compute load collapses to idle 0.3-2.8 s before the reset - in
> one case the machine sat at ~9 W for nearly three seconds after the workload had already died. It is not universal (one arm died under full load), but
> time-of-death is evidently not time-of-injection.
> 
> Correction to my earlier mail while I am here: I quoted that MCE with "... in libggml-cpu-haswell.so <http://libggml-cpu-haswell.so/>" appended. The raw journal line carries no library attribution - the kernel did not resolve the vma that time. The library identification for that crash rests on the ip-bit match above, not on the log text.
> 
> 
> 5. THE BATTERY, HONESTLY
> ========================
> You confirmed the SMU runs materially different assumptions on DC. That removed the argument I was leaning on: I had treated "survives on AC" as evidence the power source is not the issue. If the DC policy is genuinely different, AC survival is equally consistent with a firmware policy problem and a DC power-path problem, and does not separate them.
> 
> The pack is measurably bad. Measured under load at 82% charge:
> 
> voltage_min_design 11.400 V voltage_now 10.981 V <- 419 mV below its own design floor
> current_now 2.234 A at only 2.2 A average
> charge_full/design 76.1% 263 cycles, 5 yr 4 mo
> 
> I previously claimed to have excluded it; with row 5 withdrawn that claim was not sound and I withdraw it too.
> 
> I am not going to be able to test a replacement pack. I would rather tell you that than leave you waiting on a result that is not coming. So the DC power
> path stays open on my side, and I would not want AMD to spend time on a pure firmware theory on the strength of an exclusion I have retracted.

Thank you for the transparency. I'll talk to the SMU folks internally to see
if these symptoms ring a bell.

 
> 6. WHERE IT STANDS
> ==================
> At stock max_perf on DC: 13 deaths in 14 valid arms
> At smax <= 3800000 on DC: 43 ladder steps + a 35-min mixed soak + a 20-min integrity soak, 0 deaths
> 
> Nothing has moved that gate: BIOS 01.22, BIOS 01.25, EPP, governor, min_perf pinning, CC6 off, and three kernels. Only the frequency cap does.
> 
> I also built a self-verifying canary (bit-exact AVX2 checksum, single-bit-flip selftest 60/60) and ran four instances on the CPPC preferred cores alongside
> the real workload, on battery under the cap, for 20 minutes: ~557,000 verified passes, ~17 TiB checked bit-exactly, zero compute errors, zero memory
> corruption, zero faults, zero MCEs, no reset. Caveat: those canaries held their cores at sustained 100%, which does not produce the idle->boost transition
> where section 3 puts the excursions, so that result does not yet cover the excursion case.
> 
> Still happy to run anything you want on this machine - it reproduces in 10-50 s on demand, and I have per-crash triage, CPPC-counter frequency distributions and 5 ms RAPL/hwmon sample sets for every arm.

Thanks a ton for all the data. After a boot, could you share the data
from running:

  grep -r . /sys/devices/system/cpu/cpu0/acpi_cppc/
  grep -r . /sys/devices/system/cpu/cpu0/cpufreq

Also, does this issue reproduce if you add "amd_pstate=disable" in your
kernel cmdline, reboot into same kernel, and run the benchmark?

You'll have the acpi-cpufreq driver running which does _PST P-states
based scaling but the boost frequencies are completely controlled by
SMU firmware still.

It will help narrow down if a specific CPPC path triggers it for out
SMU folks.

Note: You'll need to do a full reboot and not a kexec since some bits
of CPPC based scaling cannot be disabled without a full reset.

Thanks a ton again for all the data.

-- 
Thanks and Regards,
Prateek

