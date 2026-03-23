Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4F3AB282
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273111; cv=none; b=jolL6dqVBgBTJCDuczB5lHF8kMzi/g87H3wIs1MDoEOPiACr60neCl+iXeVMdgFkeUuMNmn3mOPGocZwLnzI9E2bqKYexaI39SefdGkFN00/6z4i+kpjwEGRg6P6h+XiBpiTZdFvh7yKKstkv2rOekKYUcExH7UMjVaWw3AhFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273111; c=relaxed/simple;
	bh=qsIf7ud5Ph6QqblFlecYc9fYw1lGDBnS/dITukEPMTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6Ph7/pV1XMl+9N1k60X2Hc9Ts4EsHSGLbmqRzDxiGI5RRClSs0bErZSvXe+9Rzl3ExgAWFiwKrZkFgot8eHIzhWxdMZV3IJwfovqzQZjD8tf8UrYUxvfkT44lkqn5zeUovkk2gIYIszkHc32d+BAP8C4TW5gzlcQDLQjgJwrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhdKisud; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhdKisud"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82a893d289bso1508505b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774273109; x=1774877909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn67HXpA7zjDtiRyKaRULlABylDK2UruwZzMMz6sLEw=;
        b=EhdKisudNMpu52WQt82xZBuhjmpsHFgAdupV1pcw1o9aemnE8Cd3AAgTW7e2Yv/lXC
         DAKWqKhBwLQsRPfhY4kqrKf0BDHrpkR2/QnnAaiaqw+7oTprRgnRiJ65Lb6OVu/etJa3
         kwHHGasgaXrkUydgwgFcLcZh6xxfJ3z7wgqObD2vy/YTxdhqDxB/35rREkrvFnaJHGoW
         SMqog5HvvHNGFMedIcQg8VJIhvGqsBxQxIPLDbBFjWO4ckjlK8pzAOZwZYQ6rs0avISX
         HNO+PaxY0Rd+exhBxTX5gtHgtyjh6zvJdanHrbiOCRTULynTYW6CPbUmsWOt91vTMpxG
         0KzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774273109; x=1774877909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn67HXpA7zjDtiRyKaRULlABylDK2UruwZzMMz6sLEw=;
        b=cHYIEV7X8XaRJWGuvpphoid1GiJLXel+4tAOEQ7A82Pl7aEH18RUCzqYIEJA0J0ZTs
         whaUCYL/S0iGr+o2Q2euxKOWpevqRB3coIxvEznFLto8WbDVbBy5R8pXfPg9xGGcIK5d
         V0QUOv4k1+5xLMTuQcod8J7zVJ3E7EbJdDjYNQZ/YPXbfwWl4zBQPuuOQJqlM5mXFOlZ
         PGXv9Z3kWtJjXEyzklm7a980XBVS15DpQa68uhn+rSXaxMfQsbyR4RpNBLeG0AvhRdoA
         +YkuqHXEjQdPvVmNLRZudTzWH1A3JFPMwDSiifG73MbdRzeH62L8iiqE1goA7ldRlktW
         amzA==
X-Forwarded-Encrypted: i=1; AJvYcCVsqswLR/8c9/V4N+bN39dj3G3G8Bxbu+Ns+Z3I3sHoI90U8JinzlMcypxhnon4EmaynZDiqyCpNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyagE8jLmexB5OMPrrFD/FjCetxSZWpDYavQMZE88XdVjFo7UFV
	FW/TrjJUE78tDMIX8U3XWUQQag7j7SZEJHdCFc3C+L/U+3jtA6ooM6oe
X-Gm-Gg: ATEYQzzaG1Z6odOvQA54ILf0rV3DaHQek4bYnsOKyVk6FNPo5HAWJFJk3cQyuqG9PCq
	YdxSc88fEpHNyUNURAKI6V4u5c/AO8jzc1MU5SAnNIjy+5EG/BRg6y5j82O7NqzCefws0DTGREM
	XhSBj5dwVzHZBwGAJm7rSPiobFwyJJ28wpCNFCs6OBS7mRLFNcNi/Uau+nhrFqjvhjGB8buiYcD
	l92ccJk26jH5/E0q7+bYbDmZvHD/6baAWl6h+jaPfkPZUyFx2Uvy5RzmOkO+CIxkVZDBo58YlXe
	lF2jTUuSZr90w2ac4y0dfMS28LRW78fNzxrJBCUUFzf5CHkEbvF4IBwHHVPE2o0dmwCEjngvXoJ
	RgKDCAEsTH9Vi00o5xevYlxGe4uPpFGlUr9YruHifvJzyieAY3tNm6ClDxgSTe69KA8QFD0uyAP
	cM5vmBPz6AWdfAiwWH8FbEkeq4mT3DZyD05/IVMEDP5XgRgRkYHokBqnJQv4RETXZx1oVXvZL+T
	+Q=
X-Received: by 2002:a05:6a00:10d3:b0:7e8:4398:b34f with SMTP id d2e1a72fcca58-82a8c301dacmr11323142b3a.34.1774273109336;
        Mon, 23 Mar 2026 06:38:29 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm12069224b3a.57.2026.03.23.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:38:28 -0700 (PDT)
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
Subject: [PATCH 0/2] dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
Date: Mon, 23 Mar 2026 19:08:07 +0530
Message-ID: <20260323133814.14152-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series converts SPEAr Thermal Sensor bindings to DT schema
and renames thermal_flags property in spear13xx.dtsi to
st,thermal-flags to fix the unevaluated property warning in
st/spear1340-evb.dts.

Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings


Gopi Krishna Menon (2):
  dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
  ARM: dts: st: spear: fix dtbs warning on spear thermal sensor

 .../bindings/thermal/spear-thermal.txt        | 14 --------
 .../thermal/st,thermal-spear1340.yaml         | 36 +++++++++++++++++++
 arch/arm/boot/dts/st/spear13xx.dtsi           |  2 +-
 3 files changed, 37 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/spear-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml

-- 
2.52.0

