Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5736998C
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971605; cv=none; b=U79fQh1eWRk/03iAT6zuyqDvcXc9cORtSblNwpAlBQdUbt6hRElwnsKudoD+XSylUjmOtWN1zYJ66MWqzQYL1ZCnao8x2dQexRSWJT4PlSaye0vwo10uKc07nKld65b5WJinJ5BfQ/r29W8L15hQlPj5kM6XgOh71NrsjTA8iE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971605; c=relaxed/simple;
	bh=Gw3kKloXHhd5RaAIBqqm6LohQm4BxTM9Pt44ObqDInM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UxTSze6EuOWAyoHkcD/VplMR3gkhtiVxaN7Q09F56VDdwFMk8zM+kKHsnP/eWMT4fTP6vaf1+GUYZXeXJYLXmtyYP2w3K3X/sBYvz0nQBDKrWT7vsoxnnbcXlcFEqpkaaqevgZaw5OSScuZ3tU3z11kPujxmnZt8B/BREMXIC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AN27V5C9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QmrA0Z+F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AN27V5C9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QmrA0Z+F"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3Zbwl635556
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6cYeD1qFgi7PTbqTpFl3N0zbczvxdHg1te/yk4UXbYQ=; b=AN27V5C9eoTXuW9j
	qoWqnBpOgwgFiedzmEzQToIYx4Vc+8U+TCJn4/prJ+2LneSZwZm1wF7I0ENHApzI
	rioRQhE8gUlDPSrmV13OKaf6bbG3Yo6yYNEOgLNVAqYX2ePn7bxmTpM8BEAMs9XB
	QYm8JbbbS7WeFTkm7AhOUmMn53V+59rZOzAsuOSKK1AtHpsRY2SPYZVrn59fWMGA
	e0O8RaXZaKc6cou93DDdrhoh8pNev18dyhfrWB7dPNothfdZNWssaWi8vEyP+Xbm
	97D9/12qmdX/lDlPjAtSz08ej6kgx8EzFk3pIJ5JV5Ahlrz2wJ9lSDcA+X5xY34Z
	CCo8Gw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshyxw1fu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dff6253so39294035ad.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 23:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789971601; x=1790576401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cYeD1qFgi7PTbqTpFl3N0zbczvxdHg1te/yk4UXbYQ=;
        b=QmrA0Z+F0i7XJZyUTB2p7OPt3raNRA7++3JENpobV3+dW96BmJO8bGcvn6O++MA5by
         KNJ5mqNC4qBbY9S9cw8/XyPsEceZUeyqinBU2ptE5Jwme1GtyZgrev7+fSzaTF+QTQRD
         V617xKppDgWJi00NUvwYbMsVuPrxuk9QicHDp8SZWmPX5c1locaJETEmiTeyeRlbsC15
         2MzmALUdq/MamfagxaZaRk9oZ9o99js8jv8d34M8vrJBYjNOKVhUUI9pthhp4+BV7et6
         PQoRzd+BKcqFWWrMsuMofZBkpGynkAraLytakiClj/WDPNlp18PG7RpThG0DE/Eb41uW
         1GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971601; x=1790576401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cYeD1qFgi7PTbqTpFl3N0zbczvxdHg1te/yk4UXbYQ=;
        b=bs443rTU50P/11MaXOGRvgHbpUgQjj/SsgWlMQlX7KM7u9DYWdQNJc8ywkDWdxy0VW
         rsMPFiXuftbfmeEbKlE/L/Uh2ZcEQ0E8wUqYfhfs+88a2+/eB+E47AIhqMQgmyeJk3Bz
         tjS5c7vdEDLu7xGQvu2eM6qVkl3UHwrGSF5tKsMXoLOaw0ymU4a8s51zkZoQYKVvN/C1
         puxmtxMszyCC+BFbbVwl21e7/vDqyudUyAhmJTTk7TQYqOlMXReegxMP/X2p5HYsbMvU
         WgjJ7LAa7rwIj1xZKeabj9nHsaijz3iTPemrNNLs2l6NrOsnN4pm5Kxs7WftXqqi9Epc
         msWA==
X-Forwarded-Encrypted: i=1; AKwUvBwU59VxRidTKZofw/diBhOVmR7kDInKP6QG6sfi8yyLoqQSL6BLAa4l5JC+t5nTa/RaTsjl1bpoSg==@vger.kernel.org
X-Gm-Message-State: AFuF++nHlLNxec2FSe8PTHewp+oK6hLozz+PhoGTd5Gh8uSzfcXoM+hq
	ssnN4CQk4lHhJPvoMo5irDm2acUSRfcWW5r0yqn2GwY/13/LWqUtNF9uc6CCZdJ5xDuVKHDy6MQ
	Cv4PbP3tF3vD+/QdpmduTi3KnOZFBl1sg8y6AIPwWEICKu4/+5bCCJZC0XGZOmw==
X-Gm-Gg: AYBFou3T5J/qNCwkBAlthLhMDaAeDGOCnf5UBVyCdMoNgsLCYTbLrlzE8BwXmhsZ7NT
	sCHDGfn8rMMNiOXAv/1RLyzx0bkUObcldIVWwnQYOR9qRpodGrekG13Zg4ouPd4T5nTq8nc5o29
	2HjuooPi+qs1rjlnvorArhYMaV0RDYVhgszVJPvzZFTJeRCyQXsKulULv66YgcQCXEoeRPjJKR0
	srlvtsz8Xf4sd6xvfNCiRwSYwVt1Yu/jN2zdLrumHPxG+2l5JBGfBYVOrk9dLnDSGPgG9o3Qrr2
	0gVBrSh3oBWVglBI7hhrNs/aAsczxl18QTiSFVx6tQAcCNUhm25t7wc4qSUBmQ13shXgt+Q4eIi
	unTf6EfaELkU8Qp6XOWesvUcfUcLEnXtVK+EEOf3NKJzCCPc9jJHY6aOLNYTwV3yGSN9WIu1SJc
	PtFOs2fOn5G23ZaddgUJBxHg4qX8j5qcHxgg==
X-Received: by 2002:a05:6a21:7484:b0:3dd:a9a9:396a with SMTP id adf61e73a8af0-3dda9a93b99mr5596882637.46.1789971600688;
        Sun, 20 Sep 2026 23:20:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:7484:b0:3dd:a9a9:396a with SMTP id adf61e73a8af0-3dda9a93b99mr5596862637.46.1789971600244;
        Sun, 20 Sep 2026 23:20:00 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm14091444eec.28.2026.09.20.23.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:19:59 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:35 +0530
Subject: [PATCH 02/11] clk: qcom: ipq5332: add 24MHz rate for USB UTMI
 clock
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ipq_clk_changes-v1-2-d242e3d49648@oss.qualcomm.com>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
In-Reply-To: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=PaRqFShd c=1 sm=1 tr=0 ts=6ab0cc92 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=T_jLbkAMJ8GdCbUqRukA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX4YxxALVyn/Q6
 y+lSbc0/9cQurt1ii6687sP8C9X1Ir1HmLhA8z95wwPeFQGGoJW33D9OXEJmDlhSxzC1cAPfbxZ
 X6QC0d/WERiKM1Cv33L+mC5HIfWaLCo=
X-Proofpoint-GUID: X9dVCJDCDRn9ibJL7gYjHPjO6EKz-rx3
X-Proofpoint-ORIG-GUID: X9dVCJDCDRn9ibJL7gYjHPjO6EKz-rx3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfXxUiOtyiOGRo/
 Gy2vQeBfbotyeS1PwsfDY6nirq9A0L0cTYfUilnuo9RANBevO49vlchFkNefyby/Bvf1LbPh1n+
 7DyZAvs3jkkxiLokBuOvX8Gt5GtFnj4cwiGPEZzLdeajBNYjlRk6oZORT8x2w2NfeGuiJgEsk6x
 TNt2Aet6JvzN2GJMhjf67ENJRgZce7fEm28Vpn1gMv/bR0NZfI0NxACjojx2yU/rgIMszoloaGs
 zh4uDwXnWq/aD6L/cY+3HAOuCATpmXFZPYoNSWHJgKUrSuZtgALpquLvzZ9463YKNnI+npolPig
 J3X4j+Iz5J2k0RzVEM35Zyyw56rlD8cSJqZpWwQFTr4xSqcqZodylCD41NG6T5pNePuGTUgGwak
 3xqYnBnXTUkAoHXGs2xwIlhyg4Muv5AkUMYWP3leoOmR2Gx/jD2yNpcufct52iXegG30SgrKa3P
 vhI96XSzDP1eICZqvwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210089

The USB UTMI reference clock must operate at 24 MHz, as recommended
by the hardware team, for reliable USB operation.

Validation showed that USB 3.2 hub enumeration with USB 2.0 devices
fails when the UTMI reference clock is not configured to the required
24 MHz rate. Configuring the UTMI reference clock to 24 MHz to resolve
the enumeration failure and ensure successful device detection.

Cc: stable@vger.kernel.org
Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index ecd9ebeed754..4625b447c235 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -1038,6 +1038,7 @@ static struct clk_rcg2 gcc_usb0_master_clk_src = {
 };
 
 static const struct freq_tbl ftbl_gcc_usb0_mock_utmi_clk_src[] = {
+	F(24000000, P_XO, 1, 0, 0),
 	F(60000000, P_GPLL4_OUT_AUX, 10, 1, 2),
 	{ }
 };

-- 
2.34.1

