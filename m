Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454372;
	b=rELDEV7mRhCwBgUWNJIKljJH97oPMG9FZxsY9BLL/rzxmE2hg9/DLDvWUeC5EROWcr88
	 hUsKo7bBjl2YGnw4/Xwy8f4nuQbWf5uwZXH1OHBEfV4x2e2ArPTSfBorwWbf+9Y5h5Cde
	 +ssu9xqD7lreebHbrzpVSR/wTw5VyJdyV7gu9T+XiCXmLW2eiRaeNJqU8WoRqxBSAdTUc
	 GQDZHyHdDQOGKlq2EFIAwAE3ZPkP+R1ZHiH6nhQ3mYg8VTTyDCVx/GtxuXGS+e/uFVZ/B
	 WzAxUzRl7pkmRoRsjUYDNWAco4vic3JZ6kF4GFV77n1yWmLTcKzDgHj6XyFqbkF2R/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pl5LlU8oba1tB9cYFDtFrGCDtd6q3xDmJZtY4vUlwMQ=;
	b=rXDuO+wNnnTR507XzIwkJO+e2PXJ8MZebrqv/KlhLw3N5Ak4xuhz6i4hHYasZ+kw6ZNF
	 DUfrJ5uvZDgQMJXLWF79XHuO9dwKZ2L2N/PNK7yKyFwL3s/8AynBLrwPwDxKHn2imogSo
	 Bjqs507WfVTOmQxyI+909NOhmtF3uVZZLaYxx+ut6Pxp6IwUsbTo+R+MPgrY6hnG7cfac
	 TIV8X5iuaDZtKsqnR8mm0x23MdAv3B83Ktke/1x83KiBTknQ/P4cLbbX8TBGF/WHjCwKi
	 iIOTLeUkX4biRmw0i2ioWQCNpiu/oqwPYYjr/QMyPJd1/teYFJ2ZEju0QRtztH6yOZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kP3i/so6";
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985D606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 17:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3985D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kP3i/so6
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b6b22be970so1341294b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 09:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795454371; x=1796059171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pl5LlU8oba1tB9cYFDtFrGCDtd6q3xDmJZtY4vUlwMQ=;
        b=kP3i/so6HH98uHbfHy+ALDtpP5nXVMLM+tkX6mX2FuuRG2PPFEXsbnhwy7f4NMgG7x
         CLapE1dVyxNQ8t+4zs0kx/K+/3kRwXX3ylY85Dz5NmBXHYwcAzwiz6zVfabd3nK0545o
         7gmyZ38HC0ocV/AUQgXuQmZVry0wRWSHGrDpQk2c/5O1NUoxKiiaTnADTiVIUBm2sbaz
         +xofFwBJmmO3R8FBzZr9Cqdp8ginTinrei/cVKLvX/8cKvnvW2DvmarkTGGWqV5mfffL
         +HFi6SFVtFC1lKD2Jb78hCG0d7qED13FzsWB9KAYn+l/KZOS/C3t0aoMrLDLNLjU0o2Y
         Szxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795454371; x=1796059171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pl5LlU8oba1tB9cYFDtFrGCDtd6q3xDmJZtY4vUlwMQ=;
        b=T3TUD5sffrMl3zKmhZUg2Ii+hkt25Wtc/XzedQcqpQhC5rQfqNrDkK4inG77LsY1Ic
         o5dlQ+VKAwvXhWZOd3aoS7hHRLvwLsQiwb8k6UVpwh92oo0IXihnQ/WmnmpDcqH/Lusd
         wmFeMHDbktLVtMrwMA+MNqZYcqee+yAgfUQnKKPY3yNkavhJw2SHT7wp0icIwAIf7XGi
         Qr9pTTrdW3pSvpOhOAIRmXd6Qs0CfqR6MFVC88U6mq8guPJjXD1mDZfcdhEluwylgajV
         JfVux/hcQQUjxRemO6S1TFax7ZHwThcPD6TQGG6kVo9xGzxFZjx1C5nBGO40RaW2ifRY
         7QOA==
X-Forwarded-Encrypted: i=1; AL+hErEsU8hsCQ8ES85j0Tzr7aBxz0CrOqGPqbhLLmUIeDf8OHUN+fvuvCz71Clb0IiFLxmz1zUUTZqThA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ymx/GLB/6br8ErIfPQNhaKLsTa8K+EqERB3KnkHk/izizf9j6
	0CQwtw7NclG/t0JuLystcvmjJ4BZpCc8gqyE4BcEap+Hlg9WXGP/I0s=
X-Gm-Gg: AZFdTZdEisdObgEBR8gbN0UqGzTqRRDJVGBpHsnLS/Ahjy3XkXq0cZ5Omf+dR6F0L4p
	q4lXMiu1QHBM/MVLbvuHN0xYwY1qlNo7V+yWTPaM+8p3otrN/Q/BHF4i3qs2FzONH+WhBkGEh5x
	nWqIu1zyH/gBmWmwoR7PeSd3fEinuF2e+1O60oZA93bSLHXxb8SpiyBrd2UzKgt3iEJbPxOWpPj
	8AFJaWV9yIWVUo089XNAbCitxzDjP3vmnV5mDhMINngF1vx4YC7Bm84dgWgRRqC5OEvltgsV6TE
	N2gjvIXBEEHevxEvSduVt1oY31aVVBjFjRMGvFSgNyatfa1raCCrgydalWVinAi97JX72dGxZoH
	ybdkcjRJa3W0RSC870MWrg3LdCNHyE33Ulr21tE8DRk2NlDJk6mazEHQaQ4a1URVp6bxQGHToeR
	EMRZH9l8VbPKuudWJdgE22Urv/ps4mmClWOxHBQDXWlvxtQSp2jGQwvs703sXiy+JNw06lk0sTL
	Cghiw1x91w57TWXzC2SXv40Qlso/YwWFIijm11GMKHMjtb5IFZKkz3ZTZHJr80DUTdyfGqqjad+
	ujdCkmzrI6aYNKbju/otIP4/vYhW7LNltK+VrGdbBK680WzcicUYUvLa64SYNQLiHX4Z
X-Received: by 2002:a05:6a00:844:b0:88b:76e3:cd8a with SMTP id d2e1a72fcca58-8c87cb4bc4dmr11130870b3a.38.1795454371512;
        Mon, 23 Nov 2026 09:19:31 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:7883:5066:4773:c572])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cf5bsm5985151b3a.52.2026.11.23.09.19.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 09:19:31 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] pmdomain: imx: gpcv2: Take a reference to each PGC node
Date: Tue, 24 Nov 2026 01:19:23 +0800
Message-ID: <confirmed-20261105-18-6a8421e1b241@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The child-node iterator owns the reference to each PGC node, but
imx_gpcv2_probe() assigns the node to a newly allocated platform device
without taking another reference. If platform_device_add() fails,
platform_device_put() releases the node through platform_device_release(),
and the iterator then drops the same reference again.

Use platform_device_set_of_node() to give the child device its own node
reference, paired with the put in platform_device_release().

Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260530004541.E04701F00898@smtp.kernel.org/
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
AI assistance was used for analysis and patch preparation.

Based on next-20261104 (8b7179210b22).
Compile-tested: arm64, GCC 14.2.0, W=1, drivers/pmdomain/imx/gpcv2.o;
baseline and patched objects built with no warnings.
Static source review; no hardware, boot, or KASAN test was performed.

 drivers/pmdomain/imx/gpcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 6a54ee734514645db7e0628bdddcf579d1f0d904..7b377bf0196491298e9e772b97d15a2bda9ff83a 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1513,7 +1513,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		domain->genpd.power_off = imx_pgc_power_down;
 
 		pd_pdev->dev.parent = dev;
-		device_set_node(&pd_pdev->dev, of_fwnode_handle(np));
+		platform_device_set_of_node(pd_pdev, np);
 
 		ret = platform_device_add(pd_pdev);
 		if (ret) {

base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
