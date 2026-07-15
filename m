Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A42429028
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107712; cv=none; b=ejfYYNOk3RyUiAg0o5SPMFaufWOTwWjg7O0zkUQ6Cbz4WLPi6ceAegqeSuCuhUtlbvo6qT6zDx0gi7G7tYiKnFDyKb5eXXi8DOxGbJsm07N6q7eG/I7Q23ToN7GWJ6r9UmOxs/DPc9t1do5fdbtH7vJN01m7GWlFLH9tN8tAmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107712; c=relaxed/simple;
	bh=L6ej++8UpylgEjQY/DX/hMRSU46kfmdMNZsHvr8wlHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaGirEAZxfad5Z6foAG0Sc9nz1vbiAQDrUNDv48+P8zASJ6zcNrln2jUOLOGh7en1gaHdXgmcsYaXzlJRITkR3FZrL8th2zheGAul5VD6wxHj2tGAG6Nf7NlQmjqi1gQyGIlyHwFWcDZE+PrwrRe+Xv9wfAqINibjedqpuQ0OpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ls5F5+xQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j6IW4RFT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ls5F5+xQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j6IW4RFT"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F9RYU63144630
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 09:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AP8nMGePrwJBuZJet7pj5q90N1nit7OreF2IYhy7kTk=; b=ls5F5+xQYYJvWcQ/
	0O66Ivkk1FBj2m6Bh89lt9n5OGFuosp9buKJNfGsL2jBeu9+uARtOi5ugMKLqc/u
	G4yBvkrGJOWKuTLvgggwUYt1tnXJC68mqIfq0X6/z/J5CsfdS4R7Sy52RBzJRnrL
	iljUtzmTZJiayZdICLboolI+T7RmC9HUlnRkQxSJUQFzXDoHeZ+LTSL+fwj4PY9D
	28FwJkY/B3cjumHM5eXYNAzW2Y1Mo4rin9Ho4a2b4AmJ+P2dKvKhLm/UziFt/MC+
	rg3vmmK/sy6TVoyB5iEpRsRH5m+sg1rl41klNSNfwnRN24M0m/BYKb5zrupiqeWa
	9qYHLA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7ka805n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 09:28:27 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ebb599e528so11924036d6.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784107706; x=1784712506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AP8nMGePrwJBuZJet7pj5q90N1nit7OreF2IYhy7kTk=;
        b=j6IW4RFTgpet5kR4nSwyk32x+9oxcDk7D+t4dgUUHghl2XVA8iXhlCRuhyHywVb8TV
         jRvhlzij2ucIGiOrN7ePBg+ioMR8p3UTN/3jmk6hy8etierVJ9VCf+++crwZ3p0cCCE/
         Stqrau2VgJqXDILKbf6H8ixVF2g14MsCLUe/Qivvk7bQLhyJEHX25fBpuBP1fPgNMA4/
         4I4I63Y7VACpy9zWv6npRYssmBoRJFonInjoCf3+kOF3LjGpm2QcHfTD/YTIQBdtOXN6
         wO7nnDZVZ4y2MEFVWJn6zXodxWy0Qwng/kIk4e1/zQf2NCYQbjGfrGmXOmc0iFghruOU
         1TKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784107706; x=1784712506;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AP8nMGePrwJBuZJet7pj5q90N1nit7OreF2IYhy7kTk=;
        b=e4JrGAgw0QeaRX1BOkIOtOHlDfQfCXAhplVv3FbUdc/pkaY/6l+T299KhqsR76+wSx
         qEkhEqa/ZPlYGAJU/g9MYci4ZQCTOIU1x0q+UTm0NUKei9xFf6OteojlG8Gs6OQlRpK0
         17cAHCGEf08DZ9SJrSytPcMGMykNy4qFKmAmG7+oc5COafU0HaQ9n87LNbg+td8Ta3mD
         MYbNDzpZ3TTyrTF3iAh5QREe3BOPHZe1BF33Xeq4xdU2Wci2LRkxAENLtKtjrEKzjLLP
         iQRI3jenznoYuuMThxEmeme2tawDwpz1I+lUfyoQ2nKn/cFnoX1ALzsJXYm4JH1T0A5o
         A0CA==
X-Forwarded-Encrypted: i=1; AHgh+RqNAT8lSsdvAMynWjdAivpl14Igi7QVcF8CFguP5VTBfe5eMMR4P4pwxVST2BbmecJdENWEwjMkXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNNNS39WeObncVq0ltxKLJlnxKhUJfft1emDLlO2fawJ9QSUo
	FspiIUZm2WbrlhS4wcKr8amTj5t0d0nvgJs/QJp2L5fVE1RiybLowqaa8naxgdOj+P+OfrClX0N
	V0N67jOo9rtUukb/hGxeYLB9FAgX7GfJN90JFoOPuLmhKdDsCu8ldMZFOcrj/CA==
X-Gm-Gg: AfdE7clQmZcRqjAaTKd/44V8YVHCUJl5ng6114HZ59jY1WtMfKxrcWLYpRk/gVWqHlG
	HN+3fWcY3wHSpHwnrq6Qc07e2iOkyv4PsYn74iV/kd2PT283K/eLNV1TdviqRtBdztwlT40ur8s
	WRZNGIA+SES6ymxpoh/IaxDoazPTIbna3+pl3W7K6ShtMZpn6KHwget+ErSVvObETvI6Co9CH5H
	+ZXs9606cjJt16uj72TbyayIVHN582TtuHLlNYtNaauiqa7aQOWaR7IHrg2pUEts1yv4qph1RbW
	sOsMQ76GNZXqnx7/eUB6hK5BSVs8hk++pjpxMB7+bIc/iaqDfHjikHipzarzQ9RA+dLuTaImAvd
	66mEVABcRFI8i7k9UIgVIqhgI/wEqGcledRk=
X-Received: by 2002:ac8:5d05:0:b0:51c:1c73:51a6 with SMTP id d75a77b69052e-51cbf170c31mr134548031cf.5.1784107706441;
        Wed, 15 Jul 2026 02:28:26 -0700 (PDT)
X-Received: by 2002:ac8:5d05:0:b0:51c:1c73:51a6 with SMTP id d75a77b69052e-51cbf170c31mr134547881cf.5.1784107706012;
        Wed, 15 Jul 2026 02:28:26 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c165a9b7c73sm300603066b.9.2026.07.15.02.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:28:23 -0700 (PDT)
Message-ID: <3f5430ae-7c8b-445a-a980-22c8fa8122ff@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 11:28:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm2290: Hook up MPM
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
 <CGME20260709114143eucas1p18463122323bdeae8e63b1d13cd626b55@eucas1p1.samsung.com>
 <20231215-topic-mpm_dt-v1-3-c6636fc75ce3@linaro.org>
 <dadff7a9-bf04-49fb-8c55-5605e99be7fc@samsung.com>
 <CAPx+jO9d1qH12mxg-n1rkbp6Xd__sdrSMeoc7CPELE+jgxRYHA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAPx+jO9d1qH12mxg-n1rkbp6Xd__sdrSMeoc7CPELE+jgxRYHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMF1jVla c=1 sm=1 tr=0 ts=6a5752bb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=hD80L64hAAAA:8 a=KKAkSRfTAAAA:8 a=MDPXCrVRUyKAm27fIg4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nlxjM0HI8k90GFdqtWMp25QOvAA6kd43
X-Proofpoint-ORIG-GUID: nlxjM0HI8k90GFdqtWMp25QOvAA6kd43
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA5MSBTYWx0ZWRfX0T3qmt3Oc/a9
 sRzZPFmjHq4r9aL1/MX4IfOwVhfG1e+1HPWcVS+yO81gFlHy9XED98rbUxPLztOXpnXn0K3WQ7C
 Cwgn9RiTNQT1/awDy5khBr48pT4gFN4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA5MSBTYWx0ZWRfX6tfmkl8a0IXm
 3um4YZ26Z8OaoXETZxDDL8jk1pV+NkrjH2tahdhVyEbsPh+MkvwvMUUocw5cZxFUrDazA64ly5Q
 1DQm5/la1+EyjEkTcx1QmpNnW1ML+VZPoDo18SfWEM0x2JFh85c1rVMZ3IOyShTvnnK/cPAcKKU
 0uKXG4XD8nk5gGsxPUnX8DeuUUXsnqPuDSvMmp/EDPyG4DleEAsShvAoKeaiLy9gNRsJ6Tz47aS
 A+XWMfmmfN6x8zH5oVuEcr1itvcMzV83D2H0qLyKeEeKj/NJxgOV1utJEMpIv5aFWtDxO4GHQ4m
 JhI0dFoyUPWuV3wvRmiGUR93m5UxpgyFudjA1ZqKhazrHqRpsDGTYPsApcdJij9gqUmRI05vAjB
 ZJ2BOwIIRTlLsW09aq14bPH9LfghUvoFSK7BVJ7aN8BPS/zqz7eZ/mzS2g9W4hpU/AMQiCSsxT3
 RKXOzeEbrMrAgAKCt7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150091

On 7/14/26 3:04 PM, Ulf Hansson wrote:
> On Thu, Jul 9, 2026 at 1:41 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>>
>> On 15.12.2023 01:01, Konrad Dybcio wrote:
>>> Wire up MPM and the interrupts it provides.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 42 +++++++++++++++++++++++++++++------
>>>  1 file changed, 35 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>>> index ce04d0acdede..0911fb08ed63 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>>> @@ -199,6 +199,7 @@ CPU_PD3: power-domain-cpu3 {
>>>
>>>               CLUSTER_PD: power-domain-cpu-cluster {
>>>                       #power-domain-cells = <0>;
>>> +                     power-domains = <&mpm>;
>>>                       domain-idle-states = <&CLUSTER_SLEEP>;
>>>               };
>>>       };
>>
>>
>> This patch landed long time ago in mainline as commit e3f6a6994041
>> ("arm64: dts: qcom: qcm2290: Hook up MPM").
> 
> Without detailed HW expertise (still learning about the UnoQ), it
> looks to me that the HW may have been modelled upside down.
> 
> The power-domain-cpu-cluster should probably *not* be the consumer of
> the mpm, but rather the opposite. This is how qcom,rpmh-rsc works, for
> example.

I think that's right - we only need the "CPU_SS going off" notification

Konrad
