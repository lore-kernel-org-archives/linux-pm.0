Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203C647D94F
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847974; cv=none; b=HXlO3y5V/0ErKUyN3/DzLW/H422G+Krqn+uotJ84P0ag0B0mfj0ut8Iyf3HkvIgU0D106g/bOWzwOyoSIg0CIuflOQ/H7kOQRZsl2GaiZscTWbt2n7drrwaognpG+UUWtf7DgY21YkcniJFiYfwZVxTYBan+CUFz/uy6wmuZ4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847974; c=relaxed/simple;
	bh=iJIZQDoa2/E8Qe1v8hcOOpN3cVgMl6qU1fIOM6gzK5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oq5J/B/VqSGTj9W5mmuz3aGZg5nLFCCXODw3TDRBrQXa93H8cYLhNgvFJg/L3LjlIX1AEageEWQloYTT5UHvIZ4DnEepef+OR3OyiBoulAdcY4TigpI3HmpE02AoKAylKOJXFQbKuPSBfG2kTm1qy2VLC23Fa8wRd2dCOKad3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UTSw8f2K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IIdm6K6F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UTSw8f2K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IIdm6K6F"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBFAfY4020769
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+3Gh63lxdcQDm1Y9m1WL1VQ1JCZamlpt8A+h4LCdgZc=; b=UTSw8f2K8Nt69qKi
	8nDWK/C81ASL2X5p3ypmpaEB8IUOm5WqngtqF105/Vo+zc8osTqt9xCwA/oCBXJ7
	DmQD+tx3rProm9tWD1J6jbOwP5VpHAJ1DX6EpZgx10jC9ofrtxvv3iMLO2WYyLF8
	0TQgtVUOGjomhEgKMRSWwGiM1Mmb0EiLlAsc6KK17SvyCHDXG8AzBjwogndMJ1wg
	4ArJQaQhrzigii/BKSTZTHcvDcP+gS6GGBxnqhCjd+w0Hr9mk1JPV7BQ4j2ifQi8
	RzcZt6X9yo54ejhPckUny86xlz2aVSez5iRzmQ/Ha5jMKvi4XXfh6O5N44ku4P9f
	CK1G+g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1ru7hx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:26:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-90e0eae822dso82436185a.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778847970; x=1779452770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3Gh63lxdcQDm1Y9m1WL1VQ1JCZamlpt8A+h4LCdgZc=;
        b=IIdm6K6F5GqznAZ0prC7/FgubdmtlP/OtlSZpYGSJEv+Lu7XFvMwmHrLf4dZsyjreT
         iXJs7fXewGRsTjy0MGOGk19DI4a7BD3zXr1QHS36ME631H2V1GX/TK3Nch0vWtqpS9DJ
         ETCma4OJOGcj02oHs7skL5YrAeah7C2N+QN4d6dYgK4ghe+AvahTfFcvEYSYz/HVM79M
         rTaCfQ8HqKnzDlrjYLMrcA/boBk7W3snCB5p5SnZ8j7255HsEKAG4BbJs7U9rntjXCes
         fj18GBhvu0dPJivAgfcvW+i569xYmqnYANNl9J62IIaWfqC4q915w3R/qjZVBR0AEJG5
         21aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847970; x=1779452770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3Gh63lxdcQDm1Y9m1WL1VQ1JCZamlpt8A+h4LCdgZc=;
        b=WQv3wUNKtLys9GpJpHNz5dP/p4SrTRf/W24/H7mBcHCYq7qHF/M8RNSndV1u81SUlF
         lXNEgZSldVk7+qheMRSiipjABxYqd4DGhqCuE/zyk8v4re69rbPEgp6HFjNNkMOZSxmh
         GBnNBv8/GWJVDRC6+v/4HYmL/nOTJHj6H5Z6NfGzowkZ5N9yMGeEkXax7IvCbAqJ8F3J
         c+o/CPcnomKQokV/XzscW1fzpaw1H0AW5/9rG99V/XMwGoLmb5jHNT60OxytcG5nDn38
         a5nUPTrZsGdz9aKDHMdSo9nOk7XXbNH8kp3eKSR6SHWYN4BEGcuJUgaq/2i2kWOm7fym
         yKdg==
X-Forwarded-Encrypted: i=1; AFNElJ+nh/28+m00C2liEDcLcaDQX07xfH1TEn+rTd2Y5QG+m0j1CyZtDHaIwR5H+cefyfHdbvOUGRHhvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfHWIi5encSTLWXSNrURHukF0AqrSP2p9mi+agD7VF3ZcAncgY
	BfgzcBgs/fZZcnhuNaK8oy3pUXSDZwZ5V/kW2ny1C6CJGe7Hqb0jn5aVeY85LX7522Dr8V0CSkW
	TFy+eddDwOKn6fNOtDEXJS6wycT7L/VOOjzHHN4uS19ujpOsVTCsf6nWZTWh/FA==
X-Gm-Gg: Acq92OE90OBIHjZsmFGrkU+MiyyHFbWbW392Tl8TYUzMNzEhRLEF69KwMUnc1Y/dkAM
	TuETr3t96y/COT3V0Z2YhUlU+p50Q1fyWnVxUGK5sSfDUsQBOIFYkGFIcyy/yqRzSD2g4TxtZED
	pngDIF8KGm+V9raqWQbUak12Li104eKG0XxnNO0qcmVzB/Dte0bPvjeYlfGPdQwBa0TQ99VWupp
	ysZiTJLyK6Rr8n3832nYKGUkFyFXFd/cBWKHBFP29X8Lh0vy/DqNLxkYbvQdAfe//fF1ucF5ynJ
	4nBymAwZygWx3Vg200pN/QSFq4uP1a+NXaivioT8fxrNMogb2RyI/qUfTxcqW8+3H3CCbyvr00J
	aPewl3eHW7DSwUAxV4xZVdKsly5md1dFKgIFwwnCD4nJN/n4spp8AX7dAEutGwc4dJ90qgV8H2E
	fZEwc=
X-Received: by 2002:a05:620a:1997:b0:8d7:ed38:8189 with SMTP id af79cd13be357-911cb003cd7mr402621185a.0.1778847970425;
        Fri, 15 May 2026 05:26:10 -0700 (PDT)
X-Received: by 2002:a05:620a:1997:b0:8d7:ed38:8189 with SMTP id af79cd13be357-911cb003cd7mr402616685a.0.1778847969926;
        Fri, 15 May 2026 05:26:09 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d58c79sm1980407a12.12.2026.05.15.05.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 05:26:09 -0700 (PDT)
Message-ID: <49af220a-6e9a-429b-a98c-4cde0aa1671e@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal/drivers/qcom/tsens: Add support for ipq9650
 tsens
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com>
 <20260515-tsens-driver-v1-2-015ca76f1418@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515-tsens-driver-v1-2-015ca76f1418@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A-hKI2hWlp5MlsM3jMJAP-L3aVcS-ZEC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyNiBTYWx0ZWRfX0tYT8Xw0VLal
 n9cgf0W1KEMCT/p+h/SKHWKs4Swwzdcji9gwP5uPkgDBpXx4LA3sJgUo7JKjxVXScaasGl3A5zc
 p0xfsRNi6K9GWBpMXjswAheHLz7TX6fTOyQsv3bEViKAC1xnMzwZiJQ3XPjYvcyYYKKu677yHf0
 iUlbmqScplWOVSTn9MXF5E4U9/dwpcswszfRPcd3YhnlqIcPufxXD3akGC1Biv6BZGYMkwTzTQ4
 Vxky8PrV+y6LN8OAggOCIHqViEOYVthX0DSGzFSmnUCGcFPurx7NvmjRVuec+pTWE8B6XOXPZXq
 8bXZjZNakxUc7hk/KKDfMAEdJuoaRuRGsyUDeGCja4ONKG6uIFVvqsR7j8ZCDXrHPdBZ1uVeXyJ
 RvkJbukdRXSvce2kGa79JOrFtaR8quKdgS7vYxbU03uKd4tejajQOBhj2qDVObQzuYPfXiQZ6bH
 1bheclg/tZzBt0a0VFg==
X-Proofpoint-ORIG-GUID: A-hKI2hWlp5MlsM3jMJAP-L3aVcS-ZEC
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a0710e3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=35m-WzFFBhUzNNwjB-kA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150126

On 5/15/26 12:18 PM, Varadarajan Narayanan wrote:
> ipq9650's tsens is similar to ipq5332 tsens but has different number of
> sensors. Re-use the ipq5332 data for ipq9650 and modify the sensor
> related information.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/tsens-v2.c | 8 ++++++++
>  drivers/thermal/qcom/tsens.c    | 3 +++
>  drivers/thermal/qcom/tsens.h    | 2 +-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 8d9698ea3ec4..ef1fee2266a3 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -300,6 +300,14 @@ const struct tsens_plat_data data_ipq5424 = {
>  	.fields		= tsens_v2_regfields,
>  };
>  
> +const struct tsens_plat_data data_ipq9650 = {
> +	.num_sensors	= 11,
> +	.ops		= &ops_ipq5332,
> +	.hw_ids		= (unsigned int []){5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
