Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AC2D73B5
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775342548; cv=none; b=AQE75DJFtWMTEYzLmwnfXHCSy3v/xAiMbI2J51fYBDwlVCNz2aF0u+p5fHeWEbxjFfpyUJpk/i1JiNbrRvfpuW3AP4lhmFmjUn3EMYBw9loykbKOkOtpxnf9Qv067TMFL4u1o3x041L+Mhd/rKjDrKyEFS5LqHpdA44D6Yijk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775342548; c=relaxed/simple;
	bh=GMnoEZ4y9vwRHFk6x08B2hN3K3bVPiixflP6pmS55GI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=RpuhComu69v9vOy0MxV1bwXGhiyL7VUs8xf/yCmN1jkL6YxCkBngGfu1WLU99iiSptm5xUrEPfziN5a5XTQWRl95Vg+jmb7ww3ywTCvmuFtgqg5ZWjSPUF80a3jPdUJNqJIpC2E1r4qrot7HLpuRA6iE3LSAlpFElthiXRJOgWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net; spf=pass smtp.mailfrom=orb.net; dkim=pass (2048-bit key) header.d=orb-net.20251104.gappssmtp.com header.i=@orb-net.20251104.gappssmtp.com header.b=m7fbiXKC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orb-net.20251104.gappssmtp.com header.i=@orb-net.20251104.gappssmtp.com header.b="m7fbiXKC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso1974462a91.2
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2026 15:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orb-net.20251104.gappssmtp.com; s=20251104; t=1775342546; x=1775947346; darn=vger.kernel.org;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZcFkwtelNvbHrpmOVful4dZyoIYvTSSe4AGBuE0+FU=;
        b=m7fbiXKC2v9AbuZg+n8VLOjoA9EeW/EG+kDErsGo9trVPCc32/4DO/J9lH0dOZXwI2
         Ts1uU+b1mDOPeOm7hmHp+G6wfEIAS692ZU35wEawfAFxtBsHIZ/W5fR6VqDONuyToil3
         M3CO3wFTMeNnfhm6Vb7L591ufgBmscKiBbSw7J3G128Wvfd0lPFxoZipD/TQGto1rbHc
         RI2cq6w5vIyFmUv67UKowTFiEIK2GqxVuoLMPTXm0t8RWCCcerUsK4Zb+8/V/jRn+bVm
         xSjc3unPC1IrGkf74CIRfT/Is8HbA2+m5TEsLDvOZN667gcIcC7yTT8foe6XRGweqyfQ
         3Ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775342547; x=1775947347;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ZcFkwtelNvbHrpmOVful4dZyoIYvTSSe4AGBuE0+FU=;
        b=fWm0XO+dJcrmgxm+ff2ijzyFgRodx8/Nte4xLZy/lPMm7YjXfx4jTmMVj1pP8dtW1I
         VufkzUfF8YiA/Uv7pGrypShyV8KHWY6td8vXqt7TQC/wAmPj5MXU+nUgMJ23HO9RiFvM
         jiWLBQ7prFihFdtkFwsRiHDCKMAlCTpQHcD5zBOUiL8PBMatdvNSBZ7Tnu7O/ESl+sfR
         cysGdL8Ez4itRalaZo1+VSh1dWmHFNO2VaaTzOT6tUYdcnL99/yQ6MEEfJgrQNyVTBM5
         wYdqfYbnPMeW1OB9wgz8M3tJGnGQo0TIw9Qw74jNy81rUazKkhHNkA9Xy/vqVZ0ivgs4
         EhTw==
X-Forwarded-Encrypted: i=1; AJvYcCXMF1NvqW1iQNu9dSVQh9cHDDxH/l+V243/wUeqo6erRR9ZVg4g0tB8jdZbI/N1Fny7W55kdE3gEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRD47/9DRplPL0NEHsVgZA3VqLHfoYMWMmk38w5Gs9n8h94gb
	/JH+iSThpSm/CTE4fwo+HPXEg/3J9RKq69hSyTk7tETo8CfOHCmE/4ErnefNj6Zjg24=
X-Gm-Gg: AeBDies58VSL/xLZdCZil8VYT20etyYpv4mcAJN4mzLW14JWQeEINSr06xY59XnosHU
	ijxILlaLGAsJyIf6e6F4+dK7OyIhEmwHSd7OTivXPHsS9u5ZcMYIQ6IwzUpDD6McAYRglQDfiwz
	5wFOaxBvRRfRod7HKjjEwHfFv91WuLHsUFyOpvoKpXIqvuYUp6bY8EqtLAOTS7OsNWJqCd6fcCu
	UVOQQGenaBX5MweMIrtYAotsATYVxzbPWeD7gYucWF6KcEsR1OyWB1mxAAEYfyiCUZKWuo1D4uR
	9ynWmL1rRwtswyjhGg8P1vTmVAxGWJ1aEtT2g+b97UcQrbzckBcmgIsTZGMJs1sW71z7gsE0dAc
	vXCkRgzzY9ALrY+QFo5tBYQsBu0iSB15ihPuaT7KwG0tWpyxIjZhGdVhbyvKImCZ1kjQFwccG1h
	78ZW3/A9TYySD0i4hdKbTE/kqlBDD+O83hSQKUSxkHMHyPQCr1oJVJHBslV0Pw0VdX/SCkZvtl
X-Received: by 2002:a17:90b:2d10:b0:35d:a9bb:1e33 with SMTP id 98e67ed59e1d1-35de685ecf3mr7280003a91.11.1775342546534;
        Sat, 04 Apr 2026 15:42:26 -0700 (PDT)
Received: from claude-dev ([50.125.94.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd367c142sm9424108a91.11.2026.04.04.15.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 15:42:26 -0700 (PDT)
Date: Sat, 4 Apr 2026 22:42:25 +0000
From: Daniel Bozeman <daniel@orb.net>
To: shawn.lin@rock-chips.com, finley.xiao@rock-chips.com, jonas@kwiboo.se,
	ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
Message-ID: <adGT0TZb1BASubCL@claude-dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b9a97a-f1f9-0757-5dc7-33960318be61@rock-chips.com>
References: <20260331180223.1682283-1-daniel@orb.net>
 <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
 <fbf16b5a-1565-39c9-0d92-33a7a577212f@rock-chips.com>
 <f1b9a97a-f1f9-0757-5dc7-33960318be61@rock-chips.com>

Further testing with NO kernel patches and fw_devlink=strict
reveals both crashes happening simultaneously on different
CPUs:

  CPU1 (genpd_power_off_work_fn):
  pc : regmap_mmio_read32le+0x8/0x20
  Workqueue: pm genpd_power_off_work_fn

  CPU2 (deferred_probe_work_func):
  pc : clk_gate_endisable+0xa8/0x130
  Workqueue: events_unbound deferred_probe_work_func

  Kernel panic - not syncing: Asynchronous SError Interrupt

This shows there are perhaps two independent issues:

1. genpd tries to power off idle-only domains and crashes
   in rockchip_pmu_set_idle_request (the regmap read at
   PMU offset 0x1120 faults)

2. GPIO4 probes while PD_RKVENC is not registered (power
   domain controller tore down due to PD_GPU EPROBE_DEFER)
   and crashes in clk_gate_endisable

Both crashes occur in the unpatched kernel. Previously we
only observed crash #2 because it appeared first in serial
output, but maybe they're racing on different CPUs?

I also tested removing all pm_qos from all idle-only
domains (PD_VO, PD_RKVENC, PD_VPU). Crash #1 still
occurs. Because it is in rockchip_pmu_set_idle_request,
not in QoS save/restore?

fw_devlink=strict does not prevent either crash.
