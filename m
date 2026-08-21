Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39442CAE0
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299990; cv=none; b=jP0CirCXiWthSyPuGscpECT31tG8cM/7msbYB4xAnLcbBtNMExOkig02byyRZ7A1cclf3+Bfgn8Er+Q4jkFn2QfXk04DliXAbMkv5n7UYEKhjdPnQjj9fQp+xmu/XyTiXfg/A09NWYhk7bG7QmMFMKZ1G+9N/dEt7R3K8Hb04lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299990; c=relaxed/simple;
	bh=jKh+XPUoJmr7fIpNbx8/2EaPd/67MsZW4ebNDZ/8MPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQsBb87Q3c2Gq0WGpfm0ou7ATrA6U4l0hxZc0tcdl9AuhPh5pyOY1gsCfvtHyf1P/PCWJ9UlqC/Gc98W/otLkialwtLv+bQFsDMtO4X38Thk9RsmVG3GCh0eMNvV/Wa1ppa2XIuiqEDr8F+dJR5oWhXn2TZ6n9KYVNVoL8vDbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cqh1raHy; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqh1raHy"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so769665a12.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787299988; x=1787904788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQnqfdvjWzHpIFqKpmfnZN4AvVDc8IQ+C2JI25EK8GQ=;
        b=Cqh1raHyb7craUkrjznD0U1qhmV6uN8A0WmbrgecTGldLn7BUeSB1R5WjrQgNKjoGE
         0sI8tbgGxNZJ3YdyriS8frQ7bB86xgOdg9jfbOHkHshVrb4IPKY7FjfPsrF2g7b4vDL+
         4u6nIBhFe68/0qccHY48Ilc9MfnQYnIUvPDKM0w5sJTnzjxtacMk6XPWNR7J0KGXwi02
         Q1T8ZP87jnn7ljKVwdSti5Sn81NCXZGdz7oDuvH6SijiWj7VJRezJ4xpWD+Y2eh2Sb76
         V0fhUQhsj10odn2u0YHVNcodl8Zaezu/ax9AJlUewonKDQBmwsRca9nR16YFilzXa9I0
         qncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787299988; x=1787904788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQnqfdvjWzHpIFqKpmfnZN4AvVDc8IQ+C2JI25EK8GQ=;
        b=pyCHbZomiArZeMIv18XT0rgxyMo68UMyMZYLYEQFDZf6ZiOBYW2TJF/wb/DnArwHau
         3Zd0NGjB58ZOh/ng9E6MjQLZn5P45+zV7V7n7xqE6avceuXLFpA6AeEmpFVpvJ9fVrOK
         o/YW99DyqVl6JE7oF5hrPBNT4t+XkPTOAZaiFVx0tzec5GIguBX+luMYRgcyezp0q7CC
         d/sv2TAkjX+BQhpEruHVKAotOR9HX2RXpzsL4BQ0ujsokRJ0S87sIgiR7pxNb83VnLID
         ntGkQrCVwIONztf2+4xxz1SDELDcvKu5ZDH0R5SrojIeTRwa76XT9JTx0feNzdFtiVg7
         rLYg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5hUZ74fZHpoHdNkxy+vwGF3cSWoKx9Kp0ZalfomfFFdhXBrfqYsgvKuwMUZZPFNElmOyV0zPUSg==@vger.kernel.org
X-Gm-Message-State: AFuF++lC4ErNiUDoNm9TyvrkdHqT7tYn8Th+nZkAzulu3Q3uB1vjOram
	0PvRGYGpvkT/UyVX1rq9aRMk7S6d206RIXMRBV9i9++Tcl7DEhQNtjWi
X-Gm-Gg: AR+sD12N/JjN3FuPpkWSiqz8/ztYh0RPucQ7+W0IrT1/NaUDd3v3O8k1GSHAsJPmBJj
	RdARUDmX3FnTk3p2sfhwWbU1l2O9rRk1xjVHmmhCodQJV6MaMCRlBXyUdTmsBwVZAHmX4Pk5gMF
	x33PB+lNCG9QJF/U7DHDQylBsrWFQO6/k5VYpotA+XXA5OS2vwVkWG+fHUJlo0Qt87tqH83/xzm
	kOsGEqZ2eHWfvXdbRAWeZ3xd4xOlcoz7zivIDH88iJUwmviJvuZcZf5H5pw/EvYlp985WN4eHK3
	lqOq/ZOYX2mCMT7Rq5GQx02uoo3c7OtZzDrwfsxvy5Kuw5K+O9aEG4PKpwJVIdj+ion5LjM7q/c
	J/Nrhy8wFKEwjUgiznDeCMHhUQ+Y+x0p+6HeM2XbADvpl2pMVoqE3KG0w1zBVVcudE89annwo2n
	V1E4FuS8IMJHVHvOGzEL6prnyzRCJfDjF/U0Y10c8CyjPw76TqZ4MamnZ3R3mSlwSOXFHTTPLCx
	3jHLrw5czvJ
X-Received: by 2002:a17:90b:50c3:b0:395:5eec:b932 with SMTP id 98e67ed59e1d1-395c39e6433mr9171716a91.11.1787299987899;
        Fri, 21 Aug 2026 01:13:07 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae48761sm22040786c88.12.2026.08.21.01.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:13:07 -0700 (PDT)
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
	quic_tdas@quicinc.com,
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
Subject: [PATCH v3 07/13] dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
Date: Fri, 21 Aug 2026 08:11:19 +0000
Message-ID: <20260821081125.4522-8-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081125.4522-1-sreeshankar0910@gmail.com>
References: <20260821081125.4522-1-sreeshankar0910@gmail.com>
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

