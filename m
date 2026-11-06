Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960379;
	b=0pEnxRzwMfMr40T2rYCTqMRKbFT/melEEBDmFdnr9xVuJNrta8tfKlrMCjWqtv78xAp2
	 NsEWuIkEtjJhqYXeG02gjU75yz21tYYHQN4GzKPVkjm7spV7i2DttXnssA4LjZ7PeSVFw
	 n3aiD6vbR+erJB0vcGfcDFR7Ku7GiehGB53GKKGEUo+CK7BVCvZ/vSNxfPHX3mdeBbb6s
	 QFk0O8WQQ3BrCiHFqY+cYlAiB8+w5vtx/3H9Zj5bOfLopNwYw4c1gr4ZZH3fuUR2IbRlW
	 aJ5ezaRITNK4yhE6i0QUePeMrzoH9JIuaVak9GuwTkbJcLfSDYUrLaVOWtex1HqQWOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960379;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=6QgvRhlzOA/wreBqMg52QNgHYNNm7XlsRj0cgRLIaiE=;
	b=ezQNYNBd2Rb4fHCDFL749WTNzfNQUOHduzOiutBXHK9m9SjjLOmZE8TAngPh55TLsNsf
	 icdXyPOKzUR1ddF+o/OZlAKVeNanDuClnojpCaYPakOS0jJDngjZnIlAkI9DMw/ANVf92
	 vUyYWfqmG7FMLI/w55ouzuiqw5l9e2stE5Zbh91xdz4UK+oDlHE7Mn4ej8UHqEvhV5p6D
	 jFTPgYBb65vQSGADEp/VkgZAawaPbunk8EzbC8a8dyAROUZfVAyfx5tja6VCPQk1ybG8n
	 9ZrtAj4RhG0X/VqNABTnoqQyCfT5iVlZQjvLVdt8ebDqXlbW4o1TrsDjdS2QtUSMiGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=q8BZ1Wj3;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31312606D809;
	Fri,  6 Nov 2026 10:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31312606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=q8BZ1Wj3
Received: from surface-pro-5 (ydWLT-U1-95-184.uibk.ac.at [172.25.95.184])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A6AJFCV1863929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Nov 2026 11:19:19 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A6AJFCV1863929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1793960359;
	bh=6QgvRhlzOA/wreBqMg52QNgHYNNm7XlsRj0cgRLIaiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q8BZ1Wj35fLCS3WMlUsfr+GVTwFzd7K5aqk9Vw4j2NPOIdz+gpLHyPrBJkdqFDXpr
	 8zjahMZw8EWwrumwt0pcZFxiOfAKD0Q959Qbc932gMNnP+DBkSGHgK7sToEYdjTs71
	 YiPmhy2AsRgGNDw6iifS+YpMgHYbqVkwhsNozh8k=
From: christian.koever-draxl@student.uibk.ac.at
To: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH v2 1/3] dt-bindings: thermal: amlogic: add S4
Date: Fri,  6 Nov 2026 11:19:11 +0100
Message-ID: <20261106101913.46664-2-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106101913.46664-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261106101913.46664-1-christian.koever-draxl@student.uibk.ac.at>
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

The S4 temperature sensors are the G12A design, but like on T7 their
calibration value is only available through the secure monitor: the
ao-secure register used on G12A holds unrelated data on S4. Add a
compatible for them. As on T7 the sensor index is the argument of the
secure monitor phandle, so one compatible serves the CPU and the DDR
sensor. Each sensor has a bus clock gating register access (ts_pll /
ts_ddr in the S4 peripheral clock controller) besides the functional
clock, so it takes both, named.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 .../devicetree/bindings/thermal/amlogic,thermal.yaml         | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index e72cb39ac635..66dd572ff44b 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -23,6 +23,7 @@ properties:
           - const: amlogic,g12a-thermal
       - enum:
           - amlogic,a1-cpu-thermal
+          - amlogic,s4-thermal
           - amlogic,t7-thermal
 
   reg:
@@ -84,7 +85,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: amlogic,t7-thermal
+            enum:
+              - amlogic,s4-thermal
+              - amlogic,t7-thermal
     then:
       properties:
         clocks:
-- 
2.56.0

