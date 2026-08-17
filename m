Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7A435537
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972851; cv=none; b=dG1DEf4PFA3+KthRRFGBTx/EUArJA+soVxqVs/tW+l+13Q/MYp52Ip8OdTo/42ru56eZWKvYOuK3h5f6b1Ej2U8kU1EljPy+bUGDJ0GRU68yRXv1CvG6K83/+d3XsK6TXtaA9G/Fu5G3Hx3+WOQL4E1uWsxRPkkFNKKeWcgeZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972851; c=relaxed/simple;
	bh=jB9+En6C0wpuP3D8iuDZbNRYZSDkZeqCj5UjzMgKESs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=af6A9izL3IhIQp+MAQegozpESd3ErkvJe4mOX5LszKwJVHLOOumNcvZEoGWy2AZwvbYToFfs1dB5xZuBn8WmTRZpu6X8Xg1uQUBYUOW2xYDu9vVA2QEvG5THnwwZ9WGF2aXCZnFjAxa7/egS8dSyu+GKlDEZKi/oAZ5yFoFBe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iAgyUF+3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Obyrx0w6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iAgyUF+3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Obyrx0w6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD6CqB1193610
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nZkwYYTlqj9ZHjP4hcwD6T8+fMjAx3qby4LJRy4G7ag=; b=iAgyUF+3adJhRbYC
	QGE5a7WprO0TC42n8ntx8pOcHns3jtk1c/RdvleDXLbxWyeuHEAWKExP26f3WpMJ
	8WuOH1KfektebBJ0kTeGsQJ5ahf08nQBKQzCk4z3gqQSwk9cRXKjC7oB91OGLH8M
	YM/UgjtyiBWXxv/Cu5nUZysGxtMMICPBVUFddbegHqK5WQ9KdrHVFh0VVx/0xTZA
	DjIKyaG5poFrRzlkliOuPRsGw774QCZE7UYLui+fuPYutBSkG+F9WwJO4RjJln8h
	ghPjnO0h5P5jBGbWi4d+4dfFNeMs6yg3HsvqVkKFqsy79AUYn1Bxh/nHI8SNgU4v
	nW9NqA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wke1ee7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:20:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51cab6f7517so2011621cf.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786972848; x=1787577648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZkwYYTlqj9ZHjP4hcwD6T8+fMjAx3qby4LJRy4G7ag=;
        b=Obyrx0w6MesthIQ6rULf71kIpTq4MGgqisZyPlTF/ZadMaXVyhco1FV762gQEvxHNs
         RTKS+sdTTt9fMnGsElkCU1YAq0FK02KQROINlAFg9pmGXJcEYjnFZOq6MU3wLSsgBkDS
         AKzo63HNcdomf6N4JqGZwg+HkJcRWZoonphzbBDg1kkS00+MZo8IoLCE1PhNwy9Sf5VL
         YvNe5ebqSdkXVvUZGcDmREwWbgSI55vhOX3MM+YsoVDTYvd9fxmFsisBc3YLmL3M6oTV
         P8UsgrcbOhEyUmZYQ+xLdomKPfacbMn/ng9v3S2cLbirbtzRn7xHTrtBLuR3G9QcHT7Z
         NJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972848; x=1787577648;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZkwYYTlqj9ZHjP4hcwD6T8+fMjAx3qby4LJRy4G7ag=;
        b=oT+/8vHdrcKdzwVE29zhqLGyYUplmzcLkGBCp5HOXiEoIBFjXkaPPrR9PD1dmLQhGG
         4t7JIEF5uEHHiBEg5ScwiBmUv2BUXPR05BTDxi/2drNg6+5MUbUpyh48dxVlRtWdXuGm
         GpnunM/+1exhWo78ctqBrOF8/skHP8dgyxhmrwND5Lp858ggqkygMIvbgS2D8+yzCkzj
         6V8mg+e3FqbkIlrbCIl9yAVD5DjMvR/Kl0tvjifovFC+tcaZLo8GK2BUZdAs5C5l1Cvg
         h90qa9PCR6t5F3pxkTqfG8ONSqwblA+8od42or8c2QV7i0CAvspqjgsm9yKp7EFcHnzH
         MoeQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOlWhmf7++KbWkUIciEPTkJw25TdUn1prTLIKFfdyG8Qsb3jQ8nrwJHrI5U5UZdsDqR88DjJFljg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwATBEq0ImbX8jEemX/IcTU25NtmK3p2ZKvzxIQTb9qYNtGNwNV
	06WGVplUiUoQOxRBRdOhPIoCSwSmQSyxNP9shZkzpGlRF92i9OiDYrRIXtk6graDc4UGNNDI7cU
	WPrJTvfIxsHyJJJId4Cpt807csT/XMF6Ul434x0OD3zMCuXhx7y0sgoTyKXr8pw==
X-Gm-Gg: AR+sD13SdJ5+qE3At3ao6hqdWv3tPciK8wjSQ5wSd67ewLibSCz52h7m7L4l/BWf2Mi
	Yj+4G+m8s75V2D9XBJf1Cwul+SYDH0FZj2glAqF8ymoIp4z2vuBZKqP7hC2Ho8U4LyeE8o4vSgU
	71JCSyTr7Be7kO+TRiHGkuc0qEoDumHXDkSqXPo1m/GbjwW67PDKGMB64efwfNbvJK295C+MWsN
	bW9ALlOB3VZJ5IRQAZEBMvNeLnHZgxI54q7rY+NOyOHP8ZQB53GvSxOqXT3hpHUsXI4aulILsne
	m1bMAMgOT/HIKQVtWqPd5KQLr7gwrBGgsZYsIjraErbRNA/2+BPdjsITWEe2xVDBaooB4P2dWgL
	oZR0eDcFg9VOuiJ0SDZxINzFO
X-Received: by 2002:ac8:5fd1:0:b0:51b:8543:cbbd with SMTP id d75a77b69052e-52d852d1178mr188197861cf.1.1786972847666;
        Mon, 17 Aug 2026 06:20:47 -0700 (PDT)
X-Received: by 2002:ac8:5fd1:0:b0:51b:8543:cbbd with SMTP id d75a77b69052e-52d852d1178mr188197221cf.1.1786972847102;
        Mon, 17 Aug 2026 06:20:47 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fea1e64sm60193666b.21.2026.08.17.06.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 06:20:46 -0700 (PDT)
Message-ID: <a7a7257b-b1df-41d6-bfb9-9496f00bb25b@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 15:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] clk: qcom: clk-rpmh: Add support for Kuno RPMh
 clocks
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
 <20260814-kuno-soc-support-v2-5-3079794f0f73@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-5-3079794f0f73@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwMSBTYWx0ZWRfX03+RL16o4SPF
 rmgUZxUPYAF9WnMPU6FWizi4GRUfPN317xNgWqpBw2B85GSIviXQDx9LC0o7WokxMxpwiAyp4U6
 lE7yD5URPIqj4Lmkiqn+UlHBYsHGTjgC6Q+h4fhnWnY/fPNYijxhlO8mSdJloCcegpqTzOYqcMi
 fs6pyDlpUArHnBHrmvs+TCJL45JSjz58hbWMW21OjAXw2XQQJzFWZo1Br8beI7zbjbiaxa1/0bi
 7HGzrBWDHIjeDdI3RblV3o0xt5X178GFWL6zxCdXeKTob4pyRImzRKAFKye0QsMZWaXBFQC8b6o
 p4QL7voW7hzX38+fHVCh5wb7gU85njpPeeOzjU3C6gFWPR6uuYfW67wwszNxRrPWwrO7/gDVDGR
 g1PskaMySOpMl7MVgmSrFqc2f9t7ZqppmZv6BS/haxn0eO2VWTzo7nDDdgqGw9rqbfN4TIn4urS
 Q+Gw+Uz534uhmaQmgew==
X-Authority-Analysis: v=2.4 cv=QetWeMbv c=1 sm=1 tr=0 ts=6a830ab0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-YGGs88sVoTMC7_f4VAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 8V6FEw7_FhlxDEn1LDk8B_dRgK2-9Fr3
X-Proofpoint-GUID: 8V6FEw7_FhlxDEn1LDk8B_dRgK2-9Fr3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwMSBTYWx0ZWRfX0STI4z68kUdV
 LGu13dSqs8/8d2mpnHoHYdsp45TktnlnP68nozJ3FjR/lngAEV+OYdNlDtKwPJDv4X48NEWGIMA
 xvbC8k9wOxNiP2/Zj4kZ/Jg4rJzKY0I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170101

On 8/14/26 9:31 AM, Hardeep Sharma wrote:
> Add the RPMh clock description for the Qualcomm Kuno SoC so the
> qcom,kuno-rpmh-clk compatible can provide the RPMh-managed clocks to
> consumers: the CXO div-2 (and always-on variant), RF clock 1 (and
> always-on variant), the QPIC BCM clock and the IPA clock.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
