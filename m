Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25385C4A
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774764939; cv=none; b=rfp5PJEPU/vlRUVfMenKwFnqdNQeqpVKrqPSTQJcxF50NLkqmfmsUiAP91uh+a7Cqg2otsOt3bnKCwujimqXxKbBiLWTaQArHe3GhBp3/azNT6ehZoO0NO/iXZ3YgXWz58YLaEYiXSwiQKA+PTLZcch6ysqpz3LeSVm9hbV8Bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774764939; c=relaxed/simple;
	bh=tLCX5T/5BD+D5hhrc5IQpY464+LnQSj92xbe4tJBm+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjaHeZ7yENIUTbXg5wNzESZwbzmlsOJIq2EGLeVJlRWIj+7QWIUyyDkAfdQ4H7L2CwlxnWlDaw/15BVoW7gg5XgTBC5vfWJnh4pJ389ZsDDOLx1qUFXNmMOuFqHuewVS9FBkeMHCdDbgKDdO1lz5vjURBruuhNgF+/wsZdI8Eo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a24G1ZOX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a24G1ZOX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82c2239140aso1377574b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774764937; x=1775369737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpxvjrCfKfWKOT/ha83hU/ESLCv8PWJ47jL6ccG2o9A=;
        b=a24G1ZOXgYDETqrQfPOkz/XkTO9l7DT22yrEtVj6ar8rE9XHLMY5ZuXDiUaAhSeRKW
         g3T9A7a2SOKQDQHsZ9rUL4b78zgqWqNjf5QNUoXfGP0dCj6k8EilnOMMawh+lPQmMxW5
         GINVVHixO0PSTZBmYQ2h9AN+N8whiyN9kvPG0dNWuD9X+Z+JNVLQz1Vhq+17QjHAZOjL
         zM7X96i3WUsNmv4S57a3xCTVfHENFsXjOZwFmNKsl+mbkeUE8BJG66B6tcnqQLmHYcQr
         IveRTsnZjo/DOB29nhVipmurGS7jJWRCnYWZvT+3ZtMDxD7Mq6zNR3UhQ+a4b4zK8WjN
         yZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774764937; x=1775369737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpxvjrCfKfWKOT/ha83hU/ESLCv8PWJ47jL6ccG2o9A=;
        b=XOsBuYPqXZSiT5BBawxEOPslC4I5uLnSHL+I9625FxJVwW1syKNRxDcCBH5z8Mb29t
         p45mjPpimgiAFMwGzSki5fFFFZ97b3oHtA94DMNoPIOe1D4j9kz1xLX4Ha3eBZc9jdZk
         Jud+/RIywH9eZqPdAwc1su7HPboBF0avmULReI7IqEDCnxVMuMv8g9bW7F5uShx7cRL/
         3mwsQFMM3SWARIHRyHt6w9aVBRstmQxZ86aenWebQYLS6CgaOHlPssbeaLN0yn9MgujC
         0m1o8FQwOnjEVwY3snOYFYdS1jAQc5LmxP4nezlZuZHhJQGsVjyPMh5/d1O6c7jL7W4t
         +dRA==
X-Forwarded-Encrypted: i=1; AJvYcCWTikmQeCDnLMwR3ljXul6Dr//2PZG0HvCj8Aawp8wRE6KHVD61gd0QDv09ocYEBokwhOSZdcZ82Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJ8kjy2b2KJ+6G4RrzXGDmGXRjgDPjIYYVtwUsWoEErvsWK+5
	JHu/oyBeCqXPbWUe3PnKuYAGUwAh32l2ZfyEkj02lktUxgO947NvcMfV
X-Gm-Gg: ATEYQzzTXjnJJmfhr5viZXJRXDPGmhvisG9LrJ7yCd1MB/FmlSFNN/I3CPPwdTzoa+P
	TWIDc5Rl/CQw8IaTeDSlewo3qre0I3ydWbjE63PVIVuM4Gihtz5ItMrs1G6a9IT3fnUu8mEhyxG
	hdMTdcxKPJgniD3QvPIfI5k84nzCVIDGVkQrponffvUuPKob7uz4NGZUwjXoAXaPUwDCziIgRtL
	WrhfiiJMP2Wx+tzpBb9V9k3arghHVAB2Q3oZ+U48xduKzVVGK7eSU4IyZngGL29lD0QOc0vz5g1
	OmxHYhjhNDH5TDFMnDSuAj+v7Ma6noTYW71mZ7y0SposCMa2ZsL1A+b46boJydXcdTmaaJWL9JT
	UKpFbkYdQZV9kYS6BJx6pJdpXnFI3Xnb/gS0xQLxDap9B06hKdTQV4/e5XimaDKhSwZXzKzOiul
	taszQ9wZkQJegmSKkfVB6h5MrPwCKgfq1Qo4To7SLlP+Bxseta8SwWXlRd57aF5tDRO+I88ChmC
	u1BX3JhVBfnbg==
X-Received: by 2002:a05:6a00:3e16:b0:823:b1f:892e with SMTP id d2e1a72fcca58-82c9607f5b1mr7817427b3a.43.1774764937194;
        Sat, 28 Mar 2026 23:15:37 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8436f19sm3709731b3a.9.2026.03.28.23.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 23:15:36 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	vireshk@kernel.org,
	conor+dt@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com
Subject: [PATCH v2 0/2] dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
Date: Sun, 29 Mar 2026 11:45:18 +0530
Message-ID: <20260329061523.98346-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series converts SPEAr Thermal Sensor bindings to DT schema
and corrects the thermal_flags property in spear13xx.dtsi to
st,thermal-flags.

Changes since v1:
- Changed unevaluatedProperties to additionalProperties in the binding
- Reword the commit message and subject in the second patch

Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings


Gopi Krishna Menon (2):
  dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
  ARM: dts: st: spear: rename thermal_flags to st,thermal-flags

 .../bindings/thermal/spear-thermal.txt        | 14 --------
 .../thermal/st,thermal-spear1340.yaml         | 36 +++++++++++++++++++
 arch/arm/boot/dts/st/spear13xx.dtsi           |  2 +-
 3 files changed, 37 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/spear-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml

-- 
2.52.0

