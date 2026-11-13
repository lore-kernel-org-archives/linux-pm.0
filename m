Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585901;
	b=tdhoaX3M7gBPg6VvMWxw7f8AR/lJ8J33LP2dwM7AvI1uaIRm8/YEDOFlD3xthLlgw14L
	 Zr1028MXTiSA5ypePIUq/AQ34Fi0tMTejEB2NbPTeMzXvQ5nmsfKDvYPcPsy413pu3q97
	 0uTgWWYuByCHVC5Kg123lBkrSbqx94beI74hFnhGuxOhnBrHDzP5+3IGCMg01n52ZmVGK
	 cqmWbI8CpcLeDsQB37txMj6wkeCkglYA5l+mEuSo3NzWjJlV/AiSsrbeDYI4cyaawJ7gU
	 XPjcPFivFjbqU9ljwJG7MnMg4FffHCOlRj0JgTtB/LYgP10vieVfkM5dJuMcVdwJugg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=HwMUb4dEkzr3j3kYrSUeFqOaaM2WvdCtqrwakPH61UQ=;
	b=k/NDnosPS6rdQxYXD/NLIKpjHiRswZvbfIA5zm9UYje0eobozbwT+XFKtZJfe8Psq6SB
	 A6xY+e/oZ0w3I2OUo2Iw83AcFT0d4iwC7iNQ8vNoZQOHy6oASsGHel4jAenoIAX/eQy+r
	 /0JEitaE7nzeo/SLlVBHluQHJeyyKzWiKXtFzctQOzpgBpf0cCwAxl822tTbV0cMWQAWp
	 +k4hXAfbg0aN62+9II2afCzLzhUeACivvRqzhDUNBltbwWCigoLcQMMyo5EjM73xLCT3q
	 r/cMdn4GLhQDTg4w5B9A/6bpvnsqr1d6AHYQWU2Mbv5Rx/lWFvmllY+G2e5FX7DVY/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=TMizCCmw;
	arc=none smtp.remote-ip=74.125.228.72
Received: from mail-ed2-f8.google.com (mail-ed2-f8.google.com [74.125.228.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF42606EAAF
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 16:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDF42606EAAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=TMizCCmw
Received: by mail-ed2-f8.google.com with SMTP id 4fb4d7f45d1cf-6b574dc3747so740301a12.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585898; x=1795190698; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HwMUb4dEkzr3j3kYrSUeFqOaaM2WvdCtqrwakPH61UQ=;
        b=TMizCCmwf8mG/JV9eviD9QSmLpeGVHgmSZsbfOa8NLMU8Cpo5WfKMUv5tUSq40GbS6
         NW4O3S+jnsPLGnT4w4iq0qzMEYdjeX2nbriDhkrMAHHfJQ698tj7hGF7R0M8jC3rd2iO
         SkoVNWx48RiYRJ47mP4wm2SHgzlALTJyfvl0pMNE1mauqdQ2uvGhABKBFyFE8GN3JfJI
         l8kN7akXW9XitcAD6G0l6ZlbSoW+JSzA67VXa1FIGwJt+qRprMEVYNPy7gzNiIxNS6gm
         WZKvHmW3b0NrID67oek21Rl6lvTGGiN494NIjDdFneMtyDg5W5w1StgNvvCuJnD4YOzF
         3cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585898; x=1795190698;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HwMUb4dEkzr3j3kYrSUeFqOaaM2WvdCtqrwakPH61UQ=;
        b=ggSPwzOolVIkWxR73QB1mwgweCcf0KEIf+cwJqjutuztCfVlXF9rtdgG40YVJTcyBN
         QfuQLcjvZ9s2s8hR8oicYFGNcaE4wpGB+JxUDj+ABMsGa/65FljUjHd85ea7zT4/MW7I
         EaSz80ije3emgzb68xGYagdxdZIvsd12+k+Z0Bdwe6ZM0/Jx9nG1ZPe74I7MZEgcua/0
         wau3My8Ul6Vc93xvL+U+1GMCHSeXTDpQ6YDPpMhPAxjfvtmORqGQE14bNuchLnW1c1Vq
         oQ2CXxC//4tWMvULF+Nh+7sOl6XeOWHOrb1oa6No0/PkjMILBaZIFvjcThwwAek2ejsc
         gd9A==
X-Forwarded-Encrypted: i=1; AL+hErEHF80vCmal3MVfQqzVa8QTlcbK2FCl9kA6DTJe1SsTIiMaEfWw2WP3NYep4idnYFexJeSn1XhkFg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/nCsGHjvjDNmz+oI8hMP/516GQawr1hl3QYANbZDhRuClIG0G5
	4IpSxN2XQmc3OjEA6TipmYY7Ix0Diq5Szbpm19ny4IxJxJxNEw3usc8CCe4lTXHCAHY=
X-Gm-Gg: AYBFou2cRwc99JpdXb7marVnDYx26ejPURrhqSiq9X+0StbpsZMcUmS+bLprLqs3VQn
	0rg1lfrwo10kytUUYkAJVU7mo+425GV9Q0zv1RfHzfDun+Zb5iYpN094LkXb3vZNbo7WpigP2n1
	Ra2ZtBsWS2WP+7qk8YGzDSvlgh9dgAbq9tZKsidtn16QFxW6am2UBisCIB6yxPgaA4qjX0H7ZDY
	/zA/BmPbytVBFRYGN5MiDIUIvnZK6Z6igEGL4wXuYNiYhNgMv64iMuCWAXehXTlZdeq4Xwe6Q/b
	Bkq+9CVVVuZR6vYcP1+7u9d7pI4cLSm91RuJ7LiLdLCUcz05EtL6Jxq9vp9++sNuDxaywIhZTNV
	fy+ymb6CjxcMZqkx2QrQ8TjRwa2hJvVuXDADrTzRlOKqG3M67o/g1Mi8Eu+gTUqCp/HKiH7g6NP
	qHWBI9dQlZZJSJIBohOZtGoky+CZ78GEFRSBIuUb5C7J+UkSZ1BJNeqG1wbGNx36dyaq7m7gKfP
	vyNgkhfR+G/LsqO2AAAN3mJaMzVvsMdyybZ3vJPeDE/KUOuVxBZ8CK9wvJ+2v6GSwaJh5nQIoL0
	czHmNLi4nPIvL+sJCcJQoYRK5sKdE8hqwr0sJOvKWonmB6FUA9rb0jjwQiusI9v2RaB9nvyjmgG
	hND8Glds=
X-Received: by 2002:a05:6402:e9d:b0:6b4:9c38:a990 with SMTP id 4fb4d7f45d1cf-6b7c0c75afbmr2983164a12.31.1794585898224;
        Fri, 13 Nov 2026 08:04:58 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:04:57 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/5] Battery temperature ADC plumbing on Qualcomm
 platforms
Date: Fri, 13 Nov 2026 16:56:41 +0100
Message-Id: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Oyw6CMBAF0F8hXTumLZQUV/6HcdHHVLrgYVsJh
 vDvVogb4uzuJPfMLCRi8BjJpVhIwMlHP/Q5lKeCmFb1DwRvcyaccsEoo6BVgoTdCMoakKJstKN
 aCm1IrowBnZ837nbfc8DnK6tpXxKtIoIZus6nS9HjnCDLNctDvoXWxzSE9/bOxLbG/8sTAwpWM
 DSyEVaZ+uqUD2M79HjO/IZN/AfUlPMjwDPgsKzQVqikYEdgXdcPJZAI/x4BAAA=
X-Change-ID: 20251010-bat-temp-adc-8539bf0b85bc
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Val Packett <val@packett.cool>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=2567;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=AnCETj31XseSXn+d00dwl6t6SQEdfssfzEz2saX1ad4=;
 b=B1fAUfgQCruIJjGIq6oviNi2fMjyU85Otv492YGAgSOdFhXiv+VZQXayVf13n0Q3YFM8+/zB+
 WQwi6BTRzcyAnpZTL2e1Z2TszEbZKLJv/y8QbvXZ0G4dhmqQIRrjgEB
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

This implements a solution to get battery temperature readings working
on (for example) smartphones with Qualcomm SoCs.

The solution chosen in downstream Qualcomm kernels is exposing
ADC_BAT_THERM_PU* in the ADC driver as temperature channels with the
lookup table ("struct vadc_map_pt") for the specific NTC found in a
device's battery patched to adjust the lookup table. Patching a kernel
per-device is obviously nothing we can put upstream.

The high level solution proposed here:
* ADC driver provides temperature channel in (milli)volt as IIO channel
* generic-adc-thermal driver converts voltage to temperature based on
  provided lookup table from DT (driver has one IIO channel input, one
  IIO channel output)
* The fuel gauge driver can use that temperature IIO channel to expose
  battery temperature via the power supply device

See RFC for other variants or alternatives considered.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Expand commit message on dt-bindings patch (Rob)
- Some commit message improvements in generic-adc patch (Andy)
- Fix dt node location, move higher up (Konrad)
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com

Changes in v2:
- Rebase on linux-next (a different patch to add IIO to
  generic-adc-thermal has already landed upstream)
- Un-mark as RFC
- Link to v1: https://lore.kernel.org/r/20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com

---
Luca Weiss (5):
      iio: adc: qcom-spmi-adc5: Add battery thermal channels
      dt-bindings: thermal: generic-adc: Document #io-channel-cells
      thermal/drivers/generic-adc: Allow probe without TZ registration
      arm64: dts: qcom: pm7250b: Define battery temperature ADC channels
      arm64: dts: qcom: sm7225-fairphone-fp4: Add battery temperature node

 .../bindings/thermal/generic-adc-thermal.yaml      |  4 ++
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              | 24 +++++++
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 83 ++++++++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c                   |  6 ++
 drivers/iio/adc/qcom-vadc-common.c                 | 16 +++++
 drivers/thermal/thermal-generic-adc.c              | 20 +++---
 include/linux/iio/adc/qcom-vadc-common.h           |  3 +
 7 files changed, 147 insertions(+), 9 deletions(-)
---
base-commit: 6aa7dbf8ad5ebd3babf53a4d6209018f86939f17
change-id: 20251010-bat-temp-adc-8539bf0b85bc

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

