Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0831361DB1
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775251640; cv=none; b=qszKuhgcFKhGmGo6n9qUn7JWxWIT4WJAc76y10NrdmEtGExOLtxgJcHu0+Gn7ZGxT5bqDqKKfELUfWYPXGK5d6jYzlGEWzZ10iiLHhSmjuHhO4Q9KED0iDUMN2SKIs29dyWA6aeLHiZr7s1KLM7Xyd+YR0CIF9gKYC6ptDDT790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775251640; c=relaxed/simple;
	bh=N6DT8c+jxwVXwgkqmAfoksHh58THNMA+fwpfIw3KYKI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=JTBiicpTPlwZqMUqPLCdA77di/EF/plYjCAeaiBxDAoUXh6oM9KPlfkEJDy8mqomOoBMwoG1ruj65TjXFzoIsl77tP/I63uS4pJ4teya0kPTgguc0naoXGk23RumLT5zKKwPgQmVl7oDeNCKt0HP66ZEu/AZmNPAzjOB6BEP9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net; spf=pass smtp.mailfrom=orb.net; dkim=pass (2048-bit key) header.d=orb-net.20251104.gappssmtp.com header.i=@orb-net.20251104.gappssmtp.com header.b=jGUgQDII; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orb-net.20251104.gappssmtp.com header.i=@orb-net.20251104.gappssmtp.com header.b="jGUgQDII"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso1149152b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orb-net.20251104.gappssmtp.com; s=20251104; t=1775251639; x=1775856439; darn=vger.kernel.org;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeRTLOcy5yBXD+HuJ39TxkiskXMTMotEnO2l9/4Dmvs=;
        b=jGUgQDIIHaBVd8Yq3FIe4h7SMAEnNotq2Dfw0compdHJnUlf524gKYx6FT59E582yj
         jEEta6vOXi+nXHqFSXOF7hf+9Em9719PJwvzDyJhVtbgI11RbuyJn+GlLOtFRt1yxlrd
         qYNTluR9ABvouubRRTnsL4xOxDYJ+jdOQfBNKEQp/hCd737SXLH3kHzKQPO6qkRpL8W3
         uXe1aqheeYufj1S+FnVjBLIVwXzL9kdk2NLEN3LWaZYFP4eognLKUwYmPFCuZiAmhlbM
         9UlNon/GJkl3BaznmRNesUwOexGVOxR50WcOjn205gzvBjPpTXLkxP856V2tLSnLK0ia
         W8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775251639; x=1775856439;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JeRTLOcy5yBXD+HuJ39TxkiskXMTMotEnO2l9/4Dmvs=;
        b=BXUeHP88m910VDpD/UePfOTQpzhNss8yqtFjlGqZyea/CHJ68b989bOakEVfFOMGCS
         M7dSaS3cefvY7mvvRZmP56HkxCMFujiZu2w4HE50/BAwteT4hQHfGaYb2yNp07LIhKLp
         pyhxELopUaa4B8ezhfL5YrI/+pMxwZRNcKTgkFUOh+R45v3x/Zg+O0FoZNyT4G3+1zWE
         ES1wBFNdI+iOrl//Ep3E01CNMw2q18+xO36CFS5wJTIMPrr12Oq8+4y4Pm1tzSLIEGo0
         pBt9yaKeieV8i6RgyOeQpj3DhQYtQWOw0ufBcBVgiOEjylLCnhfIQjgPQ9QHN9+ZTq5E
         xfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoZLS+lYczTzcPaJhud0ZA7kP5YHEF26nYo0NPwpSvdmc0okdtje8Ee5sG17kPyrvVfizfN+juyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFVovgaIz9wZ94QpKTfwBMUPuFCWgIwK5hv8Enm+xFNvwoNZ+
	RqYIsObi1uAe/Y5xjN3R/sorsoq1W40aOotYQZX56V9PQOyrVat/vdhPPne0odQWmQA=
X-Gm-Gg: AeBDietcJRD0CwZbGaLnFKOqTYDvcReh461Vma/F+wgUoWmbkoPQq/EIgB5qAhSWzRj
	v90pAuipzhrkuePjMBt0RFWnHyOtKFUP3KWW6tpgErkYJwu3jsMRjwJ7Jwl8f/pcRT6tLgZBu5X
	C2ULgqO/n2arSmiWsv5fdiKUpJG5LZkJiC5joUuSVWWMEpjNJpvl8pXtK9EyYmM8KgWoArbEnoA
	tWvLDkxlXkWRi8xu3pqcegoJGszud8v+6hkEelWOKEL/GoRhjJVh67njpKMteIYHhdJBG0BDino
	1qI4Bwtt/58mpmPZwg8lASmElqBFLH6WPwZfr+H/+SwRgRkp9v9dU8WP/F/4+E/vuucNsHJ+yMU
	SIyZYP2tczooSufeSkrucH0AQ8IXBLtvtt6dnd/knAL3ZnzEqAqY8x3OhctxnNTTlYZqAO9esiT
	DHlZORsGzH9UOYFeC5huC25TPzQhxm5T68Zvqx8TzPux5IQ1wWsRJbu5eXA9FDipFG9TeLNIVX
X-Received: by 2002:a05:6a00:a257:b0:823:1444:7873 with SMTP id d2e1a72fcca58-82d003b2753mr7863216b3a.32.1775251638984;
        Fri, 03 Apr 2026 14:27:18 -0700 (PDT)
Received: from claude-dev ([50.125.94.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3dcb3sm6643153b3a.16.2026.04.03.14.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:27:18 -0700 (PDT)
Date: Fri, 3 Apr 2026 21:27:18 +0000
From: Daniel Bozeman <daniel@orb.net>
To: shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
	ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
Message-ID: <adAwtiaU-32qjRRE@claude-dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf16b5a-1565-39c9-0d92-33a7a577212f@rock-chips.com>
References: <20260331180223.1682283-1-daniel@orb.net>
 <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
 <fbf16b5a-1565-39c9-0d92-33a7a577212f@rock-chips.com>

I ran both tests you requested:

Test 1: Added pr_err to rockchip_pd_power_on/off to identify
the crashing domain. With patch 2 only (skip EPROBE_DEFER),
the crash occurs on PD_VO:

  rockchip_pd_power_off: vo pwr_mask=0x0
  Internal error: synchronous external abort: 0000000096000010
  Workqueue: pm genpd_power_off_work_fn
  Call trace:
   regmap_mmio_read32le+0x8/0x20
   _regmap_bus_reg_read+0x6c/0xac
   _regmap_read+0x60/0xd8
   regmap_read+0x4c/0x7c
   rockchip_pmu_set_idle_request.isra.0+0x98/0x16c
   rockchip_pd_power+0x130/0x48c
   rockchip_pd_power_off+0x38/0x48
   genpd_power_off.isra.0+0x1f0/0x2f0
   genpd_power_off_work_fn+0x34/0x54

Test 2: Same debug build, booted with clk_ignore_unused
added to kernel cmdline via U-Boot. Same crash, same domain:

  rockchip_pd_power_off: vo pwr_mask=0x0
  Internal error: synchronous external abort: 0000000096000010
  (identical call trace)

The crash occurs even with clk_ignore_unused. The QoS
registers for PD_VO are inaccessible when genpd attempts
to power off this idle-only domain.
