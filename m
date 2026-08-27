Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EADA48D868
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848820; cv=none; b=nJBKL3q4mw8IvBt2yH8IYfnZZ8bhdgWn5lWCMvSnbl0wioVZABrTVzHUlK4Lny6dZmXHPsEjJT3tabp6/U75kpxo+6oSmA9Tfr2XMU64z8dhbvbRUpaJRYpAGOBZqyCLUUV7+hs4mSajna7tjgZZbs/MIa93Dw4labVK8loEPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848820; c=relaxed/simple;
	bh=9JHmO47xFcHiKwRcWRppqe+FIDEC/EmRY/1PhD8wx0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NN1jn5Gh5jopPonCJF5UtBJebdGsPQ5jeSndiSkyHy1vNWLtVo3Ji0i3AaLXfsqz5oealwdunreoMCM2OFmKqezgtuHy5C9JpEVY8WdbFmhKRldg61wH4bY5EjqRz8v1mPBW6jApEf8qTiAg90KbzWVweenqrzFyJNAkTXOpFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N8vvVj2v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R1RnM+Ai; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N8vvVj2v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R1RnM+Ai"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RG4CJ8342126
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wOoRRo1BzWfxcKIRahahL37V6D+SA2lxSIowy+5sCk0=; b=N8vvVj2vTDZzGwDP
	A67C1JtkqcTDE53xyqIRB/SYAAMWMy+LHtcy8zSAN8PY7N29uUmX0BftGy8MdN7K
	EGsCSXD3ROSR9NFgNiMmJST28GA3MV6h01b6mlJQw69l6zmbhNWZz86bHrgrTARb
	Za2Twxone3gG/EmKGplJ9HTEkfLX45P99ffP93JTuHFnRYTGSNojLt4T7c/l8YQS
	2O7SWRYpBFVuVK41L0YtPBDlGLIfXXebfV2bu3KUHCdu5e8Tt9Guwc4to6sq9ULF
	WvWlXfLLed1KZ3r7anRbhygqYvy1GXjHtI0O1Dfr/IpkdFhP8EaQ3SH0THqqz+0x
	AocL7A==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee04yr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:18 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7f36427abfdso102178a34.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787848817; x=1788453617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOoRRo1BzWfxcKIRahahL37V6D+SA2lxSIowy+5sCk0=;
        b=R1RnM+AiFb1vvAYrTfvpkLn1oDos1NnS03rpGFkK8D6r+aZ9uMxVgki4YbHA5D3osi
         OawSqXBptHGVAom1hzf1EHIYW9C1jQpezWHU15BhXdwVN99g86fmnRX517qcF2lOJ91q
         9pbF5S5sGAu4UhwYASO73myal+/mPanDXcW68HBdTGZ0BSLVYeJ35XykT0UgxQGZhaUp
         BRvdHDnvV+eAJGBtQ0eggZHKie1U9yCuxf3kNyRSbZ4d1xufQ3leuKiaOeHhG8Azb5mX
         Kq8SDRWt66cJAyF3ArRb8F3gbxCpqF2j3yc3WSzuL5e2RweHzOUvSOhHsT8Ye8w/jwwa
         9zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848817; x=1788453617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOoRRo1BzWfxcKIRahahL37V6D+SA2lxSIowy+5sCk0=;
        b=qhbXhOFzkn1l7n/0tZlAx+Hy4xhtuWtS7dVKyJ1XtXBeRPNWmFWiwI+teChC6IzGt7
         jmpTG7t+3NnwY2YFRXufBtKx71YATniQfTHGYdtUFZliVQN7e5eu1W9LbXl3ladtLkqH
         vZuzTRCR9+JAF0Y+NYtqf7/GR3wXbVpnrtld8NiaS4M9lFdsgZkwR8q4LeQH6G7YGamK
         cjs/ESqgWdp9aAPg4WeK4mZeE9WhHEUr1lu2qZ4va5xmzupvnfNGjYo7uzXaSau8kSom
         jon/9Vl6hD+xv8FUIXS51zJIxWnUt7j0Cdd0JFDawDK2AArIn3jqWNn/PqxHBhggtgSG
         vVJA==
X-Forwarded-Encrypted: i=1; AHgh+Rpkap/kOsdsprr7GTOHHm4QtskEkWF3c8YgyHQxZaz6eqN9SNJMJ6od9qxhHl66VSko9EwSmqAolw==@vger.kernel.org
X-Gm-Message-State: AFuF++nqfJFqAeSZm3ch/I2zEWPGqR9XEDLVU/MkEQ7cev3L5aMQndVJ
	jT9qZdNUR44xN9lnELychY76PHUMMt4SmulVhWmDA1Var3SIBX2ek5UiJfL2c+HKiJmMCKXxzS0
	C6OfSL+PoZIIH94O4TRrMfFuJb1NUs/5+jWabWRrsVSDasSFjTvCzxEDT4oHKRg==
X-Gm-Gg: AR+sD11LYLhjYtBFQaelVLccc9NaOZVnjxia2HuI3eZe/fjI7tcjrP4nDI3B2XLz4OJ
	u7ZNLK+HYbazsA8fQ9hjCO1jK0w+IAUug2ZMM5solNTpeLApvql7XG/PDjk6YKIkerjQzzHBwib
	KSd5a0YVKv4CxJuXm8YHfmFyPHXfthP8T5P6ixeD1b7Ht826xyW6p9upNdaq502OWHqvkR2EAar
	mBSOm2ya/gjIzr8KTANoSBKZ+mUI7VklfCE45sJ7mixpvlELAsL1NUKMezZaI0luybczvp1Ajsc
	wM+9ddCDQYlkADiaJxwEkDVCieu7+/9p4jYOZ1FdsvafiKWkheqg1PCcZ3pueEtTpLreJ8sM7zl
	pEkC2kFFht0pTa27ScByykOEvjgmF27TVWE7tWE65P6i1Kta/8CLNxlR0mHmkYUztbRot27FfNG
	/RX9oTfsgyRjfEgNzu4sCDw8E=
X-Received: by 2002:a05:6820:179:b0:6ae:a950:9fb4 with SMTP id 006d021491bc7-6b1a052926bmr13261517eaf.33.1787848817469;
        Thu, 27 Aug 2026 09:40:17 -0700 (PDT)
X-Received: by 2002:a05:6820:179:b0:6ae:a950:9fb4 with SMTP id 006d021491bc7-6b1a052926bmr13261458eaf.33.1787848816972;
        Thu, 27 Aug 2026 09:40:16 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm4253171eaf.3.2026.08.27.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:40:16 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 22:08:14 +0530
Subject: [PATCH v4 13/15] dt-bindings: firmware: qcom,scm: Document SCM on
 Kuno SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v4-13-dd34f235fc1a@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787848688; l=871;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=9JHmO47xFcHiKwRcWRppqe+FIDEC/EmRY/1PhD8wx0w=;
 b=FzE4Q+PBujlIxnBIqlmOr7wAj0IwjS7m5ptJ/dDcSO/NJAOnDGcge2UvSXP9Ldwdg4J2npUQM
 agBO9OVl2R7Cj2H8FreXT0fPbuMGanegKflD/GG71Sg7ZNDymSJR3cG
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfXwpLF73ikLb6Q
 6jOhB76Hbso+YeHtZjG+79whZ7Mp+OX1mI+T9B/NEwPauuaUlrWKml3+Y/MsmdhFTnT3fNAn9uM
 JPAExrnn5sgIjViAS6gBszeBbSOW+zhYIvkv4qwjQHveS0LLYk8gUoT2ilB0sujA+HW573FJ20n
 8LJNf9gY8mL8RS/5YUWLiNsq9ylbttm3rY5ATrOFJZ7cUKcV3/oJ/7f/A8wAEZvKxVpw5tHVPQT
 1JfyDxA7yDL9N9ac426B/XjXwby5Nzh47NKHC/KvegM74QL4emCL+wQZcMMvsQB/dcHXNDWHWiR
 sIE0g6P9pp22Swn6FXW7aB+vh9UC9WPXr1O7xcLAMPkVOKCBqpjwiQlM6POq2gCY2Wzbjbw9PDp
 4hEBtO+ABFfDtQyHImgwtILfcOcFWdwcXXaRfrl+1fvMsP5v5WsJTYKevDBTe1NMGLN8sOaprln
 0DKiSfPIEHIz+4rKpwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfXxvLofBGWfHlh
 6IAcqsetHQaHhaXWCR3GiCunj+AIRr8qZj8STB7GmyPWbNj84bMDnyazGoM6K7xWlv+DDyPuZWH
 gQdRwxhf3p/mD0B/9Jz2t9X7/y9XzbQ=
X-Proofpoint-ORIG-GUID: cpjKL4Ah9K3i-2GwtGXrG0ElQi1nrdJk
X-Proofpoint-GUID: cpjKL4Ah9K3i-2GwtGXrG0ElQi1nrdJk
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a906872 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=M4Tw70yJP9P6qS8g1QAA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140

Document the SCM firmware interface found on the Qualcomm Kuno SoC.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 037d4ad8f718..ecee5aef65a7 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -37,6 +37,7 @@ properties:
           - qcom,scm-ipq9574
           - qcom,scm-ipq9650
           - qcom,scm-kaanapali
+          - qcom,scm-kuno
           - qcom,scm-maili
           - qcom,scm-mdm9607
           - qcom,scm-milos

-- 
2.43.0

