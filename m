Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4083438A4
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 00:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409970; cv=none; b=hA6gAYWpLYBjwzrugnnqhaJyDeTP1NFrZ0iGOR80opRmQYw/i6rIwZUSmoUMn5Tbf24JPa8sjfDprRQe9tiu7GxzJmt+D+iZlhosbePBFcWJ0qKykx7jq4gDwbsDj69k/+aPL07Y1Gj/kmvHo2THrb9B7XoyddwDqFHR0z12e2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409970; c=relaxed/simple;
	bh=CjQdVStJQcg91fypKE4K5Vi9xyVllTpeBG6sOBpJYuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUYdMPb0Ov+VeiDcT6c+mlyv02EdyBSSZLRnkuH1NcpL05ol95ob8NAy9epbdwM+yiuKQDgpx8sLhcLyTyijqM/NxfJ36J738ii0gVaWM+cykfZKyh+7VedLttfW4rc/g+oP/sstnF0SB9qfDszyb/2xp+pHO8fTq6Cg5MIKrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=boGzuW7d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EFyZv1ou; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="boGzuW7d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EFyZv1ou"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMqEYG2706098
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 00:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e9W/tZpD/0Zo9zxxG/FneZtf
	2PKBjRMlIQfVAZ5Cf0Q=; b=boGzuW7dpQigYVrUnFqfcAXRPzuyN5Jfba/ujZeK
	4jsBl8VnJNbxHud9+5Nj4STTW8npTbZvxDn3bLp+iRu6dcEc5cZAiSQ3RhFYjX9R
	oN/jw5h3/EWCjLrhgaRadWhSr76LSHYc0sI+9i3WefzTWE+BRB8vnjcLvI9GoHvC
	Pe8T7juXejAz2y/iUMCsB8rbgSfxx4hvIUjs1AJlIpmRNDsaeylzq1SgbZaAmLzW
	KIXeCrewM5amBg+Q/bZ6wYRsgcje/uNEUk9uVd+Ym1qjMmmWJg9PBU4bOIVuUdyn
	Oam25Filam4A8zHm3QJXDbBcAV2sTVwMQumq8mNG0lg8IQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk61q0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 00:59:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a23afcbso30454941cf.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 17:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786409965; x=1787014765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e9W/tZpD/0Zo9zxxG/FneZtf2PKBjRMlIQfVAZ5Cf0Q=;
        b=EFyZv1ouKOxipAhpXtqg5KcHX5XwFdcX1lpOYkiVR/6/LtKGRW0cBrkr5IkOqad84d
         38wSbaiS2duLhq03epEa2xCEWv2knctuoKzkUrnbtCsIreua7uj4VihE08kEds1xBwAA
         r6QKxNPCOZXWQikcb+DwxTYVJdZ7X3L4D631RRjcjFGYMC+zMCZf7Q7Z/CDRNS20BqdU
         Ld3RmndbW9rIo1/jdGDHHDn8ozo19auu+yR/CYpaN3/7/KOFGcojGecSRZQe5baZmEQQ
         Y6RJl0W8Ifl9dX9KM5JNFjPPo9VUjYfc00RRKbgCE+SWchLd+jd2SgfYQ9IZ9Ohb15S+
         qVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786409965; x=1787014765;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9W/tZpD/0Zo9zxxG/FneZtf2PKBjRMlIQfVAZ5Cf0Q=;
        b=DQ4Tw+zVP7fWT3EcZvKlJqO2oaAHs29zFaym+Chj5U5qphtSrHou7Q1KpxNlhUUnJY
         mPNCvueysHBzsT2xLK3rlyGw5CBqUoIPRXjEQG0bePArABUNAnFGm5RVTOYr9YsJZSMn
         XfN2ujwZkjcxd8GYspD+IUIQNphdMe16/Gn/u2WV97oN9kvO0XMydBUI9AKlqCv33JI7
         LTgc8Z4I5ieNcTS3R3YP9Ceu2oMPUf+e3WPq+upwIZ/5g/Nl72eaBgf9oEw1EaRYIePO
         liBbFG+4XmGAlnbybgmQYBd0gPPnFP2w3wzFHxlNt0eDUWOL1S5XPi2oxUdYJMoSRyn4
         Cfsg==
X-Forwarded-Encrypted: i=1; AHgh+RpHzmzNqPLnxVd5ADsoio7+TUT7aWPEtKHbvl/0AYzQ0bg5YpFMnVwHdBWSi8y4QzCpL0K4npREAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQxkg5hLGm0ydxd2GiO06smD2PWkZG7A/sLKAr5bmZaiw4JOSb
	z+sxWMMkx/0O462L3C00IpeLaC5yZzBeF6jXnSRMP2qHjlBk67gmZN9R0GWrz8cBZwhIYy4cMlD
	IlN4rooJM4k/mjBrP//0r1VRITeT4xATRI2gvXIdQ4H1ANsxs3cgLW+A5bvP1QQ==
X-Gm-Gg: AR+sD13vwIWP25ekpkc59ZWlGXnh8IREgbs4+tMP5VYjCZ0x4fvkZOmFXVNPtWwW7In
	xYi6Zykyw8+kHvskqhr/p8iYy+jKQwb3yjeA0dZxId3ISFtHEJHT+xFEboVd/aO8TI11vAKiqiH
	/4yHP18m8L2Yf7FgVGDv711CN/gAp9CJuYBypcQ6CHi1FrEePmDNqc/qVXmewTeaCXoKdzX9Mf7
	1FlCDsxHx4qSktQ+KDIIeYwH6UkPAFj30IpXXIka+BWFzXSY6ZYpmY2k0LJqug16v0ChiPe6xiq
	3WyC/UgUAaE3MHe5yO9ssfB8Ue/vsxEAL+dYj4CnL/xQQ5Gj/gi5i397mEd/Dl5bpff1XBqnv0M
	KkzMwlaq2+knAU9XVvIqO4aq9mA5pinZXsx8MnDcSPXdoICUBGr3RgtiGrGUiuppb05RbpzeU0n
	n9GSsGcn0MetXJyw==
X-Received: by 2002:ac8:7dd0:0:b0:51c:1e2f:1281 with SMTP id d75a77b69052e-52d191dae3emr263411731cf.42.1786409964895;
        Mon, 10 Aug 2026 17:59:24 -0700 (PDT)
X-Received: by 2002:ac8:7dd0:0:b0:51c:1e2f:1281 with SMTP id d75a77b69052e-52d191dae3emr263411431cf.42.1786409964426;
        Mon, 10 Aug 2026 17:59:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b304fd1c38sm2227656e87.12.2026.08.10.17.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:59:21 -0700 (PDT)
Date: Tue, 11 Aug 2026 03:59:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
Message-ID: <vexqghyxtf5ntmu5mpijgql7atlzhci5fhde2j7gyrw4f2tpdn@pm2qzwtefmrv>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-6-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-6-5e0ede4a0c72@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7a73ed cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=IkUaqJR2pzUdpQOAnGkA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: l1Lo0kXGuhwHt9_dE4SVEv07vhUDgFrM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAwNSBTYWx0ZWRfX5pALAm35yOca
 C8tpnV4c5So8SoEvvae6nF7GQcP8PjU2VX5a5hKGNBoxVk2paehj+uyr2nxN7vBb7iegoogYamt
 +opWIE8oRVM7xF6cHLhGi15sIKuZSfo=
X-Proofpoint-GUID: l1Lo0kXGuhwHt9_dE4SVEv07vhUDgFrM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAwNSBTYWx0ZWRfXzqMMdLEwYSlH
 aOhWzFch8nunv0/L0DccLEY3XiF2eXQRtNBIXigeYVAF74LpmBiEWsZVbX9IGL3IMS3e3HBCLCk
 h5Acw0+F+siVerbA6/sxR17AjKvutCS+BjCNwqlCR60tbsmmCPhNiCDuSzL9pWlhl1xabZHeEO6
 R1tm4YzB68SVGwOoAEGp1YQ1uJoiC+pIX8Rs+10Uz0oG+Yf6Uq+YRoGVaqoMLoaChbAPnuoYePQ
 8aKcmyIiGkdQmlX9NUDhRZf85lTWMfcLWaHY8SY9R2sbFPe92nJdltOMXsIHCbPqjHQOo7QbVE/
 5FbiYOtVBRhY11l8tp0tTyfvtLYeUVbmHfBz8UuWkplYfPaY6ElvHDgQiAJGHVaszxwg9shUAZk
 O0IAWyvJZ6jcs2S1aBIrG/ibnvsg23fBdIKixpf+PtNJdEwSp5obmJvAgwQf0bPjBEBsmgCCxCN
 BxjsiHXbRg1yWMiYmoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110005

On Sun, Aug 09, 2026 at 12:57:05PM +0530, Hardeep Sharma wrote:
> Add the Devicetree bindings and node-ID definitions for the RPMh-based
> Network-on-Chip interconnect providers on the Qualcomm Kuno SoC,
> enabling DT validation and interconnect bandwidth voting.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,kuno-rpmh.yaml      | 72 +++++++++++++++++
>  include/dt-bindings/interconnect/qcom,kuno.h       | 89 ++++++++++++++++++++++
>  2 files changed, 161 insertions(+)

Are there no clocks requires for QoS?

-- 
With best wishes
Dmitry
