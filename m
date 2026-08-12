Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F5392C21
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 04:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786508947; cv=none; b=bgFxYsd0R0ZxN3hjWuvGntQCVC13qFHD0N1kzJIRX9cIkyczVD3jhwjkjmOTx9fzuf4ZANV6djTMgaci4SbdhwU9Oqbh20pf9KwKQrEktxS31PupQAJPfxBASlRJ6/B+Ht34af8afrIqy1ScobkBwb2KOsD58WTX7/IkSQA4rv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786508947; c=relaxed/simple;
	bh=ZSBNYkXFwk+NUO9FORdbeme/ZZ+z2VE3xPQqDmvGQlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyPM6zOS9dhcJmbudTEEeN1fJOm8bu7DPi3n8SP3H62cZtJUmpXhOgp3zoprBMZ/7vyqI/GUsMVNnl4+5dSS/htThWNNtOfSAx6uRrVXlsPCJI0QNjkZsaIhveMA/kbu7OStvuvl3TUBD3bRKkeO1mqXxxBBBjoKCUuGMfT9qOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9pQDR8+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9pQDR8+"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848743155bcso271150b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 21:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786508944; x=1787113744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dBDm4XABT+M35OCZXHfxjb6N217Z59IKvmM4b+FhRtg=;
        b=f9pQDR8+iLobjINAP+0E5AOzcwAdW+7GsdaguuX3GmJARz2+Q8qr2KNIfBKxRScQz6
         uSoJFG3tU24WHohWEUAVqgwDJg8ELkhVAfuxMpU2/5apEZwaKHpKZQKckAooScFjPRJ8
         48++bzqlZK1lZWuHDCc5BJheYAYZREDgOTs8BC+x9v0Jzw751yyZdSFg44UCE1yiJ272
         1PXxEGwDA0dtqdG96nDClswgYXmY1rLs4cxo5XbGCjzEJb1fbnmv/DpVhGYzpY1Qup8d
         RAL597MMEoApuqmdjntAZpUZgriR/95SDFyc7h9OjfTZiZK6G3qcIPQEY1Vri8Lwhx9E
         YOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786508944; x=1787113744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dBDm4XABT+M35OCZXHfxjb6N217Z59IKvmM4b+FhRtg=;
        b=OoLCf53L4finn5yfdF/LlN64SC3TlwvN3BAxTrOnnKtC5DqH3F7wIRlivNuRJfO+Dx
         WmkSbl9wBUZJwDqL73NBexq629/lsiEtsfb1h6siTdjX65NCEGk5ddxXMmDFKxW6G6wx
         kwkYxpuB8xHguGFzvAuZ82Y4ZbJEN45JUVpiZQY1+JlZiCmzB+oSEyN9H0ACjSFGVWpX
         I7BcgKWzjIdqVm6RpmZNGcFth2ZsBhtyCP1PKDU5Fj0W3xDvhYqfm59Z11z9uQ6gR4ge
         LGInhKgj+c58pXVqG6VF3odhA4Bjf5Ncrb3UK+DU8Px47XS47LCEaIjhjdOE3inX7j4A
         d7uw==
X-Forwarded-Encrypted: i=1; AHgh+Rpci6vP4bisUqqC8Q8iCqcZ7OYjiMUcfm+/m2njbLsgpx5B3dPM/3gYyjigIltgMZzSv57d627IWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDgEWaHvfDeasdVxwVOXoXHKqksPQk98SM3vU+Kj3R6vTavFb
	M9nJ5lrF2ThErUV1Dz2TcNH/FhOA6pgHhKH/I83CMQdvGDgEORlziYGu
X-Gm-Gg: AR+sD13XGe+7kn/CjVAlCHAVbBqDAw/FiRA7jkys5m/IfCdi76H5rO8tcXuK2pwsjz2
	8gNYn6cNEG0EHeJBRdjG4sATNuq3Rffc0l+Vaq4fXk3mpva6l9d1ff646LVeNOOIMQEizQfSzoe
	F6TlKaXnkWLybKD7Q5L6XguxMw8LWKHSw9O0wKc6oNVZHSVQ9+66iacZHev0ueCrbN2T5mqmBsQ
	yp9WF0Fx339fHFzA2cowFCjR2U6PJnO0UgaJbmxsikke9tleY5/erUGXPeWEuOlqfyEj6JGVCqH
	4F3hPlZBzVMhgaR1qivRGChQy9l2rr6t8NYQm1w6wM5PN5q8uPEQP9RZMIcj286k/GlYnHHdx3f
	9fM/on9ngXFvuor2sGJlZVnUFyMdG0F3oNX8QV71VR6/RcJSCN7dy/sq/rHOxhvxlBmGWtIdLGa
	RfIcQaoYU/GomSYHKjuT5rdllg0L8pBymXMNYah/KuldrUyZr7Ug+YGleFpVKXSv3RisZmEZV6C
	9urVaG0GFTkmz4sCzQlrF+6tzCGTHS5Ng+mIibv95YtdpJpGslwfkuZ1Ye22pnG4RQzARHXhceJ
	XexW
X-Received: by 2002:a05:6a00:32c3:b0:848:2c2e:c79e with SMTP id d2e1a72fcca58-84fb53ec59fmr2561067b3a.12.1786508943983;
        Tue, 11 Aug 2026 21:29:03 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1cf41acsm476376b3a.11.2026.08.11.21.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 21:29:03 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	rafael@kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/3] thermal: hwmon: Remove redundant OOM message
Date: Wed, 12 Aug 2026 11:28:40 +0700
Message-ID: <20260812042842.15209-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812042842.15209-1-phucduc.bui@gmail.com>
References: <20260812042842.15209-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Remove the dev_warn() after a failed devres_alloc(). This is
consistent with checkpatch's OOM_MESSAGE convention: no error
message is needed after a kzalloc()-style allocation failure.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/thermal/thermal_hwmon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index ec73d03a1e60..747ac87d1c37 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -269,10 +269,8 @@ int devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device
 
 	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
 			   GFP_KERNEL);
-	if (!ptr) {
-		dev_warn(dev, "Failed to allocate device resource data\n");
+	if (!ptr)
 		return -ENOMEM;
-	}
 
 	ret = thermal_add_hwmon_sysfs(tz);
 	if (ret) {
-- 
2.43.0

