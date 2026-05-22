Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260303C3BFA
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443244; cv=none; b=dLGUOBgWk+3QA+z/4ldG9bV+2J6qcCugeVyY+fi9lXQbUBoKm/9axuqJ8GoZdGVM7M9JHG7lOvRlygnFzb0lZ7AHqCpT/+QZPF3Vg3zbOTBD5aL+5HaygC4ytETCajmqvq/mGR34YS3H0GGm1QPtUrg6jDZo2RkjcmPtTJ81Xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443244; c=relaxed/simple;
	bh=zhynE7fpfbaeCJI0HZCi9xd50jHaLx72XtaP9KIszcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsODo3SnbYMS2iRYlXQqS16s0HBn0HNZnX2Y+IzYqCmb50CuSaxpddaLKaZlfue6Eni4JnY8214MQqIxbkmr+D86/8QXrNCJUhSYi+D1owMyIj//CSNqS+API5ZOQ/Tj5kzdBx2BT1EjGOIKgJvP8T6awjPHbO3+YzazuNQoylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oe69dqVu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EuacJqW+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oe69dqVu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EuacJqW+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M9BnUP3005110
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLasbVuHWA6jDYVcffIJm6ecP5zXaFFkBR4wHX/Ep9I=; b=oe69dqVuPm9wpef1
	KJbK8or45bMHeDFGIaO2/+EHV5bSg8BPin9KWxe3iNSTBcfROaix82oZM62IPfQo
	5Vvq8FgB8jA65wFnus46C0yUUQkIa4E1ow6P9R4a5X1gqDZydpgGNArsufDwedtl
	53r7jJ7/b+oi8ttOGeLC/aZbLOdtMH9Ozbs015q1+ZX7epoy/htO1aKTYW/xVTyg
	WC/WwPqbiQhVygtnZbtFLhPsEZP+qm79/CMaZ8bB4r1jAnm63MdXB0SYFa0tlIQ9
	eqEcxk2rthKglyr5ve+u+GkbC/It9xArwAYLBdRF3pVmTj9g7VAZGBFUWdzuu8ik
	kQp3jA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrt9d5t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:47:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-90fef17f6f5so183998585a.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779443241; x=1780048041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLasbVuHWA6jDYVcffIJm6ecP5zXaFFkBR4wHX/Ep9I=;
        b=EuacJqW+/bSybIH4/TYayaudd7NkOQFSO9TreQV7pRSDMvcYTwyqftqBNHd6308CuD
         HoA7uXiaPU6X2Xl5QP7zKtx26BM4jfUF5aJlcwJpr2YqvdRsbiYNf/bE8WBEP1KrGYTN
         wU/TW6D0/jsMXaDNKy61sVOMaeOmZUVgNhgMwks92NedyXEirxaAHNl0jdnHJpRFphog
         MwgjWoHiAEqi/ZAYGVR1xc/1ha7NwoaMBrypRQBNttZ2KytIJrbT992cN0/pWEPkM5MH
         3+uLVBNlXi+Fd/5N0pMFjkmOyy2h4+nSGXy+eKBWI0ejHZlxbdiZPlOhvYFlTx0OtwWQ
         /MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443241; x=1780048041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLasbVuHWA6jDYVcffIJm6ecP5zXaFFkBR4wHX/Ep9I=;
        b=DIpfyVWzA7s5dzxRCoNKneE94gJ4CL3g9UWISDXmBnag/r3CRXTDkkzH3v918p7YMh
         HrsnaiCa5KQTAVaNkQdOUJHBMpr8Q5OwQZ9jNrP64lAZFH4nP9Dly0Srji1MRnNjfCTy
         3t597JPv8+QFvM46QLq6xG6j/EDEFxbhNd45fPSeU+xanA+yrFNRbVGxkfSycJF+rqBA
         XktgypBrAoyu1PxYfx7vDSEVUTBkNz1St+1aUUlWvLnviFk5NQGr33JE+WwuzV/OndvA
         VFvPe+MmnPksZiEorWzhwQtYDlnllInE8G12rVW7Xe+JfnZN4OZY2tfvEwSsCRDx8oLQ
         x9YA==
X-Forwarded-Encrypted: i=1; AFNElJ84iipkczUmAjVJhF/ojg273MF30nbINEoj6AfGpJVFwfN3AQuUgco+5zQd5fTQ0PQkjE4PnVq7IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMDND/vVg3iBT/ZcHYMfgX+GYm1n/30ea/w4HoIiUANkuR0yi
	GWiMiAlGDpcPJJq8QsZMGKDnunoXif46Pq8FhFKQVqEnmoBMpTLKCPYxHemcaxGfnE0mruIlLkX
	wbjLYBEzke2eOg7gnJFuKyxFd/M0wZXHsqmqU0fZGgbD4XAUTi+/2tvQdKDVuBA==
X-Gm-Gg: Acq92OFrrIUgv5srxUcoT1UDevKaWENDUHurgtLL1St5UlQiNgTtWz4JgNeF0/Z2c/w
	ghD7GMCQeB7P6wMT+oKJDxpOWkeoFV/NLkLqOIxJHaBRMQapjwOpWkIP6+dKEFaKCXpGPt4MpVM
	eZrDR8xLgJ9wgnsx7YHa/Lfs9QVOMTdDtthfBEe697Ox6gQq7WKRhexohkMhgmVhA4gotfnGxsw
	pxCT/d42T2cWbgxMeZfV/ehkK27EQkYKLl5YK13/Y1WN6r53uHQQ1QD2jLTuI3f/rGxTTkWghmb
	LxxcrfesfHHAzs1w19KgdqaD2koef/mL5/0eHWqdCGiu/FExhmHQcnskEb3FiYXMsEl+ANh/QTo
	pWEVXytiaQGVN+19FED476R+OrmwrlOmVfWROAQMQyKgeuXReB45X4cgP
X-Received: by 2002:a05:620a:4711:b0:911:1263:fb35 with SMTP id af79cd13be357-914b4a3f840mr285196485a.7.1779443241331;
        Fri, 22 May 2026 02:47:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4711:b0:911:1263:fb35 with SMTP id af79cd13be357-914b4a3f840mr285194185a.7.1779443240934;
        Fri, 22 May 2026 02:47:20 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bb62b6dfsm465344a12.30.2026.05.22.02.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:47:19 -0700 (PDT)
Message-ID: <20d202af-7a63-410b-bbfc-cb695d0f7f46@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a10262a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NyBTYWx0ZWRfX5tlcTumqb4dB
 WQWhXFOg5EbLabFnRXJxxM6eMq5Qa36oIQD/GeQxhtLCqGgZMb1K28XtROMkQL87x7HAaSFw7Cp
 6ynCWs0CZw0J1GI3+JHBJGaMSxH6q9t5wLbFQM7vtTIwFf3R2MVP0H2dgyVra2ytRLjeIZ2mLb2
 iNiIyUQc2XGVu/LpCn6SY54dDtF9Wo3tRc5/aa5xyNVbVg8QvNHu9iiO+KHFBg+orRdxVGZ7mj+
 wF0WAk+SfRh8Fx6zW73GyPoN10VYhwPcs9t/RdjVYwm5Hed5QgJR9HqrML0EQUP/C5r+QArsXiS
 MCPD+IV3qj1mAAYy2U7I0RqBgzS2Vnzjdn6lYIonDm82Susm0uRmqhm8WFh0Q/y83OLx4VPDjpz
 NNL5L9yUIRg6tppjiGiW+ElzYTZOhQ46bQ/uU6gvvgl+OwFBw8qCHUddtkCJN4KWRpisFQ6udbD
 /fw4mWcqH42v8Ki6KBw==
X-Proofpoint-GUID: Lfkrpds8UinvqhDDC7L846piG7faq9uV
X-Proofpoint-ORIG-GUID: Lfkrpds8UinvqhDDC7L846piG7faq9uV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220097

On 5/20/26 1:01 PM, Loic Poulain wrote:
> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> Arduino VENTUNO Q board. The module is interfaced via LGA and is
> compatible with the M.2 Key E.
> 
> Add wireless-lga-connector node using pcie-m2-e-connector binding,
> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> the Bluetooth interface.
> 
> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> the pci-pwrctrl driver can acquire the power sequencer and enable
> the M.2 slot before PCIe enumeration.
> 
> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> (gpio56/gpio55) used by the power sequencer.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
