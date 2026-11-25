Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643753;
	b=XXY5IUZuJJyCtlsil2vpXtw5+rgXrAJDqkv9UBCEXGaScTib1JnODfZfkrLLXiQqqaEh
	 J8PHy3afaY5sJSdSA+Q6b5TVzh8HkRv6y3Fo/lKZYFyusqZ8iA33245sN4aTqpVzsX5Nm
	 bMm4hKDoJJjmSut8Pgr8vwRqSj+GSIiVf8NN8PeFQQsaAJWTvNTUiXC0V0wI3psZbNfzR
	 K6ENjfXF/I0x4oQvKyMBS+23JLi3I8p/vn5b3Qn/H3IvnzT83+BzF3FhGS5UmfhdmpV+2
	 BypDHNMUT3Kd5SrriV9f2oMlZkt3OdphL/gv8VyT6F2sUuQdw7KuNg0ZO4oY7ZOBlAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O5MpsdOOKt6WYnEOMw+jiBh7wLSAzt3pbyqRaYl9xCw=;
	b=zSEvpC0EiV0RnuS9bMgbdyQNTMOSqbZENwcTlriLzf0FaanJDxUss02Pe5q7uTzCaWLZ
	 aOSQna/hRpymzzY4UO/6FORXaJZ3WI4V7VzIQx9YTjOTYC8JZy6MMgSsPw6onCE1CqbKs
	 XL48XAiqVQDrT0v55pyJYpFJri+MiooLcAKZd7iYjr7xH8eK3cz3IL7AOH/YbhlBKOlge
	 xXAZ1esWZl9itBrySV+zSoEfDp7SNHBlbwjE/qY2G5rSN2gaQ1zL2jE5eFIr+erOEe66+
	 AFSpfqgn1uifTG+Yuq02PdJfHsLvdCofQnrewozmd2UPlBBcFnfTXs8t6it06o41fEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYdrHTrP;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C134606A331
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 21:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C134606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYdrHTrP
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6bab10844b5so6768051a12.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795643752; x=1796248552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O5MpsdOOKt6WYnEOMw+jiBh7wLSAzt3pbyqRaYl9xCw=;
        b=QYdrHTrPhMglMeTWmpJY8mRzOL8k6sKwd8JlnzXXPNBtCcJCpPgvDL0SxMbyvWXxPu
         2rzNKPPunQctCkMUJg6ZeR1F8Iu5IXx6ShD4cMnYUEVF0UQUdtgMCKKRlrKo62xvbgtb
         s7Y+j3veXN3VOokGRGjoYtsAyJXBI9EPtjR7ltxOAOprTMrJ6NTdEMCD7aHsurKR6AE/
         l/BHsNdeGaQ2zw8sAgUuRUtPJ339DGWibZRw6wpBHWhb6MAF/VLdpFLoajZNCKRDAjj1
         HFWlfLH9JTmaPt7wNLzT9yEuQt72YW9JidIFcNNrPU8Pml6qOx3n6aXqC2Ab0TycnsSo
         Wfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795643752; x=1796248552;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O5MpsdOOKt6WYnEOMw+jiBh7wLSAzt3pbyqRaYl9xCw=;
        b=SN6exxkB1O3rwKDX7nJklhbtvX3gVM0qSqhwu+7Y4rWAKDlgO7YendX4axeCuqFl5/
         ySLf0ZPGTn9BzQBJPJvbMY1NRJ1H5L2J44hX8HVeBCXvy30EJph/82ObFMnlvTxpMkuL
         BNRN9qF6sfYl5/W/mD8tMFErTEgVVFS/n6lzsAWIXap5SPNc90iugN02ux/ncslM9oXP
         CN6xhcTasx+vQm1u/Laur1XmSecbYCTFK3V4LhNj3m3zwPgSiPe54oG+tWXOVVZ/3eq2
         GMh/LzH9YLcNf8JtjjfccauEcsdmwmbVQ3mxga9DilCtAkMZfHtRiazRohlKbITokHoq
         nbZw==
X-Forwarded-Encrypted: i=1; AL+hErGEMaW472F+UDUZjnX10nAalTcHu5JoAfb/EHlTH8X2N6R5v1E+FmEx2kQVtH+0Q8gu5v55ID7SgQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9LqLftRqdVgAQQ5elFsW1IcglD6l4c93mi7P1U58fKlX7mb8K8
	QMnVkV4O37a5bBQlS54sNiYuPQf7PTzGEnJHdwtjyEvln8BDQ8PrUck=
X-Gm-Gg: AZFdTZek4dyFT9AI6OHRASyHsh8bGf6FiYsJwmdWuLvxWi1LTF6zl0W4Mgc4sJQzIeg
	LdKr4gt4MHQCvEmprMVr1HLQpC6xli4byVuvJS2B8tOrgcuswjCeuy6WlRknnjVsZGCHxecsznP
	bDq+ndlJcsKS2z1fxQ/92ndFpTfe8t/7ZdXm14ukuIjzSbQXHVXbo1yfMNBBUQugH2oS3HG+g+y
	KrG9k1xE0BgHaq+1pPkUktH0EjsU+LhFxSU8gOJkjj6tadKBw8R/ytenZiiup9emJDT9ObazDHZ
	hBc7X18q1x+DpTlYuDZWiknZjfugTbWb9gL89QuO4aN88wODJdkc51tUGWNyQtHDzdoiEqOxzDJ
	HKR4J684ui3vM5ZCmLelMecvD1VZSg7pby+qcPQ+vFCmuQOyRGp/ULzYuUk1krAypVM3eVt3lXh
	7SSQJpVWOhBWFJNbzvtXPMPE59xEM/1nzwudUF7HsXxM1E7RQ5xKBHVeyaLzx7HELmPshS2bipW
	pNlzT3m4wT2ZYg1f4m6jUBtECDG97Kk/Uuo47dR3M/wb8zeKu1TJgtt5ZdAuryTNN2tIDmapYZz
	egRuMpFKVh3gc11YlZo5l10AYZmqEMU67sZv6mX5Ax5r4SrcQ/THqKgnQvb2F/IrXvFUbSRWoDG
	X6Fe5AQRArdwzqvIGbPqn74CyJA==
X-Received: by 2002:a05:6402:370e:b0:6bb:b89:8ee2 with SMTP id 4fb4d7f45d1cf-6bb0b899043mr4209318a12.7.1795643751507;
        Wed, 25 Nov 2026 13:55:51 -0800 (PST)
Received: from sohrab-omarchy.fritz.box (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e77d8sm8608871a12.14.2026.11.25.13.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:55:51 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Roman Linev <admin@mswin.me>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: qcom: sm6125: Add cpufreq-hw and CPU idle states
Date: Wed, 25 Nov 2026 22:55:48 +0100
Message-ID: <20261125215550.1834075-1-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SM6125 has no CPU frequency scaling and no CPU idle states in mainline:
the CPUs stay at the bootloader clock and only ever enter WFI.

Register addresses and idle latencies come from the downstream
"trinket" device tree of a Xiaomi Mi A3 (laurel-sprout), where the CPU
low power levels match the SM6115 values exactly.

Tested on the Mi A3 on next-20261113: cpufreq 300 MHz - 1.80/2.02 GHz
with schedutil, WFI plus per-CPU power collapse in cpuidle with rising
usage counters.

The binding patch from v1 was applied by Viresh [2] and is no longer
part of the series; patch 1 needs it for dtbs_check.

Open from the v1 discussion [3]: Barnabás Czémán questions binding
GPLL0_OUT_EARLY as the "alternate" clock. The driver only takes the
initial (300 MHz) row from it, and downstream SM6125 (trinket) does not
bind any clock to its cpufreq node, while downstream SM6115 binds GPLL0.
So there is no hardware proof for that clock on SM6125. The binding
requires both clocks today, so they are kept in this version; if the
clocks should become optional for these SoCs, I will respin without
them. Barnabás's own mails did not reach lore, so [3] quotes them.

This is meant to go together with Roman Linev's SM6125 TSENS series [1],
which adds #cooling-cells to the CPUs and per-CPU cooling maps that stay
inert until a cpufreq driver registers cooling devices. That is why
#cooling-cells is not added here.

Not done yet: cluster idle states (PSCI OSI parameters need checking) and
an energy model.

Changes in v2:
- Patch 1: cpufreq-hw regions are 0x1400 long, not 0x1000 (Barnabás)
- Dropped the binding patch, applied by Viresh
- Link to v1: https://lore.kernel.org/r/20261115003158.391171-1-majidhhdri@gmail.com/

Based on next-20261113; also applies cleanly to qcom arm64-for-7.5.

[1] https://lore.kernel.org/r/a3f071d3-6082-47a1-bb00-9d8e72fa3cdd@mswin.me/
[2] https://lore.kernel.org/r/avvnF7zQfYhF11so@vireshk-B250M-D3H/
[3] https://lore.kernel.org/r/20261117173547.1656090-1-majidhhdri@gmail.com/

Majid Hajiheidari (2):
  arm64: dts: qcom: sm6125: Add cpufreq-hw node
  arm64: dts: qcom: sm6125: Add CPU idle states

 arch/arm64/boot/dts/qcom/sm6125.dtsi | 61 ++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)


base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
prerequisite-patch-id: a01c38e015a1f9bc178b74a4a2451f6170eafb54
-- 
2.56.0

