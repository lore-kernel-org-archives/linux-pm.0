Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5B48A2A9
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315843; cv=none; b=GImoEfCW+BGwPloR4AizW+k04iBkMaqJv73thPZnc7h6u4vI5fG+rgBWAE0+J5NROBkElPBxC1sRnZKLO0gOj9iorU2jn0G8Ye0/ambbXGa+xHS4MINs6ZTx5pQXuwDQ0gMiT9G60DCatXvpmKQdG9Bl71bxRpCJ0ylFLQYgwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315843; c=relaxed/simple;
	bh=a2V+I7UeXRDj3lHU2NGFDjdBIe3drc9UQsymhMr1D/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thFr9YNux2tgIutx8E8n3ERaQWKGaYktfPKMtoENtGQTcezvFPkDOeSgvDzJ+QxICSr9n/LwuyEGKl8WeuV6gP16KWTBalFlylydlel2qCyHFwdl48EYgm/BnRwG3eyIfgytNBUyeJ4Ud0qwZK5Kr8kM5rGQXtZwZE1NPI/RoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeOTDygC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeOTDygC"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1c52d920b8so136608166b.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315837; x=1787920637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CC6zM5DNH7SSIqqjxl1MzTwo2sU+cNMvlHaMx4m2Zy8=;
        b=LeOTDygCXGkBZ1wZum1J79iHIB1rXhswcjl4Vxr1/j1k7at99FMQ8uG32FTKnitp9t
         6zjDQ69WuS/p2/HbgxHMXMizbu07txQ+RWqTruNxAuBslksMkzbATgteR3m3yBtlAE02
         N9IB/qHFXYNzT1DHwmW9und2ANyFS4pg9r9PdwKPPuYn+GScIjDhT5FY205oQ4oouCZR
         RTkMsthNvcCcJOdHDBPtXYEUIrrKod8/7FP9YiCWq5aHnkSl3wk/CLp8A03qbdwH0rTp
         R3ZBNOgjjrU1wjFqb7x96uz8zjCSEu62o1mc7puYEgIoU5ICwiDPCvvwwI77kPb4SxlP
         KUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315837; x=1787920637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CC6zM5DNH7SSIqqjxl1MzTwo2sU+cNMvlHaMx4m2Zy8=;
        b=bz0JjJn1Skbe2OBx79w0HJLoX8QuKm13UsNOs1waMqcp87o653ukjk4Rw3MqaEMEDh
         qn77Q5+X3T+Di/IL4zBrpPjrj2fAQAV52drE+SwiUcvrFwekZIDNSwM/mW3SWMm1cGBo
         5bidSLnXX1XTcLXGuJ/HHHBraFzMTKB9X2isrufyJCEVZCBQSAl6eghZpm3+fJpyzJzm
         M60+exCC+bQN2R2VpKZo99lqYOv6QcOq1a9YWTAWPyIoYHc7/QTBAXlQ3+wRPrZHepCo
         +kkUva/c5tEvQOmx64uSE16olEo1yiXtTdcnMSy628Zf0GUDbIV+XGqE0/vsjPz3gB+3
         xZGA==
X-Forwarded-Encrypted: i=1; AHgh+Rratnw0gWPpMoLcGhG3HwEKGsfy1lwSJV7H2nTYHg3t9XrshUh5KiAkgTAjPPpJdP+bO1yU73D2tA==@vger.kernel.org
X-Gm-Message-State: AFuF++lHKBANFAYd355lUQcHmMdEu0O8SVXDTmCKOcKN1aOWWmYlv9lb
	qtBL6/u3QH3MHRtdAnfnmuNI2AW5BQswsBbvWnOkQV3LtQ0rzS91eI7H
X-Gm-Gg: AR+sD13u4PCreMqvEIxEV7/1z5Ge3ywPxaMuFyYfCwVxC2k+xLZkGl9/T7Tqp+5d4cQ
	+//YGKMBTED7zd7dC+fPCWa2pdg451UsWdT0CWA6F0LlUcninXul2V3HodFxD1Pp2Wr/6GbxRPL
	wlGF7nnEOf2Qa5F7nqqIxpFcDxBlVmtWp1ZT1E2y5//6TyjxLkATpCnicfHt2sb6lPopHyPH2PE
	yM+ss5qXZ7Ym3BzVobbxpVq/+Ql5iEjge8OLzNrsLfyCvhbzIEJq22xjA4IwK6vNFKtl7ssSn23
	PHgwSD/aLG+1MH5BaYtUBbO1m2J7qcLpOuO7INYMpa99VzuqIRW8/4QyOirnxBhLPrwA7fNszfO
	UYGoYbkAolgwcPAc40XaNhewIr1a7a5rTWRnpb6V6p/uAknZBQ0ITDDxdCOVKZq85KM2fHPDaF+
	kdXY2OnWN+mYUN9aSSPjK0GUqBSnrbS81M2wI9K7U04ce/elgc34u96LDd4pxGg1jrahEU/Ztvx
	tbYlF0qAnqyr9uNrunJ4Q==
X-Received: by 2002:a17:906:f359:b0:c15:f0b8:eb91 with SMTP id a640c23a62f3a-c246a359a52mr510507766b.7.1787315837384;
        Fri, 21 Aug 2026 05:37:17 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591e0397sm451194666b.53.2026.08.21.05.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:37:16 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
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
Subject: [RFC PATCH v3 3/3] arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to device-specific pmic-glink compatible
Date: Fri, 21 Aug 2026 14:37:11 +0200
Message-ID: <20260821123711.1579539-4-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821123711.1579539-1-zstaseg@gmail.com>
References: <20260821123711.1579539-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch taoyao to "xiaomi,taoyao-pmic-glink" compatible so
qcom_battmgr can identify the device and apply its taoyao-specific
battery property mapping, required because its firmware shifts
battery property IDs relative to the generic sm7325-pmic-glink
firmware.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
index 6f8bc65bb99b..bc4dfa49ef38 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
+++ b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
@@ -72,7 +72,7 @@ key-volume-up {
 	};
 
 	pmic-glink {
-		compatible = "qcom,sm7325-pmic-glink",
+		compatible = "xiaomi,taoyao-pmic-glink",
 			     "qcom,qcm6490-pmic-glink",
 			     "qcom,pmic-glink";
 
-- 
2.53.0

