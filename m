Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794239264;
	b=oz8Eewo5+yjGORv5tOieJGHRhNbxIh8NIcfZjfuoRn00xi55UW1xkqh0lOFfSZqoSoK+
	 7WKBy5VCmDRCgnEPu3EpovoYI5lIDGO/5XAwS6snsqEDi4h9YD4ie9wbKU0M+0eayZGGK
	 6jRyrs3zKBEWXWZfQ4n8cRopwzuy+xbqMBlqniyt34TYZcNm0Ddcqhfb2HtB+FJWMfNvY
	 Obt4e60/E96mIp+DowGqDsxTscH4G1qE4hR7FIMgGhH7nzwLyeWXEVi58ZVPusredjCDZ
	 f4V5SQw6FwOVL+fSGm9wA5N55B6nZhPxk8DX0P3zQWuJUCI2rcrerODdXpKRITrdgVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239264;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mBoR5s6oMFRgFxiQj9Lay5NRlrAbxIjp94cmKVZAPUs=;
	b=MVsIztieJ5rM3cgwABkP30O5o+iP0ERURXUaZH75FmJev/4KzUktXgTGMmzeEOc0U5DP
	 TKXG5T9LDYMksqQv9t68J3y4l2pWkM6mnYOuCFQ9M4Z6453XsBvXoJk01vBtUQID5q1Kx
	 AZP3TML+jF1SOiCder8OPWjQgStWUQCKdjYvn8LGwT90kMfAmzWzwKKwY4onVCrrC/uWZ
	 AKzoxdl+IcCBC2QzksR9JcplcPaQRrCXzgtG7MOierHEJmOpSYv1r1kf2oJZq9d03vOMk
	 VSyWaS3lxDpqcWd5Q7j3ykx5AilT7omkE0cf5/Q7T/3iM1Mtiaw53eMg7bUC4bmuMSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i9cOGYDw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kzv6+DSY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26099606A326
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26099606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i9cOGYDw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kzv6+DSY
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DErEG336359
	for <linux-pm@vger.kernel.org>; Mon, 9 Nov 2026 15:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mBoR5s6oMFRgFxiQj9Lay5NRlrAbxIjp94cmKVZAPUs=; b=i9cOGYDwelk3Coqs
	Lnm8maHufdSmKU9agpzwAvGEnrGe1g5maoL0oTeVD2vMKitnjvDHsdPqVeSvVaeI
	8nr0owWuRV8qvu3XZ25Qbi3V4RogyWXbuzeeqyOrkViAgfS2pQJe96Hj74eVjOQX
	bq0SN1Pt8Z+6XxT+aLfgNFz5p+vlBgxOf19lybW5u333SlW1ZvHV3+qO3TrqqIbZ
	ocpDF5hn9FSnNyM7KsdzYX85ruuSxU7+zvrLBl3AGbGSpypeBdxqmoJvhts8qywP
	8glHvw+f0GasDtS1A9Ktp7VJF8hXE38GZ/yPi1Zg9j7yntBx/XJjX75vgZG6qtgV
	nJ9Cpw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5rynf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 15:47:43 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ece7f075c4so298699e0c.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:47:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794239262; cv=none;
        d=google.com; s=arc-20260327;
        b=qL2RY0HxDS66RjPf4MtfGnxg4VtQXdtfaSUNEea+2gVogMsBMrb07Y/KdXHsS4mpl2
         QVITeAr4I/glaqMLvsP0UEvhlH5vyolCq8gmd1iWyVK4hBAOl4+DuLMVV5cPXS63IT+a
         7SPpJAILB/I3psw83juol0Rqb/MDdUxPJZUc3CLzhJlO0IZ8Q/elsBYFgv4K7eoFLMmk
         ytsoWNgpzx5a36FDhMJpuVFr+VL59MfCqUjoymSFHJ18EX2Gp6Jypp7XguklhAF8rpQW
         yH6To2RGxQnSh/O/j1jrj7LPdhKaPxW76CR4KBqVLKwwmaI9kgBEEOMtzV/4zC4TlXXq
         PM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mBoR5s6oMFRgFxiQj9Lay5NRlrAbxIjp94cmKVZAPUs=;
        fh=NMvQQDEv+m5hfUXMrD7P96xIbpxAwfvo8Nr2xxrBSTY=;
        b=iPZOPDdxvaYXpA7YNOQRhoXoekNFdFINzlLAlNCH0hVS54rREF4slvW2YekPOVvfOf
         F7NnkOb2W+bTyxA/jnm9RjWufuHdUczNR5x0la10eqNriVCchMbSQnj29FRG2rKsqqag
         AWD7uTXqWa7+bU5QBgwG9UlMmjUpi/SiwwkKOL2jpTiCMuyxQUF+T11JIWlKsnnoLyQp
         ceWnmo8MlOBNmTf6+hgh91WCWO7wXrscvkwKnqLAM4yF63lUuicqN0OYybD1Qsn0t6Yb
         glKsYbJwxGEQIWsQZFiTYGcT47M80jO4mwQWZ+oTIXMti0dbVpeCzaNG+H5A9LL/kqBo
         Arzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794239262; x=1794844062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mBoR5s6oMFRgFxiQj9Lay5NRlrAbxIjp94cmKVZAPUs=;
        b=Kzv6+DSYorJUfmW3b/1Nd5IkiAlsIGtF7TF05V0gXbGaSirHRr2N4ZksG+s2hpxScY
         YEX/AzYU+99UGqwoo/DhDRyn8wQHXOWrBjLTXdXAruUGdR2esmZBU22e7mvrRRJnGqcT
         GAHT5inkSAWezPVFdAxpzcODRaAOeT18XKi7Sp8r9WJ+xPJpJBXFxsKFLRPO59659iAD
         tSMIOp+mwJl6EsoXixAxik53nCzleje645Rk6MfGaCxoI1BocsbYtIBeInifRU6+558x
         1gSYtIjsjlV6NmrQUkzc7pKEcJPoLbD3qkXmHMaB5p2kFRmhFaVvhAjqAlDWKXlGVdNP
         lH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239262; x=1794844062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mBoR5s6oMFRgFxiQj9Lay5NRlrAbxIjp94cmKVZAPUs=;
        b=wCPf3Hox0U6ojKOeJeIah8HDpXiJaXloqqnpbTSQJqeiK8LIJIOy/OKfujc8kPQ+cX
         MvpfX1rLO3FpUslYn9DFPDdzihlgFsXTMZS6dTzT+lo6euOd4NvFuwKFIQ2e172mcERj
         7Nql18lV9+tutq0QJOoP9q9uq9OysKiT3h2PPiE27HTdLpQ1XBen9nZ++HapEwm/+iZW
         pvNuwkL555C3c0tHaw3kNOpJXKR1yPtbuxIhIsXTcSveAFKL240BcW/ZjgAmsJhHf7BX
         bMJaCTw+vCy99y694DQzDOc6S3n/9GvCu4W42QDMUpsWSHunFhMI0brKN8tqslLwuT2u
         CNVw==
X-Forwarded-Encrypted: i=1; AL+hErFvp8VHCz3RZoaNoOeDnpI5kK6gRPDEL/d9lN9kf7ryA7IJ2AYYptBWKU6NPFT4w8Idr82rrCszhQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8axZ0mCZ7Ecf4RnPua1t6mK51B2loKXk2keMEokZdUtdRmSzkL
	4z235RK4S/PbSYr8lbREsjM3ZN0d9SW/lGFDUEQJOQwFhtWN8C3wbGa/a/F/GgD6aq3LQV8v/S3
	sVbuFZB6OQuLS/AN/6LrVzlXyc54AqYWcB24D7FYE7sqZehlUcZPbiaSUMHpgksyMfRQpa0FLOp
	ZHzaGZKYcEItqKkTD+wq5Wjq/evG8CRrCjXYPu
X-Gm-Gg: AYBFou3BxFWIlhZmbZK+y9fGv3o+sjSrAtezTsZucjT2SinIHh2f2GQ4X55x6IkONFv
	Kyrh4gMIl83GAOX/nBAMlUEwecqraNvq9hMUMhRaSb/FJm3rPCaKV4k/TTr70M+pp2y6k++gNJS
	1JS4yydGe3X1bnkorlGSKpyWgGXblSGcVtGwlOdaKPl6G8BxUfCiEZKNwIew==
X-Received: by 2002:a05:6122:32d5:b0:5ea:b294:f0ab with SMTP id 71dfb90a1353d-5ece7143d92mr1480903e0c.2.1794239262156;
        Mon, 09 Nov 2026 07:47:42 -0800 (PST)
X-Received: by 2002:a05:6122:32d5:b0:5ea:b294:f0ab with SMTP id
 71dfb90a1353d-5ece7143d92mr1480860e0c.2.1794239261690; Mon, 09 Nov 2026
 07:47:41 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:47:29 +0100
X-Gm-Features: AclHuK-Kr7TGoM1o4LoUqHv6QGn1qOkyGnkGREVNczQg09-nH_zkvO-sNuQEANo
Message-ID: <CAPx+jO-WLCnVecquKbVaCcErbhuFt6OHFUmzbgNHjixx0r-wMw@mail.gmail.com>
Subject: Re: [PATCH v27 00/10] Implement PSCI reboot mode driver for PSCI resets
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2MiBTYWx0ZWRfX5PXpbwovfkDb
 xxxVCWi6CWh91BzRFcXqJn6Hhlm9lWUbo2Cng9xyLJmmMI+ETvZj24/MQPvEOnxmGI/p4iJnY0s
 MlYMRCU7VtaMyDp+Iicrkw+qm6F1w8Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2MiBTYWx0ZWRfXw1kThlxzGaV2
 MFtgE2dgs9ISpUZJBLl/XdAEchD3QOhvAI+6vyh4CUvYwYWUVTA3Hwk8UelBYAxUIoApFKAUQMO
 Y9Wv86FuEyjGa8MjY8fC9+c8jSuIWpUSWc/oRAGsGUd7EiNYNyU64NUdpfgIf8wu7nNQ0anvEQB
 U6gRWwX2z2p05JfDMHQhabJFSXZPmTVs+RV0iTndfLXpAj8Un6mNY1aQWewkYsGLCsm6AePwPyl
 G52K920DtYGwgEo15peNAs76UwX4UO5lW0gJ1jD2Abhjj422BQ4kkLQ9+H6yDdqMsDFXutw09Ox
 IS1Sct+k0LKb3FrcjbPsIIIQOjMYIvhq0dU3HWs9A8gUqVKhSgf/7ueUtPH53CTWu1KlwCAY76a
 tVkimCWELg5/cXunf9Qi6VdF2y2YLPqwVyfYjsPsk8Dnv+k/npNatR3JSMSmx5F0cVmPRYYPUAM
 nAYD/dJNUBmVVTqINGA==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af1eb1f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=7LcMNQwP9uozhxO2aV0A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: dJqIwUiCDIKFZ3vH5IGDWFEgVK9v_wEF
X-Proofpoint-GUID: dJqIwUiCDIKFZ3vH5IGDWFEgVK9v_wEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090062

On Thu, Oct 29, 2026 at 10:01=E2=80=AFAM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> Userspace should be able to initiate device reboots using the various
> PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
> patch series introduces psci-reboot-mode driver that will induce
> command-based resets to psci driver for executing the device reset.
>
> The PSCI system reset calls takes two arguments: reset_type and cookie.
> It defines predefined reset types, such as warm and cold reset, and
> vendor-specific reset types which are SoC vendor specific. To support
> these requirements, the reboot-mode framework is enhanced in two key
> ways:
> 1. Support upto three 32 bit magic values as arguments. This enables to
> support for a 32 bit reset_type and a 64 bit cookie).
> 2. Predefined modes: Add support for predefined reboot modes in the
> framework.
>
> With these enhancements, the patch series enables:
>  - Arch Warm reset and system reset cold as predefined reboot modes.
>  - Vendor-specific resets, configurable via the SoC-specific device tree.
>
> Together, these changes allow userspace to trigger all above PSCI resets
> from userspace.
>
> Note on introducing psci aux devices:
> Based on feedback from Bart, Lee and Ufee, PSCI child functionality now
> uses aux devices instead of an MFD driver, with psci-cpuidle-domain and
> psci-reboot-mode probed through a common PSCI aux device enumerator.
> Reference discussions on this:
> https://lore.kernel.org/all/CAPx+jO9Hi2R_UnCEhsXLwf74c3RTb+RodaJ6SOVXbQX_=
eHt++A@mail.gmail.com/
>
> ---
> The patch is tested on rb3Gen2, lemans-ride, lemans-evk, monaco-ride,
> qcs615-ride.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>
> Changes in v27:
> - Removed unnecessary headers from psci-reboot-mode - By Bart
> - Rebased onto current linux-next.
> - Link to v26: https://patch.msgid.link/20260928-arm-psci-system_reset2-v=
endor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com

Overall this looks reasonable to me, but I will take a closer look in
the next few days.

When it comes to the merging strategy, it seems like the best way
would be to funnel this via my pmdomain tree. But I need an ack from
the relevant maintainers to make sure there are no issues with that.

[...]

Kind regards
Uffe
