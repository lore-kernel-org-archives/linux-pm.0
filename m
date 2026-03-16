Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290E18787A;
	Mon, 16 Mar 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649163; cv=fail; b=M+bluLKXVwgbXNqppvu2Al58EDwNB9Mc7M7RImR1/4ULPnUKzHJbw+PywLdtjKGNpRFvMrss8kS+rSFi6DjNxx6gznw1i7BYgpTb/3matVaNtaFnGCktXY3PROmpbC6iGxmwtb6pIbmV56eyJXr20PhKegPw8NLRv0B3PKVgY5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649163; c=relaxed/simple;
	bh=u8p6kihIC5m+Usb39oUowDP4m/wAO0nhpT6HfVkbsoo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tjqyOpzjrJf2bsjrYbyY+v6otJjCZavpaBG+rFTDBjHVSmMDgowKl37o8wAfbkE4TO/Ao35IsBy/P9U9gEx8vcbIFVUQR13apyvYhVTT3nDIemMNP8CBbBYtGzWdJpJZVxQkIMXFFQahdzVonLX8vktSs0inYQG8aN81cVseO9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VPbuXYjn; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VPbuXYjn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyKNXdTNcKM/dx7ivly05gazgaijjbNv59xdUtTLwws3LuTURmKCxzNm6vSjsDgjCO3KWFwFl1EPtcTO6d3L2rujwP1vgzDPMUunfHoCqeqJgSZUI18yFcYwY5Ffxli4f3E5z2NjNRJxUZpYl9q56RT+f4qr89fx7wYtaITj88Hz2OCYVQLPUTGGRN8UqCgI1eacHGxBvuP9eLBaj00vKXr7ftk5Nd1m3axBHrH0tyYQ4DbavsYrI8xF0sVmZhcIkxTfRy0hF3RZcvQoNM4ui+R+yqLVqtOSMwCY3dfnePt2bTCLMtl5dpQcLepLPWIhtdN3BQmJ7g2ph1O9YohhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABZVWCwWxQS/JTiepEZ2I7oesmb0vmwSgqE8KmntjC4=;
 b=ZBS7Eeqzhj/fBz+m3EBtp5pyTw5HrgeNRSUK7zmeTEur3fvpwqZ7lGLJcJJB5+ywUdSuHVBCDBAw40jBWpv+cRw/ugea4zy1CN83GPJhoHgJgOjX8ysZML+IBkXpo7lNI438tU+HZ/m5DeVs21VMxfQk4q8gsZ41KKBHAiyKGR9S349kzzNWpYiGaUtIlSNzSx/ngogvb837o2/vFwiVmbPUijUqdcvfuJx0OcSQ6WkhhLtzBExksJYWEf/cLHnJbwS75XnIckv1RPmpGSLhtpM1Vned208FaPiy+HitlkWSzBKfMAjw8ipNWT4V3RJ0IxHDI8T8NELgZ5SzMuQDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABZVWCwWxQS/JTiepEZ2I7oesmb0vmwSgqE8KmntjC4=;
 b=VPbuXYjnhafx1TBAyrvabyhhxIVdIGCGqOsw4MOmlIUuO+2iNloix9L98OQG+WdCllgAu4Ib+g4I7oR2jUkBpGyiYjj7AXiWoPd7oIduR7vtisFovaDC8rnzJjntlXoXPTKAtdb1gNagwagd/S2nnQjaS/RvLBBWGA6s8Gs3v1E=
Received: from CH5P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::25)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:19:15 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::e2) by CH5P221CA0023.outlook.office365.com
 (2603:10b6:610:1f2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 08:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 08:19:15 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 03:19:07 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>, Len Brown
	<lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Miguel Ojeda <ojeda@kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"Boqun Feng" <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>
Subject: [PATCH v4 0/2] cpufreq/amd-pstate: Prevent scheduling when atomic on PREEMPT_RT
Date: Mon, 16 Mar 2026 08:18:47 +0000
Message-ID: <20260316081849.19368-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f70b194-e704-40fb-b882-08de8334b668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sbWuAYMA9f5hfIclxVf3stdfacv03grEvnMv+YCIa48jmVWhMr6BUq/UcAGdNqxeeBs+hWcZNdR3xw6Q0/GvVlNUUJ3mXfLAFqkgNxGPf1WO/rIQtSNI5YMMbm/CPXrLOjZAe+EjaQyeb8miutADtXcE6R22Cu5oq0/Gx3eJnOejwpD7KRDdXciOnY3rofFrSbO0R4JWTw7Q2EOR5+FJdhBk6JWevYfsgIcf+vfuWEUlp9Hy6YY9Ew1FLjBX8P9jaxbwYMcJGBGMPpY+YJyBLEbtx64KY1GPLLDTWWGiJzcNcwgUVZBi9bvOlyIEe538WojRLJ92Q/4lu5AFetFL6P67RiGg7B5Ret7Q/r2Wk+idxfHVzbbEnSlOvnyKraZrn5WYt59SqYIWdFe0jUod65po2/ZIiI0t68sRDYZtNZM1JyOYUtJYrCmCYRsuoz6LNv0Y43uSTwWYyz87Ldc1GMk0Juelkzn349cBEW9Rn+hnnSWfieEji0EbzjfxpVMoT5uHUz/611dERdxB8GbC3SKdydCVaVtAD01IbNSbhrEQ40NUMPA3506Xk9JJffyBErbYpSFgqEri5YjtmQIUb1iYl+6Vu9viK/k7f32DlWJmbRT53fu5KIWtWLhvlJCnmsryznd6rN/ZX3BDFeb3oERr5V2RGHtODCEsxvPZeg2+Us0PPTpWQRRj67N8SMISoGgScHthrdfDTXdHqXwJaVVTPFR2j+4zVhnH1DL4mj8M3RrByakTOzU3VYn5AHFWGCc1/Kvlt274QmT+laBSrABhr5yeB0lLFaplfdfmMVGcSINSGo0q3yol6d27ryoXixRgDwEaaYVmbx3Jp5UN/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(921020)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VDUBMucg4QyuVwl4Z0aeL55Pr6gEgTQY46ls/jNLFAzBY3mlvzodH2LlzJbTV/usgTN7auFq3sOtEJMt9eMSf7+tOGPA8m/pLVivW8+kbnIQhZJCRZRCpUstUX4Y4W9/ibyhK3S7afCn/0xndoh9Z3yv7RG7BYc2HFYqWCn1iEFeog4TwWKnfltsmNozz9vehCLyxRnMSZiJIq2lUxHKJ1O3X6+T/FBAB15IsGVgRaXNFKOl69I/uO+usAFpemanDMhiBpps4IfK9trtzgWGLer3Y5Q9pzYIKvXHRB8FhEprdEPBq1iegc0rGfX8bLcGJeEs3dhN84TucwJW/UGHFnSDN3GpgDrqsyyojD1HCvhCXbJo15yrzQKVrCB3B2Db5nBMs63lKCBjFEqmFgxnQ90iPC9jTncy1JvKo7TtF3Spi9dUSXtIMEPf/PimSAmm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:19:15.4503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f70b194-e704-40fb-b882-08de8334b668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763

Bert reported hitting "BUG: scheduling while atomic" when running
amd-pstate-ut on a PREEMPT_RT kernel [1].

Since reader-writer locks turn sleepable on PREEMPT_RT, they are not
suitable to be used in the scheduler hot-path under rq_lock to grab the
cpufreq policy object.

Unfortunately, the amd-pstate driver has a tight coupling between the
cpufreq_policy object and the cpudata stored in it as the driver_data.

Trying to grab a read reference on PREEMPT_RT can cause "scheduling
while atomic" if a concurrent writer is active, and trying to grab a
nested reference in presence of a writer can cause a deadlock (manifests
as lockup) since the reader fast-path is disabled on PREEMPT_RT to
prevent write-side starvation.

The two patches included removes cases of grabbing a nested read
reference to the cpufreq policy in amd-pstate, and modifies the
cpufreq_driver->adjust_perf() callback to take the raw policy reference
cached by the schedutil governor respectively.

The policy object outlives the governor and the driver making it safe to
use this cached reference from the sugov data. Any changes to the policy
will end up calling cpufreq_driver->set_policy() or
governor->set_limits() once the policy is modified which should ensure
eventual consistency despite not holding the read-side.

Series has been tested with amd-pstate-ut on PREEMPT_RT kernel which
successfully passes without any splats on LOCKDEP + DEBUG_ATOMIC_SLEEP
config. Additionally, the driver switch test from Gautham [2] was run
for 10min on the same config without observing any splats.

[1] https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/
[2] https://lore.kernel.org/all/aJRN2wMLAnhDFykv@BLRRASHENOY1.amd.com/

Since the generic cpufreq changes also affect the rust bindings, Patch2
includes the necessary rust/ binding fixes to preserve bisection.

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge

at commit 18ca40891b83 ("Merge branch 'pm-cpuidle-fixes' into
bleeding-edge") (14-03-2026).

Everyone has been Cc'd on the cover letter. Respective Maintainers,
Reviewers, and the folks from get_maintainer.pl have been Cc'd on the
respective patches. The amd-pstate maintainers, PREEMPT_RT maintainers,
and the lists get the entire series.

Rafael, since this touches the generic cpufreq layer, it would be good
to route this through linux-pm. Upcoming amd-pstate changes from Gautham
[3] apply cleanly on top of this and doesn't have any dependencies.

[3] https://lore.kernel.org/lkml/20260311140116.19604-1-gautham.shenoy@amd.com/

If you would like to see anything changed, please let me know and I'll
address it in the next version.
---
Chnagelog v3..v4:

o Rebased and tested on the latest linux-pm:bleeding-edge.

o Added a "Fixes:" tag to Patch 2. (Gautham)

v3: https://lore.kernel.org/lkml/20260116063234.24084-1-kprateek.nayak@amd.com/

Changelog v2..v3:

o Fixed the rust bindings for adjust_perf_callaback in Patch 2 (kernel
  test robot).

o Tested PREEMPT_RT + CONFIG_RUST builds using amd-pstate-ut.

o Viresh's ack on Patch 2 was retained since the incremental diff for
  Rust bindings was discussed on v2. (Viresh let me know in case you
  have additional comments and if I should drop the tag.)

o Adding the Rust and sched folks to Cc for awareness on rust bindings
  and the schedutil bits respectively.

v2: https://lore.kernel.org/lkml/20260114085113.21378-1-kprateek.nayak@amd.com/

Changelog rfc v1..v2:

o Updated the kdoc comment above cpufreq_driver_adjust_perf() in Patch 2
  to reflect that cpufreq_policy is passed as an argument now instead of
  the target CPU. (kernel test robot)

o Added "Reported-by:" and "Closes:" tags to Patch 2. (Mario)

o Collected tags from v1. (Thank you Mario, Viresh)

o Dropped the RFC tag.

v1: https://lore.kernel.org/lkml/20260106073608.278644-1-kprateek.nayak@amd.com/
---
K Prateek Nayak (2):
  cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
  cpufreq: Pass the policy to cpufreq_driver->adjust_perf()

 drivers/cpufreq/amd-pstate.c     | 14 +++++---------
 drivers/cpufreq/cpufreq.c        |  6 +++---
 drivers/cpufreq/intel_pstate.c   |  4 ++--
 include/linux/cpufreq.h          |  4 ++--
 kernel/sched/cpufreq_schedutil.c |  5 +++--
 rust/kernel/cpufreq.rs           | 13 ++++++-------
 6 files changed, 21 insertions(+), 25 deletions(-)


base-commit: 18ca40891b83f01b35537f4cc93c9d95528eaf42
-- 
2.34.1

