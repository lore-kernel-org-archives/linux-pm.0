Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778429;
	b=AohleGFs7xwhzpKS6qVwhw7V69t3/ujr9p4BSAfnOfJnJZY3JSelMbHzTnTTWp1YB+4K
	 tbF8S0gOd7Niq3xOMb3ApfBmJ7cVIi/H7elI502uBFM0uBeZCgEUvRWpGf0JiRJQC+rWh
	 xb0Ay2eYO8So1ahWKf9LXXVbuemzZYgLsl5lhL46fuYf+fYNmPHSlHbPKBXaAje9QwDQx
	 qMsJ8L41xFniENr7tGhHayQbUTKZGi0slBtx8pgdSDqo9tHBkvrmzlhbGAmiBr7s+EOYk
	 Hf+5TrmU41bzAwJtThq0DnW2/Kj4VHNEtJLk9jdOVilBArW0Xdecu4glML1WE3nTYBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=J6yu/WA+9/TduvIgw8i/6/eU7fXdqXxpE3Xb+fSN5P8=;
	b=NVBCNiec2hWWutknqBjRE0KiAVVG114hnXMVDnJ/WcSDhKOEbeIqas9yjxkfx9pxe70Z
	 ateX5HQP8hi+zrSN/SGCKpIjVA4OqrRYqabo7APFzWjaaJIANZm6TbvsXP8PVUTO6bMpc
	 7TZZic/No/8Q/Hl8AdI74c1NL50DXi3fsuHahy/D6XJXPE/9ZbdNg0H2enIJ/HuFSGTiL
	 q9KyxUgk/Wt+0O8Z5n/3F1xEALaLTOg6jmYIHpxiOUKuh9i2JtDraJK3yAnJ6DDgMpvLM
	 O42gOypNuvRxagCzDsGkKjvHsEB8n0CsfD5Z/gxWtA1TATtrFXZv9b6fKCvr1NRFWqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sl8t+O+K;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B24606A326
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 07:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B24606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sl8t+O+K
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a18fc7a38so866917eec.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 23:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793778428; x=1794383228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J6yu/WA+9/TduvIgw8i/6/eU7fXdqXxpE3Xb+fSN5P8=;
        b=sl8t+O+KsQyQ5DSrejOdiSjykamgCVW3ly1JTuZRkT2dhUs4GoP9/ThyCQGBq/XCCp
         U98webc/Ysmoh7c9MJY3B5oI0yPCgntB/GcL9AXhTlIWSK5dygUBPvtaa++R2IgqaOwc
         zncsdYfkB9nhgfUkuqV4dxLndUwnHg2X9ZS7Nm3H8HIkAU5e6QZUSZrWfK/IGGrwpORd
         vlEbLyuIsO+aHaGtUKKT0QXkAnEyY83eAafBQ/gK7LcQOXlhYuE1e/IaBdGbUobFbizJ
         gKELP86j/916+BNlfrgufWSt7aL+7ggPX5PPBcSFgpyaQEhlHk4mx2oV67aPqyfjc7sm
         /gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778428; x=1794383228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J6yu/WA+9/TduvIgw8i/6/eU7fXdqXxpE3Xb+fSN5P8=;
        b=nhvG1pI+Y3PFOCrLQv036kRP5Z7Ow1tyNh7S+KcdrkqOCGvMWapY0npYwuvk0rHEH6
         zMqs5k6KGKEkMWnQm7tV0/uzMYmYuzLwH/nLNdH1PCc9yJKHmHV7v1DHlCN6b/edMPfb
         rtMWNboXbVX3WVDR4iNsyQomMKu+qo7z8uQYO22Iddk7PdsP04rmt2Q7Xoo/DxOG0oQk
         V7G2I36o/t1xj59NcJiN4kpuvwfYo8DkdahnJz7SrA/2nEbFNzDq+tZYWIlYh/2M2GPh
         QhqoFrfrPJIOKUHcvTnUA7xa0Cxwr+wnzQ0TXL1UWcPH5hhUQnmjSWRRPnlVic+CyE5c
         qb2A==
X-Forwarded-Encrypted: i=1; AKwUvBwmAYHiVXWR2EU4G/DJ2UdjYtSzNN09nB0lj5FzNa1SnRIMwGyRVB4Oh41Pn4+LJndd9TZxF0roAg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+StGj4gKK9Ql7iRByDRJNOBU8oysB25Ztl3SLdjNomy/RGc5Sy
	5XNJ7kTyIhHwkBXoDssJq/jVpsCEJobH+GjnWKT5xPaVaffuFqvsrchPkxFeoA==
X-Gm-Gg: AYBFou3Vz+N+3o9EvhI0Nh/T9wDdhbRUxgPtEfkLeJULVzRIMLBU01vtnMl5ZEAkYAz
	gQoqxkGj6L4bTYSvu+RTt4mwUgfy10I8ElaQxgUMzkxSVL2iG7PBaqD7G4X3ZhSfZJZK/l25+if
	T/dk2WwzRTurvzwt+nJhEidodJfz1/lR/LM+d6cy4xNM2BlhDaswRLQEf4cq3r3w96SJfDk5H2q
	hGD895eGL+0OHmGzrIfKbXwOO7guMTy1L2jJP4oxyPxBw7eWubM3B5TS7OWcHrpdHUWmgAwGyij
	sNKMZ6oTWaQkWq/SBpESoAU52xnoZzmP1bYiZ+K8jNj9nKs1Iw+4niISfA+c3uh+NPiXdGR2RSs
	VpWSQEPAZqDyhihxpuMeqFVMhk77JcK6Z0hFY7+ZO5jhOy9Hll0U5eXCSAjr35fVLYUEk9xqH2p
	SmTAMz0AbXv5PKmqvSMjkF0pOtmDt90rxXRoUVjWx+O1x67RuwDjEkXyI5/Fr3bxupG1IQPv618
	twHlkuyBF2rXJlwB/zBk81Q6wWhD33GSR3rQIgY+qcLn3Gl7FsYquN1wdnZRaeDEql6FlfSF+h+
	J4xQ30K9fPbrrMd1oh7lYw6Rr74pN/3jqvjw0h+5IwA6zgPb3uS3FhGIb5EhiWx5cfDNgyIrlxs
	zm8Rung==
X-Received: by 2002:a05:693c:6316:b0:36a:7bb7:4609 with SMTP id 5a478bee46e88-36a7bb74690mr7403733eec.34.1793778427751;
        Tue, 03 Nov 2026 23:47:07 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.204.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm4566016eec.8.2026.11.03.23.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:47:07 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Wed, 04 Nov 2026 07:46:08 +0000
Subject: [PATCH v12 5/6] dt-bindings: thermal: lmh: Document SM7250 LMh
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
Message-Id: <20261104-master-v12-5-57fbe9eef978@gmail.com>
References: <20261104-master-v12-0-57fbe9eef978@gmail.com>
In-Reply-To: <20261104-master-v12-0-57fbe9eef978@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793778372; l=839;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=I+Xei2sZyAD45OKuTBmy2G1nFWggAI0hWE7RAd9U7rk=;
 b=GV9sBUWE0iEAWwIlPa/SGOrrN0lri3O7hQcwiFcVGn9liKszfRaOKsyvnpyVcbDKLNf1fDcL8
 39Nm0QD11IADHiNAZse6CTtX0O+2atStZ6s5c7Npz6bntVLNBEkGcjo
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the LMh compatible for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index ce72347e2..b8da39f8a 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -26,7 +26,9 @@ properties:
           - const: qcom,sdm670-lmh
           - const: qcom,sdm845-lmh
       - items:
-          - const: qcom,qcm2290-lmh
+          - enum:
+              - qcom,qcm2290-lmh
+              - qcom,sm7250-lmh
           - const: qcom,sm8150-lmh
 
   reg:

-- 
2.43.0

