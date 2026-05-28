Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BDB327C00
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950143; cv=none; b=qGr1Qbt8Pn70ORnLNMoLBiI88okcbR4/cEQPSS9F0D+Ypwf+sn+/jNZBJ2Mjr1AAV26U+ZAZ8sLYQC+vNk5KO/VxLCtIy3Obfjbl+88BTJVVdsg177scU0ayBVDqhj0gsgWPfDf+nOecthdktXyqg5oSz45YStdUALFocFmRYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950143; c=relaxed/simple;
	bh=c9lsraxF7MF5yE6tUfHnBFZa9WWpihdkME3ni/W2xQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6BdF9AHXtU2H58NiqqfplAjds2RD3AL2ODbGPwV4VT+jer5fYRDe8EYa/Ld+LzmoWvq8GhjmdzvQoCSSgGbUQY6v8l54zFLjzHecdHxwAjYceRGZ4jXwxb2wV0w/6nQWqGSTFj/AypoBhGYVcXl2h7y5NaWSm2Nz/UoHKYZdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IwopzICG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXWheYiz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IwopzICG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXWheYiz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKmwiY3197818
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 06:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ydqXkzCJxOfG9FXBf1HMLa8s
	SWgOAyO7S9cyz0soJm4=; b=IwopzICGE7TpKNQU86K1MoME3hmW3uvZHZGtKirT
	PgRpw1/wuIZaiLUyLcT3b+bpeDna2S5cMyo7aLbepYkECNKaFiXShnZPlHCjXcQf
	9DxIkkeEUIsOvHUvWaol5y3hoM4aiOKd6tZdqnaeDRngdI4oRflzaS6MDe0aCxVe
	KLX0z9MO31T0/y3bUvmxz5eprcSqBhQtVdZJhqTQ6LOt+d7bxOooirkN8g5RdZpv
	TiaHo5YupxK74ASOBrSc3SwprkvwAb0L/kW/u09Zq4JbxKLWEfB8lYdn3sqOeSpP
	H+ER9bXY+Cgarxy+7yxZJObNMTOXGIPEEOntZBQIioRWYw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynhkn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 06:35:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516d19f68acso130952511cf.2
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779950141; x=1780554941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydqXkzCJxOfG9FXBf1HMLa8sSWgOAyO7S9cyz0soJm4=;
        b=MXWheYizp3XKyqmLDbg4/eAaEc8NUhLBSp4H/vmjtjBB0Qk9v9oldN33Yrpc6fWY+m
         N7vQEqqFwMt4E3rW4gOw6ApooZrZz5Y2hTrQp3YV+VqkJUQqUy6z6hImABkvtel0Zi+I
         4DH4XpNvfm2T4dbcZiFiCIEIEvtXWRAuXFNf1tTK8FKiXJElhJzWxiBvp00pfph/Jw2A
         YrWoi7GaIelz+IFbe9PZbS8Wucaup/ALWEOwOfeZHkqOBXYvwIxjqQDIrRCmTCyNYKs6
         Mc4odzWMe+tLGjz1BnPnIQH5QjpKRQ6entUeM3nv6DDfBiAtv1/w+tnEQASdHydJnljR
         aR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779950141; x=1780554941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydqXkzCJxOfG9FXBf1HMLa8sSWgOAyO7S9cyz0soJm4=;
        b=AYvej1No2BdIDEUTcosaGQeSYTkhIlwtoieYBZjNs32qOwnehDi00mmXFx0epvUFmn
         Fo15FyRmfn0HF1+Hk4LrMEMKGGFVD1tAIO2r1zLOZw6FRtzRoO+xEZRK1QkDOUtR9/Gy
         UBaPT7hZ8v3xik6N0gmXLtCRKPrObG5MXFmPt7Gr0nwtDD7HA6MzF8qOgnUWcYJMAT9w
         DVQca68Rm1qqly2foz8EGi7JSD8JlUEHM2cazod02ni5uVs57EycsTt7Hl27rOaT3ByU
         Y2p5Fel3i0qnjgB8geUf4nlYMExb44HBUUDT4VBbszL8wzpzv2tdeDHzkorE07X2BFcL
         jFjA==
X-Forwarded-Encrypted: i=1; AFNElJ85QKHsvrTXJLu72GQBy2tWmPoACCkV7Qq21fxHtm7fzJSIYjsWwwsMG/BLjPzNUNn27Trb0JtsgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Gatjz6WUyHKegGf/c6gHUl5SiN1lhWM2iQXnEyFgis+Q95GX
	yLpbAHmjRvPw4RaHPJISDLuVz/6n14UpLXjiVXO2hu/JNWhQqmGKf7g0oo8WW0kVekWUkc0B26N
	aeiwOf0hESM9qgm4W+p2QDXwajrziQ0HsBCQVEkNXcqcDRwFSO2+RHqvlABKSJQ==
X-Gm-Gg: Acq92OHWzg/UF9j4HfnMpaCg4oQULY5Id0Nc8smq0+sQ2OIBzXQZbvf1j4vD0z7RAXF
	gL0Y77A0CAZHMRi+Blil5AEErzF+w/yFN/0wh2/BuyFuiLXL5APCAYUWmoopye/vSFRj3MFv9Gh
	hKHwS/Jb7jBEY6LswAGLL5DMrOVgoqXIaW5CxPU1m1ZE8GImgBmwWTDEtM77mc3wwZY+o4/Lg8o
	ZT4ktYwOXR4ffGkonWut3WEUwdADhJ5Mxi+mp7NRyx5G2g4+KD8V0EaPdX5INJh0c8YuotbMF/6
	SuHG9kKtq+OGM86m9ZwTglZM7DgnjPfb1T8C20ddZbCMugiS2X68oYOwkyZkDeGErg+cNyMgvLj
	CijQc87QGqlBDwWGMMDU5/010rTaGM9f4hGilK257Qz9XsYQgVVzozQHgggMjcAWZuNuROzrJEM
	8ZtdsFzDX7BUm74VfAb8aCgp27SYhSJFvVHycme7gZTp2GqQ==
X-Received: by 2002:ac8:7d47:0:b0:516:e0bc:f485 with SMTP id d75a77b69052e-516e0bcf5f3mr290292161cf.30.1779950140581;
        Wed, 27 May 2026 23:35:40 -0700 (PDT)
X-Received: by 2002:ac8:7d47:0:b0:516:e0bc:f485 with SMTP id d75a77b69052e-516e0bcf5f3mr290291721cf.30.1779950140011;
        Wed, 27 May 2026 23:35:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcaa226fsm35385481fa.18.2026.05.27.23.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 23:35:38 -0700 (PDT)
Date: Thu, 28 May 2026 09:35:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: opp: Allow optional -vN suffix in
 opp-microvolt property name
Message-ID: <wwzqpnkhdepkgl6bdmcuwep7v5m4rb6h3vfdbqmphxvmw4ao2m@efgv7wvm6cty>
References: <20260527-expressatt_cpufreq-v2-0-b9b7726ccb6d@gmail.com>
 <20260527-expressatt_cpufreq-v2-1-b9b7726ccb6d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-expressatt_cpufreq-v2-1-b9b7726ccb6d@gmail.com>
X-Proofpoint-GUID: kqT5LICnHRbYFxhmS7EgS1W74E1uODnB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA2MyBTYWx0ZWRfX+8Xz9uzxZ/nG
 z9rsGW1MB759uAJcXZlgqzobFn4LqrvSar/E/uaQ4uWLx8vsNPN4YpNjJwn4k1VMYUpboSrdqPV
 zKUlABF15+E0jWqG7gwF8SSsO3ijmqHAsShJBlA0RcG5SQGVT7nkGgfImAMQB6iELHBolpT41KY
 F7tbrvpkOh6ics4V9vUjb6tRsSwgQv23/IiQzTK5NGR+D7T5tAu2WVbedvGshO8H02a92SfASGG
 HCGF+3++V4gM4F3CDGBownlh8CFJ3ReOPY0SmUwN9ugMtTxxeSaCJ3yWn5guLl2lCG7p/T5gmQE
 gXyQHPALOcOEc/Kjoc/kTcE1DU+Re/g/1CzHSvqQBmmKQMSdq21A14jtrhSbXr0e6pX6QXzOCcH
 Hj3NQ9VjJno03MaFGKAflgFEZxUU8WnpS9RiVISt07TqITYjMB6fhFukHZQYbobssiV4nKYrDk3
 mXohI9Dd0xC6ychWnRw==
X-Proofpoint-ORIG-GUID: kqT5LICnHRbYFxhmS7EgS1W74E1uODnB
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a17e23d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=jtOVCDSMMUdUVPAGS_cA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280063

On Wed, May 27, 2026 at 08:39:28PM -0700, Rudraksha Gupta wrote:
> The qcom-cpufreq-nvmem driver generates prop_name as
> "speed%d-pvs%d-v%d" for Krait SoCs, resulting in property names like
> opp-microvolt-speed0-pvs0-v0. The existing schema regex only allows
> opp-microvolt-speed[0-9]+-pvs[0-9]+ without the trailing version
> suffix.
> 
> Extend the regex to optionally match a -v[0-9]+ suffix so that
> devicetrees using the full prop_name pass schema validation.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index fd04d060c1de..846f49a99484 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -81,7 +81,7 @@ patternProperties:
>        required-opps: true
>  
>      patternProperties:
> -      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$': true
> +      '^opp-microvolt-speed[0-9]+-pvs[0-9]+(-v[0-9]+)?$': true

I think this should be fixed differently. There is no version for
MSM8960 / APQ8064, per design. It is only applicable to MSM8974 /
APQ8084. You also need to scale the core voltages.  Would you consider
picking up the relevant parts of [1]? (also see [2] and [3])?

I got stuck because I couldn't implement L2 plumbing properly and never
pushed the series further. On both MSM8960 and APQ8064 we can scale L2
cache to follow the CPU frequency. I tried adding the driver for it, but
RobH requested using cpu_subsys, but there each cache device gets
created multiple times. Maybe I should fix that in the end, then we can
scale the L2 too.

[1] https://lore.kernel.org/linux-arm-msm/20231002185940.1271800-1-dmitry.baryshkov@linaro.org/

[2] https://lore.kernel.org/linux-arm-msm/20230827115033.935089-1-dmitry.baryshkov@linaro.org/

[3] https://lore.kernel.org/linux-arm-msm/20230702175045.122041-1-dmitry.baryshkov@linaro.org/

-- 
With best wishes
Dmitry
