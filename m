Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A971930E0EE
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183722; cv=none; b=LmxecKV/CKpNV3/as9cVCA5+BvaXwCZGrgu4ZKoKY2vRLB9aAw5+uRgxMYI8+Efw/yzQfbDG+4g5UzZpOwCys8wC0ZZ+KVKujFk1fKagwydIi8lsZAG0qigrqAK5FQdtycQlfhZAVk5exXn5fhZSc667XmprgJbaAlM8Y/WS+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183722; c=relaxed/simple;
	bh=XJQHz+fa69hLNOTfiaj+ntovmW7NecNwSmoTYXDh3Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G26DjiSusGIWgSd3UAVs+m40/ce30IdYDQlrBKAdAZNLsEYrS7PKSf5s54tDoul6eCSAty8hwMqHZ0+Dhc6w+hvGqMDioBCTlHRT89JT4DDxMemgji3k5wPCayJCWV5OyiUmoQlzVKsLVILUbwNuaAlA8HrZjdE7zVEXJWULOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nFQigi6h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XhyYBeNO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nFQigi6h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XhyYBeNO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6950xvFs4060136
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 07:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	44lmmXHu9OxWrvFv/Dp80+DaLPYnkIgWKx4lSUJuz5w=; b=nFQigi6h83zbdwZB
	Q2lq1gMOxSDy9X+GumLh1Om89Kg8/fsekKWSVD1znW59LGUVSx6HotCur7pAY1Kg
	1kPr6qv//09ZK/WzLKTvsj9ZHcMQjnkLD+gAHpFYqgy2xt+EXnRByJ/98kYNLPh3
	ufLT+QOYpTPb+slFrKde1nfFnMjZ/hGkmuP/bg7mQb0cHdyYEwpCB1K8Xl4avrxG
	vV3a4gEZQtYBSW65dg6o9xJdrqpaGRH1DKHA+mphS8EkXr0peCVgU9P4cfqq175T
	ILL0nvw91O6Adfxj+PN5CGE9OUz5MmELhgR+qqey/wvZEO3f9LpyWyfilJLCj2I/
	LNbMzA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gn8s0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 07:02:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc0b31ecaso325332985a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791183720; x=1791788520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=44lmmXHu9OxWrvFv/Dp80+DaLPYnkIgWKx4lSUJuz5w=;
        b=XhyYBeNOFBq9dZ25dGXlYITon1dWz+uJJR3g3qGb1EW/hcJATBOk1wTBdrFviSDUL6
         aYtG+1wj4fRXOh177J6f4B4n4FimIkUEW1aChmoPH8OEf0sm6dXkHe2vIfexfQuuWxkO
         lLqPGpe5nOWp1JN1oDB2Wg6KoUoS+W1bRAbkdIULfoLWMz0RpetA9vGAism/GDMRKXjy
         Tz4PxXbGYZC5VDsTlSAH5mr+Xtxa/h7x6w/3eu5UOPAtFaidqyzX+PWRcvfZ9fmlUk1I
         35YsQyzbv/Psla0zwiVchfBbOmZjxPu3n+N6ENbQBez81U/jB8acgpHgD0+uQ7NjjIOi
         6RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791183720; x=1791788520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=44lmmXHu9OxWrvFv/Dp80+DaLPYnkIgWKx4lSUJuz5w=;
        b=E2S+wtD2xcIdMGJahwLNRcj1mPLCHuZi4FxFD/O2HSTg/u5niwsxchHSgNyanBieN5
         Ghiqm10fUl560S3JvKYm8xONNVNJTw+2gUuZ13MuyDVZGOElif32nJjsH267d2o20HxZ
         c3YMHbkzZH8HpmfPaam91RMLuDTJ6L4zPp6lOPeLJc6WsWt1WG7vdkeZ4eMWnEsMcMuw
         jygxRVJtoZ5ztmWSLNsvClCg0Gq9GeJmtnEk8mphirzK8FO66Sz5DQXdqUdg8jN6XnyB
         imIUhBbSV+ROB88q1L3aX9L6WFh1KzwI/bAuuhRDj+IE16EFq+BLY+vZe3R1YKXIXsTD
         gnQg==
X-Forwarded-Encrypted: i=1; AKwUvBz06vGDy3JwsYJW//h0c4IlMB2VkXEIIAA1nUoJ8mL2dxdMx2PgBV5mh0p9sOAPw5jJDDnRLxgcuA==@vger.kernel.org
X-Gm-Message-State: AFuF++m6wnGX3Nk4X3WQ0yMhz8LIR9e/apQXmDI9Z23YRkkLpUegd32a
	ftkyLQc+mIriC1NoxfXwiMhr1W3u1z+k+/foOsEwuTsKi3zB75JWJAtKHzc7YXo05milDsKd6e5
	0paeaAkEmi5MMTI2z5Ru0KgpC3JuDB3YW+Lwwsfrv859SzLDEhLPLK0/aYNDcxA==
X-Gm-Gg: AYBFou33OtAxVkzHnuEUccHWrwBSUxkncA+ITI/+nv8qpQPkX6uqxEm26qo5TWtyJnd
	1BCL+xExUFcX65RFHS/0pLE0ZCEwol1YsagmoANLAZgaBHPg7XPnTJ0TfTkaGjb/WWUx2hmXDuF
	Y40kwZ+wQ19aozGYJ3j5oozQ08Ls4V6DRxdbaAh2Eg4P7h9D5OA8kr6FUIkNg/COHZxVkR5N4ny
	cBQUsyjvnhYEHPjaP6kDZ9+cpcwYMzHVujj9rJriYkY7swLD1DT/OVVfTQnvq6CYPlV9PZYFD4j
	wucuapZZwX5SGSWO+fwKuRahX5q6W0mW1UaM1P9y4S+wx/z4VbN19J4hMjZ/ds6rn+EK/fswI44
	LwXz9bg93ACd+voOgmbDY7J4PmT8dUhGFOd6N61gjyw0nIbmm45FR1FUY4NPltb5DwaU+vfCfaZ
	uRODUiIQVimhSt
X-Received: by 2002:a05:620a:230e:20b0:93e:6068:7e8d with SMTP id af79cd13be357-93e60688896mr486489985a.10.1791183720101;
        Mon, 05 Oct 2026 00:02:00 -0700 (PDT)
X-Received: by 2002:a05:620a:230e:20b0:93e:6068:7e8d with SMTP id af79cd13be357-93e60688896mr486487885a.10.1791183719641;
        Mon, 05 Oct 2026 00:01:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c79f7dfsm2903284e87.58.2026.10.05.00.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 00:01:58 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:01:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: power: qcom,rpmpd: Add SDM632
Message-ID: <zk5ujmwz5jfna7xzqaaove745lrcarqmkqua2hswl7e4mnme5l@q4ik5vuav3a7>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-2-95c47d0f26cf@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002-sdm632-rpmpd-v3-2-95c47d0f26cf@mainlining.org>
X-Proofpoint-ORIG-GUID: z0ng3AhXVF450R2b1-_uU-ajhWAuB2sj
X-Proofpoint-GUID: z0ng3AhXVF450R2b1-_uU-ajhWAuB2sj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX1Wz+5UqIPDpg
 hBv3BdD2MfNsQcwzEABZhwaW2VQR8FY5eqGBQlOLsXN9vrCfiqMAWTi8RzH1OaAZTIDq4nWnY39
 YIlcfw257hR41u3AzystbGF0+yrsBggA9T+DMKltM8ZKMe6zR67Mjs7TEdBzeYhRRYVi+Ww5uQJ
 M4M3jRiem6faGs05LL5eABoQHvTMWA2ohBkUesSZ1X6zKsGGx3cV39GaD0Ps4ZikW3VroZlcJDy
 SwQ+WWi7li8a2CPdf565Eva7R89iO/mCy8buL1yCekUwdoOMOJQO89sBSFwlX65SxekrC6r6lPc
 FiVx3qvWumu0wYXlAZv3W1WdY4erbs26b+Grkawj4PMYDFZ26DhwkgCYub9lqbR3573EPktVsJ5
 cKMdzmTLsVdePeKZMIVDKqJi+mMwTx/ZGDfgsJyl0dOiU/vrYAbs8ff1qgHbKIDj8SKd1azycEf
 cm0y7V4NssAQJ/qYFXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX8DRZyTuCyLcq
 MUCz3d6uVZ6zdsHqdXWZDvRGjkl+s48jnKkBr3Buhqdrli1zedPrJuCBkfEiMwF+wrhTWaHDhWp
 Zvjqdx3HsAyt7MrqybxBFfinraYiuqU=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac34b69 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=OuZLqq7tAAAA:8
 a=qZHw2mh3vVBxtvyT7EIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027

On Fri, Oct 02, 2026 at 12:38:30AM +0200, Barnabás Czémán wrote:
> Add compatible for SDM632 RPM.

Please write something more useful. For example, why do we need a new
compatible, what's the difference from MSM8953, etc.

> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index a70bfacbc5d1..4b263a982fca 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -51,6 +51,7 @@ properties:
>            - qcom,sc7280-rpmhpd
>            - qcom,sc8180x-rpmhpd
>            - qcom,sc8280xp-rpmhpd
> +          - qcom,sdm632-rpmpd
>            - qcom,sdm660-rpmpd
>            - qcom,sdm670-rpmhpd
>            - qcom,sdm845-rpmhpd
> 
> -- 
> 2.56.0
> 

-- 
With best wishes
Dmitry
