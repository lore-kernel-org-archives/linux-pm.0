Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4DC4398EC
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222290; cv=none; b=m9+nwC8ah31pSTJ7XJtQZKqYFQvXg3cCjB9V+b/PytQKhDSYFHyqadL6/9PalAxvysCVpmc9WTzxeth709c3X8pCZtLYJACwMo3bP3z9f7kx4jxmuBSPtCRpSBTn+snD3vSZbsTlAMLwsqSWU7I4zkvMDzH0H3KVXwjbgMUlo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222290; c=relaxed/simple;
	bh=J0ZsmPYEowQMOMxEQ5XSmmwU88gF6MVEkonHVpC3RRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkJnFLeb5n3dxjsG+H+TdLyIKsDN8u8sjhgkn7kLTZcq+u05YWOQBYnyMY3Ru9XGqZYoZ4glJc52ARkZ5pXLfTt1YoGSlRX6s1uOSgVneoiAxq1gON0EV7BWc+1peRC14AmkVjK2UGgh1zWI5TkihekAj9SHdItytZgPF20zHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvO8J11s; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvO8J11s"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cab973140bso84516915ad.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784222274; x=1784827074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8YOzE4Dspd5jzvIIg5G/ODj4WmBPO1vOc7GQ0jrswag=;
        b=GvO8J11sQSGQQ/sF8s7uiraCEKVdK14TEzPca3mJldVAJXX5TMO+ZLewJ3cQkQ4A64
         fzmIFzBW7JZo0E3z9Dq43hmR1uSxAwQBzHWFzPIAlqMafTP7YZMiuCfLEDio2TsuyNMd
         3IwOtW8yg6uFrof9WyAlAT7IJyvK6UQJVLhmn+jGnxYdGYQgzeYI8mcbTUjgpRDTPetQ
         PLPLcvbVE7bf/53UM48B7/+bzTEOQwGmsRr460oYRr+FCZIOj4mHfCzQ04APMvg2FQzp
         9uaSbL0t3pbNJ7zRRebtxDaIx1Kjb5SVFGuZp+KEZvHPgIQZ1+RiY2v/5fVuOjoDuJ6q
         8KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784222274; x=1784827074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8YOzE4Dspd5jzvIIg5G/ODj4WmBPO1vOc7GQ0jrswag=;
        b=pLLqrjj1qxcHP8Ij7v8EQNdM1xCqLjlVcRplj8mgVw/benPKSFk2EC++RIbiI6ino3
         +qfDtyROjkrLbpT48rFnn5y6reS3zqXQJXQuuTBNJHKy3OYaR9IBwa6FQ1yyUwnXtFPL
         SR/8vA9PELSu2D2CzDyjQxMbZ8MwTy00KvvJSw7nSTK3EPGB9yNESIw+gqREfv0WJc0e
         Ac48tgWme7JFmAav63uLwi2EoQcxsewmM+Og351EpZcT03AQqjrNS4lrs3nfeLGLG2h8
         8e7X8OCGsTPlCBuXZsEbiifdah2wFKOvDsuUNS6PxdpU1ra4QZulyy4gqNaWuoGSjkFq
         L59Q==
X-Gm-Message-State: AOJu0YyzNjrTplLAQPXAEKvZmLaPz5xvm/E6hpWySau+rA6QqHCpzwmZ
	xYzTFdSWj3rYYzNsadsy11+uVw5XnEGs8Tk2kWKuLsXgbGjh30N13GRJ
X-Gm-Gg: AfdE7cm6NO1TmbEJNLkAvStqnOm4OiZTxn+ruQYn6dGXjrS3NT/B2xyqYzDVQqpRuLl
	69fIi5AFHkmi5yjlQc2s/lZ5x1sHDbl0g103SjZzYzxZ+T/FgZ27ppnp4CAFuX2qOZCMBWSr/bq
	VfUmGxSUwi/8Oeo3vBwsv94MDsjDh2vfyGh0zqTj9FWduid1ADcMW6jCAQ9lKv79W6G9fkeX2a0
	TTqEbRgfCcUTDUPGPcjtHJnXatHM+1u95nAIXVh7Kjczu4GI7l71AfoEEfb/26U6aSxFR62gjw5
	0YjqBCU0uFJTzCxAtsl6JUYX1kPZZc9bn8oMRbbw8/uLYDq4FsLDm8WZkBQ4JUxFxMezWd1xI4i
	6JIaku7dp/9kz43nSuk1ARL06lrc9DP4THzvwA/wUaJi/GBhFeP0G0XcyC5ojOKkkbi1WgUkD4r
	avB5BurbgMZs+RNxzpEMCR4mXgAo2H2CM5uQ==
X-Received: by 2002:a17:903:1cb:b0:2cc:1452:a014 with SMTP id d9443c01a7336-2cf03c36420mr81705655ad.18.1784222273587;
        Thu, 16 Jul 2026 10:17:53 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1055de44sm22917255ad.51.2026.07.16.10.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:17:53 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: linux-pm@vger.kernel.org (open list:MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS),
	mfd@lists.linux.dev (open list:MULTIFUNCTION DEVICES (MFD)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 1/3] dt-bindings: soc: mediatek: pwrap: Add compatible for MT6589 SoC
Date: Fri, 17 Jul 2026 02:17:31 +0900
Message-ID: <20260716171733.300885-2-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716171733.300885-1-akkun11.open@gmail.com>
References: <20260716171733.300885-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for MediaTek MT6589 PWRAP.
Also update the description since MT6589 has pwrap bridge.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml     | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
index e7c4a3984c60..a487ed39e6cb 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
@@ -19,8 +19,8 @@ description:
 
   IP Pairing
 
-  On MT8135 the pins of some SoC internal peripherals can be on the PMIC.
-  The signals of these pins are routed over the SPI bus using the pwrap
+  On MT6589 and MT8135, the pins of some SoC internal peripherals can be on the
+  PMIC. The signals of these pins are routed over the SPI bus using the pwrap
   bridge. In the binding description below the properties needed for bridging
   are marked with "IP Pairing". These are optional on SoCs which do not support
   IP Pairing
@@ -31,6 +31,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt2701-pwrap
+              - mediatek,mt6589-pwrap
               - mediatek,mt6765-pwrap
               - mediatek,mt6779-pwrap
               - mediatek,mt6795-pwrap
-- 
2.54.0

