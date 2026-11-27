Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818777;
	b=h5BuoAXoX+le1w8FsPkPDO9/l1e9jgd9hjr6bd/yiaqyMi9TWlLFDNi4UTmsl5hHsYcb
	 Y7FUJ6qSNXWZyfpZI5obISLgzsyN9Nf6QCXoWMLqHi5mux5BAqnFtRn39qyPEv/uJwEks
	 FPxVUDy3KCQ9ZCvBCpG0t5yzf8deGg38y9qZx1j4fNYCAeUon0bhbNM366JYgHF3F1Jlp
	 HFCSJaSDEZh5xMwafRCdjTHRxsubQnQcVQ8wCRl0qqwHyBQRjy7gSlY5qs8sUX2nLtUSq
	 ITygPZZHEcxpC5a+ZFc/gLiLnbMsmqgHc9s0/p3oPjlfO8JpivfvyrBIxLvEedHgJxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=e18q7m+XRgO8UtTQ6TkOW3EX1GONk1zjdab/Y9iIkTw=;
	b=oRW+XK+hUbZWa+o6UMcFTiQqatQAzn3tGJAwbghYxMi8yQYevWhiuBv0TVe+OYINEhmt
	 UZC7nrXujIheec4xlB/1jj/TRtaV59/ZdCp5K+Jm4eecNQzjy89jXX3X0e8uFJ67G6Ygn
	 j55lY64BAqiwAwmFTAYeX8WjBg8gI5QBu1CJH05AiHwaM5Dh0PVIzBqNNYSitM/g0W03J
	 mfkmQNV5QGXV5MadzvqTJejWwDIgmktTEMhL1orJqegf8AuQc7xCyR2t3y9IiTqX0ikqt
	 TN+l0OPeFvYmza4yXSNWa8sW5MaSzvXZW6fDscuQpqZwF9LyFlDLLWjrcfDVsymrhhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KXbz5l/u";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D9606A31F
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 22:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9D9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXbz5l/u
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a9be758734so5385096f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795818775; x=1796423575; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e18q7m+XRgO8UtTQ6TkOW3EX1GONk1zjdab/Y9iIkTw=;
        b=KXbz5l/uODdnOEfSJoNmxfbMA6pMr0YlR66YwD+IB+sEF0i+m+7C+RAxhLyF+SfJbd
         uGJvqUYQRf6EEBoj3BV1n1MD1T2kbbzaipdHnEbFpd97X0el041kD+NYxV8xV2M6Aodz
         KXmHk1p4QZnCdxKPEE0/uDlmFu8NUC6vQDp+XVKM3/TyEnLfD5arLsXTinq019BnJXZ2
         +UoG7nctxn6EsFi2a+RR7zLyC2gVyDadDvkDyC/p3/DjPlgugXiqmKZHV1X1MKvcAZPN
         bcxfO0vexWyZ0j0FpOmMvIm/aNQhTMELCrTP7SxKDl8ixrBZc024O09xabaaEqdrXtyF
         AsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795818775; x=1796423575;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e18q7m+XRgO8UtTQ6TkOW3EX1GONk1zjdab/Y9iIkTw=;
        b=CLmesadsj1+tchNObvhfyNmBHZ5ewK2/Tl5xl8hkrvtMUDLy0/nFwXmV+DLrG/gMjt
         J/bvpdmwx1M2sZ/knTi9dId/QGKcLcgvNrtX94tEkRgsQvLIDuj5ialrAWGe/yH6qjU4
         smurAtnjLIfombyuGGmAr6mR6/6Cr1CJ7W4kAF7128kcOatLfeSfKKQeTMag1bFXl55m
         EOa/hIXx0AonqgbOZs+xCKNd+OJBdReQXQyT4Tc2KKq16motEuxLSyQnLFvjxdUx59vX
         HX/Pl3eNZn6fUr7/eV2MNyJNJO/LA8lkP7SWGyaHEIVS9HKvKXQP67K9whQLm9EfjG5/
         ns/Q==
X-Gm-Message-State: APuU4Z8AJCLd9Us3UDM1TFmjiOt77T+qvgDO3a6ZEIJFO8VZBb4d2Mdg
	+eMLHUDTBnO4yxbB3kbf4UCJWJQVZbhqEnxz9mik3XdktAsOZJB0TDEilBa5nrrnLYeFTA==
X-Gm-Gg: AZFdTZera9iok1YS4KoF+FqgBwWXaxvUITzPdWo/5B24/nJzxJi/gGOhGUIU6zm3nNo
	PhhPMe48nJIBKWuSDPMIy62h97NOykIMx7aUxToLDmAK9F9XQL4TkEknK5vBpAXkInR9K4ltOy+
	LOcFg6SblJidqsGyt/ZzeeWQavOQzL6dtEZabGGJA7kpKGitJuaXUl8qqe34tfPb5NnEtjQSxuH
	GVmPdGCFpRX6aqGkeFaZWJ2gXa8eagDn8UvJE8EGEknOy6aMXpt9XhrInZ3D6bs2G81a/OHPxwt
	0beQqzdugNJkK59WSnciQexX5zUxZElwhMGeOxBkirCeBi6DS03Oa7URb2gtj9kafzty9RW1Ykk
	yB33rIo0hD1gwn96XRRcRmR7lxvZ//uz5ZwrVyyRMx5P37sBqhO0Zwn6Y8dReV5AacqYQiAvDst
	BGtEuSvZ8VZfyIHvTfV9sUtUIzU7TjL+xd9FRtPfwU0eUghQe+AYZ//sX09CSVMtnU+hJAxh6dH
	YyeWxofg/fBwMzqZXqe+NeIvxocxnoGKiwY/YaoaYKsbo7LRdXEqlfHq2rM33tkk5fX6bBxxtgZ
	00d/tZRbXb0exHdslbeajzGNSicxIynIHJQkSkf+b88MK3gkzZ+ypcc=
X-Received: by 2002:a05:6000:2883:b0:4a4:39bb:970d with SMTP id ffacd0b85a97d-4abab02c469mr49831115f8f.2.1795818774858;
        Fri, 27 Nov 2026 14:32:54 -0800 (PST)
Received: from [127.0.1.1] ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm50430285f8f.20.2026.11.27.14.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:32:54 -0800 (PST)
From: =?utf-8?q?Adil_H=C3=BCsrev_Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v2 0/3] power: supply: s2mu005-battery: add S2MU106
Date: Sat, 28 Nov 2026 01:32:52 +0300
Message-Id: <20261128-s2mu106-fg-v2-0-2c3142e05aaf@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OQQ6CMBBFr0Jmbcm00hJdeQ/jopQpjKFAWjAmh
 LtbdOPyJe+//A0SRaYE12KDSC9OPI0Z1KkA19uxI8FtZlCojJRKi6TCKtEI3wlNyruquqBrCPJ
 gjuT5/Y3dHz9Oa/MktxyFw/BxCmLpI9m/qDRYV4hYnrWWtRFSLLbloV9TPnTrguWhdFOAff8A/
 VES0q4AAAA=
X-Change-ID: 20261125-s2mu106-fg-5e2fc4490cbe
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 =?utf-8?q?Adil_H=C3=BCsrev_Tepe?= <tadilhusrev@gmail.com>
X-Mailer: b4 0.16.0

Add the Samsung S2MU106 fuel gauge (found on the Samsung Galaxy XCover5,
Exynos850) to the s2mu005-battery driver. It has the same direct
voltage, current and state-of-charge registers as the S2MU005 but no
MONOUT averaging, so it gets its own compatible and match data. The
XCover5 does not wire the gauge's alert line, hence patch 2.

This supersedes the standalone s2mu106-fuelgauge series [1], as asked
by Kaustabh and Krzysztof.

[1] https://lore.kernel.org/all/20261117104328.1176951-1-tadilhusrev@gmail.com/

An AI coding assistant (Claude Code) helped compare the register maps
and draft these patches. I reviewed and tested them on the device.

Changes in v2:
- binding: add the compatible to the enum, no s2mu005 fallback
- shorter commit messages
- Link to v1: https://lore.kernel.org/all/20261116074000.355176-1-tadilhusrev@gmail.com/

---
Adil Hüsrev Tepe (3):
      dt-bindings: power: supply: samsung,s2mu005-fuel-gauge: add S2MU106
      power: supply: s2mu005-battery: make the alert interrupt optional
      power: supply: s2mu005-battery: add S2MU106 support

 .../power/supply/samsung,s2mu005-fuel-gauge.yaml   |  1 +
 drivers/power/supply/s2mu005-battery.c             | 71 ++++++++++++++++++----
 2 files changed, 59 insertions(+), 13 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261125-s2mu106-fg-5e2fc4490cbe

Best regards,
--  
Adil Hüsrev Tepe <tadilhusrev@gmail.com>

