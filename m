Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E2345CBC
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727222; cv=none; b=Sr9KyrEmGbiR2GB1ZXvA+duqLSSJaSYOWdZ5NaJoyI1pWSMCZ7TdqMohamEuMdf7HmzVOI+eBiH8YgYWTipVdC8pJRg45XK3HFHs6YQBWbg/n/ewRFmnbysakpdqFykBL2eplWFY592miv+7C+/gDdIzcgNiB/+Ws0FrCaDsM8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727222; c=relaxed/simple;
	bh=IK0nPNyVliHInYc5llgRFImUtg/oBw1zId3SZsnZemc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7MMnbkAIBPp7Gu98TlwhGu5ZaNPKY6AgV74NaeZU6ZcgdktY9bd6D3ZR4VImZlcBIAkPqASbmyf0F1qCY1n0D4uF4tU/cw4lbeseY9fkxmzd67dSuh4buXM5CmLtwblG0ZcADegaHkcINCxtquBShR3BZV9fj3Vd68Q72FdPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p6jGh0aC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ek2Nzz25; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p6jGh0aC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ek2Nzz25"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWk301033913
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ss0O6hRBUHxNH6IxnPNV86R5Z0G3U/HPz/CmgoZNFtI=; b=p6jGh0aCk4giX1im
	UEUXR3cYR9ostzr0WwPUNMeTC2ZStLqADyNqeLXAuWslFmvcLOCRSbI9C9LAtlbn
	2yD9aSRJfArOChaUI0IOO7kuNkzsxci+L1TT+skYRM6oL1FSGpu7wbGV7U0ynamm
	LtR5jO8ABsmqGhPQJ/4S41otNC6IQHC1eUULxg/YCMtQP9j6Q/AnfxYLPO8Q2h9/
	In/CeWZyFGFW985RtvW3qda/Z6N7MHZSP8XnL3n/dYc23XSc7ElaTzSPgfsdMSA4
	MaR4E2/xjjno6CV85K5uXYCx/Szg5/ql4EjAD5XTDM0NyPYKfFFmUDAxbSu93wg9
	Dn7PbQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdj28b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:33:39 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6a38b9eb18dso5900226eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784727218; x=1785332018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ss0O6hRBUHxNH6IxnPNV86R5Z0G3U/HPz/CmgoZNFtI=;
        b=ek2Nzz25yp3PKOwucIFQb313XOY0Yw7bbWZaOJPqsyLt3Ny/jBB0xn+cwT1CyT8VEB
         8nz+KuHJBIc6GaeDOhOkSbQ1lX26v9zHq52iPMD0nIRenSb9/hE2/0THB5CxSEsUJhCF
         57EKUMmr73OIcKS6bYAQ6F4gwgEo+wokvJ1o0/0qjiMsQdpitZlh09ESiB/7ZYqw67A7
         EKfVWoSlFiNn0hKx0derTj072pgVLjKWhjoxqoQZxlpZeBzjQKTdOp73nft6nvU12D3O
         dTYVfoYjXcloi8+o0VM89ciIou1oFneU3KbKWB33S9UuKO2wR1cbSV9SgZLPL9PkQVQ+
         Z7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727218; x=1785332018;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ss0O6hRBUHxNH6IxnPNV86R5Z0G3U/HPz/CmgoZNFtI=;
        b=czjKNJ9EtSVQzIq2+iwFyvIp6pmJYtIt1upuWK4UiNY6D8aOqtgt79ar3T84/3rE7P
         LPlL/ySRUaKl3CH+d3fpNtT5oEdumjCniKjr/VeG2YA7fFHn+bGl+BZnNgfr1Cr4MSQ0
         m3CAzH6F9Zb9m8iftFwFOieJL1Xz4VO4m7UEWEY5MM/jNZS+Vhm/dR1pYyxZkUuJ7SuT
         6VEmy6YrBTObZtyCjJX32W5SzkiJBw3vGufmGCIEEjkIf9vBYF0iUi8fxqlsjzzHHv2e
         SyOoUkR33BS1Su5Xk56NgEr9NRAOjggkNxdnXchw2Dj5fUqQ0lYFtUS0GgOayux6BqTB
         aYzg==
X-Forwarded-Encrypted: i=1; AHgh+RoTAtAmw8VXIgJwhfRhXYpFpEuLC9yjqI99x3+Mg+EJ0dOWxNrwXdIaG/CbUSQDTnJi937ulEmw4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzepaQ8W0SqEo9BLQPlIu2rFL0UKYIE3BZoZFtlwVvUrAW5BMXS
	TWg/eSo4Fd2treaki4fr1JcV+4/0NDIud5efX9WjRZ2vJU1y2o2npAcembYfwwb10LyURwheKot
	skSdxeF4SIktKzsVJqupbNVK3SjEMM5HGtOz88XhXecj3WC3OP/ZOiIemv2r0ig==
X-Gm-Gg: AR+sD12nOtr82vdeVlQRcj+B18adsMYSpphzxt9HP5AM6MJxyAzTSYa1bLcvdOV5Op5
	OZQEf3CCkyymbC9qoKy0YH9SyrX+gR5iwjSjaqZRGvySXVhqmuuMjbU38Rx9V4REQmBNG3QF0Qe
	1piVBXot3VCHBXPVMnnbI5pLvVydeDja8oRJybzwmNcIbXfgzoeqVaFT3+ZgtClH2U/k54uuzoV
	pDGsK5rPCkognZx7u++nfodWIGss6RodOPWUI8qhRjCs0/b0Y0Cs8MX7JB3ShO+l0v9TSu9DHPT
	3ak9xkqfBFU/l99LHE07f/UaTtIwMxA37JdhoJ2xg2TXCSyI7EGBX1gs9Vv11FC821Pl6XBnLvQ
	VEln031aRGMzHikE4tLrE4VQ0xJ8l0Uot/hg=
X-Received: by 2002:a05:6820:16a0:b0:6a3:e0fe:c4ef with SMTP id 006d021491bc7-6aa4bbd56c9mr1653211eaf.35.1784727218600;
        Wed, 22 Jul 2026 06:33:38 -0700 (PDT)
X-Received: by 2002:a05:6820:16a0:b0:6a3:e0fe:c4ef with SMTP id 006d021491bc7-6aa4bbd56c9mr1653117eaf.35.1784727215447;
        Wed, 22 Jul 2026 06:33:35 -0700 (PDT)
Received: from [10.219.57.229] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa79a09cbesm1395149eaf.12.2026.07.22.06.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 06:33:35 -0700 (PDT)
Message-ID: <fac2633e-db28-494c-9b31-358ed6d0ce14@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 19:03:22 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 02/13] power: reset: reboot-mode: Support up to 3
 magic values per mode
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger
 <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla
 <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-2-e7453c548c21@oss.qualcomm.com>
 <38115586-9913-4d6e-9447-e82aee811dd1@quicinc.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <38115586-9913-4d6e-9447-e82aee811dd1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMiBTYWx0ZWRfX0lGWAj8len5o
 /igbfKNDK1x5efOu1ZKyBCOFMYuI6VHpfdvUGK6DJnY7+i/h2svRQ3jDINKnfvgJ1PUEkdEjHpB
 kYynGvpC0xfCXjX9jTyRaWoH6pj6pn+T8+DwhTByJLPRvaR1jPlnKdwZNajktiqsdWePSyskoA2
 YHQcF8+/jjBRBO8ODzK835ZmjavNB3gNcDsIOQlqXlHhw+sMuTUENYD5ETPe0qMhEuiLz8xqxGl
 b1Y7SDTiWtjDrGJXpUdKDOTDJrrbL8PxbdrHkTYUO1kgG7owUo2Wpcb13KChIbUxMSPffdIKKYE
 Uvak9d9sPaQFG8dFxGh7QNdIg+AY0hKPAVTySHrcY2tlm/wqMztbKJHmaHiLhPVi8LBXiAWi/fY
 FqTiDmerFjgKwHzy5wkxq6qBDWCD1ydj5QE2H5Cr0lB8qvq4atsrJ1m8rjAMRwIl0NHRMXRf3hy
 ZxVNyvo0DB209RMTQWg==
X-Proofpoint-GUID: AiaqsHJc8iDVhbcW0bLA7GdgA2fMr02E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMiBTYWx0ZWRfX/QYgwLEs22Su
 Jr6p/iH/vR4EPzYvSqzmB5bfa7Q2vmFPeVjnRX8wnWO3TwnY6Nqivci2hFEV+nNUK0v0xr3mIMi
 pjAswHfllkDSXhDZz1ffAVOJ+UtoWuA=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a60c6b3 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Fs1vR9WLwBkDfa--pcoA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-ORIG-GUID: AiaqsHJc8iDVhbcW0bLA7GdgA2fMr02E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220132



On 22-07-2026 15:20, Pavan Kondeti wrote:
> On Tue, Jul 14, 2026 at 10:46:30PM +0530, Shivendra Pratap wrote:
>> ARM PSCI vendor-specific resets, require a 32-bit reset_type and a 64-bit
>> cookie as arguments. This cannot be implemented via the reboot-mode
>> framework, which supports a single 32-bit argument as magic value.
>>
>> Extend the reboot-mode framework to support up to three 32-bit arguments
>> as magic, per reboot-mode.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   drivers/power/reset/nvmem-reboot-mode.c  | 10 ++++----
>>   drivers/power/reset/qcom-pon.c           |  8 ++++---
>>   drivers/power/reset/reboot-mode.c        | 41 +++++++++++++++++++++-----------
>>   drivers/power/reset/syscon-reboot-mode.c |  8 ++++---
>>   include/linux/reboot-mode.h              |  4 +++-
>>   5 files changed, 46 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
>> index d260715fccf6..ac69b5f39fb4 100644
>> --- a/drivers/power/reset/nvmem-reboot-mode.c
>> +++ b/drivers/power/reset/nvmem-reboot-mode.c
>> @@ -17,14 +17,16 @@ struct nvmem_reboot_mode {
>>   	struct nvmem_cell *cell;
>>   };
>>   
>> -static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
>> -				    unsigned int magic)
>> +static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u32 *magic, int count)
>>   {
>>   	struct nvmem_reboot_mode *nvmem_rbm;
>>   	size_t buf_len;
>>   	void *buf;
>>   	int ret;
>>   
>> +	if (count != 1)
>> +		return -EINVAL;
>> +
> 
> The count can be different per mode. Because `struct mode_info` has
> `count` member. This single `count` check across all modes may not be
> useful.
> 
> Either drivers need to use count passed to them or drivers needs to
> receive `struct mode_info` in the callabck.

will add a once more write function in reboot-mode to handle the 
multi-count support. If a driver implements it, the multi-count write 
function will be called. And no change in existing drivers.
Does that address this concern?

thanks,
Shivendra
