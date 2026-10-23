Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771460;
	b=aq0nh7k2XW3Up3uwifk4iGKTvbyQzmYxZbPX/2UtQ2fwAWItyW9RV0q6YwRfYTpyx/Tq
	 rARvoXerbPwxtyqjTk0AeGxlFZMxUb3EHvEhN7oJlhtXcHjh3eb6rSShr7JhrGVtr1bKm
	 89KTPZ5Sea/X8FWyg+f0Ft3046t79XzCK6mkxvP1KITYq+DtC2OfUPAH+UsXzsdTdTywO
	 LTCMYRc9c3sH8ABFPAK0NZvHpGsp3FKyOsCGRe5hVQsRBTz2I9LNSQH4O+1gDXvsXBrkp
	 uCzpCTVbwFyZI99/7Il7y74QqBNqXuJuh2r2qAoAwYrXynxIyBJ6+ztslxnDum0AqUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=EcU6RfKr4ZzY1Q/TbJYZK1jW/7NnBQPjgUilPcVqQc8=;
	b=KmdfFpnqnYRSedJXpplBK+DEgU9aZOqH89b2dCulUgqxDsuBWL+4rZIvGZ8XUQf9OALX
	 bvGWISvNIrslyT6wdmIkQ1kLWyn43FsFgUE5TwRbAVkEcv4A+E+lVG09dr48a97wIf0Ln
	 Nd3tTgStZgz516eXI7eLOz0gvDqSQaMUvqEjqnO0nVN1eDvskw8wXxzd3DfDQdQX5N3X+
	 fY7AmE+A2DP2u4Ui4A+FmNvT0oNSSoB25C4S2ihmmXJJwo3pe0ypWBzfVs9odW5K2X/ug
	 ws6BlZDNLPKzVsrb8NBI8u8hKxS2lECo9CuRPuhPxkQlKY1cTVkgUiFH96f9AvwmKfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F7eRWv8L;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54A606A31B
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 16:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C54A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F7eRWv8L
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a264b6a06bso485747b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771460; x=1793376260; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EcU6RfKr4ZzY1Q/TbJYZK1jW/7NnBQPjgUilPcVqQc8=;
        b=F7eRWv8LDdWj1TmIyy6wRG7ZEbN3aBGk/y+JCwl3JEZH7XAH1SrDdldqBgtqPo+iW7
         lQDCRWi63YCNnKtIgefVtWO0rB6dq6VBTrAJEbZ8YBrdo8kgBlYda6dEigJPamdFKB7d
         4DgaIeX6cK/nbWY2aGRxYqmFV6EJxTLRWaKBoRtxPpRax9BY4G8Q5wtwJbI4qDAt6Wii
         rrAQ+H2E8RsIPHWhDwVp+673WIyz1Z2PmZY0DXO1ki8JQtTK0VlUV0fMaJLX4kcVZCVe
         80jCl39Kli1qLij9fOzHlZVlZsvv7lyqTVQG5RiM2JinzFBA6KLT7+mlT3BPcf0YxbjQ
         GzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771460; x=1793376260;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EcU6RfKr4ZzY1Q/TbJYZK1jW/7NnBQPjgUilPcVqQc8=;
        b=PL77zkPUtPb9iZxJ9BlVqfKDYKakrh8+s7NGGrbdBP3jdw8uBK96+phsIxO7Kx5w1T
         G8YbxAN58oOAahqOynGUSR4ooyQEB+IE+vhNx5XPIDcTTdOzqMbP/TdaibA2L6qlP/vy
         5DzWowCqVFK6HB681FKnzayBNtx3UxcaS8Xv93c/hSnEwKZB38NAHJNGN7WOdrsmIYeY
         fR/pd+t5g8q9ZHrnWOrxtZULVtabJFt++qhdZghIma+BxR0ZO7dY/zkEVNqM/9OTCQpL
         DezOdRp2pGX6BPbWLxid96MVTGyllUNkIfxFC4G7LywCa6G84WkEbakYfExdAaeaTt0K
         hCkA==
X-Forwarded-Encrypted: i=1; AKwUvBwrhHciEUh2SJmKE6eRlJyt66Ai0Elqy+kLRVgVWsKTP4AMUM5lY+L0D8or9Rh1AZ5NH39OVHQN2Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIn8uXtSkHS6y57lN6LTpTgbz9nLFoS5ObobFHKa310slveYQex
	BSskN/nlidi32eqIi2tms62gN1DkwTlvJE69kEAEpZKfnqOfp4vUdTqofBVnTg==
X-Gm-Gg: AYBFou0p7p9X1++tdCziBrvGds//I/CmiFCCQbuM562DLoby7Aqe9iF5wbunqLsaHo5
	6DXIk1cH3tdj8ef+LtEaNOmjsSqsBxqX30wlAkDSTUmMwZPC5buI7u3vUFsUQkAk+A1qVIK84S+
	Zf7W/UeUDVDxWPfYM1EbpxnKrpre3Fs6flij06V0TlIbrRqDGprlArex5FbFZZiZZoEGxP8MirW
	mSG+z+3mz2Rx0A1t8H28MVubxdUcyklXPd97V8eSW5HVu6QiWrcI/0W9+6oVfOziR9HH8aeZRqx
	Jq4u5lUIz8yzqr44mtGutYl1C7xb5+OAtoegbCOQ29GkMHT1Yu6Wtz11mdxaho+0u3olGRM02fC
	j1fX3/6fAAMALzTw3UwCYPSLaObqqkram9w1Y8ih6WtfcqIEFKAs7Z9zRVEcj5gxgkdjroINsfc
	/9YkR6cZCdoX9HaGogzRFN7xdRtWC55VfynBwRQf2EqaCBLxHHYCaRKg1lwd6KaCdpdvqP5P5PA
	si6JSc8u6DkVQtPmTbSUBTL/R/C3VOLxera6dwpOTwlYDyAmrDS+W0g1klPVanLFmMteWWkWhWE
	Ces1rA6xfHdnngS0itO7ujdm2RyWXaLWWKgjCsT9EdcT61R2kjToF+vY9PyLzA==
X-Received: by 2002:a05:6300:618d:b0:3cc:45cc:c401 with SMTP id adf61e73a8af0-3e36923d731mr2426629637.13.1792771459736;
        Fri, 23 Oct 2026 09:04:19 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cb00a17fsm18537a12.18.2026.10.23.09.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 09:04:19 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 16:04:18 +0000
Message-Id: <DMCCFYFSY28Z.2BL8TJ1R2QZ1F@gmail.com>
Cc: <zhoujinghao24b@gmail.com>, <rafael@kernel.org>,
 <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH] cpufreq: ext: serialize BPF registration with
 governor teardown
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hungyu Lin" <dennylin0707@gmail.com>, <zouyipeng@huawei.com>
In-Reply-To: <20261023083131.58291-1-dennylin0707@gmail.com>
References: <20240927101342.3240263-2-zouyipeng@huawei.com> <20261023083131.58291-1-dennylin0707@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Fri, Oct 23, 2026 at 01:31 AM Hungyu Lin <dennylin0707@gmail.com> wrote:
> The 2025 fix addresses a separate policy-state lookup error. This
> teardown bug is present in the original, unmerged RFC as well.

Your bot is going nuts.
drivers/cpufreq/cpufreq_ext.c doesn't exist.
Stop sending slop. This is how you get blocked.

pw-bot: cr
