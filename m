Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54C4749DD
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531220; cv=none; b=Q4T/BhWdRgWCfXfmwtCKm3pO86jhIOr++kKFvlSWOyznFwn0t70/Zi5RUAEshPTjKtYV8DmKYvrHFAbGQHDmWuIs+6Tjyku9ES4vl2MYArsUqsvrQGcfSPhIu8DjC7+K87QctrH9A7dFKFC1m/VgizKRxcR7eDcb7s3I5D3Rbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531220; c=relaxed/simple;
	bh=DNeUKDQc6MOqH1ADnGtMgjyCzwqfg807JsDXZXD8PdE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UwbF7FUvJXjcbX63brXUfrbuTCmbWT7zSXigQEzbHru7+egWOMoT/WLPFIhv1CNP8EqcoPgwpHzUjLBhx4YO0rntQMLC9AwILR/XVlSZiSJDQvf0lX00/m01MPuhylgiOXFsQBSuQLLkPusYWdCLwvlMefX7NIYqoLDiota8y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmEO44SE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmEO44SE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a061a13884so32577925e9.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 00:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791531217; x=1792136017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxQ45OeQSc5IyxmrCu5z0MqBw+JjYn7NVXImWxo9iSQ=;
        b=WmEO44SEUdt2owfjB9YzQUatK8n2baFMrDOnhEHIU0pts+OSglFWH4l00AqJ7kiqqZ
         0mCb3GF19TXkzwtpEd/9hotq7VKKSeQ2YmMtxHUBPydWWrJM1l6ZeG4Dlx0YhAQRXkDj
         juhg7d9BN+Y9vacAkr9kIMSLJdDuETNB63YccKnAhA9wXX0y0S0z2l9gG285C7M+ETOH
         /YdTtvmZs2J6msVcHf3yOgEpfdHYB3JrnZiJyRfpfdAEjPafsZWtikiyVn6qPfXC/ejb
         OeJbkC/Rtnkg53MsLOfs0QeW438LZk1MrUNMPiBb1qJsJwZL1V2PMdFGU87PMKPWkZMk
         i/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531217; x=1792136017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kxQ45OeQSc5IyxmrCu5z0MqBw+JjYn7NVXImWxo9iSQ=;
        b=wuWo9xcJRgE524RfUUgi7raM9Zmi7owFTf01WxP1YaEqL27g2BAL+7q2I71AmRorM6
         oUH27H92kZA9SXGftBC9IzHg9+j9k+G9+NBYH9MSszvJB+NSufNjENsnKrybXSi6mMBo
         nnLD1NHyY5c0Gv3CK/f8MpDQBLnKJfLnKyv49ImY4R2+txmzGL/IaeVlLKhvPIQ/HmW8
         dSlfvjeeaAkAvqxbr7Tbm5IZagoQJPKQ7D3IDcJdPN/eccT3qvqHUP2cAtlC8YkKmJo5
         XbaeOD14twGn7dhA2MA+NQ3hArTYnlgCax7TiJN2LUPmy3y3q5oSJOdkn4jWNEo/aBQr
         8nTw==
X-Forwarded-Encrypted: i=1; AKwUvBzJB/oxuo1BLP2PL1zX5CBf1KCjo1pHY6ia7W5YyPkM+XDh61kFzAbSf9uNjMdB/fbkrNWqA+eomQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m4K+Dsk083zxgm4Oh8m2r6wOsp1CnpX4av7YmF+oBbY/XhjbV2
	2YgnpwSNCj3wX72TV5CVn8JACxzzfSyMPrgotWm/KHJL6MDmEiWqfU85eLSBvQ==
X-Gm-Gg: AYBFou0muTngYoA5LBGlBawUtolmhJHy3COT887IUhYvuhpJBOC+GqEP3qffciETghX
	hc7aYjubjaYWb9w9FPyUnBAKP+CFHNdkswUnBpcSnKGL/XV1caf1qMRZ9qolTSpfo9ITtW9oBPb
	njdTLerA08gSdHMsfkY0sU7OAlq8npEGS2K6hJUgFt1BU0ZlDRYUFImkIbVb13aeJZPyxBv+5Hq
	if27pqb8vHiHtpOsQBYJw/sQHkjC0pnlVd6CWsbB+BMKigxGQZFRV9vG1cIGNwZOrWobfVfeqf8
	s5lyXQx2Xghe3S0FniARNqESq2vs4b6B65gXMci75ecACCn1d10YyInALj3wkYjlzchNsR59xrM
	RNrZz048OZVzLut45qf4dxZJVlhDBP81C5nqsudykR7F91Zv0lkVO91V/HU2AZoCNHtZVPkT9qq
	B6KImN7+wMQYHKjZHuWNTGrdBDwvVF+sTzNhZJcikwTfSH0aVRz7jCXv4lW6kYJK8FIi4ztlQHH
	pnKRYZg1YWJavSLIExXqj+3MyMgXjlOlzP6IIxtJeq1/cl7HOsrI9PYMISKMUaNZ/EvM68/DmTA
	Qzl9Z1UAiQHQFkxS3w==
X-Received: by 2002:a05:600c:3b29:b0:49f:ce78:3561 with SMTP id 5b1f17b1804b1-4a18e49c420mr17004555e9.18.1791531217099;
        Fri, 09 Oct 2026 00:33:37 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a18be96549sm55116365e9.6.2026.10.09.00.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 00:33:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] PM / devfreq: add Airoha SoC Subsystem scale support
Date: Fri,  9 Oct 2026 09:33:27 +0200
Message-ID: <20261009073330.18175-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha SoC contains multiple subsystem that are scaled to a
specific OPP taking the CPU clock as reference. Such sybsystem
can enter idle or performance state based on the system load
and power consumption conditions.

Example of such subsystem are GSW (Gigabit Switch), NPU (Custom
Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...

Changes v2:
- Rename to a more symbolic name
- Address some sashiko bot warning
- Better describe the use of this devfreq driver

Christian Marangi (2):
  dt-bindings: devfreq: Document support for Airoha Subsystem Scale
  PM / devfreq: add Airoha SoC Subsystem devfreq driver

 .../devfreq/airoha,subsystem-scale.yaml       | 114 ++++++++++++++++++
 drivers/devfreq/Kconfig                       |  10 ++
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/airoha-subsystem-devfreq.c    | 100 +++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml
 create mode 100644 drivers/devfreq/airoha-subsystem-devfreq.c

-- 
2.55.0

