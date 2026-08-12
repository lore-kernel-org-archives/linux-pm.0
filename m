Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302DE43B6C4
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538950; cv=none; b=DA84JgB0p5zt5ncPgeaAvaOJl2lZEyGAiydONtXlUqJKO4BDabXqOyKJHR1PpF3lXZ2kQ4hto1mQ75t3Hpl3/0DzKMICH8HY+bhC7pmpduV/MqarwaTse8LpMTp3B36sbQX82uohix5aS7G6/IC3IRcuSKrP8euJU2DEaLBDVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538950; c=relaxed/simple;
	bh=R7P9GJg/MAi+yHuvn1qTceQ9Hb4OgtvyY2bPwHpj89w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Brz/g56+TQiGhvvg48Lmxch/qq0Z4tbBFwlKFZQjoB4mh09N2V6yxofDKJgMMrUVwqHuByt6hiNU0mNW2rGCweg5+D4ax+o0cYy1jAfmBDRfHgxsLy5MQFYNemGPC6k5K67WcyTJdsaRnk3pZJC0Up3xf9TqBGyeufdEdzDK69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIR1uC6r; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIR1uC6r"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956d1d9fb2so569055e9.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786538946; x=1787143746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1u30g0AMKY150GAPKUik0QfLk+MxUjv8vUartSunHuE=;
        b=fIR1uC6rmeM+mHENNXc/fnvnknL8mcOIZzIFmN6iCDXKBXERPj8qmmfSshs++i18SV
         io7Fk85wb3zQNQoN1/QXGnqwR4m3QkL6dOh6z9dsdSxFDM1A79pczZcyGIr7WI1kNPYJ
         tJ5T1n080IRo1d6enj7QljjpGmcZLX45O2NcpL+1md4zTfnI2MgpdkwHCTrKoKPYK8qq
         Sr6Xx7p08wzTSMHpo4/9Lj0lgKLQdSqgx5cwsVugjqpvNld945Ov3h44KHVkebTk4P59
         J3TQCMGe7Uz9yWk1UI9ChnLZEwkMyuDEFrFnnN2GuGpM6aVkeN6Ru9P+/AZIdzyzw5cS
         fbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786538946; x=1787143746;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1u30g0AMKY150GAPKUik0QfLk+MxUjv8vUartSunHuE=;
        b=S1FQOuFEOiVNWPm+g6CNjTbFdVQnsGfHBNArzvWApwcCYp/bVbSn3DxhYPXa8TuaDh
         CAS8TXMWZBo2cIqILUCuQXmCPVijlSsoRJM3hMEVmFCLLH+GKb6mXb6rYbVzHtIDTgSw
         e23XxKPU4HJRkTFw7KQr5g7n7aScFF6oDZtSIVKw8lHMdRpr/3jeXX6FV4Iuxu5HYDVm
         W0Njz/t77yKpj7YiBCcbl3MDV56OEslcaBhVnPnRSAxiOM/J/ofOEVs62q/0dU+9EsQB
         H00uFn2EABuUeqLiBGMiWKKXv9nJrkBT1/z5JrPFIB7nbTX7o4D2VAop54wtlyP0U2wI
         W52Q==
X-Forwarded-Encrypted: i=1; AHgh+RoP7bfnnUT0kwAgelFsbKUCJMm92djxZtBF5pCdB9z3HVzYmAJ8HJNxMuMpbfTiedTa/4KSXa8KdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxbh9+EmpVaCIO2hoQ7Y55WJY84RiX12k1M3rdFgOgfKOw17CD
	7GkdutHMLocNk1MD3VjoVW3aV9zILTj6G3v8EyAtzNYBKU50rA2b33xA
X-Gm-Gg: AR+sD12l8ZymZ6HsENA7xfcluLXibDPR+0s/mn2WS5WxNslQNOJB8HjpBo0d62VfdvE
	RA28b2w81wVDsvfnbCNnxN5fUnq8f/KSMGUzjN4spJsyUjd20LcQ7IkwTaU0vgPepGbJi+5ypLE
	iXChIj2zGT5cc5xrwfjZWnoOkLQ16hCgNjjeFGwHSXGuZSPYlHOsOuC9FD7Q7RfIYzKC67B7zVM
	qSHahyby6C3NsVHQQYj3WpZnriMyf/L9ODokK7NfmH3+rRCUHawqyQZuzhSf+vyU48kJMqAt+kH
	rYm6Qn0T2G+c6DAfkmRHbTQ9Qib8w8C5Hjd6KgDUBU1d0vsxxrUDoXIQJm3SDL/l8ZBElCRBjko
	GFd8wVRi+oVEX7/NXqpGuwF56/zvuB1BBy0OpadGP6OE574TxywE98VyPzlfrn0b9BLoUqKhWUR
	Xk0crhqCVNbi3gEPRBDYxXH1cXsBqYmCDIwakF76G8+JCtvs7IJcAusCqawZ8nkpgHavZZSEEqS
	W95lEeTaRNO8rUykjivuCwXPGN1cxAawPz0lx6F3Z6dcVZ+US4zUOJH8e+cB9pp0mpF
X-Received: by 2002:a05:600c:3b17:b0:495:71ff:598d with SMTP id 5b1f17b1804b1-4997c0ca479mr29063825e9.1.1786538946151;
        Wed, 12 Aug 2026 05:49:06 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B84A6001A34C2DD5D9E0419.dsl.pool.telekom.hu. [2001:4c4e:1b84:a600:1a34:c2dd:5d9e:419])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4e260sm7247226f8f.17.2026.08.12.05.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:49:05 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>,
	tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: Igor Paunovic <royalnet026@gmail.com>,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Wed, 12 Aug 2026 14:48:47 +0200
Message-ID: <20260812124850.6597-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812094106.1391698-9-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com> <20260812094106.1391698-9-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two things here, one of which I think has to be fixed before this
lands.

The first is a comment that outlived its subject. This patch adds the
following just above the PC_TASK_CON block:

  /*
   * RK3576 arms the same DPU completion as RK3588, but the interrupt
   * never reaches the GIC. The completion itself is visible in
   * INTERRUPT_RAW_STATUS, so sample that instead. The tick cap bounds
   * jobs that never raise it at all, which is the same open problem as
   * the wrong inference results.
   */

That is the v6 comment for the poll. It states the premise your cover
letter withdraws, it describes machinery this version deletes, and it
has no code under it - the next line opens the second comment block.
Left in, the driver would carry a claim that contradicts both the
commit introducing it and the register description two paragraphs
below it.

The second is placement rather than correctness. This patch also
factors the completion tail out of rocket_job_handle_irq() into
rocket_job_next_locked(). I read that as behaviour-neutral on RK3588 -
the return that used to leave handle_irq() now leaves the helper, and
scoped_guard drops the lock either way - and the numbers I posted on
1/10 bear it out. But it restructures the shared completion path in a
patch whose subject is adding RK3576, which puts a bisect in the wrong
place if it ever turns out not to be neutral. It would sit more
naturally in 1/10, which already touches that function, or in a patch
of its own.

Both of the things I raised on v6 are right in this version. The power
domain list is attached before anything that would have to be unwound,
and the comment saying why a plain return is correct there is a good
addition. clks[] grows in the same patch that adds the two names.

I also went looking for an ARRAY_SIZE(core->clks) or
ARRAY_SIZE(core->resets) left behind, since that would walk six entries
on a four-clock RK3588. All six are converted in 7/10, including the
two in rocket_drv.c's runtime PM callbacks, which are the easiest pair
to miss.

Igor
