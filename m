Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233A470851
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421388; cv=none; b=UuELNr6XmbThqG5KXUt9jSO8BmvaQZdwYcM+Oh2h18CcQd2QjQQUhPlnZXeNGeQ+g4dkzTAFjff+X4ZIioD+jYgm5spaIg7UdlqSt8GBOuJh++704PNF9GA2Qo35Vmov/uz/aIInYMyVbFZ7k13kMv+0O+cSyVtLbOcgKpHuHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421388; c=relaxed/simple;
	bh=+GAH88BEs7qm1uxKmCt5sqiNxC6fTV5X/ULDPMR+7kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBY6HwscwURm1YzGjysEUXN5D141dbJWysQL2xWf4ehXbIEmBb61V2i7SG+2PdQ4VJRo81CkHzTkJblJ1Oh9tScHzuE7ByxFMD+8r7xRGZEffSJXnNyvAA/xMaM8sHOGcHnsRgiq/2w8UEFTdSAAwEimjT3MprtsjP78I9COlWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c6cdbxuj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iq+Dj/Ww; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c6cdbxuj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iq+Dj/Ww"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE0HoZ2971440
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5Ep23zikX9zOjtrHbiPT8GoS
	ROPPec2bJyAV/PUp9eo=; b=c6cdbxujjpe6oL35xeCwG/aSWiCenA7WxK7b6rFm
	wQVfB9E1mGFkd6FzjQLvHW0aTVculCKYVeEXVsdqoiIgYaDGgThpK3W6h5dGHuTt
	5cK+kdguJrob7SVYmVJHrb50b+oVC53kFu3QSsFPbkVzAxyisKtOjVNU5DTTCjTC
	l5wwQYAr1UckCtJ27bR6RFuPDPxFtKy+7b9YivJULiqVX6ZPU83CVz+EifXSpxDI
	YIvRyTvtecb7LGKb+LKDzlEIhPLKKRigfUUUyCBEIfkTVbGCqYVoQzXhUo8uqtTe
	U4ZxVeCxzfrHo9zz4XRnLFZKWrRuIQ+yh6kh0uJXl+rMeA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x9rvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:49:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so498112485a.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792421386; x=1793026186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Ep23zikX9zOjtrHbiPT8GoSROPPec2bJyAV/PUp9eo=;
        b=Iq+Dj/WwosxA7wZIW8UGDydYLRexBODVi6G5PNa9L6VNhDNoNUO1LSkNp/+pKvk8m/
         3rSTXj889OmS5R9T24xQugPR7qbhc8meOW2OubCRx95nA/lfEwQh2NkFNFJCJ3xkafmQ
         nl2eY0v0BdmDirENRjiHNaCnhm9sbWzCoTy3T04rbeJIeYbRz9qOOr7+xlQu1pN7JKDa
         oD47hRbJBcB1S9GsfNsQSFi/xpXDzw9cR9BaXg/0Kor4uWbVwVjACvjDpcIB8pGQy1TJ
         6foUKND87FoTHezy8KvWKFtTLY8d7RaU/LGsGGtnwFhH/YlY1+7rE6wspdoMQoDn6e2Y
         jAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421386; x=1793026186;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Ep23zikX9zOjtrHbiPT8GoSROPPec2bJyAV/PUp9eo=;
        b=A6MpWo4DZnZG1Erkpr8ca1Q73c9BqmA/N3zmPX9qiAF+2u4INd3TnHMkU9H8r1Uy+H
         kr5zoBiCqC4JsGBj7WWErUsEMpO2Q6a1JV0xag8cz1p7OIh80jvwRrvGncMQdVhoxu6B
         usq+FT3fIRjp+3ySyw/5FzHbZVBN3CHsyKcPT6pRaAfK6/4z5FefMoEQJNYrUCHQDqOq
         72v4LFUuOn9qqvneMU9dFNBAAkdQziA9AmKcSZ9TD0MsLyM7A0snBkUhHw2pHPdAvUS0
         MQhPllsWca601tWf1hADEp8Y+ActnH5Xr6x0dLXvQAkrudsdQezI2Pm1cqGLODVQVNJ6
         cqtA==
X-Forwarded-Encrypted: i=1; AKwUvBwtUBtN3j6kHczpUSr2jv1p11WcMq/wynCMdJVwlxziYM2M7qYR4ER8vIBxucsuFWWZ0TAPSEucuw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJOdniLKYbQbmUfqtq1LSqVdQV8wz+CaLfVUzYg3+XH4N4obidc
	iES9zfArEUZdCg+/PqsL7AXI0T9LwoSRvgYOOUf7VNDqg9yW2f7wQQGHWEmMjYL/nMkvKufPrZb
	iLrKwbzKP4g4ZgnWsFAicPDUvSc6GmQP6ty5EM8q29Q7jRYs/Zz4Auk8OMJP2vQ==
X-Gm-Gg: AYBFou30nyFQDSz/n4qBYEXP7PvL13GagA2KwRApt2lv7M97QQxdfqsrMLgSrqAYoPI
	pXju4XU2I114iTt4K1PMg6PqNDNo43kIFXx8cWcOwxeyKgtkuweQ7U+bgKYdSjwa0SpfJUmjPTk
	mBqrBKcmjIN+fS1PKZzxCFCty/BDCegIP0n9jrUG/CWPea7bV+ifoEvGJHbKptpJILBfXF79MFD
	hQF04GEJFJ9zcApaVwdNe2AeaYHtRPlu0234mEa0DgNeJbDajC8zfEkZcSXHg9sWkDoi1buTIsX
	ZclKsBaMBWtQKHGYXEXD5Of+hjS/YLXtJlk6DZ0oiMtwhhbGZUGuh6U+ZMLkHl1clRhT1ELDkbg
	+2JH59f9YpgzA2ZTEN9kYV0h1dqmAe3etoMZngIcY73sumKrkvRPRTrVyOigmxwmiLdprWtbXC+
	XHHql/qJpb8cO9
X-Received: by 2002:a05:620a:d8e:b0:93c:6f0e:8468 with SMTP id af79cd13be357-93f29ceee4amr1368541785a.43.1792421385522;
        Mon, 19 Oct 2026 07:49:45 -0700 (PDT)
X-Received: by 2002:a05:620a:d8e:b0:93c:6f0e:8468 with SMTP id af79cd13be357-93f29ceee4amr1368534585a.43.1792421384904;
        Mon, 19 Oct 2026 07:49:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a6380f6sm1978836e87.63.2026.10.19.07.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:49:43 -0700 (PDT)
Date: Mon, 19 Oct 2026 17:49:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] clk: qcom: camcc-sm8250: use icc-clk for camera
 NoC AXI clock
Message-ID: <g56qnvvcuvih7pm2lhkppvpbj6squhwyi6sfvahw4zvuqitrkj@mewzkeerabm7>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-3-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016170701.1504338-3-atanas.filipov@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: zTPtVmewQCQ9LAD3iIvK3hSr7jd9bman
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OSBTYWx0ZWRfX1v91f/7q4JI9
 QxzFutW7cOJqugaI1TwxaN8bVJtQrRHFoNTeGl6c1277gh+liJ2mb+57j7j77JSlS91/DDJo+pm
 eYMs3ugkorRHpySO0I+G2XNwTG87ZHM=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad62e0a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=zF8lwYezSTq--4imPpAA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: zTPtVmewQCQ9LAD3iIvK3hSr7jd9bman
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OSBTYWx0ZWRfX+QqsSYsYjZj4
 wqaGlmGoJN1LIkIKt+t6FHxFq1Gr/qxzC6CJThzwMkhunt01NlmvEQKdRqCyGQZVzoc2VoHgx8W
 zB6HCfHMb1jEhl4liSSD6oMxHsd9fdG0PG3CkemhRxRkhIHk6wYyIMc4++lLf5iyjDzjc6BqIdL
 SdkhJrBONz53eDfplKEV7jC8M29Sm4Z3JXYBiLvx44NKdensJ4a2JteK1B8s25yNDUvHz9wP8u6
 BnWPrZOmGmwJKklLWqThOYnXrVC4w9CKfdnIzPDJNIdK6iH193CmEIWcz12cdh2QAS2U55m9nxO
 60/q5zkwgU8Q72KaRaFdxJdT14Z0ALomXJMWtYNtJvrGaTZcq2c6ie/V3JyjfLoTLNXbqSDU4mb
 qbFLhZz4YHhildshde3xumyH30VQ6I9/9ACrumCntFV8+FM6vHj3OjecMcTuRD2LUfJd9ciy5aq
 ay3ObgK9D+QuswvAniQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190059

On Fri, Oct 16, 2026 at 08:07:00PM +0300, Atanas Filipov wrote:
> CAM_CC_CAMNOC_AXI_CLK is shared by several camera blocks. Setting its
> rate directly from each consumer means the last writer wins.
> 
> Register the clock as an icc-clk path through the common icc_hws
> support, as gcc-ipq9574 does. The interconnect core aggregates all
> requests and the clock runs at the highest requested rate.
> 
> Use the RCG rather than the branch: icc-clk enables the clock at
> registration, when TITAN_TOP_GDSC is still off. Consumers enable the
> branch themselves.
> 
> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/camcc-sm8250.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

This is a nice approach. Several quesitons: if there are multiple
clients, should the clock track the max of the rates a sum of the rates?
Also, this clock needs a certain level on a rail. Are you going to add
the opp table to the clock controller or to the devices which use the
ICC?

-- 
With best wishes
Dmitry
