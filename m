Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794762717;
	b=NEXChZvFrPkFdI1XAcfOjOWZxIDZrm6dm3mWKOMGeNOHZsOnrXP5ZFDYf2UF8Pr8DWHk
	 +nQN6GgpSmMoozOhLr4+WY+tH5gAeC14ruI7ILXAuAY6rdOlzdwM8jvv06pu92J2EGcX/
	 mCcpVz0SEF5p5D7URRD+NI8oUH0NFrYhHZ1D8iyNKWltDi63C00B2XAEtw7PQui3EHuYq
	 AzHxn24J8WW+83WasiilqElsX5oj6mW3MAWoopMb70z2aSSN2NP4hygE3IiCGIFIrNr1r
	 idA8QbjbEmmmsmQFoUUOTDRYuoBxu756XWIFqcIyVh38eYexC0C6OZA+5hs65GwMcLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794762717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9RWAF1oftI93lc29ycNPKrjj2FPFv1qc0l+KG0PO8Bg=;
	b=V9fqW1UOkI2BUTPH/QCRIjkJjaB3BRYXwbIjdCQ5U3iAecekkFAKIjqWzdiGh7gXo7SA
	 cqgWYNnxVi8QV7TXRPkRwzb7BQ/A38m92+B2Jy2C8aKZ9YVO36DEmZ+Qeww5pu903o1JN
	 RokhVUvVe12YGZh2mvN6D/uJXxFXRuGHOlX0LS7qqvPICsQ8DaJtBbt85efviBS+PKn3O
	 AAQ2iS2XGUVcvGZm9/gkQaK4pQXu8kHvR+FfMjXfKhOycL2j1VBSBWmkdQ2cvajNXe1tb
	 KGsY9A8ql9/0e3z2zi3CzauWaDn5p10l1qjvCHHqxisVqI3QY/v/hDgylY6eYLimsnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=wQG4Lgwn;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C5660A2615
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 17:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C5660A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=wQG4Lgwn
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso28990375e9.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 09:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mgcrea.io; s=google; t=1794762715; x=1795367515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9RWAF1oftI93lc29ycNPKrjj2FPFv1qc0l+KG0PO8Bg=;
        b=wQG4LgwnhzHEMVFNFqIAFCh4ieei6Jjq+uMiSAV7Cqo9m/VbI/po3ETct3qEodVq5D
         oR1GyDi9JCZ1ftpzspqj3A9OHoJOUX0dQhJ66KITiAQUKNGil/6Lqw8rxdINaIoRsXAa
         OMBvj4XkL67qTdBSTgbcFY2EqOlUAWU81SRAJ4snrrb5qe0qDl1PUAuLVxe1kPt5NO7/
         3v2Ne6ChpPq8VtW42ffwPk8TTKGc/ewkUeItQgsRFVQbVPEurBUllMVypBzmfHgS8EWr
         aET1APTLU7SKuGdMxWxZK6zN+9/oyLfpOwCipndmP21Q7AFSvbzaTmHHZkV0wWr/2iH2
         dFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794762715; x=1795367515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9RWAF1oftI93lc29ycNPKrjj2FPFv1qc0l+KG0PO8Bg=;
        b=VdypTG2PRPOUDsIXOOAm3dOUwbtihW/3yskP404vpOZUiB/cIMaw4EmN7Ydvr2uz6c
         7OoMmrREf6yhhmM4QSXsCn0TIO6Vw2cSYkTZJ57EOl06w79bbnbX08F9ScqHK8gHHEri
         ksTrtnV5PmVhdvtf6K2gr/Hp84zaT3uwyYF0nPEolz3ebiVFcr6/1UelBCPb0m7i61dt
         86XV3oyRRZ1xPSQc9byqBOuxH9lk7zKclM9Ajabr0YHwHSgvuGfKPm0NxDw0/lirxcZW
         vhadpGEBb6Gac1YpJmwfbMVfxKKp0j82SClZqGaEo0dDUOjHeQ+Rl80rwABOTRKcOne2
         K+1g==
X-Forwarded-Encrypted: i=1; AL+hErGWpfy/n2acjG87mFXPVtQRoU/vzjVfv7bIQa1Yey6TlwTsLRE8E3tQxZw3p3q01Qx5mLenVcImGg==@vger.kernel.org
X-Gm-Message-State: APuU4Z83I5NWzEVNsxj2Mzv7tH5eCCv2CaVwLKcX0xnYQwTowlMFdwWO
	e/hhgE5fC/Np8/yIt4GsBqAgsKmfoE3GIu65ppEAC6wietjcDEWHVGl08RSIxamvLQM=
X-Gm-Gg: AYBFou2/zSpgBio7LWjKrBOhfI75aquqyJmq4vAhRYbLnHxy3QqwF5YzXBlvhGB7CG+
	RWUX81NUWBGZEyaiyfdiZQOyvP5xD+nYIHoMoh+UjXNBdlu+TyZUNDxWgKeHAZauqtkCHQ+55xv
	399a+SMMunRq4miUSamGWwV1/R+KxnhMyyqWlZHiURKkbdfVJxU7x4IdZYJ3Gr+TVyyz6PeW2O+
	YX1jXln2dUGm9+R5RkDjIN/RiUNTTMxQr4UAMy4/v06M55QMdMhs8JhSf1jKIXYh4r6p6OcHp5Z
	5QUp7VZdfFu4SJXC+OFPpzvj0kq2n3E8O7lR5/lsWw5mDAHWms4jCf9OFB1XWTFMaSJwbmmhg5y
	e9oPyvpgTXAQ/anm6qLOQy7GUaw0C5uO1/HpAmPDCsNNLX1WsetsVm4oP7BPN1StL+RddGNU2hV
	pCU4KJG/nKKphxHgJrT+MOoxT55ErTkVSh3M1v99t7yrWqwrXfYof/KiIy0R5sBBy7vL+unpKYr
	odp6jG3CTm4QZe6ujs9egUNdecfikqF4OT7rmlmc6ofDsaq8tZE4XypU4AQhfaHhapxZ+tL0rQx
	HcLs2qGJH/G9hHUBzs4/0t5Y8/8wDT1QysbRo90NjLjslD958qJvd/dKeD+Cj/uR2xt0/H6q9Io
	MllVeC0M=
X-Received: by 2002:a05:600d:82c6:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4bb55c5f5f5mr209711325e9.7.1794762715464;
        Sun, 15 Nov 2026 09:11:55 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:b9ad:41d3:c29c:11b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac0e1esm205418705e9.3.2026.11.15.09.11.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 09:11:55 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] dt-bindings: power: supply: axp20x-battery: Add the AXP2101
Date: Sun, 15 Nov 2026 18:11:49 +0100
Message-ID: <20261115171150.64431-7-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261115171150.64431-1-olivier@mgcrea.io>
References: <20261115171150.64431-1-olivier@mgcrea.io>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

