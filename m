Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88841D211
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692831; cv=none; b=e1Q14gX5gBt5g53Lu0nlWxBUSt/xtKO9kvOtB/qEBUY8a3S+ZD977WMiYglQPEKERxeGqbKSmcHHqOX9hq/0EDZYBLIdbKlNARZOGC0wSCDNkBFNRN5u19G1sDecl7P0rTPa1WnNT+l3/yJ0ixUZqZ/UqxWvTWKfbolo1429PN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692831; c=relaxed/simple;
	bh=+/+CnJFkK28UfCOUz91D0FsS6GYOqD6AEiwdg9UDtAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6u5xTO+y6X2xNXlgJZVsmokrtwmmmaITM6m6AuVxTwnBfcQf6o+ysk+HCg+hcD3PvcwDn/r9KrnuwoFiBS663N/Q9o6aWmDprhAAafuRAM1bNERYuVdlLbSOE37ZHtpJHfSK5m2X8iY0pZjJHutKz8TwcK72sacp259W/hLYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f47cNOju; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iFfetm2g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f47cNOju";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFfetm2g"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4QuWB283607
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GsdXzVEg/opOUMCjXIMLe0tWNQrrcXZla2NfQwnp4TE=; b=f47cNOju6Yg9bKgr
	pVlDJ9ZD1JPPwYQ3kYTqh0QE4byrKyuysRvlI0cjuCdzouB1EIo/rY7ONJaRiM3D
	4e0Wfs35yErbB8+a0S6GCI2+0GqTZkiMDgQlWuoJDvop9jsAe7abC7somdrXeOSy
	m7w29WbZpnvknbkOeiNeJyscniNVcUN+ZRBdwH6oFVFs0a/5sZIB5L2TsOYGRmVC
	EQwU1HgTvwJqWAGZAXg9ySNKRlz9FEBpBc6GCxwf3TTEM2cUCozy+hj/taydQVl8
	utrwPClqiXnV80cVBd6hlfMBJ2+FOMTamDkS3kjarFQ1bkPhxyfzaVzLmQSUKKWn
	yWQ2Wg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h90u5q1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:33:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so592218a12.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786692822; x=1787297622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsdXzVEg/opOUMCjXIMLe0tWNQrrcXZla2NfQwnp4TE=;
        b=iFfetm2gDIAck+ar7ckmYqV6Pf7sVCA92rQe0Qe3H0FAKKjmlu8lLGI/DjpCy35Tff
         Toq7GTgoXECF62zhBiI4unHD4axhnsgpPNWivX9YztSfZH39KJrEo+Lsaf23qiusm7P+
         z2xnx6t3zgs+zCTjuRmpsjeXD5NF/SFmmYWbhOcHCXse+PLo3lzIYpIk7k2OZPvA5nnn
         TR2emXZfJv17h1E8mK389+y6caGXnprrDDWGsdrMTeTIjKd/4511gn1s2UGv8Jp3b1CV
         2zICOZrBi2fkQB0hH1SJGy7DZ1kDhA+5yiE4HX9TM5P9OJaoGFndvBIxKRff96PnilIK
         rHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692822; x=1787297622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GsdXzVEg/opOUMCjXIMLe0tWNQrrcXZla2NfQwnp4TE=;
        b=fR7KX2LWWi7O+WR1xsFIxk8TQ5p56PnT7TC4TXjwocgNKN6WzNoYTTR+WiluMKgu2i
         7ub3LaYBS84UM3CIFP3WxXf0fwIJ3QsvvYm5PAw92PMqcb/cCckWsc2CYcG4vdmShjAz
         C960jQfkMrVOJN5pKYjDDtTSvpeVloTjjWNpywW9Q8jeYKjLwic1/RLdzA72DHlBjOrz
         Arq4eO4w8UgXANQ+2SSNMXACleKwUIHtFZZ7P0y/L9w8EdYdvu13aklDqvFyBDO3+sFY
         Jv35zowLEmnHjK8Q7oMmdYNwZNe9A/oPny/Hy3Ytzuk2mqWrdsgSNnZpgFd5cKUu8yns
         AU1g==
X-Forwarded-Encrypted: i=1; AHgh+Rraa8Qn4bpO9TxWDwpb/zNa5jNzkPf9u2ZyGoWMPTKhF/TcoDQg7RS8bGfu4S6X/3i7lxg4lZPT8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSbqJHPi0f98wOk3AC+mgYrnyjTwa5kux0ndG/6mGD0g/5lBw
	drrbpUdM7HI6G0rUwFKh/YnhAhYYe8ZuWjjkVqjSXdvMsSxOhLLWGAgZGv00qwhDasivDlHZqbr
	+bNUKygvVmt/Bzaq4Wbho+HwUqhEl/8OA2OfWjjL4/xGFwWpHi9mRMQ6klJ//Rw==
X-Gm-Gg: AR+sD12scTR0gMdEXQXY6fMAacAmMu40wPFx0NtYM0XUQuk+GwXd13U/QETNa7bpGWv
	ezhYX9vamqZq3OkDjJGPZUuwPwtKmjb24rxkl69ip1NIoDmHhxSt+6/VIV0/TeJYxDXUqD9EnFv
	aaXzMnGKqaxatZNnJoqv5a4bqbE/V/SNRgCl5yjWWsutDD20S9nqyFblFGeNnt27FnuknKDxmFq
	G0Uxpg6+AhtG5jXRZBHDnkuCWgnnlmk5GDuIBkXORtp550EgIgcJymOLXWEDaAE+n+mGhJDiys2
	iU1FKIdrrQhHMKAKF4U6tQpTK1AqA9n/hsYcn5vP4rlhajsO6s2/eVFXh2x7rsGBNJvgkYk+hLF
	ZQPm9QfXPIXXAxMeOQLVlaTOIWrtGz5cpf2n+73NA76qtLeqcj6CKzM6t4FVb4oUth6B/qFj6se
	PBAZTQBEcxOH1APb6U44VYT8g=
X-Received: by 2002:a05:6a21:a98:b0:3c4:397a:69ba with SMTP id adf61e73a8af0-3cc71d7bd03mr4632001637.28.1786692822528;
        Fri, 14 Aug 2026 00:33:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:a98:b0:3c4:397a:69ba with SMTP id adf61e73a8af0-3cc71d7bd03mr4631945637.28.1786692822096;
        Fri, 14 Aug 2026 00:33:42 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm1062280eec.26.2026.08.14.00.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:33:41 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:01:43 +0530
Subject: [PATCH v2 12/15] dt-bindings: interrupt-controller: qcom,pdc: Add
 Kuno compatible string
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-kuno-soc-support-v2-12-3079794f0f73@oss.qualcomm.com>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786692714; l=922;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=+/+CnJFkK28UfCOUz91D0FsS6GYOqD6AEiwdg9UDtAE=;
 b=5rfTSqeF3ZffhEbWQ/MCkAbuDD82v1o8NO8GUugDaLDLaKTC3LlK5BcLVBkEaw7CxqOZjkCyn
 LB5WOXsXFY3DZZxny1BmotvMhg1imljcHSJu02Gp/nx3UKotZJU73zb
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Authority-Analysis: v=2.4 cv=Ovh/DS/t c=1 sm=1 tr=0 ts=6a7ec4d7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_KRvd0mH2JNXacczCDAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXyyyx99GpPF62
 OSyBix/r+TiLnzmyOMWyAWVpdjALr/BnJrFa/EoTzeMNIJryW11BfAJ3Umj3OKUbOk07J5E5VCe
 srreLfNfHe41wFZQSUkrQJEit7HC+70=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX/DGktL6gCuJ+
 lwu6ZhrMkqTQCMuvoScM8YRQNcfSi7RrJOcoJa7RA41Zk6YxTItxISvXCs7Kz2lsTnrVQ7nKwKO
 wgf4gkiKm3uiiUlVXb8ukhiOzNWSJ1LXb/k8kROAaz3Oa74aEAuhi/nOSFTs9e1RPZHIH+sUTl5
 ZszdWvGHwBpdSLMXbu84Gx0u3ZyZQJ5P/ugV7Pt1WtF5ShndW22NGF78i4ath/UXgtDG46GzdEO
 3qYYmmgndI2wXZXAwk1d6tRpOHvrLSd25ZsTYhFA/PJMer2L7O0RvoRMINRUN9l1sUp2Y3+Fl8E
 8UKEzlX/nyMyMJJzIce3Dsvs0CRDcvuBbErYuOSFrUg4HMBx8DvHu8g7XkNRsidTXCd/VV12DFt
 2oaf0+oNQQACt4nD0M9o3OGV3qbutdlHXW1PYMCb/9zvBV96lQtcGMZxGY2zjuYmxEvzhyrbRbA
 9rnIWE/9FcX2dAGSwAQ==
X-Proofpoint-ORIG-GUID: of26eDypF6IPCK90gVrt6q30hPLkpcr3
X-Proofpoint-GUID: of26eDypF6IPCK90gVrt6q30hPLkpcr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Document the Power Domain Controller found on the Qualcomm Kuno SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8162a49d49a6..518fbf6b2761 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -30,6 +30,7 @@ properties:
           - qcom,glymur-pdc
           - qcom,hawi-pdc
           - qcom,kaanapali-pdc
+          - qcom,kuno-pdc
           - qcom,maili-pdc
           - qcom,milos-pdc
           - qcom,nord-pdc

-- 
2.43.0

