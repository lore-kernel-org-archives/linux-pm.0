Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456388;
	b=QD042NqbB+fIgo7Kglygm0dvnqtKqC9OXoq9U6CLJNA0l1E7FB9hvX0TSNe30+CMyQIU
	 lGRBKMQfQW2sHbxhAT5J6SO6Sd9VvOc6OvHi+MY7l70rH9HR9ukwLmEom6j+TGjoHTHbV
	 zawvOCswWJqibb7vD1EZm6lfxBAv1J9xyRVbHYnx2Wu3OnedEZUk+Mcm0EAdw2xE0mN7i
	 jD6Z2OtAT6utjlLb948Dq/6IzEKsA/BErdaU3PCyXkECoi/87/g2c3Xl+z253g0xJTqmd
	 q5poHGRnGDD3+gjORuA/G9V5KPlfsmtoB22IdgGlm919izPIeSr3oUnJFe8bV24ztsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c15yII0Bbqbvlrh2M47suTP3fe26fyb8Izw0IoDwLNY=;
	b=He/yRyBt97LmfRYlXWsFFI3eWBCXjyKoPEcpJ+OGGIPMZIgZ7JtMBEecv+XPUEreVUvB
	 qEUlMy77EEWCsLRj+9TKox7DvTKbwpU1vkUT68X30vmZrW49vkbT8DeCs8N/HnCNF/eFx
	 RzRBqIFxpxJNO8VaLlYB+fmos6nef+VuJLniyV5qLhjzz7N2p1rleSEXcOSh03pMTh75x
	 f28tVNwH4CPci9UMmEOTmV6WhVlvsqkWqVphp6pWOimkQkMHHv/SMFY2Zf+otXrHef3Vc
	 ayMTn/MZu9gpieXrb1WvpR++8SHMxvydNEcNicO3H/iLTu+Zs0RKdwofpNJbKgxdSbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=utAh3K9n;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C18606A31D
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 14:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0C18606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=utAh3K9n
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a210470b49so12857635e9.2
        for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793456386; x=1794061186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c15yII0Bbqbvlrh2M47suTP3fe26fyb8Izw0IoDwLNY=;
        b=utAh3K9n6ASkvDKJCVcthNXfPz/IXZukGbpuM7aKzBdZQ/aWHtg41rLYOxQx+vyywK
         WyliRtagefBD3CuNc6cy3qlkAVHtkwKGaf8+h6pxEpjCyTxzOGbsYi+f8aHxns5KK+hL
         iHE05tiSBV2MEtCWBkRFA2TFoP8kaQ7zMHIjh9Wqv8ciRlbItUIUZjjLy84MGZYrkb7O
         SLcFer62IwjVekybP2FP4RyADwVJGSoWqaFAkG+TZDWoHo+uIndqCkm1RKmCQUuflLZ3
         P+vpGJlOQsZDfm9K09G/35yl7q/OuYF8nld6YjFCE0CA6N3tseIpqKhp0KxLk5pY9oZ1
         PRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793456386; x=1794061186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c15yII0Bbqbvlrh2M47suTP3fe26fyb8Izw0IoDwLNY=;
        b=deancks0Kl0BrAvH634UNq5X8fU6lrIflEV9j9OtQCwwwewzPOmTzbFtkn0/bicPT9
         yEDlGkugwZtYvOMHgr0ah7GmXRBuhUHkWjaXIdltAPH6lQkQ36WLbqZj6iOYtFGO/HeL
         EIM8SgldHwJ13JKQgrvWKUzpMjx861AcvLAOMJAZbSLdmXBBqSfIlJ8fV0KQ09UZfz/g
         tk/nCtqJ87kq/7roZ8od9G+LOMC6YIQXX19gwDlrGwfRTJZt9DOVaadlebi7ixMak+ka
         l4EahpeYs2axVB0so8+PooDDQlE67dzDpESLpNBwdjQAe/3AwVaUbHN4zAbcCxmc5CE1
         dRew==
X-Forwarded-Encrypted: i=1; AKwUvBy/e427aYpG86b4EnlIdWZ9J/8ygsxKu5dKr5fUVjRYXOtAiw5hzuMezP+qAxv/SMYyy6dPK0CEZA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLjmqkYAanydjvMxa4FTj/oVW6nkYxDF3LjJA9d5CeXuDc4rEOV
	pJhwAngQJ+oqxvR4Ek3eg5cGCHeiaSdqQRMv2alP90Sb4xpy8jCPkno=
X-Gm-Gg: AYBFou3vWQOFrmH9+uO9EE+gi81FsLG471RoFz7hcxmuA+tBmGHrR0iwOAxVfeS1hUz
	9hiuilAC6vd4g0QFWjul9aCy9yr3Epwo9WhNVE2cxHd6u7NR4hITu/kRnKoCPD1IkJmR+0FvP8/
	u/UZJ7wV9gK9JFe0eZs1G9EESZTzyIBTS3xu7Pi1gmLzFkohhgP2ER5PHE24xQ+j0QE1Qb02iuF
	jqtcymWBuJ2hpQc4YMcfySUfp6poYgyMe0ePP1O3MiWRMhuijFsSoZTpNMWH/9W6G05TTns5JtG
	gTjTafRo7UILH9CP9F8M67j0nalsVPBfOBCy0sPk95RnbCzx/zXPNNER6xIDGURe4iiI3wD9LUN
	4QbuayCj3rHy5xaE2Bz9FFfD47xiHFzqY7/nQ71iXGnIq7SjzU2+KeMMt3u9EPoxwc4ptwpdLeF
	HFmBunw13wWr6dZMVqNbryhb+I8puCqwnJa0Hp4xdDZCvYWQSJsI8IB0kPIv5U7q50tiAcr7LZe
	Ls9pRTvay27ZgJPvFy0HJy4AZ0Nq9VvBvELmcsRIUYDGqyN5yTRLZ74u0yrMowBfUoJcNz9J5RE
	g7RhUHrJKCY314nTWqtkGiV3U0KLQHdnE5/aC0Y8
X-Received: by 2002:a05:600c:4e49:b0:4a4:6fdb:cc42 with SMTP id 5b1f17b1804b1-4ac17b2c38bmr128602715e9.11.1793456386005;
        Sat, 31 Oct 2026 07:19:46 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm209871275e9.4.2026.10.31.07.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:19:45 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: daniel.lezcano@kernel.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH 0/2] thermal: airoha: Expose EN7581 CPU temperature
Date: Sat, 31 Oct 2026 16:19:10 +0200
Message-ID: <20261031141912.1664575-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
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

EN7581 has a second thermal ADC for the CPU die at SCU offsets 0x2fc/0x308.
Expose it as sensor index 1 while keeping the main ADC at index 0 and
retaining zero-cell device tree compatibility. The hardware temperature
monitor and its trips continue to use only the main ADC.

Tested on Nokia XG-040G-MD (EN7581, OpenWrt 6.18.55): both zones read
successfully before and after reboot; temperatures tracked CPU load and
cooling, and matched direct ADC readings within 0.3 C. Twenty driver
unbind/bind cycles with an IRQ pending preserved both zones and handled
the interrupt each time. The driver builds for arm64 with W=1 and the
binding passes dt_binding_check.

Vitaliy Sochnev (2):
  dt-bindings: thermal: airoha: Allow sensor indices for EN7581
  thermal/drivers/airoha: Read the EN7581 CPU ADC

 .../thermal/airoha,en7581-thermal.yaml        |   6 +-
 drivers/thermal/airoha_thermal.c              | 157 ++++++++++++++++--
 2 files changed, 152 insertions(+), 11 deletions(-)


base-commit: 2dc1f296b5754dd2441fc8b6613a362a47f6b98f
-- 
2.55.0
