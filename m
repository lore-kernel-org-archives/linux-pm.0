Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7F3603EB
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789194182; cv=none; b=lyMwV81Me8ih9mnsvX6hgs2HJ4u2ip32JQxg/43DzgN1qGQwAsdSy3YpOsejnpqWPhHsyYYYg1AtQfxh1Bkvt9KRFmgiPOqBV8PbFPeS+8QSC3iThiDvHOBtesF41A5D3qEP1A/s7+X1OQuvCOP25rVX/WsFsJtUZy2dgAVvoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789194182; c=relaxed/simple;
	bh=Eo0mHBRWqGbjHPOtw+RoepOiHqUltsjCs3L6erZNzys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jeuIpnLHQLG2VBmf5hzdOCPXEwYp9lIUTR58e1Y9GRdOOCM0ZG75LRe9bS7MeDqW/TQjRPLz8ly6iG2JtzJUfvHWEynlE/zdZlmH52906A/A+UnVgJ++aOM4IpQKELlIWAOBRfv0yAaFnSdRQAbjwhJDsU+oN+NJ5pAFZ4yfPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M33aO+uX; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M33aO+uX"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f88so122851f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789194178; x=1789798978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXZuoWLz+daoVkVjYqrR1OWv4fzrVeC6Qw0y82I4Cug=;
        b=M33aO+uXXMQExhaPIFws41UHmEtvRXNKOzL8JVlDBNY5bYpHXES9BcGmYNvV4MXgd+
         Bep0lR40Sylq54gEusPJsA0QM33fSz4sAFWQDkJbcP6EGOAphDgBMwmlygMhljMfpQ28
         HvFe4fbNHL+Hril6R6ESWIn1v93iwfLlYIKlX1qbRJdAdbJ0KAbvbejQ+bzXXgt3XJ+m
         pe/CvPLat7jgw22PRxHaVOBeCPnbeBgXC3RpFPcYytOLH47EWtf3+9DalXIDfpgKWdsI
         5bUiDEHm2KpmBFfZhbvsnDVrjQdLt2K8gkj6iMhqFJraiUCz4H2msTG0FKumdVbk4qes
         OuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789194178; x=1789798978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXZuoWLz+daoVkVjYqrR1OWv4fzrVeC6Qw0y82I4Cug=;
        b=H/rXyn2ZXi8N+cKvoeh9SApt85lNh9LXK52nDxkF3zDFJq4JFT0/deERobSU7P3eF4
         tnlfe29NfPWDS4h8COF6e1wcTB6/cU4A7hi2F1taGKtUjtTemtiUkZtxygnxIJvObLkT
         FE9R5gQgWSlzDeVSgH53gmM7jnS4Jw9kIKzoh5zc6VS6THPxpSMW4Z/6lXD9i8giVHw7
         ISbb4pbsE4TNB9ptvrOp60JQMsUaVEf5viWzgdavtc9wGLrK7WcGgztYeChoWnewA4ew
         bazbzJFFWTotkcYj4qSU2wffOf4KyofQzqRRRDnC+By74IABIBl1n2onKhKUFGhv7ZQl
         ym6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzqajhBxVOViQk3CsdmrbTbPr/2mEZXWlfDwz40W9oODiHFgub4XwkQjhFs7VxbLMzmDj+RLpPPWg==@vger.kernel.org
X-Gm-Message-State: AFuF++kCEjPsxdPaMfBouAuLq02Cx1vsOmY63v7kiNMlRTB5OiznmIjd
	FAz1527LfCs+Ot9HW5Jj4tStyO7ESBYLOTKoSdwoFjYhzc/TqUZNnrMh
X-Gm-Gg: AYBFou0HQ0LOw53b5m2QHkTS0qizgt7OsNNUEEw0azjNecmYfEy+l2GsL/0GfPWhWir
	EWiJUUMnX1mnlI2UCpsVvtVndzs/hiVJQiGwYrIoK7AY3lhoRektxC+fm8JVs4jXl59xIoAe+L7
	MTSe7VZjzV1lJzS20YkHPzVPeRSH2QhfohNVJYXqr0gQhYv82XMrsrWYVfHt2xFS8VXlkMr4Pqz
	op+Tlr1WOBatdaiAzp/U4Bm4l0mND2jpd4H21ycEHVvbLFnALWgrgX+ZjWyTC7RX9EU84gzak8O
	Ik4I2WmJPPzqfQa2t+wHbj+CIUx+UBA6EchBJELSxN334izk1m10VDasiVXw31zxf9mfXiU/+SO
	XYSzYTM6R5OWpW98gs2EggNVqnoqNXOM3edUBjJYFJ9ZGew9HaPJ/yN+GBDznTnQ9Myu+rcYPKE
	46UqWWX+1XWL4T8mBBHr02acykem88Olzh6dvb4XjHfCZnmxUWw4JgPFaXypKeylqt2LttpErXL
	2ONcbX3mmEFyfXMZvFSHN2IFhwPdKU3vMjxg3GIPMHvs+DPAdhcoGMO/WQ1BItnGWdngq850WNm
	TxpX99iohv89fgT86/mUeP5eKy+RVTf8+v8mqAcHZ5E2x0tDF28xR8xnBwsAPO7S4wUdZLtlpIQ
	tnzsuMraHZ/zA
X-Received: by 2002:a05:6000:41cf:b0:481:5167:abda with SMTP id ffacd0b85a97d-486f6bd8afdmr1548275f8f.9.1789194177611;
        Fri, 11 Sep 2026 23:22:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e74esm10929336f8f.25.2026.09.11.23.22.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 23:22:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: ti-soc-thermal: Fix the return value in ti_bandgap_get_sensor_data() kernel-doc
Date: Sat, 12 Sep 2026 08:22:52 +0200
Message-Id: <20260912062252.42762-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ti_bandgap_get_sensor_data() returns an ERR_PTR() if the bandgap
instance or sensor ID is invalid. Otherwise it returns the stored sensor
data, which can be NULL if no data has been set or the stored value has
been cleared.

This mismatch was already present in omap_bandgap_get_sensor_data() when
the driver was introduced in staging.

Document the validation errors while retaining NULL as a possible stored
value.

Fixes: 8feaf0ce1a04 ("staging: OMAP4+: thermal: introduce bandgap temperature sensor")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ba43399d0b384cf86d12642cc184c5f14066f431..2e8fe7daedb80b7ca4a24f2c89fc5ef44a0a9ebb 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -576,7 +576,8 @@ int ti_bandgap_set_sensor_data(struct ti_bandgap *bgp, int id, void *data)
  * @bgp: pointer to bandgap instance
  * @id: sensor id
  *
- * Return: data stored by set function with sensor id on success or NULL
+ * Return: the stored sensor data, which may be %NULL, or an ERR_PTR()
+ * if @bgp or @id is invalid.
  */
 void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id)
 {
-- 
2.39.5 (Apple Git-154)

