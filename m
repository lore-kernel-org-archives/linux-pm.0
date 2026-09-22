Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F43F074A
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051636; cv=none; b=Teyc/JJ21sBJPnkF0jnXCTcfcfNYFbuvCbiCB305wSpVjgSC8B/7c3hlEEJToNSJGEcMHnJJxILvUKH3Rc/y7X8+dMaTdRXjzggSTYEeKh9xbTMuF/MTnyzmb4cr4+PDALvHdE34WBKi3wXSSHka9S1DjbWhCW0Se5VikWphDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051636; c=relaxed/simple;
	bh=+CrABi2X/StxEwnWst3mUt/1ibBP9K16D9ajzjNs1nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ah/nlwdWSQXsfLMFDFAHRj2RSLzBgtzN5Q7YIN6ePf0/iXtcLBxw9r1mjk+dHceqmv4J9AzlFVqC1QHzAz3vbyLT6qva+vY320UU4lAYI+ESREHsI1TxlT/sPaBQ+mB7b02UaX5mF9tMkeIKJBU0PJHKCyvmcTU/iI85E7eoXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdK/lU/K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eajmPJay; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdK/lU/K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eajmPJay"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M00DQD3840523
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tvjqr6fgEwD3B+/nx7OrBeom5nuYsBLcU8Ew/WCH294=; b=HdK/lU/KCvOIEeVB
	b8eXQ+pvxuQFs4/Fr2r9BmulpGXozcQQwxEsZZNsPVr0Cs6N5cW9rxH3AOgg/1Tk
	jp8AJsJ6a0o/PNKcUs0ptbqnt1ZK+Nup8jV0mMtIPMi4HzmUyVMNApvIIJOo5o0v
	uyPlB+0GyBiFTMV5jWdXVQHPCFCwSFLvOb2HH2/j5R8rZT71Yrq05VT1Y1ud0WSd
	oCdOo90e5egi6xAGcGCuncWz9cvM7o7TqQoBKKP9SzbZEgLhCygII7q3u0aBGFy5
	NAz3U1f2C/tOqo0jJSUEXXS4i2PUS+Ja2R+xOGD0yPyCgJeNb9HoQKDmWC/ftM0z
	FR1tvQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8v526a4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso4775976a91.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 21:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790051633; x=1790656433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tvjqr6fgEwD3B+/nx7OrBeom5nuYsBLcU8Ew/WCH294=;
        b=eajmPJayqslaM8h7062zPfs2F7yDcfbH60Lsb3u7Zw9DuH9ToQqn3FrGNO3WVCqfbS
         1qloFmlhOn2J+2Z1iWc2LWhmToRijtqC2fL4YlQO4pigamWIrWvgPeozlkFhhcQ3BVut
         BkcPAQIJYPtkXDi8RRSbnhSPMjXhsbQiElqUTbYPpr7UQeEkY1tWAgp27zQtj/tzaZ8o
         m7K7bsLz5A0Na1Wl0OUzxB5yWwxIE6VBeqnuP6m7XwaCo13W16TSjBu+7qdZifKkIelU
         tF7jpPsuvw8vdLRkg674lmR8NWT1/N96rlq6dYZ05dSSlFTKIVxyPdXdO45dWo0Z8uda
         hb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790051633; x=1790656433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tvjqr6fgEwD3B+/nx7OrBeom5nuYsBLcU8Ew/WCH294=;
        b=PnWfwP9mx/zmlH1OZatTlzsEp6g3svzh1Jg1FUHVSGC3bbg8sDnee3qSb4B+BQvbkq
         4GhR8aYCxTU3ACiIbcmw+g6vH0E/oIbIkoQ5SYldK5GAmEyOKmOFYADgEcurvX0p6XAy
         J6OhLeHIalbCH0ygLiTXfUvcS5Jn6XZIL1tL47NtkTpavuNvZnEE9nC6hHpz+Pv2sq9V
         hsTpfgBglFaymEQq6W0c9e0OHt/tq2g3eDs+R1FIFlerVqZMWMFrBF8bJ5rmlNMqiuFi
         EozAyygd3fWVnWOfwMnR5gvK9Efo0s7nvIcG4QCCvKaqva+EX2Watvrj02/IevOvAGJ4
         qgIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvCE47UwjbK/FfoJcf9S/AtY7BQFOQfr6OZBg28zDd2zhpo1ciqBE49acemCE0Ga/sb1va8q2JmQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kZRLPGaIZyysPnEhi7QiqMczSTN49mZ+efolwHPXWZN3gd8Fq/
	8swPw0EqlbU4lEuH3Qf/5eTqh0UUzsJynHpvZYq4/KNVkgnLPclPcPYO6J+52verP38rlVskzeJ
	Y9EiDKespK2pRzx404rsvn6/Z6dkAGX6js916LaubETE9NyFBWk1nNYlEv2NeQg==
X-Gm-Gg: AYBFou3qVPyH2BSyvmbRFFOZY7n/m8bqY2SipEpj2pS4u1k/iNT4Y5pGmNCAg3w3q0r
	YTwMLksJFYnhoWk5EV9eWicltTvcisrLyEtwtWRhZ2IzX9byELv7X4QDEBYZXIjSMo6foH+QpJV
	z3MuGfynb13sH4JcGE7vsbeDoSAqgtiPbYqvUzxTKDEl3lRhuLZkj6+tKjcEkoH/1YgLInsYE76
	aKgKU8bOuOkLjMa4hP5CvOililHGkV02OAaJSrsZQyOSAngMy66nRqZPRUeXLhIp1Tb8nGf1URe
	WPihHNUl8pnpId3xAV7TdB3igdTAsRoTHetgpJRXevm7AVEaXYXnmHSfFFTMAYJr78HHqGi16Mw
	mG08DsRADqAW79bGGteKEzX8UVNJGNKIy40UJC1hWcZ7hr0RxfoYvb4TF1Izegc5IJZBB8sKzy0
	VCUQGgwynwXe3KC63MAWcFU68d5ItiQE7l0tI=
X-Received: by 2002:a17:90b:530f:b0:39d:fcbe:c1ae with SMTP id 98e67ed59e1d1-39e54ff2f17mr19428382a91.23.1790051633420;
        Mon, 21 Sep 2026 21:33:53 -0700 (PDT)
X-Received: by 2002:a17:90b:530f:b0:39d:fcbe:c1ae with SMTP id 98e67ed59e1d1-39e54ff2f17mr19428342a91.23.1790051632870;
        Mon, 21 Sep 2026 21:33:52 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129ad40sm1906375eec.12.2026.09.21.21.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:33:52 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:03:15 +0530
Subject: [PATCH v2 2/3] soc: qcom: socinfo: add few more SOC IDs for
 IPQ5210 family
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ipq52xx_new_ids-v2-2-4b1a0f3d04b2@oss.qualcomm.com>
References: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
In-Reply-To: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: Q9wpWONx8qYTlG9obwK1_LLQ0c4wguLP
X-Authority-Analysis: v=2.4 cv=B+0sQ+tM c=1 sm=1 tr=0 ts=6ab20532 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PP8aMIA6NNbLyI7UcOwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX+h/nAkyUwcv3
 4TOOUxZEs9OzkJ9GqBqJZdwy3ORFNui5HsIVt0MtE6FnfKrgoQw/KI36yP1MnEiyq2u7D71wIzt
 azE5nO1NBXsjoJ6uHMX12pYiUrP0ihw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX4Q0XnbpNpKEM
 H/pUAcjbbKryQoVeQxyldJBzK4/2/M/HnaDlY/Jr3P2I2MqegHg6t1/Xz/omS4bDs9qUCCmd/MB
 SBBtQY0eZxbkvgkhcaaKbyW9uwjgrTkQgzB5cKKKETXh6eqQNW3OB3A/qLxyJkQIQz/YptlPfqW
 QjI7K81VN61wDKCDWz1uIdn3TWtUQo6O0uMQ/LGzqXoF2qu6kCOp1eb9TVpXa/oJSKzcAFtlYZt
 E2DTYtIkZ+/0WWDwfZ/nqkaK0qVYlucdGglL3KBji0dgt5DD5j2QdRfswP2iufYSxV9kh6Rw/SX
 Zi3xjgz62vujJDnGBD/2RmgntpzZGQKfwOngGCFEzeBn1m6NS+o8LvMjfT31+yPpKe9pFYI43cZ
 4Sna/l4L5ArhCZT4ysctK43GMkEyeVKszaFKd3ID18pYOEV2Jnfti3+hYIjAtp7ios90pAhaTBx
 uGpvl99RtL+5TBCYseQ==
X-Proofpoint-ORIG-GUID: Q9wpWONx8qYTlG9obwK1_LLQ0c4wguLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220062

QCF3211 and IPQ5211 are the new SoCs based on the IPQ5210 family. Add
the SoC IDs for the same.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 63ee5cd561a2..4e7e14fe7231 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -558,6 +558,8 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ9630) },
 	{ qcom_board_id(IPQ9640) },
 	{ qcom_board_id(IPQ9670) },
+	{ qcom_board_id(QCF3211) },
+	{ qcom_board_id(IPQ5211) },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)

-- 
2.34.1

