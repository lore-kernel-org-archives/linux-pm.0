Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32740928D
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763203; cv=none; b=OJmii+7vfmfgSRrWuDvT787KGA3fB8hW/tNC58X9LN2wcln2mBdWkiAH3AS1FKbIt55+EG8IgX5YN6mlS191kE7iHCLheejQwh3Hq92yDo1q66dR7/vxG1FQH9a9IGhD4lf76mVJX1aV1Z01qYnI/N4unQzgP4D/+CSXWsm4hww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763203; c=relaxed/simple;
	bh=rBsRy3iXLPyH0ElO7S+q4fH6ceA+XJ2QeGN6YVRABPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O46u+2CodX7sQnzocZhH+0SQdVRrhkGE/KXJT1Ar703Kj3c/zCc2tG/i+UvXWZJAUN+auJzINUnOVVlOXp+OkbBwCMDIfOYhEoaPwBuA9EciegLjp0npmyBPxcF4HcTYR4/iIqAqg9xEx5kcbXn88sVTvvlcLE9H296dfGNKZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOxT8G1s; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOxT8G1s"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc328b43a56so2609017a12.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763201; x=1789368001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rkk4VK7wXJ/SpSCUZkU64A9h/k0aBnnXr9vARP0ia2c=;
        b=XOxT8G1souvq3ejCFl5H4DWl/5Dh46UuWfHZr7bg5CKSZ+BjkMJxP0CXKodfqcosSd
         HtxKC964ddNFhW76zLNBWeoSgsz3GyabyHJCOcNN/AUIDcDPvvjkCSaT87OCIe2ZZyV5
         oTHimszHdQPYmY6wuucCMGGfjzTNr0aLfKAHqoiXo5oUbJx/qOnJasZdylL5sMEzQmki
         Px6g2VkiIWeEK4aHiZmxO9ReYCSRBSXJmoD/M8WFoJEg/AzxyNDVczSjKiejHhDAm9et
         gxDELFGZ243Uw8dxxDCOgQ/99YuBjENPRXU6xb6nnAATKq5ZQHLbsOm4EZouPC6dGDoB
         VApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763201; x=1789368001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rkk4VK7wXJ/SpSCUZkU64A9h/k0aBnnXr9vARP0ia2c=;
        b=EvgJ2DSZNofVHRFrOF5z1ID50jHG8HIV1bVPWwuIgMGPg+/MqKzsg0+StOLvLJtQ2v
         qR8yTE0/RyaJtFgOxdu7un/QtKYhscVviLEiLqsR3F/0qDHAxmMajAcaVB2N1nSJRXxh
         tvxRCnvUuSrydkTsYeSd9wzyU51uoaRXmGgjtmU+63fXvdbvDInjh/kQPx+Hcm7IRR9c
         LO2DII6rGmOECVkqNjM6o31Owmh99Ir462R3WiHDn0lv66FxRVDAkc50dIIs4c9BczWE
         86FxwvFuf3pMkhcAhJze4VasVVnNTbcp2MsL4d6jwzyzuF/bhqL0wscANx562AImlHnb
         LFeg==
X-Gm-Message-State: AFuF++kUEBag1Tk4kwB3hFVcZc+jW0e+DIn5eyb8LD8/pclXptRdpXal
	Up1wlvW2V7V39HJBnBOir2NjXVEEjCDBi8JepiUgNjF+oV1K551gTQmi
X-Gm-Gg: AYBFou31Y84eIpG80ZbYm7KBW3aAD4l1ZREs6zXGEc/RPYijBBy4s26H+2Xn3FZIG3I
	VCGZa2KK/s80viG6swrSUvFSvfwcR5s4n013RUnId+v496W4KfMUOeDLiGlg2MQvZXb5W7qwoze
	rAemm7hJ55l24TwV9kWpoazWI5X3MHwCTXgAMaZF+kCgnLp5g+1wR1l0kYNmMG22z5RWgUh+z+z
	JtkbNPWdUqfVOjf0zTNZjhrMxKQS12H9VttQP9aJUyhR2E0OIp5l7eTjTok6betYnIcmQ6qo5HL
	gMJeOjk1xQrM0Sn2FbJPXFXQdxPofnKZxCxTqlp1P73Ug69R0XhCgRDEP8cM6wP+SQPQt6uC0CJ
	a2KQHrs960JAI6YN28/OTn8Y+mKoWmunmWE7+nxbn7gQiyMH1rqWP65+FPGESOOtJ9yxeS3RcPC
	3V00Z1wMYIRaBv37yi+g/gg8OewDyh8n/WyXXu3EfJ1tM0XKIiszpquP9GupTSI3DuACDq0EWsQ
	0iixdl0lMmyPOrq71gUO6tg
X-Received: by 2002:a05:6a21:a07:b0:3d3:ae40:51e4 with SMTP id adf61e73a8af0-3da3a08d654mr34669130637.24.1788763201155;
        Sun, 06 Sep 2026 23:40:01 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm25345322eec.19.2026.09.06.23.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:40:00 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: reset: add missing space in error message
Date: Mon,  7 Sep 2026 12:09:47 +0530
Message-ID: <20260907063947.34852-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907063947.34852-1-hemanth.selam@gmail.com>
References: <20260907063947.34852-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two string literals are concatenated, so the message prints "has to
contain atleast one entry".  Add the missing space.

checkpatch.pl misses this one: neither literal is misspelled on its
own, the fault only appears once they are joined.

Only the message text changes, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/power/reset/keystone-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index 3c44cd6cee0a..dbf2e4274dc6 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -112,7 +112,7 @@ static int rsctrl_probe(struct platform_device *pdev)
 	for (i = 0; i < WDT_MUX_NUMBER; i++) {
 		ret = of_property_read_u32_index(np, "ti,wdt-list", i, &val);
 		if (ret == -EOVERFLOW && !i) {
-			dev_err(dev, "ti,wdt-list property has to contain at"
+			dev_err(dev, "ti,wdt-list property has to contain at "
 				"least one entry\n");
 			return -EINVAL;
 		} else if (ret) {
-- 
2.48.1

