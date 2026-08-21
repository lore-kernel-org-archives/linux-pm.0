Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51E37AA74
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315839; cv=none; b=TFUVlA/e8VmbYueS9v2AVntOQMd5R3L+vpCjx8Owc2nwSFAPzIFk+WGLqGjn7i+GfN+vLQ+7Z+NqKM865U3nl1uTTQwxNF5FTfuCqOCq/qciz3Ozo5BZdrFd8PeQx5gL8OLgIKpiNbftBBe3yoMD7y2YlPWz+NHjJumkUDGl2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315839; c=relaxed/simple;
	bh=Tjd+qqKRlPATrV03pdQqCuwbNQZAlKYm8gvQMT9w2Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFzvnwY+ypLsaw41lRujZVRwl2qheN8hN6Upkh/j9PniJxbA10dDKl27QfVIodGat4WF2QdLw2Kcv9mqPtReON63mvhWfOGenpqnFAWFR8mCD4XoV4XA8KiPMeXIewsbnS9gYdC+nsqsVeu1LdnqwuT6g9oQ1TKm0YLZGFrwWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw7dt/Np; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw7dt/Np"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c16794450aeso141677966b.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315836; x=1787920636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw0S7j61Xivg5Kyv67PljsWbYXB5K5jcfpwkKzbAMRA=;
        b=fw7dt/Np97B+uB8XF07hJyCi1Z36S4oLLvsm62THffOHSq36iMkpCWgawjDi4wQRWs
         /vOiP7MetJfzyA4CJvfqH9QaaVobqs9S9z+A3HQs3WaMnKZ9OQ9t7CPcgaRbA4YOo4cK
         CYOYu/R3vn6z6kOe9o5zHaFgQvJdplL4BNTM3iiO8bhzCuBk8Na6HQlYca4ENRFKmm1S
         GtQbTF6cTbt1fiVzzRzsvjetGMl+5fSyNRVs5TdsxKmQ7Md0FLjNKZoCMFCmxCYDxVAx
         +ty04xbW5kCvEJ3gqef4FqMD20CVH5O5jTjIexZtKKTTWHOsrR966sygyvZHtZWBJw8u
         xhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315836; x=1787920636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw0S7j61Xivg5Kyv67PljsWbYXB5K5jcfpwkKzbAMRA=;
        b=dOI/vyJ/M+nLUjIrKYrMKeY35GzOTitWhii7BeuwTP0j0hioxpi2lJNFQNAHY5+hce
         ImQ78jN2wtp+JvrQqIJ5MQHSSdUNg+ZRnpIx1+xekfPX8HO48sONktNsDZwGv/xvEoJb
         2Rq6Y2+EbVQShGTP+0dZdHArXk/zCJacwFLgJB7y1zod/OZ6n4ZS4cEY6bu9RMuEMmEq
         K8KyjCqU6A/CBmLaWwbi+YwcKsmTudD9Qsxs6o+SiCvhaQD1QZHQoH6ZPT0KM8p8/pL7
         M3pnl2XZ6aVRnPxq09ZAv1ABHCGTE/z2asNjyfsxdtRPyjxB7XCZI8jGBvNVbdCyZms/
         JrVg==
X-Forwarded-Encrypted: i=1; AHgh+RqbtZUOTOM83hRb9e+2YaF9FCioUErjMOAHJR9ALCA6optcvKOhxsgrDFlyZBo68xjL+IKA0OEqMw==@vger.kernel.org
X-Gm-Message-State: AFuF++kiic2t+BnU3ADuX5MO/RDAfKjq/LDmu0AhsNZURAup2nZs+/qZ
	Jeo7NrVay8hr2/hejHw3DYqycPsE/DICBPEQvdV9/UNVtVX2dfQYab0j
X-Gm-Gg: AR+sD11fiZAelEZwBj10Hg3WoFk1spg0ukpC6WGdTE+lArAOxolD9iqFYk/Tis/mrQD
	ZX5+KOJw0KBjxmSZunasgRDZc27FIbZZKxnE/u7TehQAVg5BvAhjwd2cqsbA4gras7f94u1QV0F
	4aHr/sdoJIWlfumy1bAMZ9YaWw9LTiHbC5+8WqkR0PigRjTznOKXXL4gvA8sGMspc9sLUIWS4Wu
	Ok48JBpaiill4QbYIqIfNWFTbqPQA3MAgD33E1UWQwtcI4gewMDBzdfNPDzZY4qSflmHp0OaLwj
	oTVx0zPu6Spo4Hc6lcLkXdnfcCpdepFH6BuDYNUgy+ApDCW8iBgq1LNgvf9ZdiAYvKQrwjU2K7D
	UB+cWXLLoIa6owF8zOjZvcn/b36604f4v+1RB3zjdGBpEii/Csr6bZd8xKTYFQu4LXNn30BiDQw
	idmx0MFwGH1TpPEseK8+avQShfNGyNGx+iG66GmIcXKxwy3IAHpzMczMvdZe6v7xfBEfbEbyTnt
	wiHyYRuDQGuAxNRhxrYjn4=
X-Received: by 2002:a17:907:98d:b0:c12:b2db:873d with SMTP id a640c23a62f3a-c246a2ec634mr725649966b.5.1787315835633;
        Fri, 21 Aug 2026 05:37:15 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591e0397sm451194666b.53.2026.08.21.05.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:37:15 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [RFC PATCH v3 1/3] dt-bindings: soc: qcom: add xiaomi,taoyao-pmic-glink compatible
Date: Fri, 21 Aug 2026 14:37:09 +0200
Message-ID: <20260821123711.1579539-2-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821123711.1579539-1-zstaseg@gmail.com>
References: <20260821123711.1579539-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible string used by Xiaomi 12 Lite 5G (taoyao) so its
battery manager can be matched to a device-specific variant in
qcom_battmgr.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 16ad4f5698fc..8ca057c4e3e6 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -41,6 +41,7 @@ properties:
       - items:
           - enum:
               - qcom,sm7325-pmic-glink
+              - xiaomi,taoyao-pmic-glink
           - const: qcom,qcm6490-pmic-glink
           - const: qcom,pmic-glink
       - items:
-- 
2.53.0

