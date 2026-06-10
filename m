Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679740489A
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092961; cv=none; b=HAyed8FGJImq/Yu7eGWNXF+PWJvnntOUH5Wx5Dtn+ftOY9lsoBkc0zMZ6LsYD/ES3Y5hzhGPRcfVe15eZscvgQGd1HTwGqaSAHntgoz+rUuJaPBr0ygmTuE8s/l/bRecj4CnHRojvDHq+UfLer2HeGPKtYmcXVod1rAvbgya+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092961; c=relaxed/simple;
	bh=6N+clulkPZ4b+YW1h7cMHtrZN8QWlpzXaaiZ3uRZxwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XELSIF2fzWl3fWluY5qzMR+6ebyC1MLmAsrPbsTIM2hwHx1T0SKRhaDpXCxJRm9EnQBtcQ1vI++LieMiegpsYrWjus9h2OmzQ3DtY8XYcwaXzhz3r0vi4ZvWKE4kpJre8ZncTqmO/n3HYeRaT7olq2sr01A8kIwW10zlHcRZ4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dUWXN/28; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BVI2hfG1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dUWXN/28";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BVI2hfG1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ABNY4j1494361
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ol5IR1Aip1z35CTe1ZZdvuNeCl8yaycEOk4X8EMNnRs=; b=dUWXN/28H3Gtxug4
	ks41kiAke4JNBhKpMulTZDdrUnKYWHXkPzGTYn1fkasbP/PdAoYD5hX++Xc1kWwZ
	VMauhM3cYii9mZnp4PGhes7AfCoR8jGROnUt/GtpuDSsTm/eIMDDzLu5mtwrgVf3
	jPP+SCpIPoxKKLWeDucqIrr15Vn/9wVJo4VHekjxaYOMbZvJ+FSZc6dJPR9Dnhyv
	LlitetEZNfFG2feFczsldwHOu1lV/EHndPCsVzh8b+1oj6wIuqiMiD6EClifE7Xl
	SoSeMda94TdwCrgjgeuteZlc/LejPc07cqR9JY6GutmOO9K9zvOGCiAp5ivZlcqu
	em2RlA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq1tg1fk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:02:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso4502450b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781092958; x=1781697758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ol5IR1Aip1z35CTe1ZZdvuNeCl8yaycEOk4X8EMNnRs=;
        b=BVI2hfG1nOkhEPRVx/XK2gbeUTQD4AaSG4vYKqzqPQ7BY+I3ovlNwMwhRlxv4HBArX
         g8gF0BRENIkJptWWGnqPAwRfIhgt1LI7orioK+YP1dAv6gGhe466qyBQ/+R8apRV/aNh
         JVBZVcWAbRjbBaeIc8pAAZuBfRecpi9IufsQVA8JQMn/AxyZSmgT71K2mZOOILFv/q78
         oO/Nn+PHKuPs7BS/aATozu9eLTRsv6szwnxhTs6xAO41Bmz9/FTbl75Sdmz5QOOu9d1O
         WxSlnadDaEkl7qhEPEvYFjpHH2zYAd1B9AY7Ykwq4AW+K78XAKNbeMhFJaXkVcW+h/KP
         GywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092958; x=1781697758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol5IR1Aip1z35CTe1ZZdvuNeCl8yaycEOk4X8EMNnRs=;
        b=ZgLkdiwNYusn1Zzfb4RouSBZV1+4A+5KbWT2O6EPyXWFqC+KamjYae7kQFS5GI5cpR
         ZEd1uwpQKK+XdTICT+kcbLxnDXS/hM+9VSPrtPI4Idpfv/JR5VmkeLdgawr0YCtxw5Cu
         SJr1pYAViCwMGLelus5+BbyxrihKdyeGFJFzY9CcEWawvjEgY2OlWhmyrlJeQaXjewSy
         I1BmE92dINUqqjxWWLtjGmNt/YGuDrfN7xwvJZ7B946NEcpZCbxJUCCxzef7DHQOP40P
         EPC2VIlE8xCECPfWi6IfTSPM4SHt7lwnhc/i16mDuoIvEVuEKv47h12iCsQrOscRHLLd
         d4Fw==
X-Forwarded-Encrypted: i=1; AFNElJ+hqGPZVEmIf5g5sRWIsBDfTU9iwnslfDhe90dDb6FwezJDVo8T1vUwe7HF8xGxN+PZOYz2ZcBBbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygOmY8zl+/XS+rTCabRCIlyevL81LKGnTGhnikROmD90/HWM37
	vzI1yFWXTRI4i+2/lDL+nTZDIQKBepsH2OwgWXxRxTyZDtqgZ2iVJGEc3HBoty3dWLof9YYoO1R
	yr6G7HZUDCXg/e/MSGLGpnxpdJkuTEBIVu5dtm8kDsbKMlfqYzExDTGLp6SuOxA==
X-Gm-Gg: Acq92OE8oUBgnCywPNhTU2nYAyXYNT/SBeRXQ2CuYTo1VC4MYWoQIIyZbXrzkFnhCl5
	Ql3IPwnSj5jY3ibLSq7vSnBlt6AFWsrbtq+FJaoYJuU6L/pM/dfk+H5yRXQFTO0Lvuol1ffVdZl
	yhCYeyn/JqyMYTqR0ePfSusV7gzLbaNIB3TBPfWryzSo2Mr4UqDDqRGJwB3sdHqrdtYUrTxghyW
	t2xLFWDKfTwtOU3m6e3AYVZ7C7m0YqTJxZ8UtYb+LSXOHY/yBNdk6xpuQKo4W0rWQhvdUdItbz7
	kQN+999wPJrE8GjdRNVWzfS/B/HTrXm6vhHcsTYnEoN+hU/HZ+CH143EqmaOPFfIoqP7TZjN0VQ
	/Ym+yreUF2JEWZjFjs0mNFFjO5eeWlwn4ZsLWgKIFwhu1amUV/7I30A+3SRQr4DU=
X-Received: by 2002:a05:6a00:c91:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-842b0feb656mr25453845b3a.46.1781092956756;
        Wed, 10 Jun 2026 05:02:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:c91:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-842b0feb656mr25453772b3a.46.1781092956257;
        Wed, 10 Jun 2026 05:02:36 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221cc3dsm24523372b3a.1.2026.06.10.05.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 05:02:35 -0700 (PDT)
Message-ID: <0593ec29-b670-46e6-8eaf-a146e96a719f@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 17:32:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <ujf53zya6hes3hkddhsmgu4wyabodnyg3zdwarxmcsoy6p5h3c@ild34ppiyvre>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <ujf53zya6hes3hkddhsmgu4wyabodnyg3zdwarxmcsoy6p5h3c@ild34ppiyvre>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FPfMMMYIKh6916EQno7KV_qR-WycpSmN
X-Authority-Analysis: v=2.4 cv=dLmWXuZb c=1 sm=1 tr=0 ts=6a29525f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=AQWUehsJRALLLA6uX2EA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExNCBTYWx0ZWRfX1yPNkf56Mn5A
 Y85Y24/h15svMwA8FA5H+fdftnolxtiQJ1HIUoqZjkUb7nWjJBDCO0ONrZFCzrIqwJY9HwfrSek
 li5kTEtKxKQuMJCrePgfNa2vaVeajxwUk7D81OP8fqi6L78JUtCxhT79EnaiQO0k2vb1mc1zuaU
 FE8fo3glYfNDUdTTjSPQgA9eialYiR9J+xDxw8EdsLavk3EBH7CBnIc/x4vo09SfWQznkO/XM3g
 wFIIcBm/ozki3Emyd2PuQ/3fcBzlvlVWPx1hNoQSkG5zsoqusIfDeUukY8p1K/NYVC715iFAtkr
 8ljfNnB1q/gC0g6qBMVjgRLSvZ/eRAdT4qcOHEWGx3tEZia9fznigZp4unxLu1Qhmx2m1Aq/5c8
 125yBMPRdevhkQNANLJjIt9lRUdAu9pyclGMF7wTMRwUTUFp99JRFK3nIJhsmcGSs+6ZGmOqodH
 GzC1DgfqbGdgcLAG7TQ==
X-Proofpoint-ORIG-GUID: FPfMMMYIKh6916EQno7KV_qR-WycpSmN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100114



On 6/9/2026 4:17 PM, Dmitry Baryshkov wrote:
> On Tue, Jun 09, 2026 at 03:52:56PM +0530, Gaurav Kohli wrote:
>> Document Qualcomm PAS remoteproc thermal mitigation properties used for
>> QMI-based throttling.
>>
>> Add:
>> - #cooling-cells (2 or 3)
>> - tmd-names (thermal mitigation device names)
> 
> Describe _why_ you are performing these changes. For example. why do we
> need to handle two different cases for the #cooling-cells?
> 

Thanks Dmitry for review, Ack.

>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/remoteproc/qcom,pas-common.yaml    | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> index 4607b459131b..0d07a0750762 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> @@ -79,6 +79,20 @@ properties:
>>         channels and devices related to the ADSP.
>>       unevaluatedProperties: false
>>   
>> +  '#cooling-cells':
>> +    description:
>> +      Number of cooling cells; 2 for min/max cooling state and 3 when
>> +      selecting a thermal mitigation device index.
>> +    enum: [2, 3]
>> +
>> +  tmd-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description:
>> +      Names of the thermal mitigation devices available in remote processor
>> +      subsystem.
>> +    minItems: 1
>> +    maxItems: 5
> 
> Missing example with these properties.
> 

Thanks, will add example.

>> +
>>     glink-edge:
>>       $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
>>       description:
>>
>> -- 
>> 2.34.1
>>
> 

