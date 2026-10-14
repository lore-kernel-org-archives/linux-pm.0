Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07E9518129
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984932; cv=none; b=VJ5HOaRU9lCD397afGz69ry5rCQCIcVbRbZLbF/AriWckTDURgBtAYejkKOwCpRO6wV2QbGduOyu8T70B3thL/c3aloCSyXc3ZS9FsgvGqvY+Wstb6+MoSCsSjZfWsLs/lsQA7vEkuQG1Nf1+zogAmSiAuyYRH+d49Vzh7zzz1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984932; c=relaxed/simple;
	bh=IlpqbHrz26EweNTVebA5NYWFDrcc+dfp5s1FMniEugU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfInNj2dLsUMcmrYbVm+LA7ih5cQ+1zRfgQofvVv5OT85ONEM4E+8VA2i6epzWSLnvQM3XvFeqmAjSbGG2ppXWPHylQAXQeHE+gkKuM/Sr9CTnehPhbIdOkqQfP7NSu9c1DIXpY81oMxO+qaZ264MOAnTvKy9yYkrMjOKZ6ybFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YSt/rCap; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C6jgNpt1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSt/rCap";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6jgNpt1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8i3qe3000877
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3oJjtNP80ClUlRJQPIJ5xMzy
	E/SdWULvgaeOPu3tEZU=; b=YSt/rCap38oBSiDonvSoUHWYieDW7AA788/GQYdp
	XLSfI7xGEpPtB4boX8OLXzQDk+fVeGUQ7VGylvdw5mgsvd9T/NLoAD3NtZz5ZzP6
	3wnXds0whZCrHtYV0mWJeCYyHLhzb3sCEgiXlkbBhTZoxbvHWKcUQx63iEvUjaZh
	F/V7B4RRVZgCvCVQY9FnsUCjgsEQ19i9Pnp30oJncktV7Z877VVQlLA1zzTtyGVs
	faOK1oX1MzhSSMddM/HEB4wZF8JNZe87v87lecWDb+i1UKYMjSp/BC2bNZmk5Mpa
	und//Lrbq3Z41nSs6BTvUMWOv5BqGngNkO1wphfdKQe7cA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbev68s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:35:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc0b31ecaso76798085a.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791984922; x=1792589722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3oJjtNP80ClUlRJQPIJ5xMzyE/SdWULvgaeOPu3tEZU=;
        b=C6jgNpt1DWcLNRj4vqBChWiM5uMqjGW3n964BSYPPd/HvSoiIidMFNCVV3yPjInPDU
         CLp1WRvOH2VEv37kDSOfUEHXoTp6zjL8SwU/cWqdkJXRh7fim4KHGD87PjBFuU5Pqf2v
         odQLkQuSof9aJ0vFwtMbC2XVucu0Z3YpYhaO8XiANrIRRk74LKYQpfpaJG/1K+NHWcXC
         PWzw3VljDykEEby+dYb39YVz6nj/G9D3rVsGhOPROLoCxJ348HHtxCJNNKslCy+NdhPf
         fro5zB/UmqOglw2CM0rLSGPSHrAybyGEyZtGF+Oem0p78BDgYEF3LNIbOJ/n+nmddkAU
         ZjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984922; x=1792589722;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3oJjtNP80ClUlRJQPIJ5xMzyE/SdWULvgaeOPu3tEZU=;
        b=Afezksiaupwbl+7wG1F86kPSKjx0nX5p+u888eJPNGFu9j6WOvB0WSzoqdjyQxRe8c
         fepfNCS+27hy7J40pu6auz6LJ3w+H79hhQowenBVv1sQV3g5/Mus6hrQJnr3D7CHeRNk
         CjkBX6AT44pD+wSLFI+I8Gd5F+89/IbeGsQ7swdG1wxcVcyb0p79D24YTm4TJNxZBxBG
         Vwz+0SlcUmjA4aUNrkImBNe5y62GrSCKK7nmbiWO+PrPrftz4l6EQT/9DllclgEV5kMs
         zPf094EDKUS/2Bn7G1eld8OtssrclFyW/W007EeJxTUNpbfuTD6/lNCzk/A/v6ht7tk/
         yzAQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6wD6roeZaXwJAAUmhn8ko7Md12jyi9lyS7cWpIVWqFon08hKsgC6PYS3AKuOUYdt/iLH2CvGYkw==@vger.kernel.org
X-Gm-Message-State: AFq9FYISX+JtHlW8Kkb4JghUM3VrtXOMsa118ciu0VKTnKpCSvBf4TLc
	fZUY6ctWdLNhpb4fy/ewBD9hx4HJlvdd6FjHH3cryr3OpxgoqS+/Gb0Mal+7SkElCPnxppT8dcB
	HXtyBxn67wPGFOVvQveUQbJz4q9ehyWsoXC7E9QfBA7AWdqIZe+bxNNKWDnZWHg==
X-Gm-Gg: AYBFou3FSVLD2N0tKHRmGHFlOeH7iMhRpDh7eveePr6phj8rkIUQrICd6Z/8/rrrsi8
	pqv/kTmP58Tve9KNj8hJji0qxd9X2OH9l6SsBHmc0yRdg9Q0P1SCAhD6ygis/ot1os4ciHnzTW/
	pov6HiiljoQnxB2NmyKgqba5AhPsWqJDeRe73aDew6IbE51wF6Oig61dNXEogBfh/RUC2PsY9Lv
	iXrfRhN7U25zFu2Nr3ILynWSveckBrMD8qdQ9pKXU7mUd3R4VqkldlhYvWxbyCsAiek+zG+VfMm
	fJ3beijyteuRCFOo+hPRyoB9QtHm0Yy5hDyqOMmms9mArhvy7K94+X1ha52dS8W/Eg2N8SBjxmk
	Ulv0x9C1acxrqntO6NbMFgNyOj+NxRJ3i20/UEgBN0qDokv+pV087u8subKM/1uUdN0SxWGkbF0
	3imD9eA3xTWUYj
X-Received: by 2002:a05:620a:471e:b0:93f:5ac:14b1 with SMTP id af79cd13be357-93f05ac16cfmr236552285a.67.1791984922451;
        Wed, 14 Oct 2026 06:35:22 -0700 (PDT)
X-Received: by 2002:a05:620a:471e:b0:93f:5ac:14b1 with SMTP id af79cd13be357-93f05ac16cfmr236544685a.67.1791984921806;
        Wed, 14 Oct 2026 06:35:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d857d9sm662845e87.49.2026.10.14.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:35:20 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:35:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC 03/16] OPP: Retry failed default single-clock
 transitions
Message-ID: <xkiu74kv2biofdix25gimmxxzqfqyocsq3wvdriqj7zscpynv4@us3hib36vops>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-3-3041b788e9f7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-3-3041b788e9f7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: TzjKSNgdKknhqKAwtTV5bJsuj-ypKcXH
X-Proofpoint-GUID: TzjKSNgdKknhqKAwtTV5bJsuj-ypKcXH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX0Za9PqNA33Vi
 ENVp5hXFw+YtNvyPUI60OdCVv8mxIWaKvUXlu6PGJIRueUdZUOK8duOxtlmcRlPZPpT6+NTQoaC
 z8x1HyiA8YRf1emE/Fg4WI1M2zIHr6J9HJFwnDCaENcERO6mMr7LKvPdQ/7MgsAHUPwshAuHO2V
 P+QcAnzkuL5O7YTEJVjJVzjik124xfzVP+YLVDNBoDEkD2elmTYl91WGGCflRbHgm83OFfGaEEC
 XNOE+3ViDXe7epNLOMZuDm2b57wgqq157ZBVYX0X/3HcG7CuNcG0eNy0FrZLbunavyBwDbslS6I
 psGq+cXWMKb6ipTYVF76SU8gANGvEie2k13bqsGP5OOdoam5YuWja+aMdSIitZU3MJOpOwbR98N
 L79LdmrgrW2Ph4JyllHkAeMxdmrmLRfAkLL0c03WJH98iqnN1V4iyrDGsycpyMTmcO7SljocEbp
 4nTJzOPgvklxF8a7ekA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX6Nbefo1VDaue
 ESqRrMNh/8wjqxXfgYEiy84DaUV4xYU0vm2Kg2uFNJEwDxbEqjXCkX7PvBGXbAjguCJG0H7a2qL
 nHqhCUJsy8aOc9dWlrxSTTf5dVIpNZc=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf851b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=3h-aFR46GQ2hTHGVm7IA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140054

On Wed, Oct 14, 2026 at 02:19:03PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> A failed OPP transition need not leave the clock at the last successful
> OPP's frequency. If hardware changed before the error, the default
> single-clock path can subsequently skip a necessary retry because its

What is a necessary retry? Shouldn't it be: try, rollback if it fails?

> cached OPP matches the request. It can also choose voltage and dependency
> ordering relative to the wrong operating point.
> 
> Treat an incomplete transition as dirty and use the observed clock rate
> to establish retry direction. Do not trust same-OPP or same-rate
> shortcuts, or allow table disable, until the state has been reconciled.
> 
> Limit this to the default single-clock path: custom callbacks can have
> additional state which cannot be recovered from a clock-rate readback.
> 
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/opp/core.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  drivers/opp/opp.h  |  2 ++
>  2 files changed, 65 insertions(+), 9 deletions(-)
> 

-- 
With best wishes
Dmitry
