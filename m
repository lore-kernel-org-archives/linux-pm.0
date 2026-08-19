Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5253644A6
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153176; cv=none; b=AfWF53W1UJh5Sjdnrpl5sPMMnff/cJdqu0zn9ytNHzaqU3eZDw7Cs+c7LEwzy/UAstfLLgZL+mkD/UdAWoGdgIWZ9aueR8SeZKkQb6I7pvIZ7PRARCivIkjQRqZWqR/tq85na1rB3fVZbfWRupvXYjl6ZuzT07Iug8k6RL1e+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153176; c=relaxed/simple;
	bh=KUroni8tprXlojD0kzaT0KYlWx9yyDY5qyk+iWcuTGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BHBmyeRrAkVJPvKGIG0bYOWaRRkTQWFfcgm3mNHc+u2M47vxei9bc3hwEHF40aQ6JEz63f8dZUr4i+BjdshW5JXIsF0zA3Fqf0qS0NAUwprT0bXsBvAisxFba2LtYq0K2a5Biz7VoGKlBVphtg9aKBnFoPeZBc9eeb3t6IMQQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITp5tAU+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITp5tAU+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1321588a91.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787153173; x=1787757973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SALXsfEo0CULtkLcwdzPbmcj9OnpSD+IDtXd+njUb7A=;
        b=ITp5tAU+rfMFWRXD2nbAN6Iv4A65wj5ASb5hnRpsKUUf23PFzOinwH3FTWFkPDHnhl
         4iRMpRDJhNq0HkfNg10S8xJh7N5ppWKoxRN7cPahVv+1fNkExfxAnEdeo3MbI2mMIwdd
         byxOzXxyfkf+N+bAgQkGjVBYSY8VJ++ArR8+fiYnJwthin330aBdIGbuuZn0D1yWwWDP
         fPSBQzlhBkW7DKrs/+tnrTTjNzM+ZoBm8cXqxjd28roYyVT77ygm7MGZeZBsQ+CCQKhm
         yt/U2mrrinpf0cj+mFg/oVn7JzREuMx9c/XyGy1HteIWTQOzvkZ671+lMzyXt9At/92j
         17jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153173; x=1787757973;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SALXsfEo0CULtkLcwdzPbmcj9OnpSD+IDtXd+njUb7A=;
        b=Ys1FSxy53sur49WttQ4KzyKjNmF8aT2/VhEkfqr+IzDK+MiRqV6QZ+59/bay1bSoE6
         mgJymwL/dxkB8PKHxYtVGfp63F5mkAx8pWc9w3VMloqUtInF9E9/u7vG9Axt+SdYVlKu
         pzRDsp0BF/ZV7hGmBPchNKppQ5U8ASrdwtU4B8PB41WhcQDmwukk9JPhbnboMJSW6APf
         WXkmZBGn7IZ2hd+ND7BfQGUombbzFERRF0eiUyfAF94ivyeZn1BPzpiL2TSwbUg+Xbcl
         4o4BAohlsEVuNErJlbHAyGfJoeE7B5KhwBs6mTGqExrXPa0TGF2csbwQihLOWCXXOp7R
         jdjA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0RbhdUYKOclFExMVkKbFyWeVBC5KVoSWc1Gd5+uZ7G9aTm02owuXkXYeSYSf64m3KoudCf6ROnw==@vger.kernel.org
X-Gm-Message-State: AFuF++nlcwPO9tVkmFq3iQmAwnfTnuP3UfPLWkXFYHE22zHQ4z3tSOc2
	RzoHlrv1YnfNxEZydrxyxWtMVWrBaywUJz2xaWx5WuW8ZuU1Op3TOkUl
X-Gm-Gg: AR+sD11DhzeefMLJliNxXaffMMS42DjFD7KsXK1Q3gy4JWmP0XLpLs4xVhkEpG3BfYH
	OgxPXECgfKKIhoOMx/BcHmsbgQd0xEg60vUVTdz3bQ2kwNSmexu07ySQ/yDDr3o2m0mUpbTrmPI
	2pE0fUklz1qbujP1fHnyhSjbtFVNCaI0jIxjGQh8RKfRQRjEbjuXkhCy2wPXj9ky1neWyUw9axO
	nzUgMn8a2PglHzm/tKTWNqXqIpZFUyDiXf6omeNWppYKqjrnV0JehAqLbNARS4eNpCYYXG50ihC
	azqRxLpeYpHK4VRe36LQzIgOavivQxHn1MrdISvrgdciAMTVoStjlU6S6sV9AJLPup0bENgFYGx
	V5T8/tgnirDl2cr5SCIQaphGVC9+qFHROPpt34rQhCuJKm9TKf6lUimN1x5TRZ20fGQTdyKe5+W
	Kb4enc6yEnRNQjoHu2cNk9SgmUxnzjRECyGBY24hs4lTUaJiyrhhpan4cRnY3A+47U3+6v7OveP
	WmHOa0ED8s=
X-Received: by 2002:a17:90b:2c8f:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-39580f119d1mr10377347a91.8.1787153172547;
        Wed, 19 Aug 2026 08:26:12 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm8232838eec.24.2026.08.19.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:26:11 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	quic_tdas@quicinc.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v2 00/13] Add initial support for Qualcomm SM7250 SoC
Date: Wed, 19 Aug 2026 15:25:29 +0000
Message-ID: <20260819152545.3934-1-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset introduces foundational upstream support for the Qualcomm SM7250
SoC (internally codenamed Lito).

SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
octa-core Kryo 475 CPU configuration (1x Prime Cortex-A77, 1x Gold Cortex-A77,
and 6x Silver Cortex-A55) and Adreno 620 GPU.

This patchset is organized as follows:
> Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
RPMh clocks/power domains, GCC and cpufreq hardware).
> Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
interrupt controllers, clock providers, power domains, and reserved memory.

Dependencies:
This patchset depends on the following patch:
> [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com

Changes in v2:
1. Added SM7250 cpufreq hardware
2. Added the tags from previous patches
3. Fixed commit title as per the suggestion

Apologies for the noise in v1 — I am new and still learning the
kernel submission workflow and missed collecting the tags from
the previous patches.

Thanks,
Sreeshankar K

Sreeshankar K (13):
  dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
  soc: qcom: socinfo: Add SM7250 SoC ID
  dt-bindings: clock: Add SM7250 global clock controller
  clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
  dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible for SM7250
  clk: qcom: rpmh: Add SM7250 rpmh clocks
  dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
  pmdomain: qcom: rpmhpd: Add RMPh power domains for SM7250
  dt-bindings: arm: cpus: Document Kryo 475 CPUs
  dt-bindings: firmware: qcom,scm: Document SM7250 SCM
  dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
  dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
  arm64: dts: qcom: Add SM7250 devicetree file

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sm6375-gcc.yaml       |    4 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |    1 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 .../interrupt-controller/qcom,pdc.yaml        |    1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml |    1 +
 arch/arm64/boot/dts/qcom/sm7250.dtsi          |  612 +++++
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   24 +
 drivers/clk/qcom/gcc-sm7250.c                 | 2347 +++++++++++++++++
 drivers/pmdomain/qcom/rpmhpd.c                |   19 +
 drivers/soc/qcom/socinfo.c                    |    1 +
 include/dt-bindings/arm/qcom,ids.h            |    1 +
 include/dt-bindings/clock/qcom,sm7250-gcc.h   |  163 ++
 16 files changed, 3186 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7250.dtsi
 create mode 100644 drivers/clk/qcom/gcc-sm7250.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7250-gcc.h

-- 
2.43.0

