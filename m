Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702724;
	b=GuY5IFzS3yzll2X9SjLK0KLYmKPwB1TxAXQCBkoRlE1xtxR7XlV3gZQpzyerjOHqPtAv
	 86LZymWlEVVqHwNdud+oKlAupAnxXXuC9TRmj9CLBRdB58YbyRVGRbScG81EEqnIzinu1
	 n7Ckzv7oZmZsLerBsYtOEsKBZhOvXm0Iv3v+LVrJPfFZuWNWEkYc0lEuO2PBBw9D7XE1w
	 yv8TIOjej5F6FfMirVV1kOpP9vQqf+yXmxVILuF7yaoE4eCMKRmtOXDe6dxesMKPJnxYK
	 q0IN2INYbYmM5vksFUCn76zqgR6lKedTwxX5cRGqnnNjpSUY2qJjiJlGyG4YCVIq+Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1ORxa+4DrubomnpEFvgyCRsCft1wmp5DXp98YT3uKLs=;
	b=r/74zh7FTPGYl6lFO+yXd43ZC/1iqtkawbp4Ph9WQIqMiw94qRCOaJR3lTucXOKhq9kx
	 BLAwYrRywmMhDIGrYMDM0XVSGiF8WuL4JR1R0D18K+VVPjuSfIPvHAydw482lRlXJHs2M
	 4XS4Ug2DI0t6ru9yfPuQdRBRASEeJ6nSaP3FXvpUI2Ux71Ij3xxP0lqUkXshrRk8grTQf
	 7ZMu86DthCMxqq1RUZpKkP4PmRKkJGh1s05Yv9viMlkyT29A647Db6o/almzersG4CLYr
	 kJTfhHgOEX6oCk1b+NFky+c95ufzprOPj8MpbEDA3srqhbvDr1rljwW6csafAp84exg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlcA9+xv;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA5606A32D
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92AA5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlcA9+xv
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d427836e9so314081266b.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702722; x=1795307522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ORxa+4DrubomnpEFvgyCRsCft1wmp5DXp98YT3uKLs=;
        b=DlcA9+xv6ovQ7U0XnP+svbUjFjhy51cSsHATRyAaPicXbRqayB+mIxzC5TpzMRQLk3
         LDt5Ce3qRNLH8PwS7YhfnLJTO3sZ5Jw0SIlH+98arhzVSvxqqfGBH5JYZFwoL62y15su
         wSgCV634hpJfX8qy5Sb+HU/i8rQ5zkT+wDnjFhLakA+1o2GAbK6M37u3xkX7TGJCtZ/p
         /7FfFneDcaHDSw8ccfL0X3aXh4yn7de6KDDMUFRs915zjJgwJLIwM0iiQKphMMH1y0I2
         UwFWMlH9SmtKMcd+Wmt5YwkcdjMUUlhOlT2Z/geKLUE4DmiJdkinMK5Zw5D6J0D4iRwD
         4kOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702722; x=1795307522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ORxa+4DrubomnpEFvgyCRsCft1wmp5DXp98YT3uKLs=;
        b=qw88nYB2UB6AfZNtxQOru6w2gk56CJP4nxyFQcGyyeegNK4ky5zwTZRX7A9kTmGn3v
         tKdz7tPeOX5c0Q+s2nsaUS9llZvS16egVkTOLZit5PBtsZDXzwx/coRDUZi6gaTLArJo
         g5g0jEjfYiTRj3sDzNX2myj2mD6gWDA4EexnGF/VWCPuNkYqxMYAWVYyZvdHorhAmKY+
         FulctjUvTs51PkXF89tENix2G0dhzejAL2xTVHGPAN74/tfKJ0fKe2mODfP/CcvRTbfR
         Yio24Qa24fgkvS1k3Ue5bkF2C3m7WSSwh4NCroRc1tJkfWPov7ptfB0HikzJnECp9KJ5
         unuA==
X-Forwarded-Encrypted: i=1; AL+hErEqYYjnKKRuwJEzXD1xnJjxwpT/KXDs0g09Li4kN5XPzQx5rzjGRUbynbCcGmeMMd/YclIFimld+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qx3yeXoeKhFt8gkN3bMsyi3DTu5KLNLMaofo8FKy5fiCYQi1M
	ykEBNM9JZR5AGxezx1KqCX1M+D2YHIsDh2nY6FrIU//BhxdFWpae5IE=
X-Gm-Gg: AYBFou3jlQDwVO9VWNQQnj8OWa/Hj210yJi3XAvHUahwEehEQ0EKJh3FnzAO5l5GKuj
	PMnAR0niFzPCOl73NocFQNZ1lL0n6ThDREQ7iDPFVuZ10NHhSq1FONZfGXQQuX4glOJAulyYogK
	17URJM3fahT/bJOOYEag53AwYDXXKIu0w5Oc5xlKa21eNHVplBMvaR/KtFWd8JUvkrnWBSdTBcH
	oSBqUT93NACW7ltR4hf/luq0wKuWPCIOVhab40I9HHVE6WZXuSgIh160rFrkIaAGKWuuB1gruGq
	Q1Fgw18UeJXiThvxIo7Jfd9fPJbvzBQpfCpofDRwOPl4GmjKBykSkqlgCoNqPnUNLcWS0RjIM/r
	v7yh/fvqobHpiJ5Pkf99cwkD/Ofp6NYDZU1E3b1m8HTgSMBqhQXKq4FoYVfPdDt0wb2VcYfQeBs
	u1rhI3TtM0X1xYfxQY9hI5W1YgenqMh+gw5WtExAuQQUReo2dxabVRk4ueCa63sJqbzXH4w9Pw5
	bkR+oHCTPyGNyWmNx6mwlmfWi7oEY6SvTj9RZZ6XEYCks3zWJAzxVCEcTCuL4XHlDAdKuPlxZVl
	iXRaOvw9+/k//KF4N3eqw80jAXJrrKXsXCmI1U3CDdSWq1BLgXR+FH9ZLA3rNnopC9E+QFt+tu6
	J06/zqfVFcB2F+8mrcBg3UuKKTRbVq4y6sMU=
X-Received: by 2002:a17:907:a714:b0:c42:5363:38dc with SMTP id a640c23a62f3a-c509637e20cmr507032166b.25.1794702721723;
        Sat, 14 Nov 2026 16:32:01 -0800 (PST)
Received: from sohrab-omarchy.taila18b31.ts.net (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5c4b7sm260695166b.1.2026.11.14.16.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:32:01 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mani@kernel.org,
	admin@mswin.me,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: qcom: sm6125: Add cpufreq-hw and CPU idle states
Date: Sun, 15 Nov 2026 01:31:55 +0100
Message-ID: <20261115003158.391171-1-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SM6125 has no CPU frequency scaling and no CPU idle states in mainline:
the CPUs stay at the bootloader clock and only ever enter WFI.

The blocks are the same as on SM6115. Register addresses and idle
latencies come from the downstream "trinket" device tree of a Xiaomi
Mi A3 (laurel-sprout), where the CPU low power levels match the SM6115
values exactly.

Tested on the Mi A3 on next-20261113: cpufreq 300 MHz - 1.80/2.02 GHz
with schedutil, WFI plus per-CPU power collapse in cpuidle with rising
usage counters.

This is meant to go together with Roman Linev's SM6125 TSENS series [1],
which adds #cooling-cells to the CPUs and per-CPU cooling maps that stay
inert until a cpufreq driver registers cooling devices. That is why
#cooling-cells is not added here. On my phone the same TSENS
description (derived independently) runs together with this series and
the cpufreq cooling devices bind.

Not done yet: cluster idle states (PSCI OSI parameters need checking) and
an energy model.

[1] https://lore.kernel.org/r/a3f071d3-6082-47a1-bb00-9d8e72fa3cdd@mswin.me/

Majid Hajiheidari (3):
  dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM6125 compatible
  arm64: dts: qcom: sm6125: Add cpufreq-hw node
  arm64: dts: qcom: sm6125: Add CPU idle states

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |  2 +
 arch/arm64/boot/dts/qcom/sm6125.dtsi          | 61 +++++++++++++++++++
 2 files changed, 63 insertions(+)


base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
-- 
2.56.1

