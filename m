Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210103;
	b=kCw+avjRww8Dziv+JPrshgbrZawK72i7P55Vu7MPH0LdYNOHI3xKc5f+OsuF8K8RYYDc
	 WIfYurzpraOa8TY+HUB9BOB0KKMGS3EhTzwPAgfdEVBW8cTZiuJeDSXBLLzKyvDeVgs7V
	 pxW4uNlqV7k0sxaZPN4jvP8aAS0S4wQUlMbiN6JJByt4LXrHNkRQqgnkxGMwW8x2aiwDk
	 aU/YhVctRxmnJ1X1BZ8KSbKCg0LKlrh8CVzpsvVricRrTraMgLlgpk49i/wbbcP4ZyMNi
	 APDMh82+Zez99xfna9oJc93xzl6Js7dbS+VHnkOoSCvrcKaB4L8upC+wntRmr4fxCag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=taf0KVPRoF+3JboQGvuM90twCXz2SjYe05359+kTlN0=;
	b=Hx3T0p3H3ZgXnHAe9urzSChrdO47FkI6fD0TMT4SLK4GvqtPhtdlzvVlwEYnKxGHS3dm
	 9L2GCrK3FweLCXcbYtGh2aioScHanaduueCUtI9QqoZ8pCxBvxPlcmq0qFy/kVJ6sMiSo
	 lJbEHgUVrAh6b8aMOv+FOV7JGMWe3Wtqs1i+KCaRXfN7qnyspw5SPGJq+E4qVbcgOUWxJ
	 6Ih3h1s9wKn7lIkAZl2Dx70qWCz2emspBkoCJwJj2W8nvvZIhSP+IIyYPJKh7RH90DM1F
	 NJazyOPEg1+DgrlK2gViZAT7kX9vqXT6wCMqKkkWHzA4bwhqEQ3a/io/YlLXztzbXYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtUSzxaj;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B1606A6A2
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 21:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A6B1606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtUSzxaj
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4ad587ba293so909146fac.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 13:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210101; x=1795814901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=taf0KVPRoF+3JboQGvuM90twCXz2SjYe05359+kTlN0=;
        b=FtUSzxaj+TW/kizwQ44WcHMK7fkrtbh0TBjEM6Y8hwUmZ6hXvEcdUCkpMuuXDvcCyq
         901SKBaL+Wpgkt3RCD5m8t7BindXheyRFBliuiIzuPFw08GphYwdsHbnJGsiYFRrMYjY
         zdfhChHJPWCyG1X6Ck/PnRnMk+AhlS3elu0s1OWVWQFMpulStuS/IoK6h7KvF77SXFio
         WIldfRkJwcp7xwWS+OCzCPV5Errlwco/6D80BEgc8vUEXS/wT9L+MNToNZXf0SpMDXRh
         km2Mrdt7vlCjZ3fYdvteCdzmVJUYI8Q8URDjXnZsC08f6w6Cqg7+a8+F3R2/1jOJegTs
         e1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210101; x=1795814901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=taf0KVPRoF+3JboQGvuM90twCXz2SjYe05359+kTlN0=;
        b=TUc7MoBd0Qj8AO5VqCaQtXOBZPagMrQj77lvakqAPtAkJWIk5Ca+NXWKk8w1PddrlR
         oDPFNO7rVxYrCX6H7yFR4vDSqkndDtnRxQvjcdr215BoIDe3d9daDqGxPoTDBYEqbiSm
         roAzFwehCdQeHKxhc4UaLbtxkgj0n7CznJf0iApWLw8haL+gFRD0MjVViYiaEfODEPbI
         K18H6dBIOmM8066MyMCkB/zPHGL2e07kc1u46cxsO9MtMq5zkv8VfyLRdFv2tKwYUZ5B
         7HJhZTE8CBt6GDGgWo3CYEj8DXHkE02Ao9X7jeMPPFGKx2Kk2nc9p1lNv8Om7fituFtL
         ijdQ==
X-Forwarded-Encrypted: i=1; AL+hErFfNl3U7/XII4fGGJEy7RPlFmHrfrVrU1whKNqZqxfzRsTmkawFuz9IUSbErCDulIELZxrnjVK8Vg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/g1+qpjmXsg4dvjc0dHHa96WklPmUJfF5Lk26p0yeyF/7ySj3B
	SpmaatPvXmzRw+Mnm7cYdNdBu/rQn33JYRwWN6HHNwnzXRNL5vIlQ7Qj
X-Gm-Gg: AZFdTZdlHYEI6FYHWan37ntsBLsfDAk1dCdhuZN0Sd1hWDMBQ9iZ/O0w98gTJNOLfAI
	z/0BmbVV7w1fjwJxUpY/q3MY6/cX2lCmSW/fjAT9xQU3mKvVkTLAbMTSZVUuKDrWDgiAXWctVcM
	x4bc10Ux0398hVwL0v1J1FIjA3m6femo8CWNXh/rwD7qPP3RsgPHzx9cLbJwbSK8lxMYyklyq6x
	f6yykKdqaVrJXuPxsDy9b7pnxSYBgbF9cypD//fqq2YyLJBbQz0Ry6w/kwAc+L+S6+tz3gAfMWe
	Q8lQa7f2BTVXhfq1j+UfjRkl7dQY88Jz/JVzhPfpHRkXlqdEIZ1suszeSiKzrad8Q0gtFFjMBt0
	Ezhotpeo7EiNy/8bCy7beet7BJELkq5FmepjcRV4tMj5gRds3mV31iNLw2qBp4TQR8Au1W5beGv
	blsEsaIf3rCvSOi1IlynrRh03IXSVeCrrShLCedCFPIPwVIM6BCj9yQjOCu/gEbjGcjVbQdUZYI
	KqCGD0QrpL3avthDYsRY36Az8ghNDer0Auc7gACzi3wIxxtQTEpdc9HrcKGQYl59We6Zcsbe6QR
	RTxqa57XQffY5Tp/hgLdehRbrlFwZw==
X-Received: by 2002:a05:6871:eb09:b0:47b:df9f:6c0 with SMTP id 586e51a60fabf-4bc7d6650bcmr4022958fac.4.1795210100955;
        Fri, 20 Nov 2026 13:28:20 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5b07d766sm3774126fac.2.2026.11.20.13.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:28:19 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com,
	linux-pm@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	xsf@rock-chips.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 0/3] Add Cellwise CW2217
Date: Fri, 20 Nov 2026 15:28:12 -0600
Message-ID: <20261120212815.35663-1-macroalpha82@gmail.com>
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

Changes Since V1:
 - Added a default value for the shunt resistor in the binding
   documentation, and updated the commit description to note that the
   min and max for the battery profile is now per-compatible string.
 - Fixed bugs pointed out by Sashiko bot, and corrected units for
   temp and shunt resistor values.
 - Corrected include pointed out by kernel test robot.
 - Noted in the commit message the patch is based on original work by
   Xu Shengfei at Rockchip. I did not list him as co-developed or
   signed-off since I did not have his permission (yet) to do so,
   but I have his authorship included in the file itself.

Chris Morgan (3):
  dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
  power: supply: cw2217: Add support for Cellwise cw2217
  arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro

 .../bindings/power/supply/cw2015_battery.yaml |  41 +-
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  |  21 +-
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2217_battery.c         | 826 ++++++++++++++++++
 5 files changed, 893 insertions(+), 7 deletions(-)
 create mode 100644 drivers/power/supply/cw2217_battery.c

-- 
2.53.0

