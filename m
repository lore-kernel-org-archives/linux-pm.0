Received: from outbound3.mail.transip.nl (outbound3.mail.transip.nl [136.144.136.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4E37C930;
	Wed,  3 Jun 2026 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470935; cv=none; b=q+q29pz/9dkSRiWBxgj40hF7+6GUwzp27YlxWswSL8pzkDQEMg9XVQLEyyU3cFtatfP9NeUUBFprT+BMylffEAb3mCEop9D5IL7mBJNn0AaEhfTT9yDQ65nEq5DK7HqrIQkUa8TyUj8BfLoGjc+5qzGkflnI5toEG2SGSkPN9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470935; c=relaxed/simple;
	bh=5rJLmehv28yHT0ypBzvBIo10EXIGQTIx2wLs7Ssr6w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6JrL7G999lGTNIJpoKYOen3bWK7VatXd8abq2mLeJXeUu/IpLDWZqb4eIqkNINwwGSbHX6iy5BmCR7kH301QsGezMEYFdcfq6+dg8cbsFoT9APNXRPOqy4/Vl/NVPH9IGqj2A5+jq47mwiIcoIs1iPrqUxqTmVYDw9IG42pt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=tu6SXJeN; arc=none smtp.client-ip=136.144.136.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="tu6SXJeN"
Received: from submission9.mail.transip.nl (unknown [10.103.8.160])
	by outbound3.mail.transip.nl (Postfix) with ESMTP id 4gVf9P0069znJLQ;
	Wed,  3 Jun 2026 09:15:20 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission9.mail.transip.nl (Postfix) with ESMTPA id 4gVf9N24GJz3NZKgZ;
	Wed,  3 Jun 2026 09:15:20 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: sre@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH 0/2] power: supply: max8903: add GPIO-controlled input current-limit
Date: Wed,  3 Jun 2026 09:15:17 +0200
Message-ID: <20260603071519.807604-1-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission9.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780470920; h=from:subject:to:cc:date:
 mime-version; bh=6Yz+cmiP1HMDegbpmFhnrL2p3f/rJ9xArQXe3nE2oEM=;
 b=tu6SXJeNNzsO+57Mb4fdaTm3qVoVyK+OvWYXsV/sT/vpxS0H2udKRyxQ812V9CxOYZUrOU
 NDg7q8ApaEEdK5LMcbyxkRUxRO+aa4vVt8J1ve0HXaDTyJBQK/yeD1tMqk5zXIN0KRBZLl
 wYADt/Kgk+YfmKUI8HXOe62SnOP08QoCcfEWq39yhfoFL8rwe0zvvhfg4nKlbwHt2yzEVc
 h3b31+9Hu2XS/n7wHUaye2IXlmmMJf4q+LcxYGYj4stzhCzFJigYNEh1apseFE9WjIogsf
 tw/uP/zkErWJDRpJ4LfIXV1QI23rFwwg1TakiNyJl49qvKCE82DaxJCpjH1L+Q==
X-Report-Abuse-To: abuse@transip.nl

The MAX8903 charger exposes two hardware pins for input current control:
IDC (DC path, pin 11) and IUSB (USB path, pin 7). On many boards these
are driven by GPIO lines to a resistor mux or logic selector, letting
software select the input current limit. The driver currently has no
mechanism to set POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT at all.

This series adds that capability via two optional DT property groups:

  DC path: "dc-current-limit-gpios" + "dc-current-limit-mapping"
  A 1..4-GPIO array drives a resistor mux connected to the MAX8903 IDC
  pin. The IDC pin programs the step-down DC input current limit from
  0.5 A to 2 A (R_IDC = 6000V/I_DC_MAX) when the DCM mode pin is
  logic-high. The mapping table (uint32-matrix of {microamps,
  gpio_bit_pattern} pairs) lists every step the board supports. The
  driver picks the largest step at or below the requested limit.

  USB path: "usb-current-limit-gpios" + "usb-current-limit-values"
  A single GPIO drives the MAX8903 IUSB pin. Logic-low selects 100 mA,
  logic-high selects 500 mA per the MAX8903 spec. The two microamp
  values are described in DT so boards with non-standard IUSB thresholds
  can override them. Requests below the lower value are rejected with
  -EINVAL rather than silently programming a higher-than-requested limit.

The dispatch between the two paths is guarded by a new mutex (source_lock)
that is also taken in the IRQ handlers that update the "source online"
flags, preventing a race between set_property and a concurrent DOK/UOK
IRQ flip. The IRQs are already requested IRQF_ONESHOT so the sleepable
mutex is the appropriate primitive.

Motivation: the HP TouchPad carries a MAX8903B charger with two TLMM GPIO
lines feeding a four-step IDC resistor mux (500 mA, 1 A, 1.5 A, 2 A DC
input current limit) and a third TLMM line driving IUSB for the 100 mA /
500 mA USB limit. Without this series, the charger always draws its
hardware-default current irrespective of what the USB host negotiated.

Both patches are purely additive; platforms that don't provide the new DT
properties continue to behave exactly as before.

Herman van Hazendonk (2):
  dt-bindings: power: supply: maxim,max8903: add DC and USB input
    current-limit controls
  power: supply: max8903: add DC and USB input current-limit GPIO
    controls

 .../bindings/power/supply/maxim,max8903.yaml  |  58 +++
 drivers/power/supply/max8903_charger.c        | 369 +++++++++++++++++-
 2 files changed, 416 insertions(+), 11 deletions(-)

-- 
2.43.0

