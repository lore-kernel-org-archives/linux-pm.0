Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791277;
	b=J9egqqS9FBHFg1hC0m0mV0azjbEArBKB1VBcyFVWJjbZ51croxqo8PthpPXfe+tybneW
	 lhMWMR1LKWz1n9Cs+W71EZ+V08UPjwvHVIMk0CtmZ8dkz19Pn2HtgnCIFJUOL9J5lo8+r
	 S/c5cLvytnyU09oJGml/VdA5q8NrpaE6Dfs9ZEj2i5FZMrXcB29XzgnJ6yOibr0OqLFED
	 snK9HvJ5PT2aGvGHfikUEMbhTQn65r1At1N/FBmPYbTcF3aOWP0oP28ARHB14EybqeirQ
	 8SA5LwDO6joOHzisDb+I28dgvP14Efg7fCuIenVmhKg+oNAf2hUcJ7VcX0GqmkQ+kCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B2E3iVg+Y53ku5x5pyq2TwGurqaRpRcncBnG/OPEoGE=;
	b=OehkQ9R1jAvjdRdEDZjaODoUQ6A943a6zSaMPfe1ULmuOaF4gm1FjsTOpgfPUXAqr0u7
	 tsqbvy+TJB/oH1fCtZQyFwusWO41TNvTTLvEXcxDOaucIMkW0pyIdFqu9kn2hucw08Hlk
	 xDLXWR/zY4hV3lUt0TSglG2w37vNh/++XukyoetGiXzD04gDNLV80+uk0nb9L7B52ligb
	 r5Sg/wgrv+e2zklsxp7OXy2UpjYGDU3eHGACwmOTUBay92Bzx1juljh1ItES77VUla0JX
	 PMPTjZg+AuZVrkYymfYYVz6MxYUWyJZoqHwlcv4mAYXINY+XqHdw6W//8svvUTkUhAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iixHA0sv;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F89606A31E
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91F89606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iixHA0sv
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so67038505e9.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795791276; x=1796396076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B2E3iVg+Y53ku5x5pyq2TwGurqaRpRcncBnG/OPEoGE=;
        b=iixHA0sv88U6GlWaq8WJ6u6F6OD+2Ul2IEc5X29nvNhQV0advhEpIETTKTjyWEOjsZ
         f2rTwAZ70xSLu1rCUSuvra2ZMU1HigrRRj0ail5JxftmZ0v8V5gsNaOgMh7tAymaPg91
         VUKwJPq4/7LeCQf2qcYIo5HtfHMp37YhEqVpRRQSVTQEmfOuaRBPZhagVH418I9AZ+UQ
         2zOANZnGrnPBOpCHr+Rb+gaTtfyMYLAQhwwSzlfzoIQ6oxawUxpqaA3l5ai67yk7c27d
         rR3pmEIriHL1iiy8iLokZ/z4Kn39q3lVDOOA+kYKrkKsVmt+zvm/yiycK3L36PG5dVG0
         X8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795791276; x=1796396076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B2E3iVg+Y53ku5x5pyq2TwGurqaRpRcncBnG/OPEoGE=;
        b=AvITtoWZapPAFcqM461KxgND0OFYmftOR+GYY/Aw0RLjdrsl6a+DlDI0HWnA+tj+9n
         i5MSre2atApTfyxv79hyzhN1nXo2bGzPaPZrU7alndUqRnRjNWXlMtV3B37cbpRCMnh9
         s3OH+jGQnovLw1kBH2qCsqFr4m8RawpWfl9ubYg9THrtPyZXrgJA7SfgCR6mCSXzavd/
         sEMFHzIDdFdUkP1WCBW+dzfYBxoCAQB1kKdxwYSSdeU5CMRVpCejw8jw5wUV15QUa8G/
         BV76HZ7Z1nZG4udzJah0GXHXRYBJWNHB39L0f1u8Fe799roSSdoGm59YUMd8eBy05tCJ
         Rs7w==
X-Forwarded-Encrypted: i=1; AL+hErFq5/EUFoYuXeHg8TjXKz9JlMVrdVBmlR6ktU8YpoBZo3rtmyiHXjE8uiuCaSFKDx2hqR+CmeMHVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9bMIrNIpAbt2/JdhZFJjH26/j8WuFxtXXWLH9kU4di7wUf23qY
	cjzLNW+fH/Zxj7RyRHCYnhwaw+TIoVLV+BZKcXCuJ+qa/GXg14nvC35v
X-Gm-Gg: AZFdTZd2WtfC8LgVCKX5HZfofj6GRIZMxTXekvcwtpaJjVuhIz4gDYEpmKZdh5qWl5x
	MfsfJztp/nQGEzfG9UEKyvwA27XGR/eAx+LwbGT9byCt2ILc+R8bziumSTjsd77LNF/A8U4e/vw
	JtyLTWtcfJqtdeFi8i8h+iFIFclTPnKjEUvlNjXFZQuZi1R4Wa27ljlAj25V28DaaJ4S5G1/VPU
	mP3gki0LcgmYBSkTQb1wOoZQ1ZLDFOmTa02vmmnJTzgoV30Ci99+mRpn97SXOMLelNLb1/4ymuu
	awcfCGZcYfFPzds/RkFrrM4VTZNrWB1eJqmnuO9Br5WmeRmXrI45hvs5fKZAvmEcVaCEfm3dxLA
	y5t8E+WkOUb5Ld6jVN1Z4+cm/m7YSOAxGxJoMjETacxrfqSJssqLa2B3ZISrnxPUdQs0mjnFrN9
	6y+RZq33PJ/wLuLW+hD5+7E4Gyfbys4H+eZBzzd/JhfpNYY/A+XPHmNP0NN0nEmEVlXfBJn4+0h
	uy9SeeXi5leueZ9rxVwkMpgWK+kSc8MRqB630HgH3FpCHpZk9/CeKB4lM2eYP+batDgqPe5diCk
	XnnFhwRpO1V3oyMeY9MN8/N+Sz1e6c0RclICdpv6K4rgyf+B138L/Nlm1qx2GQ4W135W9J+AHR/
	1d2Y=
X-Received: by 2002:a05:600c:4584:b0:4a7:c366:d791 with SMTP id 5b1f17b1804b1-4bb887e266amr485218485e9.1.1795791275934;
        Fri, 27 Nov 2026 06:54:35 -0800 (PST)
Received: from emanueleg-nb (host-87-4-46-207.retail.telecomitalia.it. [87.4.46.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm633589105e9.1.2026.11.27.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:54:35 -0800 (PST)
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
Subject: [PATCH v1 1/2] dt-bindings: power: reset: Document the Toradex Aquila IQ8 EC
Date: Fri, 27 Nov 2026 15:54:23 +0100
Message-ID: <20261127145429.2060162-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127145429.2060162-1-ghidoliemanuele@gmail.com>
References: <20261127145429.2060162-1-ghidoliemanuele@gmail.com>
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

The Aquila IQ8 EC belongs to the same family as the SMARC ECs and
implements the same I2C programming interface, with the same power-off
and reset commands. The module signals it controls differ, since Aquila
and SMARC define different connector interfaces, but this is not
visible to software.

Add a dedicated compatible with toradex,smarc-ec as fallback and make
the description generic, so that it is not tied to a specific module
family.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 .../bindings/power/reset/toradex,smarc-ec.yaml        | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml b/Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml
index ffcd5f2c2bf6..d59d08c0250f 100644
--- a/Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml
+++ b/Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml
@@ -11,13 +11,11 @@ maintainers:
   - Francesco Dolcini <francesco.dolcini@toradex.com>
 
 description: |
-  The Toradex Embedded Controller (EC) is used on Toradex SMARC modules,
-  primarily to manage power and reset functionalities.
+  The Toradex Embedded Controller (EC) is used on Toradex modules to manage
+  power sequencing and reset.
 
-  The EC provides the following functions:
-    - Reads the SMARC POWER_BTN# and RESET_IN# signals and controls the PMIC accordingly.
-    - Controls the SoC boot mode signals based on the SMARC BOOT_SEL# and FORCE_RECOV# inputs.
-    - Manages the CARRIER_STDBY# signal in response to relevant SoC signals.
+  It handles the power, reset and boot mode signals of the module connector
+  and controls the PMIC and the SoC accordingly.
 
   The EC runs a small firmware, factory programmed into its internal flash, and communicates over I2C.
   It allows software to control power-off and reset functionalities of the module.
@@ -26,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - toradex,aquila-iq8-ec
           - toradex,smarc-imx95-ec
           - toradex,smarc-imx8mp-ec
       - const: toradex,smarc-ec
-- 
2.53.0

