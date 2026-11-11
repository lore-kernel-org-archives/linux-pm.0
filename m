Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794411301;
	b=jwcLDmY0uzTijnCse2kMDJKgTJOfoXELTBy683sLVqB2mRjM0QF6BGdcy2QA5Egq0Wg2
	 Lo5sYV1g5cMA9sUI/EGUU+1ZX1/fOa5qfqTO/iPEsYhDPVC9M8zyCOaMPn3w/UwPHjyBq
	 Wkmz4Z1JoYDtiHqIPbswfYzaHrtcvwmUlZklXBxv+/fMmVlwFVnWY9h26XK6Nj+p7JcN3
	 7Tg2iQhs4ryVrTN3q+OlywzGWDiVVbmAqLaO8191ltNNX1ABGkLo4Kb78FrNvKUiRpqiI
	 HDWBFJ/o29TE5KAg3/WsEodNSojREZoIk0amwtKs64Abfr+R27VyXRlu7kXU//y6vxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411301;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=j+b4RdtPuBh7amsSTwAr9llsAjhTDfOm1btLEdeiDO4=;
	b=5bZQdueurkSBuVml4rq1Tvpkai7SU1yLAzTLbi34yy26mgwoEh/tUG4dxHWb0vHdRuZB
	 am7PPzdqXydy+ecXbvyNZnI5kI1AZOdQpuZpgDLBf7IFUuZZeYp9zbqCVNkGtFaHjp34v
	 VIDtXxhBILtz1kY1vYuLeSiQUOtD086Y2n1JkzM3gX2DpTzPfVFuU2jWl6rRn8idK5fT0
	 jZq3w8sod1mX/NZeCGX7cp/Y1je/avT5SwOPZxJJLWsxWVbIMBh6fpajWb6kj7RNDgqCK
	 xrOfPzp+KjI3v5PgsBrVjF6tm8XwWxDNce1R4dpzh4xP1jJ8kA8JK1wgaJiLhBpgYWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SC9o1fiu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EBF606A8AA;
	Wed, 11 Nov 2026 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SC9o1fiu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794411301;
	b=bbK9G6T7hUKbEsrmfBmeqw09YIPdGWBXZN94JxOdb+4JGdVCwCpxX+F94zXN2Xf93psx
	 EhEJ6IetYWlctAp5RA/MxDoh7Y7s5Nsef3RLSHJZTMxBU+FN+485tGaBG6pDAhabRMQ30
	 YEZ9DAYnOiKPZ6SHNvZk4D3RpYfMq1FEpNembUPIp/tnQVoNb260R5kWx2Zn4cOgvMSrU
	 vLTxvVdy277DaC4bSv34L5r9vfH2grQK6KhJi7N8e5N++RrHswPc05BY+a2988SvJU0nI
	 uwSgVcP3fFst6ZoyW3zSbthOHb6Ghl3wTrzDTzyQaSDTzqeYr6ivx6J7HTLw78KCjVA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794411301;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=j+b4RdtPuBh7amsSTwAr9llsAjhTDfOm1btLEdeiDO4=;
	b=gIiXmaYcSOLQf5i80xbZ34Bg4+2inI2wHLu+xQkhFkbHw53T8yLNRVgHRfA+48nUfheM
	 +DMSXNP3tuqvc2bHA6xDjipjGk4wRbJl83uPBe5MdWFNfeDCndIGWPz56rOivZZ9uYTBX
	 o09kxnc587/DksyyinUh6iG+bg+WHpiwV8SRn+MDjsBWmH9VGduE6NsTn89k/GeFT9I2V
	 /Vgm9zMeV0DEvYrc+T9BZwBgcAa5PuHkZamzxHAqbSQT1gXzHNjXrdKYqf9BGjkR57GJV
	 gMM1NU1oY1k1qLLVohYxSjH0Mi00gqD6bA51xxOVDgfNRn/pRveemJpIOK+z6dQZyZw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 94F191F00A06;
	Wed, 11 Nov 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411301;
	bh=j+b4RdtPuBh7amsSTwAr9llsAjhTDfOm1btLEdeiDO4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=SC9o1fiuCEQO+Ugs5HcjxGDkZ8XKSM/1x8FTM2y43r6jxMCdKU0zWGWVkyxWMsJ8S
	 OnAzcU6CaiSS0yp2Kx0seBNBYWV5Hbm9U+VMUibr0oW4OJhZC4j3isT0hM+7RSmX6J
	 QnWGVs829qRBBymQlLz5653T8fk0YUTN/s/ZYtD9/C8KDwBZXtVIbBeHZWIjPAoGHj
	 xBTPuJh9fsZsBx/qgc6Va06Iiu/H/APdu5n3sRAQyKD2wnhXOhXEScgjz8HEzcARpo
	 fD2gcvHDHkUUk+MW0FnPZs0r7ACfEinecTsudw6BJvf33I2xR1DKJIobqjGxnoBUwq
	 gwKp51nno/Iug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E173A49005;
	Wed, 11 Nov 2026 15:34:59 +0000 (UTC)
From: Asdlerto Korry via B4 Relay <devnull+korryasdlerto.gmail.com@kernel.org>
Subject: [PATCH 0/2] power: supply: Add Silicon Mitus SM5714 fuel gauge
Date: Wed, 11 Nov 2026 17:34:58 +0200
Message-Id: <20261111-sm5714-fuel-gauge-v1-0-b9d163fff6ff@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIACKL9GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINAtzjU1NzTRTStNzdFNTywFKkg2TjYzNDcwtzAyMVAC6isoSk3LrAC
 bGR1bWwsANTEWw2MAAAA=
X-Change-ID: 20261111-sm5714-fuel-gauge-c3c617078240
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Asdlerto Korry <korryasdlerto@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794411298; l=1685;
 i=korryasdlerto@gmail.com; s=20261104; h=from:subject:message-id;
 bh=76ei+RgM9hKvisAUftK3npdW06X58VHxTiIil5MR6B0=;
 b=TkmNnO8CvraYln5cWpyEJnk+YbdPl6bcnr+37wPdYhFCMhmxzda+T+C7zs/egAxxNprrt+JSk
 jOtDwliwEtGCKk0cu7Yf1YzqtygFkO+Qrn5nNLb7b74FJFcffRLUCo1
X-Developer-Key: i=korryasdlerto@gmail.com; a=ed25519;
 pk=RqttIGkm2XZ8NhLQBzPgpXXawOdVa1uODGsk+sagbxs=
X-Endpoint-Received: by B4 Relay for korryasdlerto@gmail.com/20261104 with
 auth_id=1411
X-Original-From: Asdlerto Korry <korryasdlerto@gmail.com>
Reply-To: korryasdlerto@gmail.com

The Silicon Mitus SM5714 is a power management chip for mobile phones
with a charger, a USB Type-C port controller, a MUIC and a fuel gauge,
each on its own I2C address. It is used in the Samsung Galaxy M52 5G
(SM7325).

This series adds a binding and a read-only driver for the fuel gauge
part. It reports the state of charge, the battery voltage and current
and the battery temperature. The temperature measured by the gauge
itself rises with the charge current, so an optional ADC channel can
point at the battery thermistor.

Tested on a Samsung Galaxy M52 5G with the driver backported to 7.1:
the voltage, open-circuit voltage and current match the out-of-tree
driver used before, and the status follows the cable (discharging when
unplugged, full when plugged in with a full battery).

The charger and Type-C parts of the chip, and the devicetree nodes for
the M52, will come in separate series.

Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
---
Asdlerto Korry (2):
      dt-bindings: power: supply: Add Silicon Mitus SM5714 fuel gauge
      power: supply: Add Silicon Mitus SM5714 fuel gauge driver

 .../supply/siliconmitus,sm5714-fuelgauge.yaml      |  53 ++++
 MAINTAINERS                                        |   7 +
 drivers/power/supply/Kconfig                       |  13 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sm5714_fuel_gauge.c           | 315 +++++++++++++++++++++
 5 files changed, 389 insertions(+)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261111-sm5714-fuel-gauge-c3c617078240

Best regards,
-- 
Asdlerto Korry <korryasdlerto@gmail.com>


