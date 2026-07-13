Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83607306D26
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961757; cv=none; b=MsWd7uqLD2NF1D5KtQqIrSlSAqkhZulUd8rtGk1NRBMyQZ5Tc6Ike+U1AuLiY2JT5NRfmAJAkEnicS2NpWhncQtR5Fbi0D3sNmJvAhhFZ6lvHNcsd0X5FWC12uKD07S4ReAppr6PYVqgT0DqYS8+ZHkHaAYzJxIGLIEqhscqOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961757; c=relaxed/simple;
	bh=3N0ABRarTdfq54f1BH3wC39dBAKNrx/Lg+8U/uI7/mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYQy04MJiMTGcFX23cJdkCLXRVl5Rcv8FM8luvXwuSii8Jc2OYjsbym1q7DeDkIUmKPYUAIxm30dg5ZMEP19JNPdG5Pv6Qstb3AMDRReeFLg+6xNjcGDqQY5W/I/WEZL3sdZrkiSax0wmJ/qhsjQ5V1h8+NXhuBw7+AtrH/026g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VqQgExBO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b3UsKqdY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqQgExBO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b3UsKqdY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DG5HRc2030823
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e2l5AlR95TaD7LKI1gelB+DwJJ4uQc1DBAVxbTpujtI=; b=VqQgExBO2ziP4XXl
	LxBo0E/0b747DcAle8B0dbc0WkvL8drMvHnEqh9Q3gKBKfaTEIrPCNGMpkaTfEKB
	OVeY064Nx3a2PkiqsMVVaSePwnK0TQx9YHyCCi/TH7304L0xolX1Sp7deLkiBSK/
	7IJEg+ktDj0SdU01Q8zOFAR/zgbO4b0dQDtEwnBgdylwbzLYYxMDe+DE4IGCFudl
	S9IbOmNEhUlzMR+0N4w73ZCboDFyUcKTBU606dlc4pMHKt6ryRpH942izoXhvxcO
	4ut/aWwQxIsEYbzmQqrGnQDRvK5+linr2e7qpo6Qr88VHyTWra/6QvpYT0Vq8mfw
	Zlx+qQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd37x8728-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:55:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso4164953a91.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783961755; x=1784566555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2l5AlR95TaD7LKI1gelB+DwJJ4uQc1DBAVxbTpujtI=;
        b=b3UsKqdYy2TjBiShZaJzrBoCJgI+hyWRfaR+xe/87Kem74jAzuiFkSeKeJmzTmmGl+
         4VX2Y3dcPVi0uPM9mSBAUtz6sN7qdksrUFZTd2F+GpUXY1Ton1tpLcDgWqc1huL5Zyl9
         05hQjr9mu2qxnsxG7hKY9ZIqlMTa+V/KY47oCoAkyyqlKwDsVM8IiPKWS/TRmnPKQfA+
         vvdMnL1VfybOyhexBaGoD5gIiJqHU2IDTLGtxvfK/xgLI9lv/0wih7A0fPX6bq9XJXSU
         D4i8Wr4C+EHEFvFyX7fjGz1+ZzRH63C6tmZMXeLAjbuJItQX5dWFMSPO5iESiHsu4Yme
         8WOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961755; x=1784566555;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2l5AlR95TaD7LKI1gelB+DwJJ4uQc1DBAVxbTpujtI=;
        b=k574z05d/UHRNmV5GnS2vv3loyvELRBj9DdR9b3Z88draDqYZ+fV5rNi3Enb/8rci9
         Flb+uKP2kzU130kfaUdmi1mcP/oBSD3grSgVKs5BJ8SnpqsA8XZxl+eV2O/4cs8sMafP
         O/Y2SFvl6WDmZYYEngS9oNXB5aX/ER1+i2ZRtskOE4YFS95bMWR8xVDYdMyFrfMcHsgB
         2OfSqvqmufC0cEG++NQPg59qUoS9orua40Ljy09TWG5Vki0YW6ZJICx41dFrwLTpdm2q
         kP3Dzlupc3LqMmaThtJWkawEhY03cbNgLegfUT1vGInX85p3DyxU/As9zkrLcItxCVij
         0uDQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3pkwdhALJBwc2IfIA7AtbIBLFWkNYYVguGgirkgp2SiBrBxfO9cgYGIZORU2s2qYU2YzBzLxSww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiIONf4uOYsW4mEit5icEcWuRt7CS+w8UESpaQubMfZ6EfWx9
	eGHrrd6EsEMne9NLoH/Psf7ttJRzJhj/RQJkPw4pdEGrYqnRvY3LrZ2H5Anvmj7Arla77VpBRAO
	7uJxFl+7BexnXrK+jW+ClueVItXpXJn9hauawlOlsILVdp/T8BCGIRG95OvBlfw==
X-Gm-Gg: AfdE7cmFuu3Ca+lbhQX3Kuy257GIXqM0wbKpp+/pK16ffJwcjdr8VmYpZmM5/LFqieX
	wykyXezEyIVC3rk/MRCQmflKnEUmVbtph3Yl6IyNgALYIdKaWe6qrTESaRFBcAerQpIzvsv6Npw
	d65NccLOY93HWfIn0hqI2+YhhqhrfPJuJAtUg5XjmnkoZ7YHvA3yFCKX2wtZMNUkHaEiLGiJKeT
	uetpVIt89D/ZNXLY8dKqFbpbwSui8tvIJfz+S3W/A0kJnoAs5M3MxqFtEFXtKWi6tH626bY4E4B
	0Nev/9x04PARCoHGRmn8fV0lblJGrkY56XC9oJipMXUXY+YziaNyevPYyk+0SHvBXcVEgGMOdfi
	YxfCL7YG3MDmxHwx2fqscTpLkiMR3XIxpQfd4wQsxJsZfcw==
X-Received: by 2002:a17:90b:2750:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38dc75ebea3mr9509016a91.16.1783961754972;
        Mon, 13 Jul 2026 09:55:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2750:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38dc75ebea3mr9508992a91.16.1783961754510;
        Mon, 13 Jul 2026 09:55:54 -0700 (PDT)
Received: from [192.168.1.100] ([157.48.180.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm71653953eec.18.2026.07.13.09.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:55:54 -0700 (PDT)
Message-ID: <d47c822a-8219-482e-921d-f129e6dc5c84@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:25:43 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
 <aktArynt5xftgij1@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <aktArynt5xftgij1@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX4Jzm8H6srzvI
 BSjKgj0L4zP3sv1AYpoiGffQeNm7D4mQrkvvyg0fKuLrKPGWAj8w0E7rLSGvXAPe0Xnz5A8Fd5C
 EVGEAQ3DuxRHT9sz0SnB/zg+mS0wgHyp96QxS/PPcf/d9Xn3s8HBMQ9u8Vgp968iGuHowAum1Tr
 4Z069Lr2OH4KCEinUQZsWUgMRpIGpBo4G0ZG9eED6VT5HayFeLFBCnBRiCAKbasVDh6dsMAv77H
 322JyH1HKxNyv7zO6eJhfYC7tnHooganZLetHBtaE80zTv9zFwG2BF7WBV0OInEF1bl2zheTJbk
 Rx/RJVtiOBtoRXLZcdLNpBuMIczvF/qjRUwunpfNHaQ8MQtmlVGpyAOVYKKZHhbQcVpo8NYNTiA
 vfVEmBqfwAz5Yj+wyvrv6ZlR6sj3zl44+YQ/6xCUXTXfw6IwMysDjMK6qPAepe+aEpZFG+GGIqr
 wkoQO3gDY4LuGS883Xg==
X-Authority-Analysis: v=2.4 cv=BNWDalQG c=1 sm=1 tr=0 ts=6a55189b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=62VzjLAzdHZQ3L95IMgkXw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QyXUC8HyAAAA:8 a=aSuIdP_MvOpnUHuhdBcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: tGUn3OnwbbE3DXIfkclxCptVk-ryu7sB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX4WONBkN3JZ/P
 9ZytBD3Wu8B6ftpe/Cb7MV3/pXfsKZpVkqqXI5qJtaTqSfRuvetM1KZLfLMuEAvHV8db8OhmdUs
 S+m2xLsGeOGw9vpujEw1ajPiH4lF2Zw=
X-Proofpoint-GUID: tGUn3OnwbbE3DXIfkclxCptVk-ryu7sB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130175

Hi Andy,

On 7/6/2026 11:14 AM, Andy Shevchenko wrote:
> On Sun, Jul 05, 2026 at 10:23:34PM +0530, Jishnu Prakash wrote:
>> devm_request_threaded_irq internally prints an error message using
> 
> devm_request_threaded_irq()
> 
>> dev_err_probe in case of any errors. Remove the error print in the
> 
> dev_err_probe()
> 
>> devm_request_threaded_irq failure path as it is not needed.
> devm_request_threaded_irq()
> 
> This patch should go first. The patch 1 is not marked as a fix and we don't
> need this message to be printed even before the patch 1 of your current version
> of the series.
> 
> With that being addressed,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Sure, I'll put this patch first and fix the function names when pushing the next
series. I'll also add the Suggested-by tag as you mentioned in another mail.

Thanks,
Jishnu


> Also note we refer to the functions as func(), id est mind the parentheses.
> 

