Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE43CAE81
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147912; cv=none; b=KvLY1013KSyb0ObpE5JBzaTyHmgrRI4vMmGzUOnzvwGWar6jgEw1MjGFRenQgTod8SJJXaeqw3i7aCxCxsKw+BMk6EmioOUdEDjD4WBfpHANn0Rzyw2Rys8wFB7YvUWqj1Yn/yFXoSeobIw+nqYaYYONTRx/MkagH0dbmVYBsyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147912; c=relaxed/simple;
	bh=ueFkU1uS82QA7Qz5PfMYXENS68x8c9lLBflhnOVZ6aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fk3gGpxtAJ8D2L2gM7lEGKcAAMaU6Eb442Vu2VGbmZSP3cycGlrg3CoivkUNFuZmksdkjgzpXOMZEg+/nR7bAj+AXAg8VHgkXww7CtNHA3TGjoG0lPUAVVzCZsRS8LYZ7kWASpQ7RLrJ5GoyhCFs8jtB+Pl+RVZ4HWGgpnGgZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W2kgtRor; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RLw16P2+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2kgtRor";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RLw16P2+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6473ebQW026592
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 09:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ueFkU1uS82QA7Qz5PfMYXENS68x8c9lLBflhnOVZ6aQ=; b=W2kgtRorpmg7moVR
	3nlYSTqKjEDGPqScfuuynl+ySOpMiJh83vEoZcBlOZEBh9yd3nCqsBUdd8VyvyP7
	GunBZVbuedem/NmEEbvHSKYmCNI8BbCFA88sy9bQWNUT3SjpawchIXUNJcHbNCNZ
	A6y+M4ZcA0j5BqpSH6Ippu7OdwKtHpIKqCiEW2Gy4eXjArnoKxB7hI5nmunLc38a
	S/rIBKkfYIiUNH9HUrcODxWx6Ct18jo64EBIz2ifaGHEVpsG81ZQF4ejIDHW1cmw
	wFYxfs4tdAcbB07HrRZgEQplVz3PDrPovSug5QxRHGiIg2JgXC55BG65GnfwaiBl
	btSNSg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t1b50-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 09:58:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-365e70c39d0so934858a91.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778147909; x=1778752709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueFkU1uS82QA7Qz5PfMYXENS68x8c9lLBflhnOVZ6aQ=;
        b=RLw16P2+pV8KRfHB0cRjQ65JlYKBoRLh/0UBTz4b9Wz/2ZycMkkYwLpcETZ0Njnf5u
         kgyudRmonENtAHNeSGC/d+EIuqGj0EDmCJxjsTJuPJNuugP7kec3/hDc/vT02v5mda1i
         RECzlyvYw3aMnwAETJfNAW2Fv6tumPqiYV5EtyCQ1LQ1Jso2SmzJ9pzjl4m9VfdxoBc8
         xebAMvaWJ0+vjSfBsplCR/MGxDJZ5sJNygkmmJ98SrIz79cRtYbHXG1EBhft9ZCfiCs+
         YpNxiVb+jRXaLFMH/2EP0w5KZlzQbomwPUGFN9AjmyE1hUzS/dIKyLECsoviu6O4sp9r
         x2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778147909; x=1778752709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueFkU1uS82QA7Qz5PfMYXENS68x8c9lLBflhnOVZ6aQ=;
        b=MZrcVHBJRNWMPsgartYoBkS0UKsqhUBtvmUeP1TqLvKp+9RRc/6SEbFnSbhZtrrWDS
         8iOQEctz+ZP6zbssvbrbLLtsxpDev7WEHuCcbjvOsdUEiCwX6kCuZIvx2jni64J46U2N
         dM+xT7AnRFe9LLuNKCfBgTHB/GVkNpmtpzfau8PPSJJHz18HUNU4Hz+L6eNnVmW/ibO9
         Qz2FSbOVer6w0bib08rsjn/sEOluTJomCxQ3g3f6BscO19rEtv02iJPoNDwMwh7/xRq3
         5OqOSay263oF9oXvN0vlpmSKk2EUuX9go6LYT8b7LnSvgA0ICUUBnShdXIQLrtfK/STN
         3YoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9u7cS5STjrp6n3VNdE+rp2GGiGkPRVV8Kog2e2G6VvH+TpaIAA+QSZr3j8gW8+uv9Mm0aCEI9/oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXK1vkUkOGH7QoqkritX7ufZddQZw4aBz6jZQjM5QN+X0KqoRF
	VAlAz9qa/YxQbUPCMFOGtfjBqumDSyQHrji5V5eHG/ELbAWiwXIn6ntCHXODt17XBKRYuFt0rqm
	BmWgzyf4uludv1o7RedHrb+IY64kf07JhlF4ZsCa+mWjMLSvuXdwvVW2LG0dPhg==
X-Gm-Gg: AeBDietj8td381BWQhzPbOZDZ5Q0SnZzJlIlRquinR71p3pBbU8OR69uJTVWYa57FJU
	vqjdPQw0DHA9UBcQC6dyKgX6Zeo4zU/IF1Xzq4PO/2bioqvecOL6hN23CCg/L7rsDb1ps0hu+fk
	uBAIxaY5ezkIjaZkbge9n0zw7oS86U0tZFVmfRS/mPMU7xdduoSb0Ex0l2g25tOwMB1BX23DBL1
	3Jgroqs0jlEdC1g7F65jny2nWQTDQlAaCjNxS/M5AEMO2jytXKjdvWUOeyXTNzHDH2Ndk9OZuIu
	Yr2oTCvMxStsvKCtR04R5ptoPKhsEpOE/k6TijnVs3ccCGBQvGf/jiqHA27hiahOTWZIYbZ3K3O
	axU8Zw71xDvZEKgmhH7acUyyBr4BpJYGcvzoQfApnnb3RJXZClGFbJKE4aNUXiwIUABeiQSMEfu
	x1lorg8e2kcrQoEPA=
X-Received: by 2002:a17:90b:3a0f:b0:361:472e:3be6 with SMTP id 98e67ed59e1d1-365ac79e167mr6984130a91.26.1778147909426;
        Thu, 07 May 2026 02:58:29 -0700 (PDT)
X-Received: by 2002:a17:90b:3a0f:b0:361:472e:3be6 with SMTP id 98e67ed59e1d1-365ac79e167mr6984112a91.26.1778147908928;
        Thu, 07 May 2026 02:58:28 -0700 (PDT)
Received: from ?IPV6:2405:201:e02c:3e:6c6b:1a56:afde:6508? ([2405:201:e02c:3e:6c6b:1a56:afde:6508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c4270esm6906007a91.9.2026.05.07.02.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 02:58:28 -0700 (PDT)
Message-ID: <605bcc1c-a4ab-4125-a4b9-facf801db26c@oss.qualcomm.com>
Date: Thu, 7 May 2026 15:28:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V6 0/8] arm_scmi: vendors: Qualcomm Generic Vendor
 Extensions
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        konradybcio@kernel.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, jonathanh@nvidia.com,
        thierry.reding@kernel.org, digetx@gmail.com, conor+dt@kernel.org,
        krzk+dt@kernel.org, robh@kernel.org
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
 <mplk3qvyslzazuolwlcgy6fb6ta7ts63x3dq5wwybyejaxpyh3@fctfzjkyxi55>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <mplk3qvyslzazuolwlcgy6fb6ta7ts63x3dq5wwybyejaxpyh3@fctfzjkyxi55>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc6246 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=nip31g8rMu7ECPMDnyQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: BTBPSZqWW0GlnFdjKk6dhzl0EJx2SWHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5OCBTYWx0ZWRfX/EjTmSfjvv+D
 /H+lpOAi50E6j625wJmsJQUr0Dopr2+gQhrrVBSE+q93jJm8QFs4lkxhfQm8t39J1lZ8Kh6/DDj
 9t9gUrAPdRwtu12htFjXZTYbcDwf0jzTMg+531r/2qMdS9uWeisarf2Ib729Gh6yCakv9WEaDus
 UoRIdkWXPFwGJ3+bx08C6i239MXIrPZCZS0DHvfZTshCsXEfNOXFkFClQ+EI5hZvzITSew3XT5f
 vMrimlQEBrCfZ89w6HKZQJivc7hJmHsVVi2pXfgkTIA7LKVx/kz/0S1+gg5h+pc+IigPAANcNm/
 Llj30lDGwf47tNg0JGd/8HxCRExFfTLJSRs0UKCIWYGrN3r7TlxnHr6J++ym+MAiWTZlYbtDcfX
 4zisZe7fPBunjbjkNjsqoz0gxduQtXam58LDMtog1SXc1G+bWFPIsxllGQ1He9pdVytrKVlVh+l
 IfX101/oTaFdM0I0CTA==
X-Proofpoint-GUID: BTBPSZqWW0GlnFdjKk6dhzl0EJx2SWHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070098


On 5/7/2026 2:40 PM, Dmitry Baryshkov wrote:
> On Thu, May 07, 2026 at 11:52:29AM +0530, Sibi Sankar wrote:
>> The QCOM SCMI vendor protocol provides a generic way of exposing a number of
>> Qualcomm SoC specific features (like memory bus scaling) through a mixture of
>> pre-determined algorithm strings and param_id pairs hosted on the SCMI
>> controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor and the
>> mechanism to control the various caches and ram is hosted on the CPU Control
>> Processor (CPUCP) and the method to tweak and start the governor is exposed
>> through the QCOM SCMI Generic Extension Protocol.
>
> Could you please clarify, does this apply to the common commercial
> Glymur and Hamoa laptops?

Yes, they do apply to common commercial Glymur/Hamoa Laptops
as is. This is the same solution used on the windows side of things
as well. There can be certain cases like Johan has reported earlier
where certain oems are stuck with on older version of CPUCP
which requires a the memlat string to be sent out in lower case
we should be able to handle those as well with overriding those
by using driver data and specific compatibles.

-Sibi

>
