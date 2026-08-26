Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07183C3BFA
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740102; cv=none; b=r388F+DJVoCysUUyEyEsxRdRs6v5YLbOyv9Z/EOweFmz/sv1xV/NbFjFqcZHR7CLIFq0Gr/9Tsj1uWXFN49ElEcs15ycvxJofKQ+vbkqRsXqSvRQ9v3InhviKMlCOu5fQIp0JUL9CsfFg0LHJHTPeaL8RLNMFqTWSNlfIoyaRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740102; c=relaxed/simple;
	bh=otEHI81H4WDn9tOnr9Q2d2YY3f98Ld2GqVk/KVLqC6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJbOjISNpsY6RyMsMYDs8tH4OQ50LFIpFYOFCbweZcqmMWR13JWn2GbhLNj4wjj4kE48+M3VF5FoYhqmphIeQzFBXS5NPiAQpbC9FblHFI582PsobiM29Jm3mUxK2NX+4FQoXojpHSFycQz7kThiADlSneDySNdGKmgMMzBKnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hT52z4/i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AsnkKdT1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hT52z4/i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AsnkKdT1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAGcIu630831
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=H8h1GEu+Qlj
	UORh54PMZRj2icU0G1P+PhnZ9VWrNixE=; b=hT52z4/inV1EHjsNenqVbTsZZl3
	b3WiMz0ZzKr5KUFaxO+N6QtWAlve08+JQHFXiuH/u7rxdcEkqjhzTDAqSWF1lMeb
	lnSyzHOuQzTQLx3DHGV0XrlErYUhwQxdSzfHucRkq+EhHNlch2kF4xO+S56jd83F
	xkRVDJQEEgWRRnRB5RxfafLwmbKxZAjJYZW72Hw8d6BM3FB8SKfBVggbjXy0Kigm
	Zi8WdbqlEpUGWzWWA9VExvzi+C4xNUdQ+Fqtp3ggbkjIXYLj54IY0WjmgdyeETh1
	z8WwXe7dOI53oEWxLJSXKm0LU9+AFz9jgo/+iW8IuskT27LDwPdppS/X/2w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k1nfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso1240649a12.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787740099; x=1788344899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H8h1GEu+QljUORh54PMZRj2icU0G1P+PhnZ9VWrNixE=;
        b=AsnkKdT1jjTNoHAOWwKPqocOIFXqfdaJwwFwvpCjkttjKzLOnzGB8wQoUMHE/DJPOL
         s3Pa+/NPKtsZBcpz5f3LCDUXMHiTMfAkDqdBMMQuVet8hD7OjMzQ2xU0ADfoGUTItdhB
         2T8m/h/j17o2T72HDYGtf7gvYyC0UTJ/4p5eFBdKCMQs7BpFVCSYG1USKmTOK62240Dr
         9OtK/zCiwVPjnMwDmWEpCNafeWIWOfBtYr3NuPktWH4VTxXvx9W1/FLjO6YTtyahKpt6
         pjV8hGeOTmWczPvLcRdWIrzDZfeBQ6/LKrZp3Ai/2vrd3l6PmikMJ0g9wBurOyHFsljy
         Rkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740099; x=1788344899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H8h1GEu+QljUORh54PMZRj2icU0G1P+PhnZ9VWrNixE=;
        b=W745gj6qDlWLIZVoyTpt8tADE6oPgB3HNJIF5sbs10PwpABC+Oid+n8lcazZmxXvb+
         plzcSyXRyT087Bz5yP5xq4jSRpisVgL19Ka9IbptVoQMB7DpmiFlJiwLZ1udQr1GEfKG
         6/0nZP3peVAlahzSWyMHIaCl6n8YeQSArQ2J62KY3d+SpSkIeYOqAk+wV8q3Wo9bvE7t
         QxFmQ2jeuu9Otiv0/uATICFPExKV7cWlM+MzWf3g07B19RgsdfLHPQqyW/kRvqebjdII
         LEK1GWsFIJvBEks0vCW80lmolPCUYn5c3dI/EF/5ExidSShFeSBn18LnM10co2A6gNds
         248w==
X-Forwarded-Encrypted: i=1; AHgh+RpDRbYlk9hJr+ewRV7D4rtWoHI7kpi6uMHLJh3zimUwVJpRitsIoKhq4pX0PeZjQ7r3Cz8h7X8xnw==@vger.kernel.org
X-Gm-Message-State: AFuF++lhnqmq19xKcz8ceAgAxvVyZGFX42OANSN4SCVnxWYnt2Ns3aU1
	5dkBYBr22xPoiIFcEMv3LPnqN7iFYadUiNG3eykJvcB0wtz//GBAAd4+aFhY6MBgQNGKs68+T/w
	DzQjwjBpODeptuV9gMMO6hOePdPcx4txX82o49USD1LSRmdJNOAM65GXqDrWQkkUxx4FsHKxC
X-Gm-Gg: AR+sD10v6AN5FFS5ou4rVMqMMvOBjXnOlDJcDGn55RrR5cKbNh/dSJ514USwHwuee7G
	H9Gicey4nvjX4KcEs13e5kfvK6jLpuwTOy9WTBWKl5gzt8/JHHJCSOu9JRqvH0l7uYemzvLU9+d
	YQgxOHdbY8AmnLXepQhm2TV1CH8sfzxzeBD5EyBl/k9NBYcQqQM3TtGfWm8l1ovBm+RatpUsxr/
	KS5utPLpDjvUTyPB4KKNLy7oC/3f5h0/OLF9un4uTM7yGGAFzOg+Qpj76KjJYH8IVTvIYtlIG2N
	v4q0sHk1fwqI5caK23gAZrPgttZJwCh0/zw4UO0ZB0Kmnkb0YayFZcIgQWbaT5bDbjWT9YcOKpa
	w1/hP7RS3Xu9KOWYow4dyGZYCmNJaoJ9rh9A2HLEcwgPqG7zTQH3HwYLkJ/sk
X-Received: by 2002:a05:6a20:a110:b0:3c3:33df:4d9a with SMTP id adf61e73a8af0-3cf7596a65cmr10578911637.1.1787740098636;
        Wed, 26 Aug 2026 03:28:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:a110:b0:3c3:33df:4d9a with SMTP id adf61e73a8af0-3cf7596a65cmr10578819637.1.1787740098114;
        Wed, 26 Aug 2026 03:28:18 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm12935669eec.6.2026.08.26.03.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:28:17 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH 1/4] dt-bindings: power: qcom,rpmhpd: Add NMXC power domain index
Date: Wed, 26 Aug 2026 18:27:43 +0800
Message-ID: <20260826102746.633076-2-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8ebfc3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=8T9gEdC4W5p8owDaN-wA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfX7MS5hC47wLTV
 qc4YIW+PEP6HFJmtZUO/cQchjakMB6+YKpmGbShM/C9URJCwLSxDGAZEhwgHga7OABxuV4/9wQI
 PCjsK7xCVhQB+8JAVaLxrjrHGILiBXs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfX33jPb0twNgMl
 2HxJ4FnTFJUBCtNKcS/JqzLpdsn3kt8p3lAE6Tsx0Wif6TkdXA9ZosLeNSigY4Vhmlg9hqtbIEZ
 EdpWTPQeeJ0GV790jFRUbr4MCTDJvW7fKdBb73MOJw2EoQRzt+cxQ5ZwcNORH3tb9k3uVMzqRPQ
 odnevSZ5Yey+s3Xu/hxRkTF40Y0+nZRTj5EGc5LbltUNm03XlFY/rxZcMkUjo1JlliFtDsOrvUx
 pGGIAvSTP6Yd6YOkZutQUntAPKpO9tw9TDgWAmWW7b65UflJUv0Na3+ArWHwfGlvIIK41abVOeY
 ql2NBrSlDv9wA98/OQFaJQy1M2iSSYtuoQWoyWzTxQQSopCHy8TO81lqHL4C+lgxp3dXH7Mlob0
 sn58YyBG0EfehzZ7XB8EhrNJPCSZYfiU59Qg7VokewKeoru3hvx56Cic28TAvpxXJvpJUqxdyf3
 18QYk6Fn1BtydBu9lMA==
X-Proofpoint-ORIG-GUID: HVOl0O_q8mYyE6e1VpKKHWKtulbILnTu
X-Proofpoint-GUID: HVOl0O_q8mYyE6e1VpKKHWKtulbILnTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260087

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

