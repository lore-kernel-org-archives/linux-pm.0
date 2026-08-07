Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CC44237E
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104442; cv=none; b=Rja8abuhCvnZpNbPr+CroN5Esn2Y29q6zdFOuh1qn9hhE9j1ukxKdQlDGsrD3YnO3oAAz+6oqPoisjdQY/qlY5c22cXExAQNKK4LqSDOkiZ9B2CaMhk1qVVJvC39/F6KVD6oydgRaMk7i3Gu2QlPqoLp2HNaH0Bbh1j/rgZKLAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104442; c=relaxed/simple;
	bh=ehPxIFQ21Ol+ZycPPlarMM2wALuLgzffeeMI4q+2ToQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnDhP0f1/36wuUJPT88tLuXgyO31KnebG+ahXfz7DdsPkX4XPx2lVBabYbTdGiNgjkRZ6u3tHcR7isgW0tBC+B/w32JXbRVBIJZ3K5XFWEXGyQ42af91i5m1Ljg23melmzhXRT+W3Q7MDWvGwn45+prVZ6x1UEYLTLCcjXuPMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nD2LLTVu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ob8KhSJg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nD2LLTVu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ob8KhSJg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777gIqs3478244
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 12:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J5PnJPw5FcNJb0sJKMIKFrFpB7jUpmhAZkLfowS3CEc=; b=nD2LLTVuf553t+ER
	LM+hUnXn1yDSGlIUMYMLHCDOv+jUeoJiBeMnREcZ8wLtQ9YEvIORaGGNfx3wyLIj
	J0t7r/w4Jfdeg9Gs9cEfRMjiFsW4b0f8a9iLD/TcJ8gNN2+6yW++QuRekUdbl3IK
	PpaFaYsTbKA+4Sg1cLC4c+9/tnf0ICB3UmrKDmKKDz4cOmvqVttR/VkBdWFUP0VL
	neKD6ZffuAr0s9YOvq4dmZyfUM0qu7mnMRJRr+ZHapZoxF7mRknpoTpXgUSMEoFp
	lu0P3DptBnANXohS6z9fdCY5gdp3cIz1AINmYvACbO3aah87abn2e5j6WxSnU4fw
	9XvvHw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hbt51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 12:07:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5283fa0656dso24963401cf.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786104428; x=1786709228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5PnJPw5FcNJb0sJKMIKFrFpB7jUpmhAZkLfowS3CEc=;
        b=Ob8KhSJgrOFmVg9jiZPxWD3/XQa1lnruOMTH+pkOKaessR3LVZlRua7vL9rEg7vefs
         eM7NZB/75OOIUE4q6YqDWDNtBB6/B/N3JauC7QSKPbNxogKnp9pnCi6JYOlU3Mj/sAV5
         +HzFtEYeSlhjhkYbSe62HMP6PhrlSlyhh9XU7zH7fhQHm4G7UU+tOOdlXW99wPmK9deD
         zcSeG8w6PpM82gQ3s4CWXeRW5+LG4PJ7dctJvYZBuvutWa04h1TPabqzA74xOco8Hsd9
         0Op3YA707ntdeO3thbMVl4CiKWkFYxWaYUIDQLMR6El2+ItXP2YAsnu6SIAfQfjbgAW5
         Nubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104428; x=1786709228;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J5PnJPw5FcNJb0sJKMIKFrFpB7jUpmhAZkLfowS3CEc=;
        b=WZnn6WKgi8unlKNOrDIff9K6BjdSOFKJ+NjR5tHb30tz7iioW22e3GL4GRrxmADDEx
         YU3FY/jjwqaTXTUHk7wm3wl4hMz+AOHF1eRPvEo1lq26E15Zwzus+GXHDwF01fpufa1k
         PjqoHU5zm/Z4LkEU9Yq8NgmRB3gT/LRsTFkmViqHroAm9qdY70g0p9/6iXn1yBkl023b
         85Hxp/vXn9Fi5a3/lLZ45TAUqWMMu5MA5wsRJkY+mSPWz96+vJYAoggG/Vx0ax0v/dNM
         AmtpqqPv3TfmEnsnq5mEGRhma71gu3WC3165HQIGtDnO/iMnivsNNkqODZynXnudLUEf
         CwvA==
X-Forwarded-Encrypted: i=1; AHgh+RpDzA3xg6bhJHw6f43bANylxLGEDhDRGCcBb02Y5Vb9Zt6lYEEYDMJYJO6YR97Zhaj7Y8BOP9y8/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTF5HqFXgi9dLJSWHPVyDY0svQzJNb1A59VlYCZMUWatJjAJ6
	rUEZfwP9EGku++RDJEvqqEFyjk87FoYNlRlOg4jKpTjv65waurhQ284gv+sf8e+fmPt9WTjgmlI
	WKEj0oCSaLeW3TZjniEuAIP0dLCfN1o5+MzYj92rnSxwa4Hd1Kpmd15+kaQsGpQ==
X-Gm-Gg: AR+sD12AsdNNmj8JPRcwE90t2kn9GxM2784Lw1yW/WlpbJXBS3CtOEisFNGBwmoVJMX
	Xkf2Hady3FEcrGRWEe7RKVEV1vDHTqkQZ0BYBqQh33TqrCEp79eaEmtVe3Q3w8drVDAwMsXiqtl
	XpqWD8VdIbyKljOQ4jKFpfdL4R0PqiiIeU/rYF/Gd6FZzv+nzAJIlg2vFrlicoaA9qIHG2eLQgc
	8WQrt4T3CaL1EhIBsQhx0dVdzmTOafbnlipCXAfAhOUu1y4/jjrY5+CSYn6p19/kmWn+5ahbOL+
	hDMfLqG6YemWgL96rxgQAijWz3S7MqWdBtNF/fEbwVNG+v8LOJrAWU2jzi5brav3peKjvMwkuH1
	qa7Ej9OS8TULu7g5WPAW96kUyFK/qLlUEoP3NKlhcQo2Axg==
X-Received: by 2002:a05:622a:1646:b0:517:63df:91a5 with SMTP id d75a77b69052e-52cfb04c58cmr151076071cf.19.1786104427868;
        Fri, 07 Aug 2026 05:07:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1646:b0:517:63df:91a5 with SMTP id d75a77b69052e-52cfb04c58cmr151075161cf.19.1786104427457;
        Fri, 07 Aug 2026 05:07:07 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145966sm5365813f8f.5.2026.08.07.05.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 05:07:06 -0700 (PDT)
Message-ID: <70f39b10-c529-4a7d-b1b4-6d0f04b2e38f@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 14:06:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Maxwell Doose <m32285159@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>
References: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ev5MmpD_IGjD125xtwIP9BawpAVFgf1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5NCBTYWx0ZWRfX9EQFf1Hz08CD
 ULhIlquEd3Zvq+RwXCnWqfax/AHtuVgrvi+X1aTfmCVrrcLuHGzOA9UfILgnNkBCmsNdiIsAiqu
 daOOwx5ioun8tkDs0RweRl6+rCvvlbIaMVwt+tWxyOGINIvLFLzAFkqNhhQ6QEu6B0T1xHQVWEW
 Mdz7eMJemzArPEV8jVux1HgvTvhFnGeaw9kxgkOO6EuRpvx0VF1YPbu9Hk7hIFsRb0mGn1ferTL
 iA24iaG5GZDN+Ha/XQ1LkslL6pvTTy67U7Ttee6207ZUBr4fzPY/AYlNljk4gcx0MMcchthwbik
 eGixzGJV8EtyTy6qHA7I4L8fi9Qh97/mUSLgoXAPmmkclbr5GhOEEELBL/OyS033w/9HEkBFrPw
 ZV1UROIMXoHdigLP79asPBfkYq+lQsvBjZWtizuNEmX/j+PKojwHbZ3CzaUxC4wJYEEHEeiJWaJ
 8+BInyS54ol7+T9G3IA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5NCBTYWx0ZWRfXzRJXqouVQjl0
 Q9pRjCqdv3jEyvj517bp+kbF2h3Aza0E8rAxChQ8tAXxvBCg5WIRMngw+plvWRrR/DnC7PB+TIA
 GSktMa55b3chvlbm++/qiSx7Y2dMpd0=
X-Proofpoint-ORIG-GUID: ev5MmpD_IGjD125xtwIP9BawpAVFgf1f
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75ca6c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=RQz9wGa70jnH9Rp9_sIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070094

On 7/22/26 13:26, Jishnu Prakash wrote:
> Support for the main PMIC5 Gen3 ADC driver has been merged now.
> 
> In order to complete adding support for the Gen3 ADC_TM auxiliary
> driver, some more changes are needed in the main driver, mainly to
> improve its shared interrupt's handling mechanism.
> 
> Patch 1 removes an unneeded print in the main ADC driver.
> 
> Patch 2 simplifies the interrupt handling in the main ADC driver
> by declaring the interrupt as a shared one and dropping the logic
> used to call the ADC_TM notifier for handling ADC_TM interrupts on
> the first SDAM whose interrupt is shared.
> 
> Patch 3 adds the auxiliary thermal driver which supports the ADC_TM
> functionality of ADC5 Gen3.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
Applied, thanks
