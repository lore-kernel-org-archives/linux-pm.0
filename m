Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907923;
	b=bYc9veUstoE3S07VhbdTOCs1vcQMSDwZpMOenqnKNDZBAHwVXYoHMbvt01V7RF5IVTO+
	 aIn5m6N1oZZh7jtOX2+eNZnaRd2QUX1CdICOjg8TTYc/ACrcHfpI2+RZBBNV6J3Y3Xgpx
	 9o6LzMRcYYlPg95srjyfUSlNq46LI/6XAg+kAdPdjqJNAJ0L/7fCe8/9SsnnSfPiajgP5
	 +btFSHCnWhRSFOwpqOlxtXprc2StBelUTayZqEvMGiuihP72iPDMQB3YS9xHw9FZY9Ylt
	 BzFs8FCIvu5ndvVaTPDISWbAzHHQhAGRnlkEWn86gl7Ljx4o1JRT+53+GExm2DbfnZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
	b=Zt6g1UO3PAI3YksfreBalYjGpXnfFwX0Y9XrlbfAZTPmYDRMTAMkfXL+KtzdB17rw0ZC
	 vVsxAAcsFSosEvR80nInrcm07fZ6UAj8YE11XTyFGXQvhCcUOxmM7fR/z3iKMXEEbjC94
	 o6EeKUMLOFwCJmnlFi0oh4e0s+YU6T3MHMAQkzttkXWKnps4n8wLs9oE9SxV2K9ThHYsL
	 UEFA49hFUMG66YTsLx7H5MesuXG87oOzSfp+1wkWORThQgDzdGZWXzpfK2/hCAHy/7rub
	 hhBnSdJeSk+U1VNgLFU7lQR9Nn7QI0ZAQKNw3NiGaSd6382myx8ZCGs58yjemvadSpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RrX5BTtZ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FC607955E
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 19:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655FC607955E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RrX5BTtZ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a214af2076so16936775e9.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907922; x=1794512722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=RrX5BTtZ25KAkyVDqIgIjSieI0yowwfSr8T6mwymv0DBFz5APBPsQ60BLti2G0x05q
         6boqmc8T+fJnxWSpzn8kJusKUm60NFwdJju/vVYZ3iqkbGQzDtfFvv/qi3tNuErvjFQe
         11nINNWnhw0ATZ5Z0jI9ua9qp/9M4BXOQh8gsE8HOJjK9+JEh2ZyMaKOxeec2cZVtpKK
         k8HMWcB67/FgMv553KebZ8rp0aOtZ37D8ZbsTaxepxk5+SsWn0SA5ZeuI9H04WfA/VaL
         WJq5E68OZ+r+EbYxT3Ff7TSgkCiF45epeHQoZdEWx7D/vK7+0qaxziCcKWwcGhlSdQT+
         Ybnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907922; x=1794512722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=IRdcWGlSt3E8L+4488kZToKUsr0n0T4OsAuH5viQtCnaGm1tYoSdNtQxNNdp8vXVK1
         fBc00gKKTb4ZdysRonjBRjEJJGKb1wcb/uXuim+Q+4j+O/iD5Ma8ekZ8hGeUjQSn8wI8
         cK2X8KEWJomtnY36fHMiu/MOwm9m7bC0bxobmonwBNWoE3WR2EHY3RfQV0+dvRCpeIJo
         AxOdjxIG7eb9yDasXBAE9DbXpCxFZmmmhks5STRn/fT6H18LUtO+2AvjXSZgxGg6oSmf
         3Liibxk0HXzlpOT+ASOYf4oZeGLaNj7PGIdbB7Y9ejV4N+byP+VWgifzrNRXOvOYuPql
         zilA==
X-Forwarded-Encrypted: i=1; AKwUvBwlV6SXSxWp6fPSGj8tMNxjCzD/RWob+NCyixTaDCq8uRt08X6XlQqnTXWqaZ4JLO9tz8w8Y2sjDQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/0pYiCvs7TQs4X9uEJ9iHQU7wB3I5VA/X/hkxahwwSna3ATbgW
	u+kGUuoJwjhXgpzAqHwb8qCjaCBMzbkQ2OjnLNd8HgSq20A44jUWCsBE
X-Gm-Gg: AYBFou0Z0xulQpl+ry+L+ME34XCg2l3q5W0ygpdvGwHV++WZX1eOL6YoPgO5qYvI9KE
	PFeN80Wh5wHOQWTBo+33yqySLzsLVs9Vny9FWUN3ZIbtyB5nRqoGNH4DR8KaUdiISvirX2eWCA2
	7R/+TtpLUEQi6lN2kaNr0oipacO6syrNJXlxDhtmQFiznkxKNb8SGH5aOZqhfTA3twPrd/qkOEr
	cwSmhSLmawKvYgjiHI8HqjoAQGrlghZnTlvpzDWJ5AZnE/HJYMGDGLdj/hxIhoX29+XfsfIBN0g
	mMCU78i9Qid8BXsMFocfx/wSy8rQPt/R/NyRPTVbjvUMDR/pRnZ8wvkyD4n/p9NpPdFynxHTmmO
	yguOXyW7UhB9o7ZIKnwEuNvv/DVcnFQastaOIkLpms0Cw5n7G+9aTIwDjoG/AYjCjLhhVimSpbC
	9loT8IyyhcFZPxppOnJJp3y3c9GOvwTCBjaNiSiRyNkGuqjZXbEUI0dCtS5IXtMd/3ErpSCrU/D
	o0CFh52zMbgYUQarEi0b0kKMv1x+uawjhkbA8mYn525raDMgigK9Z7fssZ9YPJx7VTylSREIs+2
	h1hG1rwLaAnH6el8/LOiznwo
X-Received: by 2002:a05:600c:5285:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4b6db4a9a2emr3123275e9.2.1793907921887;
        Thu, 05 Nov 2026 11:45:21 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6df5eaabbsm4204265e9.2.2026.11.05.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:45:21 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v12 2/8] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Thu,  5 Nov 2026 20:41:33 +0100
Message-ID: <20261105194426.1113050-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105194426.1113050-1-l.scorcia@gmail.com>
References: <20261105194426.1113050-1-l.scorcia@gmail.com>
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

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of mtk-pmic-keys for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 140a862ecfbe..ff720588128b 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -31,6 +31,7 @@ properties:
           - mediatek,mt6357-keys
           - mediatek,mt6358-keys
           - mediatek,mt6359-keys
+          - mediatek,mt6392-keys
           - mediatek,mt6397-keys
       - items:
           - enum:
-- 
2.43.0

