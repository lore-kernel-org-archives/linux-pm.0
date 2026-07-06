Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545562EEE9C
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357706; cv=none; b=oN/ci3ULnREWXdb4ll7LV47UTsmMjmCanSXu4KRLwTl2SSU4KIate/Lz8Zxf0FD8gu9xqqOCH8v3LZrXNU6Gst39JQqo0g32ZS+N93ak0YZ0/FFkcHKfJ87YA1c4kqyw74FakOfw07xMUiqav5lC5QVBd3C28WcMw/CjmtrDdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357706; c=relaxed/simple;
	bh=IZGbYaxH8ggjxoIMYNl+yupFd97qlolubyfSMaIcNTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFpIgaDxijxKMc9nNoSMfmXPbKlB7Ms515k67L8FRtt7/irrUwEaqp9iFFa46TupNVyRVhuoki+rKfdQYnTCv1GMCReoaG6iS8e0fF8pZk+4rVhIK+DR4TGyQAkhj/PKnOyXLRG8kZviXNHU9tnW4AyT/toOqNoqRiNHkE2t2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFEjFBui; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h8vi2OnI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFEjFBui";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h8vi2OnI"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FEwbX825579
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 17:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7OEXeTG7Fk3+hIiVqx+oEcBHQzWnJhCqfnlrjuWJG/g=; b=DFEjFBuiaow3l3KQ
	48x9uLdVslT5J5BBQoMHLDn+doJBpQLrKQ3YPrHT99ZdJoiV0NbNKc0fO+cHToB7
	RZUYNlWA1W70yk5CxW0oye2NBslonJTYkTgxmfYsxONa1ro4847V0LDOETJABpZ0
	HrUNwjFAwFQh4VPntkV5ZLgsJMa9vc53RYoKfNsH+MTsUkLfLq61ylwmGM/7IXUB
	ZVUGRuu7A4VtbVn7D9na0NpNJaqvHlgsSV/tWXFhydCQedZ41IhXXVIQLEF5lzqD
	e+fSoZn5/Bx2af3pb/Kx3xpR8RdmagdBHoYhFjMoOwT8/c/X2AJZexg1Pih31lLR
	cdhQ9g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8ack3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 17:08:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e8004d60eso516646785a.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357703; x=1783962503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OEXeTG7Fk3+hIiVqx+oEcBHQzWnJhCqfnlrjuWJG/g=;
        b=h8vi2OnIVLbM43DUtawBCJDT/sDxZs/pR29oqlV+Xd39ADiXoKgFTQK5PEOlrO6yzU
         0xdI+tZwbYmAc+aoxNQ3WjOujZh3zMiu9E6qVjUW/fUOHtxRW18O2BEPyu4N3x4GC1gH
         VZyfIFZFb+Bhx0bbcbyQLy4WeiBpNClok4uZYEJe5DGyTHTSgViHO6QxFUiTRsFkIR1g
         Vmh24Xpn0DIPRKnPhHZyjdNbNUr8XUpFjQalXhu2vA1nGJbRN+tufY3K5hu2PVHWquis
         WxYbFEQQ7AlfWrnTLvvSCz8f8NWbIuK/Ub9rx0LMmpoADzMhGDEsCfG2gx6ypVVVr4Cc
         8Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357703; x=1783962503;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OEXeTG7Fk3+hIiVqx+oEcBHQzWnJhCqfnlrjuWJG/g=;
        b=OSSj4KaSfkO1crXAOMcRNCDOPwn7MU82+XdoXoErXS48MN3smzShaGIAXrZiN+lXK1
         89x/BZ+WCUsw2FepTyGj6hBP/26NaZu/LISEZPXIeOZQ4ZIg3nIAlqd+9+EOKaOGRT+n
         IGeeY06mbRQIDpotGF1PW9iSibOiYn8atP93MM/XTSM9jwflKmqyfw2PrPbVy6cD/oGF
         JmF4sfhAnOM08MdKrAf3mq8gKbVWqBsR5mvvWZ6RT6HeUCe25XAmI8k4fEaL/IZyJlov
         Azsk0ZBslmr0dX5qynU+S9Zns19xrZW4bS9TrT3Z7QHgTESzmyZvyy9UXsX6PwCYxS59
         3OUA==
X-Forwarded-Encrypted: i=1; AHgh+RrzPY4Nezz0CrBUikDvPgpIF/eNmi3uevTxxveLys3vOH4QwnZWdqBlRY7p+1WVLSujFLgx01tEkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYqCoLbzR2raUZmn41u6VOMhyOEnB4sxq30V8jimorUjYDMTt
	mDhyYM1vO9SRiNNXDtsz5I7JVwxdORg3XN1iUcxXTVRd2stzrROkSwWcVB+EYtPHZirlTkvd/vo
	GsQXh6J6pyE9lujPmpuxRc8vSllRC0lM3h0ahFhrkMuoQwkV4UvQrXAnxPxuh0w==
X-Gm-Gg: AfdE7cn3Vzy/ZkozcUE3F86vnBIebf5cnQnEuMc2ABSIl7t9Q2/xlMT4JK8sV4lBUrm
	IDlPKLZszgI+0WIftxXxBGZUfjGmV2VZ9ULpmtiP8oXX9ei19faiVJCJTnpcoYOMMCh+PsH6N+2
	iK6DROfy0GE+znwBctBYlghzbBG75fz8OqPBuM64603shKQpjqvnhThSQkQ3lQVXxU+CrUs1p1K
	6/cTGNiT4RrudXQvAdasJXWBxF1aZBh0y4L8mQ1kYSvnwxT2+WnRl7FzD1qE0d9fXYcQbLR11iR
	btGcFjPkhDE/DtfZgPXHSGSDusNAOGmAVfhDqVyUDF4XS4qgMCu2btlXG+6kPCXa87IWf2CJsqg
	7x36sBBbJzpfkeLXqnf/nh9a+t1b7oR6o3XYKHU9a5pEBngE1CY/UFTp2EprGAJ+R0ayT7l4QVQ
	==
X-Received: by 2002:a05:620a:2991:b0:912:1206:ddd1 with SMTP id af79cd13be357-92ebb52fb00mr210912385a.1.1783357703549;
        Mon, 06 Jul 2026 10:08:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:912:1206:ddd1 with SMTP id af79cd13be357-92ebb52fb00mr210907885a.1.1783357703111;
        Mon, 06 Jul 2026 10:08:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm686999515e9.7.2026.07.06.10.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 10:08:21 -0700 (PDT)
Message-ID: <d9c6ec58-930f-4834-ad3b-d9beb4e21f6a@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 19:08:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] remoteproc: qcom_q6v5_pas: enable QMI TMD
 cooling support
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-5-3882189c1f83@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-5-3882189c1f83@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MyBTYWx0ZWRfX7gr90knWKWxx
 Qx6AGNj/qw3rUCw8XCIUno9ttps9vb5ACOFjdWxzivDPg28YYMU/ZgqsfoFjRSfnIiCir4pyXh6
 EEsQISLykLb0CUSfkFaGyGurFFKoTO8=
X-Proofpoint-GUID: tkSJEU0Kuv57U5zG9-HcTcYHlJypP5Vn
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4be108 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=gAhwoHsd_6a96UM4EnwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: tkSJEU0Kuv57U5zG9-HcTcYHlJypP5Vn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MyBTYWx0ZWRfX4rCsKjGGvudJ
 XWofuxqvKUcXw/TsV6aQhgsMP9pDJhlnkteFU8gBVwTVssBddQw6My+Wq5zwc5TR8COR+/Y3ia8
 Ht3EHsnfgPObJcNTmdMq+SX9ddjZir6WYOZbWKRRc2Mpg1qun/k/3LwV5jHXghh+uHQdSfApO4+
 jgC+AiCf+SBTKQwdo4Zx+QIbX5gSJe2J4HxhBn/0+NlHtqbjH38bLKbUyaejLRabKzwXHM574vP
 4tClTR7Io7vBNTpXFMM2YiGXKJI8kfs0632eJas3UpsbVxXPF5XkGurSfYMwywUecue2zMfe4tn
 vpgqDjxJPewJsySfaWXlzzEB5SzzIIQayNSPL7JesF5YdEMi8caOyftrbGVJgRshnQ962Ata92O
 LcvN0Yv2ZG+Q/F4ttfBTu3fdiWjE6jphl9qVmGwL1k7+8vO28EGvR23R+qMHc6YaAYNBbPk2kfa
 ePIMwxypGUTKh9hs4Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060173

On 7/3/26 07:03, Gaurav Kohli wrote:
> Enable Thermal Mitigation Device (TMD) support for PAS-managed CDSP and
> modem remote processors on platforms that expose the QMI TMD service.
> 
> This adds per-platform TMD configuration in qcom_q6v5_pas for:
> - Hamoa (X1E80100) CDSP
> - Kodiak CDSP and modem
> - Lemans (SA8775P) CDSP
> - Talos CDSP
> - Monaco CDSP
> 
> For each remoteproc, the configured TMD QMI instance ID is used to bind to
> the TMD service running on that subsystem (e.g. CDSP: 0x43, modem: 0x0).
> The driver then uses the corresponding TMD endpoint names ("cdsp_sw",
> "pa", "modem") for cooling-device registration.
> 
> QMI TMD identifies mitigation endpoints by name, while DT thermal bindings
> reference cooling devices by id. This change provides the mapping
> between DT cooling indices and QMI TMD names, allowing remoteproc nodes
> with #cooling-cells to act as cooling devices in the thermal framework.
> 
> With this in place, thermal policies can request mitigation from CDSP and
> modem subsystems via QMI under thermal pressure.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

