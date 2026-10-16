Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3002361DAB
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142056; cv=none; b=qWBBmeGGFYazF+NwMZ1yERiXVfe3UZIa/GX/+tiFHfPoJb6C/vrvbkPt1HDD/obt4KMt7/fUuO6wKoCojJPZmsT/jE43DFY5zXHLBHrBs0jVktzUQ9FU3Y3rGnuaMN72nFOMRXoDvgLhhsyqApTrkEBDXfxf06gSza5h0l6Amqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142056; c=relaxed/simple;
	bh=OJEq2jEr53ZPXKtp/Mi680q8DSbM8duPldM1a9SdK88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsUMtoVXYwNfJV/LWRKFh1p/1g+z4xVRcvuNM9c4GtjHZfY96+qCEGAyGnW48prtvE6OP8VLbLnc9eMIZgXM1Z1uUVUwLkzZLRxhOJpfQ0QWxeakPYOf3UZeNcOy7NKNCEFJXGe3AC2OYYB3RZJ7KYRDMHgDddgdcFa436YwcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZdOlJQdv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zx0/6/DV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZdOlJQdv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zx0/6/DV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8m50f1465297
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 09:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SrmfRoS479RGoNTAm9ZWMnLNQHWSSZ9Tr8xg5KM9gZ4=; b=ZdOlJQdvAbIjdPSC
	Vy9+CDU/vIr143YD59EQ7OMYrTupZmxkqtPLmQ3L13bVy7NXmseGptjs4b7cXz2F
	10NunXJvNVFeMM3h2ez0N5C282oCn+bW7kooesVDKJB5lqjhSI+E/3VDDrHMDDuO
	o/ZO7U9nO/LMtzOFhqSE9qo3NtA4BR5DBErNiRVzHGgWH/vraMkbkNPYlC0rLedp
	f2MkUKAMOfc7u3B/T3sSdPee0Po+Dq79CwF3U6jLe6k+RSfuqVHWZMhtLfiTQ2ag
	rA3KmCXNqh9o8tgGf6LXBvtVpZwCiMLMPrwPIwE0p1jwuxxo64WciA5imK+DhPEf
	1hXe/w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb21wuh6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 09:14:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-535d44e2c23so11047631cf.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792142054; x=1792746854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrmfRoS479RGoNTAm9ZWMnLNQHWSSZ9Tr8xg5KM9gZ4=;
        b=Zx0/6/DV1luLr+8n9KpHLUgTN1ZpEI78Qxqq+Wrr/yRdCC4k8dPgy/kGdVt7hji24R
         bdr6UWHQiE1LxCBf+uywc4Z/dl8/1iF9iivGWJs+RV/WAf2eTGYD2hyZ0Yej8KTII6tU
         wdcTCAQrch5zcdUaSa7AQI4qzhc2WqU0pXjZsCld9tcVlO5nrvwRgZN+wfcUkBlc8izk
         XCyy0QLnA2ZCSeH3+hgwtSd/yx4k+y27m8MEm8VZnJNmDnm4v4oUuWN2CipEaVIag7GU
         drxM0qYfTumOJVWArgxjRBOwPHRpZtcHmg01THUnzkanW/3z9osTn9YO35+amJFD7EUq
         YWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142054; x=1792746854;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SrmfRoS479RGoNTAm9ZWMnLNQHWSSZ9Tr8xg5KM9gZ4=;
        b=ZZXa4iqDzkidvhGZwmVJPbjKzRul5+jL3J0xm6qXgMclJMUmbZ1atRLZ2rGBsQCMZW
         A3DglgS5dUQTDvDTUbcoyF85kmtTdNNVkgK3pvgMEJZHnLM1zbqdXinnw/9qKo6HmBT5
         pN7Ec5wQHqUxI7JFgIIgoYx5QmbSYrMQ94idxAMxmg1zOXvLoenPIaz1fpjxtHUj/tZF
         Zjyj9HZx5SD8Y1c7r9Uu6f+V60+Qpj6s9VUmmXqVJthReF0+gTWicQemkLQ/xjMfbZgL
         qTIcY/aJpdzMfslLEP2bdpoiM3mToBxCOy3c5V6ayY8xHyZ2z784OJNhsFx2ZLodGmta
         Rh0A==
X-Forwarded-Encrypted: i=1; AKwUvByNzlCHuTUYCtBvBikwrqcmKIo6DQPcCyu3s6fKW4zC/nWb1ouAVZuB5DpAF8s3E2I5C+LTe7rBMQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI1K5cwKAQ8j7V0b97Ko0J97p9pE2bA5oGO340H0hnf9j4N0bdO
	vDegaEyalwjkDVMOFXsAv6kadehmkdze6jpLNpBoR6l9XF9HBt8G5lD+hL/2Sq978kJRGFlo+6b
	To8eoflcOUbPABTGG2MeRaWs12uAyJr4l36r1eYfP1Wjk8tVDTTNOldjQZWFNMw==
X-Gm-Gg: AYBFou2gmLYpjsNTr7LrEFDyBzno1pdQR8y2wzseW0sB0svUDXqks50kTrkw9d7QTyL
	ZV8ziZSmvHWbSv53L/l+YvcfQY2l0xNlBvB7Rbz9Rvbr5Pp6JunOodUAKgptBqShCbLLLmd4dac
	hXIziwKv//Jkg5uCk4QJiRETspa77lIqeKgCT7c8mSCeCTv0R0E61uCMjdkZPTq5Af9yK84J7My
	7yyFk/TV0p2TgEeF/imwonZCHLYQdt4ebFIa2zCGcPTHXhz9e+aT1iPmiPBk2VhHaylZnAwpvA6
	vTlIHwEYqJVnWBrvYhUANmVskGEsoBIm6CH3p9vzWtOE9DzYypklI3G8ZKcaqo9Kc/QKSNd/qGr
	00dzSa8/hpzGOIAlxIR0A3w==
X-Received: by 2002:a05:622a:507:b0:532:d67e:bc2e with SMTP id d75a77b69052e-5359f0634femr420038001cf.0.1792142053813;
        Fri, 16 Oct 2026 02:14:13 -0700 (PDT)
X-Received: by 2002:a05:622a:507:b0:532:d67e:bc2e with SMTP id d75a77b69052e-5359f0634femr420037111cf.0.1792142052249;
        Fri, 16 Oct 2026 02:14:12 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c1282sm53264266b.63.2026.10.16.02.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 02:14:10 -0700 (PDT)
Message-ID: <4244177c-2ce0-48b2-9a0b-d63f1c420f9a@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/3] dt-bindings: power: sequencing: qcom-wcn:
 document wakeup-source
To: Linghui Wu <linghui.wu@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
 <20261015041241.2186521-1-linghui.wu@oss.qualcomm.com>
 <20261015041241.2186521-2-linghui.wu@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015041241.2186521-2-linghui.wu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uEAVoVKC2X8HTPWXRPSVqdJkUgrqu5KD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX6fdjgod0+/rq
 9naliFDiut90DNHLtlXI+8PNMZurEMh6yoMwZla0PmGbZkOqfAqlAjuKqa13ImSD/7V55cqz+9/
 k/d0LxrejuDQg9h2JzfU5t4A5M8W9f3c3BlZG8Ty9nGso2t86zovqQx+htDC2VcYxV2OrJVWgwy
 bZ7Lx9SYE/n8loA2xlkOub5UeTFHTcsv+iR/6TUEC4d0g3FIB6hp4UbYZpf64K3RHoZlv8cuecj
 07B/5nBEjpxHzZwibci52MEWNanZSZsEeMFXAdLBO7FZIEwGK4kZ/ljR5BuIsSLYadT3KSV0xDx
 /xIrEvyVMI3hOUDRpIp/ohDpoqLcLBpVmiCuJ/8ybubw+vQaShJR0lrj/jaGyjDIOa9IcCcMoKj
 PRhCqY7sZLYHW+9bxPgDpiHT9SaKpfR3POtNmBzRHk0IlZyws0A3LqhbXMBdvVVPJYykzJ6tHdV
 u3XFyfo2mXdkDNRCpow==
X-Proofpoint-GUID: uEAVoVKC2X8HTPWXRPSVqdJkUgrqu5KD
X-Authority-Analysis: v=2.4 cv=R5qWitRX c=1 sm=1 tr=0 ts=6ad1eae6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=R5NHEjnr-bMx3tpQEQMA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfXwcATmRZ0wtID
 iHEpBuugQsBaJ4QvPwfVys8rKWDtvWHJTYZqyVfGnBOdknLGQ08u1H3slAUO92Kc/T9UFafYJak
 HL3P+Y/yCmhy5cALmKlqkPJbGiuWlRI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160036

On 10/15/26 6:12 AM, Linghui Wu wrote:
> The SW_CTRL GPIO can be used as a wake signal on platforms where the WCN
> device must wake the application processor.

"must"?

> 
> Document wakeup-source and require the existing swctrl-gpios property
> when it is present.

It's a little strange that the property lands on the power sequencer
and not on the WLAN node itself - although presumably it makes some
sense given the latter may be dynamically discovered in the general
case

Konrad
