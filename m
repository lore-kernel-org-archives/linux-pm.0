Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749852;
	b=isSeblf8ycyM1HtlGBPA4owJjvoZiZ6JD7XYPYJ7ojh4P94Kl5f8t97Vu60u1sdwcjBH
	 0LHghctPuRnc4SS6hO//EMmMXZKw0/MnFH21ntIj7nUpVbd1iWnU4esa0DwQY/RWoPLGt
	 PvqLo0+wodaFd/DTJYhfiL04C11yhIARxhmYBooq8iu2JuDo7/pNA9Hrcb7VKFTSODO6Y
	 aeKJ3+v07O51hCGZwsJSnod3JtmUXtaWSVUClqvbJ6eUC8AMSc0yBo3umbjU6NeVnG4L2
	 arPb0i1RaGwD7GfjK5IkrUzAe5oE0Wvw1QQ7SQK3QRoUmIEZugNrOC1WmccmjubCEuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WLd0lU2fh/YAFZVVEuZA4CYWlgeDeL+IcAlXVNkPVKw=;
	b=FCgXojvWJebFjWA3jS4ElF0yfTOepI4su1HkJRQJrhGBNOpSaMC8g83rvRVSgMihfp0q
	 xk6T5GibeE1RyPorwkLjUvxheoCmeK0g4pKb82QojkJpUtEnHvyoYnw4Yy/Ap38w55gsR
	 40FP+9EsjEXvBfccCLAiP2vGtspEvcxZI5ayYjtiB4lYfnVeJK3AnNvXXNaBkPxnjMDEv
	 jhfAQZQZckkWubFoH+s8s3Xef+7N0cZc+M9QLKX2H56cKV07MaRN18AU+InffjM9hr6lO
	 1upUIqMf6WND0opxEL22kRqnN8S2aAu0DYY+Aw7Yee5sCaHTZsVjmihS3y5jqAAOuGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Bp+v017q;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F48606A31D
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 10:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0F48606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Bp+v017q
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so2811105e9.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792749850; x=1793354650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLd0lU2fh/YAFZVVEuZA4CYWlgeDeL+IcAlXVNkPVKw=;
        b=Bp+v017qOOHv+fGEFbZyhDKPjmjPM8N2554dXu8wqilzQL6POiidZKPC1fT+9/0i9P
         YckpdzDhRv3e2fKa5BRVBplXrHGZYq8xnpQjU42AEftxpLEDDC8tr5y3LrXNzzUt3b9r
         Wg+X5V5Do4ofmadBzat4R8plYNZaPnMZwdf5Gh3jwNkCwF1lil9halJlpZ3QQbGfNgR7
         R5+Sg+SASg71mQYF4OcJ24EadKUCsu0e+w2TF8AMoEZZ/gjhKSVWMYvbOLmK0e1VlA16
         DI8c1AS3HUtb+sVrFAjKHKnqZuJcvNtQHcBVBkB4eQwEA2NHzDRi0k+haz+IxoW3Ph5m
         +waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749850; x=1793354650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLd0lU2fh/YAFZVVEuZA4CYWlgeDeL+IcAlXVNkPVKw=;
        b=1Pry6bUlpmbRUdulU0h9FnEyykeaiNo5kjs7+0kiX0fgTwVb9LwKWW3ut0/tOFwhwA
         Y+bzprlAxwxevN0tCVNOhQl32FWjugw64yL8xx7urGr2UkiZE4NngKBwTpXLBo4YALH6
         afotkwr9OR/7DeNpPuydnwU6t9QJrczUEVRYrwS7lfYpfYE3eTg7O8QqaGhJ0AoGN7Sz
         3JZtGy/H3z/nw3gaZzWeOxjTWos3imG5EF9/kV9O1YrjlCIJxQ/7giYl6Sp186U2wof8
         Q0CUsEbkjbAyc3HD29a/e/AqFyAY2f3RaTS+Rn64suOhnO525vdgq8xXrVbnMLYTG5Jh
         5DVA==
X-Forwarded-Encrypted: i=1; AKwUvBw/dhfJom9IjiaP+SC6yECyknw24dYW72nxp0+Zp4GqRaXruOvYjHMom9uPT+9A8Rk1VzMut25eBQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJWNshQa1V7j3HfrmrbSHnwLi6G6ejUQGtj862SJ5d8UqjiTvOA
	0T4OXD9VHksHQNJUc7NtE6l50OKty6NSe6zbjNfS/s5uXbCYV8bfCnCLWUpUcOWFQqQ=
X-Gm-Gg: AYBFou2fcHbqKLTYMOw0d8a0SX0xzaG9EtnTKaazO68QyfmgnxnQ1kQlN5UZJAH8b72
	JyCoDe5fRgS/fojRNpb5ZnmsmPL0Mjb82Dcy9ZoFJuTn3BQuh/OI+Uul0Kd6PAaudk1eBW/gwtD
	NgzxZgYu+YbayrVGmQqPRdpzG1DRVIjz39nyECP/tOQfoM/0a4+G5joJTFhPyosVIvCOXNNviSA
	dIyc2OiJKp03dD/iBwewRyV3p2azjP0V3e7OrMN8FgnTDIMQdHBNDvL2SWazw5uQYPYLt3J7mnd
	HYyWSfUOopdwA1nKJv4xKwLRAHjQK5HiBjOw3v41g12bZ0gpe+/942ur8ldnEto1MlnAhlVkW0M
	9iEUXTrfXn0kvQijX9Pg5ghGsVPTi5iRl3GQFj4HyIA8DPtyfmWBfVLnFgft2s4uqE/hpm8Scun
	MdWJGPtd8lSDyXSl0fVpJ3MUBDCXRZ8jW3WwUmz5u3WlSIOSFbATL/wK9u7zItv+Ctv7fCpdleE
	Gi7/hGgY6GnvXMiimXCGAjb8yKKBsU7iw4WLIpwT+EVlfurDDuw/iHgJeHGAGOVoMPbQQTc1uMF
	5WMzUaGAIdP5sml2SV9PlLD5wV7F5/Ijfw==
X-Received: by 2002:a05:600c:8882:b0:4a2:47:b79c with SMTP id 5b1f17b1804b1-4a211f29fb8mr20172565e9.32.1792749848816;
        Fri, 23 Oct 2026 03:04:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:6877:44a0:5297:9502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21045df9dsm75761435e9.8.2026.10.23.03.04.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 03:04:08 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dt-bindings: power: supply: axp20x-battery: Add the AXP2101
Date: Fri, 23 Oct 2026 12:04:00 +0200
Message-ID: <20261023100401.67592-7-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023100401.67592-1-olivier@mgcrea.io>
References: <20261023100401.67592-1-olivier@mgcrea.io>
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

The AXP2101's charger is programmed from the monitored battery and its
registers differ from the other models', so it gets its own compatible.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index a90d558e7f86..6a0a0c3f052b 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -21,6 +21,7 @@ properties:
       - const: x-powers,axp209-battery-power-supply
       - const: x-powers,axp221-battery-power-supply
       - const: x-powers,axp717-battery-power-supply
+      - const: x-powers,axp2101-battery-power-supply
       - items:
           - const: x-powers,axp803-battery-power-supply
           - const: x-powers,axp813-battery-power-supply
-- 
2.39.5

