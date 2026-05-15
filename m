Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BAA429831
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835750; cv=none; b=OJInw71JGVTHL5EvxV3LUB25Vvgn2zoLkD7WZgLyhbATzo5C5O1rJ3lhExoygLBniusrQKDI1Q2xy3f6Sr0ZS3Hco6mMlHB/p7ZY3RN1QmMoHyi5dPoObwdhWlwqJMNQLU5u3iDttR/qLpkoIObMAcUfYwRGp4ZlkOy5IgLVY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835750; c=relaxed/simple;
	bh=ZpZa7k5qW6d4O5s2gIExYuE8RnKJzrY7mGSZ7vTtpmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS8gbsg9IJppOyCULVTiykzkr7WSkUKzqD/jlH3KO5pvDDWNDRNbBqYwElo3nD9fxckT1br3/G3vha2SHjHxDjMRWPm5rkK2KGyzdojZ08B3zwUYXLLlliReEhEa3v53ngB/HQ6/pVgjnVEpNl5Sdpo7lStb6OG5hEBa7OHnpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M1ZKebKz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M1ZKebKz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-366375c4076so4334896a91.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835748; x=1779440548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmC0iPkEpdT0NyKzeBxGsIEHmhfQRvHGa186Cj4Bsl0=;
        b=M1ZKebKzXgxRYmqadt91sF2wLWIgeZuyblx2pRSUYy433NDojHxvOTfmweZHw6Rpr/
         z+O5zJd0FkNbaCHBCAA95AX8Un9yEksRiBJ7GQUztR4++xhjMUiI9zZV4+5w6lSdiHjk
         nYN8SWqW1GXjG0rgzVuqjmInrVTD/qZJxOtPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835748; x=1779440548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmC0iPkEpdT0NyKzeBxGsIEHmhfQRvHGa186Cj4Bsl0=;
        b=gfopPor7zGDnI5z41S4WnSQ9uKKWUUXQ9Hs+SqGJFWQKZHv3GtJ5XKTm9vIOKN3Ise
         mGMVvMt/QsxWYkx4pGBijKxHR8R/hKnr7IW/+GDHzWnYdvfo352WlQJ2A01vh6pJL/2M
         lZjCyJApwhD4WzwXx4AVmgX0vsFf5+TSMFw5VzE2mE7mrjoE7fnxlmCHzsg9LqG9L2hg
         MEJe3hAaUDYwvQpeduJXmWA0sSFnK328nbOmjTWakHf+vqrOA9itVtCKpEPZwUVMq8eW
         yvRoPxjXw01aa48b3K/p2bSBnrQbHjQ1//GTTOdwpqeEe1oyl/Z0dQFQ/fWFdqG/7V9p
         +QXw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZVucIuWYjWQwwMCibnpoNjuy8LLnOMv17/cgtqveO/hzL68MZ/obHTxSgcRPWWG87kcajOZsanA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuv++EOG5GBsHQujSl7V56hT+CGAZD9TG7G/ntwq4NKdmOkYwf
	AMBTRisAFJeG/YQhNgio5h0E9TwnvO/aTsF8qwKfTFUZHzbdghnXnMjsaB2aPfTVAg==
X-Gm-Gg: Acq92OGiuqJC+hhbWMjt0K/1DuMq+R9stbwarBu5VjlY7WKZRDQtmiPLlcHS6K5a4gc
	W8s5h5gSTGpoA34wMjJIciMsg+YAKDMXehvbXZcWUBO82oMCcvamlIIwGUKHYC+toONA9ivR0ut
	br1H1gdZEyeZrBqff5Mr4qcSveW87MDhN6Cgyy8E+phOvQJ55Vly70Cz6Lnby0TgU/N7Bv80EPI
	qOvVA3R2vJb4GGJDsOvWOjqOjgGWrPaaaFpQWaffKW7MS2UiFKz9+lXv+twBG9mcnXVhW3cZ8FB
	BwNVaf68UzvqgibsCsiXIqzxe4iNLh8NSux1gkx4ygEoC8tUBXCVL9hx3drH21nLk0QgWfGSODz
	0Bf71x2HAEXPHN62wyqj1DeOY0OFqyi1LQcFZHVMvpglioa/CpB9qEsKiQy5WZT5lEwuZDaWLcE
	H4HXDZ3IRkSJMxtkw57lBuDXtI/ftGydaQ7E7/C136aIw5pr4+2ewQ1Tb9QjDvL1Gl9UP+tDvaw
	+JasvzBOcw9pVs81uk=
X-Received: by 2002:a17:90b:1c82:b0:35f:b7f5:9cd with SMTP id 98e67ed59e1d1-36951c9fad8mr3137430a91.20.1778835748348;
        Fri, 15 May 2026 02:02:28 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:27 -0700 (PDT)
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
Subject: [PATCH RFC 06/12] Revert "dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP"
Date: Fri, 15 May 2026 17:01:42 +0800
Message-ID: <20260515090149.3169406-7-wenst@chromium.org>
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

This reverts commit 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a.

mtk-xhci handles both USB 2.0 High Speed (HS) and USB 3.x SuperSpeed
(SS) host connections. And there are USB 2.0 only mtk-xhci blocks.
The SSUSB controller handles the device or gadget mode. Saying that
SSUSB handles the HS portion is wrong.

Fixes: 454a1e3cd36c ("dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP")
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 231e6f35a986..75ecce3bdc7a 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -107,10 +107,6 @@ properties:
       - description: USB3/SS(P) PHY
       - description: USB2/HS PHY
 
-  port:
-    $ref: /schemas/graph.yaml#/properties/port
-    description: Super Speed (SS) Output endpoint to a Type-C connector
-
   vusb33-supply:
     description: Regulator of USB AVDD3.3v
 
-- 
2.54.0.563.g4f69b47b94-goog

