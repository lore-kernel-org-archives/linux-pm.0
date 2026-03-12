Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A938AC75
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305680; cv=none; b=tdnBdy4kzSa5HvjYfOBwscUZ43iuImWIbXtm8CCuCj2YcXWmxkQIYn0Ng4JdqNK4hqsFO4CPs/WugZYDCqBHgAUxkeB1bEXs1iQh5Cf9WzfQRrzaLcI9b9fRSnTKQQo7V3DBep2jqnUK5100EJMxd7dMfAZ/K3Na9IsFbDjg0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305680; c=relaxed/simple;
	bh=W6hiN826Nj47dmuat69Ci+wnnicZJ77Cn5oLCDUc+fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQGuNWFZH0R9BPfi+7YNc8DOE3e0a0MuYnoIJB1iKu/nlA09D8DDyK1BFOW+xVOCOdKnMKDK88CrkGlYroOGD4ViA+7ip27y0Enpu0KkhN3TvOEJhWHwnKk7Lo63fuJj/PBikDybf3RnnYVnRxq9xRXC0seFREuMyHJtjMtu2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JvRUjeIK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fLxss9eO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JvRUjeIK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fLxss9eO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C2brVj1740582
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ex6SR5AntwjH2hwV8Pxt06HDLsYD3NW0CR+gEG/N2zw=; b=JvRUjeIK8VTnhp9t
	q3Hg0aEdaIqihYMPsopJf8cAVk5ztzRhE3pJxN8X4R9VeciRfrJrRfzx9Ia9s/I+
	+ZSsnVn+xLCUk0moE4Qkf/fr7bz4o1I8QP/XdfAv4lQkbmnxVYlgSgnq01/n8QIO
	LDfZfb1KQJ3dNhoLEYBo+xlEbyNzgbf4rN4N/VrJ3GnnmUqtQpsgQ+5ZZgwHceRX
	19eE4xQ0eDemioYGRO8EBalv6qAhqMApimXG+4qoSQOMFH9IOjwdOG9IzzKqFrax
	fLwN8TfmwV7z/FjBa2ogHW5r/NFzkwwMLllvhtCwXfrmgEoTHDfZvDhtfuMtjzAD
	1oOszQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cumvdgvq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:54:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae47b3adacso8544495ad.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773305671; x=1773910471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ex6SR5AntwjH2hwV8Pxt06HDLsYD3NW0CR+gEG/N2zw=;
        b=fLxss9eO+qaKjkGaiODBOh60bxNOM8kCKaIMjfGuM1hIbbniBEgLFyYAWlvtqhWSpL
         xIrqJC6+fF+10wHX3Pn4mQ0UX9UM06KyuGbtHo5x3MKG/lfFdlnZogGYQp4Kcty2mg3L
         wDjO7f3gkp8CbAEbmDL9Iqoc62OSyS9BJG7Obmf8SUXiZfBBTccgrc5v062nforN2xy/
         TNJcUoLu+DwzQTk/2ZsjGvJvlFnElcRcyQB/E3vGteyeS3qiiG74ZXGfz56NpsbEURVn
         4Ws81CPRvSPBCZ5/KKZIj4YCA/KwbBEChzY3z7n/uE1UwZkrKgk3v8i6dY6E2tXBi8Du
         41Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773305671; x=1773910471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ex6SR5AntwjH2hwV8Pxt06HDLsYD3NW0CR+gEG/N2zw=;
        b=mVXKWDqyd9hE4agLSe87fMHv7YqVvX270zzQhD28aZ05iRjgxRv5GaK355WlQFwAxj
         mb7a9wIw+s205oOcU92fUvvYmPQ0ZzYC5cyJeyiBQqDzunesq2YERwyd42bEBNdCVqRu
         qHbojOwbjo4SVhfkKHpfe997UR67VLvrbF3fOsrd4SyvHlKsy4CXXY5PluTTbz+LEYd+
         j4zwHvf4m0EM6ZxEykD095k4odIwobPNEHl9K1kbbQd6JttFmhFbHQngQXrRYxF6kXRg
         zj3V4ysj7expXQtOyOi/Q2o1LA0Nzl03hSzm8KswNdQu0/K1SSZClCJFPaG8Gn1N7yg5
         6Zqw==
X-Forwarded-Encrypted: i=1; AJvYcCVEbOdiHsNhTr4Tg5WIRwrtVlM5TW/HE4AUWk4M2QSFZdoDnNIK554aOkkddb4/0kObuJqINjxFuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PkyP1f+qfNxBwlCxQgxdhNK0yVhUOSyL7LvaPD2zPofDPfK4
	kqPIVL94PgYDh+Pnh5nOKSYUuqnJq2sjDyiPwUh7jVR1s1FjDGL2uE8DgRAzkuNWuoW08aSQzAs
	J82AeEMbq+sD26S+yCrDPs2qbeYNVgx3N00GZnNJqeBQATzFUWKEHG2yoZ1ETrQ==
X-Gm-Gg: ATEYQzz5j1iGbBIlwayvMfrkhd8LmtFQPqI7UFbW8ElMDeZJsm8zGtizIfFHkORVeNS
	az6lMDrkPkQ25p2Mu6tzLbJKxWB5MVdRIIW1p2vCan9rBRyW7vnvuB3jo07srXn/BHrlLrnZkb7
	ogKY0QAbuMORvsbHKClDCOYn6b2Ge4t9sy3ibYWdvEP+Hce9dJNMOAp6niy5LAIs44+zmzRR3Pu
	7RiHNdeZMRU3LWJrc3Q562EoFpxEjiDw9WstbSjod6cqTAFHePb5sKNGUTp3obZxtvCZoT9OjPA
	sC49IFblENY1vTQCyYT1W9kvkCSvVbl/PbZDQlN/vL/CVOn5kp0/SB770gXYmqF3sFp2ircN2dq
	SkQlHQYPPPuYEZEmVmydiNTm3CJJjKfzUHz1z/HeFuCfCRQzuxahvvldadnIGiAc=
X-Received: by 2002:a17:903:32cb:b0:2ae:608d:ecc8 with SMTP id d9443c01a7336-2aeae85a33cmr49716965ad.27.1773305670810;
        Thu, 12 Mar 2026 01:54:30 -0700 (PDT)
X-Received: by 2002:a17:903:32cb:b0:2ae:608d:ecc8 with SMTP id d9443c01a7336-2aeae85a33cmr49716735ad.27.1773305670339;
        Thu, 12 Mar 2026 01:54:30 -0700 (PDT)
Received: from [10.30.144.113] ([152.58.131.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222e2fsm66922835ad.2.2026.03.12.01.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 01:54:29 -0700 (PDT)
Message-ID: <509fc515-aa29-44be-86f7-a64e2d8f3f98@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 14:24:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 01/10] power: reset: reboot-mode: Remove devres based
 allocations
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla
 <sudeep.holla@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-1-cf7d346b8372@oss.qualcomm.com>
 <abEzdgQ6pe0fC-5z@venus>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <abEzdgQ6pe0fC-5z@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA3MSBTYWx0ZWRfX41EwVqTTjA2z
 +4WfEX5fOOYEjfel0vq4HTIjixcE6lJehHR/3/zNA1XxEI9kkLpGzwUCG3LC0kQjR59hU5J2yqi
 ziuhqdawtnis0zwbeU7kCyj/mwHveeCoCypxMXlJ30G5/hjUQyZDtT6Z0uXIE69x5Cs9EExAQGn
 rFH2byLk/VVaTrk3XunUW9/8fMD8xDePDUrI2Icn7Mthp4D1bsLwOFm1wB3zm0mjiIXSoznHtPA
 6+LIw2C2+CDHJKkN57JmvsJ6QYDWpqS3pYCh6T/wVwh40P0eMHvC5e3esVj5fS5omWvPMqyCPJL
 oZOmGbPdPhLnBXGUcGb9fnVGF2P+V0POus6EPmzoVQqk8HX+0XUGG2emdfev7qYa0/vScM2KOzJ
 DPHNxUVXdzGOSUC/FPusGJe0Xt6RGjB/YK2KhqGVrsIfsgIl0qifPg3p4Fv14wV0fWD2uUIhYbd
 zPBPaJ3LEoHSVFftj4g==
X-Proofpoint-GUID: 7v0WX6nKLQT5YhHHlr8ywXX1AIELvSJk
X-Proofpoint-ORIG-GUID: 7v0WX6nKLQT5YhHHlr8ywXX1AIELvSJk
X-Authority-Analysis: v=2.4 cv=XsT3+FF9 c=1 sm=1 tr=0 ts=69b27f47 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=kINRXkAo9yxRtpb0MKIxjw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=8-yduQQsOBGYcPy-76YA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120071



On 11-03-2026 14:51, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Mar 04, 2026 at 11:33:01PM +0530, Shivendra Pratap wrote:
>> Devres APIs are intended for use in drivers, where the managed lifetime
>> of resources is tied directly to the driver attach/detach cycle. In
>> shared subsystem code, there is no guarantee that the subsystem
>> functions will only be called after a driver has been attached, nor that
>> they will not be referenced after the managed resources have been
>> released during driver detach.
>>
>> To ensure correct lifetime handling, avoid using devres-based
>> allocations in the reboot-mode and explicitly handle allocation and
>> cleanup of resources.
>>
>> Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> The patch does not apply, though.

thanks. Will re-base it.

thanks,
Shivendra
