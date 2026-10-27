Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107076;
	b=0Y2TZ0WQTWhUJVkxXqkdQ0SWP9jTblzUvh37oB5b5dojE2ruP5hKFpXDAbZbzNehuWAp
	 gB11iQwjpZjREvu6OdgwkXGaA8XvBSYuckPfe2SvHSNGlspwOA49k3o+KMlSdtw+Dh5db
	 nmhuvrDDKvU76ahaQ8oTuPnB0MyS1F9p5Z9oym/Kms+YTzgrYchiJ3eKyh5Bt1dSqLDN/
	 NIi81ggvyx4/PnaSx24UKBXG1rJAsRN/upykMJjWfuqd1aWMWeeOvaAiQ9UCvr52Ib4kp
	 MqrRGQ4NNA0k6LlzInqP4Bat3+jJy9/vPE7Hrzb6J/Fub709crNlD1mt/2NIfwGQ7eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vqZvXjV4n8be69kPlaiT6+hlyFGKWR2Jg6RBdmE5QhU=;
	b=IIWY+uk7blWmBt4u5AY6Rf/ob2c6Yr1/z7g1vnSkzEjk4MBXg3iIfKbv+DIR7DQ1coi3
	 iVSPz13Ji4lkj2yqvOF1cE5HDdH1yz1MHIvkelKRfxBT+vvdKVLkWd9SetNvALvMGSmeN
	 uABhRsV7vC7mNMXUF+l8NwBLKzUZABz4TgMvtZY8tgjgiQmZYds+kAJuqbF59oZ6I7Upj
	 4rBE2Eb6cuvfeH9fberIkE+XiB/wqx66S10c5Z3r19sH48Ipu08zz4jUVpXiaw4P4VoCz
	 AdsNOj9CaK75IZAWqoCoEBGc8R6I/rxuFxxD4zqOWV9f0+GNEn+nrRGTOoA5jvs8AnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BYgNUIEe;
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45074606A31B
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45074606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BYgNUIEe
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-486f013db83so1542329fac.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793107074; x=1793711874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vqZvXjV4n8be69kPlaiT6+hlyFGKWR2Jg6RBdmE5QhU=;
        b=BYgNUIEeS3hiXi91blh9PUmQR/bJNGta7wvmoZ3FwonGZIioT23eWMkAcUOKA7LqZo
         Te3tK7LJMpdK6nB9f4ov6enkvugqkiB7RSA9O6DINkmrq4Sve/odgXLSaXcnDhRyNdqK
         N84gkYAFxaSAhtS5mjpEWjjDvaYeE+AaYH9C2dXwQ8fen3pkJnbX0LIRUZnt5dJnK+73
         ImErX0SydSxgBDl1Z+UjjfuherJybQtZHUXJuZRw1coGldPpsLtI8qqB7XKaaSPicw2w
         8VHHe0dTyRvXzAzsqDz+MXhrq87uBSPToyOnpfOGlgCnYBXlSAZ6DJLetXVrHdzxnMs0
         r+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793107074; x=1793711874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vqZvXjV4n8be69kPlaiT6+hlyFGKWR2Jg6RBdmE5QhU=;
        b=sx3N3kwZ7Ro7TkEa0/O8xP+a06HKsBi7N6H2g/t4V5SyHESkgt2kQF0bz7hAIvp9H/
         rkp8BXBfDXx7+8N8xYRAnqMnLa5oD4RcwiMqD61iN+S1kv0K3HRA6GxPYK2acEVwwtAg
         NUo8y02KT6gr6irUXTYlVrMJwFwOig4sDWT9Zw7YO944FwygImnt6TswQKYTBOb8EiM1
         fjb3LBsNmZfNN9CqIBnSbz0Q0XcuYaO4pia3NNI9SZY5qdz49Ix/S8Y8hnPdQC3MLkmK
         QWACLw9WH5QD6gb2Bgue4vNHAe/14/9BltksMKirkyMbeRy+t6EQ7OxjFLICLXIkE36A
         A9Xg==
X-Gm-Message-State: AFq9FYL6n62KaUkoGGF1GqX8oQXIPwq1SMbxJyMVZqiWD6sbSRdPNAYI
	F5kA+HUyTAIlo3H3Qviop9U4iqyyaVppjqR8Mf3QK5SdULme+SqeWMMFkpZ4QzCs
X-Gm-Gg: AYBFou3vFJeQdJfzJkwWFVpFGyvuunNql6d6xm7bs1ezbYxW/Z+7V9FD/ZPXm1i3BGa
	F9Qz4EaZLmmI5lfWAOJ8a66bQMajdQpkMENoGZCZvW/ITIzSRUuUk8GyL2mFerCi73EAL4pZJQI
	plA8ZzddNwQKs7krj2uO3FB9xYRLuusehoBgwrgyp+O/ed1F/SqfxQzGf94NUcacVHxDoNPqFoC
	mKycyDpe3Hd3KqMXDgI0wbMTpK255y2tD3TAxI+3sD9t6NTCqOfwXxAacUx0Gp3yIy0zDQ1Ocs/
	Ndn6inlGg9aOQOkmN+tW/yP804hGj2tWmxcTe8de8GW8PMbEA9eu4eWYtepu7HROZnNrIFOZkCm
	R0BjgCLVMXamMdP85N0MO7dmW7Gp9P5zmkBEvtxlBFvYgNlNj4uEI4QJHakynsZXH2D6S9FMWcf
	yG+qDiMR/TSTxDxdXurUdNa6+uX0zlPKct24MI15gziNWkWdw+GRvjkMO8xVJS9Kh2xwR4EegoW
	z8KPylGYYyMJY9wPbyv4xw2n0LyuEb3VM3mrhP809e1t4Ubu0uXdwgtVEtl/Yil7VLZ9ThqBdxR
	KKWD/Sy3KQAqcr3z+vzmvIVGFynHvQ==
X-Received: by 2002:a05:6870:b0ca:b0:475:a112:1276 with SMTP id 586e51a60fabf-4a83f5d3533mr5799677fac.35.1793107074123;
        Tue, 27 Oct 2026 06:17:54 -0700 (PDT)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b74c0a7fsm23412fac.2.2026.10.27.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:17:53 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/3] Add Cellwise CW2217
Date: Tue, 27 Oct 2026 08:17:48 -0500
Message-ID: <20261027131751.1724448-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Chris Morgan <macromorgan@hotmail.com>

Add the Cellwise CW2217 battery gauge driver. This driver is based on
the sources used for Rockchip's Board Support package [1] but has
been updated to use the regmap API and devm helpers.

[1] https://github.com/rockchip-linux/kernel/blob/develop-6.12/drivers/power/supply/cw221x_battery.c

Chris Morgan (3):
  dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
  power: supply: cw2217: Add support for Cellwise cw2217
  arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro

 .../bindings/power/supply/cw2015_battery.yaml |  42 +-
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  |  21 +-
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2217_battery.c         | 818 ++++++++++++++++++
 5 files changed, 885 insertions(+), 8 deletions(-)
 create mode 100644 drivers/power/supply/cw2217_battery.c

-- 
2.53.0

