Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D63C13EC
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752555; cv=none; b=Zrx+SSsxC6mfg4/4Y7Zk8x4/ZjDQD8XdxFWx/rCsmeF/N1VnhS0gE4VHshl0dr+fs31ettMKRBTBInM4ASUbwJ17cqDH1gySiHdd1GDNVWN8sk99IgmJO5rboVLGlh3DHpYc03R4cCGakVUiwl0aKNN3AV6PDwknU9MIyqMECr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752555; c=relaxed/simple;
	bh=otEHI81H4WDn9tOnr9Q2d2YY3f98Ld2GqVk/KVLqC6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsEjQx6KVzYJSyBT5hVXmz5nyJoGcHC4J3d94jZoaND07XoKj5cJ5KttoLe/b7un3nTzNPBXHDr4FX6aU878//l3Y3xJGPvIWXB2TIuxqDL7V8M7EDJoQJgXV0VWSLPrjMJF5DH+3HBi5Bmd8iZr45tFxQ+iyd8+l3rZTKKH7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q/jGLp5Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uh0XtKvT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/jGLp5Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uh0XtKvT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDHlrW1617883
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=H8h1GEu+Qlj
	UORh54PMZRj2icU0G1P+PhnZ9VWrNixE=; b=Q/jGLp5YlEK12a8Ol8D8SQCFtVj
	DMn7XQMrrURdSTog6SmesX5WQAitGQPJ41ovWo1P+tOIrWTfVIM1ochF7ZwRBMlK
	1sV1LdgP+DJHvv/NqN+5dkmZut+Ju75oqaeHybtbRQ9hXH4k71obCkPIOhpcYKGI
	QPrkM6IaPAMT9OBF2fYNo/a1JrzemuytGaELCv3AN5cEgC6H5hCrB+MKTVf77AOs
	FwDOaNyjsygwlgnWE5b16oZrYcVJcnlq+axzjxLmr3fQFj3mnwBuyl/yW1SgRiTW
	qLrGIHK3Bd+8NVOwIZwkYICvcuY6UXUSCk/TIpq9MsitOI4hOmeBjJBbaQA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbr54a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:55:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso1635272a91.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787752551; x=1788357351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H8h1GEu+QljUORh54PMZRj2icU0G1P+PhnZ9VWrNixE=;
        b=Uh0XtKvT7ud7hkaFyy+TKm0Kpjm1Y48q+RMsL+OEoU/J2GOgM2zaFSqCWkVngffBh4
         UN1SGtUTvspgMaiMNTHW8jG/6U9G+Qo6v9u9qajRz5vpttywVWtrP3+7+kKApdAhciU4
         cMAmOK5hm4CoHwGlFrukocedmRU4zpGxFacRj2nAz+YhPuo/YRdnWmRWT+K7v+6+CGvZ
         IWcxal8WcgjcNgbmD+pbxPTtCUJR+OlS7SBhUckKb5Dg35gIe7KOkN0K11r5GyvTxOiN
         UAaQEeULG1v/8IL/OlS2gTXNzd2mwWsGHQ6kJhFcI3c+5A0N8vZxJLgz09u3uw+07k41
         o8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787752551; x=1788357351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H8h1GEu+QljUORh54PMZRj2icU0G1P+PhnZ9VWrNixE=;
        b=eOuSJ59d0eEexAm2HMHNKkewD1ryLx74OZAXhiUU3PNtWZ/vZ/GNJN0vcji2A8iKvA
         NMEFkM0XmQqgZESdRZ5crPgRj6G+wwUD8Z59sR8NAXR0cIIySz75RJl7y+p3cmeKxUwW
         avLqb3CRGitL3bTkMPl8yTlQ0S4srRtEvMrnFAGwfhhhw1mqrRz6tgYPhlKcOO30r+Av
         grs0hi1DwQGZ5uE0LFadZuObapskS5+qgTwApWRsful9YiLB9DxZyFb63Vcdld1XKE7j
         P0s+0I/dyXcTYxhfOmievkCdKGUNIcgr1LLGhobY9MoZT1ZgAFupQSxFyBepEAjxxroq
         0YHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7dmt7mCdoU20sLdqAagVxlMkm1sqsUhVpJ1Wr8QKwOhHvrkBhigXgV+snn90cxi2/n+g7PgV/ew==@vger.kernel.org
X-Gm-Message-State: AFuF++m8IYL4z7utiZwWiCLNy7qlQC7yAqA/5HQFIkOgMlN21Eac/cRA
	5JlV/OhiLE9bpn5ZKNhvIgOWOqcqeTNp9H2BVXb8d+yM9DqOWuPAPfh4BKY4rtZZ2zKtuXi6WtI
	vpmghPT7fP0B3i8CxtmN0ZOVks9BPXp3/U+t3RStiAdgRtwv2HHnagJv3OW7bTw==
X-Gm-Gg: AR+sD106paqdCx/9k/QeObFf5cTCCKdi0l7UPaj4fj1uJgJqa9xhIrspXVHBUOl8G0a
	exIBmZvEc1cYHeNQcrZd/lEW+6Ie8mWGbTJ4ri3Aw6C7VEfM9Xf6NpC8IO9uhe/Eh+UcJZ/lPYt
	CGE5h0X4rGXag43K+GXnK9/yEzeVnzSU+Y7RiVWM3Nzr8Dse32t2vOn+wK2b2JFrSDSF9viSyKJ
	H+OMyPFe0U07RZNq8pCxjFY6eKUyQwykYztwRn6PAYhu4PZyLqKEGl/CACCJ+3iOyCdfcGXftNT
	gtJ3Nn+hriGVEQnD4lPznDF/1Oss6BozXeFN3zb4CYVD/VfNy4PY9cH5jI5/LFUwZ+pGxOWx8+/
	rokmgNki+zbVncKSEPZ4JEhcTrAI6p0jz3+qAvD3TPIBtVvz4mVb0X6M3G4jq
X-Received: by 2002:a17:90b:48c5:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-3966d13efc0mr15615193a91.2.1787752551520;
        Wed, 26 Aug 2026 06:55:51 -0700 (PDT)
X-Received: by 2002:a17:90b:48c5:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-3966d13efc0mr15614990a91.2.1787752550699;
        Wed, 26 Aug 2026 06:55:50 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a573a1sm4347911a91.14.2026.08.26.06.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:55:49 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: power: qcom,rpmhpd: Add NMXC power domain index
Date: Wed, 26 Aug 2026 21:54:53 +0800
Message-ID: <20260826135454.658615-2-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826135454.658615-1-shengchao.guo@oss.qualcomm.com>
References: <20260826135454.658615-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fTuQUTKeu9mOC9UXeDJiMhq4ZblyjUDW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExNSBTYWx0ZWRfX/vXfuvtQdi69
 oYGSCNx0VipGBbGJKa4tezhh+SZJScvjWcI0IU4bEctq3rn8CRPFtSMtfUJqf8Q2ZsaSHkEThUV
 8+Hsj9gpAE8AzWbNR2bozaqUXgmnjDg=
X-Proofpoint-GUID: fTuQUTKeu9mOC9UXeDJiMhq4ZblyjUDW
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8ef068 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=8T9gEdC4W5p8owDaN-wA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExNSBTYWx0ZWRfX95sw/H9x2vjc
 pnhy9M8gv4T2gul1TKy35LDSIELvIKqrdhqzVPgb3eRk49nam5J2/PpY0OEFteCyYGEWNRdNVQ3
 KKG1mPZMmEDZb4RlUPxvf1xt++/C9qFgJqBLW8wKlfohnP2zODLLWq9MabNKCu5HaCneTeUr6O8
 /fLQtN+FlElqcSS3aZEspcScyb4KlB1Hxh5EFzGbviIok1wthbF7P4AR0DRsSL3A4dXpLswktBH
 qZzeiX6h8SqCYwgi3pf1JdLOrXTLKSOL9kNLFlO9CXfC42beag7fwW6odDAYxU4SASvvbC2fR01
 19fygQ78VMipY2x/kfJp3sVdaJAXIiH41nMc0KyvEqSwZnl7f3FLMR/LuN563BYafompR6K/+Qj
 dvVaxOiw6iN0TIw3tLDRcRYBHE+TYGl0+jR6tlOB/u7kGa0hby31SRlWYQPqiitf9T/MOY1HBb9
 afeCllSGnlkDwwsLWag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260115

From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>

Nord routes the NSP (compute DSP) memory rail through a dedicated NMXC
resource instead of the shared MX rail. Add the index so device trees can
reference it.

Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 07bd2a7b0150..92c8408dbc57 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -32,6 +32,7 @@
 #define RPMHPD_GBX		22
 #define RPMHPD_NSP3		23
 #define RPMHPD_GFX1		24
+#define RPMHPD_NMXC		25
 
 /* RPMh Power Domain performance levels */
 #define RPMH_REGULATOR_LEVEL_RETENTION		16
-- 
2.43.0

