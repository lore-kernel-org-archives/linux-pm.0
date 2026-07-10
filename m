Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313F36493E
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 04:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783656699; cv=none; b=u8RmqSKp+Pys6XBZXKO9Tqz0RbF9PhdDY4XKNLEhzXXVmn1ybvFaBBU7zEcj82U/kHKx/fs0/CGGwOZuRcseIeU0auxE62TXFB6o+RYqH8C6horkvEHr4WQfcvZfI0zZSchwaEt70nEjC0briIl62J10rq+PqZS9e/qBVJXNuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783656699; c=relaxed/simple;
	bh=LfFIKIOcm55z/amtHtkeCs37XEJtSuSYSN8HZUHOrRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=as/zPHkMikUzz/Mv7uNE2rR2bV8vJn7+tLtxqBygWy6n87hG+GQOmwzpmjMyk2eelnIH5Tuxu8YHKCv34xpuUwYRjhLwTSQ2OqnKfdbXeiNy3pAo52glPDpUlganO2ibuF8QX9popVsjQiynnaI1a0hRzVR2mzdbztABtKGBqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gSyaD+Vk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F+cQjiPV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gSyaD+Vk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F+cQjiPV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3n7C63661843
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 04:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FKVns+xih/NaHnE7xaZ9w5LtVBrsREGYlKhm+lRa+Ao=; b=gSyaD+VkX2sfDi/T
	5hpsgGIUT25JEfmeh77dPtu+ft2wW6efCMtYviLn3vy2GHIh98iXNn37QE47P2o7
	hBCi4R/IOZSfi0VLkkk8QwDlj6Z4v8JBi7ATTve0uGnKKiDTpjiBTxvcQRR7hLhj
	XUlSHLvcpJGyOtk3WmlKJtxZV8ltBAyApMwzYhHrYRIGX2Bh8/p5czEIuD4VhfXG
	4CdBz6MaJ9PVLFwtnWAOEb25aKzDo+I6SJErXfzY/TPtVgEMdyFhWlwC20bux3uC
	rKGSzQDx9DgpdBB9qU6NSZ3Y2p0TmEPPZd7l/dYx9v6wItbdw8lWWFjw2eCv5LeW
	n66Bew==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24tdpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 04:11:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cccfa32670so6574865ad.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783656696; x=1784261496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FKVns+xih/NaHnE7xaZ9w5LtVBrsREGYlKhm+lRa+Ao=;
        b=F+cQjiPVZSH1LehALqsOxAAaiANek58OyhD+kj/gbQT6/PZsz9PkiUJpOZCmch71ar
         7d6SdoUGjyd1/3UQMAWvstoRTmRGJweuGPghBqG8LixAkKhK3CAIBybzWa5z4g+VItiM
         a5ylt6i73vmICkL9csfXqo9heuzDHxbDTBLo642xqXH2cULFwPxi9C8JSlOcnruwcmkP
         HkjPTtBjZBGGeemB09k6KOQ1tffQDcHCloMyxC4vQoEz8KK/UQvmyzk3TsT7m5D2mdXZ
         D4aWCmbPUASz7xC2tPkhu789/06Zm9rhnMVQphtWoyPdLws7BpFMwy6sNo0WtoyGfQfJ
         8WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783656696; x=1784261496;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKVns+xih/NaHnE7xaZ9w5LtVBrsREGYlKhm+lRa+Ao=;
        b=O8XpHxfCjXK/GIFWnnRb3+6ueIDMpwjT9UeLlJlh+TflqrRopxfwwV5P9EzrPwAZxU
         X4gumNNJ2eIueO3rWxX7J7MZ05q6hh7Q/qjfHyA13DX4CuGmSZSMIbAolEceKTdZy6mg
         AL4cFH/cg1b2oeatxNNwKh/c4CTqAb5wF2Ag+7oV4xbq39s1vHll5TGUNDxndpoHE8R6
         mRb92H4pGeazFnQnqdZbXTW39izPHhYMsPlUpQDmdS8Ip1l5w7hHrfhvcmkKkz57bXjM
         +WnaaH2q0qCXguVURdfYp7dROrOmYkhZjPyASRceKtGgUmOGdyjXeUjwYWEM2rNARo7M
         Czww==
X-Forwarded-Encrypted: i=1; AHgh+RrNReEJSFr4xKfmsu5/VlhbiHCgqy+5y8aUxZKnJkINoAu0aK4bg5qx5iX7j17IF4lhcpmRxmDSMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+C/cMoNxIB3mCvcbfPX603iyW2Pzt98slt/B1YXChHipprp3D
	qkL65NdpDt6lyGrdDZgq6zOlObyI+8Kr8wF0i+lac2L+/M7DjhDBOWcEfQr5YSQu17aNd7j1vpQ
	oop36n7Ifp5rPCgt5zGQw1JgSZ2xG+iF9Mw2AypjxH4AAAhNVfcubVNpBflueBQ==
X-Gm-Gg: AfdE7cmbrRuP8FrgsU0O6cxQLlQEPdvRx+GGczeiX9+wRq8IctThOF8zvcJJpFQ6Kpg
	u7SyCoOXgRlm8YLePPOWDR63L9L4CB6XgYKwIU2JTV8Nb5He5WR/LjSRDF5MVsAOjFi6rZ5PDkc
	/Ei+L9vo9RMsjs0xKSkBVJNgDR2JsBz0ACaVbVNNEB9gv/cbwXLePIG6+jt5KqcY0pphZqtifF2
	elb4nmOtuT6np0Gy7li9SPv2c8C/NLuBcE1BjIoE9LFrHlM8w/brzOljDEeUfPb24wTlMddZhRl
	SeMvf9G/XUdqlUfc4wJCRP1o+qis15lZux3uhCDs0M2HKkOhZ1OUS6NDKU0WsKz1hJmIkKaqYkM
	4BReajrMlAOchGvWl7rCcLIUT+HKt0iwrO5WzfuT5btc=
X-Received: by 2002:a05:6a20:4304:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3c0bce1eb1bmr11867078637.3.1783656696009;
        Thu, 09 Jul 2026 21:11:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:4304:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3c0bce1eb1bmr11867023637.3.1783656695407;
        Thu, 09 Jul 2026 21:11:35 -0700 (PDT)
Received: from [10.92.212.146] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm34378016c88.15.2026.07.09.21.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:11:34 -0700 (PDT)
Message-ID: <0e52adba-dff2-4cc3-a13b-758c8d92e60e@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 09:41:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
To: Mark Brown <broonie@kernel.org>
Cc: Dilip Kota <dkota@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson
 <dianders@chromium.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
 <2fe34b3c-11cf-417e-9440-75a5d6e3f4d7@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2fe34b3c-11cf-417e-9440-75a5d6e3f4d7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5AkKphGSQR6ADLjBjlr6C-6qN9zqwm-t
X-Proofpoint-ORIG-GUID: 5AkKphGSQR6ADLjBjlr6C-6qN9zqwm-t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDAzNCBTYWx0ZWRfX5gIW0eicVvFO
 HlyynRQ1mPy0lRRtccv/+7F11YuZYb65H0Pmwf71Wjm42dc1xKsN4GpUtI/ytXED+g28FqHiX6l
 bj9mz/kBOLN9lBT2bvoymT1TfFhB4cE=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a5070f8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=BZ6NEH6zplJ_bYS8KZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDAzNCBTYWx0ZWRfX/W2cA6KCwki6
 NUFppg1xpIBnQtC91IrUgg3xRgkCSkk9b3C3Tu1OwgLh9xAxmWlkj1yZQMTPMcMolYAWRXlhwI9
 jHM41ZQUJcML4h9Tp5rHYUAhGVY0iC9H3nFbmfx3XtYKyPwj//V1Q4o3XUpZDLCJ+8siKF4kpt9
 BXG/ZqeCsYQAZPNlxSiFPwQJdhoJ3izphPuZrdM0DPYL4CxSQiUPllgvF1t/2+vGLPMQNJFp/Z4
 guwk8wc5QnLqi9C/moeayf2K5mCQzmqHcx31EwHF8Ym3qjAxb5TEnM6V2PbmS3WgwBiFCeiVm+H
 RiBnPtwRjso5miXOBuaoe8THvYHwrgAb96kbHQ9Nb5FtElTmfCjkJ7aP6DVHS04W2jczRs7llZq
 dmBcgUVNlm69fnNRt35TIZnN/jLDk0a5xySqDhOm3bJRJwI+jWVQUcGBI2m1LLBa3W0Tuk8Q1YL
 iI260kHHQvMj35yZEEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100034

Hi Mark,

On 09-07-2026 23:59, Mark Brown wrote:
> On Mon, Jul 06, 2026 at 02:23:10PM +0530, Praveen Talari wrote:
>> spi_geni_init() calls pm_runtime_get_sync() to power up the device
>> before accessing hardware registers, but never checks the return value.
>> @@ -693,10 +698,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
>>   		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
>>   	}
>>   
>> -out_pm:
>> -	pm_runtime_put(mas->dev);
>>   	return ret;
>> -}
>>   
>>   static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
> The above breaks the build due to removing the closing brace for the
> function:
Its my bad. It appears this was inadvertently removed in v3, although 
there were no issues up to v2.

Please let me know if you can add it while picking up this change, or if 
you would prefer that I send a v4 with the update included.

[PATCH v2 2/2] spi: qcom-geni: Fix missing error check on 
pm_runtime_get_sync() - Praveen Talari


Thanks,

Praveen Talari

>
> /build/stage/linux/drivers/spi/spi-geni-qcom.c: In function ‘spi_geni_init’:
> /build/stage/linux/drivers/spi/spi-geni-qcom.c:712:21: error: invalid storage class for function ‘geni_byte_per_fifo_word’
>    712 | static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
>        |                     ^~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-geni-qcom.c:726:13: error: invalid storage class for function ‘geni_spi_handle_tx’
>    726 | static bool geni_spi_handle_tx(struct spi_geni_master *mas)
>        |             ^~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-geni-qcom.c:764:13: error: invalid storage class for function ‘geni_spi_handle_rx’
>    764 | static void geni_spi_handle_rx(struct spi_geni_master *mas)
>        |             ^~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-geni-qcom.c:808:12: error: invalid storage class for function ‘setup_se_xfer’
>    808 | static int setup_se_xfer(struct spi_transfer *xfer,
>
> and so on.
