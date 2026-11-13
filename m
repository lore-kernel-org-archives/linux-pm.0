Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602069;
	b=pJAQ1JB0ox7UrJK+k5sm3KQeydhkBy6SZRrykIaNtQwyzTnP69f0qgjK5tQgjZv9JzQl
	 SyvuJU+ylOuJfP/H4aLYdY4gEJGjrRKC/94EcvcsEdl5DVJXIIhtYa0LJl1PQXbSFBWvQ
	 BDYiXxu4M0rYLgNrcVEYAKBYz2NfSMaFMkEUssyJRUs4EWBP4nu+zSiD/wRkHW+BWSMLT
	 9A59iFskqkRykTSfj7QU20CmzH/OHbcD8iNwOmopbQrS8nDxS5pa7yhuWuH8GDPm8g7iY
	 cyKM60IxiZwVgwvNBaNIhR5b7Qp5j1OmwDLPjXOES1c7tKmpDemuZJtcJwpdbkoOZCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gEAEhBrLJ603lWBwjrR04mty+xeSSypartbn3lk9UKk=;
	b=z8pwwZQKwYKYrdgZaPcenGHmIkPizzKLd+22nGJKKEAGSm27j8n4EL6yjQBEeN4k91Jg
	 NF6zhmANMoPhs1Xd5iRCDXu9Xrf9OxrNwhUzvxWVV5fdOuRqIuamVK/ONel/IpXSTnOfd
	 fVd9bgw+uJFWpe8s+7RTdkvsf2TAUQpmQbwMd3ZR9odGU/atz2Pda2QYBYouz6VEhQ/nB
	 wChIdiOKQ9JqrU0QVcif5xLEflfHExw6fSJosPhgWvfx3AClrvCVvxk3b2trWP77qbwcr
	 CTG2T859hQUy7rDTdaIs2tuUJqryEpWuLtxoKli4wpPahdoBOk3TY/aAXoCKKMI1/EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DW8Zo59X;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFF606A327
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 20:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EDFF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DW8Zo59X
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b09cc7ed1aso220481a91.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 12:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794602069; x=1795206869; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gEAEhBrLJ603lWBwjrR04mty+xeSSypartbn3lk9UKk=;
        b=DW8Zo59X8T/60vX6Wek7BeGGM2whjE3KD2aFk7aeZlGjN9tguh1s9BJ87QgebqpCjJ
         lunbDjM34L42SYpPeIuuIUHZbGpGih3ngRrlEewe5ntepA1LyQLewSUHxlkwsiOGM3pO
         3Sh9MlkwKMF2JxiDlLRJuFv079leRpiJxgWBAQls74qktgjLcP90B4BzTd7fdSxQUsf+
         5FdBdKwd4xe7v0Mf2UqGhJicpjZrT2AzHXQFjG8rGd0+mtrndNKjATrCD3KfbzENGezU
         1YWGaKoHp5WdBFsBISOxJGaCFy/PWgAosyjX1E++54l9xtN5bWZV7iiXoFDOivQbcJEt
         5y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602069; x=1795206869;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gEAEhBrLJ603lWBwjrR04mty+xeSSypartbn3lk9UKk=;
        b=Y0C/qfmVI0mj4SEAxnc402wN1ycFtuXrHOgn7JnJbULbvKULiYbF09rr8YC/wwMYHi
         8YTWnkQ1rEiTziKXOrkE8nGxcpTbt80wvV6BwKVM+ehILaf1mOU5EdoviqAHSHliw38W
         aRV8jWAfkTaP3fxf6HD+HpihPKpHfoGLgrv2DrR0XrVoyDKU9CCpLqCNRLz1QhLIVysH
         74x4s25ZTgyGcmqeQd0lCQ5SVDmpCmC/hHB4SrTtA5qW+nus6xHvDHJ+iTmPlOnBWvtU
         4s91JnrrcKcKwyzFmvm4xr3eo8HwfV+fja5A6Gb3C3kWwQBTs8bA8cCkRPlHy1G2FeER
         Q10Q==
X-Gm-Message-State: APuU4Z+80ROq5ii7ibhfAPs/GfWK49SmaEvSuwPu3QMp/JojDNv9eJPT
	sKlDMaU0y4hT7jts67uAmBZX0UbpzUs/e4LPQEs9Er86AXWNvblg2CT+snTCS1Bpc0s=
X-Gm-Gg: AYBFou22jNlagxm4/8EWgH/ZuMqDRWdrDfhGXwhoKCezB4AaJBiotgLD7nzYPBY/5fr
	8UCdJChkaXH5xRYY1kejpp3qkh259U0izfzQOXd+PypaF5kMC2pr+v93Lzizor9n1porIQvYNWw
	ncamFUxeSLP4JPBXuerUPmIamWIsMvr2MYja+HrJAGVTTqiV/y1Wruy1GQDVmmC8jKmt7fiw+fa
	7D1E58aU+QfMVVHHB6lT/ejo0ZuQIO8ORBfqTAbFsjvBgPzf10lM19CfrI7fOGR3/hPiq2AVgmh
	wd4s4KyjxXtMUGY3W72A3qfBqCLo/lWyfyPGZKIxTLM9gFSrSwENLjMBRRprgb/K21vO0g3+aNw
	UDcdgO1L1e/8CLVh1Dfpw9UEYDkEOm2gy8reQ/Ogp/cPpm1+rZS3K49Ui4GfS4SaOSCueSuzw9g
	+4QWJygBp9JKzpOuV4gTe4sU1uhUKWLdxAI4QXAWjMrD2FECfDC95vBXlK3Hsb5Xs4VtQauy5D/
	BWymn0n5SvxY9Pa+ZlBJIsaTbQOYGNsg1gRE0n6og2dSWoaRBnccZG+Mx1aS8rkYdMBlrkQf4j/
	yQqEMQZ+21+xwnMYanonxgQCdlt3DCq56Ky1MTx7adkfwCpH0plEnRVrdmRra8EHZheJlkPNd2O
	xhMzWsg48wCjnIo5Hnw5UTPBINIw=
X-Received: by 2002:a17:90b:2e90:b0:3ac:77a2:18b1 with SMTP id 98e67ed59e1d1-3b1b0a44b0amr5406901a91.5.1794602068720;
        Fri, 13 Nov 2026 12:34:28 -0800 (PST)
Received: from claudebox.iyengar.cloud ([50.39.139.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae98151dsm5954809a91.2.2026.11.13.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:34:28 -0800 (PST)
From: Arun Iyengar <aiyengar1990@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Jonas Karlman <jonas@kwiboo.se>
Subject:
 Re: [PATCH] PM / devfreq: Do not change the frequency of a suspended device
In-Reply-To: <20261112-devfreq-suspend-sync-v1-1-af64603ef43e@gmail.com>
References: <20261112-devfreq-suspend-sync-v1-1-af64603ef43e@gmail.com>
Date: Fri, 13 Nov 2026 20:34:27 -0000
Message-ID: <179460206763.199714.13518791714665074913@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Please don't apply this version. The Sashiko review found bugs in it:

- A limit change on a suspended passive device stores 0 in
  pending_freq, so devfreq_resume_device() can then fail with -EINVAL.
- After a deferred update, resume asks the governor instead of
  restoring resume_freq, so a userspace governor without set_freq
  stays at the suspend OPP.
- Two error paths leave the device marked suspended or skip
  DEVFREQ_GOV_RESUME.
- The passive question in the cover: exynos-bus children need to
  follow their parent to its suspend OPP, also at shutdown.

v2 will fix these.

Arun
