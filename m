Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28403368A9
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336959; cv=none; b=ZZdK3n1nYYTeLM519lKQN8g1JD/pyirEzwBB9EsT+T2rl3kxRzZ/Ccq/Mr6OF9tS8YHmIdXI0lGxk3j4hQDExnMtQ6okvD9KfNoB0UXlBbAomA9CQ6/aU+k0lNX460uVWFfm3B1Cgpqe/kHw32w08p5pTbfRF5Zjx5epI/7F8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336959; c=relaxed/simple;
	bh=Q4YqXzmI+9oOgBh2DPw5n0DcgX3aRz5kn5SKwSjH6p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=FrxM2JDoMKhXx6gR4QpXLXwnx5DT4A4+v0qcKnWXpXISL65/GW07RqMaoCG+8bxTJbElq7Z7vRNUmtb2NgUsqJc/nixIx/JceAM4oYu9s82CmfY5sUzKvFa0IEaGbEq/DMuvXcYhyXKNPafNNybZK666LzIAEL+Lz3cz4Cy9s7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgEjoFgA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgEjoFgA"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e706a6ba9so128440785a.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 18:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336958; x=1791941758; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4YqXzmI+9oOgBh2DPw5n0DcgX3aRz5kn5SKwSjH6p0=;
        b=cgEjoFgA5kDVdN8GkgKVWnvwk5Yrok9MBVJphnYa1UGqemfFBzJVVrFeTlEjosXg3E
         PdtZGH37k8p3giDuhKO6O2KyzEGxGCYGqA7QzYDNd3LfUIp2CbbpV2EpDTBpRevG6/Jb
         1+90yBuhOn90xI9iRRWxA6hWSxjlFYyDa/hUiji2gt6M548aF3IZP6fXyO08OOgy0/sD
         xcevFsCEzO+5jhPGYZUKHqrB4VfxpHII23iJIMshvZSjUYennRr0dorH919QXHcRZ3VN
         pRGwDe/G3eGXnKcvP2e+Z9OwT173aJK7Lvj9DYNA/yw1TPm/i2nz2mdaWJHP3BRM0+IW
         hA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336958; x=1791941758;
        h=content-type:content-transfer-encoding:mime-version:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4YqXzmI+9oOgBh2DPw5n0DcgX3aRz5kn5SKwSjH6p0=;
        b=2xH5t7yUFzHqOZVo3w8lJQlcO2hlazAV18eImGQ7Vb3a6Coqwf4t09H0VK7cL+8QmL
         tS4GzvzBjcZgxU7bmVXR6M62uLOYShs8fWoFSFaXN5y205lIuGSlSr7UGLzpaiqeI21z
         2Kmb1j58WXrPYF2M2aIC1lTCF33p5FWqyJ5D8wYr3tuXjleNCqS2e+cMdaG6tpcLyuzz
         77PnS8fYczHG7Zvje7Op0GCwnnWJ8hXHHqo8XLvq/mmoya/X/ClpyN8/ynvCpHO0NX9J
         THiPaQrIgNPg+aGS8Bj86WKY91iVWQ5qEveFnrdv89F7hxfNnCkMs63Dl7QdXaY3IdFH
         vcTw==
X-Forwarded-Encrypted: i=1; AKwUvBzEFFUAJeqop+Ve4ySZCNFm7w6/9hOq3itpU5E1vPaETOcm4UgvRLWRH95qFa4N9rVeua8Ohlklsg==@vger.kernel.org
X-Gm-Message-State: AFuF++mXydL6czmUpXFQVnuhr+62BpnrGeHvE/8t4SBzO0+yykK488eu
	NXspJrhD1PugTi74iEn+Ru/4+vLk+XJJv1tcSorUcUewGbG9XCADeNH4gjYdFQ==
X-Gm-Gg: AYBFou09jmCbwjG5m7AYa+jCKkdqVvuKUMeerjzUPYDncxyQtG1UsWg2YqYHRrPguqI
	cYMeFJNr9Mwvol8HOxRBBixZ2BEpr5ckHXrrgOO9AeWmNhg00GsPLw/U/VjiXW3hepaHT+5TyTS
	E4/GOSYs9RhKrVjFE+VtpP9qX+ooVl9NV/f58Nu9mzyhFsA4O+Xfyhm3mS0HN1le9dxyG9DF4KD
	yH+PNCqOCbdI/OiNL/ZYyWXkfbKzEeH8mWwcGGAMjaqtNjXlb3aI8JvAm/M7NmEyTugiAC2r0iE
	EmaBQb4kzSfj90wREgFiQR2OR+xC3h8u68IthynBfhuYri30awAzCJ69SWZ8srF42LD64ejX8OR
	QqBx8Fyy8/F4b4G01b5pN6meqB826vJnXfzbyr1QEhRpHghbwYNn8OJZRWSinvwdP4s38amTvpU
	GsW8kWSYipa8trqM0WrY3dQ25chES6DX1Lnopn/M+bY0em2flZvb5ZVifCtl3sUpeuhsAJuj9gr
	G4THBol48D9zLuClQklY4S3iA==
X-Received: by 2002:a05:620a:a18a:10b0:93e:9807:9790 with SMTP id af79cd13be357-93e9b8581c6mr104499085a.81.1791336957720;
        Tue, 06 Oct 2026 18:35:57 -0700 (PDT)
Received: from daniel-desktop3.localnet ([204.48.77.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e98f6f8desm101574785a.3.2026.10.06.18.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:35:57 -0700 (PDT)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: rafael@kernel.org, linux-rtc@vger.kernel.org
Cc: alexandre.belloni@bootlin.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bart@gpxbv.nl
Subject: Re: [PATCH v1 2/7] ACPI: TAD: Support RTC without wakeup
Date: Tue, 06 Oct 2026 21:35:55 -0400
Message-ID: <5383347.31r3eYUQgx@daniel-desktop3>
In-Reply-To: <1959268.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Someone's previous patch hid some sysfs attrs when without ACPI_TAD_AC_WAKE
support. Should you add something similar?

Link: https://github.com/linux-surface/linux-surface/blob/bf1921fc63f33d03a007fb38c4f88ff7e7bc1a55/patches/6.19/0015-rtc.patch


