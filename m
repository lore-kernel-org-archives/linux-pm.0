Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296573;
	b=1ci69roGo597Yass4E0LvuCgNW5oNkGxC9vyGkL1ZyvNFlY0yu5BL/k1Y57wB71Z+bWL
	 CaRioR8UpPjoiJI4mTRWB1k3BY/LNIOSAAX6OCZJUh6rFictq8pete/W0k/F+0YDjAcUD
	 T2+6ngmGrDX3H004b3iMu6dfJW/M3sxD2UnA1QnVhMondts5KN3qCX+e5x2TGGw+BvRrn
	 6z5mD5v1ccpz1At6BG8YBA7rdP3I4CHvxKP+ev3dv7Y4r9zGJzNKM5xtnfpDFMjAbl0tX
	 +ffckcKFyuHPCkAJAGyJfnFsnI6iKXeW0BqRDhGiz9jJoWRyxC7NEUBpNHYEMLDSl0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296573;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=ByFsVBFGXW7Uh7hGswMOP8zgyfk05mbsoHtbkfCSmjU=;
	b=n2VtFr4x4bvNAw/FZmJ+d/vE0DOJGb/oS0qWBm1pJFFbqbHtwE5zg0Gdt7Oe9j7NBopm
	 gmHVFm48N5qLBsvvWHVj2Ye2C3LCtpXYerFLq3iho52iyJm/M15IgWDRtLIMDMVDgr8BT
	 iBUP9bMX5PsZZzoDRIvgdKM3plC/koWOWws2UZGGYCluOmwDnnz2pcY8y0fZfSgdXi1ez
	 YOOAMWUpeHBCc0kLZXgTvKuL57nVtJs8yZi9Tiqev9hpL8tgUTrqJpclkb2QOBqMUIHP4
	 a9Cmm8K4qvAESXblioDpPvayncgrEayp9Q606xoeyRNylQFc48+nzsCTThNGGG2rkww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Pou2b3it;
	arc=none smtp.remote-ip=51.250.60.164
Received: from forward104d.mail.yandex.net (forward104d.mail.yandex.net [51.250.60.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C49606A31A;
	Thu, 29 Oct 2026 17:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C49606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Pou2b3it
Received: from mail-nwsmtp-smtp-production-main-38 (mail-nwsmtp-smtp-production-main-38.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:4d01:0:640:e9ac:0])
	by forward104d.mail.yandex.net (postfix) with ESMTPS id 3FE7EC0032;
	Thu, 29 Oct 2026 20:56:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38 with ESMTPSA id itnBq5Sg9Sw0-pdXvF8P8;
	Thu, 29 Oct 2026 20:56:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1793296561; bh=ByFsVBFGXW7Uh7hGswMOP8zgyfk05mbsoHtbkfCSmjU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Pou2b3it8KLqKo9UkaIRTDbfqE3BEeO16dEcjjGqqMOySAVyN5zIMA8sgyufBmVVX
	 OrTCuNi7V/GhEDr7Q2GXF6d++hQhEp2cfCLRuCXolteqVBvNQFV0t95Hklp3Na4vne
	 ERoMFFdyB7ae5+SQ34C6Hk6iMRSoyOa3Bu+v/p8A=
Authentication-Results: mail-nwsmtp-smtp-production-main-38; dkim=pass header.i=@yandex.ru
From: Kupreenko Danila <keckerz@yandex.ru>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] power: supply: read-only CellWise CW2017 monitor for Redmi Go
Date: Thu, 29 Oct 2026 20:53:16 +0300
Message-ID: <179329639684.489944.6322623410181934358.cw2017-first-public-rfc@yandex.ru>
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
X-Mailer: CW2017 public RFC via Python smtplib

Add a read-only power_supply driver for the CellWise CW2017 fuel gauge,
its Devicetree binding, and the Xiaomi Redmi Go (tiare) I2C node.

Unlike CW2015, CW2017 has a different register map and battery profile
protocol. The driver requires a gauge already initialized with a valid
battery profile; it reads voltage, integer SOC and temperature but never
writes CONFIG, changes the battery profile or resets the chip. Charging
status is unknown; presence is not inferred.

The CW2017 source is an independent implementation assisted by Codex
(GPT-6). Firefly was consulted later as a behavioral reference, not as
a source of copied code. AI assistance is disclosed in commit trailers.

Hardware testing on Xiaomi Redmi Go (tiare), postmarketOS, Linux
7.1.3-msm89x7 with a module built from the same RFC driver source (R5):
  - module auto-loaded and bound to I2C device 2-0063;
  - running srcversion matched the locally built R5 module;
  - capacity, voltage and temperature appeared in power_supply sysfs;
  - three consecutive measurements remained accessible;
  - udevadm monitor observed kernel power_supply change events, including
    changes in voltage and temperature, with roughly 30-second cadence.

Mainline 7.3 ARM64 build/MODPOST, targeted DT/schema validation, sparse
and host mock regressions with sanitizers passed. The mainline kernel
itself has NOT been booted on Redmi Go. Hardware PM/unbind, power cost,
calibration, temperature-source provenance and induced I2C error recovery
remain untested. The source operates as a monitor, not a safety controller.

Open review questions include policy for already-initialized gauges,
3-attempt probe retries, nominal 30-second polling and up to 300-second
backoff after failures, and event frequency with small voltage changes.

This is the first PUBLIC RFC; preceding revisions remained local.

Kupreenko Danila (3):
  dt-bindings: power: supply: add CellWise CW2017 fuel gauge
  power: supply: add read-only CW2017 battery monitor
  arm64: dts: qcom: tiare: describe CW2017 fuel gauge

 .../power/supply/cellwise,cw2017.yaml         |  52 +++
 MAINTAINERS                                   |   7 +
 .../boot/dts/qcom/msm8917-xiaomi-tiare.dts    |   9 +
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2017_battery.c         | 370 ++++++++++++++++++
 6 files changed, 453 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cellwise,cw2017.yaml
 create mode 100644 drivers/power/supply/cw2017_battery.c

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.56.0
