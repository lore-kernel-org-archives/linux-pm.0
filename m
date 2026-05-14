Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E93A75B9
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755583; cv=none; b=m08SebXtC86jNYpq7HQrMyAEhqgRCgd7lwGPxOehc9xjdNEI0TIiKpuPpDk4ajtVoauXMnJ1DZjvlDDIxb7dxMSR7XzEli8cVNoX7JYW+HdOiy6xVBeGN6mub6Iq18sV9QjNSBvVcSfO4MB/KRvpMZGVbfBfC+CPsDZtiVb6nZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755583; c=relaxed/simple;
	bh=u2yRYeTk+yXTAl1pm+t6z3kf8/ELAek6AheCZmfXdxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFRxLGnKLWDaxa55k/2OdUMNhqL1ayNSg6DWrykWcknqMr6Kf9cbcxWlsn3fLab2sw9B6EuUkCdM3X0rF/7EiVH+HZnepZi5dJKh9hISzw1YqsdL9KRUm7mr9HDhUBkg4REJrt4/ZRcSfWeATezo7WB7EnEWuyLhUKMM80XoxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mzVwWxAi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PUffW8RC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mzVwWxAi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PUffW8RC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E9k9eW1990824
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 10:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pv/Imfs1xInWX2bI1umtnP6W
	sGJ3pVBx28hlPbpJCp0=; b=mzVwWxAi4P3ygkGjm5V87OhXiOQF9dXWLQm/UzSG
	wvJhZk52MFp81w99OnxnWTY7BZkcXRB+PPOgPYDU8XP7HdqkmIwXi1u5i+Ds74ny
	ATTvaBkxCroCf+7H3e5iIA2cs9VN0mbMeSdYt4ziEEyl1rbcAPXtdtO1e1PLq1pL
	SU16meGVW6VYsvrqLGaJlxpFhKYcnyKRmTl50Yrsy/69sP9KNwj6ZOeEvva1r0cA
	V5dRuOwj9H90QFIWHCwyKoPd9YthQ7/Ft+pYLnnrWl9+Ri9h5UitnCdPR+SX0r6x
	vb3P7aXaK9Dhhxy21tUlCrnMv4UXKu21tLq3yM6rXRy77Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e513ga9yt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 10:46:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-514cbe73d00so89879191cf.1
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778755581; x=1779360381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pv/Imfs1xInWX2bI1umtnP6WsGJ3pVBx28hlPbpJCp0=;
        b=PUffW8RCv2At9gY3Z2doVB0StcTfS+R14xQmCdKbkZqDeSeaI5XMxP+yR2fOcD4bsq
         quPZZP2ZFoyIJBsqTN2JSte/7ixmtyYcRPJTl0e0wKnNAJoDIX5yon8bKuvY06/G6s26
         sdMxW4xw+pDgr5CZ3pIkH1d1Yzjc2QZyBPnz8ZMnv6VUxeFi/Ia7JVVE5UXYQ1UvmCXj
         wYz+N9vqgZfAZ3Y6IvVoNL47z5FLDql4INzIpxsCvXJRBbOBn1lv2Gf22nvNybw3dRnT
         CXDd8WMtozV2qA2LI0Ywddg5AX21QfoKQDe/i44OZC4N4HDmiTJTT0Q6u1hbNKiZ6VMm
         o4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778755581; x=1779360381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pv/Imfs1xInWX2bI1umtnP6WsGJ3pVBx28hlPbpJCp0=;
        b=mFud14TNejF3IMwVsYwJFtEg5FBtxdXgWkf3W2y86uyV06+ezL1XoREBgiyTjqQcgG
         wlV0hL4DRZdCruefFD9jAorIfp657XjLhmv83FC0P/BlanK7ttGlri+tUtZqLuEG9+WO
         D5dnr9FUcKQenl/UaU0apQBcKaHhlXvankKOa6HbamnelYn+I4a+Sv9O23PFy5TZqgTv
         BJKQ7cVYj+HG/Ad5GDggaB6DcYuDubveKfzvsyjdJdoj9EIrCeRHCTPv+mF4dedIzj4i
         hD7ODDn9swxPYfzyR/vsZ0hQRDZ7n1GCs7kdTrZUFn7uyBaDXOrXc4oRX4wlUqxehqHL
         dxWg==
X-Forwarded-Encrypted: i=1; AFNElJ8hdQi8v2yeMWuJbtU99GaYcjRxNieBLot9JZ31FFh4vO8xYrA+EywWy7gmTEXjZKnM67FblzBTBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5E5xkxTLBlFJm/2MLA+767Vt1vuZeIus46I4/c7vm2ge2oL3
	pDG0XLS88Q2rEoytYLV3KWvWQ8zyExPW8eQMa8UGmJO9pKckWklXmZiRGUX5fb7Q/lJ0n74Ra3j
	OFzDvN1pzCMz1SiMFXxA+WBZB3jAvnotUounNOS8vXhcr5R54EuDqK+9NCv4Knw==
X-Gm-Gg: Acq92OGkF7jjKaN698dOySWNCgtO2MhQWU4oMKmhEsyGXFc5APnhX8Q8ql/mfCP85nm
	2r3ZMr1fxd3bZVuB10k91EC7mrRGqqp/Nxnacgb1fQCuN31aWJmUE0cwiTZ/V7xECBY0qHnu2km
	vEFGgYoswff9l3KQlwWBYTVuzT6CSeigKzmI64tdTo0qWIH7hAGwrg73Szt2gER59HaUdUjQd0G
	JsvfubXVD1pjwpgpZJHoxtlgl6Yzc4WsXs0Rlrx1e9mn6LTOUIsignXR9kLbmZH4k8Z5ebt/OBT
	5FHpCsj1GiZDXl9yBdYekAcaNBv3GFpETGDhoAWcC3xHM9goBPLukBtySbo5wlwUAEtQcS8yiKW
	KuMtHHvleQT9Z25k5zjZmk5rb3OtYSZNu37zg
X-Received: by 2002:ac8:5888:0:b0:50d:a4e6:997f with SMTP id d75a77b69052e-5162f49dcccmr98843931cf.15.1778755580489;
        Thu, 14 May 2026 03:46:20 -0700 (PDT)
X-Received: by 2002:ac8:5888:0:b0:50d:a4e6:997f with SMTP id d75a77b69052e-5162f49dcccmr98843411cf.15.1778755579925;
        Thu, 14 May 2026 03:46:19 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a5653sm6111166f8f.35.2026.05.14.03.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 03:46:19 -0700 (PDT)
Date: Thu, 14 May 2026 13:46:17 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,eliza-rpmh: Add
 SDCC1 slave
Message-ID: <fnasmnyh7rf4wtyrv77lunx7spilgjxji3ejflvufouqrdep6n@uu7pkkfwkxyi>
References: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-0-b1edf81bac3b@oss.qualcomm.com>
 <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-1-b1edf81bac3b@oss.qualcomm.com>
 <5c615bdc-3a19-4f07-a38d-16d45f318411@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c615bdc-3a19-4f07-a38d-16d45f318411@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEwNyBTYWx0ZWRfXw2lvRq6lFpFa
 KDUjv1QJko9iv1VcfD2ATqWk/Vb74rdsKa+toTFxAGWldLqFte5zEXo+KUJ4dZ5cISA5wzWI4Za
 uOWB4jY0TNHTIzQC30FitDZEjUGjwlo6kk9JEElY/CGHsdoBmTNas3CVMe54uJFPHSxlDbu3brn
 rq8+iIEyzcaeV9HwoMC5cSOyyr60hmTmy9wj2oVxRoLp3/KG6FpfRPSH/UTgkbfVSsSNTuOk3Rw
 58h1gSmx3vu1gagX/Shd+CtuoV0ZlLo399eKeBZm6lJXFmsvd6SpSV1zlaW9vrvpAePuhOVysAl
 vTdnpzo9ctyitfrd5UavHRNKG8NYvDhJZmicSMGKWoCojYNk0Khjmz7ExX/sVaWILu/ihya0tss
 gEW+z0jX2fThehe48kfDJ72PA1gm+0iuHzfeURtb84Su+faUzqqoVTkvTzP/DlZ/DAP0Ui0ZLLk
 TgsdREJUuRDXl2pnkKQ==
X-Proofpoint-ORIG-GUID: GYCD1XW6sLOP9nSoVybgYuheLenvlZXR
X-Authority-Analysis: v=2.4 cv=Iba3n2qa c=1 sm=1 tr=0 ts=6a05a7fd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=NtgjAHhJo3Q0P2g9Zl9R/g==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=4NfwwHxzEUokdl6m7bkA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: GYCD1XW6sLOP9nSoVybgYuheLenvlZXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140107

On 26-05-14 07:44:12, Krzysztof Kozlowski wrote:
> On 12/05/2026 14:18, Abel Vesa wrote:
> > The Eliza RPMh interconnect binding is missing the SDCC1 CNOC CFG
> > slave ID. Add it so SDCC1 consumer can describe the corresponding
> > interconnect path.
> > 
> > Append the new ID to preserve the existing ABI values.
> > 
> > Fixes: 8300438dc424 ("dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Eliza SoC")
> 
> No bug here to be fixed. Incomplete first posting is not buggy just
> because it is incomplete. Otherwise please provide more details about
> the bug in commit msg - why initial posting could not even work
> (although it did work...).

The reason the fixes tag is added is because we want this to be
backported, as the id should've been there from the beginning.

Anyway, will drop from both patches then.

Thanks for reviewing.
