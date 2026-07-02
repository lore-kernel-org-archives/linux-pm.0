Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01A3C5DDE
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989757; cv=none; b=sCDPizibyRG08Fea/5p7u0Pd+UffhOZ/IqjzbX2SJxHefXQHmFwQjoHV6c3+JBfxhaJhyw2yasXSJEg8B64UJ2uz30/7L7mCunlregtrl5/yr0cyaZktvnl1D1mL17aRP+5A3jYnXTm6KyoE9LyjJMT+cF4GAoZrjz0Ghf9UC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989757; c=relaxed/simple;
	bh=/ZzlequwXhlS7LWvnF4LjPV63ziQ+cD3M2ZZ5OvxKnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AodtAM1T8B8OX2y3PjkoP1gwIw4pbN5JUJ9/EUBDWVXVFZo+8VbuaOJGI/XrvJzGSAcTnpaYPikio1Gd9SEHaKoIRafz9hcMBWv0wke4Kfz99zUOXrHd3agxUtgIYriDlZNy1T+elofYDI4e/eZ5srjZ+O+OZIkrkebD7Iw4idI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a2hGTebG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iYwAYDZ0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a2hGTebG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iYwAYDZ0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629KJ4k4115130
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 10:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y1ryAiwJl3UQzitsPwkR7CGd+DjhIbqH1QEDSsZ/xoQ=; b=a2hGTebGOPF34xxb
	UhjLMYhe7C++fX47vrTKWSBq+PICLiPz+P8pWN01oDjQM2YxFAtKldwza9BTz8mh
	CYtST+LaUsMAKCTZfdatkDlRKGNolCksgd3We0aKXId0NPoUxselRmnNgej0vlRS
	rLC6yo4Udy4RI0xcmwlqjCyRDNCvfAgvCWLOcdT8tjN3sHAf02YasApZ15j7K7AE
	6ql2Ub5/hm8yM5osiID1vNaTCrjBXBjbtgq4F2oMkxjuxD5AXR50SqCjwFrSBfTJ
	70fX0hS5JuTNk4rMBwo/RC51HZnkcAUaSQp9orNjSiX4nvjPdhv7ZVEooelTY3Ba
	bzHp+A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n940b80-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:55:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfa45b280so3369331cf.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989754; x=1783594554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1ryAiwJl3UQzitsPwkR7CGd+DjhIbqH1QEDSsZ/xoQ=;
        b=iYwAYDZ0Hnc2OWSmwmko/D345dKyhadKPMys3qyENSbdho0/zaNa0XEsXAVDT5GjLk
         +c6gV/rGlXAKjc0WKd6eZdKEXZ2YScE/J1JPtVA/v2f2FBLGz/P1QpkX1BJm6IxOxAXe
         3zyCW9s/c/9VYIFBbJa3qUoXKWBH8e6NZ3Q2ab73yLYeVVwl8Sc1kVkPTylP1WkSatGX
         2u8PkwSta7oEE+rZxY1eWeuuxDcALIHjPO0IsqaTMgWdgObLHrtzPo8VFxAX0Tx3ITFp
         yoBY2Lm2QyTDvubixdRx+MlMVcyomcy9PP30JRlAk01bj+o9D0XjABt4kOxF6yuCPWkp
         V0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989754; x=1783594554;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1ryAiwJl3UQzitsPwkR7CGd+DjhIbqH1QEDSsZ/xoQ=;
        b=jN2sVQEL5LyV6SnwaoZ9X336McY3t1sjwoaCAhV9xSYK3TguwGWsCwOqz/ndQhlJVg
         ENHoiQn8qKqVq0GX4JNwgztw0zICUjPtgJh6vsnc/fDB5okcCoKdYv4KBTrDsUVqmVtN
         yyDDZ+hx1qys76cv2ktTc6xJVuYXizkeWfIdy2PaS4AunzT34s0bp4KoFb0VimdntE4j
         4RJGJmWvyrwVLJyPX6RfQ+1b7I+bHRG/vCVZODVUkNzqM805YsSkwpgNlOS/SQYAyxFk
         fWW3A8iuKH1uNT/nWGuekx6BxRsOwcgpM7J8c/dJpzWjApMXQAiyKJJ2FiQS/Ijdfmbl
         AUqA==
X-Forwarded-Encrypted: i=1; AFNElJ/4DB+Wb8eTfKKz754e57N0mT/oboov44LIokbHWJkM533PZdn5TkB8P7eY9BuLMkNF1Fvij+S7sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjj/qyJeKt+hrFYuSg+lnsxhU5d2F3mOK+HLp+MCR+LPyoLvrt
	Lr8vjvI2OxALpZECWCCEoOHC17q6QJ+J2+K+tDTh9pR4Ky/MEd5tsg7ZvGf1Sv2HMrkzaPH9m11
	KUcGZLsWxL/+3PDzZ6TeDw/Qj+mTpFj9SBPE7f8AQhbA2Zcz8ttsx/uyFd0j1zA==
X-Gm-Gg: AfdE7cmbaBylHhQwc6EIcoyrnSjj+S1lDgqexfJ+KK7G5WrKyu6W/5OoCQ8mcRzyOrG
	jLEcUzoYWJtsp8wuEM9sAdaaUnNs2kLIiW3p0AHtLOMDwkMcE2n+WdI4ZIuSkdjEZ/lxcYoYAZt
	uGOVqrI321tBmfN8ZX1yeo8XKNxs0xSs9/IIbXWCzCqBerQGtt9766yf0NFNWEDyQlS3FKdyQT5
	UqqC8yrOGCPf3crcyT4MiM3XTd0fxoKq2Z8PTc7KzpWfKCsb5d+9lrCWODxonz7CGiQr1Y8Kfeo
	uLzEyVNpjKGvvylbmH3wFAKEwgjjbhM5GEU+D+fUijSWJzlB1lGPQPa7fFkZAk/9MMWpDdJ1rUw
	ow6rk+cZqEeEt7QBz2i0EmLeho/vVayrtpJs=
X-Received: by 2002:a05:622a:14d1:b0:51c:223:3c57 with SMTP id d75a77b69052e-51c26b41df6mr43962621cf.10.1782989754162;
        Thu, 02 Jul 2026 03:55:54 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:51c:223:3c57 with SMTP id d75a77b69052e-51c26b41df6mr43962511cf.10.1782989753769;
        Thu, 02 Jul 2026 03:55:53 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad118f43sm788110a12.25.2026.07.02.03.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:55:52 -0700 (PDT)
Message-ID: <9c1aab59-14b2-4811-b778-8e96645bd65b@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:55:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Anurag Pateriya <apateriy@qti.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfX8cI1+8zg6aE4
 qiw6P7guR7EnObTUV9iaskXNqb6hH+lEqBTMMUAW+oMp71qsF/04LzjHju+re+9VpmY/2guFCcG
 qJXaEpBQt+EywzSHfFKcpqOEvgdYtjIktyR8XOtW51qyJ1+ARqM+4uJUj1mE7FzSNtD49zayNSK
 kgBJSZr8/KiF8wNoXzQnJIkMndd2Dj60ikkLuoL7ajJiXLGQ+k1Ofxy9Kr2xfVOy4jfTWw7GwLR
 TmZHkWvKsfcjbgLBwafItCWI0YFiW4ytJjYnVdwj5b42lZOvVALfuuwtez34k7Dg2YK7y3Q8D8J
 adFpa1i8QaKVIvJVN9Io5bNN4oc63zylpgXJPeOXqXefi4rarkUwTMIJ2Qi0XH21/syQlCKV9Jr
 PciqLNA4C/2XkQZycPsCwXC7kJasSTJX1UyZlRYKB9o5+kn4StqS8UX4qOkI6E+EpCc2b5zC/X2
 zURfexsMrP6MdDyy7gg==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a4643bb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=t9bxL2sBmI2IUrh-d9IA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: JSCrEIKemb8ed9SKIrh-gKlXCpq1xeCz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfX/2YDqVRdMt5Z
 EUM4nMixXcn8K7XQSnl/qLDS3ZdoLML7Luli5BDwZi1QAkJFVmk6cfdy2MRKRgOb7nmy7weadlq
 7w6VdM8+sv0ZtQB6QTL1v9MuVdZZ2yk=
X-Proofpoint-GUID: JSCrEIKemb8ed9SKIrh-gKlXCpq1xeCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020113

On 7/2/26 11:50 AM, Komal Bajaj wrote:
> Add gpio-reserved-ranges property to the tlmm node for all three
> Shikra EVK variants (CQM, CQS, IQS) to mark GPIOs used by the
> SoC internally and not available for general use.

These are generally added to prevent non-secure access upon TLMM
probe, i.e. the board won't boot if some of them are not protected.

I assume the proposed set contains both ones that are _absolutely
forbidden_ for Linux to touch, but also ones that are dedicated to
some specific purpose that Linux _shouldn't_ touch.

Please add comments, like in glymur-crd.dtsi:

        gpio-reserved-ranges = <4 4>, /* EC TZ Secure I3C */
                               <10 2>, /* OOB UART */
                               <44 4>; /* Security SPI (TPM) */

explaining what these pins are.

If any of them are boot-critical, squash this into the introductory
change

Konrad
