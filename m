Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAD47DFB7
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851908; cv=none; b=ctR3La4bY7ChJ9LywN9V/iAM9PasbtPPCC8nnjLlOUO1riAB6f9rnRIlTJd65ZSuLc2SV37nzfBYL6dw+nDiy74b04aB+mx2GZ7D75J5NGODk4LZA73h+cN9wqO4eWbTeImeIEoSyGSbH5qGzDB0XacrmhF6W4ljUXybPBZ2IUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851908; c=relaxed/simple;
	bh=x3KC5gvjDTWSMf7+jkoN0GhGLGzyorgflzt4JqGg6/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBP9fXwHSn9BCnpeayfctdRXOKQBEJYHEuoMJJqsDx6cPl+7vZQ6u0OWGlQ1UMtjcaOjaQeZNUem50gm9zDTp6wY2rMaUIzVZ4l7cW67j8QKUmEpERWnwbcKM0hBW+yK33NYoUNJScZYkFRxiCjY3Gfx89rI1vK40kEncnKc9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FTfuL1y4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fPSatr52; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FTfuL1y4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fPSatr52"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAucjY3200106
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 13:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5wLrE+oAQthnuDuTT92AIEx9
	TsN3ufsAGSFIiE3PcpA=; b=FTfuL1y4JNRUKPQ5lNia0ICqMbz/kQUTwXF+iz6v
	uvMsvhIGbaXc6SxFbrE7Qq8k7ukd2GN9vWZqm1ylO80yOPjp3ZHcHCDigQBd6i2V
	0LgHPUQVtYMXio5MPI4wP7QP1StXTMcAjRwOJfsaho38+IN53O+0HC1j1AGIEQpA
	UFmqJISUzdWv2UoEsDkdb5yhIiLptVACn686Yn1A7yAp4UV8KBq3mb1kBIpLQvt5
	vHF6ZF10EOE3WOxOh86N8nyeQC5zhdqXdiRiURLRQj85tNt7IUDV0HSVIOHhoOF/
	/UyG9/xj0Q6pTxOfewat6/qbEMUEcWBeiwxjqb85EuAhzQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1quck3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 13:31:46 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dbb6b95836so19935581a34.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778851906; x=1779456706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5wLrE+oAQthnuDuTT92AIEx9TsN3ufsAGSFIiE3PcpA=;
        b=fPSatr52a3Ecjeh8+VXzivXgS1x4Fg1SoMHb7WAMYMYEYI/4QbTm+j1OrAmr/qWm8V
         pwrPAl9O850IvPKuVnG+dbHAF1DKj+pg+UyW5WEpS9zWtI1k+c52kl1CfeXMYS1iJBq9
         PfimSulJX+5zzzLPPCXgo8go7U1iC+p8Kek8+YLbL4YVkWjV26zYsz+BUQyLBvtzLyLg
         7sZw9ETPQ2SHC8P+xBFab4cb2JTO560f1BV/IX6DEvBygSovmLZkbcpHrxnREIor8nC4
         xz2VLxlPriKDki3lahVJ1dzIISx2ekeEeMPPn+7DHxUn2hifVrIugl5VssgHuCzCVQ12
         tGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851906; x=1779456706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wLrE+oAQthnuDuTT92AIEx9TsN3ufsAGSFIiE3PcpA=;
        b=DELiF9FbR5coCX99c5N+b3gzQwlP1J3kWWDdDag8E/b5E3PgnOGAzqzSn85CDchiNg
         sGdhptLPsFyJS0WnhDi6+ioIgeOVrgTbVk+eNu5dC907skLWF1P+NWmUmIq/wN3RTj8o
         R7+5ArjIt/1ElPpi4ePYU+ijqasQlJ832cJ+XtZxaEZOiZ3KFQPbOPZpUSuUBzfClMCR
         rVWaVyST9MZkVUxrtp0mqxs5HttsEYitWjzxowsQuxHIppq2JT2yN9t0e/rzAf/LE4wz
         hePUuOeArIBpaASteaqOmHuWUzZABy8LznhgsX4veR2cX7y45dBAwzan7l2WgWaRubwL
         Olwg==
X-Forwarded-Encrypted: i=1; AFNElJ9a4aH7vLBMc2L1swNsQLOmrfOT0EYk5JDCa8i0UZ6MCIjiMlavsjs0rvPft8OVT0AHni5khHw1Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUop3DCD6z7fFSY0fbckg1aW5+LV4jzGnhKRB3ipLDBuCqwym
	/jIW4jmbbn2oIkGmlI+68XgtiM15bJdLGGwAT5V1sdgm+F1qh4xy99Qa82kzxa6KLWrXBgOUajz
	37VjvSBcj0tPdU7zTgZDiHrR65A3RnYUxxJ06rphMcKOkD4S2FwtcMazFw+OPrQ==
X-Gm-Gg: Acq92OGKoNrJxnuu0+x1MDTxBcpoNT3KPRX5aRATw+ok9U5B9x43wE19lLs96dlFgaz
	TUmfT8laCjLxIeBrTq1/jfm9txJB8dCPYsRMBuHKVB9QYAfsGhbeo0J7Jye2ZZuTJ40BirHP8JT
	eez/z7BONfhvXM5ywdGuFcT04wnuELe0/HTxh7kp/EwW48s7DxXihW6LrvTdNfNIyQyJincohq5
	20dOzUzRYz18uiJVrrTK2jCgTlHcdS/iNNZ8gf5/G9eYpgTC2fHk9QVnTq63/qfgW9774Cj24Rn
	L8ZrpVzTmWiWz5E3jzCcnYOsBxKoBy0BqcbW+CtofLZhabHmFqOCcWze72yKZGhI0NN0SOcSy/T
	ql3AwP3VqAANH6FuuyCYv0ipRMqdJrd9N33CzcmFDHS02iVxzRMiGdPUEoDTyY9QJl8bFwrBGra
	K9IvhjefTDhVVy5DkKyGaC/H+QLfqO9CNfEdVm5C4fFI8NBQ==
X-Received: by 2002:a05:6830:3809:b0:7de:44a5:51d1 with SMTP id 46e09a7af769-7e4ea0818c0mr2309424a34.7.1778851905602;
        Fri, 15 May 2026 06:31:45 -0700 (PDT)
X-Received: by 2002:a05:6830:3809:b0:7de:44a5:51d1 with SMTP id 46e09a7af769-7e4ea0818c0mr2309325a34.7.1778851905111;
        Fri, 15 May 2026 06:31:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cf0a5sm1313704e87.75.2026.05.15.06.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:31:43 -0700 (PDT)
Date: Fri, 15 May 2026 16:31:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: qcom: ipq5210: Use icc-clk for enabling NoC
 related clocks
Message-ID: <5zdmbj56ndi7nrvdqadinrf3sneywft3uaplnoxugp5zetsfbj@5hazmuzyfz7u>
References: <20260514-icc-ipq5210-v1-0-b5070dfbe460@oss.qualcomm.com>
 <20260514-icc-ipq5210-v1-2-b5070dfbe460@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-icc-ipq5210-v1-2-b5070dfbe460@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=HbkkiCE8 c=1 sm=1 tr=0 ts=6a072042 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=8eC56JA1x6P3gbDAbPwA:9 a=CjuIK1q_8ugA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: _xUssUso1KUoUZFfJCxijnHEbDPlOL6w
X-Proofpoint-ORIG-GUID: _xUssUso1KUoUZFfJCxijnHEbDPlOL6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzNyBTYWx0ZWRfX42aPlHEwSJ5T
 Y68O4gozqr97J0uAt7HmQDrXCWCh4xG5Fq3dZg69lC10kQHxKUUXqnUZN1RWEmisMj2guTbtxbh
 aTmK/YqhaW5irr9sKfULRZ9TQ/UrM8wDAlliZTLAptE+10u/4eBG7tNTaBMU5nF1FIRjN/VROmW
 H1FngTUJR0mLytyVNkRm9cmcBmlD6UtmOLLreNJ10uTl33hsB6tUczCDEfocn+X2JVXq8rYFwhW
 ltwoTikJc44D48hsj2IXsTFa29abmHAIpNIiyhK7TZSFZqZI3AbuIgwy31MtJcfQdbifnM7eqFE
 s/3feC2wh2ejQpaO+x1jKToDHYMF9CNdN3iInuRsok+SldhczqksbKOF1z5l2LSVYqli2eMRp80
 HoraE7fF28AyHJNOpdPmjIoArJ5hh+tQKdMLgCxFbav2fygJGByCNAVgedl/KTf0iEnKZZxB0mL
 gIlYZzfHCKNNg+hNKfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150137

On Thu, May 14, 2026 at 09:35:36AM +0530, Varadarajan Narayanan wrote:
> Use the icc-clk framework to enable few clocks to be able to
> create paths and use the peripherals connected on those NoCs.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/gcc-ipq5210.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> @@ -2642,6 +2657,7 @@ static struct platform_driver gcc_ipq5210_driver = {
>  	.driver = {
>  		.name   = "qcom,gcc-ipq5210",
>  		.of_match_table = gcc_ipq5210_match_table,
> +		.sync_state = icc_sync_state,

in Kconfig:

select INTERCONNECT

OR

depends on INTERCONNECT

>  	},
>  };
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
