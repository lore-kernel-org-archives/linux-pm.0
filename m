Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36038C2A4
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305618; cv=none; b=TW8pn42xmXCJmC2/HBfn7ATIdPsFsc2lHibqgvvkX6N3RL95IzrnTbzhvFzp370vGKys9BlREWC3/4OQ+/9RQpOsv3eoJjzPFwkPpM75XSpydaujmUVO1xbqigzzHrta6YlgJMhnc5ZsMoFicsdtuE+aL6opaZLUjgi2Rl15F1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305618; c=relaxed/simple;
	bh=OCqMqTV3Fk0GHlGjVJ0UFzNI1DHV1XFUgzJgSRR9AZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX3gm9tYMDrwAMzCA4T7vdJdEPAZ72/H7BN1cRT/1YnUdyS8PWVwv0XJBQYZnQrTwQOt21iMnESceaQV8hK9Ew+XB90GjPp6FELiQfQsKQd7d8wLSJLWIGXAuYYJAurW0kDs1n0rE2ABmclrz0RBdZAR7DXbA3K33HkjP0C6OQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5x3kQ7m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5x3kQ7m"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so9224855e9.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773305616; x=1773910416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+87770G0UGJrf+jBGNAZwy7BjuGZ53X0m5gpUF71N68=;
        b=O5x3kQ7msFNDjWpbWi8Fq2jQgBplW7GX6/rbZs7RuX+srufoy0h4ikXCbbpKINbGs6
         04DUlWvgI4EFP5MXdujfh1Fu6u1x84tByc5cXoF7tll3+iuw+WzMh/bA3TP1rE7bFQ8F
         G5Toa7k32shC2Nxw8/rlMPEE+WlTsaWhC8hI2s0NZ4pHZkKo4H9kSud5b6Q8z2Q5CXGK
         rlq6Rh5PY3lhqavFk0mdle4fg/wFDWSErXeftNETUG81ERSj1CT6bPXF1GnOydOJW4ky
         tU49grRSNu76K94iVgjmZ9mEy3eZkJLGMec1r/EdA9/FiFXzy7HlaprbDHkElKzUC2It
         DO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773305616; x=1773910416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+87770G0UGJrf+jBGNAZwy7BjuGZ53X0m5gpUF71N68=;
        b=q6vkIVsf13jVVdnE6a1Mw5fIwyldcOR0c8ytkJWHw2+EJDghpKEWJX0LXqkYnREejJ
         vDqpsEJ0ODUVUiNdcY/cU7Vof7BewL8qIpMQL6ujViiEk6ZPJumVOYna6FUqqqfVhosN
         R7PCDC9yFaEuooiO+TqbwUWQ0oJlTStxFS/gicEg9NEFBCqwnDTRk4ndgvDvVk1NirsA
         K3kW3gb185MqmzR4AMKqw2DMAyCtNGTiLyRPfzCtPx0Llc8+UTBtuN5i210dg3RfA2k9
         wWoTeVoefLeIRHy5OTHmmyp2GKo2NG2DbPPniyVTFGamaWVKUNmHCMCMXRVPihUK8EW2
         pcxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR5VrTpUnn8p9xwleVNIh5vVCSVg9gStbsO3Q44mlVEdE+YR9eCP3lRH7SGpHlN2pfwthXvv9xTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt6E1CqVjfIlEPQhVk7EzOR/61Lj8oAP9Tbq3yaqn/mGJICAFB
	CYJWLyMaqAfFwxMZ7bm01sCtzVv/JPltLBlQKIQjHvP5cV3Az4QMcjaC
X-Gm-Gg: ATEYQzwOuZFwFTw+r3ZgJdonR5n0VpWzjW26rg0lTeH+cjPL92yee6UwcLWWvt3DLpT
	L/Q55JnthtEDeHORdXT0Sjz76/lJ+QgOjObjNkqFQ3iv8hSme17IMQrN+mJz/NeIZV3eie37Bt+
	ixA5J0KOF1+bmAX4A/nW+R8I/W4D+y8FkPDhkSDjSWUxs/XLD/b7cHAkvAAS2DTNIwyVQKvs2/e
	X3nAZbNS75rsoRBqCcaJIJa+0pkhoMaGpa6PeegXp5rqzUEoA/49rpJsyO6pdKPBEB49EEW4JSS
	meZW3TPNmm6mzBkYyARsUPj5rK1dVpaIqBuQVp7zdxi4pzciVV7gvpa0yGbNLUZH03bFtTx8BYY
	G4yjQPAVCgAkE5rFcPHX/NtOrwlq5sJvgRgXpAh0LFApe83urNuM94q0SXs3XmVk9/nZVhnlCfL
	BS5WNKjCLxPTEp
X-Received: by 2002:a05:600c:4fd6:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-4854b0a555dmr91969175e9.5.1773305615537;
        Thu, 12 Mar 2026 01:53:35 -0700 (PDT)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe226473sm5449162f8f.32.2026.03.12.01.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:53:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v4 5/5] rtc: max77686: convert to i2c_new_ancillary_device
Date: Thu, 12 Mar 2026 10:52:58 +0200
Message-ID: <20260312085258.11431-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312085258.11431-1-clamor95@gmail.com>
References: <20260312085258.11431-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert RTC I2C device creation from devm_i2c_new_dummy_device() to
i2c_new_ancillary_device() to enable the use of a device tree-specified
RTC address instead of a hardcoded value. If the device tree does not
provide an address, use hardcoded values as a fallback.

This addresses an issue with the MAX77663 PMIC, which can have the RTC at
different I2C positions (either 0x48, like the MAX77714, or 0x68, like
the MAX77620). The MAX77620 value is used as the default. The I2C position
of the MAX77663 is factory-set and cannot be detected from the chip
itself.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/rtc/rtc-max77686.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 69ea3ce75b5a..3cdfd78a07cc 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -686,6 +686,11 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
 	return ret;
 }
 
+static void max77686_rtc_release_dev(void *client)
+{
+	i2c_unregister_device(client);
+}
+
 static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 {
 	struct device *parent = info->dev->parent;
@@ -713,12 +718,17 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		goto add_rtc_irq;
 	}
 
-	client = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
-					   info->drv_data->rtc_i2c_addr);
+	client = i2c_new_ancillary_device(parent_i2c, "rtc",
+					  info->drv_data->rtc_i2c_addr);
 	if (IS_ERR(client))
 		return dev_err_probe(info->dev, PTR_ERR(client),
 				     "Failed to allocate I2C device for RTC\n");
 
+	ret = devm_add_action_or_reset(info->dev, max77686_rtc_release_dev,
+				       client);
+	if (ret)
+		return ret;
+
 	info->rtc_regmap = devm_regmap_init_i2c(client,
 						info->drv_data->regmap_config);
 	if (IS_ERR(info->rtc_regmap))
-- 
2.51.0

