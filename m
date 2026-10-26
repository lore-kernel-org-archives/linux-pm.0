Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051104;
	b=f5NeujF8nmBHa219UNGK1muoSqaqR0FJZKb9N3EuHCSspDDy+aZRN8ZkSeK6bReI8LOC
	 rbBqbPhORKeG29wos1qGLxRn4InZZWNh52LLcNpJoMZ8pbDArd8mYf2jsPM1PsTWk/F4f
	 eAsgap3+7vwG4zmjr/0L1HQkhzSx+edfwJBDnbr28nI2uF0+qVrFzbNC8eZr797M+oH3c
	 KFoVj+XkBiryh+rc9fqHPhDnHg8gRzr1P2s6NfR3hAMl5lLyQ0nO7STJU+PhRTQrL5Nz7
	 4pBzH5O49avPAkshjuJ/V98QXn2MkWAdzBKq/Gvlb18I6mA9mnWYERECoo5BGbibxcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=w7Lnrq2N9PiE0AD2+3kvHV/FsHEM97WfxRe5sl0QfQU=;
	b=nh3Tp9OcHvTOaW/v+QQiJb5tYYaTnAUOWT+QjlJ169Y4VTY8RLJ8F8ygtDZAYlt5SeqB
	 eDDPx1eKS5qh8wZ1W8vZFTfRf3R3pQusaY51QtfkqB+GWtga1MDYP+j78+HPotI5Ake9O
	 xBi7KzPl2EWnFaDtOcKXmqNdOhVU/F2+I4SVj2V6ymxIxxkaXsonCCTRQThGJ45JBRYl0
	 x5z5hklSU4DOv7O9AL+SvrzphlasY/NBOL3r5MGkl/TqlMXEv8jmXfeUJH45G38I36wz1
	 jW2WabyJG6gbJviXuEfctEWTG5irgtG/TpCe3XU3qXOlRwjye3njqAP1s22sMjnIugQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=apaSOd6E;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF6606A31F
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 21:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2AF6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=apaSOd6E
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35f036b17easo9422601eec.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793051103; x=1793655903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7Lnrq2N9PiE0AD2+3kvHV/FsHEM97WfxRe5sl0QfQU=;
        b=apaSOd6Ekoo+DEflA5oHfTJf6VOoOiMlZXRwTF70d3IY4E4GRP+ZbRacJNfZM+B2fo
         xG+HsSUUOYqogdVHfdxppnkHlRLHJDz6ngDnY54ry+xqZzbkkJ5oKfM/XEyGHYPHinQT
         xOBuOlrd7Tz8n1CYEZiJpQOWitgMdz+XjDFWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051103; x=1793655903;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w7Lnrq2N9PiE0AD2+3kvHV/FsHEM97WfxRe5sl0QfQU=;
        b=iBsBwqhmZrQzgjFgear6J6nkPYbjCmDAxD1NdKWlKDxcB3zIdK79VqcSxub9wW5Iat
         omNjO/IgOR/wciOMHxhPPze83hP5dmVvoKgxXDpXQiPnIunmqkLaMRw76N+Bml4Hoqw1
         tIqcYMZZ6XGtEucXQJs38bMxGmau7l3CpjpJ9B1qTIvUsSHVl2+Gpj1OVQUIwYQ6LiYt
         g+n1hyMCChi5a9DyLpL5ICducmSplbUVvnhYPgEXT1FoMDk1uOa1inZea9RS8p3R2yl7
         x4xM+QVEfQismOMtQW5dg/IZEeWECwl4VRiLlN2c0jNgtViBdx6QwIsSVivVH2LAorLv
         eTZw==
X-Forwarded-Encrypted: i=1; AKwUvBwOkawfD+sXxgmdrb+sW5IpiQQztBnZZ0zUoG+4zDk4890NYHG70K2k3TqywWIf+QrXwxFdlI6zHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIvWY3JuQTMfxXpg8/MikWGKbDBCoTDrtZbazryYWl5l1/CzLXm
	NCW2IsizVbwx4DWkoU34U7oXbwCCpx8TwE5X2DYFTUBGdjIz+QVbSH8ikAngbZqm/g==
X-Gm-Gg: AYBFou1W9A/xnL+UUTxNMtKrxo9rgRXq1N/VGsBUMnC9pEjOpGyxoEcB5QzcEbF86QD
	VDcdlEWkP9cI23C1nB0Pol4nxQ3MRrmUzXNMbfrYZSbClu8mX7oUydOfJpGl6ZTEQjIULNa1OWT
	8R0cJCa/aHMX8yLhDhae8zxyMnsenYqxiUzFJNB6/KgqI0c/vCzcuHpGAacojGRGAduNWZCYT6d
	ChnLYJXcHwpFlI2yRq+xZRUARk8LEC/iOAnnyhl/itrgK3suFPrTLrITZBqcAAQU1DvkhHTTj5n
	5nYrxDvmv0GKPN5LpZVwA4LN2co3Mb6yFEuph+C0jF0B44L7nlma2woo9x107mSVCbSx3bVDOUF
	T+b0AY1lWEWopf2LtDUfHB4Sca3VLjHQfXSW97Om8Xgm5cl3SJdFlH+5X18VjRg1zLd3X5JTAmL
	1zNqyrWlnOPwI3Z+GsVcAabrHm/BCs9wKi/bF43unbxKO1JVNUS3anWYHJgzQtX5wkZO33HqtSJ
	XZEUSDm4bS1Nb3S55DTWZo/RZxN9qivYmcRfl8/51uk0hKg9QnBgJr9en9h1+gR5s92PLyvcGFy
	Jtkm89BI2YD55v21GOxL
X-Received: by 2002:a05:693c:42dc:b0:35d:d9a9:e455 with SMTP id 5a478bee46e88-369e84d3650mr12944624eec.21.1793051102383;
        Mon, 26 Oct 2026 14:45:02 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36a026e04a0sm9389095eec.1.2026.10.26.14.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:45:01 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-clk@vger.kernel.org,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/9] google: Add support for Laguna CPM
Date: Mon, 26 Oct 2026 14:43:38 -0700
Message-ID: <20261026214359.3122870-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Central Power Manager (CPM) is a co-processor on the Google Tensor
SoCs, as used on Pixel phones. CPM supports power-management and a
number of other features.

The Application Processor communicates with CPM over a pair of mailbox
channels. CPM provides clock, power-domain, reset, and interrupt
services.

This series adds device tree bindings, DTS, and drivers to support CPM,
and several of the basic services provided by CPM. These services are a
minimal set needed to bootstrap many other components on the SoC --
e.g., I have a working proof-of-concept PCIe driver running on top of
this series + pinctrl (not included here). CPM provides some other
components not yet included in this series (e.g., PMIC, RTC).

This series depends on the bindings and mailbox-payload-definitions from
this series:

  https://lore.kernel.org/all/20261023235408.3063350-1-dianders@chromium.org/
  [PATCH v2 0/4] mailbox: Improve the mbox core then introduce the goog-mba driver

So this series cannot be applied as-is yet. However, v1 of that series
was under review for about 3 months, so I'd like to at least:

  1) demonstrate its clients (this came up at
     https://lore.kernel.org/all/CAD=FV=VW2h1zWDYWQ6LknX3O+3=EY665jde35Ly+UQzuscXy=Q@mail.gmail.com/,
     for one); and

  2) start review for anything that isn't significantly impacted by
     potential changes in the above mailbox series.

With luck, the general design and DT bindings don't need to change, but
even if so, I expect any changes should not significantly affect:

 (a) the CPM DT binding or DTS (apart from #mbox-cells)

 (b) the CPM interface (cpm_request_client(), cpm_send_message())

 (c) any of the CPM clients (irqchip, reset, clk, pmdomain)

Thus, I think this falls somewhere between "PATCH" and "RFC".

This series has been tested on a Pixel 10 Pro XL (a.k.a., Mustang) both
as-is (plus the aforementioned mailbox patches), and also with minimal
additional local patches to get other components running on top
(pinctrl, PCIe, RTC), to prove out some more realistic use cases.

- Brian


Brian Norris (9):
  arm64: dts: google: Add Laguna CPM mailbox array
  dt-bindings: soc: google: Add Google Tensor CPM binding
  soc: google: Add CPM over MailBox Array driver
  pmdomain: google: Add CPM power-domain driver
  clk: google: Add CPM clock driver
  reset: google: Add CPM reset driver
  irqchip/google-cpm: Add CPM IRQ driver
  arm64: dts: google: Add Laguna CPM node
  MAINTAINERS: Add entries for CPM drivers used on Tensor SoCs

 .../bindings/soc/google/google,lga-cpm.yaml   |  74 ++
 MAINTAINERS                                   |  14 +-
 arch/arm64/boot/dts/google/lga.dtsi           |  50 +
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/google/Kconfig                    |  13 +
 drivers/clk/google/Makefile                   |   3 +
 drivers/clk/google/clk-cpm-internal.h         |  35 +
 drivers/clk/google/clk-cpm-lga.c              | 271 +++++
 drivers/clk/google/clk-cpm.c                  | 573 +++++++++++
 drivers/irqchip/Kconfig                       |  10 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-google-cpm.c              | 123 +++
 drivers/pmdomain/Kconfig                      |   1 +
 drivers/pmdomain/Makefile                     |   1 +
 drivers/pmdomain/google/Kconfig               |  14 +
 drivers/pmdomain/google/Makefile              |   2 +
 drivers/pmdomain/google/cpm-power-lga.h       | 467 +++++++++
 drivers/pmdomain/google/cpm-power-trace.h     |  80 ++
 drivers/pmdomain/google/cpm-power.c           | 637 ++++++++++++
 drivers/pmdomain/google/lpb_service.h         | 200 ++++
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/google/Kconfig                  |  11 +
 drivers/reset/google/Makefile                 |   2 +
 drivers/reset/google/reset-cpm.c              | 367 +++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/google/Kconfig                    |  13 +
 drivers/soc/google/Makefile                   |   3 +
 drivers/soc/google/google-cpm-mba-trace.h     | 214 ++++
 drivers/soc/google/google-cpm-mba.c           | 964 ++++++++++++++++++
 drivers/soc/google/google-cpm-mba.h           |  30 +
 include/dt-bindings/clock/google,lga-cpm.h    | 191 ++++
 .../interrupt-controller/irq-cpm-google.h     |  16 +
 include/dt-bindings/power/google,lga-cpm.h    |  79 ++
 .../dt-bindings/reset/google,lga-cpm-reset.h  | 175 ++++
 include/dt-bindings/soc/google,lga-lpcm.h     |  54 +
 include/soc/google/goog_cpm_service_ids.h     |  84 ++
 include/soc/google/google-cpm-mba.h           | 147 +++
 40 files changed, 4923 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/google/google,lga-cpm.yaml
 create mode 100644 drivers/clk/google/Kconfig
 create mode 100644 drivers/clk/google/Makefile
 create mode 100644 drivers/clk/google/clk-cpm-internal.h
 create mode 100644 drivers/clk/google/clk-cpm-lga.c
 create mode 100644 drivers/clk/google/clk-cpm.c
 create mode 100644 drivers/irqchip/irq-google-cpm.c
 create mode 100644 drivers/pmdomain/google/Kconfig
 create mode 100644 drivers/pmdomain/google/Makefile
 create mode 100644 drivers/pmdomain/google/cpm-power-lga.h
 create mode 100644 drivers/pmdomain/google/cpm-power-trace.h
 create mode 100644 drivers/pmdomain/google/cpm-power.c
 create mode 100644 drivers/pmdomain/google/lpb_service.h
 create mode 100644 drivers/reset/google/Kconfig
 create mode 100644 drivers/reset/google/Makefile
 create mode 100644 drivers/reset/google/reset-cpm.c
 create mode 100644 drivers/soc/google/Kconfig
 create mode 100644 drivers/soc/google/Makefile
 create mode 100644 drivers/soc/google/google-cpm-mba-trace.h
 create mode 100644 drivers/soc/google/google-cpm-mba.c
 create mode 100644 drivers/soc/google/google-cpm-mba.h
 create mode 100644 include/dt-bindings/clock/google,lga-cpm.h
 create mode 100644 include/dt-bindings/interrupt-controller/irq-cpm-google.h
 create mode 100644 include/dt-bindings/power/google,lga-cpm.h
 create mode 100644 include/dt-bindings/reset/google,lga-cpm-reset.h
 create mode 100644 include/dt-bindings/soc/google,lga-lpcm.h
 create mode 100644 include/soc/google/goog_cpm_service_ids.h
 create mode 100644 include/soc/google/google-cpm-mba.h

-- 
2.56.0.307.g5fe7bd680c-goog

