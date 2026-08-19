Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308A481A9C
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153267; cv=none; b=mECuA1Z9rMtUPU+6bf7oRBuY5c7X1puRcptg/j+jW3r5Q03sylh4KRmoDURiE0xlp2raKVs7XMQ5eMvslKquvpyS/SGt6n+irXy/4xHbbizWUFQuu7lvJHo0rPxftjToIu6YZNUwo0ODGdqJEu0qPzyGNY6D0tkl40WnVST2mB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153267; c=relaxed/simple;
	bh=Unl00eAfFi9To3aFPzg9GlTfdXTVfm9Q5VowGJ6jvsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pm8qCrx775/PMxmu3L/hVkGgJ3ZafE1w8VPhKNhL5KK6LvLPFcHeJ7qsEzI87p/PJKQHhbNjnLKI9NyKJkM8fjxdd06BIsgeWDBA4glZjOAlabgP8ZPXiQmCLCDuHyw6OUX3CoUHgw/T43hdloI8qXjzQ017WjrdtlhDDKGiBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmC7/ZnM; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmC7/ZnM"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6ae8c4b9822so557825eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787153265; x=1787758065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=UmC7/ZnM1yMfwnNWSrK0kOoCj8KZm44RRrUsiZcDgDHxhbWwGSEiLV4Yovc4i4o9h/
         qnoXjCVC5NsH2rpc1BNt+PLqOlQMbIHVJZHPcMGRxFnOsS4miRDFqnh3E8d/lGstT06E
         1l5DoN8SnxF4PpwUoygAHPEOcDdgAbjcF7Teu4j1kDZwzGeEqu/iYqodCe5b8FjFplFy
         Sb4jZMjyqTqnaJZexSXbTJobuGmV/gC6ukmUvwxLyznZ4rklgMkb9OuXGKnF/mUiSWv9
         biKPEBenG9qHBZQCAgiU91lOUBqyTnywqQhFZvVGKdmPQCpieXqkkjTgc49XpXXABc1E
         G4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153265; x=1787758065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iR99/HU1Sv6a6aJcZCVFplbKZQ+GSq64X/oQnCgwbZk=;
        b=NYs35l8UMo2ZWOIGIQncQECyfMQ2IZxHwxdPHPc0LjHk/wAF5AZg3jJ1RhCvEXqCcK
         IRwpxKr74dIb7K/bqDjk1rgTflGIu01Z3KXITUnTEgLyR/hnFcfeSFXFzG0auohPWphr
         LsvQGFntARYTH2xnVN0ov+90IC/tz4z0OtTGO2qIX9olMFTTyHaw7KIP0qvwgAk/ObZ6
         xVdgET9Ikn8aa8tOmlSda1bk7TeRG8F9iuMPhOYhpf2B1okJ4tSD94Z9FpAwxgVY5xA0
         /uNX2PP7j+f3XIv3wNuwuTX+dfzEjwIivCmQP6GcUM3Oyaiadon2dZ59O2X8osxXZ6n1
         P68w==
X-Forwarded-Encrypted: i=1; AHgh+RpSD9HQa6uRcd3TnLoPx4Y+hR9IG5/O4EJcwm8idic33psHUJs8bDH6kXG9/LfEhSHmMM4E0C7tvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXEWi1YXtjMHpR31vV7r/9+yIAJQkGtEt320C9lI7zRyB3YfL2
	apc3wpb2QYpoRw9yIMfHFRijktsCkFjDRVFFWYYj7z4jezPve6oIElj2
X-Gm-Gg: AR+sD12pHxwYYqeC4ozuJdKP+sqPNFq/wWRIM+3B0m7tQq+OlcZAM/LX1RMW2Um1eZm
	Pd4o8GAsBRb8Qur6AfeTA+wpGkAB8tSGzrlmMEgcX/tEGSfgAHjKlOVazZDObuqeR6iffRzuqJt
	KyPuDid8ua7TtEzRbx5DQBoT1C2FcpFSYVoTbUZn3zRDWEf2U2XWG0t52ysLytCHJajpWWTXHxL
	uNZ3hzLD9lbCYnC8qETVdvoVHzY40iyQEv15u0PEG4Z/TmcB5LrelGHUBozp0oJNra4GXlz3FrN
	lI1Cubwjb9SkebvFCqqf+u3NVl8r7uXFvzOI6ijO3aC6Sc3W5MOnFxye60DTAsDZaEZJ1nMBcVh
	fogeVSYoMjM+CRt9I4E/39pePz4BE7SAxPrQeQG/ocpqQ5vmx/f3gYjq3g1iaE6+HfBehyMyIcf
	AjLaut6UmR/kN+qQFWeQ70zfiHbgi2t3P9N1SW0TC4mdpWc29vEtgSo25TWK3Vh0MlHh8lsRZlg
	K0kkqWVXmE=
X-Received: by 2002:a05:6820:810:b0:6b0:4355:3c8d with SMTP id 006d021491bc7-6b13c6bcf29mr4325143eaf.34.1787153264564;
        Wed, 19 Aug 2026 08:27:44 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm8232838eec.24.2026.08.19.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:27:43 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	quic_tdas@quicinc.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v2 09/13] dt-bindings: arm: cpus: Document Kryo 475 CPUs
Date: Wed, 19 Aug 2026 15:25:38 +0000
Message-ID: <20260819152545.3934-10-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819152545.3934-1-sreeshankar0910@gmail.com>
References: <20260819152545.3934-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Kryo 475 CPUs found in Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5be89c584..2a90af67c 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -212,6 +212,7 @@ properties:
           - qcom,kryo465
           - qcom,kryo468
           - qcom,kryo470
+          - qcom,kryo475
           - qcom,kryo485
           - qcom,kryo560
           - qcom,kryo570
-- 
2.43.0

