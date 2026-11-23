Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471942;
	b=CWNQJGiN8pxHGPU6sIHsAgqOERJaR46OCbctuUKnrn7Je6oIJPYTWleP3jdMfoRwnj6D
	 NLf/b8/5+LqI3RidTcfQJE+l7X6eSK82OS5ciij6+jtqC3U4LvEqBEwX4VckVltqEeXD5
	 wPoXunDeNBgnaml5C4ge6ZbwQGcdfuRqrSrg8LGcMPm/jHUfZqiqdvdMdr15jtehnpbVG
	 eDnwtlTEukN1pusrF4K1Ag7cU6tT08GvVyD6SH4VVIjVzTea+TKiOm4GtTnxCJSkYzwNY
	 AbGTpUWxKu66f7KrdlLHD2Uodc3F8188WCb4nKOWWvAvWpLRYQ6ABptt59qSKsjNUpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471942;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=y7nPJckBOCgPmlLsWlMebz2Kxq1BAx7WuD6/NnnuYe8=;
	b=Yc2hkn779KPATfIfjH/nM69L9J8Qn1egVsKOcaNh0o02A+xcf+a8ROA1PN8o2KoUG3EE
	 vAuTVXRpuh1X5YfD8b113ob7pvMxMu49N0iUiTlSBdXdNdCwQ4iAbfKTTDlIWlEF+Lr0+
	 dLim2z7ZYZz4lvEcsMkiFLm3XCY2j1ZJUHJSqXFzBdIiwTpz0sTaDlQI+fvVzoa/SvY57
	 2wDwplq8dukpYFvDamr6ocEI++gp20d8EhrA+bXyvMdb5NrduzZhZzkbXfGywIozznEC1
	 T53EJXOq9Uknxo+2sN9KM6vW8vQZkQtuBBHbHPDw2nX39QTQjkCrs2/2JRVZ1iDluPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KQVOE4H5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DKA5ccY+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63D606A682
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D63D606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KQVOE4H5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DKA5ccY+
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJuZAt2350137
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y7nPJckBOCgPmlLsWlMebz2Kxq1BAx7WuD6/NnnuYe8=; b=KQVOE4H5pjUmBJz0
	tbxA/yYP74J/Wc56vuYJnF6f9q4g/DcnI0eLuTBz8y1pXQVmPWD/liEF7xWpQ7sj
	gA+8a77ht0NByX2wE1+ibJz/VbHhiVZXVcYp9yk1VQ/efDOQAf2vTJi4/mlMI97s
	XIPB69LZEAmzXJPcmQ/mZ4c0kBrhExSIGvdoIJ83WGfEW4IEdPDVxRV4qWVlbHa+
	u/M7EhUB/a56V8goI0k94mOO9Su1jEAFZOri6k4XXi5FHYD8RzSc3gAbih7v2KAX
	1OlViCiIrjeu39QfphEXyxj9RgItztdV/bjWrhKA7/V1E9bCYlfaeY1WQp1XkNUt
	a1hbhg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g9a3n1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 22:12:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so958798085a.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795471940; x=1796076740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7nPJckBOCgPmlLsWlMebz2Kxq1BAx7WuD6/NnnuYe8=;
        b=DKA5ccY+9jCZ65fqhnksoVOdZrGS1HspZmuV9rZjTRLfwKmtVv8rGztdt3njsIWqVm
         5Guf8b/qVN6R+yPrg3NMbm7mFIRMEZoXYWH6WXYwPk7jj5fXI+Hz7PC9gt2t0ZcqBIOu
         RvtreUO5LQD7QpUcjb3ItUI/YkBnP/kgZS/Ls5LsP3lqeX/o+wC4Xhr3JFdwKnD43l5S
         eIz0vu6rLb4AGIZIrNlUHxjuCKlSZFtoRrK0SQjUxDBiCTJ4iYAXbPXKE8vWUWFv+LBv
         yiBHVEXVFBy1FiShonSWFwpqLXaUzZkiA13d4O/uWIPWjIyDxhDhLxrejvL/Y2VzMycw
         MgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471940; x=1796076740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y7nPJckBOCgPmlLsWlMebz2Kxq1BAx7WuD6/NnnuYe8=;
        b=AdaqUwm+KAyO2zXv+smzp3HE6Tazy+mUPNVBLqh7b9NgV/4pLqIDvMzya5H3IFjspm
         h1CKxM/rWocHFLsS8kR12Lg7FTc2MWNaz+/raD51oU7MyDPzh+k0uH8BRMAAuswwv/qi
         m7blRz2XgK/fhPB/qLTqxX+DyGWP9IzgUmkhRkrKHCzGDBfiUpJzPRzmevL1So0efiub
         fMKbL8CwyDt6Y/VZHtdM9f7e07T+fe4KI6bTBVmTcX1TyByjhlXyGxk4W8lQ8vP6LLEC
         v/XR0d/CljykWp6Hic7iibgi3eyMKf/YsRph58oA0SBgR7fM7+l71lpPxjfhtDWLXqMQ
         f5fw==
X-Forwarded-Encrypted: i=1; AL+hErGqmT+gArfBoq32bqrLZV0+wSKmXSvSm4r/xvKZ2oRBhA1OECnkV54Zay5hJ+VI2Vfb6IBAHDlb8Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z93mcFsLnoYM/TLnabVuXZoBh5p7gpGQr/xtkGhFA7dyaC9wHT9
	1BR/y+EIKctn06kJuh1lWNLKGlGDjAnmBtpB52kOUD09h16OuyagYifN/CrxfRPvl50JT/SzyJX
	YVwdsu9A2RiwhHr+PCfTOzLRsJN0idR5g+vJFZQQjqCH2V91BYj/DlBeSYUuphQ==
X-Gm-Gg: AZFdTZcteyV6LvqeiAhkSIDMCmVj4jW7fsY0bj9zt4A/65nH9ubZobFzVJd7BFnmaKW
	Vj0SX8m4knSnErw89muy0t7+FEtE8ja/Qto8Ghfx5noA02inH+SkbPvHaxkrSSocdYwkg9u44f2
	NQWhsNAmNkX5sLMbVcHRqtV3INHkExyMdE0JNAF3TQoveaV3Hb3Lw2sazyKfFn7E9Wc5BbU9bmt
	3enPduCqnKq5nPxySmIsPi3rbazc2h8NG04fmdEOoVvS+VZQJqh+VthbGYKp0/mtJ4c4WLTQtUk
	9jhyZ1UbfW03MiA8oRtoe1psoU05O2N2HwRSqF8g2EJQkv1dA7uyeglSozV9heloYL9cI4G4JUv
	/VtplXhKSyDUbJ0T1ghNevzQjrJKaXkjQBQfaNRUmKq9jyD9kvBK4tP+B6qUTXJZgmXQ=
X-Received: by 2002:a05:620a:45a2:b0:946:2a0:a11b with SMTP id af79cd13be357-949ba9cddeamr2216774285a.35.1795471939576;
        Mon, 23 Nov 2026 14:12:19 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:946:2a0:a11b with SMTP id af79cd13be357-949ba9cddeamr2216770385a.35.1795471939081;
        Mon, 23 Nov 2026 14:12:19 -0800 (PST)
Received: from localhost ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm304524935e9.0.2026.11.23.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:12:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 23:12:10 +0100
Subject: [PATCH v2 1/2] soc: qcom: socinfo: Copy new SoC IDs from bindings
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
Message-Id: <20261123-qcom-socinfo-id-dt-bindings-v2-1-4504c1ce869a@oss.qualcomm.com>
References: <20261123-qcom-socinfo-id-dt-bindings-v2-0-4504c1ce869a@oss.qualcomm.com>
In-Reply-To: <20261123-qcom-socinfo-id-dt-bindings-v2-0-4504c1ce869a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5077;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=TXzO7lczvT0ho7ofH7ywyEnPwL+VNQhDd+3sEnhiFCw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrBLo88biPftZQwIXFDoOc0V3d2CtiANRH2uMLB
 RdpRD4HzUeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawS6PAAKCRDBN2bmhouD
 12vVD/9tOT8oLQAabcfTYp0fgrwqezd0GVrUgm8RFkBCfJczLqS+CUux2HvWhxqx5qcE3MHW6PU
 6/qjY62ktXtrBMyqLVLptk6/4ZZzd8NPKJdZ3sbu5+tW/fuUwWajt5nJxXHO++JpN3VHH0EAwCc
 R0giZ2mFBO9+cIwCbV8GVKBkrC0+c307xPQodm+tLBlR40gxcJZED0Or/dma6+xt/Npan6PU90S
 26pyGiwsJ66woWFc8GhIYD0MetvHhsqTwfIbwJzOenJdQA9h4mB5xTPK5K0ntTQzwrGZ3/Jrzvj
 foAWxaIjtjY7cYjalrP4xQtt2fqBmNKfkECJ9qzYR8qkXEku/bYcSKBgmuH+SQtpEvMuDuWYgno
 wHP0IRoy+aKVgEXelYlXPyjaJrDaNbQqVpS7ozbRfqaHhSggieEyczLseQdw7PjOszDpZep2tbP
 bL59ze8zFiSuiIzfM4mUpyCIOSdq/FgddN6Ve1WIEUFwA2+c4mrRQafF8uEkznHvgd43xjDWX6U
 msrRSEoT8nADDelR6/wKeEZBW4NgRtxHnLrCwYPAZvpjkjFlI/NM3qDsoXcMwJnLCuW7TTSax0Z
 P/FG30v6X0x/UGLjY7bGWZxwMEyPXlPBr423ffnWZg6nQgSHS3Vuqcm5OIjIK0FqMY+o/hAysFE
 Kq4OncxueczaEMw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfX86AoJgtZ5mRx
 vsQcURpfkHGTQvwgb+26QR9vgiqjxGLfiKLkNhpU7E0Ash+dxpYIz6dJ1qxPCPF51ptPID/A1eJ
 xffV5ZEEQ+sSLJBTwTJoXSdLUZ08qME=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4OCBTYWx0ZWRfX1Tm+SwOwa0H2
 IGhrT1qutmuycxldb94HhnGRfuNTvcmzjUMqTzF4IxEgZJwjEMcGsmjejcdlUBOhRH0/DMb+ESo
 tI6bZb0CEX+hu3laxyuDOZAcpJP6AdXRIB+dZmL5ldAlxXPYqtp9A+QXk9wEGchDjAwwFx3rW9A
 rfSg8qSWbZ79jMz/7o6WmKwuWAeK3sVNSyb6I/ty4yj993FVhPEKcM4KcrNp8qC8REiyU+5FpFz
 1IdILjAYxjgOTePrpHsO2VaR1Heds8KY6GoRLYtO7GR+C0EhFvNdFrdyT8yqPsDo/+D+vRq2ijX
 nQ1AU/df8MgbdziYdo7JwdxgLbe8KIaImOQpHwACSgF+tyWBY+jjKc0W2eEYYyfVqpxjANylLbO
 EfmkyO/jBMH/dizMq5D5LtE2OpSKODi2VTsZLiRjBTEqvU0YcmQlYNduq95wFhu+PsIcxYzW1f7
 MO+CJWiNy8+I8loUUSw==
X-Proofpoint-ORIG-GUID: P_p0lRmc9gdiyJByb6ouTJFvR7e3POMe
X-Authority-Analysis: v=2.4 cv=cYJHPXDM c=1 sm=1 tr=0 ts=6b04ba44 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GMOlWMlolr8ObqTOX9EA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: P_p0lRmc9gdiyJByb6ouTJFvR7e3POMe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230088

The IDs of newer Qualcomm SoCs, as reported by hardware or firmware, are
currently used only in the socinfo.c driver.  There should not be and
there is no in-tree DTS user of these, so none of these constants are
really proper Devicetree ABI.  IDs of older SoCs were being used in DTS,
thus that part matches the concept behind DT bindings.

Copy arbitrarily chosen newer SoC IDs from the DT bindings to the
regular header of socinfo driver and use it when needed, so later they
could be removed from the bindings.  Note, that DT bindings do not allow
qcom,msm-id ABI for anything newer than SM8250 or SM7225.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/clk/qcom/apss-ipq6018.c      |  2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c |  1 +
 include/linux/soc/qcom/socinfo.h     | 92 ++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index 32347e6d8775..b4babeece2e0 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -11,9 +11,9 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
 
 #include <dt-bindings/clock/qcom,apss-ipq.h>
-#include <dt-bindings/arm/qcom,ids.h>
 
 #include "common.h"
 #include "clk-regmap.h"
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 2b458ed1f6cf..3f933a434526 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -29,6 +29,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
 
 #include <dt-bindings/arm/qcom,ids.h>
 
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index ba823a0013c5..317dcc26c504 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -112,4 +112,96 @@ enum qcom_socinfo_feature_code {
 #define SOCINFO_PCn(n)			((n) + 1)
 #define SOCINFO_PC_RESERVE		(BIT(31) - 1)
 
+/* SoC IDs */
+#define QCOM_ID_SM8450			457
+#define QCOM_ID_SA8295P			460
+#define QCOM_ID_SA8540P			461
+#define QCOM_ID_QCM4290			469
+#define QCOM_ID_QCS4290			470
+#define QCOM_ID_SM7325			475
+#define QCOM_ID_SM8450_2		480
+#define QCOM_ID_SM8450_3		482
+#define QCOM_ID_SC7280			487
+#define QCOM_ID_SC7180P			495
+#define QCOM_ID_QCM6490			497
+#define QCOM_ID_QCS6490			498
+#define QCOM_ID_SM7325P			499
+#define QCOM_ID_IPQ5000			503
+#define QCOM_ID_IPQ0509			504
+#define QCOM_ID_IPQ0518			505
+#define QCOM_ID_SM7450			506
+#define QCOM_ID_SM6375			507
+#define QCOM_ID_IPQ9514			510
+#define QCOM_ID_IPQ9550			511
+#define QCOM_ID_IPQ9554			512
+#define QCOM_ID_IPQ9570			513
+#define QCOM_ID_IPQ9574			514
+#define QCOM_ID_SM8550			519
+#define QCOM_ID_IPQ5016			520
+#define QCOM_ID_IPQ9510			521
+#define QCOM_ID_QRB4210			523
+#define QCOM_ID_QRB2210			524
+#define QCOM_ID_SAR2130P		525
+#define QCOM_ID_SM8475			530
+#define QCOM_ID_SM8475P			531
+#define QCOM_ID_SA8255P			532
+#define QCOM_ID_SA8650P			533
+#define QCOM_ID_SA8775P			534
+#define QCOM_ID_QRU1000			539
+#define QCOM_ID_SM8475_2		540
+#define QCOM_ID_QDU1000			545
+#define QCOM_ID_SM7450P			547
+#define QCOM_ID_X1E80100		555
+#define QCOM_ID_SM8650			557
+#define QCOM_ID_SM4450			568
+#define QCOM_ID_SAR1130P		579
+#define QCOM_ID_QDU1010			587
+#define QCOM_ID_QRU1032			588
+#define QCOM_ID_QRU1052			589
+#define QCOM_ID_QRU1062			590
+#define QCOM_ID_IPQ5332			592
+#define QCOM_ID_IPQ5322			593
+#define QCOM_ID_IPQ5312			594
+#define QCOM_ID_IPQ5302			595
+#define QCOM_ID_QCS8550			603
+#define QCOM_ID_QCM8550			604
+#define QCOM_ID_SM8750			618
+#define QCOM_ID_IPQ5300			624
+#define QCOM_ID_SM7635			636
+#define QCOM_ID_SM6650			640
+#define QCOM_ID_SM6650P			641
+#define QCOM_ID_IPQ5321			650
+#define QCOM_ID_IPQ5424			651
+#define QCOM_ID_QCM6690			657
+#define QCOM_ID_QCS6690			658
+#define QCOM_ID_SM7750			659
+#define QCOM_ID_SM8850			660
+#define QCOM_ID_QCS9100			667
+#define QCOM_ID_IPQ5404			671
+#define QCOM_ID_QCS8300			674
+#define QCOM_ID_QCS8275			675
+#define QCOM_ID_QCS9075			676
+#define QCOM_ID_QCS615			680
+#define QCOM_ID_SA8797P			690
+#define QCOM_ID_SM8975			707
+#define QCOM_ID_CQ7790M			731
+#define QCOM_ID_CQ7790S			732
+#define QCOM_ID_SM8950			735
+#define QCOM_ID_CQ2390M			756
+#define QCOM_ID_CQ2390S			758
+#define QCOM_ID_IQ2390S			759
+#define QCOM_ID_IPQ5200			765
+#define QCOM_ID_IPQ5210			766
+#define QCOM_ID_QCF2200			767
+#define QCOM_ID_QCF3200			768
+#define QCOM_ID_QCF3210			769
+#define QCOM_ID_IPQ9620			770
+#define QCOM_ID_IPQ9650			771
+#define QCOM_ID_IPQ9610			778
+#define QCOM_ID_IPQ9630			779
+#define QCOM_ID_IPQ9640			780
+#define QCOM_ID_IPQ9670			781
+#define QCOM_ID_QCF3211			801
+#define QCOM_ID_IPQ5211			802
+
 #endif

-- 
2.53.0

