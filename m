Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF643FFAAA
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006624; cv=none; b=t6epMK89PuFCW8OoVgoBMJSPq7ykh+i0N5SwRq8QkSf2s8pneEb8Syzec+MV4XO4LSwfPa9upMOBWWhfZcPk4H/u5GCiZedMoev6A6gVeilsGfC4bMp20T3AhlRuvwqMABkFFqEOzPciAs+1zX/UYPKcPI5fi3zRi1ga/lxcliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006624; c=relaxed/simple;
	bh=HfvR5gvfgsOcrHJ3L3OGl/zGy5KibbcsIuOZax3I7w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S43YzvrX5VTNbdavPq4/9kc++vJH7DLzHg05szw0BHFVuAX7ciiKldiLww2wdS6mPP78L48dFJB0eS6ZRGeP2gHtSaJgjdIiZmJoTMxFgE04a8ekJLtQF378u0aG39xvv0G0KauFtTbGjbT7uu+WRkuOvhalz1RqjFOeW191uSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxoC9Ezl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g5t44r2Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxoC9Ezl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g5t44r2Y"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659BnGR02491012
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 12:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t2yOM2NAjtAyFgfFhbJW5TqogRr+sQYkIoqann+cFi4=; b=BxoC9Ezl00y3ZCc9
	V6RNTeDCYrLxnHn5u7ZXXjKT4JnD0EgVuhlR4G00zRngdGw33S2w9srfMOuBkcaG
	WRpFzJWsFNLyTNKiyxW0Dha0ail5foTmmkZ0CC8U6BiWF/nYWr2F0hIKANz8T7kM
	jJgtD+3gVE1y2W/4LEVIs188XujqZt+98a+NohmZMUfmBe33rJIOdv803v3qisB+
	UaICFliMjPL/7Wo8iU9rf/jK4EynXDGN3mggxMvd3Yn3tDKMM76/wQ9ibsJRno7y
	TAmCiGjXOMho3NgIuuEcmCqNPu+UqYBWoVfsiVY+63RxMxRJF9yuPYgCglJ59+al
	vOs2QQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdds9dwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 12:03:40 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-59d93832d86so306793e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781006620; x=1781611420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2yOM2NAjtAyFgfFhbJW5TqogRr+sQYkIoqann+cFi4=;
        b=g5t44r2Yxp3ABwCqoK4hyF91HHK26M+5ziG9iRld25cqucLaEWOZlbRILWSqM9SBNC
         jCDBS55rgycn7ZzCUAcQ6MaT/inK9SefCkuVTleosEZe6bjxvOcjJBFiOiUgKsjhEruM
         z7AEoOn6oVOvE6+sxVJXazmGUrAR5PQk1CYF/h1s/NfvcjwK9sTZWs8VFP2PXBW6HyxO
         DyzJFBJkXphPGMxXQfu37lVA4xOWL8I/2xm0mwVd+Vw5zzMPq9pMBSYhHBCptvbcywCI
         NstuT282qr2zdxPdTOMFyzqDKLL9lfJ2WfieS5P2IL3iCiPMhr57Rd2u7Addm45ZdlVw
         55+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006620; x=1781611420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2yOM2NAjtAyFgfFhbJW5TqogRr+sQYkIoqann+cFi4=;
        b=ruAIQT1LleGZueo3w1rVUtTqDKkOirS8TjANsvhM4YMbe330sF80OSInIyxMPaIaw0
         sprELDiJ/+1oKU2tYPSCQIh6LiBP039kvTlUa5f1dL9ysFt6gqCmERzgjJHYe0R2H1rQ
         MvoChNGCtbESKKHu9dK0yO7FLKHq4A9wmIn9Is1JH4qeHRajyBC9HQjmYGH2T9irSZ4S
         73ga/P2Q8QvCcaF8ERFjbnBPJezhDJhrXHtZOBq7MQxg9agLz1Vl2qTfFzio13A5aa0m
         aqf/B53hrqnsEGNHrfo0HV/eJ16gFOr3gfKxSePJvGe8f3758V6BRmSiAUeSS4fc3Xz9
         on4A==
X-Forwarded-Encrypted: i=1; AFNElJ8fJR3ZtIsLMkw1QmCkzDygDGRXUyBUAWzI0DFAcUQuvaG+Xo9eKZnRjsB72mqwWI/gI825krwyvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5UgVhaJElvtnEb3qmHJdR+opL1XUjXHbYxOVy0AG4jJO5k/J
	98MpNcXjFjfK97hvTa2dGZnag5+mtIidgvrUqXhq5o+C4YnTyOjFDJB9r9GOaQji21qxtQTxGop
	aqF7DdZcb7OxiexDG/jk8Oe8ArrzE1WvAMRhBPI6UO52QDL1DiLKwkByuzOiHVw==
X-Gm-Gg: Acq92OFThKKQgxuUg+NyQ1NvX49F3sx1P83qAti7ZKnbenoTj3BqCXFMkOEWW8PAQvW
	o6+W86y5XNSMmQ9jRcy30p42FXofrTXTtWqkTRNRbjmqj3kasOOFhj8UL7zbFAMgrWLYVbjWZY3
	VDJYUwcV5wLeadOSlcnzqhcTeqgY0yqhES12Q5o5JL/JO3jbY0v2nWly1N3z2ROu0UvGXvmLD2F
	p8d5bxppP5dmThQkngX35XqVJyi5pwCLYQVJ4yYNOaoQnLejKUvNkHg7dvxi9ZDBZnc8fyHKXW+
	SiAJqNlyFLBfSlwlyf9irozGLydB+LqgY8HzPOD4KwQzNEQkQ5lD5zqAgPH05NYd+YXOo31VP/s
	HbOkV2XuAwemVmQQPnD/IVKcStc0yWvC49+zpW/LRQa/o8YasX7NjgyMR
X-Received: by 2002:a05:6102:5a92:b0:631:b312:a2a6 with SMTP id ada2fe7eead31-71913522647mr343133137.0.1781006619730;
        Tue, 09 Jun 2026 05:03:39 -0700 (PDT)
X-Received: by 2002:a05:6102:5a92:b0:631:b312:a2a6 with SMTP id ada2fe7eead31-71913522647mr343091137.0.1781006619215;
        Tue, 09 Jun 2026 05:03:39 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64e29c0esm8716512a12.7.2026.06.09.05.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:03:38 -0700 (PDT)
Message-ID: <e9573827-81b5-4c75-9d1a-d59a4809300c@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 14:03:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] remoteproc: qcom: pas: register TMD thermal
 cooling devices
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609-qmi-tmd-v3-3-291a2ff4c634@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zKYyqfaPb3fW7rMxQhbQw_w60jmOlazN
X-Authority-Analysis: v=2.4 cv=EI42FVZC c=1 sm=1 tr=0 ts=6a28011c cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=x89XBY5VHgNHtdzuPNgA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: zKYyqfaPb3fW7rMxQhbQw_w60jmOlazN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExNCBTYWx0ZWRfX4ApKk5hdopiz
 4KFptfm0GoUq2idMSct1GpURd43wa/JasA35nYNvbMWSMxYXeL0tWwi75rtIZP8BiHBApgd8evf
 WhMV/VmHYfiyAV0lr0raJ1vJthsVbtpdNT3xq/XzjZRw3lrYfULfEsPbDY2wKt7lCkhCz2d0N4e
 lA6Kmsz6JSn/73FRxtOV8xJHY7zj4jMvP5kGSaoFxqChtihnJ6LCDBrrQvtLgMGrtjUm92XjarP
 TaU4W5cIQOeykM5wk/Ko76CBy4cRctCD6KPoZqnwjGlxnwqx+UvGqwnHKlz2WOUu79aVqolVz6A
 +NASiSOmilumRm/RNB3xgXMHWbKeJTqAeYHNRuKSGG7OvYT4JSNucSGkV+LCC4GyOBREtXSc1+t
 OQdPA14Bas4NECJuhjVBJ8nfEGpaIdUi0qPnu8qlfCu7NLscQSKkSWxMRNmxHFWRZluLrzm6+kK
 NKs8bWd8n6G1swCscfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090114

On 6/9/26 12:22 PM, Gaurav Kohli wrote:
> Add support for Thermal Mitigation Devices (TMDs) to enable
> thermal throttling of remote processors through QMI.
> 
> This enables the thermal framework to request mitigation when remote
> subsystems (modem, CDSP) contribute to thermal issues.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

There's no other signs of Daniel in this patch, please fix the
tags chain

[...]

> +static int qcom_pas_setup_tmd(struct qcom_pas *pas)
> +{
> +	struct device *dev = pas->dev;
> +	struct device_node *np = dev->of_node;
> +	const char **tmd_names;
> +	int num_tmds, ret, i;
> +
> +	if (!of_find_property(np, "tmd-names", NULL))

Let's use device_property_present() instead

> +		return 0;
> +
> +	/* Get the TMD names array */
> +	num_tmds = of_property_count_strings(np, "tmd-names");

Is this something we can stuff into platform_data for a given rproc on a
given SoC (for which we already store *some* data in the PAS driver)?

Konrad
