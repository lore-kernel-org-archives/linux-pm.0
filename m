Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FFB41D4D6
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576777; cv=none; b=UDTY1ZGwR1gpcQp7SOYW36ZO6KnIE8SbevhlnUl/lF935TTUpM1flbR7OFQa8eSA36f5OB8/v+mdzr4WmlMGC9cp4SC2xGs7QCnRw2vuTK1uihwXDWgB+SpSM5PQhbnE2F0YVrprFFDjQ1HPVe053C8ILRRBOcDnE4mM1doaI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576777; c=relaxed/simple;
	bh=jKh+XPUoJmr7fIpNbx8/2EaPd/67MsZW4ebNDZ/8MPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkGPiT0foso8mnzd4lzQV696GcuDUH/tAKhb5EdjcEpbpyGz22U5fdDe8bixg7eRBp1jh/h0pG8nklT1MuHmG2+d1qSa65D288ArmoqdAh6LdFnv8z2XxTapvW4scwbDh4IrCilRrAWrBIGYXIZEX/nW6T5kvVAmy6GhrSN0D/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZUZvbRo; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZUZvbRo"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc147d86bebso2912828a12.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576775; x=1788181575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQnqfdvjWzHpIFqKpmfnZN4AvVDc8IQ+C2JI25EK8GQ=;
        b=EZUZvbRou2Xr7NLyyOa9VczdO3YZSlEpiVXkPK6fzNAWVUvvpEoUZvFTezWV5v7ktJ
         jFoHb/9DORa8sTyg+yTNAoaXxgugfUDmdNCji3q8lMjHUjhR5C3Ky84112zZ9Sd0BSG2
         iaAwT6u6mXQVshuR2/o6QIpM8gRpoQThnOmtFQqnj5+0ztiSW36YggHoY1IFmsIZ2f3a
         RbnIC8qaw0p/pIi9loXDuIMKkLdVKIHqg06jXLEYg8+NsDI9TWDMxyPVTjGNJeLhL/si
         jxnyrtQkk+whJTMP3lnQ8/E0cB+fECCNSgKSA3y6hSXx8yFq+xEA01hu/Q6gGWYowr3v
         AiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576775; x=1788181575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQnqfdvjWzHpIFqKpmfnZN4AvVDc8IQ+C2JI25EK8GQ=;
        b=cn5tL8pwUu7QSCvndoA5h9ptGo2DJVrbQhQOZC9VC+A1aLVlRgpnQrJlYm4587xBwh
         ZuIgR7tIaUEvMmtXlqI3nFrmwtUyDVOGuTJlMdJ3ZtX25yLU/JdjSBXUsFDcQGVYnFe6
         Y/3xmbro8fG7+keBEyAlkmpiYIebi72I+XV6bbN3Ju4no3JmhBsihxUAi7uf/LnTmatI
         jzSNmTvJjsD0NfCE1iGwd1GT/KE10RrFBzqjozUmohxZ8rSn9gxVYq92rgWboZL+aBwS
         XJPpPpLpP8i8afZveUf3COPDZraA4YU1xJAqjyl0waysKH321pvElQjw2GxuYeMjH+Eg
         bliw==
X-Forwarded-Encrypted: i=1; AHgh+Rq89OFiuDU1xvtOYm2wd2T0DM7rppstW1/A2kxg/zdpKjVWc25mB9+InbTIDazx4mkQtzFDDo1Vuw==@vger.kernel.org
X-Gm-Message-State: AFuF++kbwHP/bOILUmRyJ1xuZHM+czEsUexNEHjSz+nqAdzU36I1AEA3
	ZJPTe4Vv4NE18VBypyg6ZO23wE6X2aY8xMkqw55OWhGJtfNPTOZ/wIFw
X-Gm-Gg: AR+sD12wGp5e7u34GM0b7+clFdztAOY91XfbHZQ156lUkILc1i6kBthiCemqV0XYWGA
	U4d2bNtXejQzq+ILRNXStrBeeZu9UVQeOI/oxnRFyyiNCSCqjbERgqqA+pc7QUrFO5l8sQx4ELJ
	dMkv53qwsgciOSUvRnM2UgLE4IHN4a3B2AN13lEIlxH3E6rBhugDVtUL9EsMdyhBIay+94qSQ3y
	PTwBV+A1YqQHFaGqdGTMiBpmVkF5qCfF1V8Nn3YEhTRvewwofOFxWTgYGr0TSfFblhh9CQl8L+p
	YS0yAp5Z3sLFY5JuGvZj6QjtCLggOnZaCtI3ysLxi3OpotH03PxxmE2VRMCHN1Q4KkVjFzzrg2H
	dhHFbTJiVeR2jgTyFJLKGAJc51xkLMoVgaAwSjay/pAVaYg3U5waDhSCwT+i/vKYnKNaGahBdz7
	3ZDjrKfTe90ZuL67Ft2gQzMavh4MQq/ER2XJHh7kVo4h/Ht6+1AJnJexRpe3u2Uef6sqVl4ATsm
	PnMUsHZh1QH
X-Received: by 2002:a17:90b:524a:b0:380:86d8:8162 with SMTP id 98e67ed59e1d1-395a07022b9mr41041319a91.18.1787576774842;
        Mon, 24 Aug 2026 06:06:14 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm26409711eec.27.2026.08.24.06.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:06:14 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v5 07/13] dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
Date: Mon, 24 Aug 2026 13:04:31 +0000
Message-ID: <20260824130437.2771-8-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824130437.2771-1-sreeshankar0910@gmail.com>
References: <20260824130437.2771-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the RPMh power domain for SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 0a45e1f55..e08441915 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -63,6 +63,7 @@ properties:
           - qcom,sm6350-rpmhpd
           - qcom,sm6375-rpmpd
           - qcom,sm7150-rpmhpd
+          - qcom,sm7250-rpmhpd
           - qcom,sm8150-rpmhpd
           - qcom,sm8250-rpmhpd
           - qcom,sm8350-rpmhpd
-- 
2.43.0

