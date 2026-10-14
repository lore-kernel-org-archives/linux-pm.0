Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809D51EDF4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985201; cv=none; b=AMKC3E+T5bfgWJ+95xqkhxXvpJJiXrtcdhwkqxhnZG8TUtKcecuU5CvBVx7CXcJwyGRtshOnRUo4mN0Z+gnajFPLAOZXR76mNkm9YwfAgVYwfVByk7umd2fKGiHAy0NflGCS6fYIXk0mk7EsYmUfofQDzH8R6POwr/FwwCqSUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985201; c=relaxed/simple;
	bh=0xfdTrDLB2gWOdwJBkzEjPw0cKgTkhuJdf6y1UsT6YM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ShUcjyWrKLB2yQdhd0m15YEkgKs8Nv3AMBc/r0PPJjM9JZlRjKyNRZlMnZOsknGddgS3goyTpvwJDpwNm9fjm23FyPP0vjHTJ89nCP7W46QuuL7ENtA+mvrdysUtkYo+flxduF7MlSWZcGaYzGpppZuEFH5EuDizcRMnxG3QupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m5kxVZpb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TBN3TQz6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m5kxVZpb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TBN3TQz6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EDWRJT3017984
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NKJXy1eO5vGiVrxvsBEG/GIMF2FHbHhV5DLbt20ey20=; b=m5kxVZpbI7GUQhYx
	Diuw2Cb7PXF2g6Kk1nf81YlMx8pkB+qU1KrTO49M1fg/2pg+9GIBh0oZ2qhU18m0
	OlTVhT2PClDiT5R4bvvnbThWGaBEEB1sQizX6fNJZMIAvmP0NmUcNCIkGJkCqlsl
	GdSbpDp2H8JmUuCTeHGRduB42x8lbbtT1GrxcqkwgOo78w+ZUS4Czv44bIEFLwf2
	kcaIz2ZfZHeRI2lY/2u8J0ektqC3HP3UmsupYKEkt/sBfqQdqpasMZXrGTQGugG5
	KGdqAYJ2z0AceXufVEwCSQfO9PePeCvoM4x/MCakC8A//Yzojrvm7JHg48eyIhVe
	TpkCaA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b4j7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:39:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf7856ffso847409285a.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791985193; x=1792589993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NKJXy1eO5vGiVrxvsBEG/GIMF2FHbHhV5DLbt20ey20=;
        b=TBN3TQz6AvLO/5zVm3opqI5l2Ru7CBNc79+vWRJ9KKBiPZjcFJRQuXgUytX4P2Umo3
         8o5zqf/nz/ZB+a9Q9mG+ssCQdCG2jvBfQ/fP197I22iFQ0nXwO20XB0fjEc25uVaOto+
         xf2Cr8IIXYJ3/cSr/JoRmR1vTQl1YJygeWsz+i6gHe4gJm9iZGiSDf6bq9LNHA8GCQqw
         G1v0BbpAAB/nz9uIIkR8PUF+6Hfhv4BMgUMw91NNeF59l/CBlyMGyiKqbRZHF6RlL8pY
         XoCcB8AU6cGHQup3UHCiPqIVho2nwLHnXUUZfzFYD5SQ/aUYi0m/dknBGHKCN71ap50c
         WCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985193; x=1792589993;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKJXy1eO5vGiVrxvsBEG/GIMF2FHbHhV5DLbt20ey20=;
        b=ZCbzkSfK4HeJPKTFHuwoa3v5UIMiQ/5nbobdrpuABPJIbaVvty1Jm7gdEOQ8PZbRlA
         gLKOg36rV4CbDcoblL9IzlCDUH/jIIoeHq7epGGu2z4tirEbcwt2ZMBGYsqWrKNFo+Vs
         k0ZV6NdiDTGAccSGsrulU+hoF94xw6yoSbwj1lNq6Pd0uqvfnVPe544+a6DzqD24KLxl
         4juiOqhLd0scNXBmmpMvK0DjHwy3Slfo0D6Tjo8KLjf+33hSf8WAbq5JzUbDLbxrVZRj
         xqH0hWfAw/sXo3yQJW2ZRK7mIfg7Ix+X4cWHanP7SBLe/qmFUgvnmqaXMuRj0jTiDpUH
         ttyQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1iwc2fKRPqSLAoCWdme8WEObAPgo5WMuaXBHG3v6K4ftb6cVhUbG9rSHun2RISUlb6IAcjEMhAA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLVTqyfo5ssYpqQ7ubkhcxFVOUa3ID/GX6cgciMN+GZN6yx3aw5
	Y00GFjhG+IbjceJXPJzBE/qizSwyvRPMa8lqIQ4L+6VEbuBgMsrmFnoQTOLZF3pRtwDXF4MjRfp
	Q2z9NNdgqaPAIOwQ2q2E0Wv28yFMsb3aUz4jd44EZUY3O7ZqqP2vihBU0mSGBjQ==
X-Gm-Gg: AYBFou25gS90prTIFyX/Mt2gE/CPU3fDcGEu0TdOHRUrJAQO3ABas/RAzP6pU7ic8ic
	XYaXO5iKxDdgi1LwHzGcwfgfCUhrrvaQa148lJyUc/a6YPpChWoh24wXH6wF/hnwWisUzZZmSva
	6w16J+LGre8Xt5leqx3Hfw2OFX/QqLCLmsVZh2T43xSw8mzAXe5Gf3fF1FZgtnFyG7HIGOF1Cth
	mGmALPypx4WPp1IqZ41OkafukAzjeaXE+XhYEqnD9peqEdzlHUJy2iWeLUHsdoBgRBgczHRFdzd
	ExbtgoPA//iQ+QuBLIS/gfNjf/yYiGjKDJkWtUKcFO60QkVYXiKiHLrTwopc50ZBIi8drTUG1jM
	AdwN6ocnOhJQiRfA40Z8U08G0LxlS/a2L5D9gfTdD4bcwznsKafj2SLr1OYetv354+RxwhNBc7E
	gXa38/I9Vs1wtwaApeMUtetL/Oj00mh8cMP+Ih0TE8QSeFfrJxMjc9DQBisfKifmxaRg8=
X-Received: by 2002:a05:620a:2a09:b0:93e:b685:ae70 with SMTP id af79cd13be357-93ebd228f11mr2646645985a.26.1791985192720;
        Wed, 14 Oct 2026 06:39:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:93e:b685:ae70 with SMTP id af79cd13be357-93ebd228f11mr2646638785a.26.1791985191965;
        Wed, 14 Oct 2026 06:39:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203839a13sm1110061a12.9.2026.10.14.06.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:39:50 -0700 (PDT)
Message-ID: <26a3cd51-37ba-4b2d-8f56-cff4ad4de086@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:39:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] thermal: intel: int340x: Evaluate _TMP exclusively
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <20261014133013.94097-3-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014133013.94097-3-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6acf8629 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=yqPNUEQ4FSmsfWAeDTUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-GUID: xWnMSr1_fi_PLUcTg4ZdTOBrcVDziCs7
X-Proofpoint-ORIG-GUID: xWnMSr1_fi_PLUcTg4ZdTOBrcVDziCs7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX8toWKV96p6q3
 ISZ8lb8OOQ4jtMC8O1eCCJz3wnjdeIRLWBDgo02+Ix8hZ63pPgC57Asz5+gH+i+Lfo8BF7VZVBe
 1DPVyynUVP2eYXjT/i9ICkiKu8n+X69pcZMrFfu+npHtwmH/hfwlbWsAbdqPTBVncaLB2UlED72
 1HsXBwK85OtLIpbt38V8CHndwOJGPGwgnwwOt5jnMaHc7Eu50kHi2R7r5+uaEHPv/Z6w+ByIiUV
 crEp6yq+bPO4O7qmRtVosxGJ7WRiyU+b8e8elhgDoxzJeTv+ys+ke2+gqhtxbJ7lPJMP9AD8Ins
 AYjruzDGyHujdUwOcfj69hNtXzDt/DNtytV+bRsYNS50NoIcZOMJLaSeKk0ipp0eE7hiX8IIlhL
 semARC+00rIhaBfW02EJbO4d51qteozx/trPRh8zTGGFZGzxU/3r5Y1tITJJsF5o2wfej7JG+KQ
 XVTL/ErCH2F1g9A8n/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfXxJOCVXLduryt
 G84/GxqYY5Qa+AeXiU8+rp8bznPFVqLKXYlLTs/no6QUYRWOSU2p3bWxjfkghA/5raZLnKT9Qi2
 XfyFroEJVq/6ntEJ1J9uBwOaUNz2pmk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140054

Hi,

On 14-Oct-26 15:30, Ali Ahmet Memiş wrote:
> On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
> without taking the mutex the battery methods use, so it must not run
> interleaved with them.
> 
> Evaluate _TMP with acpi_evaluate_integer_exclusive().
> 
> Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
> Reported-by: Charis Stratakis <c.stratakis@proton.me>
> Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> ---
>  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c   | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 965700ee6962..de0a1fc7b817 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -18,7 +18,12 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
>  	unsigned long long tmp;
>  	acpi_status status;
>  
> -	status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
> +	/*
> +	 * On some ThinkPads _TMP switches the EC page selector without
> +	 * taking the mutex the battery methods use.
> +	 */
> +	status = acpi_evaluate_integer_exclusive(d->adev->handle, "_TMP", NULL,
> +						 &tmp);
>  	if (ACPI_FAILURE(status))
>  		return -EIO;
>  

