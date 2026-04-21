Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110793815F2
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753640; cv=none; b=gtSMPnwEhXG2wpvvamymTlmg/BjH12wJ55+3lx1O9QyUf+zuPdbZi6mjM7MmcuDYhNDoAD3Zij6OWFg3eYu6zy7eEBeIA4lZf6fUJBWf+wSl/rqZ6Uk47I+XS1HkXtOmL/czOGmBjfUM7NsUz46SIJ6/2XfN4zDmmAnRKwxAnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753640; c=relaxed/simple;
	bh=zr3UdyBhezaEsgw4sxH/uuLEZu8hBR4VSNyGP2cfU74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AejBjqch5gX1aAWZX9NW5rCLDb5KlXRgclCUomQ2bR7ucfqaXTVR3x6+GadwF53EaBn0GxRT6eamGtTKtdLKu1iJ7H9hXPMj1vEEc/IL4Zg5K2XbF2M47OULTCSaPT5lU/fMLqJjpxmPA2sadotNTzupMMz0T8Q/tzdvWEfAm2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdx19oz3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bVufKI0c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdx19oz3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bVufKI0c"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L1NuTQ2755689
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 06:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rTZNvPu3CkQLQA//20kmssBVoBiBFMz9wD0UA2Eo/Uo=; b=jdx19oz3Zazu+TzH
	GUvfOXzi6EQTs+/jBASRUde50QST4t/jRM7AP1oaOjVpyLztlz1Ullm/dj2e8NDn
	VLJNmOT/MCSVJkNID7dzNs27ShUAsDzqY95rdkLkdh3Q+DnRkt0Uwg+5+29NO42Q
	fRQpixKlru+7plEU7KybeKdeTEhGXUL4uCh5+EO0iXLe93WMNegPrL4VR7Wqn+7e
	uCOV5kW60/u/6BONNfLzM5J9X46cY4sUmlFyKxZNnDjVv8qzl3OglBvcUY4MiZSh
	BWy1gIuKEM2Ts+z2YQY2puETP59LE+GiUPTWC2X/6neSfGqVMmVOTvye1Vlm3UmD
	/prYjA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh7xm4m1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 06:40:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e5a336b44so38492521cf.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776753636; x=1777358436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rTZNvPu3CkQLQA//20kmssBVoBiBFMz9wD0UA2Eo/Uo=;
        b=bVufKI0cwhH2soue3Zv3tUwnkeOVNRFxZlVvnYzhtiMl5OesqDWJ1si0BzOdFP1P5j
         gSR6SoAlBRPOmZ2BUN5vJZnMQTJoU9omYo1OWze4ErOxhkg/Io4LIW1HaCXqSjwj0QVb
         FtvE7y6y386RdIQQzcDvS1f3wymEd5cC3n3/Gak28UQdkE/N12UzRBIH0upzTxOm9MiT
         utQkYYXVRJhwMlJkBMVVsAcO0aowbIIeQDnpjFcbI3+L9QcavXXCrv88qxlORwAv+cHV
         wpsQn7bo9Ci52WwJAMeWqJsue2p6TmtBVMefzAFBWOnk0IH4o85lVBaSt4vqdh6tLw6W
         DeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776753636; x=1777358436;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTZNvPu3CkQLQA//20kmssBVoBiBFMz9wD0UA2Eo/Uo=;
        b=MdRpQwil6GIbn3dcGGqh1mX9DrHpE3rbhLCcl9YZT3dSskUgvA7B7KyEVVq49y1JQY
         KR1hgn3zThFhbOOKt8xe11v52eTbrQAplcQ1Fz/4fluHENcaajo4qGhRBWmlCUjXS2ol
         DEvIyDm4n/rqBKi6Ogn6FCJp2LasLl/+Fldnh8PZQGsvhy+alvdxQ9cWaQZmB/41qsZr
         bhJsjGjCJjTy21yIuEeVAtqSwA6GObC2MMlS0GTzFrKLC+77SyoknKbL49wr4WVQLvAI
         dk4OJJcNT2wBWRQGbqDd8FjweA7F19dGRiVN2cBi/K3O6HnWKwtquE1h/E8RTCb9du9D
         pUmg==
X-Forwarded-Encrypted: i=1; AFNElJ//uDbg9VVaqXODpwZG7RL0f1hD5B3VJtRIgbTW2sq375qvNYvqKlR9Af/y3YdZk7ra2imDpjWWGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cQdXi69uE8tTkkvhj3F6TvnmTuBkVOGdv8VHlaEhAJ+lF8Vv
	lsU+8RhjDv/bpNMYSFaz17VEQZiM+gQIvXNejEDRNXRkOT5fNFbuoepEl4LEs/VRaw57nBPGUCH
	c+vrhpE98Zw9sGBSuZsALK6taGuGYZRMFsK1f6M7NG5+Nbwf2sNqYP0gdgpG6Jw==
X-Gm-Gg: AeBDiesjXzqJHEFrtHMv7/HOXP7/OGXoSC1u5/Xxi5EqRE/v3dZG54GmlX7+br2MEA1
	njqV5Nvd1NTXhMFX9NbdVVE9hODadRGYjshJt8yZIpr/vfPyBa381xmw7K1LuccsCOsT/p02C9H
	DvMeQbESajEjqpohUCtYhKcbJdPN0gOC/HKXouRtgufs/8z9Ubslg5rJySQ19/2Ht4V/Utwn4je
	bQO6vZjhL3qmOzxDG9hCd22g1rdU2vVsXoMD1LbPm4Mux3bvLD+761PTf7sKHvq0dYVmKWOSSvJ
	/dfu8j8xI/P/nlPklcsaDc3YOGV4S1Ai2iXkhFD7XFSeaICsE6dfljEjwOvmWNqkla6+UbIqMHz
	3kGLU+ltcHNX5aqU3gQguCLaLnHZTS61IhutgfBSKJKEyEVs1WOUH7H97koY=
X-Received: by 2002:ac8:5a0f:0:b0:50d:a8f5:fa94 with SMTP id d75a77b69052e-50e36738adfmr216375661cf.21.1776753636419;
        Mon, 20 Apr 2026 23:40:36 -0700 (PDT)
X-Received: by 2002:ac8:5a0f:0:b0:50d:a8f5:fa94 with SMTP id d75a77b69052e-50e36738adfmr216375431cf.21.1776753636015;
        Mon, 20 Apr 2026 23:40:36 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e591cesm46786288f8f.36.2026.04.20.23.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 23:40:35 -0700 (PDT)
Message-ID: <3539dd7d-9f02-4a98-acee-7bcf45a837ba@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 08:40:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: thermal: idle: Complete the example code
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>, devicetree@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20260407053957.10508-2-krzysztof.kozlowski@oss.qualcomm.com>
 <177559016610.3536304.190890909066170434.robh@kernel.org>
 <67d47859-6481-40ab-b2c6-6d2eaa000ba5@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTpLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+wsGXBBMB
 CgBBFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmkknB4CGwMFCRaWdJoFCwkIBwICIgIGFQoJ
 CAsCBBYCAwECHgcCF4AACgkQG5NDfTtBYpuCRw/+J19mfHuaPt205FXRSpogs/WWdheqNZ2s
 i50LIK7OJmBQ8+17LTCOV8MYgFTDRdWdM5PF2OafmVd7CT/K4B3pPfacHATtOqQFHYeHrGPf
 2+4QxUyHIfx+Wp4GixnqpbXc76nTDv+rX8EbAB7e+9X35oKSJf/YhLFjGOD1Nl/s1WwHTJtQ
 a2XSXZ2T9HXa+nKMQfaiQI4WoFXjSt+tsAFXAuq1SLarpct4h52z4Zk//ET6Xs0zCWXm9HEz
 v4WR/Q7sycHeCGwm2p4thRak/B7yDPFOlZAQNdwBsnCkoFE1qLXI8ZgoWNd4TlcjG9UJSwru
 s1WTQVprOBYdxPkvUOlaXYjDo2QsSaMilJioyJkrniJnc7sdzcfkwfdWSnC+2DbHd4wxrRtW
 kajTc7OnJEiM78U3/GfvXgxCwYV297yClzkUIWqVpY2HYLBgkI89ntnN95ePyTnLSQ8WIZJk
 ug0/WZfTmCxX0SMxfCYt36QwlWsImHpArS6xjTvUwUNTUYN6XxYZuYBmJQF9eLERK2z3KUeY
 2Ku5ZTm5axvlraM0VhUn8yv7G5Pciv7oGXJxrA6k4P9CAvHYeJSTXYnrLr/Kabn+6rc0my/l
 RMq9GeEUL3LbIUadL78yAtpf7HpNavYkVureuFD8xK8HntEHySnf7s2L28+kDbnDi27WR5kn
 u/POwU0EVUNcNAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDy
 fv4dEKuCqeh0hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOG
 mLPRIBkXHqJYoHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6
 H79LIsiYqf92H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4ar
 gt4e+jum3NwtyupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8
 nO2N5OsFJOcd5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFF
 knCmLpowhct95ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz
 7fMkcaZU+ok/+HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgN
 yxBZepj41oVqFPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMi
 p+12jgw4mGjy5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYC
 GwwWIQSb0H4ODFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92
 Vcmzn/jaEBcqyT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbTh
 LsSN1AuyP8wFKChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH
 5lSCjhP4VXiGq5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpF
 c1D/9NV/zIWBG1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzeP
 t/SvC0RhQXNjXKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60
 RtThnhKc2kLIzd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7q
 VT41xdJ6KqQMNGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZ
 v+PKIVf+zFKuh0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1q
 wom6QbU06ltbvJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHp
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <67d47859-6481-40ab-b2c6-6d2eaa000ba5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA2NCBTYWx0ZWRfX1WK48pMBgFzD
 o+KFWO5GtpUSZnSuwrZt+XAx6Iwotrf/mU7ULnmPXWeeAK4jygAMOD4OB4BzUHzLaB3snMwB+/F
 l8E66tqtRyDj238Xu8/8aINeEvlwC1nRHV7RpqUcyBLHqTqxz+DUPtk5afeU463HO32RSK0eF58
 kG4VFU9kq5FnuFDYSHLRq8RnDWRKrvOxUIxc0ByqPeuhkwOSU6mAhownOolVDOPCsTwFZSGNQwD
 dKaLOIYdzu5vaXeDkZlcSVzKpn8bKmCNtG2Brx3w6IYG+56uIZZvscqPxyjGQ+oQI3buEyGhgV7
 sNCP37Mt0xaYr6eQMDxGG2ON/EDWbjD0pWaAwfzQ1soPLHzuGdnrhdnOjzjFCDeazLa8YLgfsY8
 stgtN+XJg7NBPThl9qBl+uJWJrrGMgWhkpco3zoc1vTyOW8+mEUEy8WBiJNOp63nsi8QlEfMB3A
 TfxjP+GKD5CF6loZnvQ==
X-Authority-Analysis: v=2.4 cv=BPmDalQG c=1 sm=1 tr=0 ts=69e71be5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2c6HdTRFV__AsmUE7IEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: rLSqtVsREciZMSnGLMR6DK230yE25RiB
X-Proofpoint-GUID: rLSqtVsREciZMSnGLMR6DK230yE25RiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210064

On 20/04/2026 20:06, Daniel Lezcano wrote:
> On 4/7/26 21:29, Rob Herring (Arm) wrote:
>>
>> On Tue, 07 Apr 2026 07:39:58 +0200, Krzysztof Kozlowski wrote:
>>> Thermal bindings expect the node name with all the zones to be named
>>> 'thermal-zones' (hyphen instead of underscore) and thermal zones to end
>>> with '-thermal'.  Also DTS coding style is not to use underscores for
>>> node names.  After using correct names, bindings point warnings for
>>> missing properties, so add also thermal-sensors.  Drop fake top
>>> compatible as it is not useful in this context.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> 1. Drop top level compatible and other properties
>>> 2. Add thermal-sensors
>>> 3. Rename also trips and cpu-thermal
>>> ---
>>>   .../bindings/thermal/thermal-idle.yaml         | 18 +++++++-----------
>>>   1 file changed, 7 insertions(+), 11 deletions(-)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Hi Krzysztof,
> 
> what about this error ?

It's real and it answers why fake model and compatible properties were
there in the first place. Please drop the patch from your queue, I will
prepare v3 at some point but needs a bit more time.

Best regards,
Krzysztof
