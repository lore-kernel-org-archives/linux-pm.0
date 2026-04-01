Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622932F757
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023995; cv=none; b=cKgrJt72k+fmm+vSiuArO2dV6P3Fyn3VRB18ZLjywGYnZ3ZCatPB6HYjjpIagXLkx+eFOqQMYIKevHsv/Y33Vyrpta6a7uvLaBw9GvPq6GP5J1NBn0H9VBQFkMvWDSayCev531oFvoFpOGKgx+10SGoUIQZWzIRaSbRZl95WCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023995; c=relaxed/simple;
	bh=+mtVwOk8GmzDZi3j2wXyyRjxdLOOnqQCSFU6Nq4Po5w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=EYwJpcAjXIrFjyCdUolQA0b+H3EF6P1LZ1tqLrKVyyf6Q1HnDHdzMkM9SLmNx/bGmtK/f9gLjxU+ZKo2r9KOqWfBKqjgQFevP8upfnV76jcxvLQOAB8hM02ywbbVmq4+n9gLX15DdG30GhIV5W2ONsfQgy7whfHrc/uMl6PEYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net; spf=pass smtp.mailfrom=orb.net; dkim=pass (2048-bit key) header.d=orb-net.20230601.gappssmtp.com header.i=@orb-net.20230601.gappssmtp.com header.b=KfCNgp0e; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orb-net.20230601.gappssmtp.com header.i=@orb-net.20230601.gappssmtp.com header.b="KfCNgp0e"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35c124d2613so4142972a91.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orb-net.20230601.gappssmtp.com; s=20230601; t=1775023993; x=1775628793; darn=vger.kernel.org;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CFgZCEJ3fTGr4brRBt0JrAIRG/l0e3vOUBoKlYt/xZE=;
        b=KfCNgp0eN0m1dd1dfFGntlM4uUKdUHRPbwqry1XGmdTMIMYzHDYTe36PEwb4oLlgOa
         pYXX5mqsiFZgVsl6S6th2faxGgTi7cluWdk4kReRLRZhRnWO2EEPpKf7+G5aSQtXD3/a
         oehlUT3fkL6soNLF9S37w/svpztml3VDV/D2Pj15ykpIuqxO3kyQMjuNqZA1ilDGqjwK
         /D/LG3FUn3iMZCqW8Vz+EEmayNfNKEFWKyxmvobPmokWZapH/Sfx0IY+hfevoN8rgil4
         LJOsIvEuUs6ZRAt6IAyoOgBZNa7n1xJZ5oufwpE4ukjMCHpn2GOpyLEvEPYmIis6gwPH
         Bn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023993; x=1775628793;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CFgZCEJ3fTGr4brRBt0JrAIRG/l0e3vOUBoKlYt/xZE=;
        b=GJgNQVJJ+ENdzbw6G2R+oPjOfl+lEl+LYCpKO2iVReBP9vrVFkjNivPg5j31Z6j34l
         ui56jJe3c8fZY0NwNar21vEcMIMpa+pbq855YE4bLeEmpqF9LG5/0lfo143biDpWef6l
         n/SwAeuy1YD2zIcs2LAo5OOLCaJGTbsRo7hHtENwWpAk+m0EwT9eAjdfLdEa5dbhnzEY
         poBUDM6UHR57Kp5WnhEkn+qvUH3y8+DDIFQ2+rFJsuFglHpT6o4S3xfVYXyebUuXHqDT
         O2cyyIaAh01zk0BfBDhz/ZH+5rzXIHDkWbb/hFxnQK6SznlMUdiBIZf5sbpdqqqIilt9
         R+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOOgaBQOEBVQgtpEMDL7omIU6AETKwMFZeKldTGuI+YREvN9/elZJ+ZMPYm2uPu+NU89LUwsveVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxUvuMFQMbQTrtJMBjElGG8QcaAgRDr6Epk74pYU8DM1aJhXp
	zHT4vDy+SfNfeiC6q5JkZpvWE9u5Pj+q9G+QJgqsU0zrsk0XBVixj1CjyACcrh0Jc40=
X-Gm-Gg: ATEYQzxiZXhIstqtEnnjJsShIiJBsrxS2Z2jeebiHXlBlxkV21e/pgMmKFQyjrs4FWV
	3O/vdQj0JX6QH2ZSQkLd7EWvw1JByqgdBBLTmgEpgQw5giCJyBzb1jFrnQX4aA+i9WUmgxXn77g
	VdWBsbdgme9x/j0HmQhqLJGJ6klC1Uv2eP4laruEHOwndV5WAr7x3V04Pr/+55Opxf/0Chkgbim
	abSLBlDCdIXGypOadiwuUZLzpXFFgXilbwPEumL2N6L7ht75DPk+mPai9gM3963IhZXWNh5tPTX
	yeG6tBiEjA++EpP2U0hZChoHefkIj/jRUXI5jjmYr1rA2gnzeY15sOivYR+uBBxkW1sXxQwj6ir
	T4IsNkhVVe9XNbquL6tVx9NjD7w3oj23TQOMkYUvwHQZSt40MqKh6Gw/yU2fJntaH6ECUEX305E
	UQ9K9K9jQQ6psH8FubQM5j16HAnLw0b6zTmPUzwIRhCk3YMHNpDMIh1osu0KA3zLq8wGZjyHxX
X-Received: by 2002:a17:90a:d406:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-35dc6f62026mr1887773a91.25.1775023993473;
        Tue, 31 Mar 2026 23:13:13 -0700 (PDT)
Received: from claude-dev ([50.125.94.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbb840a36sm1802998a91.4.2026.03.31.23.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:13:13 -0700 (PDT)
Date: Wed, 1 Apr 2026 06:13:12 +0000
From: Daniel Bozeman <daniel@orb.net>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, heiko@sntech.de,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
Message-ID: <acy3eP0dZBx6A950@claude-dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc6f00fa-10b0-44c8-d8b4-694f8ff3b9ea@rock-chips.com>
References: <20260331180223.1682283-1-daniel@orb.net>
 <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
 <CAG+Ngm+xJCCQMPddZx8AbPEeH3rUrn3GKF575zXpGPJrnELvMw@mail.gmail.com>

<fc6f00fa-10b0-44c8-d8b4-694f8ff3b9ea@rock-chips.com>

I ran additional tests to gather evidence:

Test 1: Patch 2 only (skip EPROBE_DEFER), no patch 1.
Result: kernel panic. The idle-only domains register
successfully, but genpd_power_off_work_fn attempts to power
them off and crashes in rockchip_pmu_set_idle_request:

  Internal error: synchronous external abort: 0000000096000010
  CPU: 0 PID: 59 Comm: kworker/0:3
  Workqueue: pm genpd_power_off_work_fn
  pc : regmap_mmio_read32le+0x8/0x20
  Call trace:
   regmap_mmio_read32le+0x8/0x20
   _regmap_bus_reg_read+0x6c/0xac
   _regmap_read+0x60/0xd8
   regmap_read+0x4c/0x7c
   rockchip_pmu_set_idle_request.isra.0+0x94/0x1b4
   rockchip_pd_power+0x378/0x604
   rockchip_pd_power_off+0x14/0x34
   genpd_power_off.isra.0+0x1f0/0x2f0
   genpd_power_off_work_fn+0x34/0x54

Test 2: No kernel patches, PD_GPU disabled via
status = "disabled" in DTS to avoid EPROBE_DEFER entirely.
Result: same kernel panic. The idle-only domains register
but crash identically when genpd tries to power them off.
Same call trace as above.

So the crash is not caused by probe ordering or
EPROBE_DEFER -- it happens whenever idle-only domains
(pwr_mask == 0) are registered and genpd attempts to
power them off. The QoS register access in
rockchip_pmu_set_idle_request faults on these domains.

Regarding S2R: you raise a valid concern about skipping
QoS save/restore. However, these idle-only domains cannot
actually be powered off (pwr_mask == 0), so
rockchip_do_pmu_set_power_domain already returns early for
them. The QoS save/idle/restore cycle in rockchip_pd_power
has no effect on these domains since the power state never
changes -- the save and restore are paired around a no-op.
Skipping the entire sequence for pwr_mask == 0 should be
safe for S2R as well.

Both patches are needed:
- Patch 1: prevents the QoS crash on idle-only domains
- Patch 2: prevents probe teardown from making things worse

Tested on NanoPi Zero2 (RK3528) with all four scenarios:
both patches (boots), patch 2 only (panic), DTS workaround
(panic), both patches + E20C regression test (no issues).

The board DTS that triggers this (GPIO-controlled USB VBUS
regulator on GPIO4/PD_RKVENC) can be seen at:
https://github.com/dboze/openwrt/blob/add-nanopi-zero2-clean/target/linux/rockchip/patches-6.12/102-arm64-dts-rockchip-Add-FriendlyElec-NanoPi-Zero2.patch
