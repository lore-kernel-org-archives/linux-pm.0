Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187043CE69
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457117; cv=none; b=Hh9VAMBRUvg1TkKYJ2FyeIPQ6V/Iypjo8nhEZgZ6WYcX6Xhz9i5T49tLJIAMQ1t5E6jFhsOiZsCZkyfIiBcd8jONWOV2UJMrOZ+JR/TreL/f6oXSDQGT0sVUWeqaqUq2IoKKOKmEU+3VRdPrsJIPe9ES9gt6U6L/iMsD4X/Jiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457117; c=relaxed/simple;
	bh=+rbrWplOQUk/FiP8xN5lpwFUzK9G5TZuSDlUqlo0pUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiHeInXk7rfGvQN1Ase+/eiMuUuHxWzxFPMihIzAMeoSWQWvfh1po4GuRvBjQHrxBISPgNxlbo+XiVE0C3Y79VGwDXEqntav/JtOhYEjqjQKSlbbNlZdLUcL0LH7YmJeOQVo0APrQ2j4dWPciWqZrAfxt9alsRKClFraIG0b1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EUoExjr+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ac3EmoDU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EUoExjr+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ac3EmoDU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWWG6409838
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nxmc0t9fxOdqcLZd0PYh+n6m
	JbD21/9HxGe9yWwmSKY=; b=EUoExjr+ON4eoiuMKz9/LIdcdbcYgqxzoRK2o+qj
	oV/qlbS06ZsA1hI6mo2ckNVx3PVl5ImtjchA7MZYT0qT9wf798r9ksS1RSbC3WAY
	2TCYqYrL6l8FPvMWGC011YguWIfVSw9il92z510MCYbtY2TOsQduzqLo0wh9KqR6
	/LOEI9vM6kshjQNlAypfkeyScPjBIFm7Ga0ttxf7lM4fTGWED91wMmIgvAGfcvQh
	Ou7IQgcRtSGYjabX5LAIOlDFk2hL252IvKbOd1WaWX6b2i2bS+fjITPpwYGcpmo5
	uV5zzINeAMwoWvBVV/OFJrFQ8r4TOOjWt7KiMm3ZzBCt3Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyvcra5ry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:05:14 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-73986bb438eso3148591137.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786457114; x=1787061914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nxmc0t9fxOdqcLZd0PYh+n6mJbD21/9HxGe9yWwmSKY=;
        b=Ac3EmoDUlmrineB8DE9NivAnJU/SSF7Ihl6F0QPMWx+vy/TV6DZFI+kfmdGlXylzoO
         0aoQHgzbZIJKwJHIjtByDY4wXdysWV4VaMhY2OnmIHp5HRfPDchZ00VYFz6IsDaMeCjg
         Z6d0xCJfISBN1kjmZo4pLUkHsdublD64tPj8+VVsQYTfp/YPeUetf/OKw/uMlyl0gT9M
         +n38Nmptc6bKSXQGbG8LajokJDXksivasFm57DyFYB9T7prH1onJFmRsKCXVHz9JJnaq
         RZmY+LjmZYP1yjxJrxcU5cRfYDDPKUNcdBXcwPvN+uB+CfhOzRLu4d1kKH47R6ds4oLi
         Dzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457114; x=1787061914;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nxmc0t9fxOdqcLZd0PYh+n6mJbD21/9HxGe9yWwmSKY=;
        b=eJv+rHlTVV/c+DduyZ8BRl0q97M2KcStthtyRzvFH5TpiY2ySnOvlJMMg0jVg6I2Xu
         RyQ9aPo7N9ylL2b2VHw4uFW/WYNJ05cwarlJX+zyr0UAKjfOsjvKVNNGca4t/G14OMze
         hAdNQZ49s3kJbt30JCvqQ/IrDWy+5CXMaMoQLSwoP4PfksPZ9fDVDbgPzsf9vf9YW0T7
         Y3h6WyZrFGZ9G9qOAzc9qgUPIbTQlIdv6pdsZTSC9+NrJb0iTAiMtyTCGKv0wHRhALzk
         L1ddxIJmZS31oGTqZhDAhOCsC4Y31ykJYn2Eymbda52i9ZQ73eP5X+4p9Fz4BkCBrdgo
         vBoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWmoxdaUCKdw2onuuozRFuuzFAlw4xURJmaiQcbFugUAe/nH/2I80n4dn6OnLiI5cZ/s3z3eMN9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq0T0pkVNgcEL/FP/O1S/jS5Q5uZonZtS3Qq7DfSEu0cBK+odB
	yVBYl1gZVGkAl4Ivz6XvHEoGdzrhHtM1mGm+6wRRyX101pYJAGHFP8DlnsCSTXwxdClgChLdS6J
	fibYb+/Uxa0aa4m6Bcu81mnsLfEI3ya3hb8hN9EZ1yOxtvIeipw1uxNtsdB39xw==
X-Gm-Gg: AR+sD10D0QX8EtdIKhZBGWh1JPBaytHTUkzz1TzJZqN86NCBKOkkOVB6FGckUXtuK2X
	1Ctv8cVEVA6Z/0GtmGhpCehwSGDeFHg3IjzCjAyNpxacHnfVbwg1rQTWTMA/EwZ2pJ7aKT9c9+j
	J+ipbl/K9fXe7KFFVujMp1JO3TavrpTDxobKWWEU51XP+GiYjRwuAalbpzKZ/bCkYT6Tw8cPfia
	knxoJb5dqKjhAkqysHEBAXziP5tAOCEdbRnIxq0wnVWGRiTO5J0dRdHq/5G0zCwkVj0B3oWMvQs
	FJbzdmaXfayeLk7rB12nlPzHQTrjBZMqMU77pEY81uEaJWGlUuQkaRYkuRc7oEt2MVINbEgEJFz
	Z/jfjFr0feF8kETSMoid1gm5Em95gIPxHeCm0icO2ZrKX7I8v1xLWv1soS0SJJ5XfDGKDeG7eCT
	lanbx1ztpLr0vabQ==
X-Received: by 2002:a05:6102:4489:b0:737:bfe6:3b03 with SMTP id ada2fe7eead31-76c0a79efacmr150998137.7.1786457113767;
        Tue, 11 Aug 2026 07:05:13 -0700 (PDT)
X-Received: by 2002:a05:6102:4489:b0:737:bfe6:3b03 with SMTP id ada2fe7eead31-76c0a79efacmr150957137.7.1786457113300;
        Tue, 11 Aug 2026 07:05:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b448724d16sm324566e87.51.2026.08.11.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:05:11 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:05:07 +0300
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
Subject: Re: [PATCH 01/15] soc: qcom: geni-se: allow selection on 32-bit ARM
 Qualcomm SoCs
Message-ID: <lugf2oh6ocycg2uavba3ws3p7mawkfbiyxya4fqba7jc2vokhp@nt3egjsh4jph>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-1-5e0ede4a0c72@oss.qualcomm.com>
 <7f4qs6su5fd5ilecy4r72suk6mqvj7oouz7ahgatxthqavrfia@wxilczij4unf>
 <vxpntlaebf4an2wgebgbwk2rdkingzjecdgylqv36wmxtyqju3@hkip3wqgendw>
 <c47b3af2-d265-4e9b-b843-05b5e63fe5f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47b3af2-d265-4e9b-b843-05b5e63fe5f9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX6arje9a+ysxG
 90J0CJzJ37StuJCHHTblcLt3qBAqZCxwC0jwSjPwprydSqyXWMWj7LMGVLNQAB7jQb9GxgHKH+E
 NapVyQVT2XD8/s3cfPbzG5YzedTqUY/5IDcdEaUa2eCsbzPlNoi4li5sCDGYRBo5Ygccy++JAow
 frUylWdyYGygGW5Hc8DjPONfze54RMQfiYG95B2ItxPzjQesPExRxVa7EUqjokT6b3H2+Z5ONkR
 FUSku4lE+pASqwM6y2KosgBz04fiNlj6tHAM4LKAFaZmRmXycFwREJfDRqwFPfUw6mm1W5Sq/RN
 swlO4SzI9MOFnzblC2jWgce58SJDw2BszoLdTRLszwSMihlixqle+W1elKd6ODd5I7/FlOHeN0c
 DnuudAy1Ia848qnhMVOAaao8tSmVnsQp/BZWCgzAzX6mnc2MwzClrUgHyTrweHxDiKuPvgMM3yD
 Hyo51EcoPUkZNUoyQLw==
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a7b2c1a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=DpJPHJr2yjW4mJ3v9wcA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: D2Hdyyejq7BNZaatvWH-G558hX31Mj1u
X-Proofpoint-ORIG-GUID: D2Hdyyejq7BNZaatvWH-G558hX31Mj1u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX0XYOGdfNd/Y5
 dnZ3OuvidS+PCwl4QPJ2TA1lJW3jXcyF5z6ggN27m43Go7grvp1ZbfaYqitzAPdQ/LT9S5wfbDl
 1o/fmawPe+2Ktcoae8QG/4Knbj9kzeE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110117

On Tue, Aug 11, 2026 at 08:37:54AM +0530, Hardeep Sharma wrote:
> 
> On 8/11/2026 6:45 AM, Dmitry Baryshkov wrote:
> > On Tue, Aug 11, 2026 at 03:48:00AM +0300, Dmitry Baryshkov wrote:
> > > On Sun, Aug 09, 2026 at 12:57:00PM +0530, Hardeep Sharma wrote:
> > > > Commit e10b198a94c6 ("soc: qcom: Restrict drivers per ARM/ARM64")
> > > > tightened QCOM_GENI_SE's dependency to ARM64 || COMPILE_TEST on the
> > > > assumption that no ARMv7 Qualcomm SoC uses the GENI Serial Engine
> > > > hardware.
> > > > 
> > > > Kuno, a 32-bit ARM Cortex-A7 Qualcomm SoC, uses the GENI-based QUP
> > > > wrapper for its debug UART, so this assumption no longer holds.
> > > > 
> > > > Fixes: e10b198a94c6 ("soc: qcom: Restrict drivers per ARM/ARM64")
> > > > Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> > > > ---
> > > >   drivers/soc/qcom/Kconfig | 1 -
> > > >   1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > > > index fd4d4ecd2df0..5b3c9d31fd7f 100644
> > > > --- a/drivers/soc/qcom/Kconfig
> > > > +++ b/drivers/soc/qcom/Kconfig
> > > > @@ -39,7 +39,6 @@ config QCOM_COMMAND_DB
> > > >   config QCOM_GENI_SE
> > > >   	tristate "Qualcomm GENI Serial Engine Driver"
> > > > -	depends on ARM64 || COMPILE_TEST
> > > depends on ARM || ARM64 || COMPILE_TEST
> > Or depends on ARCH_QCOM || COMPILE_TEST
> > 
> > > >   	default ARCH_QCOM
> > > >   	help
> > > >   	  This driver is used to manage Generic Interface (GENI) firmware based
> > > > 
> > > > -- 
> > > > 2.43.0
> > > > 
> > > -- 
> > > With best wishes
> > > Dmitry
> > Hi Dmitry
> 
> Thanks for the review .
> 
> QCOM_GENI_SE is a child of "if QCOM_SOC" which is the menuconfig entry that
> guard (almost) the whole Kconfig, and that is already "depends on ARCH_QCOM
> || COMPILE_TEST".

Then the whole depends can be droped.

-- 
With best wishes
Dmitry
