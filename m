Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE0639A802
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881682; cv=none; b=BBpfaIALWCGYHcdDajB+GsKV1mGOW0PwKFdN30j2RMk887Cp/fAJjhK0SXsL3/oqT6Yj+k/wCrdebioM7M5kectiJQ5qfDmd37r1TRTSbgfzQqIju98OLHthIjywuVqwlyv280zWE/k6BPdvGkqYEYIlPmuI269O4Jiwg4s37vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881682; c=relaxed/simple;
	bh=CPa238Lhw3/i1jFwoxM2dK/g6KW16pMfFU0UbW1SSHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOv5QG20RtGp6E6LEGmxAdQMiusDEUYzEhNNreY/bP5Jf5xEUENe+j/vc50f8WzgnwkoHPt+msu4CLUbsaaW5Z76ZVI6pKekzRJxWp4i/rRlPx7/Q9NzwCbq73EHRMCm49DgJgPd6JxO/JkWn82Pt00O+QygY+S51bt0qpn0PvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZcT7tZv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BCE5m+Na; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZcT7tZv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCE5m+Na"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MFPsgl664103
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hPhGIxQkpXBRdqEVws8/Zb/E
	OCuJXIDXaw83aUIc/Oo=; b=SZcT7tZvXJjR7rM7QEPakNpS2k/kQ6kkFlrHC6dn
	9FkNeOGhbf6k8zd4T2Mw8GbN9A7eRG6/dPrfTF1wEtdBjA55ElICDq/crQmzx1mH
	FQBDByC82ZJtJybTi2hmxDMiGB88OKWo8e6+onssvtzVEraCrs6ri8KpFhzGb2sh
	3R8YKYEdzjvpGp6xkXksIxSnJ6iZR0fNw20nvTusBhhq5lQl3w5N9PKknVObV0ky
	4MOdBXwiP0QniaVKyFP+/OiKt9AbJ+HS8fd3H+YKMvKCqS7HToFwuuXFbMFUKT3B
	3BtmKhUIL649qslNHQzNypD82Fc2k1qKCPb8ywvIq6XQ1w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgt05m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:14:40 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-956732444ffso8673496241.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776881679; x=1777486479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPhGIxQkpXBRdqEVws8/Zb/EOCuJXIDXaw83aUIc/Oo=;
        b=BCE5m+NaGh1orlsNyStsSA2IhjUJP66dEYwHdqCYC4Oh7lM0KM2And62EvGl9fcfBK
         DXnJl5e0hqVW9D4tukF2YHuKa6F7AzVgsbQ4kpPR2LT2z+nT4a/beJLcKnhs09aHxdjF
         7ztcy74fxnnTwEyk8sEmRzjfwz4mVBW0jeT6+b6V9djK9xSBZXJhrngHcAoIFDy4gb/4
         pS1gJm+3p9YhIcPzMiJB6LPiYi95zpxOJ6FCDOlW694qELrWnfRcmH31QcsdDUE9dogP
         tcKQuJFo14KyEDQ4eFFijADzm59ZDDyuP8WjXZwO95lpywY4NTIOrfP2H3HXYojMn/GS
         EPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881679; x=1777486479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPhGIxQkpXBRdqEVws8/Zb/EOCuJXIDXaw83aUIc/Oo=;
        b=mBor61kkCqn2n4ahVLl0Plu6c8GEcCPSBsns+lCzDuQE7kYS/DTmAJ2LAIu6ITU2wb
         JZDf6bpKhRpXE1dxTjmDI5g7I5W97oNEL7vkqMuaEEouR31Y4rkUL8ezhjFvpWLhnIJF
         p+siK10x8cYJDOheSJ4jQYM2q/QVZ9LECZr99tXV6cAcKJdY/1JEdaR5i4HyKw9BstYa
         tS0BljbtVmG3uksLprct6QJRg4RyLikPPcucVAmtlRZHrCarL4KcL3ZTZudpe7OTUncC
         8TkykDFze8rMQcOQXTWA6riDV/yBV+jDap8fHWoRMqYpXRILP3yoiwy1eew0XNZorlEw
         kEHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZlHdOAJCHdQpuTUrmA9ga5N3wla/+qkika2A2MOYCLfbb6NwAJtS5CFyiTdM+83B/y82hHoom+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrShw8s9oMEXC5mrfxYPJ+J1Q9gqAP3yYESijdFBC4iRXof6s
	H6mpUv3ho8w4GXY7sLqEU76QhYhwpNy7rfvpZ3s+kz9+UHemNm5H9ZMO4zIfIDX1OyibxGJzGHb
	t5gjWfkv9GS8/q4OwdUmiKkeiAcrjuuqoL7nHMFOAWrMC0dxzFU65fd5ti6o0YQ==
X-Gm-Gg: AeBDieuRxxHyxvufvX2iX6PJpfe6tlB10XGp9+TXocRhowuRGV1zl4wLA00ugG1VcVW
	cVxv9zFNqZEFFH9Tllz4qHRhC0HxkPpG3lHgjAmIM1jlT/Xp/LHYAbhZP/oYcFSj/57k8SwPx/l
	rya1rPZ9FFYD9y1X/rSs8ysQBSbv3M4Z8rAeSzNnKp3sCxW7lv5Uzvoggq8JBCQoxU7JoHMMpPJ
	zx8n5sVoqVPO9uJx6mq1FpHnikI8GQU2QBmBWrYzDhxHnMXradVeGQ/5LFPSuDckEJyktU3sfYe
	i3NY41haO4uwKu0Kdr0rX/EKXOXP1OHWeHyyeIZtAL0Y8qYKVJPut+nIyBt6FQF2nj2AY1c9my6
	aBbiEN16T3LVSpnmwBYtlSNmfJU62g+mBPvPDlWThSKdE0X4tl/OrOIeXgapyYBQTuECEKXXmMl
	Wg+aLRUQxjf5qVgGslFzz1//dxMmc/yNoPvmoQm1+M8fARyQ==
X-Received: by 2002:a05:6102:204f:b0:618:3503:5659 with SMTP id ada2fe7eead31-61835036f21mr7881978137.14.1776881679210;
        Wed, 22 Apr 2026 11:14:39 -0700 (PDT)
X-Received: by 2002:a05:6102:204f:b0:618:3503:5659 with SMTP id ada2fe7eead31-61835036f21mr7881956137.14.1776881678794;
        Wed, 22 Apr 2026 11:14:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad143sm4650753e87.7.2026.04.22.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:14:37 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:14:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 09/12] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Message-ID: <odwnlr3nyootxsdstjptmh5rsyms5fb3a2347y2oen4vsv7uhn@26afv3khjb5w>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-9-720d02545a64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-pwrseq-m2-bt-v1-9-720d02545a64@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: sp8watkiJMbg7onnw0hFgcGnwptw8LrT
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e91010 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ZFRR4UPfCyPuBq0k6oAA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: sp8watkiJMbg7onnw0hFgcGnwptw8LrT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3NiBTYWx0ZWRfX7V4NXHhFx3x0
 /OumIv5B9shWh5zu5pTd+nVzoeXL9gvrDE+KH8t8CvLH1bniWFF+8EhL+fHw5tW4mTd3g8P/i/a
 VGVUupBGBZ/81zglfSGb9A8z2DFTYS0uDSy4EkKxlCjP3NPUDg3MEMO+li5hSn0LT1o7zvgna0a
 4wSkIzwUixq351fqfyYtuoW+MymQdyzldC2R96jnRBE90IdRv6Pwd2p+nfyk6ZleYislwEuIoW5
 lpbSftCtX4o2SHpERk8Lv6U5wCed0V+cqXdYbTxE0cMsKRVN94I7xp2aWw6cYXZeC5ksbl+6m3I
 RfB6PfT9+/C21VKEJZ4dtmBtv5TwjkvW1sVM9ToewfO1anhFWWpj+v9tvbqWeUK59nICxBqLjpe
 fuPjxhjxiY3SDIJLfOX1Xp12aPAgBVowRYAh2lKQ6e6GKH9fFe/apBSP1ZWFCwnTC7Qjjkz9/+8
 ET56j+VcMgBdx4xwpzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220176

On Wed, Apr 22, 2026 at 04:54:50PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support for
> getting the pwrseq device if the OF graph link is present. Once obtained,
> the existing pwrseq APIs can be used to control the power supplies of the
> M.2 card.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
