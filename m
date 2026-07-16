Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E402EEE82
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226733; cv=none; b=eRLUuggnD6YK12KlAUQOzGfvVJ1wHbKZxMUQFX2EJ+Rk366aUL8qZb/hWvWLIUJnaNPI7iicXW4WLvohi3MxzMQcLSzPYHdorj2Mkx29zFiTP1c2r67AOPCQ/wrOxZCSIDlPjc1aSPEM+IHO0exRgUKy0eN7w4ETbb5JT4zPPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226733; c=relaxed/simple;
	bh=/3bsUgW4JIhWwwr4l3m1rNpjICiTpzV83j1/DCQUvxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRewGq3KKnISeKpacuNP3zNwfUpGKhXKcLk81q+68mrnoi+fwjTRNhmvmiPOZhtVXw19KwojkWyXOYgFfpTOFDoxmvH27vBvWf1Lb7Gk9MH49RolAAaLFNNgxdjaoA0WzjNy8SRVyo2p+HiZZ0AqyKL16xGHrob/Ja212OdbMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADrAHbvo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kE3b0GD/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADrAHbvo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kE3b0GD/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GHZVN43544294
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 18:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iW2mkF4EyoOKElGESddOwINgN5E2BvggXwdyVkgiaWI=; b=ADrAHbvoEHAnawAZ
	lZeTMm8mREvOvHREmo+IIcGcQz+f+xDxiRa1bY9Pg+jTyVLi1scRMO8VWyRQpneo
	oQBAzvOwakxjSOsbRnRn498FMccwz7QaKqHzQIMp9LsuDi2QVFsK90qszsG9q8ml
	WcqxdOz8Cz/X3GSYYd4cFZ6DtNLcgGVRaEHthKKk5Xkx0YWTXAx/tB+7QSJZYopx
	S6jh0NUl4QdK2LN/Ji13SKZBN0mK9lq+kzvWuARpdA9ZgMbSW3ydsO3V+lqfaqV5
	GlhjWcm4i8kVjrh8+1sj+ULxI8ZRBUKUJXRxkRNYob1M/nLQ5qt6RNVwT74m9uiS
	PHqqZA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u807j8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 18:32:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c9d953b71so7641841cf.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784226730; x=1784831530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iW2mkF4EyoOKElGESddOwINgN5E2BvggXwdyVkgiaWI=;
        b=kE3b0GD/bXShVc4E9xNcV9ki6+UTnJMvFhGWZKrx7gfwOFYuxsXZxxpnkjmOw5skcH
         xHiIYAV6D+Hu1qTftrs1LUM/1ChpGAUUTcLtItCI7YfjKRFKHCnZ6m9f3tKqxUmVxj04
         Z4zG+juHNvg5xvk3IWFrUo54kzHFN9pgzUEmBMb8sIRM/86f8Cnmmcl6i6RgXZRYN9uJ
         E5KaYF0KHJFUKDf/OOlFJKXxRvOCbgKxgCvEa2E2JjKu0ruV42ptM5hUualDWJYYIBDH
         lYjMFwny+KXcghRakaQO0fcbZat/6KQYRUT5ARuf4GoAchVEj0xCqfD0mg5QA3grcnx0
         OsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226730; x=1784831530;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iW2mkF4EyoOKElGESddOwINgN5E2BvggXwdyVkgiaWI=;
        b=IlzIahhB3H32Gp8DGRuHPodUbaEw5pAXUMz+nwvsX+8gMKP8jz4yrELcLO+p0ZDPPZ
         d9avCEhsBnXr58lESdQ0wp3fkuHgH6CLuEKM5hJGchL/0/nt6/Wyu62k4atfCdNWX8xJ
         3XTY3Ho1PKNtYU1OWvANk2xaA8htdmwfFhNYpP6Dbv/At7snp5Fal3qCZ1CubmA2rgHb
         AR5qOjNyCDUQ5l+jI1omxuDoMYlbCShG4YK9GZ9+WMWJgCXJz+taxkBq90RNjUCE0uXJ
         87FJu5S7QoP8ZooS66QyivomTlyu/BjZD0cMfshCeiCPTd2f3SBo5C0Ek7ZzEhx70BLb
         uBnw==
X-Forwarded-Encrypted: i=1; AHgh+RqHZsmTEWoAi/PVBc5JS0++qEVPNO6wcoAsxHX6EoPSqMwOror0RSda4NDwiLstdqmzHter8uW8cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTXMYoDE0SJUvPfFTav1bGysRtAHXgvAEA0jCicQVx9laOg9E
	gIlrediB2sJSAuaJIItF3o/AAQsJDV64jz/GTeUos5wnAe6aQmFRNOwiucw/HKctY2S+5dgfdpW
	T9FGh7PFmwjCqe5akOeNCCrOJDF9NFZAlPt8YvDp9rRpi7/RJJ1r8TzNBdyqFdA==
X-Gm-Gg: AfdE7cmpuiZaKrbQcGqGM2YU0BwlAco/1e43m+R+gKxlLs76+i++93m+6IML6E8jget
	fKsgTTolcF3fCtiBukr3XLmkYpMRV6P17N7xcVOrRfj0kXSneFnI7WhgDWnNZoe2XN1csGl+3DZ
	KZgRXEkfC/mmaQtwldD9QQD5SxIcfidBjOGiUh5cEntqgHiH63qwV7GzARsxUcYjBI9do8NLgRq
	a02J9Uc/zS0rJ2unkEPMHTXOi50y0BqZlVWhgFfe5mQE/GVfV0W9gm639Sz9LehdWKA1KeoNbNf
	WMY9UyzfrlRWmseeijvFlVuX8R/k7LUMXH0yaLP5ziBw1jxlFa6awV0IYIbtBpyGpl3CpjDCfFV
	XOZzIQCNEP72pnQxFj/CkEsTK
X-Received: by 2002:a05:622a:55:b0:517:6162:daf5 with SMTP id d75a77b69052e-51cbf0e6270mr190678351cf.3.1784226730070;
        Thu, 16 Jul 2026 11:32:10 -0700 (PDT)
X-Received: by 2002:a05:622a:55:b0:517:6162:daf5 with SMTP id d75a77b69052e-51cbf0e6270mr190678071cf.3.1784226729657;
        Thu, 16 Jul 2026 11:32:09 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1687171464sm258484566b.19.2026.07.16.11.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 11:32:08 -0700 (PDT)
Message-ID: <b169de67-585a-44f2-a7b0-7a923274849a@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 20:32:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/11] arm64: dts: qcom: shikra: Enable WiFi/BT on SoMs
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
 <20260714-shikra-dt-m1-v6-10-bee265d3499b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-10-bee265d3499b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfX4c3m2Er3wAJ+
 uy15f/uxyqFeFLjIDZth7piwCpAHeNoKEaXaTNfS/dmrhsOd8Ul0pPnbrfXzBAGbu+BQAglagvL
 14KH0Yt+0DzcJzmRhD9IMAsaNqn8EyMa0zjdqee/NQW3fswrhZwAFii0VgjlFkVDh+kZmgaU0+N
 1LMHxxv/bk7qhO97OAovVl7kicfs3xSgfnXKlPgS2uI5PwsuWsQZCM+LRQ+QvNphfqQ/xgLw+Lx
 IQxiqP/aqgKcXy77dIfOPz0ivDDImkr9AUddSvlrrKTrx9aPk6V9Z46bpw++MOtFz2g0t3RNM0E
 UYG8yf5HbZjS5JGLun40CGVWbFX/2PFfQZPgAl5J/9ETM+Ghz8T4UcsVGFuNkGta0fmuN0KHuGV
 NosQrelpz4TysTa1fNGrUVrWS6eakiSIgwtunYKD5muuoj4HpvTH2GRMW3wOegI3L1KA42REFVE
 9bgz+ZXdZLk+xw9SV5w==
X-Proofpoint-ORIG-GUID: Q5SPl2GvxYsiyaaDG2vsmZoL-EcZfofR
X-Proofpoint-GUID: Q5SPl2GvxYsiyaaDG2vsmZoL-EcZfofR
X-Authority-Analysis: v=2.4 cv=VMvtWdPX c=1 sm=1 tr=0 ts=6a5923ab cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=X6UgWjF2pf8hxxav09cA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfX9AM4NeBzYJrJ
 /NCOc/zXMyXFnJKbWLnx3sBy3T5SZ3E5xV8x16iszcdSEfeeUpd6nS+bQEt9wFOODXUJieptnzt
 rfhtRj1pv0Q7J+pGA9L2IKrs4STnawI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160189

On 7/13/26 9:36 PM, Komal Bajaj wrote:
> Shikra SoM cards include WCN3988 WiFi/Bluetooth chip, with supplies
> provided by on-card PMICs. Enable both interfaces and provide the
> required supply and calibration data.
> 
> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

[...]

> +&tlmm {
> +	sw_ctrl_default: sw-ctrl-default-state {
> +	pins = "gpio88";
> +	function = "gpio";
> +	bias-pull-down;

Missing a \t

[...]

> +&tlmm {
> +	sw_ctrl_default: sw-ctrl-default-state {
> +	pins = "gpio88";
> +	function = "gpio";
> +	bias-pull-down;

In the other file, too

Otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
