Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB9402442
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660717; cv=none; b=e2vy3wT2ZIyQNiuyO1kv399ge+C6l4pkRq1XKriOtRxk2pIImOlt35ixwIdfWKoFiFT88kqxg29utZi9MjHGy/UozaNe6+hOhL9WSNROvBmkuqubYueKudwl7Rs/FamaoqltLY7wD7g37vDUUVLz3jFuooaEz3laMl3a1mssRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660717; c=relaxed/simple;
	bh=JpvP2FsKNOLwyzEV35Oy7RuDzh4oUbBOacuQEwMmnbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oq7k7vlyhteoDrWJxVN7C2dkMVU0qpf+BotG1FMZJtSumcMEjoKzkOF3xPi1WvSymcU3uUa/xUYH8bCMkLsDpGj11rBX0OdPrBsQd9zfgXOvDP3iIk/TLViAsFdYq9b7XSZuT8slGb9bLZEfMm11cMR7mATyAaD3Dw/ZiaJYI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JKGA+KsV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bDO76iKi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JKGA+KsV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bDO76iKi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAuu062320729
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxvYHaduN6TNCEf+tZMW4tMw4ZUU9VGjbq8UEfNnSPw=; b=JKGA+KsVLsBLyuvw
	xVq7fI4ge6xMju05qBRPExADjgpuVwDLbXTXFPEtaYaajwe6c1ZHgkhSFeJaMNY9
	Ju052pqAkgFZ31gdzFjlFfjgNBXHL8OYV/r765siaLeUnLE4JPk23+/ARmDYMa9x
	XyUWZFzt2CJHoV6EvjW4D4L9RREnzTHnLQmAdnRCXSEJpwZ7iISQPEqs+AlWZLpJ
	oc6XP+uHUCgngzpLKqzKmwzAXzqnc5IOzheGpsSddWKZor0+TEWc/5bGv0GDn1EH
	YF/JPAlC6My1LxuyAExsenqNkDwUTFvjOTbC6JcvBEX9fCikEyFKGeT4HT/uXnT6
	yptwJQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g92jqt3p6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:25:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa4e4684bso56096405ad.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787660714; x=1788265514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxvYHaduN6TNCEf+tZMW4tMw4ZUU9VGjbq8UEfNnSPw=;
        b=bDO76iKioX3lqGxCWSUCWSszaVJYfScGH8eO6GwdL7dL0+cSTRcdeT5FySRYEd8pIr
         JGIst0FsyujKMw8VXcqX8e8iIpHJVEaHAI52R2Mcws+2JPM5PWlrPGMwRO76CJ26aYW8
         KptNwWPnETmhFdCUEC7eCtq+DxnSr7csN1kZsYaFQf+NjcWu7WvMF8hIBOppaVTkdT5O
         7oz4Zrhongh0/MLbzQlMuOfUky/oEKDhg8JT8avbZqhhtht0k4pBiO+D/7yeIWPd+oW4
         CnMyyYRqxMMMNYLf886TixjdWzQ29xgFgrw3dPNlhHiU+5JuF+BDVTnO+8MJJ8sK9jBK
         4Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660714; x=1788265514;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxvYHaduN6TNCEf+tZMW4tMw4ZUU9VGjbq8UEfNnSPw=;
        b=OjF7XNhIBEcwIF+naEzbeCQoQxLV6oMa74YEUofUAZo29dtJENhmHXV+oL1Tz87cTY
         n5IroCJ+ltQu4HdmJx1W00nBICe4dFK0sUhf6MBo4gp2BNp/PIBaQ1Xq4nvpMLIjRRXM
         c4bwFKh6Ix9043f/w6FosWBqtuNQJQGBBbGQaCFjBujrreu2lqQ2AFO4DAKkjmCETt7g
         YDbMi1NEFIW1/lreIvlqYi1F+jG5d1p8X+cEqxGl/QqK6Oq5v3oP6HQ6+zWUqSyHlYQL
         6pkFPVM8y1lW9KQDqZ5eDh896bT/7RA+y6rKlu3GT4hNJIrKt9wEaNT10+Ep32PwHIey
         tAkg==
X-Forwarded-Encrypted: i=1; AHgh+RoQQlp/wLlypC1k8iDfdbFdtYEc+P2NG9AsY1/DXmkOJjhgGFkZAjDeTH57dkjI8bYI8/M4p5cOAA==@vger.kernel.org
X-Gm-Message-State: AFuF++krk/Z9flg8bTgMjwmjPsEaMIrSkNAnk8zfcJGsCS9M8pAKTfFG
	pbLKDu0KvjmPmaJnmBFGP7PrqWYMnXT55LANIrxV/92Rq8lC/BLgF82a+Q14CbRqDQ6VO1Vakxf
	WUj2YcX84NVw6rUoIUlr5PEdb5RDick2Rgjz672Xo4UrlyMgmOkA5zpJcJnB53g==
X-Gm-Gg: AR+sD13n39pKhTB9s1y+CDYSK/8ODsFybElBmn13BrXOjo11o4s/FtDLowmK65rYORq
	SgjZuFYRPdfVtUXWEsugB+tNmL5Jx6lMQFfCin0pJO3L3NmChn4HmJNekJ8cXaNTo+f4hOOE3ZA
	4y56ttTjVpC5sAjY1YTurcEYS5THSjXVotVKpGI0pZPN9B69uwIc75IawHCbqfL2AMEIPp5iilr
	JUeZ7nLx2UoNmVrY87xostzXG9J97bXQdvapAk6HRGHUOlrg5JNfNxjq0/JajvygbgXIBrWhg2V
	y01NiLsAGkwwtZsRJIPxPiUq8KPreZLEv6S+72P7MqBojvICGotcedVzn1iDeS3F7RmN7tALmJ0
	uELu0cA1kfMRrZwxX+6ST1uvuHWm2n1Q=
X-Received: by 2002:a17:902:ce8c:b0:2d6:2901:6265 with SMTP id d9443c01a7336-2d6dcaddacfmr124084715ad.2.1787660714327;
        Tue, 25 Aug 2026 05:25:14 -0700 (PDT)
X-Received: by 2002:a17:902:ce8c:b0:2d6:2901:6265 with SMTP id d9443c01a7336-2d6dcaddacfmr124083815ad.2.1787660713917;
        Tue, 25 Aug 2026 05:25:13 -0700 (PDT)
Received: from [192.168.1.16] ([106.222.229.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768ba291sm27562625ad.64.2026.08.25.05.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:25:13 -0700 (PDT)
Message-ID: <ff0c8c22-bd37-451f-80bb-35389ba162c6@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 17:55:05 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
 <01cd0d90-2908-42cb-9ae8-29828d4c03a0@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <01cd0d90-2908-42cb-9ae8-29828d4c03a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CNJNpeo6UxXDPewqTKrvE1R2ZeMLq-7X
X-Proofpoint-ORIG-GUID: CNJNpeo6UxXDPewqTKrvE1R2ZeMLq-7X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEwNSBTYWx0ZWRfXzJ3n6VIRF7uf
 Cw+Co5xXYyYknRlJaDJo6pj2bhHyi85rvxuSD4h1EBF1Od9ICxSTr22UjRaOLh637U0NAWzDFNi
 8VmqG2iaRo2NWr4++TpYKU0kPh1kvtcelXxJ+225iR2mnlHEXPJ1xxvWKOFJSRl2/bqSCcSdGjP
 ZyJOsaFwBNJovMj6HYhXTyt64BpbiJx/vLm0we1QxnRre1t7KFoe9igduQ1s/iAf1tn1fFK8ajQ
 eDDqC6pFe6MJnIFMHSSyNLXLHYCyj0fFfbGquMejdq1QaY1l7g5ZRCPFXMqrEYCEAAWqR5LRFui
 cL44791uB3zwqbt83Csu5CGMUKOjswcBv75vflTSdNuhkDIKn3+ul2+881CqbyKi+nQsJ+UXxPm
 /k9frulrroaRfdQ30WL54/6ZYMoxFvEXXZvS1OtdTkMFyQym4URjSeKCQ5yjBCCS68d0llCtG0l
 iu4DWpNxTpGVB2bz1fQ==
X-Authority-Analysis: v=2.4 cv=JJULdcKb c=1 sm=1 tr=0 ts=6a8d89ab cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=x3UvaR+l8cLCJ1uKBUlNag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=ctB7yVnqyLGUopViubUA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEwNSBTYWx0ZWRfXzRw0zBYQdjoe
 mwPPZntFU9OduBj+pwmV3wmBDFfGSOAreJKWUhMHaUm9pjilhtaTfTbCGISXrKr7nLpbv7BM/V8
 CSEWaVEZlIwUhHbhlyOnu+rmMfPTrBs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250105



On 8/24/2026 7:49 PM, Konrad Dybcio wrote:
> On 8/9/26 2:29 PM, Gaurav Kohli wrote:
>> Unlike the CPU, the CDSP does not throttle its speed automatically
>> when it reaches high temperatures in monaco.
> 
> [...]
> 
>>   		nsp-0-0-0-thermal {
>> +			polling-delay-passive = <200>;
> 
> ..and here it's 200 - I really think there should be a single value
> that makes sense, this seems no less than random

Thanks for the review, Konrad.

All targets added in this series use polling-delay-passive = <200> 
except Lemans, where the DTS already has polling-delay-passive = <10>. 
This series only adds the cooling maps there.

As per internal profiling, 200 ms was chosen for remoteproc/QMI-based 
cooling. I can send a separate follow-up patch to normalize Lemans to 
200 ms as well.

> 
> Konrad

