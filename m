Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864429;
	b=pOssTP3p78W7/lwunLWPsHyidriL0E3AIQU+H2oEuEjE/SEP1zOuvKK6yv83m+QuoYNE
	 QaAXoMnLu1YsDONnrXrn7QwbVW29MftOLRgb9l6yJZzvdj0ATG/IBRLaj/LxG1kehdH6f
	 E8SkR4jV2WEpV7Z6jXsWOC/a+q3FamRztzXJ+5aFjEVAfTcdfNnA/4XduPmzYmqATAMhK
	 w4b9azS/vlbmRoSqLgjzzpe/CbQVPNmhAuuYjAKEQZjLmkq2Q7QTgbACnuXUTfS/GO7wr
	 F5lmQKpPLQ2G1IAcrcyUTivLibQ4ve4CZvudsXxvh/j8dqLa62d8NbsBYE/agkp7qYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
	b=3bTz3mLNCPkzjzQnPjSdfQt5ygvY/WmN9EIkYsvfV9QMrbLlGYtCzAu3FgI+8LCEUIaY
	 D1EgGJChTgoui8W1YeK2myR/CJw/8+kN91q8m5xBS3zEDGrG+MbhtQ8MFJntKi5h5ciD9
	 LBRa+/LYJ8J7C2vJtBj7QvxofaxTZX4SvAM1p1tAQBNAdeNwNiyzPmf695dWZsSYMcaUa
	 o6lYY9JuoHz7opD5dnU69QFxrTonI4MuNAUA21wawbL3P6R2QHR9Ub7P4gseYv3NXWk6x
	 LPCtAY2PbJe8mHS1EaoMRYOQ1HA8PNoBeb1M/vMu70l8AT5RivJi3Zt7bFeDM3wviVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MxwUmdGf;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9BF606A333
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA9BF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MxwUmdGf
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490d59c3edaso193688f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864427; x=1795469227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
        b=MxwUmdGfyUtZntWN+dJoS07xQM0pQ+yVQaLKkkqz5GCWi49NfYHKbWARqZKhmg5l9P
         xd2SuFAw0lCCpffBXvhmGo2xZ9cKfJTe4nfCkkB9BpB2Ewjgp1tqMuMhU61bgBaeqDer
         UroYO6LTJwf9ez7KYEQngDY0mihFGBiJsqVzaOOYNpC2W+5MvHXboThdP/oLwUGq39Rs
         z3V0OzRqMtLQ8bMsw120HXUpxzOyVHbrTE5sD5sy3vWlDMJF9dGPmPZfIctKxwRS7q/O
         Qo1H+zS0NL/QScukZH8Xbrny5RwvwyeLCvlSK/QSvqJ0ZDVKOmrNlWLe6r9KV52N5Qpb
         /zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864427; x=1795469227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
        b=gc/h+rdhUplT4zdGSQzeyDEA+Oz57PcL5lC/AQpdzxKJLmJZ7if4CZUFTjMkbPSwnu
         TeS70jtIAvTgby1ZXJMlm9nGwSiMMFjWcj3urXUsQhBpMtUH34RFLGzTFZb5vOXAxJMA
         SE00So/8sjIBUsuVNjrm9D8pFNHIMzuQ3au5MYwNpXyU+shN97sAUenXKf6kZ7cV0aoe
         tMssq1jb83mvgaT1K2iMNwcmzToW9ZVs6k4tiHf1obto75Dm8sL3LkX+5FpI/Z+I1kFt
         x7iI76TwyNjKFe32jvURdKZDDzLrpGogA82FpIZl1JeYay4UEiJXOL7FJNSJ8X1+hbpc
         P9/Q==
X-Forwarded-Encrypted: i=1; AL+hErExSO+sbrOTaRcdn7PVTQFrKyQxkEqiOSbcVWwWXp49YOJMDUwQ7BeYxfP8p81Q2ncrfl2tWhmAmg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/CB7xZRCaxk2J+5lMggrfSHb+5sSQeFKkrjAFrWRJEpYv7p1NG
	9lfQCv0XH2tJH85LVoNl2t/vjGCJ2X40d/l+7qSbrStypvF8bR80DYn9
X-Gm-Gg: AZFdTZfvrftQQ+PKNi4eudyDiAyGfFFsyjAewphrubDf1/hXhHrWQJCyAOO+aGz3ZQR
	LS00C103wzzaF6w7nmFaPFYwXP2oseiZITJUKpbChcLpq/GHqX3PQXp9RXeyR+JF7ijAQtdS1nP
	DxFNI4jDfP4Fo8DHTVG8//QblbCPM6Ye9ZmgCao/JoVwqxYHYFh7ZKn0Ved31SYsEr8vGnApun5
	x937uLaRYQd7XaqigmQ3hAsFHR8fFpGrZB7p07ujoEPeh/jkeOPIjq4SbLrNIKjRGZ2J0qxMSiR
	F3pAiVKl0nXTaKMqf6punJ+jm5T6cQR0LF6LIvw2GqGe/rH5muX+6Kxz+vXgPc0kyu0jewOwSmK
	jPjdvyEDjHAT91I9Vohg931bT37UqzUzvsOwSQ2FkkzsHE7bxBByHQPjoZYQI1mpgA5uQzBEJuE
	51jb8oE0y+7pdhN4rwogw1SfZvPDHyj4ql/EnbWq2b6VyQiEJ0fQqpkZmQbCp94iIrcugUMrUmN
	bKZ4S2Q5J7xiuZ1IOvNe6PL7BhQlWMgzWUwhjGTLs3RNzRYioZjThSt4RrhzyAYsKmTtB3fvcB1
	jk2S3ykEmEc9prHIn4oM9rhc1S9Ob2/ys0QatdoSqA==
X-Received: by 2002:a05:6000:4a01:b0:48e:7833:2e7b with SMTP id ffacd0b85a97d-4a36c30c79bmr1458441f8f.1.1794864426917;
        Mon, 16 Nov 2026 13:27:06 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:05 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:21 +0000
Subject: [PATCH v2 05/16] dt-bindings: usb: qcom,snps-dwc3: Add Halliday
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-halliday-dts-v2-5-2c92438c6c46@gmail.com>
References: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
In-Reply-To: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=1289;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=cCyX7eu7E67i1+mb+zFb+/V3MZ2Z8Bvs+BbDvfy8HQI=;
 b=jodb8KTCYJuS0IWgZE7KB4t4x5w4vx+XqSva6vd9XaFcHbRLapvwh0kujvjIVh3aEijgselYV
 FDfNsOtrAj3APDDTnmVV1I35ZxWejVLlN13Q6QOSjvxv3VTGu5EUwMp
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the DWC3 USB controller on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index b77c02c64d45..7a8b72d2929d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,eliza-dwc3
           - qcom,glymur-dwc3
           - qcom,glymur-dwc3-mp
+          - qcom,halliday-dwc3
           - qcom,hawi-dwc3
           - qcom,ipq4019-dwc3
           - qcom,ipq5018-dwc3
@@ -209,6 +210,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq5210-dwc3
               - qcom,ipq5424-dwc3
@@ -570,6 +572,7 @@ allOf:
           contains:
             enum:
               - qcom,eliza-dwc3
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3

-- 
2.55.0

