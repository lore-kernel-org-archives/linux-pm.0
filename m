Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814806;
	b=W4ANj5tZ20wx0CJ4jBJQhyl00hyRB2Drba7TqL/gYMV37j+imgLaLgYfrD6riEmP4Unk
	 Ztlz8+M5y0lBpnivNI/77uqyl7HlCm+XFiLpWWpfMD0JO7E9JzovgrwQMxTfPfjIVtEO9
	 jGG4MZGhku8EMjiffP5bXk7RmvQSeTYlCtcxbv9xoXEYgYAzsQczjQbRabZel5wwd8YBQ
	 K9PBlLUxnrAp/pTSB8HejAD7tRhu/6k0XSW+RSR9NiuH0n5hio1hBQ7WnOsoxvZiplgJg
	 c6hRnQeLRR9EoUlTeiIki/K5VsHDpfyVq7gx1CQ5cC9JWvrV1cu/PFztPE+T01D57SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7HwD/9cyl5yU69DIEKa52hPN8DCHL8GdVhIFYuxqFrc=;
	b=n7MFg+hXaXMSI7N8DXC8gVwc3IpiSgYmxWQEiNACfqzf3yr3gZuMqFqPpmPeBJnjTZvr
	 y4S57WuMVvmM31Ow+HiTJ4/h33Vt4pTojQvooEDGd5pi7hUpTNrmq5WYsna+8jqyMir9p
	 ha+iLg/5a1cd+XQzR9vWaCYDtWV/0s2inkDLLu6AbGBTbqKj/ehbgZxWgsF2HPL/VANZv
	 8D0j348Y5QkFKQNXQb+dVsyWs43UfFfLBOLwBsgV6ZFWcwPIdOjzqEkYR8FAUzSuFmGhN
	 eWM5Dnj+or2TXLg7gPs7r8tfoaNihaBjKGIQXsa9zzUvPaxAnVvME4jmO2JjUulpYvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6LdmkbQ;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487860A3834
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 07:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E487860A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6LdmkbQ
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so1567844f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 23:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794814804; x=1795419604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7HwD/9cyl5yU69DIEKa52hPN8DCHL8GdVhIFYuxqFrc=;
        b=S6LdmkbQVA541jEVdicLwZOEbw2MGB5A6Cr+05flbgQjzuZkxsmnZrhjTKDEa9Zs9L
         r+eLO8DS/9pPo3yU4ZUGL+J1Uqm8LB4KRn3Hi00Upp3AKhs7ARcEQcrSlv6tnTYocw7d
         6EtSnQSBTXMJmUOcuWSNz32eYMVEZcOTq+qs5Oek/WJoeas9kePEPria3pXpOzaWy1Z6
         alfBNg22E/VfuCkUMvYNVnWKIsA939GGnQl75JbUBFwuog54IVABVFi7Kq0j8BxwR+2D
         ZvuIjx9nv9Jp3G8FFGHLyYvumznDoN2tgYKty8ER9u8BO9QZ9C2wOV6o6uo88Ts0EUA4
         6gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794814804; x=1795419604;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HwD/9cyl5yU69DIEKa52hPN8DCHL8GdVhIFYuxqFrc=;
        b=bOHe8HEL9DS9DVhfqDMI3hJu3ykHVlnle/xyXR3xfI3DiyBlBtcD6fVJ0Teh3SV4Gk
         4A6I1QE763XL2xSW5uR5EoeBlqso0FygEz6GFyUxnV+InZDSxj7I4SZ22Ne912YKvp6K
         nSGridPUkA+zbzyYmy9WIK5/tZAhI9dlcnIXd7XGRgTbXj+oAJala8i3WkJeNCNI7vsb
         xVnYHi0kQBck7dgRHqTnGJg1pPq6Y9LXbG9aILFOjrPrQLkGRSB4jHGMHgqfwwYI+PaL
         4ufxmXtW+cbvoNnBtBSOllpLGNtWu6HOUpryeK5vsd/AcRtDLQEIkgvFVYVIjaXs03Yn
         SXQw==
X-Forwarded-Encrypted: i=1; AL+hErGVEzKFUDJq+ZcWFsxL34gD22BFBZkQ+GKZFj95WTYgiZkhVUmZvfivJh3Zt6Gcm0pMgGytAGvV3g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+bZgR1nmgYnLYYZhcFXs5heY27bsZEUTO5PIhACdEl6FhpfM1s
	gxWMHt7jHkUGD8yC8M8/oHkaC7Zh87K1loxrt64eaj33gI1isAUD11S7
X-Gm-Gg: AYBFou28YP/OfZ/daYymUZMk34FPRkmunYhhvC6oKQLmjuv+69aFhuu2oUJvX+kVvwE
	opVUkhQN+t90sOKe6bMHCD+GVKv1UHTRH8FtdC8nF+/rmwa1uFDNnFAwcVzz+22+HsRKxqqo2l9
	ID3idFEkEj0tVL3pbYhFQAUoamqZrrLg0ZPux4Xt0VuLW9gqR6NIk8baGFGptzfjJfTqJgMvOgD
	UOPdp3obvgEoF4HAfEdjclS4/zgELxOgATB2Zp/LRKfLYaHeSe0cBD2JtI9eq5xZiysyYbpd3AS
	eCURFhH/0RUo4+5gQaymiVNigwOJfzak2WwVpjmj+HuROd/OmPFmUgeEHgP/3OreGQ6qd8ESWAW
	65AC3PoLshGZKBxzPM9LwhCxdifx0V1cSkXsSjHJoTwz1yNseLYYAOFjqyuRyE5d/EszxsmRnR9
	PP9U2PKR3OZlKggFc+qSdx/bISrY7zhVRruWrMG59SmYS4XkjSRg4AhjCIKllAG5dZm3FhmDteU
	l2HLrKs9710pN45QyRQU+dD2ltNhswc96sfUeDHAoC3iG1lYntBOzpfkZ+CryxJJC3Kl5FsIW81
	ytS3zFuFeBxyxWel6TxFkmDelLdW2kI=
X-Received: by 2002:a05:6000:46c4:b0:494:bf39:21a5 with SMTP id ffacd0b85a97d-49c70ed910dmr12914294f8f.10.1794814804277;
        Sun, 15 Nov 2026 23:40:04 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm20354115f8f.35.2026.11.15.23.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:40:03 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v1 1/3] dt-bindings: power: supply: samsung,s2mu005-fuel-gauge: add S2MU106
Date: Mon, 16 Nov 2026 10:39:58 +0300
Message-ID: <20261116074000.355176-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116074000.355176-1-tadilhusrev@gmail.com>
References: <20261116074000.355176-1-tadilhusrev@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fuel gauge in the Samsung S2MU106 PMIC shares the S2MU005 fuel
gauge's register layout and scaling for the direct voltage, current and
state-of-charge registers. Add a "samsung,s2mu106-fuel-gauge" compatible
with the existing "samsung,s2mu005-fuel-gauge" as a fallback.

This was verified on a Samsung Galaxy XCover5 (Exynos850): the s2mu005
fuel-gauge driver, bound to the S2MU106 fuel gauge, reports voltage,
state of charge and the sign of the charge current correctly.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 .../bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml  | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml
index 05e420316..7b9d56d38 100644
--- a/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml
+++ b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml
@@ -14,8 +14,11 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - samsung,s2mu005-fuel-gauge
+    oneOf:
+      - const: samsung,s2mu005-fuel-gauge
+      - items:
+          - const: samsung,s2mu106-fuel-gauge
+          - const: samsung,s2mu005-fuel-gauge
 
   reg:
     maxItems: 1
-- 
2.53.0

