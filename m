Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F439C005
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776888187; cv=none; b=UREpuxywEuIZdUGxYEh+O4k1TuCT5lL85Ytc6XWd8E6CR2ni5dZGUAYNhqFaB2TR5bkdx/OZ97KOOt8gYWChkxhx0sNTFKd8SBcq+qEA4y/oh9kp8S/8teDNta1noRqnhkGB2eyarWnKMb7K69yTULo/ZpntW7cWBppKigBcRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776888187; c=relaxed/simple;
	bh=o3uw8Dl/mDosRTBxq+evRZ5aY6Q5yBBBb4lp4lxAIhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u33m4slNooxY1Xa804ob5ItTlzRArhNSCKCwBWwd42TxinNSk56EgsHGzt+D2noTMnTNWpKQq8pP1qVPydPqNzGsEDZGirewRQ36/U5WtFL9avmRpcpeKg+tHohqOAAOo3TfLERvhXM89mdoBrKjbfK0/7EBqgcWF3bzwfF1zyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lEKxHAsi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lqpt0Ese; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lEKxHAsi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lqpt0Ese"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MFfmdM3528271
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 20:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uwtLBUqQQkmSkDCqcS+GWdss
	NcMifU1gLo5bRnSqrfc=; b=lEKxHAsik6FJ6HUGneLN1ZT2KQgTXLF0hnGafeY2
	yIu5osCeC22v+sv//KKgMtlUneLNP7jnuUl/aYe4vuMASRLx1nNZSAk2TUIp/Q40
	hSGL+MmSpcmBYxEQ8ZcUB3PZf8bxLL+YaICbDhNfFcmNlvEMsLdWAattVbtRdPl1
	Fk5xowyw6oGFtvzpRrIRJKjBSYXRhKIhs5VnMod1xOv7whhErIGMGuKXtfNEx0dQ
	qpJqQ4N5qKb2dcbSDuVLhCbqpHeDnlLlYJCVNlV1PRjJE5i3mGzrR2qM+egCPYPG
	7rEKu7o6OJqvcfRHPoFPEQlngUIK6BVQN0n18FGQWSDm5A==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16wryan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 20:03:05 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6949f514496so1780043eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776888184; x=1777492984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwtLBUqQQkmSkDCqcS+GWdssNcMifU1gLo5bRnSqrfc=;
        b=Lqpt0EserkxK4nP08gpeTue2BRUUj7LrnqMovhJwN1jVX4gTeIw87HVw6X6wQTUtU5
         f2TEma3Xlo9dglm9yQNGiNOqcYzxT97zBBK57nzs0/QU9hIWhCY5eEtVbX8X5jRQ8Kap
         COxyKlO4zNTfUiu86CcS0uCcYQ8kLmOxLYvFNLCYCjJlUPaBjE2Iv8rzcwdsilyepYWx
         MYCGKBf5qCkP9tE1zkz6mjzCfbLNrG2pMhr+dyMRkyBcZjEkBIyJ7oavNBYZCCznjBO9
         GpzfF9yDs2ScwwkYQmBPQnCvez1CnjaMtTMZcs8Va1ROoi1WXJNRFc/1SKCCVf7yStlY
         F9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776888184; x=1777492984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwtLBUqQQkmSkDCqcS+GWdssNcMifU1gLo5bRnSqrfc=;
        b=ouABP9kbxX1DiENgnsb4Y+3aEXucW4M9i2aa6E5xRfwDJo2wYk/kffz7OWd9afeYad
         JoVvKTIzYZF9Yvr5geTHjZfnSM1hAAnUDxIjShUWZrTq1qYiMN8kMTlD0M/LDUpExhCq
         PUu8ynVRE//LPKz0h93FWP1sgqJpFZ6V/KsGgsQffd/voetZ29wbhiYhfciDh8fviBex
         9BAGYhMMeQgO2yhvU9KhPRG0BzlWmV/o0cJYnTKiZ8bVxnbZTQx+tSNLUWwUqd0K0sUP
         +xkX+OcF3kcsSVQLiWQ8swsn9LfC9LXsidGD0skj7y0s1b75x7yEpEm2TmnV9R23Tlr7
         GoQw==
X-Forwarded-Encrypted: i=1; AFNElJ/CJBXPwNMQIwTqDzkaEnxgtJs4u1LlWHPMg/GXD0ehJkCiqMK/4Mrqi9+jNfCXz94/qZKOi6HIaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEi6n4rypTT35PoVQkITSYBNJ/UesHgKyoZzr0WU7HU7np4q+L
	PZR0uJqU28nDtHlpuY7T0veO3uk3ahSSgG0TA1ZdtzMbcE/BxXr+oU6CSEi6PnEiDKdaEDU2G49
	zw1tVcpJPb8G2CHPyOhJ676hlH50TrIa+/MNYRsKHz7F+ktkpJnahpxg9WIpYuQ==
X-Gm-Gg: AeBDieuuu9z0xjRKiigpa2AoUV+kFao9QpSGHMXjpxuKXBqiKGL9CSFNLRvW1nsRLrh
	H+0SxzBfW3wul6F76bmnwCKAuYOrK+mTxAdqJTE7kRtxfkLabU41huTiCTIOGiF4BTUqsseWhf6
	x7iwUoz61UwY4t3pT9ZsqSDGBgLWp7sPxub0M5ZJeVJ3wL+X9MDl9556uvXrG2gXhLQrO4OVkcs
	ejgaS5zXHJx+Z6lLcZ14wtoz8uDnoKF5EblUDHogSiI+bUI7I+TykiKqZ50D+E0VrUr0Ppc3V/l
	8HqF480K+QphKnurF2pCjMY7D5xHD0r+PoTyNn5xZk6Cm7SUjXXV98MrH5HJ8G6Wvk0yuLsZoSJ
	lUFObUPmk1mBJGhR2l7izM3XaFiblPCAu3rY4bDys4ZpcRwU/d4FHBoZY7+caM2XF6FXwwfRI51
	aBkjL7u5T5coroBYax/mSCwCY2KXUfOicZzTdPahZUcd/SHQ==
X-Received: by 2002:a05:6820:81cf:b0:67e:cc7:ccf5 with SMTP id 006d021491bc7-69462e168ccmr12989578eaf.9.1776888184551;
        Wed, 22 Apr 2026 13:03:04 -0700 (PDT)
X-Received: by 2002:a05:6820:81cf:b0:67e:cc7:ccf5 with SMTP id 006d021491bc7-69462e168ccmr12989547eaf.9.1776888184086;
        Wed, 22 Apr 2026 13:03:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187ec153sm4690454e87.79.2026.04.22.13.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:03:03 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:03:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100: Add clocks for QoS
 configuration
Message-ID: <6gsfte5cqf4455la62ruf5gtqkwk3i5wv2xkgvs36oj5hyqpzn@dfcsgoy6vo4z>
References: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
 <20260422-x1e80100_qos-v1-3-bcc2afe4cc78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-x1e80100_qos-v1-3-bcc2afe4cc78@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE5NCBTYWx0ZWRfX6o4+SdWK746L
 sMlAQMDtopXdrn+j5DiOu6G2rHLSFiQ1fT5BTaDfSkNOAEiZeSae1ubqBCsMGFexcVlIOQyGR5X
 fGDiZI9qJeflWZo7W0cXdaOmqZhb0zmbQn5DSj6tDzaIJd307RKzqXJZRqrS03e7to2WQyRj07K
 uCncMN/Qz3Yz8uFCiYBAROsL1szrtGawdl/BylpnXLUMCjXt0mvMBu/xqfZo61CA62hFbgMpuVL
 qudQtID/GwDTnDhBc0qZdbKApCo/qtb/VSLeSAHBjgYOTQd2kl5mHSlcBVQWX5pG4oO2rOyj4SX
 GkQpyA5qhBuOTfxgflWBhhjNgIPsXw8R6AA1auNhkSsxkSLCe/BPMGIzNwDqFZqK0/YGZ1PNtRh
 /0U6ARjknKnsRe/jn2N1y9jNpoDM08FnpuNXc9GMMxf0YkJ1+wFDlxt8aF5KyuCaOWve/wBU0M/
 kG3K1u+R4y9x1Wxhyzw==
X-Authority-Analysis: v=2.4 cv=dL+WXuZb c=1 sm=1 tr=0 ts=69e92979 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=DiFzayPZZ94SbrHq8V0A:9 a=CjuIK1q_8ugA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: 2_gVOJZQfTk33NaUBbxtuzqfU8q99VoG
X-Proofpoint-ORIG-GUID: 2_gVOJZQfTk33NaUBbxtuzqfU8q99VoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220194

On Wed, Apr 22, 2026 at 02:05:13AM +0000, Raviteja Laggyshetty wrote:
> Add clocks which need to be enabled for configuring QoS on
> x1e80100 SoC.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
