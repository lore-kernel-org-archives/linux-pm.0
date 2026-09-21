Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDD493D29
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992209; cv=none; b=lsnpuP7Fu9zswfU4OOdygmal/BXElY99BAC06zkq9A8PiuIkcyGSGPOut9hqnB6ZMNLzHKCCw7E2jCTRstVcmJH8F6PKW1zHcOZtNUOP1mC1/jtR0A4azniA+7lxc/BuiLuBpF198tHy7nSBF5T9N5mksj9MeXWmxsd/vbLN+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992209; c=relaxed/simple;
	bh=scRw+GVm6s7wVCc9nPzG2SgvvrPpNiJqmfTKziigzDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpWkx+1Witohv8TlNIKktvoRBk+Tpth71xC8i1H0H/N6U5Hpdy0H2Jeeq9uWp+b85XBoLWZmoe23VH1dEOyr8ahL96Dgl9ZdiMUUIpoKRBmP0MFsrSZlBql/bd3+4l4FbevZ9IMKWJGAPSj1/j9wCTjENteiVFPOLdf8vGHwFSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OGkLbO9g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GKFxn0dZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGkLbO9g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GKFxn0dZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeAJ7837789
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LuUiIezO2nuT5fNMnrZdAnpP
	J1LY+LflVe+Qi9hbePE=; b=OGkLbO9gyndnffTpRHHgHLpbV5cjhfg+nKcTfTa+
	iQ5TftiIuo05x8opyACoMOENJxGBZ/3Xk88+FzDvmm5oK8oui4RXMS6xxGDx37Dz
	sUSufxNELrGaLW9WSwkuS9TDsT390CgC+l5qp0uE8z1BOamsnqPO7HL6VvJhmKIo
	OKmCidjWsNcIB7NGKksHTC85XUCAn3f585XpVoMgBmJGCMt522w4dhqqOtcLE4+w
	Eu9fK6MhdJKLYdc+9NAlZE5ePTgcob+OyfP8eT0FITrgXsXfSIz/vTpzCGGHGJgU
	4ycX/kPYsDs4H6MltVlwYzqEPf5VzlSgKklrRqRI/QgRSg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5hpsc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:03:26 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-790e3ca4c85so644394137.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 05:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992206; x=1790597006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LuUiIezO2nuT5fNMnrZdAnpPJ1LY+LflVe+Qi9hbePE=;
        b=GKFxn0dZNTejF/A1JgrOKgXwo7ZStSE09ahu/Ml4Dc4Vn5gZh5E1izNBZNd4VyrG1z
         B9ocngMyfBqkONzW9At+ZbW1h6/aAZs5o7ZSp1hp93BL00DdBESCs1oLCkDAbZ9hZAMK
         pQKs83UJNFSPeoVIcW+IDg6T4ivYXw55EjwpcWarLj0V3lXTcPMmW02/WbuhzqbVP4aq
         +DFoF/uzpoyCCwlTSHnWkDi2RExJ0XSxNRBj0t5L5l67MS3ZaNVEbEsG4/WsLNEIC+jM
         43Ub+qim96jiy02QApVEy+mJqg+YTZj88DYNyKf+4hl9SB995r0xejyxAAfsjKBa+6n2
         aXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992206; x=1790597006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuUiIezO2nuT5fNMnrZdAnpPJ1LY+LflVe+Qi9hbePE=;
        b=VZeFKghtyknTcTwyrXaX1CmiQbs5mxho2qah4bnfFaIxYa2FzAE7y6L8av/Gt4apb2
         gVsbyQE1RDK5yHm0AltSWsujWFfycpsWUeY5o+ugmgkU9UvYn6cjD5GntgrH0KJXAh6t
         457y7L0QfOB4GSYTaS19XZUx7+jP6bh6La7581IbNPi/JysDZbYMEvzsAX9i/62MIEH2
         s/VrJAI/QxYil9Sc0qXAREUy6G0Aeaz6U6uy97OoAWDeDv0yI90sbXDLb0torRKcWxCe
         ro8pwUZYOEsH+Wgg+BgH1j96aVs5tmCOCtgg0EwVmDKfuMlZwnmv1yYJ59V1bu4sWH7s
         iUFg==
X-Forwarded-Encrypted: i=1; AKwUvBwZP+6rGFmPy374UwbfHBwraXxLdUP9fwTI9hOlt6muxYp5H6B2mQJbiVfAE+3DIKlf6HmlUYrGEw==@vger.kernel.org
X-Gm-Message-State: AFuF++mgXo0FuPbIeQEQ3iCflDyyQPJbYJwroE+B7uI6YKXX83GVa80F
	4oMJ/cjJTLsaDrQrmKHPT47bv/HSt41UlUdTXp5grIeB3Ym8vx659UBeptSiFioq8tnavr6VQn9
	DVc8suYgs3PN5+y2zVtI1opjq+oCh6o6skp9EwbE0VL5A6RqjmOvv6kc3sQLxhg==
X-Gm-Gg: AYBFou2R31FHvPBdJIyUSxyah9DChlWfnOHUruIutnMCVSPrEUUCn9KwEFURFIix8S4
	NjQr09B8dCXgykaHPBMsjMejAkcp2r4GQ0vVgqWfVkOnaFref+xgImHW2SmqH0uZFP3gRfbe7V2
	1XhbrmkA/VVgfIr0MP5TeKScTPsvK8iJHonq61kSpWJCDjhXPf2f/Jv8jEY0It3IQ15nZY6Rzfc
	vrGSwzvJUcpLyFZGdZmrL+iR5kLr60DL2QieCFjSBJ86TGxQ+sTiuFZQkEQ5VcDO8kzNChYy2lp
	NdqQm1XmnS6sFOVQmxooDLzwDr7SebnjjXidnc4CFijKpC9wcNGTaFzE6yDJHs7EPM8j0qV5z2J
	r61VDTvx6RJ9DFw==
X-Received: by 2002:a05:6102:3e87:b0:7a7:bbf2:182e with SMTP id ada2fe7eead31-7a7bbf21e16mr1506141137.9.1789992206036;
        Mon, 21 Sep 2026 05:03:26 -0700 (PDT)
X-Received: by 2002:a05:6102:3e87:b0:7a7:bbf2:182e with SMTP id ada2fe7eead31-7a7bbf21e16mr1506089137.9.1789992205486;
        Mon, 21 Sep 2026 05:03:25 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0735c9sm222876985e9.6.2026.09.21.05.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:03:24 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:03:22 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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
        Kathiravan T <quic_kathirav@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/11] clk: qcom: ipq5332: add 24MHz rate for USB UTMI
 clock
Message-ID: <mfzlmrhupyqxj3pj2h7rhqigek2gptimcpcvtn2sk7zfzhj34a@od22z2qpdynv>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-2-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-2-d242e3d49648@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab11d0e cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JaUoqYncsU2g2DIqJJIA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: DAF8GyeJZG_C--UCs1LMi87O4HEEseCu
X-Proofpoint-ORIG-GUID: DAF8GyeJZG_C--UCs1LMi87O4HEEseCu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX+B7fPkmCm7qY
 boNhzxE10q0FgBXi21ZgMzFM8DaA2bCioFzqoThsr32//iWOa+9b8UymILUuAp7LBXWLAvWoEin
 buSTxWujFe4J9ylSiMEh+VSd7yxrtAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX1CyaA3d8++4z
 TUmCOaahhYO0JNb4vX0A7eroMvBAWtNaT9SBceH0z5CK4FwsXNOH+uupgAYuQ8NL9n7NdMlgKjc
 5NtZ7hcgnPzd9b7iHZGszvq84ELlaKyeF8PyH0SbrKBUOCKGW9gZojDCkbe9BVGzGnm1Rye0UFP
 VmwG1fIcnP9IYcWQPruyf1/PPOCyJZViXTTJK7oY++SSUsIyiX27B3C73RvlFNcoGjav0njL1tM
 io8PnGrrSq6QMSMYu0V2+0lsyg0a/myld+5Ax0XhWoBJt1v2i2GFUlalb0ddd2tvEBPTFizh1na
 0KnNeVbH3IfvZZV+xvPjzIy1TqdbQZsttY1A+mbV9fda964xcBzXWmabTjhVbdKjmHyw4Rx+RPc
 Ki/yVN4yfWkE1V9+8krWwdQJ+0hpFUtEczdu5EPHvd2XucrH4GOXaAtpzuHK7hJI2WFOWgYkMDa
 xQd23nMILBfH49kLVPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210174

On 26-09-21 11:49:35, Kathiravan Thirumoorthy wrote:
> The USB UTMI reference clock must operate at 24 MHz, as recommended
> by the hardware team, for reliable USB operation.
> 
> Validation showed that USB 3.2 hub enumeration with USB 2.0 devices
> fails when the UTMI reference clock is not configured to the required
> 24 MHz rate. Configuring the UTMI reference clock to 24 MHz to resolve
> the enumeration failure and ensure successful device detection.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
