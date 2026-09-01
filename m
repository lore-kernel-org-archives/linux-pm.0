Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30223241686
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264151; cv=none; b=u6mQOjJCnsJdxB0rYF1zbN7igChvnVRaqFWFriRr8botujst0xmlTubJoBmP/9qPFpxbL9MglW/P40yf6PFiAU8/z5ZD39KF7M2JhNmxGFL719hIvDkrNMEVmQdR7RUdxY1aFBaa005jogMjYpYSlEIsZvZH5cOvxZyYvUoX9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264151; c=relaxed/simple;
	bh=Y+YY7fuD9LrO+Sd+3rCyEQKeYw2Y27X6Y7IIOYZzetw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqHcVBHWsupnwdIIKnUxuqlkoofq/5NCliepLkCHlhUglQ6aj9FcDSc5MKvIcYtYIRDgZ+vAdvOta0bQisnb01fNeZDfVpnM/mlqylcWfPDPS2ePHVcn2EDAbHoEEaXyfNmsEu9OBPVm5eIxq7dTYfeEdCcXN6hT4cM4/0qwLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZESKSub; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jL6srgbr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZESKSub";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jL6srgbr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJZ2U2323289
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 12:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xrSaMuuxA+xEooVjCUF3b9ip
	BwSv1171iBrFkM/JXB8=; b=YZESKSubBWnr1uIUSJ0VB+PzUVtwyreIdwksW8eY
	5GKXgeX8Pf9Q1pXkm8eosFuu/5oE3W8SrJK+W1uIw8o+vcQzmqNa4hHf8qXGUu2d
	DbYLjKLlXjLuq0ajvWg+NeVnBHy7sovuCWRe0ar/9myDh5zr2gHscS8/nAyTcDmN
	Xf7F4roMl3S3/INTqSgaLJNmLMPyGkEXw+eRc+KbENx7NRqUSI3FNIOEkS9+IS5G
	dI+mkMEIvq3xm9R3mDVuORyVeU7DRmeU9sTuN3/AiiVpEeLB/DOfni8kks0eJLK1
	f2n//Og94CFv/ejIr89i2IinnEDG4ucyQ1cOP2mXg/fd7A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7ca9kb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 12:02:29 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-73883529f72so549470137.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788264148; x=1788868948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xrSaMuuxA+xEooVjCUF3b9ipBwSv1171iBrFkM/JXB8=;
        b=jL6srgbrZdcpF9yQn7H5BTtqP9W66sHooZVpB8GeaIDFx1JxURoFShpshPnShqqdYR
         vC9VG3FHB1mlcxUlId4rSd5GXviE/+RMGcfOuJ4mx5+70QSxvx6QgZ3xXpQX+G/m9RiC
         1D4GtsBNwj8f/YXPjoqvr4kCiKF35RCB5mTrgELvrzLOxt9J4NRBdiJFbttjbrwBbLaX
         sFwAalfe7bQ73P+VmkNEmuPMutn+fhM4Rp5pXG9ShSyUoyUxYADeSRg63HRdDlIu1tw3
         0UAevfJtbSTDtTd+U1O9lp3ESVQ4tdDLKOaENhm2jgZI5oBm922ejO2niU4b+GdCvMuf
         ZNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264148; x=1788868948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrSaMuuxA+xEooVjCUF3b9ipBwSv1171iBrFkM/JXB8=;
        b=a1ADhyDu6qRJo/RC0bjv/Vsi/UNBNMSz/rUjrHMfT7tCCdJvT0cLj552UWz2VP5dKP
         4Vvzv0/pUBMIsyp3FD147lxFGZKxhI7xy0k+oeChDULfLG8E0p7sG+jojEGWTEnk762l
         aLF7vM+eXXgBcS2sJHu0hkNa8rTLcBEp0NZmTTr5ZhwtLdB7pOTZxM84uDy21HX3gLWM
         fBo6aqOA5c0B2WNkAotiHNfHZpNJBgsci4K4oryQ7dwS/iYL67LSyFNnspDrp0mC1Tn8
         R+VHhI/FdtT/2M/NagdY3awxCFGoksTRR9kUH/VRSBM3/fsox/H7B5NVYQp/O335gLQ7
         KszQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzIQlXtybJuLRZjw/kWs9KcN7cjQSr28er5gdv2XSz1g1peORuse9tNkTtPqjKRCbkQQorjRbQFw==@vger.kernel.org
X-Gm-Message-State: AFuF++lVaNcImF0xBzr8LwpJI9aXQM7NVD0ZH+/tTNISAZZKXs11jH8e
	ogpsxdgpN/SL+8jsZkSwB8G7izVvMRh4Yo8tr/IplDPKtYNBiynHBr5MrjP8i+o7eLTtJgYUs+p
	AYsmcqkSzGzeBZe9fUlgBHX0Gh6rblqco+RPqNuF7wPLXxydPsl08c4u+MvT3Ww==
X-Gm-Gg: AR+sD11CGzIr4fNowzVXdfXIgq8Dy22zcFBrbMDV+OyieR843894Q4QWSC9kzhbkHsS
	17axugi1nVxfCWsbLNlUeXieybRlZGbsmiI0v722V8RxQnYvaiHhwBMX92BiQRWiprvQ2WuoWFY
	MlgFA+FbDF7RkKTcep8F5q3tqb5JBXkBt3fvNw6/6x9TM27tUTiliwQvkTvPRJzfxwxCYfTjLwP
	+kXBBP5D6nlPA+wdhaOAc14tak0I2fz7CfZfDrTaXKk6EK0HHHzDZzuxbnGrW3Nf4vUGL0vC96K
	YQsTZzL0PoS8FBRVLVgM1etE/YHKKW+47uhlYcm1FOOLPS00v1/eTsjp+7jTdVyKYtAX69BIEQg
	dDjtvQAFqxkRYLSw=
X-Received: by 2002:a05:6102:c10:b0:77b:28c1:210e with SMTP id ada2fe7eead31-785967c8f7emr12106831137.1.1788264148120;
        Tue, 01 Sep 2026 05:02:28 -0700 (PDT)
X-Received: by 2002:a05:6102:c10:b0:77b:28c1:210e with SMTP id ada2fe7eead31-785967c8f7emr12106780137.1.1788264147437;
        Tue, 01 Sep 2026 05:02:27 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce18dbae2sm18891085e9.13.2026.09.01.05.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:02:25 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:02:22 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: andersson@kernel.org, sboyd@kernel.org, bmasney+clk@redhat.com,
        jbrunet+clk@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org,
        radu@rendec.net, taniya.das@oss.qualcomm.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 00/12] Add initial support for Qualcomm SM7250 SoC
Message-ID: <prxk6xpxeoebz5da52a6bjgmaaop6mj55eemxdm5cjxm276tyi@jfeziqcrxtfv>
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901092447.3028-1-sreeshankar0910@gmail.com>
X-Authority-Analysis: v=2.4 cv=OcyoyBTY c=1 sm=1 tr=0 ts=6a96bed5 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=G5ilVN+faPP2Ze1SHB4iFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z-QAWnQ1IDuNMEsj6QcA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: 1-UClVTQQ00dcI15sBWlkcJ28L4j3B2F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEwNyBTYWx0ZWRfX2/1TABIvvIXO
 PCoiTjVm6zjbHHJZfPLpoWFtbGtGTRfPoZ92mdRmq4m2SxmRVFWQMmYpYq9Ghbnzn1F3s7FyPMP
 h79hURm+HiTU8J4i+yUG+0DuwsCAGx0=
X-Proofpoint-GUID: 1-UClVTQQ00dcI15sBWlkcJ28L4j3B2F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEwNyBTYWx0ZWRfX8MCFD+s6Gn1N
 p0S4yurgMix+vaxeb0yHH7H2VjQOR9tOK9NL2M8Cec52ccv/R1ziO0R1O9NATJPfNHA9dsRcx4v
 2QfOiy+FicjvNElGCjF7hFU3A/x2FYsyfPUugXHU0EQO3L/4DwLr0XsJR7rJiRVZnCo3BgbynPa
 Buo2ZQ8GnhK0G4pZDncyz11IibRqVkI6i7dyXJUtGu6B+RcWfLTk4GQnnLq9QpM1ePAfn8mR5KU
 /Jv1jdTYXeOv64W2cYE8nnyMEYAoFCLdI7deW1ZCIoFsYo7z76zHDYKy+cArJAieuPcgagX6N7W
 FJ+bD5+MjNrbU45LIOey5LBa4muRlDIsyPRLliDNGtsPnKlyhJJBPrTeJThI0soaZa8yBXW90G+
 os7l+TvxeRirPbOzB5edFjojBA3O/16GZDBqrMb1C69cCO+4yvFN+BfU62CABmYe0V1caLd8BsU
 ohpdsQaEtsvWGz24C4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010107

On 26-09-01 09:24:35, Sreeshankar K wrote:
> This patchset introduces foundational upstream support for the Qualcomm SM7250
> SoC (internally codenamed Lito).
> 
> SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> and 6x Silver Cortex-A55) and Adreno 620 GPU.
> 
> This patchset is organized as follows:
> > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
> RPMh clocks/power domains, GCC and cpufreq hardware).
> > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> interrupt controllers, clock providers, power domains, and reserved memory.
> 
> Dependencies:
> This patchset depends on the following patch:
> > [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
>   Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com/T/#t
> 
> Changelog [v9]:
> > [PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
>   Make all clk_init_data instances const across the driver.

You sent 3 versions in less than 24 hours. Please slow down.

Give a chance to the reviewers to have a look at each version before
sending a new one.
