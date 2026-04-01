Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CF364949
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011971; cv=none; b=sSSyTOYOlm7FyMA/qdlmZAzG1E4HzPI8Y7OV7ibPpGzvvuT/CRuwQSHsxZgDjM3AK7U/CRvTyxn5h9XkkdGlW9JsNiakzYHaPQO4nvMN0RxxHiDKBguhihODgLIq8MamMDLyOefCKj/xkIMs/e98D+XCKmKc+0dpM3uDpsfV11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011971; c=relaxed/simple;
	bh=vKesLwcwWY6NcoP+fdXjgJXgpybwD+nmbppg/Nc8390=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jwGtL89Z7j620uzWalaR1+6kIgvhe6A1t29183/F+ryNptODLtSGnj3XOSj51UQLbbIUnBRgWg0yT+C6ESYKdtAARKFxvy1HdzHcXsj9ggWa6dMI5xRHj3u3jQKnrKiiEGd96lsYG4U84VcODyL1nCpQZW1LIIUbE9KdYmny0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net; spf=pass smtp.mailfrom=orb.net; dkim=pass (2048-bit key) header.d=orb-net.20230601.gappssmtp.com header.i=@orb-net.20230601.gappssmtp.com header.b=uUPj5g4Z; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orb-net.20230601.gappssmtp.com header.i=@orb-net.20230601.gappssmtp.com header.b="uUPj5g4Z"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so772605b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orb-net.20230601.gappssmtp.com; s=20230601; t=1775011963; x=1775616763; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20Mz45WcJH9ziI7hDt00QqO2FOFl1B6yMCjToNQfBoc=;
        b=uUPj5g4Z6UuwZFBTcWwQ29MxwmsGvB0dinXpteP2bOwrdLV2fR5KXgmJsqoimbHCtI
         DbnN9MkNAAxEBFULe02/ZuCM6bOtpKDfdUsgNnRqWd/taHlb48pyeg2abtRxyNcwIqei
         1ysBFuSUODycbQAFbCxgd8fSSrS7R4hYsHmYWsFayhJzO5ki7p8Ctyz9e03kZtQG/GJL
         iPwcGiBX3HZBDt7IGUpZI1N6YVe0YvTM7d447GYPkbK1SgeI3PIDidqTv9lKxe4p68P/
         BHBG+D1nuHx/+pMQgigFQPa9TuS0T8Q/7BcaI+XjTX+svzlGDYL8Rx+FFPtb2KkSM9qG
         F1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775011963; x=1775616763;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20Mz45WcJH9ziI7hDt00QqO2FOFl1B6yMCjToNQfBoc=;
        b=bGQ3HRpXERsYv65kupD9ggr78vxiURp2nmwj3StIcssRLIi+c1g7kun7N5UzFVNKid
         UNGG+rMoUxenAFxgy0gfpqjmogl9XKj7DpY+iukCWEAbt89B+KCSxuZu6keTNgEmIe6V
         cDTr7tPZUSLnWLjjisdXMuo0TJu2DGDa3+ijYvcKpn2p4Z8ofLMzVrdvQjvjPSb+V7jS
         S1k66Fe8F4DdR+gAQ4ci9vM4OLK4Vha69o2krqXvDcbAXxvEguM2xVcxHlAPMJK28CYy
         t/UOM0d6/s1O9wDjkBHRg2DroOLN3l2pBx9H9csqmJl2WtKvRxLgmxid89wRCuuyZ0W6
         jW5w==
X-Forwarded-Encrypted: i=1; AJvYcCWQvfAZ8FRNPt1G5ssbbOBsCDmnpp/wxuTdoQzpbVnEv0tkjaytR3cFKXyF2u+r5TeMIthJ10DYTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/nPgfu+aEGTFRHgfj6KQ6OExzMQYtGdNUuIl9hHtWb0SY0k2a
	JDek0ZKRW841ShaYCMDC1aygYNZb8XxS6eRzKHTkDudpCC/2gLKagy4pMJqd/fuUxEA=
X-Gm-Gg: ATEYQzxnoJfTqL11UOoRKRpnDrVhdDgTU7ReQXuI9b161WMrYlg5Oz9Ud6gAlXENDb6
	2Xti7VQh7/B6YZNlgm6eNQLYRi8MJ61VO/PEMOcRcNXgFIl1q/XdYqdKTp0tlDa5lodkpBuna+h
	NoDtwwiGjx8ZyU1CULUL88AGG6McoBWJcONF6awNSor0VDqh0+pm1F3GWc6uzm6JCfWDQLXxctJ
	6LjvUsTmoXcWjkAr7nfo52rIqwoskyusNHoIUdUVQDIzlrBa88+Bm28YU8k1YNCZ73G3xlrBFJe
	qYaCG75z92FW+WXpeOGOHTzX4qc9wei16Sj84wNJukiic3In78REEU+DqyeqVg+KmCaX2gtsl5M
	DGNyDi1eiGrr34/+3pAb+FRbV9cIIlas5m1WSt3re1azNl75izqNPinRW/J+Hvdh+OjG/JrASBG
	NzIC13xMDzRBVM8PRVVCCEc63GQNmnkFW3onj4wCkao5vXB8gt/1gx2VPag7/Os4SH/jJUrL69
X-Received: by 2002:a05:6a00:2e94:b0:827:441a:c970 with SMTP id d2e1a72fcca58-82ce88ea395mr2028303b3a.6.1775011963217;
        Tue, 31 Mar 2026 19:52:43 -0700 (PDT)
Received: from claude-dev ([50.125.94.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca846e08dsm11917878b3a.24.2026.03.31.19.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 19:52:42 -0700 (PDT)
Date: Wed, 1 Apr 2026 02:52:42 +0000
From: Daniel Bozeman <daniel@orb.net>
To: ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
Message-ID: <acyIejuwoFau_i7i@claude-dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The NanoPi Zero2 (RK3528) kernel panics during boot when a
GPIO-controlled USB VBUS regulator is defined on GPIO4 (which
is in PD_RKVENC). The goal of this series is to make USB host
power work on boards that use GPIO4 for regulator control.

The root cause is a probe ordering issue. On RK3528, the power
domain controller's first probe attempt fails because PD_GPU's
clock lookup returns -EPROBE_DEFER (CRU hasn't probed yet).
The driver then tears down all domains, including PD_RKVENC
which would have registered successfully (it has no clock
requirements). During this window, the USB regulator driver
probes and requests GPIO4, which is in the now-unregistered
PD_RKVENC -- this triggers a synchronous external abort.

With patch 2 alone (skipping deferred domains), the idle-only
domains register successfully. But the genpd framework then
attempts to power them off via genpd_power_off_work_fn. This
calls rockchip_pd_power(), which does QoS save and idle
requests on domains with pwr_mask == 0 that cannot actually
be powered off.

To your question about why QoS registers become inaccessible
on idle-only domains: I have not root-caused that specifically.
What I can confirm is the crash trace below, which occurs when
patch 2 is applied without patch 1. The abort happens during
rockchip_pmu_set_idle_request on an idle-only domain:

  Internal error: synchronous external abort: 0000000096000010
  CPU: 2 PID: 60 Comm: kworker/2:3
  Workqueue: pm genpd_power_off_work_fn
  pc : regmap_mmio_read32le+0x8/0x20
  lr : regmap_mmio_read+0x44/0x70
  Call trace:
   regmap_mmio_read32le+0x8/0x20
   _regmap_bus_reg_read+0x6c/0xac
   _regmap_read+0x60/0xd8
   regmap_read+0x4c/0x7c
   rockchip_pmu_set_idle_request.isra.0+0x94/0x1b4
   rockchip_pd_power+0x37c/0x608
   rockchip_pd_power_off+0x14/0x38
   genpd_power_off.isra.0+0x1f0/0x2f0
   genpd_power_off_work_fn+0x34/0x54

The two patches work together: patch 1 prevents QoS access
on idle-only domains, and patch 2 prevents the full probe
teardown when a single domain defers.

Tested on NanoPi Zero2 (fixes panic) and Radxa E20C (no
regression).
