Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4537C0FD
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110544; cv=none; b=T9Aq4tmQi9djOwVhXXlPMBm50AgacdjteNcvXViwubnV52SnMIRUs97uZze7zrjgKiftbFG9RcRtfdbJ3I+6Bj1Y2uP/hoWW/3nPCTzf+Xc83UfyTYurhv6f7jgf8IZo54tIFgyE9KlHug7Uz5XDXdjasFXhsCLTeFZqC9j4weM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110544; c=relaxed/simple;
	bh=l1loiawBIn+Nx/k/dA29xAyzkExLzj0o5+J/2k7RVgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZWrvtvDgwPs+5esNGgVPFMInsTJZLLwS4YCDtlV4TjX3Pb1af0pK4QidOvvW6f+8HtPKI4PSeCgfHRKjgS2WSpJxqXZmWJQLTZgVFBn80jl9IJ8/l/48lSRNwjLCvQYEgbIZCjN5Smxo4ng3m5vCpM4F+4lJe7AExasE80btBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c8bHzOo2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hZXiD0dj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c8bHzOo2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hZXiD0dj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M4DNH3746285
	for <linux-pm@vger.kernel.org>; Thu, 2 Apr 2026 06:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aRHUYded+TYp1esSjYtekH/rdFjnY9CsQjfogYeamHw=; b=c8bHzOo2Owcne8i4
	ePx8ePExa+MRg9dXSvXV9+XMQ+EJyz3WNvSshCsttH74t56HFmLBZvE9txWeth1s
	QIXKRwa1R+laOy2am9B1eWOPsotau2zBgKPN8KeDR8L4oDofkeNLtsmQtSNCGPnM
	0S7YCtaB1qW3a8Kq/Wg/Ut3cSzNws1FrHiIG8GRQ9XcA7xeCEJyGTAkm4R351QdH
	ogqyKu8RlS0MyYpvEhUHYNht+FGGVta8hX9LkGEvInydyGKiaovL3eN6H7zEA2jZ
	BYHuNeZHTWgRTWEEmHy06deecWJxrvg3MNZcHbHZRPwuQOAY4eG44FoaQfUA21Y7
	Ii3v8g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9324kpdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 06:15:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82c83bd48afso255180b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 23:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775110542; x=1775715342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRHUYded+TYp1esSjYtekH/rdFjnY9CsQjfogYeamHw=;
        b=hZXiD0djI2ie92tB/TOFgMOK1/ZtzPW3Gf4e2839fsG10IK1NjDF2LzIDdOun4a+Kw
         qLeVjx+gndrz4ZJxqEVmCzzsBj1T3c0mNbBleo7Ul6DcARgjxwT7B/EsbMwXQ3NJ9YGc
         6TPeTWpsdskY5WYKyAzer3NXOMVCrQa4l6AKxZFTYUK1jxb5F1ovVHnE1XSlyEJjsWd1
         T25v0R0yEn+zgKz0G5MqtZzO0Bo+vzBVlnikOaz93mTsKBn+PewwdV4oUNkUqngLRxK1
         l8Rqzw7FHEljpxZ2QBCQewmPTp04hl96Ek2VjOJpyJNU8BSIIrQ3cej4+IEZqcncOzAh
         +JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110542; x=1775715342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRHUYded+TYp1esSjYtekH/rdFjnY9CsQjfogYeamHw=;
        b=UwKv/ey2xMLoKdmi5X0EHxeip6Yp8Li5eAGRrE7O4CE4xTaMc3PHn0tNbZsYk4UrEJ
         IKh71XQFQu1w51Sj6P0dPykJ+w0xeBlFg55GSTO6Y4jcU8suPtWNbW9aVPQd2W4MT4WC
         hqPu5LqaJopY3XxwI7MaCLu9+l3f38fmCYLG5CB6jAraIf3FAX3sebro1PYWnZ2LyIPo
         Gs+9LOqP2anOdB2jWOizAauATSp14pcDn3EkqmGtdKyBsEvcbZ1iV30TgSEV41JIKxoJ
         Z6LnPVz2p2m0BRtUbZeTf0uRAqZVLAM8IJOEtwGyaRsYUCzrmQ832xu3mMR8cLQ8LJju
         ugwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeyAPjbcIsHB7WWs6OetgUwMOMtXlIs9dHnKLqsOATeEiRatMXgXVKTPWfVuaoiZR+sS4yeQx+hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlsvtwQiZhc3WRHIzoI6Z8lCWGje09kPyKP+j6+D8hRw0n9HAH
	ikbad8poHiwKACOS+S23OgMa58AwG5BGSICrIKaMcSoTAkf3XPrbAWBZEf45nztjP8g09fpTGqM
	mF9FVQtO8vfsRozKhEQT3eR0lqbQqRr5NC8aYlxPQ0u7jXY2u3gNZvP4eOCRrVA==
X-Gm-Gg: ATEYQzyE5OvnYa17Psa2EAON59gkk0+GoR27svb9wjro2hr6xvLIzkFDW3JnoFqfKOY
	UZZ6zAv0IVkh5dhpZ08Wn+US2IiRZV7E8jMrfjIW6L1gdG8o7hH46xKgbIbGafA3mz2vzQ2BE2u
	tBcrSKrqb+qF9asWUN3Z7BxRaRXi6ZDM8Yz8saJuBohhiD9Qhv4aYabyg9TUTRoYo4ZCB+CKqPN
	SAhmXQBReGFQNbGQcmp/P9pUxuyH1D28cag4O2yg1aQgmbvKdy/L9+mBo9meQCJXCkvK9mqgxDg
	RLl3oIpQU3fzJNoYkizM/S9uTbR1QI2LM0GWsi85RKMwNfcehHQRfDKLXN0FxNjgMgv9kBU9JFx
	xVZMoLVwRnHnQTkP/VcS34yxhfs0fWSSP909MEidmNdqWenupZh8z/A+n
X-Received: by 2002:a05:6a00:ccf:b0:81f:3c34:fa83 with SMTP id d2e1a72fcca58-82ce8b39b7emr6362570b3a.57.1775110541670;
        Wed, 01 Apr 2026 23:15:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:ccf:b0:81f:3c34:fa83 with SMTP id d2e1a72fcca58-82ce8b39b7emr6362522b3a.57.1775110541169;
        Wed, 01 Apr 2026 23:15:41 -0700 (PDT)
Received: from [10.219.57.134] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm1854075b3a.38.2026.04.01.23.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 23:15:40 -0700 (PDT)
Message-ID: <043066aa-64ad-4b7c-8592-ca3074beb7fb@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 11:45:32 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 01/10] power: reset: reboot-mode: Remove devres based
 allocations
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Sudeep Holla <sudeep.holla@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-1-cf7d346b8372@oss.qualcomm.com>
 <be9db30a-ee64-4457-8722-b9f456911ad3@kernel.org>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <be9db30a-ee64-4457-8722-b9f456911ad3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x1nxa-589R1Ik9ISlW2PaUZnjs7MS99I
X-Authority-Analysis: v=2.4 cv=TKBIilla c=1 sm=1 tr=0 ts=69ce098e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=8-yduQQsOBGYcPy-76YA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA1MyBTYWx0ZWRfXxfHsPrpT2jrl
 TcOlRaYTCffPYxv3YMs24MCh0kNdafNOaoudgBFVkLzoIaT/mdyqp+ZvBJTRkXXvskd7V94Od9b
 u7WejxfA0rOTnxt4u12x2u4oD8oQZdBK4bM1MxGFzR/U9IC2vdCk5SaDpRDcxcg6HRkV0H8YqAq
 LAYm6TcXyCFjj1KPq3JgfnCwA8fqBB0bJlRouCG2QAD5ZF/v+73m/jf5B1LyVtLHkDpwYWvMBT8
 xVaz+rJ3T3FqhJruVLRLK5HoSkKob+8ENKeNbwROhmlabaT1UJdq1cYQE3DxvEW5Z8V8fr1dI5B
 4JpBSGHuffQnPAVh97U4V61o7lA5VYuwUsL+KcA9zbR7oQ1eqPT7PvtFrC3tpFlIIbThtFdj+lK
 UmjOGQu6T/Qrw3dyEAGgqxDT27FihNs26/2MGNMsq8aP6yq2Bw7mG71CFmpSbEiTExWVw5I2OeY
 MIi6v8bDa2RB39x8KiA==
X-Proofpoint-ORIG-GUID: x1nxa-589R1Ik9ISlW2PaUZnjs7MS99I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020053



On 01-04-2026 20:49, Krzysztof Kozlowski wrote:
> On 04/03/2026 19:03, Shivendra Pratap wrote:
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
> 
> I don't think this is correct tag.
> 
> That commit added code which was a driver, not subsystem level things.
> Using devres, as you pointed out, in platform_driver is correct.

sure. thanks. will remove the Fixes tag.

thanks,
Shivendra
