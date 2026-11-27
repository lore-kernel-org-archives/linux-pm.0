Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818780;
	b=4Mx878ct+qqnBeRaJAZaNdC31jsihFNac38TKNZ/P7P2zFk5JG4rhIaOmzKvEsbIShb9
	 PXIHjlV5GWtLYZX3wtMbjxzKSZNTcmLILlQAZvB+vqLXg35Sq0yIwZj1XgK3vtitfBAYF
	 mq0aTRNML5r+7dhYPvdauU1gzNy/mKpBb3wr620kMm3Dsp1PBO7KYUJ7yEZH4dCtYF/rT
	 nLSxxvzakiie3qohoKKLxFUYh/ULOcZ8cIaB1qeRVNbViJ/iJCnY/+6Fazk6Fif1N+ao2
	 pl1eBP34dp48AZoVqOj/NcwsfhWIbexp6kCua4iXmmEqa0SofFtPQN6V6aAKacE1W4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=TInPcOiZ4I4+9DBJQQCS2zeJrPMFR72h+olev8lti9k=;
	b=h9clHHIhlWBzMmCP07rAjm9AUG52HcqSY3H/5jAMeFrXX2aSTECGs3ki+qYU1zVSqZ24
	 RUZWqjVelDC3m1DvU7LKIcOe8NnnJmnBDhQ099L9mv22o+O94VWfSTqUZzKzw1BpWdrxP
	 eTs1GhQ9PRvXH14Zt/ljDoV1pG7iErbB00ynpfJWhs139n6An1omCeOH2rQ3E0EhIAvUr
	 rc96CjL0ZdlxRSJ9NUuMXj/hL+gcvjXEEXOvUhXo0pIFoALptH++5jjMUmWZnCljQcFTz
	 ylnMZ8osEIYKR+9GnmrBg0XucXE+oNj5av5fBr95EOoH+fz6mvTlq6Xc1fYIxaP2ktQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVAQIjl0;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D22606A330
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 22:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D22606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVAQIjl0
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49465892f7bso6277609f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795818779; x=1796423579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TInPcOiZ4I4+9DBJQQCS2zeJrPMFR72h+olev8lti9k=;
        b=iVAQIjl00Fz2PZxLYDy38wZ02cyQvqaIXPLXjZcdKiCpJX6L0ioSlDpNVvlNGMhjk4
         jOJEakan5Xrt82wON/W9DAZuqFdhC4/g9z1/AC1/Ee2TnooVnhYZ/BSJnoKyDKe0Rsci
         8np+SL8iE6BJi2x7WLzQod+xLixXTqtcXY9xy4ra4YF8xNVReMyDmCcodPj1HhbdTAwU
         75gaz3QPu1WR1BtvBG36giJgCCG3EydQ5/Cf0psQylxUh+vpEEO6ioQGJ7hpEGUokq4N
         5fHm+FygwkvMnJAOME0KHS7UbTJMQbKtDrn7/SlrrAUcACSR9fy/k5gU29Fqp6+Ou5Ac
         olhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795818779; x=1796423579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TInPcOiZ4I4+9DBJQQCS2zeJrPMFR72h+olev8lti9k=;
        b=tdpLCz0N5kI5NUNyirvx1gnrAgQavORlSozHaoxzMv/EY0F3fdFY+6TypLVpz84Vlh
         CpTgtNjet4VZvsvZFWCUV9xcIJYmsSx432bDASeM/hdUo6SfvqTDEgiWgNv/FlIcFmsX
         ydYgsCBTb33HF9jCA0WPrSyYp6h522B5d1OoL6ftSMABxjBc6vEk+IzT1noFlCtz7+6U
         Cre5+DD4G5bAsUu7t7Ycs+rPY49l62ZbkXuXPjitiIxVG9BzJAf4hSxDVKTg8QAr1tzF
         Gmg+3Yd6fnk1wvyS0WAIb5WM+ax5dVytkrgdBBQnBJpbYw/JST3bbCRUfZv5qSJVfjGA
         5xpA==
X-Gm-Message-State: APuU4Z/xocrMKswnx9/mE2oNZeQkFqVpwA0UwNirNeWxI7TNVu73fyeD
	eFE1frxZByVmya4Wco0F1B78bpyxvfSE0kRsMTkdyzZscRm9NgVJcTtWi9qDFB6res2RmA==
X-Gm-Gg: AZFdTZdfu7N/hQLnm0mm77smLz2VZpyYvlh2WVQK7btEemjXaY9eZeirwfe+UUgScK2
	owQil8wq4Iw3WiiIriAprfD5LWjSIQgVkXPFYEvG96P3qciJDI+j4s1yunJ5mNL9VCpqQHKsqOv
	JB0I9fVakGsMyyU4d8+5/6p9n4x7KhCH9mk4MvvJSpAOj3LlI5ZYTGumIVrfUxfprJDLOt6pKPL
	7ygyCD2GkmgNHFBgHXcen3SwsLpoFRk9qU7YWVcC7WNMFgT0ibvN1znO0C7Wlnoy+fjmObZpMBN
	4jipgYom8JU73U7KsLzHt+oxtnknBiPMasKSzcwUWYQvZn2QTeUaCffu8wwxlbKd9bkkSfoNG77
	A3rwlov0HEFpSiFDxfttAB7IDwN4Gx0MnVteg9wl1C5OB0tLcJU+4Pkn63VfSpDyl9BVPr0L4fM
	e6Wxis3ggbWgK3ntWGGPGvIStth4akeVykHEB3T3d88o6GvwWEc0vI0HfwtRvYJhW4JF7tYra/F
	Sl6tewQaXPQYR4QHsAmthjy4pPliBQYWD962gkpjAvm87V2CUJi2z8a8664Xl05vFbRjiQTdILK
	c/kX4qnUoJKhvQ/DeXw0Zc1UKwJ2OhMx
X-Received: by 2002:a05:6000:4617:b0:487:27f9:840 with SMTP id ffacd0b85a97d-4abb59e2898mr49754885f8f.53.1795818778612;
        Fri, 27 Nov 2026 14:32:58 -0800 (PST)
Received: from [127.0.1.1] ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm50430285f8f.20.2026.11.27.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:32:56 -0800 (PST)
From: =?utf-8?q?Adil_H=C3=BCsrev_Tepe?= <tadilhusrev@gmail.com>
Date: Sat, 28 Nov 2026 01:32:53 +0300
Subject: [PATCH v2 1/3] dt-bindings: power: supply:
 samsung,s2mu005-fuel-gauge: add S2MU106
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261128-s2mu106-fg-v2-1-2c3142e05aaf@gmail.com>
References: <20261128-s2mu106-fg-v2-0-2c3142e05aaf@gmail.com>
In-Reply-To: <20261128-s2mu106-fg-v2-0-2c3142e05aaf@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 =?utf-8?q?Adil_H=C3=BCsrev_Tepe?= <tadilhusrev@gmail.com>
X-Mailer: b4 0.16.0

The fuel gauge in the Samsung S2MU106 PMIC has the same direct voltage,
current and state-of-charge registers as the S2MU005 one, but lacks the
MONOUT averaging registers, so it is not fully compatible. Add its own
compatible.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 .../devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml
index 05e420316a2..74dbfcacdbd 100644
--- a/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml
+++ b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-fuel-gauge.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - samsung,s2mu005-fuel-gauge
+      - samsung,s2mu106-fuel-gauge
 
   reg:
     maxItems: 1

-- 
2.53.0

