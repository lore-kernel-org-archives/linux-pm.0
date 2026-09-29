Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1A3914E2
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665319; cv=none; b=iQhbon+yo97BI9mpWbnGPvMUX9yKp8fE5V5BRt74ZILqCt5Ufd+PksXvmbG70q8G9VXpR42kh+Up/p20Cn35kaxzkQB9aV69o+4MGw9o3m3bg7aps69URm9oaYKpjrA+IXS6eDEboCYg/ANEPBYU0omTqIS7aKX4bv+vS3Katso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665319; c=relaxed/simple;
	bh=ug6onJikPynoPb1/wMm1p7ik/T9fv6Wx/1wYkf2VHzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBtT8WHfJnhIW2iMKq8SovFgHYCk4jRsVgVsk6EJDDR25Ec73NsYfHMttnVUTtwe7EX5kOzARQ0FfC8tHT+Qvs1YgXkE9RfPYndFwJNXfrd23Z0lIUHwjdom5DZ6k5/8oIv4N7hS24+cXvxzy0Rs4rCL3a7MRut7iECxTbBqSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=irY5eqh8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TiVKQ6Wl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="irY5eqh8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TiVKQ6Wl"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T6ojNx054070
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 07:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	svb+m8PamlTqsmvxTmKIajGp/QN753GcXO7TLKvbr4U=; b=irY5eqh8LFds3Wrn
	LL7dGqkqTzzsHl2HervKA/a8JLkEb0VPNMlnc7eUuIuk4w4O1Q1cezHOM3cyBZD1
	qyfkiJT05aunzs3UNulukqZfg7QYbjZJ9e0MdcWidmqrdWLbk7R+EWvLgOv3TLIY
	0ofVs73zKfZhLJjDQST2GqWiTP3g5SwO9K/v8dllOkgq6XP3BmjeEON+RN4az/Gn
	n9hfy9SZd2cQZ9950ILuVsWrpoAN2IyRYYjzp76vg3eHJZmXWMt9jGMGjo6jdNO+
	9TU/b+LW38jcOf8x8TAY2lpcK1xA/rgPDkVETvxrI2y76vgm70Y0cVuuO/jY/3Dl
	uBkZKQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0g1hj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 07:01:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a0f55a3941so2947272a91.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790665316; x=1791270116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svb+m8PamlTqsmvxTmKIajGp/QN753GcXO7TLKvbr4U=;
        b=TiVKQ6WlLm05Hr5WoUT4k/jfY5pi/dKNHoOlDG1Np6rsaVn+inmBvckCaVLUK7ka5E
         Bx5qVQA5IJ0rPMNE98/wBrdIib5JETVU3S//uJgWmkD8re7iSfFD7Q9zLS+zr61TBhED
         PgUM7zKi3mYPcVDyxcl+qlMwfjONbuS5TTjmWkG28jhdNf/uEcMDX+Zz4dfpfgTqfAQw
         4Yq28uG0eaDT42iTDFOVG8gSTZqFmIwwjdV098W15GCE2ytgi82CWZ4la8H5BHxOHVYt
         gtfbR6e8rcFebMgCOfdouVp7Cgd56SiQqrN9DkuPx6jxbJiKAxOvl1nmLNjL7rAX11d7
         LBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665316; x=1791270116;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=svb+m8PamlTqsmvxTmKIajGp/QN753GcXO7TLKvbr4U=;
        b=QMiR0L144CGSVkYtLEk/B+OZuFQj1QHSw6rbEL2YoLyLfHe/L3ibB79QS0QvBfgV9o
         AxyekRTt87hIV3Dy5Ct0BcdBXnaP20aNnNsueIUA+CKAHOq8R9fXp5VFQq7GaT5x2cuH
         B8DDw+iR7pa3dhJd6sQnFRkfMXc4S9xm+WcDTKhE6oaSl6Vw8FV1eowFa3UOYGpvFuN4
         d9ukaiifDepgaAqLq9X6QiEV34+c6SsMMtK6XHWqLBdhkKoCeKp0stJ49Xt133YCeRPo
         aY2ctDOKgjAfTAHqmdVt9qyVqCpJlXF1Z5935pQlK2MKN+UwNnVbBCuIzlHB/xt2iy5U
         dmUw==
X-Forwarded-Encrypted: i=1; AKwUvBzglxxrFQxigvDAjr32zV8P8uLj9YXkyI1091+Y4lTYAvU9YEKlSZhjEjnIpdaHx+hGNx6UNZzZOw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJillUwpU3/RIwbzz//HfQvBVrk89QZFz7PT5ICsGfoCDhAM0SV
	0JetDyecoQkiLWRhVvj2Hotahf2yY1ObYL3g4VdY8SSveTigIPBKj96bJfAzR5ZfqQ7usNIFANh
	DGjJqo7L8ITFcj9R+QQEbFhK7z16UXddjv9guyEuW07hwo4ORTJEGC/xgjDRh1Q==
X-Gm-Gg: AYBFou14YuaTp7FAitPm+bUt2tk56dP++EXNWSufdEG1tDmG0XmZsZLfutk68pubA9F
	yIyW7XIg9pm7W34uTdPbTlI425QoptZizF0jtUuXE8DEWPSM4WIswifdJ0G54Y+xCrxe6DeDQ2g
	NjRYiR1seu3UPqQtnzXpAyaL/IkqKKl63k4QFlSdqSt3QmNczCNqUTOIBoNH+y/ozqWvfDwXZqb
	CFseFOoIA4whfdZ6RD9pxCX65KELakyW70MXxSR0YG/LAAEpY/awMYWQLal8phhMDXDW2orNEXK
	f7vhxn4RI/vjCZh01jyiv1kSMX6x8FXDU/RsFoWd7J7vLQ7fpA/fGEGG0MS/HvxH2+imxK/OjgJ
	cAeWq6NjKeA/VZLDg7wpfEEOKql5TyA+o03uE6SXjjim53CFgGSLNHjhTKNU9B2Al7psLhiS7AF
	ZPWCv2YOd0DxHzho5T2kr9
X-Received: by 2002:a17:90b:53c3:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3a09896a5a5mr13031251a91.47.1790665315756;
        Tue, 29 Sep 2026 00:01:55 -0700 (PDT)
X-Received: by 2002:a17:90b:53c3:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3a09896a5a5mr13031218a91.47.1790665315274;
        Tue, 29 Sep 2026 00:01:55 -0700 (PDT)
Received: from [10.79.116.189] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497d9b117sm3763219a91.3.2026.09.29.00.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:01:54 -0700 (PDT)
Message-ID: <c29c1bd6-77b1-49e5-94b4-d8ec14346ce8@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:31:46 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/15] ARM: dts: qcom: Add initial device tree for Kuno
 SoC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
 <20260827-kuno-soc-support-v5-15-6d47636a8f09@oss.qualcomm.com>
 <04faafd4-037d-40d2-a79d-6d128b194692@oss.qualcomm.com>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <04faafd4-037d-40d2-a79d-6d128b194692@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNyBTYWx0ZWRfXwtRTHCJU2Jsr
 CTXXsAU3nlob2l2F9R5hwqQOhW/jE6rC7mp3UhS2ZqXBvtxWi4t2ZGIdrK3xDGNcN6Hr9vkCTC0
 yHRWKQe4747T9awQj187hm9UmbwD+98=
X-Proofpoint-ORIG-GUID: LLTcoIUWAf3GKM_tiCI5U6dMm0Jv17e_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNyBTYWx0ZWRfXxR30KE2eftqs
 srNr6tdM2sO4y2E2PBkfNcNnLmRa8DzPzEun1MM5PAZH5QhaPT9FSH6ZdYV+6rIvi66D4QtJ9wV
 nMay7bAeCO0bziKQnlHhpXudswieS5+yMuX2BiSFIhqThJcvtputWQWjJIxUpt77Uw3e9jX+RTK
 81/zrnK+9/G92r4Ys2w3Ic3TeyoJrktQ30dPVIXq+0Ck+qe8CYCEqywU9g1sj1bAd35vInK/nvH
 xvPXy6HWoem85yt/ApKWw2Ab8VZuyyuF0gc4tpkXTbYWUBLcyqODnm9IqNdqXcJk8qsoHSQniUR
 VEtnjyq5CGK6nNhY7HbqrMMWy4XUU8/huC2D0rwtcUes6FVvv36I3rORTMX9inhOj9t0yh9uEZC
 GsDzmKi873kg9bbcYce9xcXcYzr1K2SgEG48AR1gUArGNAVcItN7Q20QHyciNiHsUEgAIPmpDwD
 PbFkQi6frdfBE+7M8wA==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abb6264 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PaPtSKYIirbzHVDMbN0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: LLTcoIUWAf3GKM_tiCI5U6dMm0Jv17e_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290027


On 9/3/2026 4:37 PM, Konrad Dybcio wrote:
> On 8/27/26 7:51 PM, Hardeep Sharma wrote:
>> Add SoC-level DTSI (qcom-kuno.dtsi) and IDP board DTS
>> (qcom-kuno-idp.dts) for the Qualcomm Kuno SoC.
>>
>> Peripherals included in this initial set:
>>    - Single Cortex-A7 CPU with PSCI idle states
>>    - RPMh RSC with clock controller, power domains, and BCM voter
>>    - GCC (Global Clock Controller)
>>    - TLMM pin controller (110 GPIOs)
>>    - Interconnect (aggre-noc, cnoc-main)
>>    - GENI UART console (QUP SE3)
>>    - SMEM, hardware spinlocks (TCSR mutex)
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> ---
> [...]
>
> GPT found the following:
>
>> +		tlmm: pinctrl@f000000 {
>> +			compatible = "qcom,kuno-tlmm";
>> +			reg = <0x0f000000 0x400000>;
>> +			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			gpio-ranges = <&tlmm 0 0 110>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
> This needs wakeup-parent = <&pdc>;
>
> Konrad

Thanks Konrad for review.

fixed in v6 :
https://lore.kernel.org/all/20260929-kuno-soc-support-v6-1-a16afafbcbc7@oss.qualcomm.com/

Best Wishes

Hardeep Sharma

