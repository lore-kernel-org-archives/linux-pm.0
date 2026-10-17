Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F62F1FF4
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792242501; cv=none; b=dPS/PF2K3344wgmg0yXdThKCzjeP9PPVa+4VE10eQNZ2qSgrIfgQ6wqSZRguiKCymwOnXzO8n6FJ8AH+wxwC5Ow3X5FQOv6/YHoRTNBsJ4DqkngE2Y0Ap9cOKU5PaL0SJbdO+SNh9NQn6jWBqYREIl6H+m+1L9V4tIGTXoOTkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792242501; c=relaxed/simple;
	bh=Z/5JBeqwPxSZ0TpSsf5O+k1fvGG7B04vtfTOruv2JxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyE52d9aOGw02y8IN/efvm6xiKHyOIw8p1KGQykyaD4wf+IhmMPq60pJ/93JcD5XCk25fLL89C0R/kXJ0wUetz+a6v8sChiolYmpAjp+ZthpPFijDWu5yT8wuAoTvywfvSt4T6CF/v0oleheYmDr8J3Vjr5g/38uPJIFRjOCqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXl2HU6b; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXl2HU6b"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15943c9be84so48368c88.3
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792242498; x=1792847298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/5JBeqwPxSZ0TpSsf5O+k1fvGG7B04vtfTOruv2JxA=;
        b=VXl2HU6bjknN1IMUfwiSPFCo4VVowwrSEmRotFX6qrdkgbsozOl3Sgewo2O/cYYsXg
         Pkc55EjKirp/4gxCfW7/bybcVFjy/TgoKYkAKf1yvgMlb2Ir8ikM85CcQInSJwJ52Ckw
         gHWUDuLm8EdyOQTVT6oM2XaqeKWqBK3Eusu+kBT0D9jWULFuVqhAvjf4AMFJCVjm3cJz
         9O6oO9PfUW8EK9WwFnQZHdvfq68nOFTWlL0Xx3ZRGePCm2uKpj/QEiu7qAn5mZvLV89A
         VqZ7tpokdg3y4NHKeIXL5h7ZQ+YTV6kBu4k6EAtGzUYxAFjXZxmERJea60rAaaKFh1LN
         WGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792242498; x=1792847298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/5JBeqwPxSZ0TpSsf5O+k1fvGG7B04vtfTOruv2JxA=;
        b=VhCndl6Xquu8s5lHfZnBX8xoWcQ1yM2Ds8+Jc+OIQTE5uuIkQL/DjXl2v4JZLR4gyH
         wW1oIDE99N3rrmaJ+8kahgtNnMT2qCcyh4pno1t52V2mC3UOy04Ktl55J+ImlWVMbZIC
         +n0P0QAsUNUz+Yy1WcDLv7YDQUpCa9YFu3w+ZTU1hNnjeRLHwX+fGKwJMUUdrrRmUr5F
         lWUM3SC5KOeo1OefWFGtDnc/Slfx7Gc5YIFOt7yM97PyvjxPp884c3jWewcsQmFx/MqK
         2TX7Wq2j72UWOSmn2jREZbqSh2Rk/4N54xefBFVzpyynRT6b2mOh6lTSHrVtgKLAHvrD
         tqYA==
X-Forwarded-Encrypted: i=1; AKwUvBxI6i3wMkguaRUyZ07qNJk8QRh9Ei7pRzH6L7ThNlxRMaH2nREFwer8qNiZmoGJCnU1wWzkbWaEQA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6lzGy6Rws0L32UTZLQAimikGkOYunqbFyvqoSV8kor4LpCleK
	R9JTiXK3ihWNHemSCxC2oU+fmqOdHX8c03w0oEu5gXonIUrQt8mxEE8P
X-Gm-Gg: AYBFou2HlgtZg+vTPyWlQ8jgWV65e6MYiwYz0irjM59+oHQM8qSD3VrOk1RGeDZTkT/
	E7nVZr/pglbaIpHCr8kSbwHEzNBU1vq5SEI4riE4Tm1RAJoMC67z6M4Bq9+NDm5I+6RbeNBGbuR
	EqtfN600hlwiCo5f4L2LjkUZH1kcwKs6AkspEYXgAyHXzC2bLlJKwE/KErHRggYs29nwYUkG21w
	YLKUouDRvVSaJIY0lQqjvycmPPr8wBpJitw9lx6QlSJq0aVZ+qkQWtXXdZNadFzE6v2ZdHOOGxK
	/8XdZCytrmlQ/wQR5i7PSkAaTttpKyNSx7DmAzEGhY85BZXU0ZMuOn8Lgak/adWpZh3Kx8E7Nd5
	TzBDn4s1a5ZxeMJg1JnwFgX+szOEE2JeaP39aVhGmd8gXGFc4MDd5fe1mB5J7W1V2bsiKRRcCSv
	9iCLGt1AVpUXC+vBtx7/quakuStWJ0JeR/iILpO3PYRFvzITUGca1qJoniz4I6FNyKfd/nfkW6m
	E/4ASgFBmRvlpi6l/b1H6M8jAzK021FhHNe8QuiTvEd2PQHORIRD/pSZ5dv1S0ULJaE4iBXK9Pz
	xgRinvmxve0js9lZtQ==
X-Received: by 2002:a05:7023:a5c:10b0:183:d275:cf76 with SMTP id a92af1059eb24-18511adbd46mr5910454c88.2.1792242497725;
        Sat, 17 Oct 2026 06:08:17 -0700 (PDT)
Received: from cachyos-aura ([45.112.151.53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm18903260c88.16.2026.10.17.06.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:08:17 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	=?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Sat, 17 Oct 2026 18:38:06 +0530
Message-ID: <20261017130806.305673-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016214123.GA1884818@bhelgaas>
References: <20261016214123.GA1884818@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 04:41:23PM -0500, Bjorn Helgaas wrote:
> pci_pm_freeze() doesn't call pci_save_state() itself, so I guess it's
> the combination of pci_pm_freeze() and pci_pm_freeze_noirq(), where if
> not runtime-suspended, pci_pm_freeze() clears dev->state_saved so
> pci_pm_freeze_noirq() will call pci_save_state()?

Yes, that's what I meant.

Thanks,
Navon
