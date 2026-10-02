Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4D3081A2
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924848; cv=none; b=PRMhkCK1uRAkFjmEQRuAstbsJlUX1DcA6cpY4JTuv3WQZ31t9tkKHumxTYm3hrb8eodwxU3tbIxBN+RVMQ7zxe8j5Vyhe//x3QZwIOuBhnA0LLJ0dCuy3kQnDS0NIHkflh3Z68K1RNUQWIfoZKdLpSzBSxb3WzQonTJ9u8zDBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924848; c=relaxed/simple;
	bh=p86aoLipPnmeBSCQWRntvEIsHN7hwNunducQ3JxHt+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmdzMEtexv3tdR5bLuKWGltR3vN7htcBQAi19Bw0wAvoOCzaT4RcmwHbBUiaL0rdTVRrXkv/jgMWRBt+45diCKWCMTWBrD3Z+tanI7hpFlroJ/RcadKgEgay9GTP5EjWerfUZ98VT2Y1xhwW495N1RgNHzFpT5wBOcr8AfLHhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BpO/XKKZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Riy4XrLi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BpO/XKKZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Riy4XrLi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925j8Om1618660
	for <linux-pm@vger.kernel.org>; Fri, 2 Oct 2026 07:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9I+i3UIX4gVXyxWiJ+Cg4JTVO0MXqaK0GV0dmAfVfSk=; b=BpO/XKKZUeyr+8US
	UjRKKSbDUo5AyXUeAqtVBZWAez2jKfY098dA/oY8kM0mG1v2uYNLcqj2/oYm8j7Z
	cabMaUqTC35a/WYTOrIizr+j1qoN/8fNKF4Vp4x0FKv7jQ2cskH2eB5u6Ru9yoHJ
	+ZEXyfjHGy7/6iLmZG1kQl+Vb0quGzMgoaZIH0EXOsopGaGEOm9THHHRNVz7PJSe
	MVX1kbW7AhQrFt4m1qAouwkQ0lUHO1JSl0LaoOGpTr2tqZgYnxdxZkCFdGAckJiD
	My3gOcv8g7RnApdNoD903atljeoz47BrKIxQDJH4tykr/xw2I6JxsuOclkBUlKDx
	LrYstA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp095h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 07:07:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9308eafb465so1799008885a.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 00:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790924846; x=1791529646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9I+i3UIX4gVXyxWiJ+Cg4JTVO0MXqaK0GV0dmAfVfSk=;
        b=Riy4XrLiisj1xthrch5BtKkeoXbw2GzYnjMj4HKZQraBDraGZzKF/C/qE1GRbjw5cf
         CSPfr0DUKHjvWBS1kx58yLzkd3+pCkQ8fizQqajEvsTJ+C5rHlcJeGEcUA3B1bLqMUPi
         oq0BzIeehuwfuGbfYe4kf+/h3xZzd+PlhrpwW2iP2gPtsG+h0YfS5lctB828ILP3weXu
         SonfuDtpesfmvPRXLJpaCWziuteQTHxotuPG5+I52sJfMk2n4jkB5V/XFYHP4rgtRiUO
         xkOmwebjYVtXqu71+sUzo0G6fmeULQO+MA0W1n9Q3fgEEMaASrF8+BVPuLlALjlyRNxM
         zksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924846; x=1791529646;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9I+i3UIX4gVXyxWiJ+Cg4JTVO0MXqaK0GV0dmAfVfSk=;
        b=lm+wZ5K3wTK9Gn9hvxE7novLkyWXjPxNJEJ/RsYYtK8ngsW3p/PUiDMDLA7w+zs6lS
         i904AJtpl1Yrsbs+niZUOAbeHwjWMgKE8bOEJlW6CsRjmUKDt6ka3wq5QOB5Z2kbvcYH
         qgdIU0gVPNlslg08Lqepx+wTXdSU5qQVCyNZ5sjtp2ulY6/vR6Qqt9655CBfIXO4eNzS
         KojdXh6NLPjCFdkuxDaf3qKRPQtBgTIm8vtQnZM1ntir18SqOGfeM3xcR+e4C4mluUj2
         dOkNxDP4UD1auXUTdFgFXmcYTezPEue2T0N7eH+ij+BJhV8ZIFDtAP9j2QNbeRl3W/Lg
         DGhA==
X-Forwarded-Encrypted: i=1; AKwUvBzTEIPHvhoG8F6bxK71UAPTNdbSm5jg+H0dosrMhiforx0ByRDGH/dVWknyp+/n1011vTaVEt4ynA==@vger.kernel.org
X-Gm-Message-State: AFuF++lzrmuv0FWhdzUZUX1KrBKFUkqjoCc/pISY1jk45918jTu5VErq
	9Ce86GbvC9jJcTCOJqNa3Rn8DoUlw7rrXdWqTSaQp3kAiHwATCO10WUL/62D43NzBM+BkCORX6S
	MI5S4auKTPG8gwa6J7ib5lCk0k2++mNsNmru0AKAf8Fw1o6cb4P8Qsav12QZAKw==
X-Gm-Gg: AYBFou3XnTYCSD7xDHX8SRjWf8YB4dM3rCuKaRLPF4fKS+UnDxzM8lBMdREatj2BuQt
	D4x538/fSwP5qQZRnVfSwhJ4KhdsKep7ULgEeSBjUB2bEp9y4oRwDIdPGBbBwpaPcQR/i4Axu6K
	uZrReeHIUq8LdVactoAMFCzm8ctFdNjBC65Ld4eS73CaK5JvynhFseE8gB9Dy/VrzG7esLGkORa
	AZTwPXUQeBftrP1tJzvvcd7gGn3Bxa39OO5yZfD4uh4SPqT84Wn9pc1OVSqIBS9PRXWe9WMHJae
	x/k/Bp/rc0L6UE0lpEvIfIfhlzhIkJI6Z90Jv1J2OxzLng4QzeNVeMAEMaIM2M6PT4MYK2dGTPi
	eRJSFqBq1PlV8WJNN/NNTOmEh7l02JJtdAL+quIXqaZAc5Jnx4HQuZCWlxIkHtw==
X-Received: by 2002:a05:620a:1992:b0:937:1097:feb8 with SMTP id af79cd13be357-93cf16d9c55mr286860885a.24.1790924845378;
        Fri, 02 Oct 2026 00:07:25 -0700 (PDT)
X-Received: by 2002:a05:620a:1992:b0:937:1097:feb8 with SMTP id af79cd13be357-93cf16d9c55mr286856885a.24.1790924844881;
        Fri, 02 Oct 2026 00:07:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f14c:b716:c104:4712? ([2a05:6e02:1041:c10:f14c:b716:c104:4712])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm61000175e9.6.2026.10.02.00.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 00:07:23 -0700 (PDT)
Message-ID: <415c5fa8-d5b2-4030-9618-07cf828c8d01@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 09:07:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 1/6] power: Extend power_on_reason.h for upcoming
 PSCRR framework
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20260924-pscrr-framework-v15-0-7af87107e0d3@oss.qualcomm.com>
 <20260924-pscrr-framework-v15-1-7af87107e0d3@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260924-pscrr-framework-v15-1-7af87107e0d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6abf582e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=FITrd37hvkKM1ztSptAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: iut_e5cpSdcz4l3jbgPvtPPjx8Ejzd94
X-Proofpoint-ORIG-GUID: iut_e5cpSdcz4l3jbgPvtPPjx8Ejzd94
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyOCBTYWx0ZWRfX2BUypaG20Aas
 fYaxRKLXuF0+PVZLhA8F/Z7MHCPQm8s+0QelfzNF11DrDb3YcSBHadT+F1kAGqhfHN9jXDwg+8+
 5/YT5mldCTTCIXrhTd5y/AbO4xytxxk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyOCBTYWx0ZWRfX3KDD/9C63JO3
 ldFGdY+oZzzvCUdaUjvWXmSoDhpL3g7HJR7c4ikUOsvECNXqGT1q6DFxHl6w19E6sg79tGlGy3a
 vpLEU3nu6joGDBcJOxLzzPqIU4eoXDnKVEqCVl39dHm9Q1LkVsCkKTjyU4J6L4FfFQXTVVL4Lkl
 8i6Flw3gpkxh9sBe6WVw1tGvIO0ERU76XhqRSzuLS8yBMJsdDTcl1luYrW3ag0+Xedb9ccdMocF
 2jZasEJ9VexTOay79bGxfv32oNnTrTVEsbJMkbhshrdezmy+i8pZ6ZchEp7oqJUkno7sy0HIt98
 0njPAYoThqh2Znww1rs8KuIq0cxwfLtAq6jbfbk7X/8EleMb/vN0e5N42wu/BnkrpXD9k/SGCBe
 ryQHFI4DJseuD8DO7AhC87xfXAZdBWtrLgzE3K6Ajq+rXj0wOz36DCDnnBSXeIg127VlaRdL4bS
 NKK5HQzu1O4XMdzPOzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020028

On 9/24/26 09:08, Faruque Ansari wrote:
> Prepare for the introduction of the Power State Change Reason Recorder
> (PSCRR) framework by expanding the power_on_reason.h header. This
> extension includes new power-on reasons:
> - POWER_ON_REASON_OVER_CURRENT for over-current conditions.
> - POWER_ON_REASON_REGULATOR_FAILURE for regulator failures.
> - POWER_ON_REASON_OVER_TEMPERATURE for over temperature situations.
> - POWER_ON_REASON_EC_PANIC for EC panics.
> - POWER_ON_REASON_EXTERNAL for an external reset source.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
