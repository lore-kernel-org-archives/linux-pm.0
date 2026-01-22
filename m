Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311B338905
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110487; cv=none; b=b9hSXWFcOsjAMGROj/AbZoiXGDXjCuA2nDXThUkKjuUDCni3yr7wKitsYuuNGH1e9rWlEmqyYeX2T3WGoYD70zTBaaFRBK8Jx6lBEOCtDJpHK/aFgEmK8jD70UiX9egWDB/hP3gQLFpO6gXpckPqAseYRNsfUThD59JyaNxWSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110487; c=relaxed/simple;
	bh=jTd4MTqmMNO3vH3GBJWQVldpXyq3xREZZ6+pJ2KLIaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KExDGNxwKPWisVHzg+tSeS3Nl6DHmVshgp1sIpkwKFpSO/r5bekQzuTtYf/aAKYlrJgkcAkVn9g+jpZCSy3VEiffYq3jhAqkQRs08pAGglw0EUXAwNBXg6ASUTEmEkOcTv7u/uxDcvJck86cCoGjjkOLfAEDFhEDukaW/GHpy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnQvBSPw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnQvBSPw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so11973325e9.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 11:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769110474; x=1769715274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBXXzdoTJkB6zREE7VZrROs0/EXufGyyyFOZL5fXDdA=;
        b=UnQvBSPwithfNhue9HQBGrT6Y4x0nK439BXNE7wVBhxoyBV8BbROSxQD4iui7aooaF
         AT05chRiYQhDeF1PStcyAShk90pJQskEMi8TT1Rv3TK/DRSFQiC8+Xg65C/4zeSf2XoB
         Xc0dR74HkXwDRS9FEw8SVz6+57Aq0FZZEH6kYUo2wImJ0ys1lUjEmJCMZDtzrUQdRCSG
         XLAvFhB3DIgqU6QhQCR5DT/+4W3DVvhX8Y5vaawQ/pOwvMhzMM0BrDg/43e7H2YXvk5H
         5Z1QvtYrXwxYTGn6M+Xz7YFr7Z9K50KazaScEjIFm/c8e+asXcVllQJCEN4ptNhDQZD1
         s24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110474; x=1769715274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vBXXzdoTJkB6zREE7VZrROs0/EXufGyyyFOZL5fXDdA=;
        b=D7x5vb7/PaMNC+xHRT6JuphoV2rUrm5yrMWyCMUp9vdZ9odqOaY9fAMYCcMLAc2PMl
         2WPkfZAJsqCCfGv7i5V/tkGBZHfQATaPa/ZJD6JVbNuemMWr/6TdCjhwqxf7dzQisjIz
         H0DU5Egg9HnDL5yfnxR/dqSchk4osoKiJ7Tw0OUl0E2pcBMD2XtORluFN1ONxaHbDRq1
         jhucNiWzx/7JVB5zu7p0FtaERW61yq/F5xh3xd0vXpHoyr+ZxV4OfENcogT61CkSBMHQ
         A/ZcQ0HJH40Fmpufg8k6IyA9DhiIA7NJoNoVjnIHY9DCbr/taqUBhB91Dlb6ZtPJhabe
         M2zw==
X-Forwarded-Encrypted: i=1; AJvYcCUchd17yrqS9X6nfX/s80z9/Ss73Mg/HPpRXOzcmqrfnp4mKW3zbe0gj1keBjQ8JJyCSuBTT7K2mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjV2M3zjuN28nnlkI+hzS6NmAZsGRsXM8ELqdJMytSwEvg9j64
	7cuplNwykWCBjxZtqk6+BSu07sHcWTDcHmRbEX54fzq7PZFHNusaV95o
X-Gm-Gg: AZuq6aL9s1pBRIp+FrkXc+tIjyfdyVgjVFAuSNHG61KW3u6Npr9B4FNs8FG8DY5xVwc
	uLTjEMakZm9VryVuvfaf2F8HkvTvm4jjpJklrsUpdoNxOR96WOz4Wj6zOit3UNqbZKkNZrz6Zfc
	/D/bQGwEcbBycpjwUe1qwtLBA/sYsLuBxgFo1lm5sM0TPNL8RXu7viVwsKnXx2ZqjYsCQhOcNL4
	oy3xt/MGkOmcmDyZjmzzX2O3ut4kWj4qvr6kg0fL4b4RyOCzHNeT24YPquZS/I2E6i2OMRYcWQQ
	wO5jJJwoOQkTajZ/u9jnzdEJJKzdAyeebw3DFuJJvy43BDvytdy491eHlI8gELU56Pkx2SoZfd1
	c05ss1PScaIsl1DTlzdo/RsBenFYFuA6xu91EGfu35A4IeWDsN8sOOkcnCoKJYcRjXiifeqRrQQ
	10klJC1yfDcfiWTD55qLeAQFu5BxYEOaONMbZt0Tna45r4wBqRzV4=
X-Received: by 2002:a05:600c:34c6:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-4804c9af7femr13146905e9.24.1769110473766;
        Thu, 22 Jan 2026 11:34:33 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-435b1c02dd4sm853240f8f.5.2026.01.22.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:34:33 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 22 Jan 2026 20:34:22 +0100
Subject: [PATCH 1/2] interconnect: qcom: smd-rpm: drop duplicated
 QCOM_RPM_SMD_KEY_RATE define
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-icc-qcom-dupe-defines-v1-1-eea876c2d98f@gmail.com>
References: <20260122-icc-qcom-dupe-defines-v1-0-eea876c2d98f@gmail.com>
In-Reply-To: <20260122-icc-qcom-dupe-defines-v1-0-eea876c2d98f@gmail.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The 'linux/soc/qcom/smd-rpm.h' header defines QCOM_RPM_SMD_KEY_RATE
with the exact same value.

  $ git grep -nHE 'define[[:blank:]]+QCOM_RPM_SMD_KEY_RATE[[:blank:]]'
  drivers/interconnect/qcom/smd-rpm.c:17:#define QCOM_RPM_SMD_KEY_RATE    0x007a484b
  include/linux/soc/qcom/smd-rpm.h:52:#define QCOM_RPM_SMD_KEY_RATE                               0x007a484b

Drop the local define to avoid the duplication.

No functional changes intended. Compile tested only.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/interconnect/qcom/smd-rpm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index 8316c87a2c60f5f99edece3443cc60e9e75fa11f..dbc7ae50b02b7948217c856e3b1bee53c56f46e3 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -14,7 +14,6 @@
 #include "icc-rpm.h"
 
 #define RPM_KEY_BW		0x00007762
-#define QCOM_RPM_SMD_KEY_RATE	0x007a484b
 
 static struct qcom_smd_rpm *icc_smd_rpm;
 

-- 
2.52.0

