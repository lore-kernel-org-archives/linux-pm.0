Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184415;
	b=tIofGJh78M1EtNevkYYIalt0u1eH18vKuxY9HtzAFau1IKcw4GnQw2sHl+eO0E5VT7bS
	 dDjM8fxfyMPcWly1yWcc6JTmZyhpI4s69Hp4HrQ2uumIf/yJvKl5LUpnQxO0EPgYobp3G
	 FKHrWRHqKAuOE+u8Yp0HSKef1EkyqShDUlqYwJuwhmWkQW3ErgpPGeLgTGKl8LGk5M5Kc
	 TIpOJilvRji+w1hdbwadk/iMUJVgs3YN63ElUrRZBe7XxlMMWXSh7doSW7i8KzZbWDGky
	 OtzfvrWdrBUeJvFOi7Apw+ObYRVjuWZ7qf8gUIbwUOkCEbqMm2nijDWs4qPGSJuhxjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=x3Zvaf/6knxBP4r88bzQVxogNYmuURJ/Z9N4FNNEXXM=;
	b=nXnMwx4+XmUmyrwNp5GRRp2M98Vu2diCMbgYGhSY6wfzazLIiGhI1baiYgS/P02nbaRl
	 b6Ri3zZycnNpZ2e3Y7M9sojPQMMo0pmDesa7BXBUxxJ65gshQm2gPas3qZwl3zyI9EWxp
	 bbDIBZkpu6x3tNoe5CAR7MC/DPaWRX0gxJOBxSQl9cMLuzGHcyXz1kTn4DjYguBwCFWI2
	 4Xfl7nhbEzq191DwLJfT+n363h0m1ZPkVTHNQv02XYPqU4pdgIrSfDNRSjFfAxbADwvSU
	 rofujtetNlXfzjLVQ9MA/nHHarji8l5Ia36zzWlehzt7fV7Kvt3tEK5e68PQCFlOwpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DVeB/ILu";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B1606A33A
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 681B1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVeB/ILu
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so2206555e9.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184414; x=1794789214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3Zvaf/6knxBP4r88bzQVxogNYmuURJ/Z9N4FNNEXXM=;
        b=DVeB/ILumBTLtGhAnK9SThmzeGROX65vDDXvaMLZaeOoYlcOfAZJzCyt6um5mYfHDv
         Y3VcmUpi6VTDyzOrubE+TKxzkEzeV7DSAlF0WPPNZOCE3moVlSnmkE+1qezIdsBohAmP
         a/93IAhud+Xk1IuhtXMMbD/9JTprYk8GiRs8RDQKDOz2ajUzeKy1jt8xEeKQ03ZHTNjl
         KWqIgDs77rGbxNx92twtTmLWRqapsVjV3jMP0O+gf6wVsaSd0oWYgtJXqPstZO6rnlkr
         fdQkYrgvqlA/v1Pb5mWvu8AR3xbxLkneLZ+FWfx+DKb2+C192KWMt4IWysE3CQA4Jrx3
         3R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184414; x=1794789214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3Zvaf/6knxBP4r88bzQVxogNYmuURJ/Z9N4FNNEXXM=;
        b=R38bK8Me7XPa/ZB2XX/04m765auaIpC2ZBgegUFSCrMkqYvS7XaAXQg6evBQRxzZsn
         LAKZceGFmDm74JaC41eciYImuj/Rb7YhQGKy/5tr3j8Yj4ZIPZSJegAOfHBdFRtJ7rJN
         7pyP42Lig/Pf91FN49QqkUNlsMG9hxANqZGHCmVAqJ2lgaqJnQ2h0njETKW9ZnNzhH3b
         61gb/GG8B5nNCfD0K79PjCnillRsM6B0JiUu5Vpec7YlaZYIwWj7mvMUc5hjjbUxO2dh
         IUntVu94q48+YlIB+S6pBzLsgD6I9BF6uhkYXwmSaW3wkUjOpvb+LWy1P8IpAZWHzScD
         K2BQ==
X-Forwarded-Encrypted: i=1; AL+hErE7KV4UMQB+CEUXXtPJtNHw4rB7Dz34Gvzc87HE/eYrwG1kQuIPpvBYuH9Dtsbgvgd5De9PxHK0nA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+a6cHQ4YA4k6kfs9TVHIEsWU4hGdrnCPXX7LawtASj0mVLWNpj
	7yq3VUR682ZZ1KUpFLWVi+ts59b9rMtq6t72pV+vCFpYJAu+R+5F+vHZKhhL7wQSpUI=
X-Gm-Gg: AYBFou3O2zOoIMk2eYLjblQZAZewck6yteZiLuWLGyC/6lR05O8ghh+ANyLeBliytgX
	A39eg1b+rdJqX2UWPs0AuN6QaOAWaRA0sg4ACT3Nbd0WUSZeSEcVnwVOVrfOtzypXaHCZ8vQvLd
	TMka7D91oR4ULN2QasxX3VlTl9ZQYypMftAZewUGHqY3kpZi7XxuOO3gXPzJjwDw3sUN+zt/xBd
	5cCdisQuW5ffVo0+gm/H/ev7we32SUqEDDEOx32olR5Shw6SoN4Pq9D2iwO5x+F4IJ4IOQjf9z1
	fuX13yPO7tD5U8cTlFHIEI4Dqu+hQlVq9Y5RsWUJaK72qPP534FIa2TfDURkySf7Y48rJIdVNa9
	OCahLlhADKtcPvi/bZG58VFoEvm+XTu7nh1jeMprssumXchRku7jg8souJEvPkFmtLJzuWXpcoZ
	nJIGgMY9UdtFoSF+7/XYDJe1UuAzTr1kJAQevA+ag5hRZi3IE8SbVB3UFCt9sZP/L6CK4WJwPFB
	R8JZ7tUbQgHcXuBCfjswqkaXUe0Za+/bE0jUvpug4AFnUJiZUjwOzgGELm30H9mj3KfXRtMfGtl
	uIpK5NoTlJxjb7/YVlcK03jZWGDcGTAUE1uUyy6l
X-Received: by 2002:a05:600c:8506:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4b963c664fdmr50119595e9.7.1794184413846;
        Sun, 08 Nov 2026 16:33:33 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:32 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:14 +0000
Subject: [PATCH 02/17] dt-bindings: firmware: qcom,scm: Document Halliday
 SCM
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
Message-Id: <20261109-halliday-dts-v1-2-289114ab8197@gmail.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
In-Reply-To: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1033;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=mntziyVI6wQ2kSkSteAmiaUttlX3LQ+YCHknAe0v+s4=;
 b=6KLs+gQMEgAdwwaI8XXKZHARhr4EIqJqXke9wpzWMnotth4jMEZlLGfBGwMvNoTpcE0tKCN8v
 aRJBBJI0d5iA+Opb629gN3RAQt1TeYIjZdEvW3ChlNmIbJyjVXak7Mn
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SCM on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 40a267c54b00..fb3da66443ed 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,scm-apq8084
           - qcom,scm-eliza
           - qcom,scm-glymur
+          - qcom,scm-halliday
           - qcom,scm-hawi
           - qcom,scm-ipq4019
           - qcom,scm-ipq5018
@@ -225,6 +226,7 @@ allOf:
             contains:
               enum:
                 - qcom,scm-eliza
+                - qcom,scm-halliday
                 - qcom,scm-hawi
                 - qcom,scm-kaanapali
                 - qcom,scm-maili

-- 
2.55.0

