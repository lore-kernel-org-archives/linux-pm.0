Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2F3B995D
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524916; cv=none; b=B9czqw4xNoUE6hc14ymmiDAapM2+IwOzmq9R3X0jPi9QMDokeZfU2Vj6qInft9MzRX4jqLmAJYB7uajkWPLFhapo7UPmKtPRWWqNPhACcQ5kBN1rCNIMUHmhPZpWdpVUt774vwzN21kRkLy+VMhCcvLGUD/lRCzUvq9POVYzayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524916; c=relaxed/simple;
	bh=F7MqsTpvXEhShRZzCrVhWm+SLKO+Vc5RAc23Ul79HmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAfKyR9M+4iGr/thX8xCRiOdHubG4nRo0tG4+ySn1SCTX8XGivHPVdVtMmvfAfEA8R0IAH7OrdY+r8tFCEQuovy88beE0NNb4cfeSbwVGhPgdVqYx3NPglEd/909s1SDaNSAnzIzyND8khyZyk+9zJEpt+1bFHgymVVPri4VpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cL67h0iu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QfbOGbE1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cL67h0iu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QfbOGbE1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8Z2AY3848686
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l/9WLhEJTgXWRjhzQHboMAkJhxat9TGdxV61Ba2hGvY=; b=cL67h0iuMunP3Yqn
	+dKF8mXZ2XFnPGfyvHp1w2Ih1MY1WrOc6GqtrXdddlSD7I0/N47HFrp6Div3gJ4N
	KSf0k7v4+2I4IDFhcaTepJbDkcoV0eepRY4mCcUExPzizr1RZuCVaqtdzohIYdkq
	C4aobWj+TeBFiCVxLqNYUQouMenBZeDMXHXsWhzR//tZPW8TUGKKDIB80rQmCA25
	ZujvmJvrbpJtjiwR12Rs24X/aFvxhZSvEsQO4USZgnlEgX0t2cA5XejgTsQc9YBT
	Ad1nc5Wr4jv9C01nbuBtwEPSe7UWmUWbuftY/gnXRceX0v2IsDfI8M7CqP12vA+M
	4zclJw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5k0pe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:55:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so932246a91.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786524914; x=1787129714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/9WLhEJTgXWRjhzQHboMAkJhxat9TGdxV61Ba2hGvY=;
        b=QfbOGbE1dT4ou/+9LRTPtoNUH8UNZMkDn6xnSeV/pE9QkX4Ue23uAY+ExS9evvb+Kd
         Jzz9jdosEVxztAA5YkGXoLBG8A7dFoITcxBJutE0Fe34VCuHV40njSjniTPwPym4o94L
         nTivS27WwQL6OOhaJm/FHjUDOLwhuSclxv/fVdomAs6LRniVUrPj0FcvT1TprseA5AKS
         HpaXqlRqiMk526WE05YSmu6nxX5b1/c505GE908jb+CVU0xJPVzjlUNQlLBxQAnqZvKB
         jWSpAhZHbRetdAVodjucv2osdP4avQz6dHnsoSVhVhuHKWSJnQYcDBezx+o+LjJcDSuW
         JQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524914; x=1787129714;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/9WLhEJTgXWRjhzQHboMAkJhxat9TGdxV61Ba2hGvY=;
        b=K2L+DVU1jI1sco3Rv0Fk/HeNdFyRMAeohMxQck6GcJpo2fH6GC13qDRiFm2WSapu4N
         xOeUKBULcEQHMUmsYVLvoEZ6fxu9h4EGGHguWn6VslsMPhrutTyV0G9MCm9qGZTC+ps0
         fnJzGdcScgktfLDQqkmJjU/2L0Rk2/ntYpSwsWQXH6FODW/53IBr697xqdqidef89g/G
         AON0suzITxb17SEmN3HH2a6iRbQ3IIGU4+yYSQhkyJnzjA3Fn97hwN5oSIFWOdi5/bPI
         gvqgqdN77g5pKjXljAeyxSAV1eZ35gVPXMM3nIeRTu0iMokYzW8WQIPMqRRhdF7zMj6j
         3hOw==
X-Forwarded-Encrypted: i=1; AHgh+RpV22XeSS2x46qQ+kI8NgL2w+5g5deTBKhaMW0VR2y6cGuJxkibpdAWK9xY+O8w0LnvuQ0nywVLcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+pxa4n2IsyHwsegp3o62XXY+ktxagq/CJn3I4oV9a8P1CtmX
	wQRdFOKlrwjoVigUfN8+G8NCLQ5TUADBWbtWmenvTtY5vQyjcvO7402S0qFnR3tI3RERomf4MM5
	aWgAZzRevMGCwBWLibzS9u9gy3ZIBaKff9MSF9XL4LfRc/H8etwuunJQeJLELx8wK7rgnUA==
X-Gm-Gg: AR+sD13birotpQ2LvNZYRVJ6W4tdq1j8wc+F6jQWlUA20uzvywRK3CA0v5lmVkVdcJ9
	S2KasTrmCUkT1R2oded8rdJ3aT79nbyRNtfyCeBE/H9P+1I9UO++b9q03Fxmm4RiKXkiLi1x2EL
	wOv8Eno5YLAdmP2a94KThynjv1Y5mg+3l9vDpIgTumQNpn1J77sRMUAUT3YQQUVCHStJ28MstiT
	QvPXfmGpE4LUdUXJQp9pzZh235nXaW/IchHPoo/CKOi40huJ5xsvZ0+fy3/nU1ZziMhY2YA5gG0
	RsTNzvK9jMabijvKr02rHqLncUGEbd9XpoRb9qa13CCjVFbrDwOf+yUtxjSnws1KCMOpZZTVvqk
	CQWb86HYOt9k/Q9mAZ2zhqRNpWDAXx6GthA==
X-Received: by 2002:a17:90b:3802:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39301490a5emr3605680a91.11.1786524913687;
        Wed, 12 Aug 2026 01:55:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3802:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39301490a5emr3605632a91.11.1786524913227;
        Wed, 12 Aug 2026 01:55:13 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f908a82bsm2808212a91.0.2026.08.12.01.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 01:55:12 -0700 (PDT)
Message-ID: <de19d0ac-3b3c-494b-a3da-028570989bc7@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 14:25:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] soc: qcom: geni-se: Add helper to set SE clock rate
 via OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MCBTYWx0ZWRfX7x2qTAkhNYCu
 H/qvgw5F/NyRjnb16eQIUFud7bZwfi6a82wpuYwymUTRwcyV8qdSRXlKTzCHmO5Hvh9tpKSqoSi
 2+vzUyqjxEjv+YJgX39jGzKKjx7zdG4=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c34f2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9aiwZt7zaXvVnErAyWsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 3RXbyh9Gp6gRxZgvPlZpxR8V5C9c3Qud
X-Proofpoint-ORIG-GUID: 3RXbyh9Gp6gRxZgvPlZpxR8V5C9c3Qud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MCBTYWx0ZWRfX0ci05fXL+6Ik
 B5CI5fxAX8q7ZXaU4ooZ4cj6WE3kVvtwrN+v1qsLMyOWeC5aL0dbPQ+3gLl5mCWD/ZOjcIt4VQo
 PHdniFtR909+4wdLFJtALyx/6FIGxTOpHpvr5WPwJitcxCyfrpTCkx2rvgXzvYZ5P2E0sqAL8AC
 nBbYjUXRb/vmz1nuXTtSAFP7/4hF759WfM8ckcNI/BSSX/XDsk4fupvXvkzqbGYnn41iFe/hWWj
 RByPO+cvZ0iQeN4pmDs/fuPKmywb+gJN+Dp2R0iOQ5HeHkhH3sXJD96NYNxj9nc1yMiEJ9wXuI9
 ZyX2t/whWF4JFQtJ+j+/lTjQzRbpaPdbSBHOY/ficIVVs4n93vm6Rh5avJbHKxal6rCz39He2NF
 9JkkbWhlen338QxuxENzm0t8pbgqB72f7Sjz3nIGTQegAbNXYAt+16Bp03MehfktXIU+Mg5ZyrU
 C86BeBLQN+bsdIUeSyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120070



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.
> 
> Introduce geni_se_set_rate(), a common helper that abstracts this
> difference and applies the requested frequency through the appropriate
> device. The helper automatically selects the performance-domain device
> when power domains are attached and falls back to the SE device
> otherwise.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
