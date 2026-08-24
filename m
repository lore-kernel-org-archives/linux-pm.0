Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954694399CC
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581155; cv=none; b=F33crjRVvxKIkQwkBvoaAxjdmP+vi8zkY5wS1fHNtgjb26+N+ElCVw3/TfAfrXdwudFJ5PYSLzbtPg66hWGN3n+6kVdrnjKJO5M6zsFU9b5D2zjulHeVjkqEETXaBICaLaX7oi49qSLvyTbgGsJvFPNEeiPH/6tNB4nY1hoZ8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581155; c=relaxed/simple;
	bh=uGBZvFe03XTRnDnScoiVwUfr6a/QNJgJCLL5rZ5Drhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6ZR7t+DGmdwyc7ZFcqDvbP3qJYIa6w6Dh+UaWRuMm4qo94JdGfdyJQQfvoMeD/PIttAPMDSNxlPucgFgqCMiY56T/TtpbpK2iDBSsMrAwGefR+m1NGNPiG22I+ZbFgmwg3Yun3yi8zgzi2l4OfOzg59fETtG/S4Sc2P/TJfusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fd6Iz2t0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GgJPAZ54; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fd6Iz2t0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GgJPAZ54"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCuw473613495
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iUX2OhZfsVuqQtVDi60W0GQY3wPaJ8rUSyWA44gD5Mw=; b=fd6Iz2t0/BUeqbt5
	YJnb8iyeIepriOd/Rd0itaNS1YPq/EgRMZL86MRM38s/D/WwMm1aocnmW+UxSE2l
	RqAbm5oXG47xkLiyYiLziMgO9DYCgILYcWV7j++4qBQTB0k4DILM0ekAtuBGtic8
	Ucb2t3ncQzGy1N7y4ln4b+w87xTnyJyL6KJCsiebN6APXrUcRaJEazkKt1P030MA
	ss50uvN+YcGG0Zt4xKc7eMSqg3nlzsgwobg5tGCDwcR8TXmB3HKVyzcTsqqVof0i
	wPdiPC0LGm7k1Yc8bjjDT8YF+TLWfkLAaQRQmiHhxD/N9dDffStnPZ955QbECQt/
	mpTsvA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk1grs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:19:13 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7530aaa7212so108975137.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787581147; x=1788185947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUX2OhZfsVuqQtVDi60W0GQY3wPaJ8rUSyWA44gD5Mw=;
        b=GgJPAZ54sjTxGh65zJKPsF4/XgYFij8qYF9CHRxi1vj2o60bHl8viKgGKAe7FDdyXA
         ycO8VgPF3SJ22ro16pQAGDp4mpGCZthgCA/crPEdZkr4Hlqu5RMEuVepDOCBTc+BP6Qw
         z4BS9bhuHrXiHEFlqEFzyHTOV0WlOQZfShyu6pawdMAash/b3Xe12oHNf1tUa1dePuGg
         JV/qfix0T5Cjmkn0gPyl4KrTgcweOqQt3tCo60ygnKMw9t3vbXCrnelbctSEXXY1sjwG
         DgOF+6UX3Z5rce9avCS/HcIyLrLsmXR7W/CXIWlzXiZYEvxcK+yJXVrbjfez0zwRgkQh
         Ob+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581147; x=1788185947;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUX2OhZfsVuqQtVDi60W0GQY3wPaJ8rUSyWA44gD5Mw=;
        b=rOd7pXoT2m40XPQq1GeUKjVwjC7mv8uHY2vMAwpdA5DQqBVDF17uVu5Q1WtbdoPj2o
         D3OjAIMpDQEmwvElKLiLsTyYO8W7L7o8xa8iQKfqAGptjg7l/pmjocSE077NCqzaNHka
         kO67J/u/kzu4o4+J0nWnxg5Mb1CgXUQRkd2/CCPTpLJVlhBXEnBlZnczuGj/sNImQZZv
         JiYZh+n2Rurj238lmUSykmX6znm2A191yZqAqeQyyhwaOn4jmDM5z/Mrs7SrszSa5Miy
         rAN7FlNSn8wnI7o5FPDyjQAqMFU2xRIexFz2qHJWWYvzt9JRWDK8LB6AstBtEWWOPJGi
         sS2w==
X-Forwarded-Encrypted: i=1; AHgh+RosfoiG6ZA1/u8fxHBQsak8IG7udLspbiYaQ73mDilUV4sLwgSSMeM7LESjokO6rJ0DDLIQtZUT4A==@vger.kernel.org
X-Gm-Message-State: AFuF++kpAHnXKpgobHrzC66m8HJQUFKa93BFcArqEXy+qPQyXRvZm7Ce
	jXwzcEAGU0jNNrEqn4C7Wf0TiKq/XJnXNNHpsX/uG4pcZVLyEwX9wFAAqYKHApVzhdl1DGAcdQt
	uEri+++C9HkDnePMytqJ30JjxcJm/pRAqsuPv4bs7ProiSepo3B4xV+tE3PxB8Q==
X-Gm-Gg: AR+sD11l7x280N01Bp4RtdJGI3q8ukxaAHPsh80jKXEmqDzAvuVMWTrSpWcVTFUVk8p
	v3qyu5NYLKhkguYYj+VReCLZgOxWcFL+shm2Ztne65iZVm4l1r5IuawyqrCxkNGdalJ/0wYIv5x
	s5Y8A49d/H++5MWBrdLvgacFMa73s1oCAAi0KExxY6aoe8wMrvd7QnVNw+98LraFwDs2cQasiCC
	SJkELhVSOTRf3EdtSM+RqVtjVf3ZgRN7va4qcZVrTTQ/7G8h1gu0G8PlJiORGZB9Ro99bOPbzoQ
	9ikgqgN5D2EhIfWnikPvud0r/APVBAvqfxuXlv0nQiWAwj5uzV1kuY7YNNRxGZfkcrRCpSX+F4S
	E3vaxqvHjMuTuoQ/ZhG87lY+x
X-Received: by 2002:a67:fa03:0:b0:77f:76f:2c58 with SMTP id ada2fe7eead31-77f076f3cb0mr479100137.1.1787581147671;
        Mon, 24 Aug 2026 07:19:07 -0700 (PDT)
X-Received: by 2002:a67:fa03:0:b0:77f:76f:2c58 with SMTP id ada2fe7eead31-77f076f3cb0mr479073137.1.1787581147092;
        Mon, 24 Aug 2026 07:19:07 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a1c2fab2f9sm14278301fa.27.2026.08.24.07.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:19:06 -0700 (PDT)
Message-ID: <01cd0d90-2908-42cb-9ae8-29828d4c03a0@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:19:02 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RC-xmUAZOoHsculhbw0srTYHjfKbx3hV
X-Proofpoint-GUID: RC-xmUAZOoHsculhbw0srTYHjfKbx3hV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMCBTYWx0ZWRfXzoD5j0P/9cyc
 g4LbszvnnG+x+SywIN8+TPREJD56hpVam5f3WPUKUe75HUSeBtt0xZG655S58KyPbx6lcNWg84B
 4EV+4w2uUyiy2EcnUyjjSS2HApm3FU4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMCBTYWx0ZWRfX9euHKb1bO16u
 5KqXI+C3bfk+HFo94aWzhvIl2U6fof78D4zKFrvGSXL1GgG0GOkl6Kf729THcsabjgd8LlFoL77
 Fv/H5HFbIKhoVjwJTb43/e7h9DQAHXvYrseqiWeLLTIUM+MLWk/c5B/a4mW8opTaBzAwkpas0MO
 PvE1Pk5H+BT9pI2Yko8xtGCTy3CpZs9E3K3u4C44gjmQDijqya3h/Lk7j8vbMxWxu8vln5y8msx
 03VJTHXHUZ18dfzwpxH/uiJV8LBceieuQ4F5N/i1CIUPHleIW68Onsj7+RR0fTXcdqmIZ1OlVY0
 vAjQzKvNHrrhV2M8iSaf72iNY5LJ2gClTY/ekNzcEUCbv8HPVfXtCihk1drGS6zVVKocngNTUQn
 EdI5x/7J9PoRmpmwhSp6z2xdl+aZHpW6yvVMW/EzQ+ULV1vkeKYihqS4VCGSNkdmUzs9PDdTu1i
 ZbbtuL70tT29bmbc4Vg==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c52e1 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=lpwU2ilW0SqlNkBhVkYA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240120

On 8/9/26 2:29 PM, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in monaco.

[...]

>  		nsp-0-0-0-thermal {
> +			polling-delay-passive = <200>;

..and here it's 200 - I really think there should be a single value
that makes sense, this seems no less than random

Konrad
