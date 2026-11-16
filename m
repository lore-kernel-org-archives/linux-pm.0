Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821246;
	b=TAFte5ZsLws0KYSrhAXK/wl1NaRhOiceoPkvDiT1qXbOZziNTS+Tz21+Gygzlxd9Z1e1
	 zbIosAyBV1Iwf6rdQZPKdF9oWAhljz2c5D9UXl0FzuoMx7VBPnbi3uNikLb0BLhY3D89P
	 IwOIVcygdCe6AmJPD588WLICQI+KoFUSx3MYz5LYc7IqtjJlmRn2xCHc5SCLsScsQGZV+
	 l13wXcb/sIXzQieDJxqHJ2MMSHxeCfqZxy39zyrjvmon1Ux7Lv8hra24xxbFZ3V9IUGLR
	 o0/Ws5WUYzEKAEDYEiP2dbm79GlL0ZUz2oIIgoBZD2jJhrgGZJRgKhr5Mh3mSzQ8juQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3RDL1fZo8aXNiQEk++kgWnQkoCZHciDwpPC04gZ5fIE=;
	b=og/q2JFqUXOIuWvJswTpxI13jh7RylEEMLMLdXTsjCUeBvfzNl369AJVknA42ibGDbEg
	 OR4gOCj1TVIzfjvnZHkE2zus2PQlOytfq6PYWXbuQ2qBrSSCHhZIwgL5KmqNXvioK6UG9
	 IMjJQ5Yo/Y/dpGAQZ5EBasEPkzFGRMUB6rWDKLx9i1uAzH8igGiGG4Zbf0jkRnfNBgvO8
	 ZCkoYkLEze15LUc8mO5i65mu9XPkQCNyQlDghxsSvQmTNcfI08/gZkBVlBKMeFWFFwD2O
	 HtDe0j5LVJ9b/mFf/IjHgBQZeVcvI0sN1+m29C98fEIza6roumtWebenveWPsk7FhQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q2dfIiJa;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D3606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 09:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 772D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q2dfIiJa
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso1057034a12.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 01:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794821246; x=1795426046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3RDL1fZo8aXNiQEk++kgWnQkoCZHciDwpPC04gZ5fIE=;
        b=q2dfIiJavJvuJooQljuRg9haFaPJ1+O/ROT3r9C/a93bNbvscqMVmY/d4OuCtGI50l
         Hce3rxIVETCP6IIBSJg67wxo0cQtrl6393XwBd/+NV0buV2/b4sn+3f8yx51KWoxJLdr
         vDDcdwTym9GtVCkoEyEELud3XbzJeRjUokDooN3mU87STne+uPHyZUrdk9TyrqT8htoB
         GwenKRNs4ymlbKqytmzwZNqE2FK1VC9iLrL5XuFLT5fUXIncpQnxtIEJ0AKQZWOlOfdk
         nI1ZHwe/3gEfhL78NFfRRvN/Xul2Hsibxi1z3c7eqMx4mWlZe/ZHyAQwusT8w7gyOOqu
         JTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794821246; x=1795426046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3RDL1fZo8aXNiQEk++kgWnQkoCZHciDwpPC04gZ5fIE=;
        b=n1zMCRaOIjTy2etPN4d8QjoCZTx3rzOEhPJkyqXoVHtNtnZCUOA4rfc5U7EwjjKLAe
         sYqyjRnlDCqdGQaBTL6k7+kY8eG9aUfpVaXGBhbc6IYC94QmMpwG9Z83dcR/HKxgaMFC
         WS4qDrGWKhWsOpj1USMr9mbIOdpPOCrZtosaNbQ1bi+uDPYgacSmssL8V1fzqwFNmF8x
         13laFVII9Re8tuCoYeZuGJk8ZmCs9wrLpX5r6/c0YeWjQmykrxuGrp/sHgquuQM8xAyV
         oFojnLbIUEJqYn4RF3yiy0KkStERbtGrXP11OK5YecCX5ZTV+xf6iFYVSNEd1tD4uBqT
         8c9Q==
X-Forwarded-Encrypted: i=1; AL+hErELZ26iIZGfxXhIMWKoeLHABqbD4vfSrHFkcSQWpHdgHnamoaBEtdF9CzM/APr69fk9pVIGWJ9ENA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ls3Fni5XJQMq1kfgU4g8fXc2YsRdlCdGxzGWGxMjtNGGC0ejb
	MLiM/xB0qVW+LOwQejRbr6yXDpIrsMqlQlSuKT5mKUBcje98OwIRZIxi
X-Gm-Gg: AZFdTZdm0INjrklQVNbf7P6go0VT5y9EW6Y+hqoREb7xhkTToirFZytrApMUYi7tX0T
	vXxjxCqavHgdf3+8STPWHjuySBc5de0zTyEAxC7FXSWvSjRicIsCeulkIML4QV0VD5/VECsMWkh
	Yq9jg6cNP1V9txvUex6Qs3bre+tYGNXaRxQerfT9sf70R16+FsYcfbiAdn9gCtadJIo5rwWvHkf
	bTvr5f7R0TW6Nm1UaUO4x6OPPk4GFFifV6rqIV9iCx11GvelO5IQF31NI5XpGmX/pUU5fLj0rjP
	sSnj6/XLYjBypyeUncp03nVkfFUb3OvFWj+oNTegmBvHz6IIlNgXiPT9w8yVUWr4a5kwzSsSoGc
	4RhxjcPlN3/UNjCESmaC9JlMckQpBRuO5+/RURjGeO+JEvJdgArBdxSM1UrxObk156teD6zh2do
	Qt3wXRStKy2KliioGPOFOshCOlHwG7/j6+HG95fOmYxrGCH8870hA3OM2AugxjT+r7iLkJCRm6k
	b5U0IHEEZC9/P8IYEzb1JAmLoClu02kdb+hHsMYL5U3Sgf7HiPnthulEuOOe6lQEN5yIUSz7njS
	yUXquhHqIULuRYUyKtHSB+GlOVrkjAD+g19FXCd1L81VFg==
X-Received: by 2002:a17:90b:5910:b0:3b0:aaed:48d0 with SMTP id 98e67ed59e1d1-3b1b0b4d0d0mr8836956a91.37.1794821245843;
        Mon, 16 Nov 2026 01:27:25 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb18b73sm15680884a91.3.2026.11.16.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:27:25 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: rafael@kernel.org,
	thnkslprpt@gmail.com
Cc: viresh.kumar@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	zhongqiu.han@oss.qualcomm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v2] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is inactive
Date: Mon, 16 Nov 2026 17:27:20 +0800
Message-ID: <20261116092720.2552651-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0g-oDagp2GrZyhLmT-BYJqcm-D4s1eTrXCxB-fj5BNixw@mail.gmail.com>
References: <CAJZ5v0g-oDagp2GrZyhLmT-BYJqcm-D4s1eTrXCxB-fj5BNixw@mail.gmail.com>
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

Hi Rafael,

On Fri, Nov 13, 2026 at 07:21:00PM +0100, Rafael J. Wysocki wrote:
> I'd love to see some feedback on this from the people on the CC.

idle_calls only advances in nohz mode; with nohz=off it stays at 0 on
all CPUs, so the hold never releases.

Reviewed-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Thanks,
Zhan Xusheng
