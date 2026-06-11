Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357292FE066
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 04:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153141; cv=none; b=PmJT0J2meNcCvZy8S4j41smgFZCRQCTLvDNsOhGKLhldZJJBk+9Dk7Tcae9lKwqQE1nFLzXK//3FflTVXn5PHj7S/aZfHBnkvlotbbY9y4hYkzUd0995PHbz19yRbNRaDXx2EOVb1JongnpEbgq7yXFkAi/Eu8/bVd9Mttm0eNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153141; c=relaxed/simple;
	bh=wDZgTVz/oZs6fHMeDkBQJjN738mapPf0RtpZObfLSGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtehA0QnB4+thXgajg38DD2Hr9T5kYHem2iLPSp+BGj5DR5qP1GENNI1lrbHUGiRarvbRKj+POHIITWD6Qc/OWA/hybDfevKQ0WIqof6oUFgWjNimNB/tudn/jOfnPyFQoKTVn+1ZY+1r/M5ZByHw71RixwLwE5SBwMKScileCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eUCmfE5X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G8QPs6Ma; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eUCmfE5X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G8QPs6Ma"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B0NxuZ3092333
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 04:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8ks7xcs4CcsvhpxQlRnY7mYEmf/7lZqBcXTDU2LX0qM=; b=eUCmfE5XNyddAO+D
	0dw0SQBchcu20RPqbpJtWlc+F9af0uhK8DgWGreLf/IcuIAHWstGYcvZE1wBjWrP
	pOk3mE3TS7UAxtT2EbgtxlrfPWeHICyUpm/5ME2ncJCLlfHIEkDFMKo87wiJVxO9
	xTRl7wT+haxpU2/pecsGphJf0QdP8yTcuqM4gLs+mnNA/qOkCCwHBtEa4p3C2t/a
	269c2KgniB28cCu/RNw0PeGLnEqdXZ44WFMg8+cnx3oaU84JBeBc7z2zZvjNgkcL
	iJo0IJ4q4XAnWtTK5FJhCjIk5z/Zc8YSJ+yDMcDVAAVw5i6mMneD3B0oA02EzWKe
	yJjCVw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v9k9f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 04:45:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85dcdbe502so4939490a12.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 21:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781153139; x=1781757939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ks7xcs4CcsvhpxQlRnY7mYEmf/7lZqBcXTDU2LX0qM=;
        b=G8QPs6MaIde05IkbfG0Ekp9B3NYDtG+Wikvx63NT4Z3ZspkYV3dy4uEl8bzfL11in6
         MLrStFDGJVnFYS7e3PchvWDQELTzfFWBcKPMEcT0uJmIW6/2cA5gVXWBiuarZPMHIOv6
         DH4FbNHrI0Kzt4mlea1EjE5uzodvXYHLFnyWTepjmVGo6dxe0zzm9bNhzJNxc7snDicz
         O+jUMC/PFR7No/YfTxFjLT7KTnCxl9XXLTtob0AmixFFU4+P4OKHozQ9/KP0mA40d3ae
         ZXKat/xJchAJ7PuNas9iqqq1gewWuWipGGxLiKW/NBP7NyV3B+R61qq8gTSPNyLU86zl
         ATng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781153139; x=1781757939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ks7xcs4CcsvhpxQlRnY7mYEmf/7lZqBcXTDU2LX0qM=;
        b=BB7B66i17eWZk8HbisIuph8/N5HyXnZPcCZSZ8Vj9D/vpDNF537heX+uB2sXbxpThH
         kcxuIk3GVqsZd55/wviq1p0aMcQ9m8Fd5MQ4R1Eb0krSxEQDkQoRafbEFJzRf+9ZxgU7
         lW8DplSJrXOAGz/LoY9JIMUT3TraSemrRi354zP3etSTCUD/NjL0SlUxJgque+bdptyR
         /GqGmEZVFq/dt2AZ+Y3N1N7R1S2UeXyUjK3oOOosiK5CQecaIPHk0neE5ux5grS8TWK9
         QpRMDoEfRPQewwGKqzAR5q0VYJ818U3O2wrfaEGO/WqApNcRPdBB+8KFAGcHNqLOwHQc
         KsTg==
X-Forwarded-Encrypted: i=1; AFNElJ/drsuSzD3EwBMjKRio0hLwA9Tyxu9aZgrFAjD+CjPQ+lmCbouy9Uo4xRCABEZ0Q/qk8NkuQAjWnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtNCmoqVBAdnRwpMGM1Xdl9pxJKshZZReb0zvAJfVofQ2lI2O
	b0e4XqQ2FfYh/8GSCPeLIoOF7Yiy5sZ80tN9ls+rplF5656kBSgKy8TI7f7TFvb1ceZ93ga7USq
	vy0nu/CDWUvNoiFII7Rl4BCPusfv8onNR8QgQILcL6/gagcukXT8sTldGPbXsSg==
X-Gm-Gg: Acq92OF7MfrD6Wl7Hm3xHz7KIdU3m/eZIfylQQFqIMDhlN4Q6UsuXV08dbj4iu2fb3F
	U1bM/hCzpveAxQeNMpRJxj6USqg+u6QhOFEaaGcqHeH8YFkRsrNwmqgD7AhAQdJJiIjFHLMKhdJ
	26pZ7bGbD7C7ZPzbGnuIwlhSBrih0m0FUo0WZCMUE0tQJELqjkKdur5Z1h1KCIOP5M+1X9DK8Ri
	x87iK7zIVgM72hshOpaTFLuJasoVQ4stxyC6eFgykneaq55PMh1CfRTJ+UAckG0ffEefgFdBinb
	6W5G7qi/uUcx/kjVwa9f8jxuwvXNvukiZ+LW1KmHI3iCM0QaCcPiaDnHaclZzGJ6yxHaFQfuScz
	C36HirliP7srTuJ2YVoFi8Scham9edMK7AyMZFc2/QvffA4oOlPHQsl5drlax6pY=
X-Received: by 2002:a05:6a00:bd89:b0:842:5ea5:5fdd with SMTP id d2e1a72fcca58-84336bc6f14mr1290369b3a.40.1781153138778;
        Wed, 10 Jun 2026 21:45:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd89:b0:842:5ea5:5fdd with SMTP id d2e1a72fcca58-84336bc6f14mr1290333b3a.40.1781153138304;
        Wed, 10 Jun 2026 21:45:38 -0700 (PDT)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843383197e5sm467576b3a.52.2026.06.10.21.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 21:45:37 -0700 (PDT)
Message-ID: <cb244225-5375-4925-8d20-232cae9da672@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 10:15:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] remoteproc: qcom: pas: register TMD thermal
 cooling devices
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-3-291a2ff4c634@oss.qualcomm.com>
 <e9573827-81b5-4c75-9d1a-d59a4809300c@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <e9573827-81b5-4c75-9d1a-d59a4809300c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ds0ZaE73BFqPkFR_Lavwmqaq47CMf2-A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA0MyBTYWx0ZWRfX9UJQ4kIDhHwW
 SY65/IB+NK0fGNC0CDQCyFndfseC7Jd7CEAjTZRO/7aO6x4HcS4Mh+lzwnPZDqZJfzPqBPXd6Ui
 /g7sJ7Vjee+CQNwsHkvdSGAoLA23ACU=
X-Proofpoint-GUID: Ds0ZaE73BFqPkFR_Lavwmqaq47CMf2-A
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a3d73 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=cgKxsijKBzv_CCWCEVYA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA0MyBTYWx0ZWRfXzPOmThwxikB9
 UsXrCDSUabPWJoN4o2W1jk9tlx6u2gxlXrZagYkePuEGvUnuz5TAYnuGwtJQbwbCXYFUC09TEB4
 J1iYf4G9ep8imBdiDqe8tLVcr1w60qvgpCaE+hQJpe4x9uTPTMiN04QVmCRfOVMK7wJazP5kqff
 bHUPSn/3EaM3wngdVRIPJFd5W7CHjgEE1zpndXMpgOMWRIHnphryOIMfnu55jZfQ+r6Uh05OHQ9
 8+AmjihGvcBJFrjT0zfZDsq/0QYp0fxJ2ZOoV0oT6BmykgJlYu2sZUDUXqPjHYvKELMdzO11Tfd
 QJeudCLgGSMjMX9zDT6brWid+j5OGVIpCHLsvVZOlF3vbQLlDnblZqNVwq8/4dyg/4pqWuS8Mu9
 W4/syWCuDUU2X6BpzzITJ0JPcnqVq6abc0DxdcNrxJQGgtcioBDtBvr+CsCdOqp8x+y/G93c2Tq
 NcfiR1r17MqakQWf6Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110043



On 6/9/2026 5:33 PM, Konrad Dybcio wrote:
> On 6/9/26 12:22 PM, Gaurav Kohli wrote:
>> Add support for Thermal Mitigation Devices (TMDs) to enable
>> thermal throttling of remote processors through QMI.
>>
>> This enables the thermal framework to request mitigation when remote
>> subsystems (modem, CDSP) contribute to thermal issues.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> There's no other signs of Daniel in this patch, please fix the
> tags chain
> 
> [...]
> 

Thanks Konrad for review, will fix this.

>> +static int qcom_pas_setup_tmd(struct qcom_pas *pas)
>> +{
>> +	struct device *dev = pas->dev;
>> +	struct device_node *np = dev->of_node;
>> +	const char **tmd_names;
>> +	int num_tmds, ret, i;
>> +
>> +	if (!of_find_property(np, "tmd-names", NULL))
> 
> Let's use device_property_present() instead
> 

Ack.

>> +		return 0;
>> +
>> +	/* Get the TMD names array */
>> +	num_tmds = of_property_count_strings(np, "tmd-names");
> 
> Is this something we can stuff into platform_data for a given rproc on a
> given SoC (for which we already store *some* data in the PAS driver)?
> 

Without tmd-names in DT, it is unclear which index corresponds to which 
binding. With #cooling-cells, tmd-names in DT provides an explicit 
name-to-index mapping. Please suggest.
> Konrad

