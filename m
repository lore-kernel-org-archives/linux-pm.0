Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763BC49251F
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812527; cv=none; b=e3i0Bx0+o6LcqmWWzHfxtN9yr1AIWdN3TtsLi47r0fHhJWu5ZwEzv0TzBQEQTcOhVbo7VpH6V524YkqDErYpmu5Xr6mMfhEK+r/sTWI6mQ6sexE4vfab892Tq7/O+tq9QiCz8cxMmYJVtBBTZhE1aicSpKLUqmPEXvudrkPYMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812527; c=relaxed/simple;
	bh=aME50YQWurrWPMxFmSklDBm9jntBrHtiwEEG+vN4Pyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqhC/NnGZ/JBFfxXD9RhggNSMnybZDhUWZrkkqCzGp8PjOVqo1RQtDiDem6D4iZ6qCXXZsFIHGxZVTqiVkgYCrl5FDbpnQa3JSuFDHZ3leq3IFFDMFCqe2hxcMYryBzpUp8pzb4C2rV8s6oi5mtDXvffBdenSji3i30EbDeb3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvnfJFYl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zw2rHbFr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvnfJFYl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zw2rHbFr"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NCvUwa3819791
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O2Yu9Mq1SFTFe8Mrc+cdWZt3E4WobO9rD3AAbFfTYOQ=; b=YvnfJFYlc6uMK5J6
	USf20nI4P9ev31sIlk3UWubOmQvdg4ONcUSaWbPX/M3TX8HH/AD4tZGHQmkKmDnM
	/PJLc6E5vREwL6ZeBCZFEYoZ79EDzNMwIBboa6UToePWcKHMGv4gjgmqZOvsnisJ
	z6pD6BvX1Cdx5IKX0s5TRnWO+W/pWqo9J4JDKZJaAw05lekqmQf+U/iTcN5AF8lZ
	cJPzNFlUURdUpoLxzaLGzdSE7v+cScvu9Ds7znmnMPhHsvs6abVn0Y4Ttm4DHNQW
	eu+8DZqpL2xazJLJNrIx2GXsKEsGF/htrKWTLELE66umqLD67eHikWNqfi68Au6f
	ktpijA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkafw2bcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:15:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1e6f602cso10880911cf.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784812514; x=1785417314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2Yu9Mq1SFTFe8Mrc+cdWZt3E4WobO9rD3AAbFfTYOQ=;
        b=Zw2rHbFrcwa1MhOCJmO7sGo6Mk8SnRLXw20fd8VuPt7t3WnwOhcxpa5Er7HtYkpSwB
         cWscwVGVhcVbjqEi+QKD2f85YWZ7FQytwUKEwO94IBxjb9eEH9c+bLdOdn4RNc0vFjMe
         K0t5GSjCcbRPv240pk4TWKY+AraaMv4T/bk0ZaugxprMJt+ri0BaDGuL/+tw5z83N29W
         ba62VwYG2zAILij90J37CRE2JJyBaD+UK7hJgfWGVbGxbdkAoISVfAP49EGsWW1LmQ8f
         0F+FpBY8QOl0UAqK9ifF2sywn1F7NyZKPM/B4beip8++ObV4rSgnTJVF6UVyzNvQX6oF
         mk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784812514; x=1785417314;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2Yu9Mq1SFTFe8Mrc+cdWZt3E4WobO9rD3AAbFfTYOQ=;
        b=A0iwvXw1+Qlrm6m0CD5kkIAlTJYKa8ziEK9YxEcsdXvIzlI8MnRFIbjP1nv2r+yPIX
         lgENKc0K/XBdnWc68AT1slJsel70V9SPzotKhU8mddpAxOaks0KQ0gH+ddtoQ3TeIJLM
         z8JY95nFZgMj+EwQZghSK6kf5amf79v63j7O3kF7G8JqEySFq84cQksy/4a1hktm/Vog
         kn3m98Fs/Td/EoQum+zmEInyAfIBY3+ERgNc4qPDCriy0CWtUjMQ92qlWAc3qwfIkIdQ
         d67BTxXY/ubptjohVNWYeTWfKjQKQ43i6e+iYuTz/OqUYj2uZJPcWL8tKFmqtDCgaSpq
         dOwQ==
X-Forwarded-Encrypted: i=1; AHgh+RorGvJm6xaaOlyPqO4UYcQNzuCtoHmyCUHYMFZUWB+TBUi/Qs3Bb0CSgFP/nuGxHw2H2nD5rXxjBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVxgYQhn9reHXlwiGvRqbdYvsk/7qxaQbYy5Wq1PTCr+GFkkE
	ni/rsSuv3g2T72d8AvrKZULBUOPH/IOfcifLSbcTUj0yLQsCP8H1m8umlDhECNCNvU5h9KZ2BnA
	NRa9V34zttOXQfNR/BhDCPqnrNQi1pmUL3B1Uv8zX76KpttGFvQOoZr3opSx1HA==
X-Gm-Gg: AR+sD12FI3BC+U9haCE6Rois8ppfqXx3rK9bnmWYH01SJLQQLvXgJaiRZAehegBM2Uy
	cHB9ZP01xgjnnxQ3+AyZTV5AmX2g3feYwTtT7sIUkPpsB4guGkVhuL9is0dQQztp+IdpmssrVYr
	9Ub4bwFB1qWJJeDNrgHt2yQiA8Bdh2gHkDuZFSwXGhP2GRPI/dvuW1eAhaYOBRHXX0TFR2z0t9v
	eeMqXQ45E1hzgAxTJiRBNayOGALnWKsHwP/NpYHOo0Bp0VbNdvD73frvx1rb03PN2ZiLuM83KbY
	5DR0q6pbnvR6m85uZ/FmLw/m7vdqITvPHjKSM3msO0Y0la1W4c8tUi1kTN4igs0KsRXIatLxRQX
	hIlRKn1qP/dyuTb0lawazZhKSsbL0BRV3xm0=
X-Received: by 2002:ac8:5a0d:0:b0:516:ed02:c85d with SMTP id d75a77b69052e-5283ddfb06dmr27815571cf.3.1784812513334;
        Thu, 23 Jul 2026 06:15:13 -0700 (PDT)
X-Received: by 2002:ac8:5a0d:0:b0:516:ed02:c85d with SMTP id d75a77b69052e-5283ddfb06dmr27814741cf.3.1784812512670;
        Thu, 23 Jul 2026 06:15:12 -0700 (PDT)
Received: from [10.219.57.229] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9d31c73sm1031686e87.52.2026.07.23.06.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 06:15:11 -0700 (PDT)
Message-ID: <01237c3d-7248-4460-a115-512ca3d0a706@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 18:44:53 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 03/13] power: reset: reboot-mode: Add support for
 predefined reboot modes
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
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-3-e7453c548c21@oss.qualcomm.com>
 <9367ec1e-d01c-489d-aa3a-fb361538331d@quicinc.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <9367ec1e-d01c-489d-aa3a-fb361538331d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XNkAjwhE c=1 sm=1 tr=0 ts=6a6213e4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=v7qggGzDPz5B41Fs5RsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: quDJPHXAepTa-i5rvnugWHiixkr-pq_b
X-Proofpoint-GUID: quDJPHXAepTa-i5rvnugWHiixkr-pq_b
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzMCBTYWx0ZWRfX3kOVVaP6nbDt
 CwyepZlig26hnMI4d2A0ddfi5xRG6EXrycR5wWCD/3ukDYa8qWSl3Kgb8L4Ny9WMH7T4aKukMZX
 0iTymwr0bP0s9FVPKlaw2/WJnd81JY4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzMCBTYWx0ZWRfX62f+JBGThP7W
 ksMHb5BBo/IDl4ySrKgJQwmqA1pbYveaNxODjRkrWfRbjZhBUR33uNE6Pg0lDZFhjwOIvm3PV5J
 EdlJHouR/ZEZled72gPJ/5mDDiSQTW/egGVxDMW0cJnOo22OplLgrOt4Y6Rfee01SOjLtqIOldu
 YkePHS9MfNfhj/qmzp1F0o5gy8MIRMfKF7e/F0DPgiYcNC+E3Z9BcJZAcc07yuePSbcyxJWcr1C
 NQN8Mjw+7RShStCYvCCLtmXGOuOnYqbG/ECq8s4VOU9gCX7Rg6pfnJ+RtwGyM3c/A46KeKl8xOQ
 j+1gQV/HyVdJTIjLWRqRR7QVWBix2kvnzfJ9JkjXL2x8JpgI+UgkHWRnqvdDOfk2Veu4A31Cb6L
 2Ihyl2JyDQqWDKvnOn3qlpshOVFvlx+Zwcwe0h6lnVOEcUza+xMtvvudKpoDxyo9ZQXSic8W62Z
 oa6li6+dzzKIDWp1EjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230130



On 22-07-2026 14:34, Pavan Kondeti wrote:
> On Tue, Jul 14, 2026 at 10:46:31PM +0530, Shivendra Pratap wrote:
>> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
>> index 34a81e4b4f95..b216c7595f7e 100644
>> --- a/include/linux/reboot-mode.h
>> +++ b/include/linux/reboot-mode.h
>> @@ -4,18 +4,34 @@
>>   
>>   #include <linux/types.h>
>>   
>> +struct reboot_mode_entry {
>> +	const char *name;
>> +	u32 magic[3];
>> +	int count;
>> +};
>> +
> 
> I see some where `count < 0` check, should not this be size_t or u32?

--
count = device_property_count_u32(reboot->dev, prop->name);
--
this can return -ve values on error. and we store the count in info-
 >count. Still the count in above struct can be a u32. Let me review this.

thanks,
Shivendra
