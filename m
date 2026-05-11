Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075C43DA59
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521981; cv=none; b=phNUAyod3tsp6XyJ/aD9aoXREJVWWTgmfM6/JxQXSi5HHljc2gsnHDgyIKTtmoZ1iqw4fSPUGMR9kbZTmIVGLNQQK5NHbwPzM77Sf5Tn6Aw9xLV6boWIvBESy8rlrVZJ5teIMZuzT1m8JDbHyeTHxTLGdLvITNEULEPIh/sLUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521981; c=relaxed/simple;
	bh=Mcwjhvi4dtHzLAlnm1NEbdZ1CWs3F9DB+akIHWfhsoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXLgYW3eqySIH20xjVwtoojFgvHtb0KoRi+FicK+e0/wCcfPiMDoMQ0zhSrE60P7vzimSrNsciTCduOF1kOAlG5Sz2g+wFy8PuEHvXJR8PgHslxeCJJEFdheHjxNitVN9TWhYoUDuCyp4NXO0gh6NsssN507aghAZiGBi4cqRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6CCRdHX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6CCRdHX"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so1847974b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521978; x=1779126778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+Oww1j79o//OaSLDcXcq/lKVLOiBBH3n/7FfQT7Bz8=;
        b=i6CCRdHXeumWKtrHYKvFRd39dZgIfsy0Mmyr74VsHH3gMmTVT3B5VIi9Qah1X503so
         zwwLJE6dAkmIaN4jS2MOVaRQsJ2t8ggOoFlySlaTdCypZg0pWKD44mAIe/5PRZDnTqWq
         DXvn9uSQdTkHJLN2AekwRX9luaeX3v8iDwfkFKVEHv16WWOm7TdmZc8a4L7h+qeaMu1J
         oe4AdfuOKBahPoGzBrVfC+2GfC2oJC+ASwaF0P3PQn8+av3gmw3/d+G8LAUKi+biG9yB
         0LyDxAMYYtsY7OiC3ayunkVjAXBFLfcsa0XF4tiei7YxSCanAwQJ4amFKm3GOxKwucUi
         pAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521978; x=1779126778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+Oww1j79o//OaSLDcXcq/lKVLOiBBH3n/7FfQT7Bz8=;
        b=aHC6fZ7Lbnt3jBXXGtRYmu3Po+qrtv/n0R6DUExZhNbQSMdE/OQsYzcL39UipKIRXZ
         eqF6DsU0gZwDq8LJbidZ7ZbCfHHIcx2KwrKXJmv5fx22I1IOl+po/+Y8PoC8gnfG5KQ6
         lEENUqVa8rXVV6agBON/rEO2XBHnBK+3WbeKSUweXLQ7oVchZLsNHUJ5kPo2d32AEsIQ
         nzi3QUgfTgHTfQoBpjwPIzp8aXlc77nMOOlkIPgCTHVUdxIajqCArUbyLuwbgKpqZcUg
         fW7SR18vVhNtoIPAXMPKB6RZVD6cyIFjE+W0xmXF9Mft//otK8QDMjwE5p1b8sX1vw7G
         HeMA==
X-Gm-Message-State: AOJu0Yy9aMx5VCAsDGV8gZp6XO8zN5+j5F/cJE8/QCJt6CpVOi1csEWA
	rEz6SzRzD9xvQzSQEXwE6hYR8cX+fn56Jv/YKzwz1jt8DHuFoSpK6N9qBHXG64Uj3yncSA==
X-Gm-Gg: Acq92OF4EHfmTyHhIO+eERL7ciGekFyQwbL4QLg65+oPiXi+EGflkKAgxysXCBTGlax
	tFK6fR9kcX/Inx5AdsVDrTLaAgkZTbEOOtmfXIY+pSwsPoRYt3TYRMtFlffyF3Np7qIiWFzfrJD
	MnYlhs3t8UgAjz1wsDpdY4LRckIe/LguXeyQILCnnhMbC2XISjcpkKBYV64DiG5T+wci/fd0AaB
	GxnWiO/giGJSJvflluUsdR8fhCVvww34hVYZApvEsY+QDx2PcE4tcAqJiiAboFAutoRAfy/y+wB
	tz2VN1/VMGo0/IZGvujxVTIWsTKJZ2lPlxbHqMWcC49QXNSuBYCSquO0puLRYrWoV86Hkr+MQcd
	5uv/8q1ucBYkqnQE5cVfAvaFuizlV6huGlhCzIhiUPgAYZj0KbOqs8YSm81sqqVt6H9Wb782WBo
	R1Tp/elURCD7htEfWvj7NyIZLW/ulHalzmxjc0
X-Received: by 2002:a05:6a00:b96:b0:824:a22c:c6d7 with SMTP id d2e1a72fcca58-83e39d3fab1mr10446662b3a.18.1778521978241;
        Mon, 11 May 2026 10:52:58 -0700 (PDT)
Received: from Strong10mede.domain.name ([122.161.50.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945101sm20428328b3a.13.2026.05.11.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:52:57 -0700 (PDT)
From: Mayur Kumar <kmayur809@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: [PATCH v2] thermal: sysfs: remove space before tab in macro
Date: Mon, 11 May 2026 23:22:46 +0530
Message-Id: <20260511175246.217788-1-kmayur809@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0jskPFOQELt+XE6DhcTxVomqzuVJF322n3n3xffbG9Uog@mail.gmail.com>
References: <CAJZ5v0jskPFOQELt+XE6DhcTxVomqzuVJF322n3n3xffbG9Uog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 5eecae13f07..15f269358e0 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -82,7 +82,7 @@ mode_store(struct device *dev, struct device_attribute *attr,
 }
 
 #define thermal_trip_of_attr(_ptr_, _attr_)				\
-	({ 								\
+	({\
 		struct thermal_trip_desc *td;				\
 									\
 		td = container_of(_ptr_, struct thermal_trip_desc,	\
-- 
2.34.1

