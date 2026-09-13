Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137993382F4
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311559; cv=none; b=C5wl3xCw6A72b4UdbCx3ev8l7ddsUbiqa50S3EPwJriAKVW4wpW/c2irlO6nOhKvKF7rD2osrYysIuFSITgxmSd8MvL/7u2INAElJDVUExLtnO0vt4aujd/d72Cl5xviUKgHt3mIn0HVIKjSvBZD7elz1lYBDcPEEhH8PvD5UbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311559; c=relaxed/simple;
	bh=6vK0z9//9rngenyPHQtdNFlBhAKHWpEMyefsIOzovEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQNiQREx8WK37b5wGGEOD9dncTsFDaF1O39eXEsKxctLQbdpT4PUAhetwU5x85o4S/D1yvCaxOcuGwvkSuClvDWItg0E9G0pWeVeiEmy50KG6xYJeaYpT5+8ZP3ayF3BftwyRfwS9wl8VO0ovqSRetx+p2MYN575i4LX499s/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNYB7j2q; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNYB7j2q"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c6920so868355a91.1
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311556; x=1789916356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ifs86+3yzusOqbHusfFJjo1uLj4OkYHhXzsQhWXXtVA=;
        b=PNYB7j2qnuS03CGgiBFIUxDtDo2TyOg/Ri3MVg4z5o7SScjSA5KOIBYjBHFX/zWsHV
         w4xS5j0zLG/7w4uKfKG8htIG5S5zE5oUENaZOaHVC8ovsb95Y0QNQbXE76OC6yCPDCzl
         XWtvunGg68gRXI/DFLesJ/GmOgiXxWep2UU+baoiCoH551bLsuA5a76PJvBmYbxBFCL5
         rFnh8rASFZEDypCs4zZHmh9/zUu0KwxY7YwEHT2AK9ij1gAyKt344zG02gjP1Kb9znTN
         N/dhbIn866kJdUVq6cR6xRF0kC+AD955kc56kyiaaCQNxWqek0wXDQ96vsrfknIPIn/t
         zuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311556; x=1789916356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifs86+3yzusOqbHusfFJjo1uLj4OkYHhXzsQhWXXtVA=;
        b=l/EHTwu7kVRtfRq/LRjtwaGVLT57hr8Ji7YC2+3Y3MXJgzPea4gCYzZdP74EtwfDGg
         n3hyaBduW1B5qW4Gl7lTungQiXsyJElpTm/szA7MngwdL+1AsP7K/rl7Bg7T/mf8LY3t
         G/VPpRIgejb5iwXUhAmXCps8J/SZk4Cwo4d02Cu1exa4kWiKL/Cg74pjDdrMnt/lZ2er
         bEs7ciAmITfbx8m+9vRRT3/OLifVWglFTXO6uXVABBzVdN6mVO5PLSh2irLirC7cqMzE
         X5C7bdW6V+M+r4g2+8BAJwj0aOYQ6fuRkbe1UqXAKKuTh2w/s0x2Qu7gD2f0k4d1Zkko
         He9A==
X-Forwarded-Encrypted: i=1; AKwUvBxTwb9JlrpQj+WHacv3mTN7RyizPzRjAdbAf6TUrT1WsLlBw4K3UMaIFiOGrtIQsKl/mbfbyR+cPA==@vger.kernel.org
X-Gm-Message-State: AFuF++nsvQmeBGqcNrALLarkjxoYF+SM3t/ODxQ/0+smntJqK+r9h6xM
	81OyLdwpXQ8vnemfZgvsy3Fl4fsKMXL9DDNZKlpO7fIBHluNxjBZyWv9
X-Gm-Gg: AYBFou3OgI7Yhe33P8HoFlmlv4JiER0MC3ukW2JKKM0UhepdqbFOj2BagdU+qmQmgDM
	ByxpxCZ0HRTlFBOrTkRFxS08gSDzMRJoECQMApTjN30mx0hZQrvki89uCIdqGjbaJ2/0NFpT8iw
	q2MDy1oC4J8mQ2WXyQSZRLGrGVTJIjQ/qGQtFYgu/eHZnxDAozDEkkogFONshDMFi7Z3mGD3kFs
	NecLG1CnrucHH7szdfQwQzBzlab1HfpQ+abZRLa/UZEhhquwkRNYW/4AL7wvFEp/JR3xeq6Q0Lu
	3rAOkNU91MtAlTVNLvUdbf9Kfwy248bHzJCGubsKkqHjYqlTFzicCMmKMYcBry0EvKEfNSQmKpD
	znshIwoVnYV8+FZBw8sqoKC2L9XCQp4+XxHbfwjpFIoaZHTT+FNGftucZPtV5C3bZXDcRj1PfSe
	tD/g6uMn0bMYp2KQ5EO+PLdqhnjFmYf+VH16GIUq0CLd19yjtViKq8fw261j33wqWLorXrDY+uy
	5RHKr2tjVQ=
X-Received: by 2002:a17:90b:258c:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39dbc1d79aamr13876016a91.11.1789311556047;
        Sun, 13 Sep 2026 07:59:16 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm17536306c88.11.2026.09.13.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:59:15 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v9 0/9] Exynos Thermal code improvement
Date: Sun, 13 Sep 2026 20:28:28 +0530
Message-ID: <20260913145905.9404-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series performs a number of cleanups and refactoring changes to the
Samsung Exynos TMU driver.

The series starts with clock lifecycle and interrupt handling cleanups,
followed by improvements to triminfo clock handling and correction of
the Exynos5420 efuse trimming range.

The later patches simplify the TMU register mapping and refactor the
SoC-specific configuration into static variant data selected through
the device tree match table. Thermal zone operations are also moved
into the variant data, allowing the thermal zone registration to use
the SoC-specific configuration directly.

v8: Refactor SoC-specific configuration to new exynos_tmu_soc_config
    structure which help clean up the callbacks.
    dropped the IRQ clean up patches, with new approach 
    it will be much eaasy for new SoC to be integrated
    and the code will be much better way managed in the future.
v7: Integrated my RFC patch which improves the IRQ framework
    for all the SoC link below.
v6: Add new patch to use devm_clk_get_enabled
    and Fix few typo in subject as suggested by Daniel.
v5: Drop the guard mutex patch
v4: Tried to address Lukasz review comments.

I dont have any Arm64 device the test and verify
Tested on 32 bit Arch Odroid U3 amd XU4 SoC boards.

Please share the feedback on this.

[8] https://lore.kernel.org/all/20260214181930.238981-1-linux.amoon@gmail.com/
[7] https://lore.kernel.org/all/20250813131007.343402-1-linux.amoon@gmail.com/
[6] https://lore.kernel.org/all/20250616163831.8138-1-linux.amoon@gmail.com/
[5] https://lore.kernel.org/all/20250430123306.15072-1-linux.amoon@gmail.com/
[4] https://lore.kernel.org/all/20250410063754.5483-2-linux.amoon@gmail.com/
[3] https://lore.kernel.org/all/20250310143450.8276-2-linux.amoon@gmail.com/
[2] https://lore.kernel.org/all/20250216195850.5352-2-linux.amoon@gmail.com/
[1] https://lore.kernel.org/all/20220515064126.1424-1-linux.amoon@gmail.com/
[0] https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#m77e57120d230d57f34c29e1422d7fc5f5587ac30

Thanks
-Anand

Anand Moon (9):
  thermal/drivers/exynos: Optimize clock lifecycle with devm helpers
  thermal/drivers/exynos: Drop invalid IRQF_SHARED flag from TMU
    interrupts
  thermal/drivers/exynos: Handle optional triminfo clock correctly
  thermal/drivers/exynos: Fixed the efuse min max value for exynos5420
  thermal/drivers/exynos: Remove redundant base_second register resource
  thermal/drivers/exynos: Use SoC-specific variant data to TMU
    configuration
  thermal/drivers/exynos: Move thermal zone ops to variant data
  thermal/drivers/exynos: Add missing drvdata assignment in Exynos TMU
    probe
  thermal/drivers/exynos: Select thermal emulation support

 drivers/thermal/samsung/Kconfig      |   1 +
 drivers/thermal/samsung/exynos_tmu.c | 640 +++++++++++++++------------
 2 files changed, 348 insertions(+), 293 deletions(-)


base-commit: 2f0c1cf72f4682178506f513bbf015e591b1aa4a
-- 
2.55.0

