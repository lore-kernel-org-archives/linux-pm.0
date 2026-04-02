Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE1534DCE6
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098466; cv=none; b=CIypOJ5eEbFCMnQWjANGPJVggpqcGsUn8bsaBRWjiB7747SA2X0H0EsLlS3MRXDK1QJ0+xdYokb2dy6PhifN+cEgVwwJe9MVx6Ypznihfgaf2GT0vGISr0mdqoAqMlbyHS8c9XWHzqu2mh8W8Ctoabj3JyvQ3dDB1QqZwaztWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098466; c=relaxed/simple;
	bh=Y9HeYqp2YKkuGvR76szlppb+czL55bb43Vv2WFkSYbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTNp1C1ZxxqoZ8AZZQgREYYSLhYF34wJbFjhzefuoPT7famR4UWFDBiq/S35MzAXvlZbgbutzR6ffvwiKR6hPYd10FAw8SPl2WSlw7sR+TInyCYSdzqV3mFLL1FWNHGOap/WKiZMVYYv4r8tvgTYWHKHhTVYDT9AIBqV9CVxPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQO/zxZS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQO/zxZS"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so3128145ad.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 19:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775098464; x=1775703264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5sr9v7Zuu9iHxuJmTHoD9xVEpDewDxOWpTSIoGG5k0=;
        b=lQO/zxZSCxdD5vMlyZOnqaCHABxNry3oFJ81fAFlnYz0PN8j9LUkcDaeCTlOdE3lRV
         2SPz/TY3WCijeMRQJDIh+GIRIXYFPQuuyq64apdYu5wxMHVJXj2FSiAHQZp40hbqA6cw
         9zeXQQlzslFY9Ugm6BGIvFDQ3MPXid+z5KffQjv4zQpUc8iQ0m+WUakDrp5osc1xQacy
         Mk5ZMQC6j9eOwlr8umRqnEndMRlGDMEVCWQO/6rrnv2FJI5TzpvZZKUQyNBUKuVmUC9G
         pZfT9XW8tPccGH3jehcBkFFTiHxxa+Q2yl/jyXRIOC22XbpJGstJEa9EMjwrsZIlPF2r
         FjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775098464; x=1775703264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5sr9v7Zuu9iHxuJmTHoD9xVEpDewDxOWpTSIoGG5k0=;
        b=DEQbdM9J4AB4guSMfNVo3CeluQDAHZE1c+QygtPlij18/n/BEJpNYoAxUGtbEAyQzO
         bHiOf6VcbS2JAQmbUEVL0LxKvGp9Wr8Z7WIqon0C8g1EdBXDT/jems3INJYTLFpY4wXx
         sPv1ADYaN3v5qKYyVKhO81zryAsFZtqa0QO7DSYEPPTVjo0UPsG7arYLPMML/eXMTwpF
         jVApnWHCZtN6FiBrF36R37g2jF4EbsiBmckv0ZQh/ToNN+n97LGq5ENAx3l0QTUc0imQ
         pcoAUOhVFsQqu7xWeLH2cz2ot43YGIN9aIFObdfF8lgYJS8/MBkl9ZG7jmQyA3IGUMKr
         fqxw==
X-Gm-Message-State: AOJu0YzAnYswt9Frzum6WlK9KutEaXXcCOCrLu5EhsamzQ+xLeZcptvr
	ERoLZvVv6IhVx9UlVOZFHZo4zo+cbs/Z2MV7LTL8p8Y6SLs49qfk+nJ3VRWDdPOz
X-Gm-Gg: ATEYQzwWbDjBD+Zzi32shJlQ9CraQJaSXz6PB0FT7mGY6vBnnYIdumzbnGFsNhlJ7nz
	RbCR+Zkh2vZ/p+XTe9gdgdyvy+jcX44RJ+xotRjx0EyEVF1b4EY7ZenUaCRz892+ni18XpN6hBd
	oDiHP7L8yg6Aev/XzX14vh00DIjLkKMan62/Cn/sSMJYNi/OwefqKjKL1HKr3ppP+bxLemi007C
	WlKPNHD+VQAlPqz/cWEsI99YCIX/qHhYFbP4G+0vcBslrTpDpQqfUgJcVpyZ9NcH/r22y4LOUN5
	SXBL/FfY17UkV2aRLu3UoV5WZcz2VThh/kUusUW2PGiq8eTztyjXOTqPu3BpAmX/pYBODtZvmnq
	HolYe/cf56Oivz3Bt7c8qx6AA84arR4QtU6T5uiGi+QXMwtEpcel/CfUYX6sld57pDjIpnvWukM
	PC6q4QXkf9bP2YTUNxXqAwi5oteCYEG4npEZTjXxkbnvjNPNdsjy3nHHQ1E8YCbKxGwA==
X-Received: by 2002:a17:903:2b0c:b0:2b2:4697:78f4 with SMTP id d9443c01a7336-2b269cffbfbmr60342125ad.31.1775098464152;
        Wed, 01 Apr 2026 19:54:24 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749793b9sm10875345ad.48.2026.04.01.19.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 19:54:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pmdomain: qcom: cpr: add COMPILE_TEST support
Date: Wed,  1 Apr 2026 19:54:06 -0700
Message-ID: <20260402025406.94272-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows the buildbots to build the driver on other platforms. There's
nothing special arch specific thing going on here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pmdomain/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/Kconfig b/drivers/pmdomain/qcom/Kconfig
index 3d3948eabef0..72cbcfe7a0c9 100644
--- a/drivers/pmdomain/qcom/Kconfig
+++ b/drivers/pmdomain/qcom/Kconfig
@@ -3,7 +3,7 @@ menu "Qualcomm PM Domains"
 
 config QCOM_CPR
 	tristate "QCOM Core Power Reduction (CPR) support"
-	depends on ARCH_QCOM && HAS_IOMEM
+	depends on (ARCH_QCOM || COMPILE_TEST) && HAS_IOMEM
 	select PM_OPP
 	select REGMAP
 	help
-- 
2.53.0

