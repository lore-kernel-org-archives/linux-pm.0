Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956186;
	b=Y/iIoLgSAFSf+mrYRmBxjlgI6sdCRi2WGx288nWA+XHZhiZaHaXrXHZW+TP2rBUO9+nR
	 ENl+U8cPiUb3ynnHGeK3QAt5DqorkpYSNq7vRg27csQlN2VN14jYD5U9rYf1kGRamkTkf
	 73M84epbA/K9+39/t0z8Nb07IlM4zVGHcT+bVezI0p426iiL+iokfKjF+6Z4yhP6O902X
	 1GLtdXsJK5XqF4pSLLl3Mtl3fWkN/oiRMqaUVEzbZ0mWXaQg/ILPR39vCofbAbudR86wd
	 zj+xAV2sYGvrZ4PKCRMwBV/d6gCYm9fQKzibqBhqfJnGJ9K5ZhQUdHoX84VuhWTeeNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956186;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=CaHVn40SG9XkdMVUx/YoBhUJDWHNChhywgvcaAYGaI0=;
	b=rXif1D3F3y19fPlR5iT6MnXgWnGUny9SQLTkUuQvO04KKy/uEnpbo2adFOdh1VvycwQV
	 FlVo8xdAo7JAnKAyP3e3fyMJHhH+DWQeI2ubJYJsPXfKXkY6pYhCtdxXv90lwMv1HkiOa
	 J4ll6LDoFdIGPQSnUzA47LSaRoI9Ku5/DsVtPWIIy1fsihmkJbBwXo0k/a+ELDsMu1Kva
	 n7F1WmqIkYxtbcnLpkF5MerjwzLniN621r+Dgd0AzHkpLhYaDsRzsJJTeIMD+MdBDC5zx
	 hqbCrrblbk7vXorkEMROK31CYVJ7hPRR9d/LIhdFaEAFKrUWUwS3tbl8V3KfYpM62LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=fZJlgvdp;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9F606A329;
	Sun, 25 Oct 2026 19:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E9F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=fZJlgvdp
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJMjme517433
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:22:49 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJMjme517433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956170;
	bh=CaHVn40SG9XkdMVUx/YoBhUJDWHNChhywgvcaAYGaI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZJlgvdpxyYxNc12n2n9D6pfNR1T8TB8UiKJqLOdIQymdvKBVTRnwYXmi1yhziFrO
	 uXxvdcdTqiGshVtc7AezgIU2yXqgYSB9cSm34eqhLPGAqQLhjYBbQYeQBtP3bFzPMc
	 bFp1q44VRXpW4sWXwkf8hcKsndanG+yXilhv1g8Y=
From: christian.koever-draxl@student.uibk.ac.at
To: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 1/3] dt-bindings: thermal: amlogic: add the S4 CPU sensor
Date: Sun, 25 Oct 2026 20:22:42 +0100
Message-ID: <20261025192244.209256-2-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
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
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The S4 CPU temperature sensor is the G12A design, but like on T7 its
calibration value is only available through the secure monitor: the
ao-secure register used on G12A holds unrelated data on S4. Add a
compatible for it; it takes a single clock and the secure monitor
phandle with the sensor index.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index e72cb39ac635..5d966ab4d820 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -23,6 +23,7 @@ properties:
           - const: amlogic,g12a-thermal
       - enum:
           - amlogic,a1-cpu-thermal
+          - amlogic,s4-cpu-thermal
           - amlogic,t7-thermal
 
   reg:
-- 
2.56.0

