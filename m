Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E942EEC4
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835743; cv=none; b=k8mobsyn+bDxpETv0C36WxbcEGYRxUBn9pUP5faOSZeVgccFtlmssQsd7LphDda7wIj34gDV+N2THHqCigvnZw88he3WbN5pPh3e5SSOsjX4torrZ5s0kir8ZhcezwfNTWnankaVwL/q2MW5DFMNgo1G1f7s/ONB15MJuAekPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835743; c=relaxed/simple;
	bh=bOSDifb0+bqORKH2w/7EPITVe40diI8h5lS71n8Mt58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8gVUPvY8+YxBitN5ePYbzPuu59Ma4gbQSwXVEDCd04cmlV/mLpY5weJ34v/ls8RpEq2+Zxlcw9Up9O2P72PRbhs6fKoJagmDQw2HaMz8+EWWM2VR+RL0U9C6GfSgpxsTDF03vXREln/u273iSlNkIWaWBRsh0ZX8oXH38b33uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JCj3R3Wf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JCj3R3Wf"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso3670553a91.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835741; x=1779440541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWN7gkxjFiGZ3cV0OWHAWJ+8N9Pyp+YRIV9vOKGoCOQ=;
        b=JCj3R3WftoStic+DwMeCi+7mnyb0HhFcBZBXMAAfPT8pcXH2l8L+N8MkzUL3dAtdOD
         dxnkd8kwHxLw5PJkQjPiN34ytGyYS5XK8H08Y+ZZMPJadfGPi/d6HgCu6y1pTgWFcJR3
         jaNMIkNq26XYAcikYNj0CqhML+KgXMF6VweKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835741; x=1779440541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CWN7gkxjFiGZ3cV0OWHAWJ+8N9Pyp+YRIV9vOKGoCOQ=;
        b=JCoaMbfON7oHG7+mBeDYIVv+YRaCTxYBUZjVwIesoFfLO9wwaH3XHQZcMy+pNYH1O+
         jvz44ziltq1cSzkpGUwpLcuS9xFr6Vbth7lkbGKEZnXJJfUVc6QT7HJ1kfdzjR4nu0Tz
         vNVH9naAf2y+xcF6ifFzHbN8kuqgHTLJyGDnsI36uLCHWhSwU5REXe8EtHvYIw3VM+FW
         liJxr1RuVZt3vu9d877WdA6X8RzRTJAwsjmDPpYU5+To1lRHcm4Eev7aUSafDcamBAYb
         47coKqAjgZDS+uOHxMoElb+1ncznwtZkMoCVGsDcKgXo/njoiOEhbcP9AogSXalAu0eJ
         gDAg==
X-Forwarded-Encrypted: i=1; AFNElJ+/sTLIP4RipVujnq8p53CQehdnkVS2IUTpKvekApCs/uU5NgdhNpfLBrMn66CmVwDO3eERY9b0+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjTQ4FxhrH36tGMigkjLmfOoX40501yyGXRopghev6uFsJ9FWW
	mY02FqsENOHvpVmy9zvFktZWcbiailvc8uE+Bk0RjAbRqn/ea0/KPVBd8HrOYCDrQg==
X-Gm-Gg: Acq92OGzs9dPrPKVaMhNruRjrR1sj9MP4TnSL2MzGkQ/s7LL43o4x58J/F4hhEWZ9or
	7UJV8ZpDc0kW5NG5uKSeybPRNUsTge3ISPaD2Ys7TmDLR9kFI+KsY6pTde/qbEJT+1mbqOMsvvT
	Bn+KiCZDmjsWPc4oFlQ8aHgUfvxQaNus0zq5PDmZ1oyYjYNo2dU8qlYXzoPbLKSIggjtj8b2QrY
	z1cSQZrt5hfpMrIT1Qbx2nemFJEZRe5Fcp9mrjcTXTr9KT68GGF3iINVA0bcm/3sSCwpqaH/XBn
	qMLLK7/8yTo9+Zby0Za/ndqpU+9uzbehg7M2Y50UUIPp2wiocuC5M5U+a54GIEXG1A/1UnNgwj+
	P9ycAU5zxoZFyH8PKHfw7/ZpjOn2j20XSJtpBjwzlQQhCCM7laX8RvQ9sKOnF8KwzfFJBIDqHL6
	erowbsZvAhyOZ+JfNhJCY3UfSoRhlB9E/fs7ZYEqbbIB0laWOCFUGQUbLf3UKZjjqEVBorQPrH7
	Jvun+e6msiP/yLtXMo=
X-Received: by 2002:a17:90b:5203:b0:35f:b288:8e4c with SMTP id 98e67ed59e1d1-36951a6722fmr2708708a91.15.1778835741437;
        Fri, 15 May 2026 02:02:21 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:21 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH RFC 04/12] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Fri, 15 May 2026 17:01:40 +0800
Message-ID: <20260515090149.3169406-5-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260515090149.3169406-1-wenst@chromium.org>
References: <20260515090149.3169406-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addition of power sequencing descriptor handling in the USB hub code
requires dealing with deferred probing from pwrseq_get(). The power
sequencing provider may not yet be available when the USB hub probes.

Return the actual error code from hub_configure() when it fails, so that
the driver core can notice the deferred probe request.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/usb/core/hub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 24960ba9caa9..90ea597d42ae 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1998,14 +1998,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		usb_set_interface(hdev, 0, 0);
 	}
 
-	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0) {
+	ret = hub_configure(hub, &desc->endpoint[0].desc);
+	if (ret >= 0) {
 		onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
 
 		return 0;
 	}
 
 	hub_disconnect(intf);
-	return -ENODEV;
+	return ret;
 }
 
 static int
-- 
2.54.0.563.g4f69b47b94-goog

