Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5E1F94F
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726291; cv=none; b=EGUPxUOlnpbrlQEVyey8agfDRE6CjvPBQPokz1/GBb0gsrQLCh5L8yWmXnF62kIkrG5HLYDR7fVDU7WEW5IItbpsWw8WTtmatWOiedgTI5sSqOY0U5gVWDWrG5WUy8wlvFvaX/z8pYEjr+evhc7E55fzNpa2N0Iv1hrE5aPfDu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726291; c=relaxed/simple;
	bh=sDAtRHZn4DyZHI7y1G+7cSpzGNLxkLvIzW3IVoSRaNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGTPBT8OGQrpXtSnJJJGR67zxNcIZnODRoY3s2LyNRdI3WkGfL+i7Z6xkyRqWV4ShHyn0YxPf1OgH7bnXH01NO8P1opg6r0cBLVxApqEWrTDEJZMPTnQ0NWj5OU9SCHYGYKxBPHt7DH7Oz0U9/3v+8dDXGLVpuMK70txb2KG1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GmAo3kcS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eeKrX+Rc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmAo3kcS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eeKrX+Rc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDI6Jp411989
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f+AbOBrck2WkE1P7RDZcLaW4
	KIvRnF2j05kguajpEXA=; b=GmAo3kcSV3VHLKr+hwsi1ku6PZer/VjXNZe63Ev/
	NCuoqVtaOKnP5/aliEqwOkAqFusXL9iNVz0Q/XWZvZkE8+8YNGkN3MxRWFqTfp/J
	PEGuXdkHFbtkUe6oIQviZAYSjYzH7hL67s4mLA6V8mwP6AELcLlyeSrRaPEskQm0
	TaPG62mg0tkBRVQ8+fRLbUl5TVzxe0YNyqyeFpwulu0hgsqEcs6d13ZzxA8mUdMo
	4scEtt4Z6MUPM2wmDQz5pLZDT0JFO1FxSevqdOJL3VOpp4SetAhRij4vRsNGBLNF
	XFFQsZ40lcGoOqyDZVcdKYwCjnW0XBhNHT7snfyivL90aQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxmgg012-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:18:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0e702df8so192666891cf.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784726285; x=1785331085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+AbOBrck2WkE1P7RDZcLaW4KIvRnF2j05kguajpEXA=;
        b=eeKrX+RcIY8F/7qVecH5Jv1K/uzG4XKGa3qX1TAf3vHHeXDMXGniPNe5DnRlhqJ21W
         MRZWYdksghOyeAy+mR7t/S/OgB+JxY3mayN6sy3v9FwhBhiVn625IyK2xHO+QDDpn+SJ
         kN4iGY0kM3P1Z68waN2f8VgU41/TXGbNZ4egNJ/wghUkZwN5JeHspUreEhVodjsCh7WK
         li5q9wDd0J2Re4sEGAVtdLBVljdYwvg/OBNtdiRJ62sY6QnlWD0E0fGgCC4JIroZMS7o
         UnFHwjdgc8Am0IGrb6dMGAxOkhNbluNTqYlZ6MZfnNuaNJpmAuxGNvQx2OJVyrobiR85
         xkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726285; x=1785331085;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+AbOBrck2WkE1P7RDZcLaW4KIvRnF2j05kguajpEXA=;
        b=mCMQdQNGzTjJvHwW48E3uGxrdFIQwSv9kfXF1JO2pZtn1mwqfZDw/LL7aRI5fo8nTE
         JdIEKShQxYyHSSD3IL9gNeHw9/5V4UiH3p5v8pXz2qv1k7OhvR9msKveiIlvCXWC9zeX
         LyOYfDwOH7XYbVLedDvEr/lTqy5CUa1fU+haYrRFWBF7DwEeHDM5J3BE/Z/k/LhJ/r8s
         xzhMr1TZRn0+iNkOWRTR4dQneZiTCKhlTKSa7AUdxhXwkGJJ2zL1yre4dRHyNtNFeupO
         vIl9Ehy6U/qRIA4UqKwoO29yp1I7GtLdnYCjT97YCDusXYD9oI3d0r7EHzT+Ny8MEzBr
         +SQw==
X-Forwarded-Encrypted: i=1; AHgh+Rpk63LEx/fYM2LRimJ/wJojE6B3Jvr4ACxcz0H9BgrO9MU6IlNfEqi2JlVCftM9s/Kve+xAX8M1eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzErn0CJGRW/AcSPP0gGbwwU4zQFjlopV852KwzaRE4aPfTsa9N
	kue4tD0Emwzd1rqGqjIH1ZWb3+9lEkDjtZRvovFoVjbx9mWd3oNMlz0xuk0WGR5gDJD42oiEafb
	ZTQQsOMGQuJsm8krxrK+rEARsLRXGKvOpKIt2uS5YWILxuh2WjBiA775QOegiDA==
X-Gm-Gg: AR+sD11Ftgj9r/pWIRaexnat4oejdBcVt9bUI2mflVibv5bJlQZNCr+MRg+szMIEMin
	PCHbmvsveuqKXTPDyIHsqHij4+U+fBovIuXtEYhMM3o4Nare/RjVuOS5V6RtX/2GPrv/fFW5ZcT
	ZO1UAAgFU1lW4wr3Sfpdde6d/UaoJqSur8SNl+Ezc5gBVay6vcUGcm2ZMkFkX6nBFbhge0lNpxw
	MnRvwU4bW8JDSpto7WiUsK+HjU8exWlvLQwadk7M8T1jTXVkZXjF9mZwdXjgSeyzH++/4jd9Hgq
	NqpJMQm5W9ahCEAGxKBWEtxlRMp8ABreDRtBiO8SrqWrh8wrP6R9aHlUeZRziu1XAt5qADNGEd0
	ZawyJpSOvS0CAkQeA6ehcPrFOPtxS54RyxnlLajz+mW36jA1vgLdF5G/RoAEit4ADq9uiVh3TVc
	nn6VcIIgTNXxHPIQ==
X-Received: by 2002:a05:622a:418c:b0:51c:83ee:e42e with SMTP id d75a77b69052e-5213f07a168mr218040171cf.77.1784726285237;
        Wed, 22 Jul 2026 06:18:05 -0700 (PDT)
X-Received: by 2002:a05:622a:418c:b0:51c:83ee:e42e with SMTP id d75a77b69052e-5213f07a168mr218037971cf.77.1784726283055;
        Wed, 22 Jul 2026 06:18:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b8bfa3sm463297e87.12.2026.07.22.06.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:18:01 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:17:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/11] power: sequencing: pcie-m2: Report power
 controllability
Message-ID: <74x3c6zri7j2nlnhry54ytvckozlimsr6p3cp7eqfuywq3rtyw@bdbei5ophevq>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-4-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-monza-wireless-v5-4-69ec6743543c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=D+V37PRj c=1 sm=1 tr=0 ts=6a60c30e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=kWrQ3qjY-mGDYE7M3pEA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: D1Uk9jbUQPVsCVCEACxzUHz1GkpQstMP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX+AYaL6dSENY+
 e94b2jwIFvtkhvVdXVWWFmLBENdqqmK+OzVj06GizO1ImnfyM5VblCv3Mku18O2vviVZbWLLbqp
 DxFLiC4n+CQtKZiR4VaQ0JR5Co9UO4w=
X-Proofpoint-ORIG-GUID: D1Uk9jbUQPVsCVCEACxzUHz1GkpQstMP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX995Q7I3T0PfC
 Ehu0OqyJ4OsQMLsPsjjn8/1g0owzGt73uz1bYyE2SFp42puYL506vijhampZODuPyxW2Myqosj4
 UesTgMbo+Lyd2iWVciIiu8YBVJ6HaPJm4kXavP7kJ/9sHZliuTljhsQJF7Awq6GxE3nfD5YCSWb
 N+GfrsoFJ7JYQ6i3cbYio9UUbzRVhvNyVxgsSfz5O8HuaxXVTNn1lzoz6hxjf86vKLZs1mnI8xY
 SxCIA0I+BuLL3u2lFN9jSKmjKtcHZWMV6MjcGnmp2KOJuxTBzjhiKaOw8kHWrtLRxMwAYOcAfvo
 IBeZgMjE67OBqC6pGtBEms7v+BxRO5yqpe9QGGbd/sNnFMFAmV8cR4Q2+tlgiE0akeZqDxlTK3Y
 f8Ci2TrBsObpp7J4qymYbyYAZjplruRealgnm4SDGUhXvkdMyMoR5uQlS0jcXC+1l1Y/ZqTcI+3
 omp84Xo2tkMIHNDjRxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220130

On Mon, Jul 20, 2026 at 10:04:06AM +0200, Loic Poulain wrote:
> The M.2 Key E connector gates/resets its functions through the
> W_DISABLE1# (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals.
> When a signal is not routed to a host GPIO, the corresponding
> enable/disable callbacks are no-ops, so the consumer cannot gate
> or reset that function on its own.
> 
> Implement the .is_controllable() callback on the "uart" and "pcie"
> targets so that consumers can query this per instance (based on the
> runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
> pwrseq_is_controllable().
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
