Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570E3E9C08
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682282; cv=none; b=E3wlTZqy9fZN7XB9ypc0ZmKjQbWVyFbkOG36v0DRpJ4/czp52MQOgVfPfZ1zq2GZYPfdvFTIzbkC8D7ttE+sOFK7556tNmwMZkhsqVVP0Hne8GFiVrpmSZVBr9Sg6sqJervsqm09UKr2V2rqX52x6D+lnMITjLR1VWbCuto46lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682282; c=relaxed/simple;
	bh=v9DNVcgbp6AvN+3guy/5FOJyEoFIXSrq36l0ZPnSLU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/r9iJ/zoHE6qRnaRoVaSHNQufi89HUQUO6G1J0PkmqZiPmtnDB8WnduOhYYyck/iKQE3pG6dyFE+e6x5tZHERAeoqSz/ggDtaD6VEIaG8p73MFnm59tth5V1wYRnSZpiZ1OlVZao6Bs17AItL0EmKUYfHaOswdo+nwiC/qccfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DaOAPn+D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jAzJPTLQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DaOAPn+D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jAzJPTLQ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DAPBxF2321422
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+mcP5MFy7RzNuC9vLmEtmub5
	kAChPr9XMnvsErhT83c=; b=DaOAPn+DOeblJ51Avd5Ur1liXcVibs5AnVxaRvR0
	Jvvuav8lFcqejdKoKFsa3PXChYS789s9Fyp44G8Y+N9sg5yQ8MyCROp3qZxRwIPr
	5Yo45Ju5TZHYzA8SGXIKdlIigz8ujijlwz2NAjJSSdujO818dbaPL6ijKay/5neQ
	OqJfwwVH9e31Gbb4tayVx3G42FOHZey2hQvKZAAI6hkwse4yZu14p/S8hw6hPywp
	4hMuYXAew/qTQif80owSphr0BxA3FZOmXJ1/ilPio0vdpUyt5wz5BAM9iapZlhsy
	z+5w1D0Ln9Hvm22ZAV+Ca1Cwy15+oMq2hjpIsIfc0QvWZQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hguad5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:24:40 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95d5bd4e977so3488746241.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778682279; x=1779287079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+mcP5MFy7RzNuC9vLmEtmub5kAChPr9XMnvsErhT83c=;
        b=jAzJPTLQ6OF/uF0ZzNFvQnSiQPSz0TFMXnqhIkfLzzZvsUeVoICXd1oNsOY/tLNlLq
         DCW4Fnt090t9Mymahe8aXzIxIUtY+3VQ2KoNIVH4MhI4zNy416J+eSiEeS5itl9IDoKn
         e+UVjGizBeGcEgXjHg/GIQR08jj62voCHzY3/RuVOAPOxYKnScUsI+fmUokqaUyib1Z2
         9Pbk7rfklRIayNwb7xHpZKEz23vOTczsr9qNPSx3dIdqy8A9lw3sZIDDUUoNrYyWxvOh
         Pt0BhF3QvkwWvElSYtLv7SWzQqr1giX5zB0gyAgTRyVu43ySEb5+mOc14zx+xol44UPS
         qwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682279; x=1779287079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mcP5MFy7RzNuC9vLmEtmub5kAChPr9XMnvsErhT83c=;
        b=rOaalTwaMfAfaBHCWBp0cC2EwB3T1+9pLCzmIR5iOOkeRok7+sUV8Duo56fEuiqH/b
         pEjVsvIXVR150fWsN+rJI2v0yJi53FLJ7B0cUkIVmpQZ/VkQp3hlgItHkuBKb7dHeMsl
         ZoEX/M04tqj4RKYo+apPCcsK4ThmORKOlrCerqhOm4B4XScpLxuFAO+kC5STgcLaC+sB
         8HvAgOHs3pI5dz4NHEl8oygwxbdh2vSh2jBOE+7fO9FRAvDz3vj6uz5H85NklUYwgnLV
         rb5om4ONi+riJwyCPOOxVneuK0lpSXkNKbR8Bs588k0BuSg7XdljT5p9ooccy0oHSw8I
         vMXw==
X-Forwarded-Encrypted: i=1; AFNElJ8b2ij0menxCHuGovnAg4QgNSeXhaRlnY3VD6h0BM1d43Mj0Vj8H5BwVqBRJDwzqddgQ4iHVapaBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kR2Fne/5QAtZ/awPt6+SxQnvectVAXYRxkwA1ejpOC0hrngF
	hGgZ/pFZ/6leS6jvDATAiR/lJdgHqTXEb0uQECFlll+wwvDZTSxud2f/rPE5FonaZZ1LhXfPyk5
	f78OWyxGjoQQ61VSCEWuIovykbcxMGtGFrKhK5aHjvobHflkN2MnWHTjO/MgvnA==
X-Gm-Gg: Acq92OEUDe6Ha0KFsLBl6/J0/nmVqPMh3PCJSObLL0L+8DG3n/DUWA/I17pv14Tfu2q
	d9wxa6ESj8c5cfL0Xt2Z97cf7MbnEKgapG/P9ZTlf2Twj8XSRTbv4WBm9JGAQ2yki8sYamMpxok
	w1/5WkUwBfEAZk+XzM/qBAR3Kw+yTbWaykiwJJQwbXnmbraJ8HOgwgO+fV6lY9habNdYqVw3U8f
	Et+0S42m7KScbNrO6QX6M3o3VHups4+ziZTuEDa+uUkZExetmWw8Ee8taaKzYwXrr5z1TVUVszr
	V7DDsajE1I0BAs7uupWbKxLDMQTsru7TL6kGt4fk5Pn1ri9Ok49ONAb5YsOc14nrAMTYEP3kxG5
	0kp4mhbeQQ7SRIDtXPL15Xb+fjBDE9YmHiPQwl/aAqh3p5g0QslbXz9Eku0rNJbAgWcU/4f5fL4
	g2KLTW+LZnC+Y5n1SiqDin1Q0dPcQKLFbQiDY=
X-Received: by 2002:a05:6102:3907:b0:631:ab8b:c34e with SMTP id ada2fe7eead31-63771e9aa85mr1645010137.11.1778682279050;
        Wed, 13 May 2026 07:24:39 -0700 (PDT)
X-Received: by 2002:a05:6102:3907:b0:631:ab8b:c34e with SMTP id ada2fe7eead31-63771e9aa85mr1644975137.11.1778682278513;
        Wed, 13 May 2026 07:24:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95660c1sm4198174e87.66.2026.05.13.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:24:37 -0700 (PDT)
Date: Wed, 13 May 2026 17:24:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: eliza: Add SDCC1 slave node
Message-ID: <mlkphm6papkmtyvpafrllev7vzk6rr44bbll25p7gdwbx7codp@rz6m3xd4gytt>
References: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-0-b1edf81bac3b@oss.qualcomm.com>
 <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-2-b1edf81bac3b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-2-b1edf81bac3b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a0489a8 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=zvxfrTDFQEmcjWDhNOoA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: sHBvj7wpnB9PFZxl5Rn4eNJRxABqGwSV
X-Proofpoint-ORIG-GUID: sHBvj7wpnB9PFZxl5Rn4eNJRxABqGwSV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0NyBTYWx0ZWRfXzhV/c3voYTbr
 LUWEpkZU8iifcKPIPCQULqYGPITliHuL8IE8/KPZpCu6jP834CApKdfqeIRc/mm807EUdJaFUZJ
 Alk9Nih6AQ048gi2IvFb9ZZfGB/yZBCXk0XGDC4Qdk56HLBqg3nB6VciflIBDOY/f0Qb8jE2hxw
 O6ao7FzREpjyIKkXzQv4PVFcDYYyqGyBrqCbTPp1MnYfbDsMrJODrxAaUNGeBruQTTz5De0LRBe
 j8vL/CYwm1ReEl7DPe6oxcITRb0xIwxmmHw5HAA/VbqiI2wqI+vhb2pZZBRENZYnUyRl9CPHluu
 GpW49SBQcxg6L1lFz2cPeezeqZxufZdHet+uwKApi5cc+NJK6fUk1bCSdyREOJ4eRXBojxHwKsr
 ig0j1ID+ZKEdVWmD5afGQDGVIeT6o/9UeLj5QA7Ba+hhxI+ifSP+iW5OheYbbUOwetwaEV6glS7
 Wvs8INbp3NiruY0e9sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130147

On Tue, May 12, 2026 at 03:18:53PM +0300, Abel Vesa wrote:
> The Eliza interconnect provider is missing the SDCC1 CNOC CFG slave
> node. Add qhs_sdc1 to the provider node table and qsm_cfg links so
> SDCC1 interconnect paths can resolve to a provider node.
> 
> Bump the qsm_cfg link count to match the new entry.
> 
> Fixes: a39efc80ff50 ("interconnect: qcom: Add Eliza interconnect provider driver")
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/eliza.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
