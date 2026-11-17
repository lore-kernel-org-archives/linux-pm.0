Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912122;
	b=J58+6wtOWJqhuNpPZuDCX7m9qqjQLt/ZkumjPcdC/XfLTUXnNmyRM+lrVjs5SPhEu90z
	 kWFEU2gEMApYUbr5weVnzFUUxUBhQIepjLrQGSAUEnZlp62EpwNg0KFmVNSNb4WS80zpj
	 HRUehqUXBK1pXwti+es/B1brF/zQOxuB4zdWe+r0yIDvXEOXjknV4z3MUHhVc0kFMvqAP
	 i+3yLYMvGE/ouKI4uvctFW3qaaqoOeEPzEYuaGAi9J2a7fiJ2i1sYEcnRDpXxEMWpBmeJ
	 3Nw9iJRiwz9cVvsZvo/IzKLuskW8G0O6Q63E3wWpgVUarUoMViEe9J7JDGg5AXodl4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=PS1VfaJQo8AXeb/IwzWbByg/SH2tTkW/13Vhf/xaBJI=;
	b=No+fhwEtcfpM8VmxL03K1Tt7LgI2vdAoOSC5WAnLYHbvDGLscwUdhq9OiznhmrckOYEr
	 /LYAEGp/OO1XPtfwoIDw4EZHfG5k7/5aT+ANcWDQpI1VLX4pVt/PHEfQ2KnWln+TeXDX/
	 tCBrqLyI4uYAvI/UcYq0gXTUP19dPEz4INjV0rmgAUz4wVAQi40wlbqE193zZ831uV44P
	 QcqPtY3Nra9DbGg+SSTqMPYCL6gK13n98giS4JpIGruuL2HAbRtCY8kSj5rZ+dloh57eS
	 x3kQxxGYlMGPt3MYc9k8mcPJgRd1YsIMTqA5N0Gktq04HM2XUbYsJKeHh4mKRSj3jlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u4QkVIy4;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A39606A331
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 10:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17A39606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u4QkVIy4
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso20118085e9.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 02:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794912120; x=1795516920; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PS1VfaJQo8AXeb/IwzWbByg/SH2tTkW/13Vhf/xaBJI=;
        b=u4QkVIy49fTaoNwvWvnjGQQRpk+tfWR6LLp+CW+T4swmBdd25jXMn3tdWpXy5yiFUu
         vTuksHTy2xKLcetJrE5+cHPrQ7SxLWJnqPGTMN9w/ehtQfjowZWh/o0MvhKzh4Y/iS7O
         6xYBLvzjnMShr5zzhLCdjsDSrscSIQQCSH02l/PcaqAJEQXPgl756vs05i3C9DwYCY5W
         vczinvhPLm0CpccEU/4tRsoE1aQPqsbPf4TNZnjbs3G/vgRwXjcBxn0XjaCSs0vVERNJ
         Gjc6kx/xzNqQLGXCep/9XGA84H7NXodhlQVV8d+mvDUdClsdwdAHAKjCq1WFYMkSzDsv
         vHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794912120; x=1795516920;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PS1VfaJQo8AXeb/IwzWbByg/SH2tTkW/13Vhf/xaBJI=;
        b=UoXyfKuuddcth8OW+ONAMUbT8xYlb8NjKavX3c2oud2K/ABM5V7rKJQJxLtjfHFG77
         rEuDw4kHPoRUFuvPV8LmcyJJTA95X7d0IVHx5J9jG4RR3ri+J8FP00U1SGnNOOsC3S/A
         adF0+7vKkolrF/ooJz3H2xp7WfpYwYuI+xPOFuCygB0YEyNoD7DAq8CFQ7nCxrulI233
         R2RScMZ5ohSKTlzSw04u4iNgmXK4r8tZeQhJ8LSywCHFqdBmRwKgWZ4JuWd8Xtji5c4J
         g+Q2ZBDraawsNEVMHhR6+h0kt81wsumP2Dx/5fUVJP3h9BC8QXimaLkOoWhpFO32lz8O
         jhTg==
X-Forwarded-Encrypted: i=1; AL+hErGMJDgP23ER2V/XRbyqG6EhvUV8TS6DsE2S+CSSb/cZviefSTSe1GUdK4et5yTmMNIgCT1Ok3M24A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7V7enWX9/rbQzN1tUxfrtPsPhR1X9NkuDL6a79nPOlH5qyPR1
	6zvJVBfQUli1xNhB8CombI8Lzwn56L7neCALDjJoZYskVlNxqICnn63k
X-Gm-Gg: AYBFou0N0bP3LuHKedoWd9J9aRKwRX0yTIjTYLbv6MoeTNYn1ph30X/LwZjbwaE9Bre
	eSwaVQXuThl+JVZ8T4gJS7P5yPO5OYRwtJGtNEZf/jDryI0QxOkX3pIc2JeL9aQsoIBsYobKMoX
	4afOsEOz90birkG5g2mf2TDa23PXeX4oXMHkCNaJwb7EJZuLRinrqjd00rj4nxh3E1IEweNBf5u
	8+mrbrWdiQkQ8Wln+98z74dASgbBFotauLZfu6FV75SMFnB4vy7cKbDMLsMHjOBZDWOvvp70HK2
	6udkkuruhTEw9YtB1WcJfb7ApmEvzW0q9BkWQBzsqgiTFzTkxWNBT2P9p8QcgXL5y/MoqVEjHZO
	qMFLNhXY3bOM8ROi8+LN7l7pub0BDibw/xZ59SpPZu/eToV46FBZU5J5CDdCxgDrf5/gnZLFzYx
	fzEuQO4YioF/FfnVQMQ+waYaSvrjCNyeqmgbfb2JrJNMxrnnYlDSALlLzGCIqczX4d+P+y7Bjlr
	WaqCRevgJ51prw9Bj9RcFXoa05pnRsqNHvD7lDbH/0k
X-Received: by 2002:a05:600c:8b11:b0:4a3:59c9:a756 with SMTP id 5b1f17b1804b1-4bb55a6a53emr281079335e9.6.1794912120251;
        Tue, 17 Nov 2026 02:42:00 -0800 (PST)
Received: from [127.0.1.1] ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783862d6sm52348035e9.2.2026.11.17.02.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:41:59 -0800 (PST)
Message-ID: <6afc2f77.2bb6edcb.1518d5.5d4f@mx.google.com>
Date: Tue, 17 Nov 2026 02:41:59 -0800 (PST)
From: Adil =?utf-8?q?H=C3=BCsrev?= Tepe <tadilhusrev@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] power: supply: s2mu005-battery: add S2MU106
 (Samsung Galaxy XCover5)
In-Reply-To: <20261116074000.355176-1-tadilhusrev@gmail.com>
References: <20261116074000.355176-1-tadilhusrev@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

I'd like to withdraw this series rather than send a v2.

A review bot (Sashiko AI) flagged that patch 1's fallback compatible
(samsung,s2mu106-fuel-gauge falling back to samsung,s2mu005-fuel-gauge)
is unsound: a board using that fallback binds to the S2MU005 driver as-is,
which still reads the MONOUT average-monitoring registers for
VOLTAGE_AVG/CURRENT_AVG and uses current_avg to help decide
POWER_SUPPLY_STATUS. The S2MU106 doesn't have that path, so those reads
return garbage, and garbage current_avg can flip the reported charging
status. Patch 3's has_monout flag avoids calling into that path from the
S2MU106 variant I added, but the binding still allows a device to bind
through the plain samsung,s2mu005-fuel-gauge compatible with no
has_monout gate at all, which is the actual hole.

On reflection, extending s2mu005-battery.c was the wrong shape for this
chip regardless of that specific bug. The S2MU106 fuel gauge is a
separate, standalone I2C device on the Galaxy XCover5 (own address,
0x3b), not a drop-in register-compatible S2MU005 variant sharing a
device tree node -- it only happens to reuse the same STATUS/RVBAT/
RCURCC/RSOC register layout and scaling. A dedicated driver avoids the
fallback-compatible construction entirely, since there's nothing to
fall back to.

I'll send that as a new series instead: a samsung,s2mu106-fuelgauge
binding and a standalone drivers/power/supply/s2mu106-fuelgauge.c,
with no changes to s2mu005-battery.c or its binding. Sorry for the
noise -- I should have settled on this shape before sending v1.

Adil
