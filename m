Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3F48CD7D
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832450; cv=none; b=YCCc8CSAQQeVKxTT66rwFTv6JQmeisv6CCxJfb8R2fUl74LEjGM18TwaMIpVpYwASBtPOG2rncCcm95EnzYF/uehfvNheMvpfurb2Li4DBo/JHqDDGLXxIloxZYVO1bMOfjWCMfgIyu23tCmoHyOj3p2fnGQCG582I2bDxKLHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832450; c=relaxed/simple;
	bh=Zi8vbQtaaCryc4HCpr0GtJV6f2jQf9Xj8C6Qirl+108=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHMK1Qs13MC7F94gntYhxOAs0ojETJedAm+zZYMCLPQNUXg+TsdoQSL/8p4qBXHIdB1tUnKiywI+l0+jYbDReVW696yFlylLMcmHh2SP/1yKos9DJuUZff/7mNGyQ+2llKiFYRVlQ97s8C2bcWCqO0KJchfp3UGLP45uG5YfxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY0VIxvb; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY0VIxvb"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38759bcd877so918144a91.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 11:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832434; x=1785437234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+UjJ2nGjxXWT2RhAQzqOjO+SrT+lpfkp3b16ZbPdls=;
        b=PY0VIxvbzzV5xo3uPJxOlV3TR/vBEIMBSX5Y/igDCCX24oj4IkLlnrwDeC0iDhKxxr
         QaW9sQ/Wmnp+hfsP4fqwYajs5DqHMgr9pZqqswikHgAURMsgk+Vn0ic7O8UPXH7UVcZs
         9cuRRVmRtqWsO+4h7wSECcpsV//AK87eTXPYDGT7GOe4Cwi0HaeMzynH2isEb5uwz24P
         d7HA3xQEdPTZ1MM4ulD4YqyiioQTgdyyYOX7/SG72MrGiJeXEkB6FNi45Yt6bhUj11J3
         97eBYRRtG9lLWYk7rWwZYvC7BTo7mGY7DwcMF+dxaluj/69q1lLTHjSCPSm8wQ4HNeQg
         hpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832434; x=1785437234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+UjJ2nGjxXWT2RhAQzqOjO+SrT+lpfkp3b16ZbPdls=;
        b=mVqjmHBIvFXlO4BRqfkwqSAr7YtXmNWWFdUj3VU0Y6R3R+MeST8xgNBUb8rY2p4cdr
         Ds+FVQdaD2zTWUSPPoQlfTl2nGCA5Egbr09SSm1YaZHgRWTt1T5VdSjR97AzPzM+1u3y
         TVX1lzHp5sfWVx5ErMAc1wGK6AtXCZCW97q28am8ot/7PlQ1K9DdmuDf7xyVakbe5uRe
         XMO0wDt9OmSKJtqPp1NE/TcpYUk+XyOJp6gWM+8sl6mCL7oKc7Qrbk81V3511g1r7uV+
         +RUyXfM+vHXo1AHq3XxlzoILYXNtzw7dm5xNihqRgjvvv/oVtrYwp3P+BQSm9135K6HQ
         fOoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0lH0S4LXpNmfx4LMQeqzqT7nILl1j1bhORVcKQK24cCoKXYgr7g9quKmaBAciWsVjP3rbeSzKIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQqllQRtfzWJfYtkNFp4zhs5O5pBP7qcLq+vZnPdru/jfYwAC
	Nk2pIg1YmAEtY2pJQYZdYDyV2KtoqkUW9Hk/O66FkQYzJTmbkG13O7+i
X-Gm-Gg: AR+sD11kJSwz+sTK/bPZWhXGy6b3GuorkryZ/FU7F0w6gAW7zwEUs17X+hEsttcPR4K
	L4GoSvUy7sd/SGsKVH6bG7sXVUcO6x0NQwMA4LysqDpNSCBCrxtLs6urXYcVMFUxR9j4Uj1YBEO
	VETO0vOF05tP/qsLXaUY3+RVPPZAIviavpBR5NVhctsUFK333UZ17wfCKFP0ix98TOtaLMIJqe/
	F4yuwUIwKTZZ7locHpb0KBJAMwLIfNBtzGnMQT0X2XoYK8bSkkGEsY+3B6oM73cgKWtuI+ILOBa
	O9XAjJ/5KMbr8hCi/a4BH7qLcFkeuMH6Vigx1b3RrLAeH8eEAcCRWGD8fikS+DHNe5OxOcI8toO
	wYKHwq+Ila8HkBbhrv2t4uIMG7it7go8KtbN6sB9BXPksV1EtVxN0ZG1fMiZCUbZ+im2RT/I5
X-Received: by 2002:a17:90b:3ccf:b0:37f:fda5:8d9a with SMTP id 98e67ed59e1d1-38ec6a5115dmr4286424a91.25.1784832434078;
        Thu, 23 Jul 2026 11:47:14 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:13 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 31/36] thermal/drivers/k3_bandgap: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:33 +0900
Message-ID: <20260723184538.3888637-32-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/thermal/k3_bandgap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 678d6ed711b5..766fab7bcf1b 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -141,13 +141,8 @@ static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct k3_thermal_data *data = thermal_zone_device_priv(tz);
-	int ret = 0;
 
-	ret = k3_bgp_read_temp(data, temp);
-	if (ret)
-		return ret;
-
-	return ret;
+	return k3_bgp_read_temp(data, temp);
 }
 
 static const struct thermal_zone_device_ops k3_of_thermal_ops = {
-- 
2.43.0

