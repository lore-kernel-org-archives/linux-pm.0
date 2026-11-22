Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795335081;
	b=idookkF/QZoQzy7VshMwmSRcM57j6QqwXoQCVE7s+MFjCE0X9MFK67R3HERAtMB9E4SH
	 r7s1fu+UrnTrQva39a7Z55K84t2D+zaKMKcikFowW2frgT0qwpwUuumAv/zt/9TLi+Bkr
	 pvUj379eu1SUnclU/mp1vOIBt9dInEnfUzKm4OZBICGdGZfMnjqBWNyXNfiKOQdgp8vwL
	 r6SyH76xOGvJ31JMGPuJ+iWX8fSQVsGq3CQRSP2j0I9lwt0mKMHfv9x5m2HkvU1SHd5Um
	 h1cC7jqN0L2YTeFhAvVGqtdHPHFZEZL2Z8+fZgLKASkjIgB933X4e4/o6iRKNWOJKKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795335081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7LQKFHuvOFPNMCnvLDkMXQ86A6lGIMolZPD7spZrCmg=;
	b=soR3JtgQ0ErPv0Ou+MLBl6QbCGVcVn5uOHstOJRLpL6p8K0YPqt7llmZ51V/s+XS2CBP
	 mmjwE8exc3Pnwj8XPA+4SwevdLUNe8LCBNPbuHm3syjjBDAYTpiT38Np6k5DfitPSPMKV
	 bMwF/D849WuBWH7UNiSxeR3RkgAsCs38kVhBIuTxTPom+ysO1YknALVHjzRnUMK0RaT8t
	 JlfPnLiu7OSRQ207YStudhxyYpS0aGPYy5IjLJayWrZ+NuRd6X506JYmsUslqXUeIV22T
	 TU4BVvTXgPEdLH8U7bUu+brpAjHyQo4ULUIMMw7bJBgRb7MRFGHhjc7Y4lUqLTF5iUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oZwX/836";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D52606A32A
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 08:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04D52606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZwX/836
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c513a854320so390972066b.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 00:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795335079; x=1795939879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7LQKFHuvOFPNMCnvLDkMXQ86A6lGIMolZPD7spZrCmg=;
        b=oZwX/836jpKkwmXyKQm2gtxEgzcHo1dgYkrA7jXR4jQMF1yPkum9RA6/9zUBSIAHF2
         qjaqvs5IcEc2p6grA9XhGOZgy6dHftV8EtcD/Ai8huCe1qJ/sacbhgBedTw0l/jvxOJu
         FB8r8Yzj64R96CvD+pKxfp8l1+luLjUp8SIw/WVIekUhOZLY+SjJxR6XSWue/+4Qdlcd
         gDNxqp8qTmuPWeyqD8+bkms9gaqO8/94Tzl8/t0XU7s8fZtLhtty7SIYCRBllnRzQWBv
         KpfoopyukdLmMj4rs8+ZAHCCvjyPXpsHh4AfRXQdeBpHU7sBRq6P/vzU44mCr8B4ye5v
         wMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795335079; x=1795939879;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LQKFHuvOFPNMCnvLDkMXQ86A6lGIMolZPD7spZrCmg=;
        b=KJYHn7vuWSaz2+EYDjRHLWm/VBVxIZq1ub6DBodif9YOR090X2nbzdSG2lR/kTCSos
         D4jYRZZrMOLN3ydzpFlE6x9Ekbyl/ArMoCH5HcR5z2aWXSfnLgQUsTO6BBtovTtBesNx
         ijDqaD7Jsh+WHtY7wxbVF7GvhZLGOO5/VBgVbGXKBZ+svnWTgqXCaYaMMCfD8aMZLQsi
         2Bo6QBKp3V25GqqrGDyBwc5XhpL7795EoiOza3OuNvSzINH86bfkrX9YrSz006OSYAMc
         xhPJmjkaeS1mSzqth4y29INHqNs5qbPDEPkxYOdw/99AvqQGvG2NMj2x3VMgkYGOGgv+
         xGGw==
X-Forwarded-Encrypted: i=1; AL+hErFs9YTHak3M2I4mMDQVGhUNuTcJ9H4rpSDUt8LivRn0x6VdJGJhKg5rzr+RPqzGqJNiNWlLU1AQpg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9nUSMa1x3UF9xtJdcjv0edzPs/MVjg/O7SFLsvMwNXrQByH7bo
	HSLjGWHOxnX7O6bM7WhsHXrvtnrZuo6z8h/ARaUrP3C1qBduO7bSp7IQ
X-Gm-Gg: AZFdTZfw+UAFycKpM99EyeH6SKtgZ5AE2MxTvrYTbOVX1srzF2D1aZ1Ae1gdXxkJfm/
	MbO3QfrjTBGkoEDmRgSoSOetiXUD6Z2hvixsLDQpWU1cO/+NduR/bB5Tu1YEhFUKKNstmxtwcTF
	afNWQEQudYwvO+2STR/AcDbyEKrDPPdFL6PeLh/+vCUL6kCbYKX/JslKHFk5tq5J280enOII1Uv
	UBEWcLWo9zUh3atc4uoJvsIlKhIWxvaoZgx8UcuhlTp5c1/4KlqUhYe9abpFnjntFtg0NF2aVD6
	zAQw/w1pEep5m8zHjz0t8EXZ1X3ZjIW+C7Wauyk16LADThhij21WEGqtl6wSDTMrSN/vWtjXgx1
	e+Y/mjjxkMHE7II6o2clV2VMHJHEw0XFlrppNQHaaO2d8ikdKryvQy7S0l3ES5yMYfQc0H8eUPf
	ePTWXju4u2WxZopJNv33Hr9YOVTwHUeL75I7yg06NfmvpdGmUqk9pXYL2Iwz5v4XsiCcryoufKw
	2uoxfIYyj6+tetUpFZdM1S18i90F7F1W5IHBXOqBCDOYm9d8ckAKMXuxPR8vvQp93RVEFuILtWK
	fYXYauwB4RF2lYHqNX2SJ4eGTg==
X-Received: by 2002:a17:906:4fc7:b0:c40:9839:c892 with SMTP id a640c23a62f3a-c513a88a001mr676115566b.19.1795335079208;
        Sun, 22 Nov 2026 00:11:19 -0800 (PST)
Received: from dl360p ([195.155.168.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae679e3sm286835966b.22.2026.11.22.00.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 00:11:17 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mateusz Majewski <m.majewski2@samsung.com>,
	Thomas Turner <tturner@lineageos.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] thermal: samsung: acpm-tmu: Add Exynos850 support
Date: Sun, 22 Nov 2026 11:11:14 +0300
Message-ID: <20261122081114.2979414-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
References: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Alexey,

On Wed, Nov 18, 2026 at 01:51:44PM +0000, Alexey Klimov wrote:
> Tested with:
>
> tmu_top: thermal-sensor@100a0000 {
> 	compatible = "samsung,exynos850-tmu-top";
> 	reg = <0x10070000 0x800>;

Nit: the unit address doesn't match reg, it should be
thermal-sensor@10070000.

I ran v2 on a retail Samsung Galaxy XCover5 (SM-G525F, Exynos850, stock
Samsung bootloader and ACPM firmware), as a data point next to the
E850-96. Base: v7.4-rc3 plus out-of-tree board support, Tudor's acpm-tmu
fixes as queued in thermal/linux-next, then this series. Christian's
threshold-7 fix doesn't apply on top of those fixes yet, so it isn't
included; it only touches the GS101 path anyway. DT node as above, with
the unit address fixed, and three interrupt-only zones (polling-delay = 0,
an active trip at 50C with 2C hysteresis, critical at 110C).

What works:

- The TMU is accessible from the AP on this production device, so the
  direct MMIO approach isn't blocked by the secure world there. The
  bootloader leaves the block configured: two-point calibration
  (CALIB_SEL=1; 25C/85C codes 288/346, 288/346, 287/346, 287/345 for
  probes 0-3), CONTROL=0x9503, CONTROL1=0x00030000, AVG_CONTROL=0x00010016,
  COUNTER_VALUE0/1=0x28a, TRIM0=0. exynos850_tmu_init() computes the same
  values.

- ACPM read_temp for groups 0/1/2 tracks the raw CURRENT_TEMP codes of
  probes 1/2/3 within 1-2C.

- Threshold interrupts work. The GPU zone got a rising update at 50C and
  a falling one at 45C. After the CPU zones crossed 50C, their registers
  were re-armed correctly (rise ~110C, fall ~47C, INTEN = RISE1|FALL1).
  An 8-core load up to 83C caused no spurious updates.

Two issues:

1) THERM_TRIP_EN is cleared in exynos850_tmu_init() and never set again.
   CONTROL went from 0x9503 to 0x8503 after probe. The bootloader leaves
   level 7 programmed at code 0x177 (about 115C) with the hardware trip
   enabled, so after probe the hardware thermal trip is off. Samsung's
   downstream driver for this SoC (exynos3830 in exynos_tmu_v2.c) sets
   TRIP_EN together with CORE_EN when it enables the core. Should the
   driver keep it, or set it again in tz_control()?

2) Runtime PM gates the TMU pclk (gout_busif_tmu_pclk) 100ms after each
   access, but the ACPM firmware on E850 reads the TMU through that clock
   too. An ACPM TMU read_temp sent while the pclk is gated hangs the SoC
   until it resets, with nothing in the log. I hit this through an
   out-of-tree ACPM consumer that calls read_temp without going through
   acpm-tmu's runtime PM, so this series on its own does not trigger it:
   acpm_tmu_get_temp() resumes the device before the IPC. It reproduced
   both times with the clock gated, and the same read always works with
   the device held active (power/control = on).

   It does mean the clock is shared with the firmware, and gating it is
   only safe if ACPM never touches the TMU on its own while the AP has it
   gated. I can't rule that out from here: the bootloader leaves RISE7
   enabled on probe 0. The downstream driver never gates this clock.
   Would it be safer to keep it enabled while the device is bound on E850?

Minor:

- NUM_PROBE is set from priv->num_sensors (3 thermal zones). That happens
  to match what the bootloader programs (3, covering probes 0-3; probe 3
  keeps updating), but they are different quantities. Downstream reads
  NUM_PROBE back from CONTROL1 instead.

- About sashiko's temp_error2 point: all four probes on this unit have
  non-zero 85C trims, so that fallback isn't exercised here.

I'm happy to retest the next version on this phone.

Thanks,
Adil
