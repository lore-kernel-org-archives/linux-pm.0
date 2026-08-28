Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9B284693
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924505; cv=none; b=r826eOyl4yG4fO9vmkISsIiRXJNt3Oy7ONdqrVJhCwqb9GSjJ6/GaMN5oVM5lgOyH60C/OEO7p0VTtBrm6bUd6yPwWNt1+pi8cHGGExmzkQdCjWDEDYzGpw6fmDV0zqGIc51mtZzfvn9hTN6Nn15cWrU3U0I5teQCIRNRXM3Qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924505; c=relaxed/simple;
	bh=Tb3pJwHKGH06SZSLA9DSDf2HFo5zXpd3gB1lmiQQeaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0nVM79qK7ic1XSnw6x3eq31AKvs5dfdozvJvbTFOSRoM3Pf9VrRWpFvrXS8nzRoBIxL9EerWEykcmKsmu+BU74u9axoS7107WAbYClLEX7spX1vrh4cNw1DMPrdlvDT69rJpsiqjido/U4ibMQ0Koq2qV7ZUbg2UgAeaTLxXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QU5jOah0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gSy8kC3w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QU5jOah0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gSy8kC3w"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDRgHc2015392
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Av2GI0kKVGDvUdYvVPRtWjATg8du110aFsEraqsTjQc=; b=QU5jOah0tIbDRAh9
	uKMO7sI2LGk/1nA6KVynwGLUfLa89QdMeivfuF5PAOLNEUU7m2QBcRD+a9vPeKKz
	PIoC3D0Qp2iRBvAk367XPFf2D/YgbkjOtntPv4OuKeMNvO2CSDV+D7Nk94wURLdj
	owAzcgLxB7hrK28/LwFB3U6TndPnrbLOXFCQB47yXPbJxbr8xmKvz8yQ02VKYMVi
	xVtfh4Ww2H1TApkZlTdZsiezi+GV0eBgYFNl2u8JX/J96kB+bp6WNrAs9OIVJxLO
	tmdRm3iQXokwsntg9kfBr82NQQgrHRQwG51jxe6UiyiUvwupzTHxu/R8b0cF8ez7
	qzv+CQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbag9r79x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 13:41:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93495488976so29327785a.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787924502; x=1788529302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Av2GI0kKVGDvUdYvVPRtWjATg8du110aFsEraqsTjQc=;
        b=gSy8kC3wdFqqrAT4hVE+gu9rlUPISFtn5r1mqLsSpfpv6K4e17uLglE82ot7PWoU/K
         E+Wvcs9kcNxpTZS9EIkUsyXp1ByGSXdpr1mDwvcg0TyOGtjxVwXg/zdkCBEXoKfwLtBq
         OFRg9zg538znw26nxQ0+OdP6mG5E7WfOEw4L9lFQSEJ+yFNxetnI3WyFzHKSzj9eibWl
         ba6e6bRgDO0aOJek9fXi7OB1K1Ag5VYKErfTkdwowXLXeVGV6BctXdTf5dz0LpAk4PBJ
         UAUYaS84L0Q+eXGGqMZMQZUdUrmqP6aOZd6xluqYxHYZALc34Xf+0hB9Mm5OBvUbVm1N
         /6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787924502; x=1788529302;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Av2GI0kKVGDvUdYvVPRtWjATg8du110aFsEraqsTjQc=;
        b=i0G7XrljB8AuZMYTqM2+LThvuDlkh5j5aBGD4jeGigpOUppoCQgeFaW1sS2N5PpF6R
         oaWnm3IUvagY9OMBA56RYkNRIL9l0FmwxSsHJLEZg6mwC5nblqT9pbGUR51bFBLZlGW2
         Xb5OlB9BC50KaSSE7F2SuQUUDTUGCba5cZuukurj4Te3t6bxILbdayrpIq5P8s7Ycqin
         TCsIodFIKfcwy1MGQKXP8N33BwzRnxDRcvYoHoM73P7e8Ryyi8PQXq5Aq9bwnSX1vC0P
         ryEh9fwp9YUZ95dW10KGxQOwjeYA8dG4ALJpyA8iaqgsHT5/mjq76gAICyCPb+VqVcJ8
         EtFw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2dMHX6IYNLx7KrCqtRfjb4W8sSmGto7Hb0j7k/yixddaFdS4/OXhRC3bDFo54pVKZlE+JoAXbSQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kQgFYKS0WcbIpa3Y3eScSU9HzQJ30vdepu7E4Z+S0/U9EYHfua
	EMR1fRxEkWm0+LlP77Mtzf20OykJ+EIy5w6rDuesA1OYvDdS+dmV7jIABy3yFCql+l5oz9RYDiP
	n83l7DKgQBE2m6hTlbsjZULQ+5nGGoPSkZOpH3yZdox6AJUx5VtcbY4CLmCkCfQ==
X-Gm-Gg: AR+sD13Rsl4nK6/DBsrgFDPwl/2nqz+XgfFAvOkAwloJn+ZBU4cYBgrhIpXUbfRPMVn
	bV7kNukpZlgSM2ojhL1Im87VYTbZcAUgS/OZCSB2l6BrwH/1GFBpKMwLHO7LZQhr6xoC4HvND81
	19hIoYBD6NfElprEH2N8W1ARLDqTQy4I3H7NkKba0HreXrQ2PJJg8VyH9G9KnAcVoXw6UpkP1fY
	H6Xe9UKxArwBWVAeixUhg6BYbc4HOCZ6iW72UXiIGuQFt93a8DvdKECZJIaF6+SguLsG7IxGmrQ
	9B7zhogbgM2If1920CCp012OrwRCpFDJ/LBVgbtkudPx7CA274lZM55kiw5Jlk33WoAbiO9T7qB
	WIJfxuWVhqMiUY2UBQJFhoGQ=
X-Received: by 2002:a05:620a:2950:b0:92e:601b:8d43 with SMTP id af79cd13be357-939137aa4f3mr479998085a.1.1787924502362;
        Fri, 28 Aug 2026 06:41:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2950:b0:92e:601b:8d43 with SMTP id af79cd13be357-939137aa4f3mr479992085a.1.1787924501825;
        Fri, 28 Aug 2026 06:41:41 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1fa3ddsm81168766b.45.2026.08.28.06.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 06:41:41 -0700 (PDT)
Message-ID: <c27beaef-05aa-4963-bf6e-ff6df08c6110@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 15:41:37 +0200
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
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UalhjqSN c=1 sm=1 tr=0 ts=6a919017 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfX4EJwBtQ6hsNP
 KGOYMXWhiGSYSNMJsAw4sQ5aTBJkPxN4lLrW9bxqmxN9xkRBqEMXnOEtt4l1hIGuzsM99PZsUIM
 xSBir85ZWK4E7goyx2S9Hs3rktgkO14=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOCBTYWx0ZWRfX8orAJksjsDl1
 2dmJJri89FsGqNLmjfsXCWCK99CqA+D5BSmIAgWZ4Zds0hkGCvwARH+sQWpNztbPATtLmRB/Bbr
 VwczqJnnlnItUp4bBzjxvg7hlu7+RlfA4Jij6b31jzixt6oxT9ntkImGefBxLgQ9nEJIb6yUZrO
 dO3yyUu6j7RzX0/olctnuv8fuVNtbkObGCeyd5My9WsXUVft1h/aHo9ToYMlHnFuRj/D7OCHUcW
 t1xpkSoZE1o0RaLcxQPusy47ltUvVi7Kx2sTHpZ66QGPssR1Lt3LKPJMrnCxvyDXjHzj/R6oqjs
 7V95Heuwrzc46K/tzWTfxNobPgzqBccnLvBYkpYtJ+5xM64aaaI338Ln6mIJWMZt3ytLxmNTQHU
 ofRckEdw1jl6YMVDoy9oTkYh29DB6f8t8PKnAigVUcFUag9dGytAds1g/y4MAcz8yl1EMIPdF49
 98AU+CuU/L8zjnQgeRA==
X-Proofpoint-ORIG-GUID: GWtvtjWFxKrk-zfUDbiAQoONjqwJf_iN
X-Proofpoint-GUID: GWtvtjWFxKrk-zfUDbiAQoONjqwJf_iN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280118

On 8/9/26 2:29 PM, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in monaco.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 115°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
