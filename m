Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FEA3F0750
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504160; cv=none; b=DL3Hva5yWbbcqATOqyVU9V1DyNJgZYVIVvjuTjrc7jPIJR/8Uut/Q+wAthZp5xh6KtgWeYEh0GiqHk9jb9Ll/FyrJIZ1YU6hlQYNHk/4/EWnhblnpgMaUSI+IhpxjLF15DglSqNClrylaheLiKmi5egxHxP28t6hCq+dEV1dsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504160; c=relaxed/simple;
	bh=uuo89+sAtKtyJaPS4V9rNIjPQmeUr9B7tn/iPGDAsbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BybXjX1FDXyS3WZmYEguPaQ9TD4PI5M1sg290ZUI0BXTSOhadEhxF0NRULbl5BJz3gtqOI3TLUaEqmc0FZ4/nvoytxg+RQP6QYUEp3MH6LML0aRui6OwJO6trc/HND7ka6RvTv88iIT2JSLTiIBoILsQZj7Eyestqfi3ZB/Vfo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AYF4gbzA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MVMjiSKF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYF4gbzA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MVMjiSKF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmA1m3905278
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 13:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v+9qjsOSKXBQy8fGWCIsCrOpr3B6XcgBZrg078GxUsY=; b=AYF4gbzAlx2+5pWP
	UCsAFA9KAm9t1IY/bhHWSy0pT0/7pqVfjP/h/VN2f5SEhaeebEeWqnsmiUtqS0Xk
	llekquycx4Zalnc2uTsNorHi+T1+Y87HYc5a/T4gHNePogc56F2ZJ5kdsQ2SXSw3
	2T2TZ74706nU8VOh+f97wuGPiiPWgndMLlarDYH/FyNn8Gn0ccujkF3AeD8F08wd
	vxerm1UDTMeLa/v0nA0X6OulBlJinHr+kubgPc9uOaIg/9RY3VmtQ2sOhMPnwZGG
	HqCDT75yycY4dbVJDJns5o7mesOWd6sQeCE9obPPlm25QvvxNIElRnHTmNztmO9I
	UXq0SA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5dgck8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 13:22:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so26827955ad.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785504157; x=1786108957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+9qjsOSKXBQy8fGWCIsCrOpr3B6XcgBZrg078GxUsY=;
        b=MVMjiSKFzWt5zZsNc7PPWTuwWrsE5alsvRGEdNIzfXxNz32pNsK5vmIaqlFjmLIaps
         XcKJYzEVabxjCK0XpdN0b2RWpCkDWkr65qgErjmcQAZg4AkYZfCr8Zz+frSrvlAsaokQ
         PEOWO0WriNaxPip0k5FdvA9fvKtunhM02wRrHeGC3l4MHdImcbP8/LKsKhatJG7zLl98
         CEXoUqe0H6XuIwHzZbpNwSDQAp/QgOIWvj5RU7M/PleJepJ480SK5UgZkIUIwdulu/6x
         5W4ung6/R3Tz1PEYy7EKprn58iLUzOmOpT5iSBIIknYMQ/wf+ZbnsS8SRhw9NJZ1WiEl
         xcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504157; x=1786108957;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+9qjsOSKXBQy8fGWCIsCrOpr3B6XcgBZrg078GxUsY=;
        b=EEt1v2UmEk6OCC4RtuQlFo9GIKfb8JNmPE4wNSo5fah+VeZq8E6E8OFtn/f6EmG3bS
         22yvWEPEhcsFp3TnzqvL6ZaicJuxfOaWM7ooF+FB0d2X/TbIX5y+iUCTV3sBWINlgoad
         pPW2WF8azFmnWiW6boTTXuK7rz1j9rPO2ZChtxU5mK6nN83rgqoquiWHUbMB4Wql1GOo
         jbxkFuDP1bItqSd3pdrL4tmv7AxnUEEL0RzYB8LPZl3My9yDCSPzLHHlreuQYEyVoKMV
         w1OXVKQVWnvxSoUfjPuI2o0VSQh7W0vo1ExIu3je4qYFymyaJW2PMH6A7AJ0QGkWR1RK
         V0tw==
X-Forwarded-Encrypted: i=1; AHgh+RpVRjjhqOIIowW42+Zx/hmChwQqV8h2E8m0YWeHmpjJ+6eu4W6yXpe5Mg55PObV8e0aSjtapcj8NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXPy8bjBNmf2NMECCK6ZM0HhQbkDtcpNCRUsv460eOrXVRlKc7
	gNzaryBXtAhUBVFloZ0tbcNw4zBrHPNEM5hqe8MZ7740Rq8kPzrRSEPD5JaPGsWv8LwkGM+Al1m
	mPyyNphFLr5jQZAXRc35RBFWvBmsqG9+e3FufSKTM6BgeJ8+t6RNhkTuM+Q/ccw==
X-Gm-Gg: AR+sD13tW5vJ8pfMC7HfeazUeZCMD9QPpnp02+tVQTYnZN3G2PjPzBshgSF9LRQWC3v
	YDgptM+w8WKgk4gfecq4aGthJRduWjgFfK2pv+BxoraQFnWPpsWZ0DlMWn5tTxrrjosUI0Ui3Rs
	4zZ2+mYkSxCDkZouroDRsKT1Oyf3G7SRzeFjeukkwlGgVytlwlAXh7MTh2l8S0nXr9n497832Ee
	PlVUjzO2W7rqk+dYL5/BNVRkezE2h24JsyZbqpm70S6H49vkt84ko83QorPsfaz+sNkYeIlOoWv
	1SJLF4eL5IYIssRKoHnVAUYs+FBu5AEa2m2HJvfIWBFwHYGIKaFJLY8Ryn8dt2KLtGtNnxfAEsi
	hRHXhStDUtecB2qXRZCoJMKYh4VVEeQo=
X-Received: by 2002:a17:902:e84d:b0:2cf:84bb:1ebc with SMTP id d9443c01a7336-2d0521e9e05mr385255ad.15.1785504156907;
        Fri, 31 Jul 2026 06:22:36 -0700 (PDT)
X-Received: by 2002:a17:902:e84d:b0:2cf:84bb:1ebc with SMTP id d9443c01a7336-2d0521e9e05mr384975ad.15.1785504156518;
        Fri, 31 Jul 2026 06:22:36 -0700 (PDT)
Received: from [192.168.1.16] ([106.222.229.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19ecfsm5401795ad.10.2026.07.31.06.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:22:36 -0700 (PDT)
Message-ID: <34998a81-864e-42fa-904f-2e5f3490fcf3@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 18:52:24 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
 <20260731-b4-qmi-tmd-v7-9-3befd44403d5@oss.qualcomm.com>
 <amyFARId5K-Izco1@linaro.org>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <amyFARId5K-Izco1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X5ndgSKtJ_UfUJk9XcSr9JqGhwIKjtuE
X-Proofpoint-GUID: X5ndgSKtJ_UfUJk9XcSr9JqGhwIKjtuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwMSBTYWx0ZWRfX6rW+VpOjkKcs
 pkAreyPTrP9kiCJWcbwUZ1T/x4gdTZqrC5FUaKJKCY9PWEIxjO7twvtZwwAqJnTG5SbUzyasnlf
 VED4+RD9momYOkSzo+21E6HdOt5XRx/EztlJni6caXtHA8Bk9RSaRSQ5wtyAz/7Qd8jcATrq21O
 whf9e3IVI98qwauN/margBbiW/X4O3jXtvDObygIDgXRtrp31v0UcfUpPX/yLvsNz0Gu2lNwiHY
 A1fvhbrK/Il1doD4wvB43B4nyj5siQEP/umVmEDXGky60ZhH+LEM5CdndW/6I8NOhtXkDYJXK2C
 VWNile4rCh7k+5GAZxUxUlTUw6UWh00dZqSACsUvay2LhGQygNmAn/YxpTXOY74NQSGPqWR0JRb
 1dlcYo5DQ3uqb8/dpIGR00IMEyFFiD3b5eAZ2my/6qQLiyo59FOzI94h6ANNmyKW72b4yDHGR9L
 rv3jY3kCOikA/2ugETA==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6ca19d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=x3UvaR+l8cLCJ1uKBUlNag==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=mOqVw97Yt21F7phKvS8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwMSBTYWx0ZWRfX3r94rZ017EJC
 bNu+6SBXi+eTvnSNGGpHHCJ0Q0FWbAslaeQpi842kQSJ3YWNEqDByPW/fWOhXkaMPpS9VTBnfJK
 DpuIQOvzwQEDpxmbCsy6PS64nwnpRUA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310101



On 7/31/2026 4:50 PM, Stephan Gerhold wrote:
> On Fri, Jul 31, 2026 at 04:03:49PM +0530, Gaurav Kohli wrote:
>> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
>>
>> Unlike the CPU, the CDSP does not throttle its speed automatically
>> when it reaches high temperatures in hamoa.
>>
>> Set up CDSP cooling by throttling the cdsp, when it reaches 95°C.
>>
>> Add polling-delay-passive so the governor periodically evaluates
>> the zone during passive cooling and steps up cooling levels when
>> temperature stabilizes below the next trip.
>>
> 
> Would be good to mention why you are treating hamoa-iot-evk differently.

thanks for review, will add the reasoning.

> 
>> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 32 +++++++++++++++
>>   arch/arm64/boot/dts/qcom/hamoa.dtsi        | 63 ++++++++++++++++++++++++++++++
>>   2 files changed, 95 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> index 9fa86bb6438e..a146be1cb5fb 100644
>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> @@ -1684,4 +1684,36 @@ trip-point0 {
>>   			};
>>   		};
>>   	};
>> +
>> +	nsp0-thermal {
>> +		trips {
>> +			trip-point1 {
>> +				temperature = <105000>;
>> +			};
>> +		};
>> +	};
>> +
>> +	nsp1-thermal {
>> +		trips {
>> +			trip-point1 {
>> +				temperature = <105000>;
>> +			};
>> +		};
>> +	};
>> +
>> +	nsp2-thermal {
>> +		trips {
>> +			trip-point1 {
>> +				temperature = <105000>;
>> +			};
>> +		};
>> +	};
>> +
>> +	nsp3-thermal {
>> +		trips {
>> +			trip-point1 {
>> +				temperature = <105000>;
>> +			};
>> +		};
>> +	};
>>   };
> 
> Please avoid overriding node values like this... One quick rename of one
> of the involved nodes and this will be silently broken without compile
> error. Nowadays dtbs_check will *probably* catch these, but if you
> override values using the label reference you would notice it
> immediately when compiling.
> 
> All those nodes already have a label you can use:
> 
> &nsp0_alert0 {
> 	temperature = <105000>;
> };
> 
> &nsp1_alert0 {
> 	temperature = <105000>;
> };
> 
> If the same pattern is already used for other thermal overrides in
> hamoa-iot-evk.dts, it would be good to prepend a patch to fix those too.

thanks for review, will update this.

> 
> Thanks,
> Stephan

