Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030493;
	b=pbU/KffrI95W94rImvVYxnaFBh2LPgyymLwFwwXechxT9UjbKhGRIG7wQ29+aJzftEFe
	 XICSfZO6jzw6B43p3OhTmW5YDB/ma4zO3Pq03gCqxV9ExI75yqPr3SiBA9ay692Fzb0r9
	 +51P39lYpLcN6G1T8P5SyBHzOpK4wXWLR+KHgc/RHxQmQlBU59WFjw1WleudX1g8eaWGx
	 Ez9Ml8mdqiVmOYcv3qZF3lSUJBv+hSK/pteIhAmurqQms0g9h4B9FTPCwBTyZD+yaXGNQ
	 pN+vvDbheJfuOsi17AvpE1zbOgBwW8ZLhP1LLjxkogr0q1yBsYgxQQ4RrSfVOLBy3Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=G5mOJb0RnfSFctotyurw1MWzkVYTqMttYi7YnmnVgyQ=;
	b=ZvUcYkwjKQ5zB0IQREnkpQRPitxfoZZGCdCpPRPKI6Gm376SBcLSu+KMAeFkyDXpn7Fx
	 oiWt1ExhFeGCPa7Fl9GXW7JZrJzo5CkiUV1KvnfLd5aJF2xXS2DrotCRFYNFz/lY3e7hK
	 Rhx3Qq7LZA6HDZtMvslqXMLgF1og0nk397wzefvi3i8fLAMQ5yDJGGiIS6BeavWneId/7
	 gE0K2opTjayk88sBTB/rwkvqNU21vLunl+cyhPsncB2zmniSYc/m34nqAJGc6gGwltxSG
	 /R+YvHpZ9Bsle5/J9+RKFJnPthrjKl+hiwuYhr9pz6PIdnEs0hCumbizXd+tingKhaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dW3Fc24n;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B660A2616
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7B660A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dW3Fc24n
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4322d310e7so467120566b.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030491; x=1793635291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5mOJb0RnfSFctotyurw1MWzkVYTqMttYi7YnmnVgyQ=;
        b=dW3Fc24nHwm7RX4RtLNqTM5TYYHXznFabtwjEmnDJBOV0ztb/htbS668pgH+XdCeDb
         ss9PL8XqeU4mGTspAXLGVRtIE2oPt9TSPKdW9BcEZnPG46g+TA6jB0ogpTd3atRSFWaU
         ddsrmUeb1fVu4rotrra/pP//4B2YatJB9QUhTqnCj8hYYXGofjUyFtglScfFOP6tFyLd
         rAsy+t6ehs0dhjvOMxC0EHsbDYLz+2vXS1gdnpEaeCMkserfcwPRuXAO0r7/W6FqxAv5
         07LJRDKiYFrilduw8Y9WjZldcwhov715zOcrax2BqNa4jRNWYHgucCbMvj0clGub9Sqf
         p4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030491; x=1793635291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5mOJb0RnfSFctotyurw1MWzkVYTqMttYi7YnmnVgyQ=;
        b=vCy1ZQuKzZyyPIew2asCS3ZpQ9AlrZblhNXwFlbaSAHFqCi7uH/dl8Y7T9sQnoIKkj
         vRyBjNIk+QywDFWfSV95sEP5TdaIgaW6wN2BrMoU8LSm1F10SgJhGF3C3Jzm2aEpv4aA
         Q4Ly0otzpcncyuAiVwC9N9o+VIY28vcMiTpfTqd55X9wv3dU0VstPCWwFcfUgKaI4DF0
         QI4PyoVvUmjl+DA29BjgZlUKoeGCy+Atg58NJbuma1WByb7kEoI8KYCoV+6QHh0n9t/o
         M3tf9J1GuYuwP6FNLArIUpkbVt1feOtPmYBmbj1NG1xztSzEd1xN/dKvJ1WITe0JaEIT
         F5rQ==
X-Forwarded-Encrypted: i=1; AKwUvByFy3EB7Ovjxq5Qm5Q1PlNwlyj74axKkTYpyHm7DfK8Lvi8p1EmumVBKSiniUGONHKYjMahMWn8bA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLz/SmgZs/QKzvC9QdLC3q1Ac7UfBSnKHZmMcgsP1T+gUvHhlR1
	buI65/pxLrK1iyQkkOGwX13MBzneBpuq7LIBjhOuPa404z/9ugYDVTXq2yVH1ix9tj8=
X-Gm-Gg: AYBFou0DCgjOtppJ3zoEp2FCE0ilqYd6Ywzjey5tZRjDiqG4w+2JqlduTmYi0feaEAO
	E6pQnmVdzmHmUdOu9YvGBNQDGYyTP9OU3hKSfGZdbdPhcCb01g0yxvaW1Ib3bM/TfZuSsV4tPzD
	zZurjONxJKz7R0uIoEyidjI6gtut8Pj133pWCIXOn53xnUOcXiNIP/zbuit9/aY7CuwT+ZggQ5i
	Nv0s7XfjR60uCx7IvJjW0CPdBFmxpcPTONCJcVfNw3ALTXBPxgiLWalm8py2tSahQYWqW1oBSaB
	InU1vZUczzeJdQ9yhIAG2B72rvjJFv5rmdMApaXzfhEIVUg8bU2L6OEGEET2HDEoQQMwDZsx9vF
	4VNrREU8EHs8JsvXtTIEVeUGnQzv8XpAiqDTScyq/05MKy0o9KqDAPnjKYFwNNEXYHO+z4ydxJ3
	UNRa7kQ3J0wawlN0MM/0riMQeQLJdK/stlLB8IPcFe+Zp8aILOB0YNmzPGq1mUWwquuQ/t+Jhbc
	afRCeb28nqCjDObr3l2iVvWbB3MNRKWIvjdSAaWcRH5vb0qy9CdZIVVsE1DDYW4AdgfK0mzW8RR
	dEhYtCP82xUncXT5RZMqxLdlI8c2c7CAQ8vyjKN1y9JGyU7YHt3JpfxW7dOjvs9S3UaCcAhyXXV
	839lloJZNMikvPlKaqXDWeGc+xCUtnV56
X-Received: by 2002:a17:906:dc95:b0:c34:83c0:b92b with SMTP id a640c23a62f3a-c46bde24eebmr834629766b.23.1793030491260;
        Mon, 26 Oct 2026 09:01:31 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:30 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:27 +0000
Subject: [PATCH 10/15] MAINTAINERS: Use linux-pm mailing list for Samsung
 Exynos ACPM thermal driver
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
Message-Id: <20261026-acpm-tmu-fixes-v1-10-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Juan Yescas <jyescas@google.com>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=927;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=BUTSbzEDMtAp9xedXXWiQmdqZWmXBU0Yaz6LK7Awqpw=;
 b=QC+yB04KHzmX5XUlB+M3WHYVAVTzsEU7atGXSGu9B/dV19AW24NT684VZEvIKwYcRbj6F20Un
 wPF2S4wqf9pBCDVZf1GnUpDmH22JyWeQwySA4zYEGDPNhN/tKZ9uvFY
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

List the power management and thermal subsystem mailing list
(linux-pm@vger.kernel.org) instead of the general
linux-kernel@vger.kernel.org list under SAMSUNG EXYNOS ACPM THERMAL
DRIVER.

Fixes: 05657c7822f2 ("MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9fe9c2a39b..6da7c884373a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24382,7 +24382,7 @@ F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 
 SAMSUNG EXYNOS ACPM THERMAL DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
-L:	linux-kernel@vger.kernel.org
+L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml

-- 
2.56.0.257.gf7497c7d27-goog

