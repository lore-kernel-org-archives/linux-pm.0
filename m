Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978196;
	b=0dstg34U6mTDu/4WZqegupGmJbryfF3Ldv476JHMDcswEumYJSDB/6U9ObJoaHCKUfqW
	 GaZp3mjJNkRdYETnuomFXFeseRyzY2ttny7ogwwDv9BLwC9c9r0obWwMk7/u4GyudW6qT
	 LGI1FkRr1Yo91sXEEha8yBnSvcEMWczPpCHN6WEAH5jhT1yaJPyyDfEzHp9WzGxqS/ON9
	 lx7wIJxIbd3CYfIQun1ilN6U0/DbaMtJurlC5H8pO2Y3acdJ9YmQNJ8PRH7fAAWlLXEFU
	 nd/oyPr3UO+tIf85CZApLNpUrDDnpQYK+4P6XCQpkL4eKupqmNMQsJPgxNAjei8u2gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=AZbalvr0RZKV2CHqgY8md5UEm/BcGTfETxormN4SzfQ=;
	b=Zlto4UsGWUoH9+q/zGaLQLfoaIj7CgRgA9eqpGHbicl8M8/HCgAhtzd5FNQQ8shYb/oF
	 WLKUuswO+90e+hxJ4Jf7oCGeyTeYmnxvn4HRf7KkCRgVERKWpJp6MU23V3Hb/Xgp8izbT
	 kmNQhIGcTDuhdCPF+5I3jnp810oKLWrabGtWsFDiGp5FmQtgr5bBsJxdoegBaFHI3wxE+
	 PIvDK0ehwPR68UB9z/J8eNDo4GV5nkJZnDGPXSw4cRKg6HjlBGCxbTOM8NHLuNVSP8teB
	 12GEWW9fshYAmvjchyQMa5AWpfktlKiO8tOsb9Q7VpmZElt5IpN2+usNfIka01mM7Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VSAql/bl";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224D606A332
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2224D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VSAql/bl
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-370a1bc464cso128001eec.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793978195; x=1794582995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZbalvr0RZKV2CHqgY8md5UEm/BcGTfETxormN4SzfQ=;
        b=VSAql/blJeBuuXf8oV/4c1oADv/6SuCiNGnvgI+jYuOKHyIGlQ15D7/sdKN9NYl7wx
         iWb3gjWga3J1E8G9FKpUYgRb6DlbuIVWTvdwzC26viaTrL5X/e1VaVMZq2hRKGYiTyKc
         AzJA2l7qjJn2Mc1QtlCTO4p1IKMjHrPtdGWx7FFh5JzaZLCJx1/6THJc8ZFaWaZqzM1S
         nKBjJKH7mCdHSKmW5xbNxlbH+Z5gd+UlcG3taSFzBLnJflkRpuoWZLJ/8kI2Le266Kh7
         ujLXoS/MNkIY/yhfstFBjlc1JV+W2xRm71elGo+uD2WSg/eUw/2g+fiok9jCC7qj1L8X
         l76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978195; x=1794582995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZbalvr0RZKV2CHqgY8md5UEm/BcGTfETxormN4SzfQ=;
        b=oQM4UqyF4Px3hBwu70ByAGj+HA5+VESj4spAVR0zNd2duFyf90HE9PQyoQ6fylsfdo
         qfYCBbIC9jSnH9FhaQewMeokgdrgZbeRldoOHK20zsSU+gf5/iR0FRXHIlsZvdw2L0T1
         jCQ5cSHOgL4IqExJjd+DpiIxvVsWIiAAfclh3w43mhuNryyoMQPRncTaaOzXSKW6XxSg
         8Ja94nMGsPz/8WRUSzrZC6WC7UcqGY00XaGT3ePXUlSARPunWjgb7nURETlRmwlwB9Ts
         5w07N2JP44rNG3/f/5y/rj5U9SyMaV1tlr3ZbDxceVAkyMFslf337iqB6ovukXcIEevl
         Atwg==
X-Forwarded-Encrypted: i=1; AL+hErH7+UBHxRentUOhduZz1x5+68HKKw5X1AmOu288vFpvekR5VZXzkIHjpQNZp6fPLIJtcSms1PpiDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+jG+diJxCLPxzMRvoOXybQB7NAyAtxDh4FpznAws+SkCbiqHYu
	typtjUWzetuwDPI089DKQS33fniapS+gOtOtawkDEnIcm0FiwJOrxqso
X-Gm-Gg: AYBFou28c/K2ZHmS2kRIbNJbsCOu+cLuIFeet/COtbbf6+3I+iwevV6GKjd676uKInp
	hjefg+S4irel1AQHqMWDtWorNrwlyd2LymrzrYBLl2Bw/vMvCgXa5zARQhLgsFQdW1f9UHnX9+u
	qWthE9nsTWal3t7+TtMwMZIPQZXQ818br0Hi76Objv8zm3LdtYbPwqBpvwa4IUDQnvPa2keI8cf
	q/NfXHCOnLwdUm9ID+xsp5LFCb1kgdkrX4xtJgzTV0HR6OtiNKYA3z6MJ9xcPsByE4e04Y0X25l
	KQIO4MSUwi9kYUTp6b6mLimDOkaCRESWPVRci1L3rjYCYgtv85vFGCVGdo3VNvjjzqVFF14H+ez
	xXV1tBdzfJCFk1KmJT8xoTvvre6Ai1CqYWKPz9HYDhJm1HOE+yLMwShhg/Y5Jc0yMzc+sWN+6Az
	xbldrM6Sgxoh8Kv6H/JTxhzNRqu8CZOvNxyE9uWqlpTuJdh3KFzhAZs2A8gWTjgODR0ujf1blTh
	HmMuVs0am90/DH65rR0dQZtHClwR1dvxNZrj+zhFZzuNDot+Oiu3eQeBh4bt0HZzip2Q/RC7mgP
	uXjZ2MsJBt7s1PddwRGBEu5nTNN7CXSWPO5jSubsH7lIIqzKYW4cZHP+tW6mtMW5vsUflV3QfD1
	dypLlc1A=
X-Received: by 2002:a05:7300:ea8d:b0:361:167c:2364 with SMTP id 5a478bee46e88-36f76814de3mr3562020eec.8.1793978195003;
        Fri, 06 Nov 2026 07:16:35 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.221.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9ed126csm7581500eec.18.2026.11.06.07.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:16:34 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Fri, 06 Nov 2026 15:15:39 +0000
Subject: [PATCH v14 4/8] dt-bindings: thermal: lmh: Document SM7250 LMh
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
Message-Id: <20261106-sm7250-v14-4-7d167e993f9c@gmail.com>
References: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
In-Reply-To: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Sreeshankar K <sreeshankar0910@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793978147; l=791;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=VBYR2sSJ7gPSfZ1zDIlxykyMXb9GohC2X09rRKZ3wIw=;
 b=tA+YO4IEziw/rxKUuLOEgg9oSmL+N5rlYkZXd62GE5c3l7KwaJP7/Ge3KIv/yGEwS6/bV7IKD
 UTf6B27Bw92BqD5ffzrs425wCTGWhznBDR5PUtFGQnRPV1dh25cvGBx
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the LMh compatible for Qualcomm SM7250 SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index ce72347e2..e1d5cb871 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -21,6 +21,7 @@ properties:
       - enum:
           - qcom,sc8180x-lmh
           - qcom,sdm845-lmh
+          - qcom,sm7250-lmh
           - qcom,sm8150-lmh
       - items:
           - const: qcom,sdm670-lmh

-- 
2.43.0

