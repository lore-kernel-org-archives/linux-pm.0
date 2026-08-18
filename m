Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEBB3B4E9F
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065850; cv=none; b=oQoVwZKPvLBghS9ea1qs9pfaTPgyvWz/esF6jyF5F0DtMH+QCpdV6owxtDVD+UoM0Oa33VVAjKm6dRM+jdmxzkpWLcD4V7YzS1mdPGjTFNSYZAjy5YzHul2vAWNkIigHQtm48YX9SaitTWP8AIh0HpiZNDAqsLB7T++gmcO8cWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065850; c=relaxed/simple;
	bh=+7pHwsnV4lHrk8bBeQ822eoOERyjkAcl90hyw9Ad1Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq69kRjpVkb6i7gOH1atkQ7KglNYwDZqeVSz49K0pz48hXuiANtHXVkxgnVF+nudTCXh1NbEeKs8bjBzlJs6t4RyPTwQ7iHje3coQlzpBk5rOM/WLcZUi8a9GlGOI4wAUu/2lNIfH1zOM4nOOuIWRkNnIw7qhUIwO4PgHTz5Nz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH/J7bt2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH/J7bt2"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15c42a45adso164743166b.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065845; x=1787670645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJ2AQS/8vCTGcQEdQTct21p9QgOdd8opq2N9gve7b/s=;
        b=WH/J7bt2wH+HBMoxP887XG7EtzPN3XLvEbs5iinkE4w01sz3/q2sDXMyA//RtJBGjD
         9sW4NknHMTSDBrGY9m5KM4MoagEF7cHSQh6Jk/ybrogiLMqf2LDXqFePMXRUTQpG9jVT
         Di8n1tz7KW4Z62qS4jLpAvbClMMbB78dYOYkO9WaPgWhMJf1PbdRX7KIobVmy4lhiR8Y
         KdUq4fPLqnyC84Dcwia8KjhLbeT+ONgFZphs7eHXNJZcjJoqf/o4AWIaj41Ao4yf0ma6
         TJpMilqQM0aGm/B0LZrplh5CPSd5NlSiAhp6qyOIu85t5CHBd0MR0EaeRJ5cmUQyKD9N
         gbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065845; x=1787670645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XJ2AQS/8vCTGcQEdQTct21p9QgOdd8opq2N9gve7b/s=;
        b=mWBmXb/QRFBAk8x2JBO/aUQ7Xq5aVbN1dsM6+QpDL5Ea1ATvh4ns5CP3VSDzZPr1+o
         H3b0YvNGE23oZ6phRA3SIiI93d49SOW16H2YVZ+VVnX8mFNffOn0ch0lQneI9uy/Hh5V
         z0O4Rz6vp+SSepfl4nsK8eKhfdJDmhtqFae9ig2zg/SjLxHHlVdcLBN19Vzzw+jHYDU1
         TcT/uqgoghK2Aum5t6Xa++IHIFO+0KYR5FlUtpZGh4CuFt1a/s2TvT8gsvSHdcaRFdQ2
         JXpMPdW2hrj1HmBUwL7TLNM6W20tISdfxUYJ4xB6U4w/rRwAGf+lsl7+9CfTiVU7ILVQ
         LyRg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9gMlw+hjMwfeNpKpRFFxDppXfNc+JtRpgvF627R//rxOeyqVDY5FduTyJQz9Nqxr18var8TyXfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYfpmzHgXQ2/H9M73nvYr7WPd+krV/DYF+37Ibu4O9tBCbVno
	tVZdZmFv0pDqkGl9H25fmXXwpqtASFb1TN8cZsc5hXkYkNwmLl/0H80N
X-Gm-Gg: AR+sD13vEOysDQAHfMPGKHozNph2WwQV+lMVph+pUFZ0Dtdfkf5XnqsAxL/0v/2zes+
	gP32CWxDwOx/vHOrXOZ2OUWQyTRgVaVHOkVu6FriDbXTxQfo9YUOR8fnndtCgiTH/9YVlzLQ7u9
	yuguNR8X5S9bRcNg6RIsMU2vHhJwJs6aQcu5qRrw/03LuELL+wqkgiIJbZIkNMtODSq0DOz4JWK
	Upw3q21RvDFCh1SeHtfwu0DlsKg0z72N2KkgocNIk9cxC4TMGvOoYlCFox7Tno5+jwABgBLzHhs
	Bvqo3sy5SZ6JSEAwBhmxlc5ebUsfVkN9jVpRxaT2xBGwRZQUDObmyYDuRRM/fyL+FQpTtW9ZYzl
	XHuRR+l4RapAVCBlzw3AmFcNXaHQSxHq4dhAKta+CEw25YBaEdr1qOXT3U+gta/mxFy/+4yHBJz
	bz0iC6zn/I2YqJN39QAlb9NB5vXB2Rf+xQITmZJ40z/VPfl2D4z9AQu3YNOidhbupsUv0/c5/8h
	6GukWOY2XHunFpvMLKzc56A9Lx9HkoiDw==
X-Received: by 2002:a17:907:6d1e:b0:c20:f85f:e7c6 with SMTP id a640c23a62f3a-c218b0b63a1mr487444866b.8.1787065845137;
        Tue, 18 Aug 2026 08:10:45 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fe69cf4sm205772266b.3.2026.08.18.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:10:44 -0700 (PDT)
From: "user.email" <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to device-specific pmic-glink compatible
Date: Tue, 18 Aug 2026 17:10:39 +0200
Message-ID: <20260818151039.409767-4-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818151039.409767-1-zstaseg@gmail.com>
References: <20260818151039.409767-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanislav Zaikin <zstaseg@gmail.com>

Switch taoyao to its own compatible so qcom_battmgr can select the
taoyao-specific property mapping added in the previous patch.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
index 6f8bc65bb99b..6621cb40e710 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
+++ b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
@@ -72,7 +72,8 @@ key-volume-up {
 	};
 
 	pmic-glink {
-		compatible = "qcom,sm7325-pmic-glink",
+		compatible = "xiaomi,taoyao-pmic-glink",
+			     "qcom,sm7325-pmic-glink",
 			     "qcom,qcm6490-pmic-glink",
 			     "qcom,pmic-glink";
 
-- 
2.53.0

