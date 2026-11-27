Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791277;
	b=aKibPqVbBjk1qNj3h8IErtRT+vH0ZLYA8ETSI8d6/nESai7xBqhnnwon/gHaq6+Uy37G
	 q0iRZlSKBrkE+MVR+L1m3vXloP89Sn+nSbO5mfrygMmW1ykMtnrQ6USPtFTklyz6hQcQI
	 kKs2bwH7pGK2KPCElItz376fpn04jZI1YLKeP0PGgGIXZ0hvMKDBK1W8RFu1MyZVp86e6
	 c/tqedV6SIYHjwLwv9AYbpBDinJQqzNgv5vquL+KLJAE1SVsUpX+foRuEiUQehOL/zGSD
	 TMQHIDvzn00SFxphHrmw+XUvc9yrJxYCpcbRGKgymsQst7m98nkq5l0VEum42FekteQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SXH1zIVRj+Q3VwOmk7BHfXhp1QrzFmDJnc3rVMFxfIc=;
	b=cjblsIGLv8bzKjWodJMJm+meRC3EGYAbxr8NXNFGiKolwa2bHAq3Inn1372zdWFN+Dq1
	 +t3M4BshYX9wliHtZfRpBRr/jcsExqPgwcyV7FHqtW2IpEllq/Jb7lnNQs7SS1oPu3Qih
	 EloQ/xJkgx8l4cZceHm+z5u7yR0aJ31HpcDqJzPpuGjeHgEYcc3MzzPk/y3pzzAHz4IVX
	 1gmSW/RdbRz0aEOgCrQB5UEYS/BOD4F75MVPQESt5TLKGeZhnCvZLHh8Faagy1iB/3wJv
	 kV943B1VdLsR1BuigW3IDFvIc93elsjc76+qj9knX8hk9MDQcO79u0s+AT70Ypd+jyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fOjGfMnF;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA210606A31C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA210606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fOjGfMnF
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491971ac844so7242950f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795791275; x=1796396075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXH1zIVRj+Q3VwOmk7BHfXhp1QrzFmDJnc3rVMFxfIc=;
        b=fOjGfMnFaW36gM86CXslowU1BzK/v4A+WDcBbTjfhZ+rNc72cdan4L4cfify1+1saF
         DBHCatuJmKztS6vCn4E1yTcWKWoExE1dRi1DFsueQ4VYUNkqJyCxRVd+SvZDxDQKq8Rs
         4UQu6StiJokIcbadYqyyxNKMMJ5SEqd2LI+1ZfM6CwViCTVm+LjXvVoqeo275KkFJfM7
         e8CW6QTpKsNceMfaphZjXDbjhZFtDLSxNlbjn8D2XBFcphdV4ozlL74UfjvqMNED2yTz
         tPkH088xEFLatv8lS4Gsm6dyKMmrq4s814RuxU6L33x1WdxbV8ZEXOCczqDs7k7U9pQ5
         BkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795791275; x=1796396075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXH1zIVRj+Q3VwOmk7BHfXhp1QrzFmDJnc3rVMFxfIc=;
        b=BL76+33QH62po6pPvTJhaOiFkAHRPDaX15BHfe2/nTzMppUc2/Vy28o0G1swARrOWA
         judcDXKtRAiw7QSvaBd2dvPaln+mjrcNI17XH442hcogCC+0DyHiO5XVo9AumGlHtHRF
         daL3p9t7hAWPO2kAsjHa+Eym+hth3gd9kjwFDzs1K1QQ9Nyb4DijJbCTvOMh893DtW3S
         NiXVyePKw7JnxIz9EOdhUV7e4VBLAE/TpIGnRxguAztHzNPDXeapwB10BMpqpmZ11ABR
         qGeF8zzXZ5/ahjy46jL4Vg0vuix/rQh2DGSeIc1hAywymlbM5WHrJkPKLWqyjjurtQ4C
         UhDA==
X-Forwarded-Encrypted: i=1; AL+hErEGFhlQqKf5gQQoJOfpCjjmt5TYwg5osTuXzPlFSgv214dIy6jkU7vT40xiAFNY7VMOdEUgauXLQw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+8DkPL7iJUIaDGtgmnoEbs9ZH1GJr/NAc83BVpfLVLMZzHwQjW
	i0erClS+qy0UFodOULWx6yJYzIJDYp9xBFQEiGhW/ZYRs4eW5iIqHyd0
X-Gm-Gg: AZFdTZfGAFbbr60NMGXt1GDGhZxyjaMxw+hqZif+Ks8l0mD3ih/39GkWly/KZVNJPei
	lbRclEFxiayItP9IXyte7xrwrz0Vz1j6E/ZtHHBlD2MCKUILvB2n1R0uZoyiKyqiRxH/1jf5Khr
	gYUGf3pSbyIabc2FtqqBPfdpHyavGgcHXFN+PKWQ2HOWWngrqDhq4lAvvg0txYwoU6IUs2uFtSF
	Zzzl+SkQiz5Cv2+XmWeyTT0YkyTRwqsf67VVuckg8iLCsPucoHkQ6TSektCtri1c8JLMQ0VuNrt
	EOGx2tML6oFrKtmCuDwR67TIEByQd7EIWs4V1/mlSrnauyVn/w7zZa2wdminXQq1ZElUxU/+p2k
	EVNPk9znf9v8TMxBo1mV2fvEvQ5BtDKZor5L627ftY+lO31GBDeuyZ5y3sAA3wcbRxF4jbyhPl4
	Nt6jvum5MJ2ESCu7mfRz7Mo65xRnYa2Q5qNanDWUXlamPzg7IgS6oHMCuExp8SyyQb9p7Ns/PqQ
	toOoqq+IkvXmTvzFj/FuHnilY5Dd+onsrK/E6KW5IO6wt1Vo0ocGf4YR9VvJXGY9oWtX5ERdISQ
	+wlsPp+rApO586uYGg7QGWaMTjqKF3bAKRTBNUwDAaCqXYg9kgdpA8OiaV/fueHU++Ubz0V0sr2
	jAHI=
X-Received: by 2002:a05:600d:a:b0:4bb:aa4f:c01d with SMTP id 5b1f17b1804b1-4bbaa4fc151mr122964855e9.1.1795791275057;
        Fri, 27 Nov 2026 06:54:35 -0800 (PST)
Received: from emanueleg-nb (host-87-4-46-207.retail.telecomitalia.it. [87.4.46.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm633589105e9.1.2026.11.27.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:54:34 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Rob Herring <robh@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] power: reset: tdx-ec-poweroff: Add Aquila IQ8 support
Date: Fri, 27 Nov 2026 15:54:22 +0100
Message-ID: <20261127145429.2060162-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The Toradex Aquila IQ8 module has an Embedded Controller from the same
family as the one on the SMARC iMX8MP and SMARC iMX95 modules. It
implements the same I2C programming interface, with the same power-off
and reset commands, so the existing driver works unchanged through the
toradex,smarc-ec fallback compatible.

Patch 1 adds the toradex,aquila-iq8-ec compatible and updates the
description.

Patch 2 allows the driver to be built on Qualcomm platforms and updates
module description.

Emanuele Ghidoli (2):
  dt-bindings: power: reset: Document the Toradex Aquila IQ8 EC
  power: reset: tdx-ec-poweroff: Allow building on Qualcomm platforms

 .../bindings/power/reset/toradex,smarc-ec.yaml        | 11 +++++------
 drivers/power/reset/Kconfig                           |  9 ++++-----
 drivers/power/reset/tdx-ec-poweroff.c                 |  2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

-- 
2.53.0

