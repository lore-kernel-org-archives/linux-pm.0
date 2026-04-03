Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF0145B27
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176078; cv=none; b=sQxQKnH3oivYhmPKDzhjE8ag28fddIfoB1dHp7xhOruPBeDzIlKdjW9QfRSuXyug90wLfHemAHzba70JLqJiu46It+2ts9MDXW7kr0SXuAwPaiRgEgZtFnjf6f52DQ8MeCKbsAjFpYgixmviuROhRleBSIQq66rXdsda0Y/Nn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176078; c=relaxed/simple;
	bh=7F2z4J6Gw/70SHU3WEIe6h4koZ1DEImtf0HW5NnAVWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7JSsKQJCWiNuqDIGSDpMQykXGuZ+xtTSJYCIMG/5Nq2dNo5Qc9Yk4NY5qfER1nIxVW+ILZwXhqRlZu+goG73pelzDrisfM+a7MYWPS71Jqxihf56OZFFYqdl9I1hmujR9814IJgKvGp79nuEGgGGc9T3m8Ns3lHuevOavSEOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYnoXXrE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b1lsXau0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYnoXXrE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b1lsXau0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632KP9mP2707830
	for <linux-pm@vger.kernel.org>; Fri, 3 Apr 2026 00:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MuJNcdT01qfW/Ml6zHPw/vD12isOe1NzcSfGNdSoBIk=; b=TYnoXXrEXHmIQWrk
	bLhlXgtoaH2StElhA1GYKeGHhq4i8BtOlsiUed60QRIkjw/5eN7fEIe8wFuonZdC
	4JL/rwnwtiH2mL6KqSptLDZAGSZIUJD78NUnFHxd5hmdZPGyhracmOw+5HVMTJcs
	2qeoq6pN2c2gqHX45jwDdOW7Y3XE2DzPigZ3BRE3Ys9lfsMk3QeIB0pcq9Q0VdiE
	DJgwjgvad4yVqJ6igkFbiI403oEtYU2QDFf+M7gRkSx/eU7fBsseqKHli6BDRaMF
	abXS85LfhmCDxW35s+EUeXG+PCWzazE/8CBpbj0mmG6MtMkoHRJJTrnPPwLMKI0/
	YZsmyw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9yfjgh4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 00:27:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c7ec40f92so1800976b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 17:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775176074; x=1775780874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MuJNcdT01qfW/Ml6zHPw/vD12isOe1NzcSfGNdSoBIk=;
        b=b1lsXau0xmeSVkOepXNdfllAhpHXJa06gaGq4J+FUXUq8SKbEF8xUxWsgSdQNsripq
         qCOkDRkPz/f2BbaT2057eBlfqBhxH8qSHeLZgxJ/KfTuOSGsW3jcBkCxDw67oeoUr22R
         xJ90s1tDnWkYytjvbS3VdDhWMm6i9Vo/egE0z79DMP+iONhkhtueX0shJUigl4C/tEFK
         rMBvUrNp+3gw6lkG6cFrsqILo+FM8pGmPVbeWgwrqpPnO1nEB0hCfr+2eXv0IXkueo87
         bxA5aKLQBubgZbD5nwZYf4zBYCZeDnx2XBLVD7F6otgux7t+3JnfMUdmMT1/IKjd6Kn+
         XLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176074; x=1775780874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuJNcdT01qfW/Ml6zHPw/vD12isOe1NzcSfGNdSoBIk=;
        b=DbN7WBYc2SQCJwYwqt/IykCMw81FGuqnX4SZw6xggKsz8s8XkcYZHvFhcHpfSvHhpX
         mVot6vvWVnxAv7I6+yWLQRFeec/pr58Al1mDM3zOrpGUl4t1qZiG+twp9HDf0v0bklBL
         TNSCd3cErqwPAl0psdyPqdIZlTz29ytRzYIVqQrD7RtXZZshThEqVY8UrGyZKFWp2e9C
         K2txG07x/2Dup9gSafN9MFAHOHYQs5C/l9i2VUmbCfdtdvGmwMQ9nuVfGaw3GRUrjFVp
         svXsukrcnkL0uyNpkseTsR1ewJGTg4on40fhU5ki4W6qKbUCxPsm2K9Fvot2e0ozccBn
         V9uA==
X-Forwarded-Encrypted: i=1; AJvYcCWikBGH6J4QLUH4oPGMr8aK1CE2/YFYOYjf7hZHn5BIbxTyfTvmANduko2y9EV6un3KRcanPuhNjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+eivfzwH0ycgsRSLKBXX9ock1cN8X4MIIW499gqP2Qpd9P1bq
	FpZ0CQsoFmKzGIalo7nhsbxPLxzAXRQOVgThX2m4X2+Q1WSfl/hohonkJztiS4bFAWo3Tybk9c9
	nZtWPKBb/hgf2WPmkXIUxy2AdJyV2kOvvm8ziXFYAW937so9YNbYnSJa0dc456g==
X-Gm-Gg: ATEYQzxBmx8lOS3fkqCZYhJaK6xt1NjzkBdRje/jKp5L0YV5YYqsnLqhF9iDavneAG2
	Q9nocekQEV2mBGxqTlz0gLqwtE0yiH33nkp7ErGsfforrx4NQ6cByb+V05VD7ffuxZMplzP+/Rw
	UCBF0bqLLO9YOwoHGr0i/uJU70+AuCDAVNtM2apd6DZSojFTpLZ29/66nnRKuV1CC1V/XL6ASSC
	SDb4CwHrNHClosw/Du3e3ifcfXlQFSGmPA7KCw1M4k3T7y4TZ4RShPnmmFteHYXhOhsjy6C3yVt
	2VkDls723arYyFFwZmVmvfOLh/aDRdYrY4MWAPo2Ka/ELsu+3tqREdFWr70gKA2I/GNkfhHpsPd
	u8zCdlymqvTEtsGpZyiJanwy3CEOXwNWpFPdKeAp5uVrAYGp+ERcDORxsNaRIYuM4OQV73r/hUk
	C2TwBKnQ6OGjVSYQ==
X-Received: by 2002:a05:6a00:2d15:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-82d0da41a47mr1020288b3a.10.1775176074119;
        Thu, 02 Apr 2026 17:27:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d15:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-82d0da41a47mr1020262b3a.10.1775176073638;
        Thu, 02 Apr 2026 17:27:53 -0700 (PDT)
Received: from [10.133.33.59] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6c2b4sm4218146b3a.46.2026.04.02.17.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 17:27:52 -0700 (PDT)
Message-ID: <28e67364-4d77-4294-9528-171a9ec2826d@oss.qualcomm.com>
Date: Fri, 3 Apr 2026 08:27:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: power: qcom,rpmhpd: Add new power
 domains and new levels
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
 <20260401-haw-rpmhpd-v1-2-c830c79ed8f9@oss.qualcomm.com>
 <20260402-great-affable-panther-1a5ed7@quoll>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20260402-great-affable-panther-1a5ed7@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A9VSaKYS3QY14mWj_FcR5pHn6pVnxOhQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAwMiBTYWx0ZWRfX75GFcVe7nJ22
 8tN4lUFvtpt1GUFI1DHuSC23D4h2Qt+haaYCdcOk0hxF8SOuay4qjJuVQ8oqwdaCxrZ4JCivfJV
 wIog9h0T/GzWr5eF59gUoCwx9ASQtta3xEMcXhA3NVSFS1UkqvzY+Va0ZsWZMfixRW8bo2WnMok
 x7V523xGoUwHsVTfIZH3LxT5VUKf12mhVCxNFK5p1BK9yRgN5a/bvblqXfUAa6bqioy0sVw3Gq/
 LWnK9glw5jv5dL4n/wEF/b7IMwiH6CkxIxmSAwjXhDxWi31vXON77bEvGXmdgNNlVEQ4i5rZhLI
 wistTPyrCcO41cQqnzE86nS7g3zXI2CtT/HIwrJwrzCua00zFI+0NNWB8oaxqpXEbfDrSr5rd27
 2ygzaWja7lMlnh9YlPq2N/yuOLL9nmkPSXiXt5gTrEw9OIpNhmQuiBS0P0fnbO9tfadLsVFlN8g
 eoBFtZApCT3/c/3ii3Q==
X-Authority-Analysis: v=2.4 cv=OrpCCi/t c=1 sm=1 tr=0 ts=69cf098b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=6iJtGgWn3elk5yOieJoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: A9VSaKYS3QY14mWj_FcR5pHn6pVnxOhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030002


On 4/2/2026 4:34 PM, Krzysztof Kozlowski wrote:
> On Wed, Apr 01, 2026 at 02:15:30AM -0700, Fenglin Wu wrote:
>> Add definitions for the new power domains which present in Hawi SoC:
>>   - RPMHPD_DCX (Display Core X): supplies VDD_DISP for the display
>>     subsystem
>>   - RPMHPD_GBX (Graphics Box): supplies VDD_GFX_BX for the GPU/graphics
>>     subsystem
>>
>> Also, add constants for new power domain levels that supported in Hawi
>> SoC, including: LOW_SVS_D3_0, LOW_SVS_D1_0, LOW_SVS_D0_0, SVS_L2_0,
>> TURBO_L1_0/1/2, TURBO_L1_0/1/2.
>>
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> This belongs to the binding change. Unless you are not doing it for
> Hawi...

Sure, I will squash patch 1 and patch 2 and resend.

Thanks.

>
> Best regards,
> Krzysztof
>
