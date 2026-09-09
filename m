Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328E3C4B83
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981849; cv=none; b=d4EyHi0tdqEmoUZCxVcLpeTqT9d+fNlAgSufl1ntuwyMh+tbpvse2ZFd72Bj0e7spHzkeqsa/qgSEu/p1frPBlK96GHC2Qr7SWO3nIx7IdGuFOrGT99jiuuIlLCsD78gkfWBiqkQBTMNXWFG3m6xRUGl5e+T3mw038y8A/tijB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981849; c=relaxed/simple;
	bh=z+PwFWisLAZ8WrSIU6Nq7JGZqrrzKxVDpeLvGJYlMhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7A4DMUyAunGkvo3jmgVy9baTRoyyhnyDdkED620PhsoXO1GrIKlQM+i2arPGBLQ/jtBGaPEQb9pPS26vcB4rz1/TJD4C+seUggJSve5yIxvV5MpYLY2k+xnIMxVcTtoWIzJzYIHzUbg9/EXYoR/4zn0/Ok515OpDtri7MrWj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezXVmacU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezXVmacU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso90735505e9.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981845; x=1789586645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=juSntAU8rs/3fLNwoSR5HtlpUx6UI0vk4BclFthIHvc=;
        b=ezXVmacUjkLLyIiCq2WYtuGfljXUhZURv4ak6qez1q7Ybl2ClVHFd6pVvSgGcE8sWE
         4AXa3Zzc/bjENAiaGPuSS7S5Ykn2Uy0fcgMy3KeECUHfHHGga+zAQSK9xbLgZAx6Cncv
         BQoj116nt7YRUz+GBIW1x0dp9DxNJjcxzl36BV91yLeoIp+8iPKRmP3w7/2kA8iF424+
         ucGh0O5AH0hv/sUHEjKqJIm3iDsyw2TnvLuvNWBQOLe7SHaNl2qnpYeuwyMO8ZnXL23d
         dRuPkoq5+MZOqhGuJEE4Cjqiw6VGqxRwi+2yhtOXsRnu/ZbufEgwiF8+HwIb2ve7qWpT
         DIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981845; x=1789586645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juSntAU8rs/3fLNwoSR5HtlpUx6UI0vk4BclFthIHvc=;
        b=PGys6a5/d/hf1eE+vLnWE3bmnuamA6sSw84pdpqTRXZnGo/YjLxPry2p4MKnNwQMaB
         ALWS4RQggu9rAJTnTxDreSSAubXiaooUtJFzuiZB0K7UHF9HFVpMtNax2F8Ee5fBQg2O
         pCCbAot9BXN3oPvM66Jg7a8fPXcVqC1ym5/iDg3PjQXFtHpR6kvkWd4w8S/BS4p0xoGJ
         cEMq522o2VAcaQZ9H+EizUBMJ8b/EJDhWPbevtCjek5v5D8F3jviTYtrLtSBmQp5OiMd
         qqTRNdWc8n5RSif39qBSXubH9UXsVCkUxX+4xmRaZTJr0AWwEKTI1MI2fY4asr2l8Ylr
         ReDA==
X-Forwarded-Encrypted: i=1; AKwUvBxhn54l1B4wIsAf+oFD8vjpgsQ0YsMJJpqCx074RoB0/l80YTaCCBspFm9GvaodUSRV/mUSQ/TFkg==@vger.kernel.org
X-Gm-Message-State: AFuF++m7HZmU1wz3AXgweyc+5G5dIjjH4q4KS4CTrR1M0s/KauZhXGWm
	RMj/DUJILbrX3A7vnQ2Ze5lYdrvST/CCX6w/Ew0no1jfKTTskv6uUXg2
X-Gm-Gg: AYBFou2KIpok2gDpEtlg3msvWn2eYk1i86vJwMwhJjDvvUPNEVLeYcx/OZNwkJuwRId
	y7zWLqgiUgAxs/QP8wqxz0r4rDmGJR5lg/guLFHXJ+aLARxZ9knyo60Tg6zEq70/MqRbPtPn+Dq
	ZL3OoO26nU17ycSNWKU5/9ZRzPXck8m+RNuz6Yx0vH9Cl0I+nBkA5VJAbqrUv2CbUcyJ7TA1AZU
	bWUwReXwMzkU2KF9yUaiJjJlwaEgGQXYkdcGWOOLud3QGd+SGaBd2l0Dt0/RaQlcVcyozFr1rR0
	vInp/3pk99GbE7Xbpt8loMy6XyJ9eyaSe2DdOxW8DIz1jft4xmrGwMi31rD5yEzsBQt7RA7fyn3
	3OO7rPD6K5DwGM2yzLQaP2Bxvwk6zbMGkf/bAnJuJ2eaWPnHAyuzhr1FaQYF9ieUBpwm+gEAmAI
	P2Xy8rqpNAA1Z7ElCwF7j1PXZua9rIP24bhpp7O8OdDhm1liUiRD1rhI92XfkvQ5DjKuqSYAmQh
	lGiHnVt8XYJJIdDvceYsxALxX1Eig2u/n3EloBiN6c=
X-Received: by 2002:a05:600c:3b18:b0:49c:fa21:1c8a with SMTP id 5b1f17b1804b1-49cfa211d97mr316363405e9.31.1788981845342;
        Wed, 09 Sep 2026 12:24:05 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d26bf9490sm10925625e9.9.2026.09.09.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:24:03 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
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
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2 0/2] arm64/cpufreq: report and track frequencies above 4.19 GHz
Date: Wed,  9 Sep 2026 21:23:49 +0200
Message-ID: <20260909192351.33910-1-okerixx@gmail.com>
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

Changes in v2:
- Patch 1: fold the multiply and the shift into a single expression, as
  suggested, instead of reusing the u64 scale variable as scratch.  Same
  semantics - the multiply and the shift both stay in u64 and only the
  final value is narrowed to the unsigned int - but it reads better.
  Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
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
