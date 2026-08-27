Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE24B04A6
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853191; cv=none; b=UldDTFv5KIsAo0Ffo9jFCZzRhTBkn/OIeHFLNXJvi+Ft2QGd+HDF60Z2NSdwr9ESda1F26MMHYFVr4sJxabD/QPSP3wrX/cGru9hFpFrfx6CYAhKnu6mKXu3bCjFr2z7rukHd7cY9WmibJ6i9cZk//qu7FSXnHpp117EKEs9Im0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853191; c=relaxed/simple;
	bh=9JHmO47xFcHiKwRcWRppqe+FIDEC/EmRY/1PhD8wx0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E6FvheDbnaKkgzEjKg0M+Y7cplVg2PyrCRjxjtSz3UnxTtkCANCLuFh7lWP34wnvnWyEKoGsxxUUnvLLeO5dPQIt3+GwR2LMSqr5eV8i+8FiKW5cwrmUBEaALgr0KHYPMIMO9rE90YXyc7T7RplkjTSmuZWoLCn6oxrry3gSPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgiw19cL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dGcgK52M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgiw19cL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dGcgK52M"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXdG5419814
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wOoRRo1BzWfxcKIRahahL37V6D+SA2lxSIowy+5sCk0=; b=mgiw19cLbzJcHRK7
	VwPAevQ/8uyHAndrw/snc2A7t2KInmw2k7/t1GZQLI5Uu0SxFiXzsU1Z8HGkH0ub
	cycv9V5eCxMoxfC5Cf0jpCUXs8i1uThgt+SCm1U6a3UMKWlnZKGlcgpVoqAfQHW6
	li/clZWX+3ik3xxqlm9zJh83itxcg683aGzkaaJ6AlNvlF0x35hQnaDWyd17XwOr
	GEIkEPvuUUHoq+XhI0nv+XRTtFTHfuk3csTxwuecRqaN9ap+R1tqQ64vMukLNr+l
	tU36z+SwvLHXS7vW0n7oWXZVS+xh0uggurYrejOaFxgyHdbN5xFCWKiV3sermd9e
	hirGEg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjftmuj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:53:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f710f066so614905ad.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853188; x=1788457988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOoRRo1BzWfxcKIRahahL37V6D+SA2lxSIowy+5sCk0=;
        b=dGcgK52M7ZGVoARJyAYUOxL4BHeX75RTACBSx8YUmK3cSBUjse1FDxTaRdIMy0kW6y
         2YTLSuQsicw4nI+5Y5jUgGAd/BJG1shY3YcfMutyzoSKbv3MMOpkULtCUoNM2jwMEEei
         Z4is5IVAzY8rmXO1D1nJLYHWWtIs2o/yFUTe9TMxgDMorlElu/7y8+pRFKvx5mN5+HFx
         kQe1GVoswWXaq94VfGljOVtPr4k0sTYwK5vsyUmsOuQW8TzPfJfqkw4Dl83mNsWTM+FB
         G8A01bEWhABrIR7fXE6h3KEFIr9ANtPpmiIgQybUTr527gPMkwdE2KWT4tFNM82ji/TK
         n9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853188; x=1788457988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOoRRo1BzWfxcKIRahahL37V6D+SA2lxSIowy+5sCk0=;
        b=iY9W6fFn/EuohYArOqQs+4Rey2ySMwZf9CFjOx005TsxGmxlUXpUnFPrsX1CNsu+AL
         7Xk4FacmqOl6Cq5EsiwPoLqDafXHd5K6/K0pVU5FDN90TMg+rqNW6opGtfkYiRDPCr9s
         RXPpKiJQluGNclt6Lp51vsMTTcNRnD0KjHDqp9rNDkIf399YdWKAu/YoCVN2qUx1hMSn
         8mMZ/76bXwbaQBAdypxCds+DMTIo/2g+y07K2ZwFf4caT6TuFHzxLmzfGuQrSnn+1icq
         nxDzQ8aCGSQ6rSVrcWCe3wTTtzxJ06YFozhsf0jOcwlqU1VvG19Nz9G0TyLZJx28v6z8
         evFA==
X-Forwarded-Encrypted: i=1; AHgh+RpZTEBEpD+bV+PHzaeDhLb3vX5wihZMs+53x3NAS5npRUXCkVRw4qyBLHFcr12jtJnw3R7ktP21ug==@vger.kernel.org
X-Gm-Message-State: AFuF++kEfX/KyhLGDeTysmlMPUGEyrL3fnHyW02FTur09OLQIbTAz/Ef
	yP4jX2zqafbBd9OIfSKhQ0Von95JOs9QhOBAa410AVYQeIA3PN629VHAPopon5fU5LFgnduNcPi
	Lt7CPFOYCklhcB9YiVJI/G/7K4fSiUuNED4Q030feu4I4CtTzl6+z6/Jlrr3StA==
X-Gm-Gg: AR+sD12YJQS9+blfzrOtRoaH3dG6vn4Krg5+ZaLh2H10d5yVmwzZF+pj0Zyf04TEZII
	VvgK70cyFkorxLeAaxB8h6SwBxoMf0zogkpdMwjP/jK/0WO6f1qYSY+68ZBGTSdPTr9BIJ4Mz3k
	RdIUWg2udXYzG8mf2LFfLI7jPj6nM8usTPRo4EGlNE8ufczkGBtFYWD2T91pp0/BhUx+ZbSO5tr
	jvirmhATh+pz6ECV/cggfVq6NF8FSfX+LK2isV+Z9Gpa2wcYD0JbcmWz5yh/MjtggW0zWYDMjbI
	yANPY1FJM3aaSna/PPBzAbr/C39ewfzXdFogDPWL9ZoreUTiJOOWaiDct3ocoCgnzlkMMCVgHSj
	T/EEwu4BWML5sfkmjT8f6S0qmWinc/nqW3JQwITX2kPr408fSvnbqMlDz/V3reDBfIsZdGZK5Gp
	OKgItwJ1K7DCxKAZ2VrQ1kVYk=
X-Received: by 2002:a17:903:22c5:b0:2d7:1f17:41f8 with SMTP id d9443c01a7336-2d726b17867mr108846175ad.15.1787853187594;
        Thu, 27 Aug 2026 10:53:07 -0700 (PDT)
X-Received: by 2002:a17:903:22c5:b0:2d7:1f17:41f8 with SMTP id d9443c01a7336-2d726b17867mr108845825ad.15.1787853187160;
        Thu, 27 Aug 2026 10:53:07 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm23889316eec.4.2026.08.27.10.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:53:06 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:21:16 +0530
Subject: [PATCH v5 13/15] dt-bindings: firmware: qcom,scm: Document SCM on
 Kuno SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v5-13-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853069; l=871;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=9JHmO47xFcHiKwRcWRppqe+FIDEC/EmRY/1PhD8wx0w=;
 b=w78Pw/hDL8SLhPCEJMXKoxFhO6U0UOpZUF5rYcwLAwMKc44iN6Fghd4LGUQo47mNIYLcxJvJo
 zAPLDw5OR5UBab9ZlI6me33T5i3eV780/WGOyOnbwyhtJdakaPzl5cE
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: 0meGfQArpZBYX7g2fGOpbv7sM9qTz_pH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX+FFR3lW8W0d4
 i2OQMEO3FwIbrL3QYviPiJdwyXbUZsNRckOnoRGECxf2Y+/Ybdc4nyp29GbGi1GPFtBwCyriUZp
 G96HFKMvKk8fUKYWV58CgX+h/ua6bqs0J2NuUwRGQcDRiuJzI55byAKWHa92ol+IIrUskgeRsS5
 8KylW7R1OrMr3l941SsuUdtlUbAV5UZX2yoSafamTKg5WDvY9mc5d3id+w1RYrCjNmg1K8PVGYm
 3QQl45qUGOndgv4NDq8Bw0gyTevoIZ968weuq2jXdbyP3nTXMRxbr+lZooJa6YeuTmgzvcy2+Zb
 gxxQH0dFASPNsql2KBsWimUewkHc3+IN+4Rqal6dW6a4LYTdaKAUXUx6d0+SG+YheyOWvTxgVEv
 KvSIBaSITvZpdE/0q/3aOYoW56IsqosEg+MSF2AICD8UGp29hj4PPg3PudJC+F1ebsmMgpXwjrn
 fsC60e5NYa9DcoZ6CbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX7cwvxoihJYqG
 yxSLwefSn3Rasv5TEZZwb9AwkQo2ikTIV6/XsT1no6aYqhJZGSY5okAdII2z2BMH5kq69EAaRLZ
 RjCFr3HiOzq7Rb9gWuMSe20HaO/fS8w=
X-Proofpoint-GUID: 0meGfQArpZBYX7g2fGOpbv7sM9qTz_pH
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a907984 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=M4Tw70yJP9P6qS8g1QAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

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

