Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779799;
	b=jRzI42GJHy7lLl57RNO3uX46xQTA1b6Kz3jfK7q9IBIDbO2f0lO9b7K3+jQG5TEvcCgf
	 hNTBSW1kvAp9fvAFRQtL31iKaPw4IFWe2dCXrXwXZGM7SqygXRbIUZq5n73Cf/gg1X5VS
	 n5c5qEy3iSK4nTJkZtRt8L72AE49gwN+cUSoW/qb9yLkvkOmSGbS5scubUZZiQishGTC2
	 JFcRLSL4n/L8TC6GRd6lr04nM1euMqfmlLA9Nrsr5LEu2EYMh4u8upkqb//UCiWrfT6cB
	 0UMA9X4QrOE2i39xYGjoQSJHNnWrtE9Xd2/gBRTiBX4IintvDpMq73RwwQwsNC64Ovw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779799;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tLdJguhF20Qz5s+iyaiSixI+ncsxjnzmIqJrlznTypQ=;
	b=DoT5w90+w/YIlHZ9ZbrdJ1mr8/5q0PWhqZgCjCvXbmT2X4M2ADaS1M7utmExC8msHVb1
	 EwimAk/HBW3VPp7oOAvsek2EKBrueNXKb9YhP9J20SY82iQ1TlI9aR87fJ71PdgzmGy4b
	 ezafNyhn71yYvB1vCIef0OxSpv7x+DvjKmUM3gsJC1mFgbbO+rByF9PWnzEp1OuuWFNus
	 gOcxWJO5XmE77F3rWv8CfNaSWusTFwlhedSa1vBTRdXNaCZJ+Qvnr0yESh07mo7lkCbEu
	 eDJ9NswmJge/U9iTWbfr0yPjqRTzw/mqOcnD1ltm0CpPSyy2z64TNcKFIbhuom4TU7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WsjHB2uk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ifdRuwxF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1A606A31E
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D1A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WsjHB2uk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ifdRuwxF
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApKCJ273479
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tLdJguhF20Qz5s+iyaiSixI+ncsxjnzmIqJrlznTypQ=; b=WsjHB2uk1lWoS9Sa
	HD+yqNc4etgtLHameUFuwfGDKQhWHnd9xtZVJtunmW7gz5oek/ql0PJnooMp3M7T
	4G3pWJ1ttbB9P+ujsrP3z+o8QkJsoNY07hgWZNo8cb/mWRzzAaJUQv1+oouPJhgW
	jrxH8uZpKS/OEp4M5dzzygv/Pp+VaVEGz2OC0zjmSrTjYNx+0yr535vPbXbMImYl
	MuI0OWMuf5fgGy5mPkezhd8Dp/MLXyPsEAG1+cVg9TImOemszs7RRiBCYEh7SNgH
	TbjCL8xW/ir6NzUuH+1BaRMiKGToFPxjTEt2UD7QYOzGii5TVYacTPY92LSTVd0k
	FCM5GQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49atrs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:43:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e92aad34aso1345832285a.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779797; x=1796384597; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tLdJguhF20Qz5s+iyaiSixI+ncsxjnzmIqJrlznTypQ=;
        b=ifdRuwxFRkLDgMIOt+Ur/tl9jq5wySKdxseEJylChqzUj+ClBemYwhfHcwqWWqlCtB
         gN4Z9QfNDZnYMyppcGnyBNNLaOl7XGX0VNlspE7jtdplvwPO+l8pyj1WOmF1Jt929MH1
         5GTs3E8+SjJNFr16rJHugU5cnUwPiBOcoki9ZpJPh0A5ekaNqD5HbhGgWQA3NiNbxjS8
         WmrNHBhYuWSiin6GpQtNpCb/bLKoKoa1FBU5MIaG4sgrS22+oVBZ7NiilCQcd2CqmyCM
         EF1Bqaw2MbCe42BwnR5nBy342DA+rD1RoLahPS8yajgzXJBYM8TWAWAAT4nGoqdhYFZL
         EyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779797; x=1796384597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLdJguhF20Qz5s+iyaiSixI+ncsxjnzmIqJrlznTypQ=;
        b=XgLSg5bMLN4oCeG1wfmJp+dgTNOTyjX1wj79e1YIc/QD0ruW4iZDli6PAlgXRZcd5J
         UcImoyyqvE83Zl6+3/SaN3bVdD4luNLqGXm9rlIf3wBw6fSFPgeqpj75rHfG8RCnPIdj
         LvTQ+BrcKYuau9dh4pXI6UfTwZelVwWSg5SnFbWoOrKyj5GxFrMCmlyXlG5Ah0NMVv4o
         olntKC4taazTiy7A/+fDQFVmCYh2Kj/SKx/iAAgFl4wS3S2S1OuwzJvwJVuR/QMhWsGk
         2KTXTmNxNFuDv8bxBytHcg7Vvu6LL2c8/31BE5CnpxGiNbyuw4a6Ek5aSTdJ+vbl8ac0
         hocA==
X-Forwarded-Encrypted: i=1; AL+hErF/SP86+8s7FRbhq3QztFhEwN9cScCvgpw8kf1py8T0RMxIjVfJv3TDdcYvUrH864ufPC3hcERGSg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8AdfKlrVTLMnsmfg+li8o+/oITzYuAg4vwZ+eGbYx3C5kPLl73
	96s7VyYAqdmrQAznWqky+DnO/vbtZMVfUVmxfRlPz7MNMWf4nc39rhCIsPEXARqXtdjX0CiEQTY
	pkX0v3vJXqw0zpmvYKYDmD0O78yLgpH0t5WklX+eQO+N8sl6rBPrMcLyoxaxaeQ==
X-Gm-Gg: AZFdTZccFDsrMZYNEC5ydbhOdmgn4Aewr4hSkIXFVq0snOAYLMpfmvuYvagml7vY9OV
	RSukL/8slbVC9hLgN7ihMjW+4fIZwj3SPjksYbNgD65IZ3SLvLZlLmA2vAnxTjXYUOcXC70cLRn
	Ifm0x5gctutj14WtMMCV5yezaP24kVA97qy8kGiCoQzCVzd6cJ8FRofimFF33/XGclNd+aPKXXe
	E/NqSC0K/jh+coo2aOKy1P3NP2iURkI29Q5D8Ug/Qjiba5gNXwHF0Z/hCwqjyz6vM7ZGVyhhmRz
	1UsEu+Cz+y7YoAo2cEwqaZ/KLz+UliwuMacvUoPdNGG4ZRAZls2NTASkvmIdcvLUUOv07EKdzMn
	qnIhIdch+Vy6tj90Liua+tgCwlSypDDfmnXW7nmj4A1qHgxaKnDVpvEcW4P7hyVuvrWcQmyDkbQ
	Kr/i5Aux5Z0JFXW3+jzawQ+PVVBVp6K4KzChrLBjTeRWihOeUqG7XoRMPMpN5yMFA=
X-Received: by 2002:a05:620a:a8c7:10b0:94a:8bf:19b7 with SMTP id af79cd13be357-94a08bf1c31mr1028687985a.18.1795779796907;
        Fri, 27 Nov 2026 03:43:16 -0800 (PST)
X-Received: by 2002:a05:620a:a8c7:10b0:94a:8bf:19b7 with SMTP id af79cd13be357-94a08bf1c31mr1028685185a.18.1795779796464;
        Fri, 27 Nov 2026 03:43:16 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm716120385e9.8.2026.11.27.03.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:43:15 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 12:43:09 +0100
Subject: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document the RPMh
 power domains for Seca
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
Message-Id: <20261127-seca-pm-domains-v1-1-013c28eafc5f@oss.qualcomm.com>
References: <20261127-seca-pm-domains-v1-0-013c28eafc5f@oss.qualcomm.com>
In-Reply-To: <20261127-seca-pm-domains-v1-0-013c28eafc5f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=oIi44YUOlcdFNq2uRZjXF9VXpea2s43af0wtndVYfJE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrCWzRuFRTI2wZs8SW56dl1URmOxezH7qBju/aR
 PzLXUW3wguJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawls0QAKCRAFnS7L/zaE
 w+1cEACcH9m9G5NnItn/DOB22uAr4Hw+VztrWEW5zvzAO9ooUDxuQkBweoxYEqkkp3yIzQM8eWy
 LfEEGKoNX9x/CACqzX5jCixqpilaUzRLbcHpc//rxv0e9AuhPpDATmgSrNVSESQQmr4gVWEIEVZ
 e7CMJZ9wv6oIXRhOLZS1nk8PoqjkgsgPtiHLIsxNgwA+gpNr7lELD15guBCA4VI9tqYh4sRO1yg
 tfLdyuvtJCWQx98LTxVrsT+Z/vZ82Vrp09UxlVH4fRIrJnshuEXFAwB8JK9O5JPqglK7aNTZEQv
 +yRsp4rpKAd+yEAhjkkyREH3rypr2j/p2J/U3jCXN1Kw6oxz6XpWqcKWqQvhogfqXG0vTr5dxeB
 Ym/ZbyXauG8dGm2J/bZsawEcdfglEfEkrxgwpwQ8yStn/satHXHPWWuauA0/rkbRTqjdMkx3qu8
 bf/6gl4HTqpbyeeft+kw6qCf83vGJOwx4TglyVtw860F96hLkF9tOSk1czwqD+IX+r3CxX5puh8
 vqPApDufq0wN8OVGQDEhYDvlp1r8mXWzfw+YwRwXghBq3oa42/ZuS62LEYv3Tl7KyCE9sH94AC0
 pdNolYXhA87gb4fp4MkVd6Pib8c3UgRgqMLeqoEGd8lE01iXV2YoaydoqD4KjRLGI07ZeBrNdJ5
 j3HvcgOl9zknwsA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: YFc8Td-4YspUzq8wlAwF_9M4vyog6gW5
X-Proofpoint-ORIG-GUID: YFc8Td-4YspUzq8wlAwF_9M4vyog6gW5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX42+/z3Myh+5V
 T1HKNH2FMyqfZJgwYmXt8tvL5+lATzm9oYHsc0LANO2C9ZtUZeGIkTOua4d3IWN8a8vJDY9OnRf
 McJ1vXph+1sqFVkkVpazhEh2EWVeGUs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfXyIet0JX6i/aT
 yrKr6pbdNOPQWTL/C/fCHu+4uRZ2zbaujBouUYOLj8zVhz+VApk2csdcSriKyeWEFGToeelLO/x
 37u/kI/11GYA9AbqLRYnBayBYzpqWgfBIbGR5NIWoASVWbwIPlJ0Ry3iybgBH3U8X67pi7QCmXr
 Kd1Hd9Z0KCldRt8i9oXswERAIOMYCzx0G7oYv07tELLstEypZV2PFlpkWXNxhgCbOiw5467JIp5
 kQ3gMnZy/alval/M8ZC2cD04wu1VH4RN1R5TIvk9UO04rdcGQDFpbKxHqoRZmHOOyb+t31G0wDe
 iZ5SvFqvWyAtfBdqRku2CVu/h6X/n9Ky2AjFhBidgFdzdUpxxMkV6tAY/0IUkGHYYsRVckZFKL1
 RjjgtDbEt17AreolG8NAZRUMose7l4rutWoRCS0ahm7Z27dRIhXkEwq8WglCWgSKRIMIouQplTY
 qJGLRen1Q+OdNIkB4rg==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b096cd5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=I5fhp5uXFRFXYo5OHCMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270046

Document the power domains for the Qualcomm Seca RPMh SoC.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 663baae9cc641f16d8ef0a24c9bfe4eb33a37a71..c72df9bc84801e244b01ec5b46ea1d8d9cd0b0e6 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -57,6 +57,7 @@ properties:
           - qcom,sdx55-rpmhpd
           - qcom,sdx65-rpmhpd
           - qcom,sdx75-rpmhpd
+          - qcom,seca-rpmhpd
           - qcom,shikra-rpmpd
           - qcom,sm4450-rpmhpd
           - qcom,sm6115-rpmpd

-- 
2.47.3

