Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3A3C8C7D
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022098; cv=none; b=aL8nuWQRRdyovsTDd3dwrSoeIZ5JV8z2yW5dT316Tj4AEfK/fs9py4xxLxAT7KNaClUL5uThycB+etEvY/iVG1PSXFZITWiFji4gps2+gW8aH4lQaP4xh+9FFjM+EO+BBlqj9e50PKEG8nIxLWuv7UIaej6EiGPB/lf90x5x5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022098; c=relaxed/simple;
	bh=2bHvA86LBVnNVn37kqizVxucld93jNqngtRyL/3L6mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uge9FiyXohuTzZgh3PvSeD6OrCCvjJl0RgPUjPzH6a8lwlqI9wnlmRPXgf39LJQELokUcVx4skUkTKGNx6seTNRc+q/y3negNYO14JfOnE/PXn6jyhrYoihEpUlNMBaoYBMDT7XyGeTer3vbdVYB/NDrZodKif97G1N9rDgAmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsVRWnXM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsVRWnXM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso54723125e9.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022095; x=1789626895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D92+v0nqxMJ3pOaah+t0R5RhuqJf5mej5Aw3sSQ7mCo=;
        b=bsVRWnXMe0fE7e9ip07uTIHdWZSuSqrwtiPDea3ak7rLGxgIx3LMwP8wKLSeIq028K
         yiWHKPADSMluFY2c2G40W/1s+quXMIgoWVb/Luj1BWdQFvI6z2oxSGeCjz/JNq+/fjtP
         bvtOfTjvru2FlnDCUd6EUffPrhTf2yc6LU3+56rEVMMR10fnvkjPTVskao+vtdrvZIMh
         GgTgy8NScwWNFr8XiHRhzhQgriB1w6J2f0FbuiL02Sn4R2ELOLethd/qABWHuRGN3eCt
         n6cfsxq/z70Vy/3HUf6PwHJtVQCw0DoPnkR79TtCTgfbPT9XI4Rtqh8O3V5sWhhVfFMq
         GAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022095; x=1789626895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D92+v0nqxMJ3pOaah+t0R5RhuqJf5mej5Aw3sSQ7mCo=;
        b=MzGjTAcmezcqOma5fIynso9E2dtXglm632QlHvUeS+Sfjl1hM93LHfpb9ItZ8jMjjw
         uE7ltGxR6X6MEoWMnaYL9NbvGXc1paptmI1IforllcRJg4By/WAj2v+tjG1G1UF60pVW
         i84UPS+JJ7jGwkMz8JjkBwUeBGQS9yhP9D1yKczAiMYANgDnA4oDkVHOszm24kI0sQ7y
         OU3/WnDZCHHlXH/WZZAnoiYuNhYIFS5+osksuVPHruvvE+f1PpZ5N5pmaHLNMAMU6wbI
         Ofeae8gzhzrilJ71Zv2u4vsZcdR7OEs78JX8MIX9uKIFQvcVmLrR84z3qHGx+Im7dILw
         l0Nw==
X-Forwarded-Encrypted: i=1; AKwUvBxD1r1znqaaae7feIOnOtZKQnfVIECglhzDoEtCsKOwUKlvEe0niBy7nG2n8QOcv5wRt97Qa0KebQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lmlqs0LhsB0EFqWSK3p9l273eIHLcNNlv5DVBYKAud97NJ+LL7
	pq1A4dfYkEYfYesSksLwAbTzU1JfgLOn4suCMfUkuNshZ60rfu57QHsi
X-Gm-Gg: AYBFou1DlspBNZScvovRaB/RqTIppm12rs6EkvA7E6txWbLq8N5dkM/RbEl1JklQ9Ng
	+zPTNVlZPHOo+JmxfNi9S1cDmBLc1yYf/D5NduakMk+khil5fs6ArOyjvC3lzC9YgwlBY39oZnj
	u++j25PZt7yUSGMf1GMMhgH8p7QRWIgwIPnXeLasSj20ZIPdo68B3a5krbh95+C7VMBydUpMhdd
	RlxqYY4HTWxcPF/ZP8HQiGJce6vihp5wgakksrmwBt8l/ZEOjcf6aWgaf1DhhJ1XiD1dnjjPHU8
	3puumPCykGQBV2aljsvQpNLLQP/Z/NUzYjuIs3pSfAdtOWREQ53PDF6q4nzTJhIeeGYQPxydLRF
	PTEPEXAvKqgq12/F2REVk0DOgRgFEaaSqBJlo7zHI2GzICPJ77XgIH4Fd9prWPRDmU85zyfyWMP
	RaRIY7rl5UV5mXaoV6MihvHIeJaTnCq4pITQ+DWcRZtquB3zup03NLBL5xnhb2YW0Kwc3wgMMUu
	JOg17i31yRtQt1hPnxBOMMuPVUbe4f8zKED069FAEpaaj7HutYXHg==
X-Received: by 2002:a05:600c:46d1:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-49cf820c992mr407515105e9.6.1789022095224;
        Wed, 09 Sep 2026 23:34:55 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e2212193esm2595255e9.1.2026.09.09.23.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:34:54 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	jonathan.cameron@oss.qualcomm.com,
	sibi.sankar@oss.qualcomm.com
Subject: [PATCH v3 0/2] arm64/cpufreq: report and track frequencies above 4.19 GHz
Date: Thu, 10 Sep 2026 08:34:38 +0200
Message-ID: <20260910063440.4677-1-okerixx@gmail.com>
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

Patch 2 makes capacity_freq_ref follow the boost state.  It is latched
once on CPUFREQ_CREATE_POLICY, and boost frequencies are excluded from
policy->cpuinfo.max_freq while boost is off, so on a machine that boots
with boost disabled it keeps the sustained maximum forever.  On arm64
that saturates the AMU frequency scale at SCHED_CAPACITY_SCALE, so the
scheduler cannot distinguish a boosted CPU from one at the sustained
maximum, and arch_freq_get_on_cpu() cannot report above it.

The order matters: patch 2 is what raises capacity_freq_ref past
4194304 kHz on this machine, so patch 1 has to land with or before it.

Measured on a Lenovo Yoga Slim 7x Gen 11 (Glymur, 4032000 kHz
sustained, 4723200 kHz boost), pinning a policy to a single OPP and
timing a fixed workload on one of its CPUs:

  requested OPP    time     cpuinfo_avg_freq
  ---------------------------------------------------------
  4032000 kHz      2.011s   4031325   (0.02% low)
  4723200 kHz      1.726s    524283   before
  4723200 kHz      1.726s   4032000   with patch 1 only
  4723200 kHz      1.726s   4718587   with both  (0.10% low)

The timings never change: 2.011 / 1.726 = 1.165 against a frequency
ratio of 4723200 / 4032000 = 1.171, so the hardware was running at the
requested frequency throughout.  Only the kernel's view of it was wrong.

Note that cpuinfo_cur_freq still reports 4032000 kHz at the boost OPP
on this machine.  That is a separate path -- scmi_dvfs_freq_get()
asking firmware for the current performance level -- with no clamp in
the kernel, and it is not addressed here.

Changes in v3:
- Patch 1: drop the Suggested-by trailer.  It was not warranted for a
  review comment on the shape of an existing patch; my mistake.
- No code changes.
- Link to v2: https://lore.kernel.org/all/20260909192351.33910-1-okerixx@gmail.com/

Changes in v2:
- Patch 1: fold the multiply and the shift into a single expression, as
  suggested on v1, instead of reusing the u64 scale variable as scratch.
  Same semantics - the multiply and the shift both stay in u64 and only
  the final value is narrowed to the unsigned int - but it reads better.
- Patch 2: unchanged.
- Link to v1: https://lore.kernel.org/all/cover.1788712186.git.okerixx@gmail.com/


Oleg Keri (2):
  arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
  cpufreq: update capacity_freq_ref when the boost state changes

 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 arch/arm64/kernel/topology.c      |  3 +--
 arch/riscv/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      | 19 +++++++++++++------
 drivers/cpufreq/cpufreq.c         |  2 ++
 include/linux/arch_topology.h     |  1 +
 include/linux/cpufreq.h           |  7 +++++++
 8 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.55.0


base-commit: df2908090cda368b01ff43709f51890076c56157
