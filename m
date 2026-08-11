Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885F432E7C
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443564; cv=none; b=tPIx3ueUtHK4KYFVrPdlWEp5TnEDrly3pfh8Yz/90L0aTtMvba0ovuoJ4svbhvu6/RpnZ3Zt11Pu0QFw1Lvk5AcdjP9D4VbL2oXwz3412ruEfyX7OXItOliO2eAJ0HLD2L06VFK+bJXf5gUkHqE2AmlJ4iMXYGBFlgnP8pm/rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443564; c=relaxed/simple;
	bh=yIX0AZeDSBCxEM283ktfqzeqM9UC6TznRuSs2kcJaBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VErN0K2jvWPRV7bzgfBxCfUHPg9tNjqa+OSPxf6g73NnDbu5P2EEe4vEVHwOduJMfitXiTSwC9mNiYG8m83w56+V/fqFqFsvhWN/b+4uU1V/Hg4SBVguzezfo58omWzWeDnlxS0X4pj+A7UWM6WbRk/bIbl65+qeHUwo0aISkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aEqFXb/Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M8NG32OC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aEqFXb/Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M8NG32OC"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B6uXbq2812805
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OkJhmhbIilLQammOt+nQdb0o
	o0r1qouASRnfUNYThiQ=; b=aEqFXb/Zb/AcfX4XwnYbi0fIRplVtMEbl7bPsWPU
	6SxB8AVHa4apVJIHtqBA2Ac3mEf4lMpoHGIgsihAli5yIScg8OAf98Z8GAksw/9B
	wp/sDmPFZ9Wu0OhG2hPaUMJPzhtVKQfdjyige1dvaJqq3hF5iCyo9XBjhHXiFmFj
	2hZmqmh4zTaagp3CPWyu+wCQE4HPwC/MUlCMgVVRbPt8x16RKnJKcy9RpkWHD9vG
	V7WEzXd1tST7m4ZzD3zPD0vzZKvZZOyO8KsTI939rLmrfipyjCCZZOW8ic6N9f+z
	ye/Hl4FSBYv7U9Vu+SSTDv5Fh2qizoeQcDsyIxMbmDnnxA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwers81-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:19:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bff5c7035so56677241cf.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786443545; x=1787048345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OkJhmhbIilLQammOt+nQdb0oo0r1qouASRnfUNYThiQ=;
        b=M8NG32OCxKAsGg285+eNiXR2ELxCxmxzX811E2c2HF5QMskqyan/WMHqMMCHqKYqIn
         SmW+otVDMOtKcm12dDLhHg5OZE4Adyzx2DMH4jMAjbncmi7akXIbv8AywcPJUUMOidJw
         SqYyg6Uu200WiqwItT09H1jGt8tcKU6s9Jmz+wCr6CLNEjNuFUediH4Wow5+Y5QDol4X
         DshWe1vsaiEFPS46/fdwGgR89r0IJSjnKS1JFcYMZeXqBCeU+ljr7+kosV8k2NEg64W9
         LoB22Zh2I5CprkivtxCJWPr1mIONuIu9od1I+m2i+LDJCErgqHbGb4A7TpOJgsQX4tX8
         l5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443545; x=1787048345;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkJhmhbIilLQammOt+nQdb0oo0r1qouASRnfUNYThiQ=;
        b=paJtO50S7N/f3N5obPTEt654oXD50qEra3A6Fsggngqs1XkoAniNmaCLYKFHkiawFh
         9rF49OCHqQiXFiGk3iQ5TSUU1DSmhApjXMPq2BttriHrJ1VKoLfxT2nIG7ohLo0kFOXp
         jOotsug/hG7XyiFC1E0+THTOHLZkYIPPm4ry59qMkSGf3GOLactVDvJGrsgrfS6029y6
         KQGsRiTJUDuPdhUvvEyPj2Chv3bVpBAo/RPwsd99nCkMuI9JAyGnwzX74ZMnmdGn63s/
         9ngMH4uWiLnBGn+m/6C9XJJ314hxrZlnmoCmEhkuypeZREwy8Iu+9K9HVW0JT91VmILn
         zfRg==
X-Forwarded-Encrypted: i=1; AHgh+RqpkffixPU4ZZAoy+a0oMeUsDCG9yhJSerL2uhzFK8MWj/D1q2rGIakONd0nDFP5Ji0s5hUzZtc1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNtW2k19VDXWe8LGPZn2Dwa8nvA4QeC/Ktn+TCYQJ5qaZJNTv
	DgdfQSn/T03X6m+vvOFhxWrlJdPwfHFA0ff8ilLfF/Yfe56FD73WkCEVF+acj3XtE+jH5iArWB6
	kdV7Ojdrg/Nnq4KMMaewXz/phgGTTogbmhEtp1wG4vSKq5el4i5wWyuTh3S7Nxw==
X-Gm-Gg: AR+sD11dypBwNMqAYeQ4ZvyEdTpzGXBiZyqp0D7J5b9bXQWpx5sLBQQ1lWg2Po+0cgc
	0D877g1Mppu5av6ZTeJ5QSM2SqMPxwq/5yxiT73y47mlvJTu+4lMcYJSuEd9mRlL4xmIvW+4IHl
	Us75yVoqAj/pReb6nH8WQe2RYD9+TZcC32aZ/pH0QCOMGkPRlAyuWhtLnaGe6S1geiNu8RYL8xt
	GNjGvssUmEauoqTk5oh3WFBckvBQhb3FR3p9zF38DUbX+HJcwQcgY99/YVcOr/p+MO6oS1dxxpk
	M8Azwm9RMfPKXNg887ar+rcMaFU1X8+rw+UcyhEROOq2mghm+S6uY47DNamse+zkdvvRmX0PODJ
	c7lCP+LKTXzQN8mLpW7SeEIVXmvH901rZ6ZZ8Hg57kprRNhPMLs+/4IjlhuKHha2fU5CGCcjy1v
	LGlcbK0wf7oC3Qeg==
X-Received: by 2002:ac8:5f47:0:b0:51c:a70:5ed with SMTP id d75a77b69052e-52d586365d0mr15297821cf.30.1786443545265;
        Tue, 11 Aug 2026 03:19:05 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:51c:a70:5ed with SMTP id d75a77b69052e-52d586365d0mr15297571cf.30.1786443544894;
        Tue, 11 Aug 2026 03:19:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a0fa3fc5d2sm1729601fa.10.2026.08.11.03.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:19:03 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:19:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm IPQ9650
 support
Message-ID: <n54sewn4sjafsncs2e64hkynxr5ct7qh3xukmgvdqankpsg2iu@kunxe57navul>
References: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
 <20260519-ipq9650_icc-v1-1-4d3554c94257@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-ipq9650_icc-v1-1-4d3554c94257@oss.qualcomm.com>
X-Proofpoint-GUID: iTb8rRRsB49rQZF9Qog3o1E9-kj615j3
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7af719 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Cx5HlDUoyQ0isXJhYOIA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: iTb8rRRsB49rQZF9Qog3o1E9-kj615j3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4NSBTYWx0ZWRfX9sW9H4Buylbb
 NBTKeaWfZjCvmV7KIziSIugTipsDWTf1cYlY0I1dAiyxjX2pI5xZyfCIwlzdXx6jkp4IEs6YwRl
 r40w2MlM+P5CxCMu1y5iWvNCajAmHZQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4NSBTYWx0ZWRfX0iU0lLfRJkHI
 Zizop4lLxvcWPrBm4ZswkGZhFJkm7ThQeCBmWaW3c8rqQDVJdbUbCtDPPgQo7UTjQsZVf/0b2/5
 8braxx9AnH+Y0qF0oZs5UG8xgHhDecVZev5UCRzF0CSiRrMRkAq0aRj9L4DxVpIqkCt8cv0V6L+
 h4MIrz48le+v8JcrIjPzoWLJsTe5nj/4ZxoyATWmoXJ9asPNFHT1BbSJGSvy56K5rbWx06lmLHx
 undS/TtIQ1SzwNPe+5MYSecUywfQAbV71B6DDSDN5ZuZDxy1/BtbmSGX1FEFXrntNU77zxzTwJ4
 6d3+GEnpC1M9y8oCPb76qIwYG69tQu9QYq+Tf0XrnXfMEn3kwwRAV3LNhjuFOQAq3THtQjTYODr
 1bDgOVSZlQxAlpPtikq5liLshQ/GIR07ET5izQBxUu7brXMhVNw+VoIOysbsBRW7tl1JmtJ3+BJ
 xatEzEBjKZmltAN4ZBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110085

On Tue, May 19, 2026 at 02:17:05PM +0530, Kathiravan Thirumoorthy wrote:
> Add master/slave IDs for Qualcomm IPQ9650 Network-on-Chip interfaces to
> support the gcc-ipq9650 driver in providing interconnect services via
> the icc-clk framework.

Please consider adding an explanatory text.  Something like:

On Qualcomm IPQ9650 platform the interconnect busses don't have separate
RPM / RPMh controls. Instead they require direct votes through the GCC.
To unify hardware descriptions (and software interfaces) between this
platform and other Qualcomm platforms, make GCC export corresponding NoC
clocks as interconnects. Add IDs for these Network-on-Chip interfaces.
The GCC schema already defines #interconnect-cells since it was added in
the commit f92b778251ad ("dt-bindings: clock: add Qualcomm IPQ9650
GCC").

> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  include/dt-bindings/interconnect/qcom,ipq9650.h | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Georgi, any feedback from you? Would you ack merging this patch through
the Bjorn's trees? Or would you rather pick it up on your own?

-- 
With best wishes
Dmitry
