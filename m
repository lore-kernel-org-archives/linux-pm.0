Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FC339386
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924478; cv=none; b=V4b6ikp8dcntkbYdZPlJ2pIdpEUtQkqDGghXGYGTKzIUJBBHfcVsSys8wWixxA1JBJRB0Bsm4SpMnMr81hnQo1utLNHcbhxx/Wm09Ahfo1uC2OyiZCby3Qnu3mu2/opFaivQy6mWqTvLHiXVRIV4wSQtQ/+2OyklwnkEVgqIIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924478; c=relaxed/simple;
	bh=KOzSdMKac+N23ouYpqDlMH/iQxw2XM5R0pYY2apAVwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOIzwOQgFfE9+0OP4icdr3IOCFhOjHLmsLpg2kbNyFn0uqR/v+MVJeCYQj3EdvzHWAumbzKiAwdHkmzAp2TmX6ocxMIkxPt9RGlRA7jC9DcGRuR5sIHDUH6r99c8xAswSqLkQJ+TT4InVB8GB3IT6BFDTEUeEY/61pCxYmwb+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lA9WoRct; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BDn8dWgV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lA9WoRct";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BDn8dWgV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDSBBN2604523
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rBEnEB0C2+xZB32xn87dXB3ykS2FGO6jzaBxdrgN1Sc=; b=lA9WoRctMnJCh9kR
	vz93K85UuT/bOPWebJK08XgEDrVJjsDYwLXQhbpE8nHHNwxZtX6VdnZzZUR40KiN
	084nNwsAoLvTA6q8PSmANi2C+qId2k61R6ph7i4bFFAVkx1ZyR0HSB8YWYlLCCn7
	pyr2eXkwTqFaZLwS7dGfJT2N29ZqJ27cAr1pp4S4xUezGbGblUbRMRhyQOkMpzrV
	c5EbjKhp2T1CGJ3T2XoioEYOU8IaO8fvvySwy4vJ2lFvbujT1Bo+6qaBill3klPA
	I1kIo7RwKtFSAyUu5pAOgpkMDCfEBsLNNa6YJ8AEguOim6G2yb8wBICs63MUFS/w
	6hO4tA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb6h0179d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:41:16 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c66ec39d8cso17164e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787924476; x=1788529276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBEnEB0C2+xZB32xn87dXB3ykS2FGO6jzaBxdrgN1Sc=;
        b=BDn8dWgVGNQsb9uxJ6za3GvnK6nGf2kMoSk1GnUt3PROszzijwHmowmWSWmxYnPyZ0
         j6+i8tYtIcuzu7p7zk29BMZM1vkpcC2yyHFxONFD5qk0LdjXQQ5ZPQo7oIPAmqf7cYzQ
         7eRWFtZV1+H56BISsMp8FbCjB6qBPHqEguaJtqTQBieOsHNtsLzFpCcxtPN77XLoGxGm
         rtSpJ7oujkSEglPWo8Xyhnv5PAb6O6hJlkGtuUBYbCTYNCGg71dxsOyJq1VLLmpTJpOG
         tQs9VxiJ07AzvgCg0akxjZAvHtD6cJwY1DikEFIzVWLKBoLSzDXkupOdK/4sMcCdj+9J
         3Wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787924476; x=1788529276;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBEnEB0C2+xZB32xn87dXB3ykS2FGO6jzaBxdrgN1Sc=;
        b=kTwVgAsLE5zKR0anrZ3KeCDaULfpAODsCAxeTG+2CUm5SSQPEfimoQDZrTFPZefShC
         1Uh3hX4fMpBE1UIAQanVf+U34JbN0bBrqmsUBP0qVbA7F/ZzginQ/u96FEqTqyC0sHqZ
         Ir5bhFaW0trXcS8qdhiAcESTFjdbv74eYwCrTX8W7sHETTMzefdCZBvyws497RqrQuwD
         wK400eK/upnoOfEx/tQRMIhqVOE4Kk3sfamAJpWL6uEq+2XeNDTY0H6zYU3Pqa1lmRO5
         ECyPV49VmyVPFtgMPDSYzZrRnY6fHVMl/F+P5DY7CHsshTA2z1lzPZSXbovNUa6m9LUd
         1hlA==
X-Forwarded-Encrypted: i=1; AHgh+Row6M/abpP/8JLv3eXC6lJQ+XeH4dsKmUOLlLK9MP85bQYracTDFJHaLORDlIYMWQRcwLIPQYeZsQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mYrJzCLUM8W6HVM8nNQMaGPciLMoSEXYM31Gqr9NGRMJc2nEzr
	9Lr2ztDJcYxvDjbeqRMRGGcQMFG72T3mTgRFY++qxhb55g316sO2i0B2iV7LBnxgJn72on6YAh+
	fvzAXNWYFlK3dqReJdpBMbhHAId8D8LXLpXIa2eQahOEFtMAHbaKoZoxpsOAdcA==
X-Gm-Gg: AR+sD11BHKK/BMSGkOBVR7fy8/jbtrzu2h3jY6Ob+KV24grkAIprAxo0kU5vdhe5lCX
	rHEfB2MFhCUvRYuIPYNPfSoKOqJdsN7ogy3QGe7eGLmijmZaQwMR/v/+frp/B7hycj/3XB8lscR
	JmYrbkb7M1JOINzmCDXgslsQkS4t/3o5sdu1Iin5T1MAc/GsYJ0YtH4Dxhv5ZHFI+fJna2okjWI
	4CW2qpL/n1RmKSTWwRA3rns1zyFpdeO3AHx2sND4WLhIjv1dsSugzIK7TftcwvzLVu1Oxpbxpz4
	Wi2eAIpFClLeFPqGFv/HVJ8nDejzuavN7KHWpvRlR37x8lq1lKZGfiK/DUmOOupcTHHhfaM8AJI
	thZG7DHrtGKpyCefYt2pJ6rQ=
X-Received: by 2002:ac5:c89a:0:b0:5bd:7446:e3ff with SMTP id 71dfb90a1353d-5c680ea208emr903900e0c.0.1787924475570;
        Fri, 28 Aug 2026 06:41:15 -0700 (PDT)
X-Received: by 2002:ac5:c89a:0:b0:5bd:7446:e3ff with SMTP id 71dfb90a1353d-5c680ea208emr903882e0c.0.1787924475167;
        Fri, 28 Aug 2026 06:41:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a30559cfccsm3004681fa.40.2026.08.28.06.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 06:41:14 -0700 (PDT)
Message-ID: <e4e3c02a-20dc-46f5-b27a-9fa2667ca999@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 15:41:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
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
 <ff0c8c22-bd37-451f-80bb-35389ba162c6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ff0c8c22-bd37-451f-80bb-35389ba162c6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RNrGd5j5gH_5lDgKPHqnzAK_1L_2Smu3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfX8gL9lIB40UAn
 igenv4preEJV183npjpObhhGm9Q22BzS8njQ28Fm2vbZcltb7gJshkwn4HWDf8i90U18Rp5wq0r
 wRgDD9pXnaWD6N6SgIEq7LxDErr60Bk=
X-Authority-Analysis: v=2.4 cv=KPpqylFo c=1 sm=1 tr=0 ts=6a918ffc cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=aKGLMg70GXf6WMUK1bUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: RNrGd5j5gH_5lDgKPHqnzAK_1L_2Smu3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfX2yKBK12mmDKL
 mwO5wxQF90eIsiQBaspnMDQeSxweuPQLepaawMpML7jn0QBMdErd2WQv//a4GTuw2LIRVmBnLAo
 WleenOFPmbKr1CKFe5QO6L0s30CcUDoMNNiGkIEeZ3wHwKfD2kyPN+7k7fDqMOjapoNWW/SrsvZ
 /JttONneV8ajrJ9KYGXyaZIE9hhHWZwO8x7Uy+jHDTVM+l7vzOw147xgJq33zcHmtNcFSYe2jlz
 O5unmseM1sFIfaPT6gxhJqjAJTQfkREYv4MDhh9TMPjg98Wv2Ss+hqTmeQ6stweor95erPM5wb5
 IAEEZ9Pe+jaHo3V5nf7jboq+eSadbXxJhdW1aUpTsH8ycvQVEHzpUMhgTswndZATWfQ6UJSeBEA
 NiZ1qjuTjjBj9o2pvK0hsY+iH5fh7mdGXbMqw5NSVxbioXs4bx/nx7lM3Xw3YefrjWuMbHV5d94
 QjcF7AciN+lLiAomKdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280118

On 8/25/26 2:25 PM, Gaurav Kohli wrote:
> 
> 
> On 8/24/2026 7:49 PM, Konrad Dybcio wrote:
>> On 8/9/26 2:29 PM, Gaurav Kohli wrote:
>>> Unlike the CPU, the CDSP does not throttle its speed automatically
>>> when it reaches high temperatures in monaco.
>>
>> [...]
>>
>>>           nsp-0-0-0-thermal {
>>> +            polling-delay-passive = <200>;
>>
>> ..and here it's 200 - I really think there should be a single value
>> that makes sense, this seems no less than random
> 
> Thanks for the review, Konrad.
> 
> All targets added in this series use polling-delay-passive = <200> except Lemans, where the DTS already has polling-delay-passive = <10>. This series only adds the cooling maps there.
> 
> As per internal profiling, 200 ms was chosen for remoteproc/QMI-based cooling. I can send a separate follow-up patch to normalize Lemans to 200 ms as well.

I'm fine with a profiled value that's different between platforms if
it's really beneficial, but it should be made explicit that it's
right. If you believe the current settings can be improved, I'm all
for it.

Konrad
