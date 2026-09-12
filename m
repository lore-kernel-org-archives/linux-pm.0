Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E6481A81
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240402; cv=none; b=kqTYXT1EgPdagf7Gcl9UXxIpFgcKroJnOam5vCKj94g5fvz7VqOn/3j2OrCJVQM6/RjYCqzu84Cu3/5Dbm1rTHmH6saO/Ve8BUYQ8nkR9gE17LY15T7K46mgqpd4Gnd1X+UPHcvqiCLCx5bIPg7KNR8vIerM92kBgbUC1RSdHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240402; c=relaxed/simple;
	bh=rzU25QtfHWStXyf5JOAOYagDMlPR8E/O7UUr9Hj10z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOX3vDTrWaahHkz/qGEFgpff8Tb2W02MF/enyX6LMY7fF6rYQBIT8EuOEQOmIE6dc4KEcpDhKT4jH7lg3jGv0BxwqSobpatEPpQfCp11NbAnygAi+o9oFHBTqINg7TCrWcKHWcBL2Jx7uqOXMngEoGG71xUVv/V/k178TfvjVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3gOWOis; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3gOWOis"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4d03f95dfso1091119a12.2
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789240400; x=1789845200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=epJRaVobxvGM+/1VLnT5WJdru54OJK34KQRZKM0LI5E=;
        b=a3gOWOisn5B5hRqXKFFZKdetKy+GtbuubsLGdKfo8dqVPZnDjUVVyhiVI9XUkx9E4X
         TMjXM4UvHdST9h6udvx5ez24iQKYZ2V7W3zX1Z0yh5dQCXfeX3zqcpE2VLPlOgcvDKPB
         paiBP6rpMsArRYh1Y3t/GG1OsXYDzEAPgP1HyakdZ1/FjORGhtUuAlf/QPT7c7QhZIpx
         lzRNGFdtG6uhd9cpzXIXhVGYxs5Kn7OxElWIVaR25MN0adsA2AhHHg7oF0GD8OthXboy
         aTUKZPWGTWoXVFr1+pU2wPMwfIAj8HJQ0Xan/coljkOmX3aPp+PI5OyofQSVcbAEQ8hK
         M3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789240400; x=1789845200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=epJRaVobxvGM+/1VLnT5WJdru54OJK34KQRZKM0LI5E=;
        b=ADP+Hd2GyGbrCv2hKp6qvOo5Ks1aNUmPDW2TeYI3gNkVtgpyqn8HoeE0mYCXU1UIiR
         NU+5T196hAp6CYtbHjTUrAkhNO1WRrzB8KKWZQp/e/t0Ku1hEW2qo99zFOkC57+3aMEQ
         2fNEtRG6ExzdRWe1fAta4a5u8ZcaiUrb34BVptVYmuy6nfdJYXAIA3E8zcLkcYEF2NFh
         mqICHeCdxdnKGrOgnVWrzUpq+Gb947WXvBlWajqNW27YJBKl8GEoX7JRdhoCDhgsaOny
         3JPDyNDf8ouH9Iy/804jLOuj8X5/ixmBbdxRBeg80jCj10Zwh+3XkEr6/pAmiAw3ZCUK
         C2BA==
X-Forwarded-Encrypted: i=1; AKwUvBwCB6AtvplFLhZ8Fsf6psQ9kexsSZAqlw0h/+ruU+6vhcohQbpneCQ/WtPSULFH6P+jMs00z7WHBw==@vger.kernel.org
X-Gm-Message-State: AFuF++miniRyb54NQqmk4eGdulNJ6NK3BbnSwY8oPyWzYgRX4/EceN8e
	6BDgrmsWTTV3myWJ8n5zQf6NbFglvjD0FkVMjpm1FecD+WV++8PV6qDI
X-Gm-Gg: AYBFou1I6QnoXxUoi3ShnEWToQGJKmZNbZrSVHbahoB+1iaGJVLLbJieMO6qyapPFCp
	cQWf/yICm+AkIg9LWMqpdc/8EsoOzck3rslswMRMfGPOBaaKxkLk12Eb/TCCRI2GDBGVasdiWoQ
	pShLYNROpO0+SnvKhFtBJwc8CHhdKNP7ebD6l34fm02d646M7PoGQQLvj733bh1J8aFxwrb4ssY
	almuZ+G4/D80/GwJbX7mfVYIUy9T47KUfCZxY3ho2MkKgIc9ZISW+cqFB3SWkTdB68qFdZ0M97l
	01Zdm25JyoVUQE5dpU/zVqju+l673J4cj90z0ZRauPbRLuiaIpo8jEFNvb5NMMvUMYNcQvWY6d2
	xSusiXqUY6eyISDHd+wBkwO97UKjYnwSdjjBM5TpaIJRzp0ucET98ZO3Qo3K0m+tg0qoCR0TvUH
	acRWKXPTDG1kQJzUyto6uyW3o59/lSgvgbgZfyxPVYrGb2rVvfcXQQjK760712HuXLeeqP
X-Received: by 2002:a17:90b:4cce:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-39d9bec4d91mr17930859a91.10.1789240400257;
        Sat, 12 Sep 2026 12:13:20 -0700 (PDT)
Received: from gmail.com ([58.84.61.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm14722239c88.3.2026.09.12.12.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 12:13:19 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	krzk@kernel.org,
	amit.kachhap@gmail.com,
	daniel.lezcano@kernel.org,
	thara.gopinath@gmail.com,
	talel@amazon.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	mmayer@broadcom.com,
	viresh.kumar@linaro.org,
	sumitg@nvidia.com,
	peter.griffin@linaro.org,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sven@kernel.org,
	j@jannau.net,
	marcan@marcan.st,
	casey.connolly@linaro.org,
	sre@kernel.org,
	wens@kernel.org,
	t.schramm@manjaro.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH v2 5/5] powercap: intel_rapl: Use %pe to print error pointers symbolically
Date: Sun, 13 Sep 2026 00:41:55 +0530
Message-ID: <20260912191156.185448-6-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912191156.185448-1-sumeet4linux@gmail.com>
References: <20260912191156.185448-1-sumeet4linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace PTR_ERR() and %ld with %pe and pass the original pointer directly
to pr_debug(). The %pe format specifier prints a symbolic error name
(e.g. -ENOMEM) when CONFIG_SYMBOLIC_ERRNAME is enabled, otherwise it falls
back gracefully and prints the raw integer value. This makes messages more
readable without any functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/intel_rapl_msr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index a34543e66446..46972ee1ff84 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -582,8 +582,8 @@ static int intel_rapl_msr_init(void)
 	rapl_msr_platdev = platform_device_register_data(NULL, "intel_rapl_msr", 0, def,
 							 sizeof(*def));
 	if (IS_ERR(rapl_msr_platdev))
-		pr_debug("intel_rapl_msr device register failed, ret:%ld\n",
-			 PTR_ERR(rapl_msr_platdev));
+		pr_debug("intel_rapl_msr device register failed, ret:%pe\n",
+			 rapl_msr_platdev);
 
 	return 0;
 }
-- 
2.43.0

