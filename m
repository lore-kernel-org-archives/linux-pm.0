Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF23B27E8
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131434; cv=none; b=m5KHj3+MIU6skoMqQMZ1JMOCWn+WkXXeN8B04RpuudKijJt78kV8Geuz6hecOsYvR5OfmCOSQFC4ri60CPiTrpruokbyrHTgIPpgnvS9c3xcHy+lGVzzizCs94USSuNxK4T+ukFgHNb3J/2TFsknsKJ2wt4XcZI4QIUbE/MqTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131434; c=relaxed/simple;
	bh=dZJ2vlrKh/TokO7NMCIscFTNlFUSIfEbK1LTnu5J9bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EtV9mm0eTwP6FANAUZB5m/tylddYom9GWoGl0hUrFxamkiqNTjknwokqa4E3FtW58W/iZ/ZjzPEaYEiN+CIzrBx4bJXYPuJKQr1GFzBBx0rEx4kPG5eneUhXYA2l8UgsYA/WGiE8P5y1FQ1+oxGWT/tcYCSkaNqfWMVl2HJUI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TexmuB+H; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TexmuB+H"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35943f55c06so877789eec.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792131432; x=1792736232; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsXxYmorNHva6PcyULhjxemD8mWSIJAUyWIJ5EflALg=;
        b=TexmuB+HsqVSXYy/OzjGLa65Au2aYR4h3ktTediN7d0LmR7ELLdOswPmKUfkJ/MeW1
         VXK7eNLsSIjdGEDJnjTKJf/QPEXSIWlIIn1iuE1hZrSMQnsjT9R5vyubqUpnHUxDoPin
         784yg6UuS81ilYpXWyfs/TzzYKwLyVOZT+AlZTqZAwYLn/VHfBla7rzMh46U4oz66h77
         B8D0RV+fN8xSaB/nsz6qXfCguG+5Eay1/vg1NuGIbaXjLjLo3LxKAy6JOPUxMaCLRvxK
         fhxEg7RowF8MlbkIEngSLoGudEmG0F9mC2AyXza7anUIRQ8BkZgzYVZQ+U+f2cyXb3G9
         6idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131432; x=1792736232;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsXxYmorNHva6PcyULhjxemD8mWSIJAUyWIJ5EflALg=;
        b=Bp4XuaYBPJN7QJcV/gL7BnaRBrPv7erD7bkpxhAAp0RMyLvVxzLB5PsXnhey2F3hnc
         ptXlxzYvimSr8ug2MUH615eF4KPaTcHDl+NijDsr7z2nKpyoRQDGxr21ijF+QKutuhIj
         dZ/eTZOJ63BoQKbcf9MqdK62FXmA/Zy9rdGLMJiZO+6jjD08P+orIGdJmViYVC3q1+gu
         WK9L/mMzAHtb1k/P4X+pnzR3JYVysbS2yUewBcZ54kX953Q9xn96hggEnddBj2P4MZvv
         i1GcBISUQx7g8f59eWzjGaJJT1qhNpEsIfDDiMoZriYgoaESsVS+04C4bjWjwU6b/aSB
         mYmw==
X-Gm-Message-State: AFq9FYKWMLK17u6FxDZPQuOFaR2v7k9lnwcEUAuLxlgV/RFasQhpGpv/
	lZjsi+N5pt6BJeV1fX1ARbYYdkIUPjzEUeXvb6m1fA+MQUXJ92RQt1eEE64T4/j/ZTA=
X-Gm-Gg: AYBFou199xqfYIraUEgE55sHfpttjL/mUzz/v82X/rqkJyK4cA7qRk1SnnfmUI3rHQj
	VH4KvBzQDy6JJdqIRPNelHUFWQ1J7hBs0bw3SQIgFU1LFAFTqgyNTgHvg1q9l2kdigXgbzUo6zs
	LtxlsP25l0xmnK+PEJT1SqcQ/qrpufQDEukS5vcc8innWDp5It5cH4q/9FsXsPk0PRYp5KT3ge/
	P6Wdr82HqD6LFTvBXm0NDMwCqmynrYiVmBs3v2HDp1FobqdKsG0E/AM/w0LAVF+N3Tw8B6kbmW/
	yMerOMGTPcfvKw8eE12xQw+pn0Lb+r250WaoBH9GcIQ3HKgpWaTxm+9nz75I9s8be88dl4sCmYI
	Re+jmhgTrm1gJQW0AyXbEeD9tLy4GLuSxOCx4PNG3beGF/dcuT3sBRA14UPd/+/UStt7acC8gij
	ef+EWbjFrcbG2CJADH4YABro/ys6TsNrl4iom0XexfnoFdNSRXUWH1XZPOv84NwdMaVpvTlUta
X-Received: by 2002:a05:7300:50f0:b0:35c:eb2a:8c2a with SMTP id 5a478bee46e88-3602ae5f83emr2979450eec.8.1792131431775;
        Thu, 15 Oct 2026 23:17:11 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm4115171eec.0.2026.10.15.23.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:17:10 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:47:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 7.4
Message-ID: <atHBZAGuEvFABQxV@vireshk-B250M-D3H>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-7.4

for you to fetch changes up to 81792daacfb41ca07b04bd3956ea9e672080cc98:

  cpufreq: loongson3: Replace IOCSR read/write with MMIO ones (2026-10-16 11:12:33 +0530)

----------------------------------------------------------------
CPUFreq arm updates for 7.4

- Minor fixes to in various cpufreq drivers (Alexander Koskovich, Daniel
  Schwierzeck, Frank Zhang, Haotian Zhang, Kathiravan Thirumoorthy,
  Sumeet Pawnikar, and Xueqin Luo).

- Fix wrong behaviors on multi-node servers in Loongson driver (Huacai Chen).

- Reject NULL from cpufreq_cpu_get() in the Rust code (Mehmet Koseoglu).

- Add suspend OPP to mediatek driver and DT (Ryan Brue).

----------------------------------------------------------------
Alexander Koskovich (1):
      cpufreq: Add Milos to cpufreq-dt-platdev blocklist

Daniel Schwierzeck (1):
      cpufreq: airoha: fix probe failure with correct error check

Frank Zhang (1):
      rust: rcpufreq_dt: add module alias

Haotian Zhang (1):
      cpufreq: qcom-cpufreq-hw: fix device node refcount leak in phandle parsing

Huacai Chen (5):
      cpufreq: loongson3: Make this driver depend on MACH_LOONGSON64
      cpufreq: loongson3: Adjust the width of id and val in smc_message
      cpufreq: loongson3: Replace per-package mutex with per-node
      cpufreq: loongson3: Use global physical CPU ID in get/target callbacks
      cpufreq: loongson3: Replace IOCSR read/write with MMIO ones

Kathiravan Thirumoorthy (1):
      cpufreq: qcom-nvmem: Add IPQ9650 support

Mehmet Koseoglu (1):
      rust: cpufreq: reject NULL from cpufreq_cpu_get()

Ryan Brue (2):
      cpufreq: mediatek: Enter system sleep at the suspend OPP
      arm64: dts: mediatek: mt8173: Mark the lowest CPU OPPs for suspend

Sumeet Pawnikar (1):
      cpufreq: Use %pe to print error pointers symbolically

Xueqin Luo (3):
      cpufreq: sparc-us2e: fix frequency table index copy-paste error
      cpufreq: tegra194: fix double-pointer error in get_cpu_ndiv
      cpufreq: sti: avoid NULL dereference in dev_err()

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |  2 ++
 drivers/cpufreq/Kconfig                  |  1 +
 drivers/cpufreq/airoha-cpufreq.c         |  2 +-
 drivers/cpufreq/bmips-cpufreq.c          |  4 ++--
 drivers/cpufreq/cppc_cpufreq.c           |  4 ++--
 drivers/cpufreq/cpufreq-dt-platdev.c     |  2 ++
 drivers/cpufreq/loongson3_cpufreq.c      | 73 ++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
 drivers/cpufreq/mediatek-cpufreq.c       |  2 ++
 drivers/cpufreq/qcom-cpufreq-hw.c        |  3 +++
 drivers/cpufreq/qcom-cpufreq-nvmem.c     |  9 +++++++++
 drivers/cpufreq/qoriq-cpufreq.c          |  3 +--
 drivers/cpufreq/rcpufreq_dt.rs           |  1 +
 drivers/cpufreq/s3c64xx-cpufreq.c        |  5 ++---
 drivers/cpufreq/sparc-us2e-cpufreq.c     | 11 +++++------
 drivers/cpufreq/sti-cpufreq.c            |  4 ++--
 drivers/cpufreq/tegra194-cpufreq.c       |  2 +-
 rust/kernel/cpufreq.rs                   | 22 ++++++++++++++++------
 17 files changed, 100 insertions(+), 50 deletions(-)

-- 
viresh
