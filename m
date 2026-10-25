Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956160;
	b=gFrZezgNcpQMl2zabaQ9j4FhcZ/q36I5iHynmcfLQzOs+/OD622ClQZXGbmZkhXmB3H6
	 SIk8z/6AwYZsuS+IUgXAxgIyna3StDrRJ1s8hCDw+QaaXL7DRDtAMc/1fP3EnbX8F8tWN
	 0Qc2yX/7YM6TjWj8tMIG4GvK20pHPfqGOo20YkwztrxA06cg3qXg8VU9hn9Kjmafr8YQc
	 ihbYfOBl24QVG+tbEgtA8JZeO9UpLWg1ZDjfxPYTGjMZRwqNp0mcsz+s17MCdKvu87QG7
	 McLGBMm0R1dRLBSwLjP4CChy09zaQOZY5LTBIrX50RvYIDYNxnxhxLicOYZQoJbgDlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956160;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=Um/nwS5ME7MphJPeuJrjAiVQ3qj8NO8BRpGBgBHMR7Q=;
	b=I/99MfRJeLgTiB/oMGPFqKAeT1g7nst5pF2/4jbPRt3Sqj1vkgJS/CXlt0yAXg14f1XS
	 62Ky6seAg4iVt4BqcY0vIars3tlVs93QbVDFSiO5MTyxm+dXFz1ZnpDnJXBaihkYRCeHI
	 gZVu7OyAiSLXnQkOKBkDoCP4pFBkLlNn3CGUSGYS4DnayUo53UU0DH7SSjef2W29Yv2CQ
	 klUjyaBfeI4KT1N0/ixO/r1WgTgWk+Y+x0Sm5v7b9JymZlXzR2duyZwCPhG5T+AphQRyp
	 VLM2/bqW73/ORDCcLLT/WBttwjx57Qf8yTMv4qVhc5lWZZe2ZP7TP3D6p/XCqxYld5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=EdUZDh+U;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17589606A321;
	Sun, 25 Oct 2026 19:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17589606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=EdUZDh+U
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJMK11517096
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:22:25 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJMK11517096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956146;
	bh=Um/nwS5ME7MphJPeuJrjAiVQ3qj8NO8BRpGBgBHMR7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EdUZDh+Uwc2of9wlbsu6R7rGAUZWfj/KgpHZTQx7v4H0+fsAlPcyQhxIZEOoJeX9K
	 jp6+xQmMl80CzhpeFUJ4pNbN68eGiAVa4EvgDZzyRP/UGD4z24T3Pj/4fuSanrq5ji
	 jKCwz4GoQ4Zw9+dMLtaxTPEtTEVW7Xr2CwIE+IJA=
From: christian.koever-draxl@student.uibk.ac.at
To: neil.armstrong@linaro.org, jbrunet@baylibre.com, sboyd@kernel.org,
        bmasney+clk@redhat.com, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 1/4] dt-bindings: clock: amlogic,s4-pll-clkc: add the CPU clock
Date: Sun, 25 Oct 2026 20:22:16 +0100
Message-ID: <20261025192219.209137-2-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
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

Add an identifier for the S4 CPU clock so that the CPU nodes can
reference it for frequency scaling.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 include/dt-bindings/clock/amlogic,s4-pll-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/amlogic,s4-pll-clkc.h b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
index af9f110f8b62..8143c6c1486b 100644
--- a/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
+++ b/include/dt-bindings/clock/amlogic,s4-pll-clkc.h
@@ -39,5 +39,6 @@
 #define CLKID_MPLL2			29
 #define CLKID_MPLL3_DIV			30
 #define CLKID_MPLL3			31
+#define CLKID_CPU_CLK			32
 
 #endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PLL_CLKC_H */
-- 
2.56.0

