Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AD3CCFAC
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754435; cv=none; b=IxblSRKen6AbTSBK4x4V358fJisILFS7oClM8GOib7o0LwrThG8UM6hvzHyE9Gjvfr+ooKSCqYRQ2G8d2/J4QlGpH10y2KRZsvqlmGtor3OwhDKH3ogylDCdbMY34aO/QuQLH66ZldW2NdK8kcDrnIVRuymYmOukHmDZ7bfLUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754435; c=relaxed/simple;
	bh=Mpz/Sc/ut0331NTCJ1BV9bZyPaYbI0gSsTGxrFfabf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuF0JqT3Jz7jD0/ftNr2ZGp8l62xCS6Oc88fwVtX4Rbjza5xwW05h0GepqygTYV1T6xiS3PZ81kTYQ73FXKbXqivQopapUw6wvYEaXkzeHJPUbPw3Dsv19bNFN2QnHL2gZkD6rM/8IAX5HUuLD2px1L6B+NRjfp0gsAJkm9aNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EJCNrJW4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HGb+1GZK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EJCNrJW4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HGb+1GZK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HA39Us2071571
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 13:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nrfSBpYfuU7fuCXOmElhEgTL4oQWE3t5gcQmHtiRnM8=; b=EJCNrJW4Xy668Xr7
	2KNfE1I/OqVb+IsdBS3118/BGDyp6Sa2ovuPg8WyJKXYNayi0HwKm9XR2+06PbOP
	N7KtKH9x3IsLKCOPQNCfGNrRVAQ4j0eZZNxpp97m5FJHi7m/V39JU4ZJjwBM5pBn
	sowT1MJz5MFoK4GhbqZccN/utOmkAZNdtHGOLL2y9Z36jnbm6Qxz/+O7Ey/YbowL
	cukbPVmdPFSwa577rdjlOfQp+sjDTi1gEsw5sW7o/J7xIlEJV9Q5P8e2IzUA28xc
	M2xsltn/NTq4ccVrFgP0Sn8Ae+Lu6LexmtoiHrTYTp/zFoQ+7oZk9XyAT3AgiBQd
	qhZCIQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy4v6rp8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 13:33:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b056b2f0cfso30894275ad.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754431; x=1774359231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrfSBpYfuU7fuCXOmElhEgTL4oQWE3t5gcQmHtiRnM8=;
        b=HGb+1GZKWopR5GvooVNFDZ7Q6jh0sPnhQQ0QqeKvuLHGCCOLI/NapGMgSfjnzp91DJ
         dBYzkCLJVit0JQ4XgVm0K3bRgwRAY22tBXBTdL0fXzaU3ylo+L++1iU+vhrB4lXFBUch
         dT89uu/PdDrrKppySWjIp4Y81iYsp2IlFhkDcwGvH4YGn5ujxO3AbXSe/yBeThLa4p2A
         sL7QKEP9Ym8MHObdT+ZFCnOar3C6Tx57n59rRjNv36EnR/nriyxy1YJc4UqH9JyLiWdI
         h/lP44TslcxoLtEIUKcBeKav6rVK610lCn3+Z//j8pF7OCVQjUQSfscqpDjA0oKg4A8D
         eWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754431; x=1774359231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrfSBpYfuU7fuCXOmElhEgTL4oQWE3t5gcQmHtiRnM8=;
        b=b/HcsWDW7AG9wo6AWo2w+X1iqHuq2YCD8DbEkMOXnw6z0QPNznbuBEVwffFX1sTbp/
         wOe8tbdYnENX+OvUSu0zBhh9zvV4ipddxxfg8ow6tf/4jg072dCwXzS5bNJ6NkFKnYQV
         IvtyLgdDKbmeDx8WeJsRN/N02hKqfC9iHeK2WeZazWSkUZuGU6Gmokv+7qecGUUITpl7
         w7FztwsRJ+1mpmB1gPijP+5Vb31EL1t2AxQ2DHAa0BXr9UAAeJXxSf41O6wAcD88AYBQ
         chcEmlOHl34qkQPyq4OpWOZ9VeUDCWyMw1TTk/lbpn3l4uYqV+VHsV7QSGrWonRd+L4g
         aBqA==
X-Forwarded-Encrypted: i=1; AJvYcCWTh84o0cVqFPfCfrc2NHLsbuwccUtIfGH5yK8iL7cghzorwcXLRJSF+4m+QpPgSY/dZd0txZAdtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdDrkNmljuTNoIcjMOZl0s0cB1mmHyH/JMjDHWOl4rh5SGmEG
	/pyBd7dbvsZsecbUzIS/hiPM9f/f0BJN4iOQun2Iw8J8rkvAiee6/Pmwk9+VeU8vuKzwEL+latt
	dOJZOLZ2zLRohHbzjmcJ3Ae19qkYkvZ8FRW/M/yMNw36fOIhXWjwkmrqeWjgj4g==
X-Gm-Gg: ATEYQzzhSYrl3a2BV4UMTkNLLysPIVWMHjE3+MTO90/VAPvU+srGDRONm29Y/BxgIhk
	rmTwEe8/mzLHUP1WXnCAK4bzlY9Zh7l4vdFwmGJwjwNeu6IVIK72OI3mTFU0tiqI75YAIs4vP+X
	bj6f5QwqCTgZaOF5MAbu0y/2GKZT0mo4Bb6oLvQkYmXi9LKAAPYRcJnfR74vGMC99bSzzmAlWpp
	dvDQC91QwuG7gmXDkLQKA9OfVwxVQNsUV/ZIgreo9ggT5GtUAQpXsqjwfiHHoT5n8ad801yuGLE
	NtHhyBu3WX8UTVXYT2E+clo2gYX47ZcrWWxAxgKO//u16KpZP1NupCeDuGF1esHikyHS8fy+9R5
	XSxvC8ZPrVsA2EZezxXPDms1dHfqWRLpHfWXbZ5SjPhRX7ePEE+0=
X-Received: by 2002:a17:903:2405:b0:2b0:6d2d:f1d5 with SMTP id d9443c01a7336-2b06d2df3aemr1784015ad.45.1773754430839;
        Tue, 17 Mar 2026 06:33:50 -0700 (PDT)
X-Received: by 2002:a17:903:2405:b0:2b0:6d2d:f1d5 with SMTP id d9443c01a7336-2b06d2df3aemr1783585ad.45.1773754430233;
        Tue, 17 Mar 2026 06:33:50 -0700 (PDT)
Received: from [10.216.46.1] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed9cdsm146854525ad.60.2026.03.17.06.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 06:33:49 -0700 (PDT)
Message-ID: <cb11a2d5-fc4a-4956-91b8-95bcf9e7d7d5@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 19:03:32 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: daniel.lezcano@oss.qualcomm.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
 <20260130115421.2197892-4-jishnu.prakash@oss.qualcomm.com>
 <20260131173941.68b8116d@jic23-huawei>
 <6012ad64-3a10-4f05-9f37-f2d0c36df582@oss.qualcomm.com>
 <20260207165638.0ed27302@jic23-huawei>
 <70b77d54-a6ab-426e-a7e1-3e011adad6d4@oss.qualcomm.com>
 <20260223203145.4a4493a7@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260223203145.4a4493a7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 45aXcEDp5h2xMXH94wz3V2jFBzyBw3WQ
X-Authority-Analysis: v=2.4 cv=Aa683nXG c=1 sm=1 tr=0 ts=69b9583f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VABx3j5EmaUy11-GNHwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 45aXcEDp5h2xMXH94wz3V2jFBzyBw3WQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfXyd45umlFssE5
 1rSonO3Lc6+4Z01aeRvKTplQOW48pZb4TeYf7xbNUtPwjq5bgz1Sz/01imbV1GV3DyR8Hocc3iV
 +/cBQXP9DZ8fKyNMgB2a2wv/eACNj3vbHRiJTSIXo1ZHe80kKaZqmrnb7Pbz6sYxVl2ddBGsx1X
 56UF2T6WYBzaGBwNgfbottJ5U+5bSs9lqKQuue5mOO8hV6eFRLdbQHryh9nHl6PbFqwjeJocb8l
 YwuGMOKzK7wVnqMIYyzdYnnZDpAUPjFXXQHIiWZH1bOb1htWGW29pR4abAjXCa/m78oTSt/G8/y
 pe2TitdCi0gpsReSzXCxhW/+19el/E5sGZLlmtlrVaTWJyhRsDq9HH0bn9SMa2UjByiFx4N1lfY
 8Mr2sPrgRy2b/R3LsvFA67YBZfgxU7lb0QZcpa/rf3lG/SwJMu9YZwBMoG520gtJjaj85EOE55F
 b4i0Tn73SkMgN4wKb/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170119

Hi Daniel,

On 2/24/2026 2:01 AM, Jonathan Cameron wrote:
> On Mon, 23 Feb 2026 17:49:18 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 2/7/2026 10:26 PM, Jonathan Cameron wrote:
>>> On Fri, 6 Feb 2026 18:45:02 +0530
>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>   
>>>> Hi Jonathan,
>>>>
>>>> On 1/31/2026 11:09 PM, Jonathan Cameron wrote:  
>>>>> On Fri, 30 Jan 2026 17:24:20 +0530
>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>     
>>>>>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>>>>>> with all SW communication to ADC going through PMK8550 which
>>>>>> communicates with other PMICs through PBS.
>>>>>>
>>>>>> One major difference is that the register interface used here is that
>>>>>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
>>>>>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
>>>>>> channels, which may be used for either immediate reads (same functionality
>>>>>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
>>>>>> (same as ADC_TM functionality).
>>>>>>
>>>>>> By convention, we reserve the first channel of the first SDAM for all
>>>>>> immediate reads and use the remaining channels across all SDAMs for
>>>>>> ADC_TM monitoring functionality.
>>>>>>
>>>>>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
>>>>>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
>>>>>> driver.
>>>>>>
>>>>>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>    
>>>>> Hi Jishnu
>>>>>
>>>>> Whilst there are a couple of comments below, I think this is ready to go.
>>>>> Unfortunately this is just a few days too late to merge for this coming
>>>>> cycle as I need to send the IIO pull request today or tomorrow (due to going
>>>>> through char-misc) so this would get no soak time in next.
>>>>>
>>>>> Also, I'm not sure how we actually want to merge this given close coupling with
>>>>> the thermal driver.  Perhaps best bet is I do an immutable branch of next rc1
>>>>> once available that we pull into both trees. That would have the first 3 patches
>>>>> on it. 
>>>>>
>>>>> Jonathan
>>>>>     
>>>>>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..f8168a14b907
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c  
>>
>> ....
>>
>>>>
>>>> Also, is it alright if I push the next series to address
>>>> your comments immediately? Would you be able to include patches 1-3
>>>> in the immutable branch you mentioned, once it's available?  
>>> It's fine to post a v11.  I'll only be building that immutable tree
>>> after 7.0-rc1 is out (or 6.20-rc1 depending on Linus' decision on naming
>>> for the cycle that is about to start)
>>>   
>>
>> It looks like kernel 7.0-rc1 is out now and I had posted v11 here earlier:
>> https://lore.kernel.org/all/20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com/,
>>
>> so can you please check this latest series and pick patches 1-3 if there
>> are no issues?
> 
> Sure.  Immutable branch created. However, I'd suggest the thermal folk don't
> pick this up until it's had a little soak time. Today I've pushed it out for
> 0-day to have a look (as part of the testing branch of iio.git). Once those
> results come in I'll push it out as togreg and linux-next will pick it up.
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-thermal-qcom-pmic5
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git  ib-iio-thermal-qcom-pmic5
> 

Jonathan has picked patches 1-3 of this series in an immutable branch and I see
they are also present in linux-next now. Is it possible for you to pick
patch 4 into the thermal tree?

Link: https://lore.kernel.org/all/20260130115421.2197892-5-jishnu.prakash@oss.qualcomm.com/

Thanks,
Jishnu

> Thanks,
> 
> Jonathan
> 
>>
>> Thanks,
>> Jishnu
>>
>>> Thanks,
>>>
>>> Jonathan  
>>
> 

