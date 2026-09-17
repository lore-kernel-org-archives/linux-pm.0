Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775724DD3A0
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649495; cv=none; b=YH1sAXgp5r6YbXPMw0V6JSLVcuNN+zw/jX5BZnTSrmYFk75xuraZltkOHdgpygO+JuXuXXIKAS2rC1DD9zRbHSQ/vKKDzM2W53TZsrWAyTB0OXjqg0NAOheyvrLyOCTfzWJxJC+sLLb6v7YwUbAL/MfBr79A/UwMQqcnKhtbdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649495; c=relaxed/simple;
	bh=+UFUbButZT2weDZ/0jRJUMBmKIqP/SjVdGZSOZ/yV5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7jFzUo/cl2HcISE81kWvJfCeeLPG2zbNI7F/pULp2QaaVJ4IKEBFTXXkf8yKEeZjSOvDJnP2YbvSI9HMpD144xVi0pQI7vFe+6kI0mLljSTAKITBtNbqEXHKJNOPABvSz8FwZg5XY5NZtf2Z6FttLWRNRxYfxT5qvx1uz+YqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJRRO4Z5; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJRRO4Z5"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso9869615e9.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789649482; x=1790254282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i41XESFruXJQr6oMrsL8os9q+bHEPtCL58+AbxR2ZG0=;
        b=sJRRO4Z58zR2tlmq2ZiYfExoj1CuAsmOSUwZfiq9OHf4EG7IxWdNWf0ZeQqOOgat3E
         lqZForcikf7ydi91sVs/6Hz9ZURMT6R1HhLI+jHYvkqTDxYv3PnRJTWbjPkec/j6Shi/
         EkVYrw/UMNpjo8gtghrGDOMSN9xcQL97S1BgQrb75b1dlgEb5kFCE6lvlCYoNARmUsgt
         iuciYxeGeuKRj/0e28+rLQw07/5jVJXwO6MS1dooWjieVuVJh7bOJtyKK3DLfMLjKBuL
         i03f/w14oRIbGtjU47qMvFu7ls5lvrvPX1/GasMsg4qpcYUPdPgmNnEYXfmcVv2bHl3N
         dQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649482; x=1790254282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i41XESFruXJQr6oMrsL8os9q+bHEPtCL58+AbxR2ZG0=;
        b=omxvf0PMBOS0lptKK4kFZklSNTxYKXJtah+vrRmUXoPdBX/izwkjY3F5OiGAKexzDC
         lVRYUJa39VUW4c3Ypuz/EI4wjesIHYQqvLiaxqs97H9X3SDvkmOI6hWpOC1/6+WeRySa
         5MBcxMUmPVmnPRk7t+6N4NZbqC+aiuJRiyaZkjR4Gj4llbuTSSZEwwvP/HEvMHZqSCiS
         e+FHZzRB3C+knBD7WVKubEYJSEPSVZmOcp8JcG1YNFH18Ym08IWnVb3k+pnonTbH4DRR
         c5AEDcAsjK8NhNIWXgnYMkU3amRr/pypZvjL1Q4SsaZPEUv911KNBDNSM/3y8E1mKlNi
         EWUQ==
X-Forwarded-Encrypted: i=1; AKwUvBz34NP6cPQZ4WPeIZg/NQOcqzvY2XoXgEcVqZtzQ1dCP/CimoyrdjM91BcIC60QUkisfjdXMl77yg==@vger.kernel.org
X-Gm-Message-State: AFuF++l/WIMHJFzMTpD88C9BRO77gBo62FxjcBY80q1TJNJfSKSl1F98
	jQDY8QB2PgalKC4SP9Aw/pkRCKqGsFLrGeCTBOp8/VSa/dAHxV6U1T0V
X-Gm-Gg: AYBFou1D0QPZxnRpZ3i8Un/NSjk1iiwfiPZZA8vuBXsa319jYgB+wF1Gez5/r8FjRhv
	hqqxHu1umEX4g3dZ65PpMXYLprYkTYukbtSpMzvQxkFd8bGGbwH5O2o8IkSbUyiiLPK0U+NFqGL
	7x7USc7hlFvblycVFBWNw3JTrjgPcQdcqgh7FW90N83IndgXMdZAvjcVmpWu4H8BTF+uxtPO63A
	tS5yYZVgOq3LokSgdZB1y+aWqqd5/bsnDX78m8guzXqzs5w8ce5n3f491omittsvaEiM0QqprEW
	tzdrdRH8x4efVx5BChj4wD0VkbGiaZVJv0wS284QC7cek9XYC6JW1G2TTYOKxK1CNsix5astPbo
	I/zILNQKmyD0qIbZub65NVggJxSpqbNqSr+fS/Ui2H+45lZItS3cKvsKVRKyTUPwobACWNx3jjy
	n2sn7RGV4bhITdurutW1Ac6XQhuTlAH9XDd3kPN5QVZIEZWkM+BS2f159oiUikWs9gwHJc5tnND
	zdoLF8T
X-Received: by 2002:a05:600c:3e15:b0:49c:f617:7cf with SMTP id 5b1f17b1804b1-49eac41066amr106969415e9.0.1789649481783;
        Thu, 17 Sep 2026 05:51:21 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.113])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fbd204d89sm86555015e9.3.2026.09.17.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:51:21 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 0/2] arm64/cpufreq: report and track frequencies above 4.19 GHz
Date: Thu, 17 Sep 2026 14:51:10 +0200
Message-ID: <20260917125112.2283-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Snapdragon X2 Elite (Glymur) is the first arm64 laptop part I have
seen whose boost OPP, 4723200 kHz, sits above 4194304 kHz.  Two
independent problems become visible there, both of which make the
kernel believe a boosted CPU is running slower than it is.

Patch 1 fixes an overflow in arch_freq_get_on_cpu(): the u64 product of
the frequency scale and the reference frequency is truncated to
unsigned int before being shifted back down, which wraps for any
reference frequency above 2^32 / SCHED_CAPACITY_SCALE = 4194304 kHz.

Patch 2 makes capacity_freq_ref include the boost frequencies.  For
frequency table drivers it is latched from policy->cpuinfo.max_freq on
CPUFREQ_CREATE_POLICY, and that value excludes the boost entries while
boost is off, so a machine that boots with boost disabled keeps the
sustained maximum as its reference forever.  On arm64 that saturates the
AMU frequency scale at SCHED_CAPACITY_SCALE once boost is enabled, so
the scheduler cannot distinguish a boosted CPU from one at the sustained
maximum, and arch_freq_get_on_cpu() cannot report above the reference.
With the boost maximum as the reference, a disabled boost is expressed
as cpufreq pressure instead, which is what CPPC based systems already
get from highest_perf.

The order matters: patch 2 puts the reference above 4194304 kHz on this
machine from boot, so patch 1 has to land with or before it.

Measured on a Lenovo Yoga Slim 7x Gen 11 (Glymur, scmi-cpufreq,
4032000 kHz sustained, 4723200 kHz boost, boost off at boot) with both
patches, pinning a big-core policy to a single OPP and sampling
cpuinfo_avg_freq under a single-threaded load:

  requested OPP    boost    cpuinfo_avg_freq
  --------------------------------------------
  4032000 kHz      off      4031325   (0.02% low)
  4723200 kHz      on       4709362   (0.29% low)

The reference of the big cores moves from 4032000 to 4723200 kHz, so
the little cores' cpu_capacity goes from 647 to 553 (647 * 4032000 /
4723200) while the big cores stay at 1024.  Without patch 1 the second
row wraps; v1 of this series measured 524283 kHz in that state.

Note that cpuinfo_cur_freq still reports 4032000 kHz at the boost OPP
on this machine.  That is a separate path -- scmi_dvfs_freq_get()
asking firmware for the current performance level -- with no clamp in
the kernel, and it is not addressed here.

Changes in v4:
- Patch 1: use cap_scale() and move its definition from
  kernel/sched/sched.h to include/linux/topology.h, as Dietmar
  proposed on v3.  Same semantics, one open-coded shift less.  Beata's
  Ack on v3 is not carried over since the diff changed.  The scheduler
  maintainers are on Cc for the header move.
- Patch 2: reworked after Dietmar's review of v3.  Instead of updating
  capacity_freq_ref from cpufreq when the boost state changes, take the
  highest frequency table entry, boost included, as the reference when
  the policy is created, and let cpufreq pressure express a disabled
  boost.  The cpufreq core hook and the arch_update_freq_ref() plumbing
  in the arm, arm64 and riscv headers are gone; the patch now touches
  drivers/base/arch_topology.c only.
- Link to v3: https://lore.kernel.org/all/20260910063440.4677-1-okerixx@gmail.com/

Changes in v3:
- Patch 1: drop the Suggested-by trailer.  It was not warranted for a
  review comment on the shape of an existing patch; my mistake.
- No code changes.
- Link to v2: https://lore.kernel.org/all/20260909192351.33910-1-okerixx@gmail.com/

Changes in v2:
- Patch 1: fold the multiply and the shift into a single expression, as
  suggested on v1, instead of reusing the u64 scale variable as scratch.
- Patch 2: unchanged.
- Link to v1: https://lore.kernel.org/all/cover.1788712186.git.okerixx@gmail.com/

Oleg Keri (2):
  arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
  arch_topology: use the boost frequencies for capacity_freq_ref

 arch/arm64/kernel/topology.c |  5 +----
 drivers/base/arch_topology.c | 16 +++++++++++++++-
 include/linux/topology.h     |  2 ++
 kernel/sched/sched.h         |  2 --
 4 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.55.0

base-commit: a7728f5e1fc3d472a314acdabca6039f71ec3a9d
