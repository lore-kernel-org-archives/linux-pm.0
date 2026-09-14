Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239241D62D
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384691; cv=none; b=PIgjn2hp/6mSjGYMOjWNoOcDPGYntDcuU1P4a3B5vU90t7QB8UsgPg9jp1qmwmJaXhu9s8m0RMGCYnXIFphJ/yk/kiXRWUedEHDTwjTmGkP2+LcRLIyMv93nHyUWohxmcU29Bko9aF7bLhjHc6r8+qNYpr6bK35TJKEE4WMAw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384691; c=relaxed/simple;
	bh=qyo572r093/Wuuigpug703R2+cl/gSCazJtTr3U4JHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qviXag+LHs5oj7tYkwyPi1Iwc1r5zZ22eWiRQywIyjDAvu7RUu5t/ZrTAw+mY9RO81A5/Thp+z4z5gjrlU7/He7pm1Pv1VwXW8D1/8OY8RYcUP563QUW4sXpyo9RUURiIXgL0Rlw+Og5pPzKa8k/nyY0LKRXSPPJqE2h86GCBJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p74lKPfG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FOI0siKZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p74lKPfG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FOI0siKZ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAlxIq1460649
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 11:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lu8CNw9bVINJIb/MTRXcrF6ffg/r+0oykIW5TY8O4Y4=; b=p74lKPfGoxBk3sgk
	Nv7jbyh+PyzNnEZXmPSeygceSiRc+hzxKGqPe8gSasJEoh9jI28KkTBcCvBuJBBC
	WzTOXA5JvbzXDVBVkTe8WhQNutMRPF9it0XS3DkwhDoWGJi87AXJ0+RlvEDct+CO
	FpWCASMm55uop92Bmk6T/9dn+zzxgMzrOQIb0RYNCmSme9cM+opFd9GTGy6LqdXv
	WLobHlPt1oeF94En8pYt/HsObrlB/40wMNOpvIJbiUxfXCT87bg3586GtWX2lorZ
	K+KSP/tphg2ZnwVCfvi3/hoL58VYSv1yosERpux0u3wiqzMpl+SntE0EUvlmh42G
	6L58/g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeex8djq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 11:18:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93495488976so55599485a.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 04:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789384688; x=1789989488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lu8CNw9bVINJIb/MTRXcrF6ffg/r+0oykIW5TY8O4Y4=;
        b=FOI0siKZqayydFs0/W1u2lLkarT0ELiH+2D4URE7lJmJlrAaQ6+uZrH7xhX/9yNMrC
         W5Mal3N2Lp4W8FfJ+E9kLilrFqn8RJu2oRtd3y/6V+u+IJgkqJo40Indnl+63UmdYyho
         J0QSft307NtIsZVciPZoZCkQ6TPB/ELnDQFH+LPyW5EiwUSV6Ni2jTvlIW9Zv7pfsJ51
         jsRSwMC/2Zw5slFcU6+rSj4Aq9ffEFfl5hOeb6VcXhOaxWSyDzCjQNnqWQ6Sz6sah4Mt
         6CEvruM5hEQJUFriFRme3P4hoqmks7y/XUxWyPY6WxhbolxM91rglWukNIPTjENgKE6m
         eVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384688; x=1789989488;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lu8CNw9bVINJIb/MTRXcrF6ffg/r+0oykIW5TY8O4Y4=;
        b=N1LVSmNrnalWx2o+gMBsI/QXGZwUlL/yjUrD+KEaMigt45wZIjjhTsxKTfRdzLaiTr
         wASc2GNDYXRdpNJ8yPp7tvdztsolnYm8dc0XdkXhQR6/qZcV+/t0A//jybyoCF2i543J
         S4mKsHz7s2y0kG5nQ4eaC3Qfg8B/1H6TRFqCUuKXW4hwSgfZutW/j2PN3hKXerI6sW8T
         5vLk8cdifcfUKHhtnyC6A0QHMYN1STXT0mioPgU5M08oQ8GZW2rPBwk7Kr+JeRlToDJD
         szR1HbzY/RtcZDz6GTNXYxk0meDYTljFyPDhm3ZUptZPUm3TqgHvm1C+6ghCEgCFJoM9
         RmhA==
X-Forwarded-Encrypted: i=1; AKwUvBy7efYb+Nvb+BEgYW7mr8cpt9rnvmKCcva7bfq74UBKvIL4Ikgzp82jmIzf1uJx/ce9/tIt+YGkMw==@vger.kernel.org
X-Gm-Message-State: AFuF++kciRQEBV7z6J4SKvybbvfjS2T303Jxnn+YeGoGfvvpDn1t2dZ6
	VeOzmKH7OpGoUBFgyDX2ez5lUFMgVwnbpsCnLD1dQJ9SwnbhDpAF6rIx6B/5jpjPlkMFHcmSK6J
	0a463kXmNoMt/cHYxtmLVk/1nmjlDdLSKrVHt9tjDZ78NIevMMyS4bInjbLCUlQ==
X-Gm-Gg: AYBFou0y771gu4ErqHM34Ya+JWWydQVcyxdPVlowWHHthDhviJnTzZOUbkR1Irgbd3v
	2TYWZ/q8rGPVtv6bk+bHj5cCbFXcbz7D5KYQxTIMx0LhGzqBQk9MOJqu3qgziFFJLHO2oqD4l+H
	NDT2+vM6uGd/iWgnp1m1cdGE+RXX7JxNw6zN3rus+mB+eix+lritM7dm67woiC6lN/OUIILTLeM
	+q0DfO6YDEs3r87dG5XPmMddlrI6SjCuhkHt5uDjBUCq/FWax7wHmFcT57zuI8CcNH1HjXrDZMg
	KWMeJOkff52rpRZpzCqlHC/qspjr8hpl2NnEII0Hw31QCa5cSDtQE889PB82SajKjrgT/3rHlZd
	pwPH3fMPXG/BgBgTiFIyqLA==
X-Received: by 2002:a05:620a:170b:b0:939:8148:1e3d with SMTP id af79cd13be357-93a2987c21fmr216471985a.2.1789384688311;
        Mon, 14 Sep 2026 04:18:08 -0700 (PDT)
X-Received: by 2002:a05:620a:170b:b0:939:8148:1e3d with SMTP id af79cd13be357-93a2987c21fmr216464885a.2.1789384687844;
        Mon, 14 Sep 2026 04:18:07 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b593d7dbsm4143990a12.22.2026.09.14.04.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 04:18:07 -0700 (PDT)
Message-ID: <21722931-0a6c-444a-b23c-59b47dd82430@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:18:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/20] clk: qcom: smd-rpm: Add clocks for MSM8952
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-13-0e742578b524@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912-msm8952-initial-support-v1-13-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MCBTYWx0ZWRfX+MAxoIgZjz7m
 yy9ndpLdT5/yHHvfPOcq0ceMNJuacTe2+K5sadOuMKdNqjBay9oHPta6FSHwn54v3eCji1HB1F/
 Jgkvo91TR2+PN4edfwH31GU6uNX+mDPArZh75vfTVGiL+VpIota2qVarNhYTF5RfG4gfeivpdbe
 og1nEBl3VD53WeYzlejmoy2bdyPN0MVD7Y7ZfkVlL9sPuqtCDQhxRCk+duP6AomGoE8pS4wGrLa
 S5H/Q2jFu0dz7nEKWRc5nOGhJ8daK3eCocc9dH/Ld30zVaduwBHgYHMirf6GZiB0xAewT6+Wsj+
 gCEe+JeU93U+l7Wrrt3+kS3Hp0MMUGDZldmj5y+cufitngcpNNxw8WccwDLGf9MdeynyXGRxyiW
 Xbt9dthKEPYm+EDkGfTdzcK7fxpMyXzO7qCqTdA/+zZbkoHHwGt+I49tFqHvtEdevPScsZQep0x
 DEqVPij2ZDvqVS8fTIw==
X-Proofpoint-GUID: YmWWbyypW5arJM3spHIXCKpYBrN0btrt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MCBTYWx0ZWRfX5wuSNB9sPqVQ
 SYJ/Z2PR6ElOYChIJCrQ+9IbQ628qh3YffpMYF8BvVgjepNP7/CfpEEw8JtKBhkhk6lfnRrH9fA
 492XyTtIgyoOLeTQpqlk+lkj1IxXSdE=
X-Proofpoint-ORIG-GUID: YmWWbyypW5arJM3spHIXCKpYBrN0btrt
X-Authority-Analysis: v=2.4 cv=MsrHeGae c=1 sm=1 tr=0 ts=6aa7d7f1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=OuZLqq7tAAAA:8 a=lCfP1g0v9f8vL_Xsk8YA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140160

On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> MSM8952 has same clocks with MSM8976 and MSM8940.

Let's reuse the compatible then - add an entry to dt-bindings
where we have a 8952-specific compatible in case we ever need to
act on it specifically and a fallback to 8976, so that we don't need
to modify the driver needlessly.

Your DT then would look like:

compatible = "qcom,rpmcc-msm8952",
	     "qcom,rpmcc-msm8976";

Konrad
