Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A13D16E9
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967563; cv=none; b=PZMcfHk0GvmO2F9/X9WOnDjn8MTTxLUeKeTNcfT/pTCDM+IUFjcdKC4CAAhn/ZWub+QqZceRUYRGmeh5nT3JEv0G9dNDL0vZiaTRRDmlJZ2Eq7j3C0ct/eB2sKmYQ2NwVtJczzbaPMAoRdqB2Ns50Oi5ZJrxylG5JwzumRwUdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967563; c=relaxed/simple;
	bh=xdun6LdlXAGdhBxR1x4Opt6gNYAbFT4ZJI7bayxSWmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkHJQ9ufB4vcYbsmr62e9AePf68B8fUtokRTWWOHM9Mp8mkaa9iuKUWqMUeV1ZcyIBmx+QpB5aIFCo9jSJKCiPjkHtRLu5H1Ik9TO0SA3sg/3eXlhS4jGyjyjZ1PkcdfwX67suIKAWcaqmHOH06+RMMXb5ke83AnLi9e5ujqztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cZ9GopZ7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjnEeedr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZ9GopZ7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjnEeedr"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6454UYpi1152874
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 07:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wU+VbCf5YgKYDqtVfrNBU7YnnK1qS5oh6UUW6wIDDk0=; b=cZ9GopZ7J5FwKM2E
	GP1WrEFRgF09SeEE1X361cPV9TdbawXPucj1USz0fDo4Gte+AHn5rJiwD5LyyHLB
	GnbeW3xy2ZnwVK6mATiG3srtLkr2nZpXKC9Qw7rhP5wxUDpIFkOeo2zviqP4eeij
	BDphKUEEn1wuEpQYvHLus2giWvp7r8yLz9OakZ06PQwr6tme8LGSrnB8v3dtREuT
	bURWNTNUuATmxAKzqNQzzMGoxrKxl5Dvrc7xTfZ2eohjuGhWsG/KISCarnUBbBd9
	ymL6wBGLs1+h2TyNYLv1qSM9vrJXVO6e5g5My9QOmm5V54lxA9KPKnnuxu+ed0Ej
	feqhAQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscyc0m0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 07:52:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d812c898cso123483451cf.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777967560; x=1778572360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wU+VbCf5YgKYDqtVfrNBU7YnnK1qS5oh6UUW6wIDDk0=;
        b=OjnEeedrdd6koP4DWKZIv48SaSBalvN5vV4biArzLZJyIUHWGaxmyelJNQqUMmMNrY
         Y9lEtubJ6kDEwVZYNrsn5Uof4de4cgq4PzqZGhToavwlhBsbQUr7jzLA4CPSCUTHF6St
         Jr7YX1/CZDqQXJWGXdmDxpXVLhVzoIXhvgC6NQehtdC8LNbJn6+oHUCCShIlyXYwDfgU
         RMnv50BBZss16MzbusTyV1Qhrzj80hC0r1wlk9Ljueu5Jh7J3SzIzOKZVm6HCrCDxEv5
         2qZFIXaZdpUCMVSJpo60/EapEpOjoEIRwgHeATIIkEijD3hQCQ21zl9Wp632cc/NNrqA
         EGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967560; x=1778572360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU+VbCf5YgKYDqtVfrNBU7YnnK1qS5oh6UUW6wIDDk0=;
        b=E+2v4YnwBmnqYkLnYX6lIy2HmL2nG9AstfJo7JoaC9ArvwWRm66E3rfS+xvSNB46AE
         5o0DfP2I9ZUmqE93MdO2s9Hp1vdqFL17qZrbkO3hW1esOJYAX6IONzCGQodVlvyfxYg3
         V7dKRr72DSE/t5kwf8lYWQZK44SX5k79/UI2VUI5IqYL6B035igdr+UfQX4OKlBF3W3/
         5qj7zO/AohYBZuPue2gL5YysSIuG0iXq14lYtHN01UgK/F5YW3KZsrRtWz9ocdSyYXJG
         tqxdYmMttZ0KhFrHkpYpGA7o0FeUtO0lQMUdKEQkzokeoUy3IoN3KgTnPiuuFFLY5eAY
         n6xw==
X-Forwarded-Encrypted: i=1; AFNElJ8WKkAkx2pMVOVflYaVOqXnNXlwi1MP6V91nznRbc+ppxuzGGQ3ObWvRfRfC1rq/+RdX4d+Pvd/Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxna8BsCDPrbm18WcpiFpQ+jD7CvR7RwjjqeQwEExyKNbEkR3NZ
	+KvsW4eXUg8AXANHqBicgnR6NOVjH6sb6YCNJZUyuvPI5Zs9EHwgUZGbyna6s5+5UYu2Bjww3un
	VrQZeo6J3gBAA23z58O7SScgM0KpLGm7BQZwKLdhzjbADPyWbPsvrdIC5ucjf7A==
X-Gm-Gg: AeBDievTPSr9qLA+pG/BgdMNauOpZ69wZ02b49l92gyD0uVaaTG9j5h6/Mzi7KQ1rq8
	Lj+AM74s2CynsE3DbEJ4e+bRyfpSqL4si8sbs4bux9u+MWu41I3Q1i7wuvMbYqovCtyyCMAc48/
	VqO2IZarNTIQmkqXFwdCaa5Fo4KL/Fn8J6Wz4jgcOh6InjvlPANnyqY9h07OngV1RGSqHmZm+Hp
	nd+g1kiZfB2GOtV1lS6cOg6sb9dIHt1fxuVXQ33JByEpmCLSdKAjiy1uinht0/VpCFGfNY4wICY
	Pfb0BHWFrW8lD76PdMUwLjGrCxRVRvKBvFgjU1LmAYfl3uyNNT2rclpJay590KG8oHL2fYpXu1B
	8OO5Y/VwyD9tzJ83Ih3ldAZdkgUjjuQTpSaE2KmLbl9JUV7JUWT2/F8UkI/xpLiZtmSDkNp4QQF
	IjFaRczZ9PNxjzMkC7
X-Received: by 2002:a05:622a:408d:b0:50e:631c:c38d with SMTP id d75a77b69052e-5104bfed310mr176997871cf.46.1777967559963;
        Tue, 05 May 2026 00:52:39 -0700 (PDT)
X-Received: by 2002:a05:622a:408d:b0:50e:631c:c38d with SMTP id d75a77b69052e-5104bfed310mr176997681cf.46.1777967559582;
        Tue, 05 May 2026 00:52:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d? ([2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d149e35a9sm16483455e9.1.2026.05.05.00.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:52:38 -0700 (PDT)
Message-ID: <510d693f-1cff-47cd-91fd-4d14af40b65e@oss.qualcomm.com>
Date: Tue, 5 May 2026 09:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: thermal: qcom-tsens: Document Nord
 Temperature Sensor
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260504081236.825755-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260504081236.825755-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA3MiBTYWx0ZWRfX74I2AP+RCU9D
 UtDhPatygOf8b6hwK2peCO9coW0C8NERYYkHm+Lbm/iIXxhlJqRRx+wXO0jx4eDadN3rdwmwDVf
 u8VessopCTA5WA/HKWkVVSDR7imQjYBMgzgC+POvOm2wzXOPONcGX5rCNTuW+L/oiwUd+JyNe6S
 6GlBDdkqKiMgf8K6y2xuLFGxlAGxvQjSuCmCtYmb1jH3oJ8Zs6SJGc2N0LCCtxHDDrSzZgv+TiG
 harIt5wIPvh/ld1IFrpZDfgG/WfQBPENZ4Q/Fxh4XP1TlhGkjLR0kTOxM+O85OodwKYtwndDuEp
 FyfHmj4ntzlu8j4En1C/t7VJQT1Us+gj1wjDDS4LQVKQG4ypME3KtnKbDcHrR+dUm3f0XEHGM6K
 dSJViaIcDg5+TDho3wpJW4UdPhMxHTZuN3AqmKAJxpxGnwz/mDm+PDUAwuhJ3hQYp/wIvJmDlwd
 NHEoFvAlTORJcO/89fQ==
X-Proofpoint-ORIG-GUID: 2m-luylri7u8BYul_AiCuod80Msxc3XJ
X-Proofpoint-GUID: 2m-luylri7u8BYul_AiCuod80Msxc3XJ
X-Authority-Analysis: v=2.4 cv=C47ZDwP+ c=1 sm=1 tr=0 ts=69f9a1c9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=CVofd9qyej9kTKCMH18A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050072

On 5/4/26 10:12, Shawn Guo wrote:
> From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> 
> Document Temperature Sensor (TSENS) on Qualcomm Nord SoC.
> 
> Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Applied, thanks
