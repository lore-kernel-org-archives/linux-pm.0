Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864302;
	b=GnpExYd69B8/q/9c4vQmPjQB9MGx/f1o6EGpSrnrXIzaf0186mX3E03oEWuPl+BV+jgp
	 P9YFw/lSPJX8d1KvREBVzerRqllP7b/EGw9+nGQ3Qk8CBx1uTJ+gmtdRtkZNxjJb3ZKqj
	 jxn5PCxx5kR0xKao31TU1fWeP9zyJHOozNcNFAfs3iulvqbozCONGbdH2W7IrHXTWv1Px
	 PTL/G5P8rs08vZcyRT0maa8XfwZIDMDj4F/QP57kNawcQLXAu5Xb1vdUldRCN1rj97zJh
	 VINgRY1ZOOdfQqqezJSkpXvQj5OglshxPYWACZ2v2arjNkMo1EL3T/KxghhdYdEkB1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=S29Bz2Ne+XPBujKOM8xk1WUI0xBpcjEJIagUum0EBnE=;
	b=3bDMZgcxUlq7hPu+4FcnL87U6XNzPX6GM0YNmdpmQts3KHpS3h473H+11oTA+J//zJpO
	 7pn7dGkdYMqMSrUUFRrZxJIajZIDs2kD0708KrmhsEoYx+NpnanDlnXPiWAvuUyvDlWVD
	 8L3NHlquMukntwxfrdRmzQ6OblXh19wrTKqdNRbCM3h42s8DhRSC9cZjsffWxpZEqkiCK
	 AVK+1Lp3Yul1kIJOKepnRQz1I2D4H5ugFm3e7z5RmZoj6Y/vOzcOU5YDDbR+B6GRLj87k
	 wjT1uaQmVcEigVVwp8VXaYSXvTb29d9wOrtPg84xSdwcEycoCr3Cj/d8dBqLcZ0u9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0aKjn/XL";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E0606A33F
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A6E0606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0aKjn/XL
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so25155645e9.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864301; x=1795469101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S29Bz2Ne+XPBujKOM8xk1WUI0xBpcjEJIagUum0EBnE=;
        b=0aKjn/XLzFlq+ouSLmTYWiErYU4NZycee0SYeWHS9aLIe0k27WBTRX6PuWRoYn4h/w
         osp9TkJMyV4e5+eYgwb/9Uc/gLhNZxiGr/cttH5JB23s5talTINxpiOqouDaU3q7DwXB
         mwpU6hyeU/LjWu661kwdEwa8YWFnc3lth2ve0Sqe0d48lh+EH/wFJLkFUox+m6kZw0dS
         J92PxdfemEiGhqmuVA2SNm3IqPkf9BqTxF/YNUaHrDdDhx/nSjKqb0Hx0eq6ATmkC5Rf
         fjAx65WnzMYxrFtCFvtUBlwnbLTSo3jUeZRGoWgkIs6XsEOOy781KWog3D0urTndgUMR
         VDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864301; x=1795469101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S29Bz2Ne+XPBujKOM8xk1WUI0xBpcjEJIagUum0EBnE=;
        b=d1J4XxlgSg1HGhmXNV/1/IeaB9onqN0rLAvMJRM6H5vsVc5ly6MoG2SLOiB7I4K4UJ
         xcx3Y3OiDUytLggvWwRTmwbtr7AjIimbwnhTW3vquh7JX+J4VLbDo/3WVPPx1WJlfvC0
         l11hmFx39SBYc13hbRlw+dr+HpHQg0gLTcnhOKcqRV1KhKuSXlLDFo7aT5QtDtbmice1
         mNTYFGpv9DZl+XJEOIWuSSDuAYComKRfUnisYQ+ZYJCWj92ZySCEIAdTn1mhpUQKfAOz
         oxmGu4UvIkla4Bn5QzFwAoEXhZHj+3n6+H87AondGsHvGcKMASnNV/nRJ34MCUWZv1WK
         Srhg==
X-Forwarded-Encrypted: i=1; AL+hErG8e7w9vH9+3Y0h22KKxM8+YDy9COWoPJX9w5twkT9Z2iboZtvZK5SYVAUrQEV5YqnOpw3VxAOwrA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+YrQT23xPQsgy6/FlSesw5pve0KojQFMeRzb2x473Ap1TdGmM0
	qPR9UVevmXVjB2wP8UB4Beg2c2klYdNWCjOqQZ0l4GjhzhLlBchU2D5L
X-Gm-Gg: AYBFou2aYbsvSU21HJq2mtnhrH0wgp3Rh0+P0XzVH74TCimc39sDbrgAlT2d7Cq0bsh
	WQm/7lwz8Mml9k45pDCtqYeD+XMDzNPYypiJLfeaQqUY7+DHuLMTdAYpQmv2J3VmniaW1iYr4sy
	ahiifXn/4ddbBsUZ47MjW+rlmzKLdQ0K1W+YzZK205KFDQVOvVZ6CBhiGqSOjlWA7F2rLJ64wCf
	ESL4eSJanQosRICCrO7c7i8FcfqsWpJaGqvzKPtOxr0iZG3i/e6CTGbkcq4rXOxARxf/Liq1PQo
	h/pBiaX12QvK8ZYTyLs95maUHfgVog+eJJVMAx1OgM2Y4963hqR3NNoz0HDn9Ey7LFLtVBpfin2
	IGw9CLcbHsIGSGl8i7bf8Sk+hC+WUb2J7SUyzHwB5JBeeXHJA8mfyuQ2/lOYC5CXPCSy2xtkIp3
	j0iTiuTpNbAMvCYoPN5vD9DYlLxaclmhQvi8jSJD7p6IstJCN8H0Ismx51muvVIc4JBndxSqoGL
	vsJuNrQvUpmEOravmlg4ZCE+qSdr2kOvGFmc3Eano/WSWwGLb/dRu8rcoKTRjN80PM8njPnlHRn
	GmXRmG+R0IAT/0JIl4566SV8fV89bYmg+h+MgDf9
X-Received: by 2002:a05:600c:4e13:b0:4ba:38a9:85e3 with SMTP id 5b1f17b1804b1-4bb55a47fabmr248067435e9.12.1794864301100;
        Mon, 16 Nov 2026 13:25:01 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb734b9f44sm61928305e9.1.2026.11.16.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:25:00 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:24:51 +0000
Subject: [PATCH v2 2/3] dt-bindings: interconnect: OSM L3: Add Halliday
 EPSS L3 compatible
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-halliday-icc-v2-2-6df8fc0e0620@gmail.com>
References: <20261116-halliday-icc-v2-0-6df8fc0e0620@gmail.com>
In-Reply-To: <20261116-halliday-icc-v2-0-6df8fc0e0620@gmail.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864293; l=917;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=wd90pl7MHpq8clj67rbDiWzxPjA0DsOg6ijADlg5gec=;
 b=pz/bm+cpBSVda5rEAkb9kL+2qT3hhvKvQmxholpBFeOsC/Cid0Qv8sM1w+T+AtXgxc4c8y4H6
 3jNx4bfGNe4DUgR0PLStj8HXNjGipU5Am3ti1DyClnFNFIdI5YKWoXd
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the EPSS L3 interconnect on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index cd6685683bab..6c3475005a35 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -31,6 +31,7 @@ properties:
       - items:
           - enum:
               - qcom,eliza-epss-l3
+              - qcom,halliday-epss-l3
               - qcom,milos-epss-l3
               - qcom,sa8775p-epss-l3
               - qcom,sc7280-epss-l3

-- 
2.55.0

