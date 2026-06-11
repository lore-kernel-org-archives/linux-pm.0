Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523B399D0C
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210080; cv=none; b=RHwKH/I4BYfASaQY9Wbb068IggvobroRUjr9qTYNsNZL9iAVSrpb6q5JMHFuvw2fH40eekUoDOOVU34XDxaeRwRrCxydTMUl3LQ2LbKe8eIFPdLBqBTUjM5QGxsoemogQhOuzeYNd4N39mEXX/QQjsGRDB8QRVZbdj3CVgV5D1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210080; c=relaxed/simple;
	bh=TIdPufXGdElKKnuHJAx+uoz8CFWSUSnL3a9cM2RTenE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMFX7wdC9NsrQ2Wo15UHQ7UnkKQp4KttrVL15YaE+G62CdTP4+wvaG8ppME0vDAVV6j5X20V8GI+FsnAriTH2xlCelIid08t2p3xZksc/gH+NmOhSlH1OqsP2Hv4G1uk4ZaND7KW591SpTjF/BHDXoZ6oAMrNgO1bGZj5feJPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sgz85z5L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Aypbt/av; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sgz85z5L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aypbt/av"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3K6E1510537
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 20:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GRM+mxmakpC7NoTjq1FhUVVt
	icKlB4ODWObaEuOgJvY=; b=Sgz85z5LwU/4hN9dsMBpi2gliJxiIpqUn4joeGpe
	7kV72iMrCYhjXl8iyv73iDinhN6vKuatjnNGka+5wN+lPXIHmiO3ssYcTYBZAVPm
	AJlNsqjxgl9/kU6kx4IAeMBcNtRn7t3X0Zvp/Fw/hPSbfZiewTogqFHklB+BFJMk
	atwfmeY4Ze9KMS/Y3Fcgv7tmJY0PrJk30pkVvxR9nQMZhmtK8ufPxk0WIK6kQo0U
	zdQRNLvcd4vbG+PKDSUwyqaUHwmMMwk1maYIEhh3sv5no8DZYsbxh3/uZr0UYc4e
	gzB3cHu29AxzMT+b5clTaJ4jwTrZUhpIryaVYZN+Va6OyQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2u40a0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 20:34:37 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6751c50552dso103530137.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781210077; x=1781814877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRM+mxmakpC7NoTjq1FhUVVticKlB4ODWObaEuOgJvY=;
        b=Aypbt/aveLSJzXoz39pq/qs0dYwJfu8XC8pe0M8i8tWVG6QyuaLIDr2fQYQp3Y6MxE
         G2R6FYUgAeQak9wfiffIk5bivynocPqEJmxsNY6muEnEruZQWRjKfmD5ElTbZDuiiPnY
         h6Jk2C9cdmEhUVkheXqSqg+rGsEBIlrHzJUB4I1fxOw+qSeERwB3l55veliYEL9slwpX
         HXaYFOHlwD1SrE7ZZb8j8b2dHFQefRvTaNWUHdPYPPiyNLnBqQkeEaiuQ54F82gGx3n5
         7T8lEVgbO4fQFNlEZqKPfGDcR1bK1y1Rgyu20r5ptHwspS7QgXJvXTvGaJlIqB+Sr5vr
         apag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210077; x=1781814877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRM+mxmakpC7NoTjq1FhUVVticKlB4ODWObaEuOgJvY=;
        b=sqYo+gEZv2P4G/aCCn7Awws2vN4KVQiy+fQ6jHX9ZVZw5bJUEvCW7GwhKvYcW6RwhR
         DNkrgHznlVJh5Db1YQoaC19GfGa7R1UCCkeeYe5QNu49fxGxybRk6CeNSli9JeejVdHP
         RSRFAfNByp9dUbuhY+dHV9sXd6dAHsFG+RiDlgUpIKamFoHV6Pd1PyYM/b0ppUEvZpvm
         6MxGc342C9xNFxNGUsucl8jhP4GPptcBc8DcvUnUTAF2uzsDP9k1URio9h04FgRLorez
         N8Y9bltGm76hvddZBq7+Fvt1meIEPIs3zMjhaazXV/20Bimz6bXRXo1n7+dtnhWqCs6o
         8Lng==
X-Forwarded-Encrypted: i=1; AFNElJ/qcd9+4GvX+2fmtuej3PU5JTQuAul9Jk8EQ3JtRyh17OBu2iWc/X2j/sZLts/AIgz+u81JBcrlDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+0d2Ktx9Bywa6b/r6MgJbZzmucUAPMfMvlQEaW+b+XuBS9+fS
	4R50zkWD/G8V4OpUEs3BguXMqUbCWVIvtUjTvgG2g9moQqf0KiuL57R/58UdRd5IUckbLn6DCRo
	SMbCT9eSJ3lnMJY0VhD25so9aNaOjABtfnv0mzV7f7p6FwSU5nCIsyPYZOYLFPQ==
X-Gm-Gg: Acq92OEDStY8x5NpxaBBapIB2zVSbbX5zN89HHPxMmm6UBjhVniwHQPlfJDJErSpRfo
	rkt6LYZDU40RQvIvsVgqVNWGPBzfW2cMcViEAt1MnnHkas9YWcoyR9qgonT1g02XbbXgDqBqR23
	723cctb31K039BpuJtqKJ+LMCY39p6WgUwnwGXFfsYa0+61KZyK/914ncPrn0Ij72FcyPioqYAl
	mcLa3E9wJMyIDbz30zkBGj6pDRO6nRbChPsI7QV4GU53c1JEopyKqM1AgvbAFC8RtHAv2if4wBS
	2WGMNmfpeEdsgKw6lk8yGXhX/RZJkXk4pvTdZ2VF9m8gmI9eW6EmQtO4QjAWHa68GHp40QOU/I8
	kHXrFbaDm6x19hrHEupB16O0SDawYRr6De63z4QARjNEAWUNHJnpDEWhQJCA/dv2vf9UP0Phqs2
	9OgN4eMlDmx8FS8lGX0OOJLhnfKWDmcLlhBSk=
X-Received: by 2002:a05:6102:5e93:b0:607:4fde:1921 with SMTP id ada2fe7eead31-71d5f4c9e9cmr3251251137.24.1781210077284;
        Thu, 11 Jun 2026 13:34:37 -0700 (PDT)
X-Received: by 2002:a05:6102:5e93:b0:607:4fde:1921 with SMTP id ada2fe7eead31-71d5f4c9e9cmr3251239137.24.1781210076870;
        Thu, 11 Jun 2026 13:34:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cd8d6c3sm124092e87.59.2026.06.11.13.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:34:33 -0700 (PDT)
Date: Thu, 11 Jun 2026 23:34:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] remoteproc: qcom: pas: register TMD thermal
 cooling devices
Message-ID: <l2f6cuhsq6y2grrufyaki5iijk3lpbjlig4sdispo4yxsmckcv@iyb5jwdfph5w>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-3-291a2ff4c634@oss.qualcomm.com>
 <e9573827-81b5-4c75-9d1a-d59a4809300c@oss.qualcomm.com>
 <cb244225-5375-4925-8d20-232cae9da672@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb244225-5375-4925-8d20-232cae9da672@oss.qualcomm.com>
X-Proofpoint-GUID: 4Qu9q58Bt0Qlaa4IJUB3rZapbofeZw78
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIwNiBTYWx0ZWRfXwSMy52o446RU
 44vGEoU9jOi8VHYqw7bsxc8kfliM45qplI6TqEYe3IorgBie3HhS+K1+jbLSMiHGqwE2Ymi+rmP
 Z95JrOEN9WSuAPWutmnsT3qmAy9N2Xs=
X-Proofpoint-ORIG-GUID: 4Qu9q58Bt0Qlaa4IJUB3rZapbofeZw78
X-Authority-Analysis: v=2.4 cv=N94Z0W9B c=1 sm=1 tr=0 ts=6a2b1bdd cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=wIx81Qcb-Uf8PA-ulogA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIwNiBTYWx0ZWRfX5dmIRt9yGU4h
 haTMgzf6N0YWm+TiJO7BwAt87+QV3b3lrw/ma9AaXQUGub2zmyfJIHzT2ftPJLcOxvoly/8R719
 06qHOJoHBIiikSugqoyv3ccaSU6GUvc42WOpQIzivPd3ABudgCZxza4dt+aHqU0r2PSyM/C7rZT
 l/SzJBkdmym+Js3NYkhqHePpQI8P/XFIYYXJs0RsQO6S0XlBtzqupNBfnmU4o5HZdlgpRSdLePW
 +pOcJNQWN1nl2PCuYDsIsoXgrDmmuKXXZpaG5LwCfd1xZ7Fu4ba6fpc9j7OOgxd4EoZRLYnFGJP
 iLYs/QkKFQNXo90mnfaWV0faQf4kloqtFhtt871KDs3COjPDEkiptNhaP1l/pHOBLqcx/EkU1W1
 pOzUmhuQUz00X/jvZ21dofkR91pxWo0fZOp843NJclHgwDIsqiUJsCgWcPGH0T+iQTWrX9+4G8N
 WrpD+CXgnZD+KjiaVsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110206

On Thu, Jun 11, 2026 at 10:15:30AM +0530, Gaurav Kohli wrote:
> 
> 
> On 6/9/2026 5:33 PM, Konrad Dybcio wrote:
> > On 6/9/26 12:22 PM, Gaurav Kohli wrote:
> > > Add support for Thermal Mitigation Devices (TMDs) to enable
> > > thermal throttling of remote processors through QMI.
> > > 
> > > This enables the thermal framework to request mitigation when remote
> > > subsystems (modem, CDSP) contribute to thermal issues.
> > > 
> > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> > 
> > There's no other signs of Daniel in this patch, please fix the
> > tags chain
> > 
> > [...]
> > 
> 
> > > +		return 0;
> > > +
> > > +	/* Get the TMD names array */
> > > +	num_tmds = of_property_count_strings(np, "tmd-names");
> > 
> > Is this something we can stuff into platform_data for a given rproc on a
> > given SoC (for which we already store *some* data in the PAS driver)?
> > 
> 
> Without tmd-names in DT, it is unclear which index corresponds to which
> binding. With #cooling-cells, tmd-names in DT provides an explicit
> name-to-index mapping. Please suggest.

Could you please explain, what are those thermal mitigations responsible
for? The series applies the same limitations to both mechanisms used on
kodiak for the modem. Is it always the case? If so, do we need to
handled them separately at all? Can't we apply the same limits to all
TMD resources provided by the DSP?

-- 
With best wishes
Dmitry
