Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AF3DE45D
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249888; cv=none; b=KEoPVkVbXLhwETyNXQF8DR5uHnlpDq2BBSknPeQ165zffaCtoTRtqEynSrSM+bWCbusDbczKodfZDP+jDSTPE1OrZ2VekuNBEhZZfG8qMV2UWssdGpSVw91emPIOYEhZdpIJjfHQSd6Vzx3/BbSPKfiFEGduiJk8XxolXIN8ZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249888; c=relaxed/simple;
	bh=DOP+NEjs0aZ8AjB9Kb3C72IcIFeqDyCdhC77UBl//ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKTstBb6nafRpiV29P0NkFsruXe1PeOEURWm6aBjdObgGomVl0kjmHyxBU/ZParuiIodvPh9lXNF6iPgedQL7sjMc0Gii145Snw+jv7N7BLyQw8yDtnje8qC2GXfXa4haIpKMoYyS+iF2WclIco5/UYVpUdIhPDS5OIIcWGp+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8SWiVAO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UCdcuW49; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8SWiVAO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UCdcuW49"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39Vcp2411512
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FtRrwXijfX7jRcNOtiyO9WkT
	MQFqO0ZC2KWKNOB7OPs=; b=h8SWiVAOr/HjgZKoNKMp97PEMyff1+X+dwHmAj9x
	Jqsvu+PfBmQkjdyCDR/OT4ezsJKcW62RC22owB6l4PF1gIQ1cgdUMeNrsQxyh4gI
	KwxjsjKD1qOK+8GtryA6UVJRuYYP407gxUG/Mri/1IAdeu+M76ABVs9DP3zBMTu7
	gfo0GvoEaG+TPBP4HB8gfsRmh+/Yxm7VolXeJ2h3Dl6nbEDiOH6Orml9DkKcWXYG
	ZuEJtCKbDZG1F3bOaTqmg+EzGdAmJznz8TLvs79QExokC1PAB4oO40nGJiNc4EIU
	WkDO1UATKOvTG1Q96GvwwWvmZ1oWt1zcvr2PWsR7/57K4A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er165ak44-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:38:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5176d949c58so15063371cf.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781249886; x=1781854686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtRrwXijfX7jRcNOtiyO9WkTMQFqO0ZC2KWKNOB7OPs=;
        b=UCdcuW49u6DGqWrj2mOA+BPv3gyNkR+erBWzO9czokPcSWhaEGo+arhA55gNhrRXCz
         d4xc8qmPWJ/u5KgReZ3CgTXFctZweGt+epb2yODkwH7TP3Keq0KdobZDX+uog0dUeYDU
         ejErasHtznHDIGw6xc45I8NbAl2TYFKSw8HCNXTlS63+AgcB3xyIx157XwqzuRAPNOko
         L+hsi44+Upfc2bef4zaeet8d+MJ3pS6OcJJzB9Q0HeRmX1KhpSJ3mLKXdaG7I59rD7IQ
         1q9FfwkwWIq/PxnY97EMMFlPVc4WkAJHOe8KmT2X1eEV7cQsH9Zdg9PXuhzQRyJFO1aU
         rFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249886; x=1781854686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtRrwXijfX7jRcNOtiyO9WkTMQFqO0ZC2KWKNOB7OPs=;
        b=UblSS7HGDRVDvn5e+pwdA9RGEGk+dYNE/NyfQK2nc9+UnGhvLsEzg40q0ReEcOH8JM
         3JqFXIBgFl/Z2YUAHARGiDKbRa2ZrbtLYFtwEbFHDSe7hJXq+kVIzl87GnHzHrGHQOtr
         KIMyArU9vN/X4kMqY2g1VzfntRpe+5o3UjwLvzCLM3YqBzlL1fKAsIv+EV/djnUU8gqF
         XszNwbklJUIHswAtWECfOJMBDOEro0ia3kvcinNAWi1J9ozplljejNCjwxo907exy/j3
         5uqiyuwKz53GWNWS7oilz6tAUg4iNRinM+hOrDcfOJU/4Oi7hThyb9IGzAP5cppTQAFd
         0Vng==
X-Forwarded-Encrypted: i=1; AFNElJ/wF88to7M8FFKPA+ys7CUe6IetcsAxLWuERR2v2OZhMT8MOafTcFhyDFjASTCv//GoZlq3346zmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKlZ95INURdNVDDIr6eDVCBQO05Rqlp9Nz3f/qkToussYF5NN
	Nis5q9xWCwgol2TGeAEoOzPU+jBMrN+MLbFy7DZf/sUDyPbVSzOmpO6uVTu6JIQmk4Ulu9hmW2m
	75Zbi//rEfbQlxa7lTuwsz4lRgflChYixrJPnhgGE2IZdD9WSSPs3U/sI8kU7Sw==
X-Gm-Gg: Acq92OEGF1K1ZTEG5cJQVvFETegdsuR/dPXiZd+78nwMlbpbiwtj28qmiEYlxsd6uun
	XG73PBTKj/Bj++Gxr+dxGHYVtZ1Y3IQ95/C0YsCPBM600gNuILvYFDmbLbEtAoV5E3D7YbxwJM3
	wTCY+6VtssEhVeN00RCDmfT+F6zTbhtFkN8fLTU1z+Yh5XKWwFi1mlighPWECSPz1qoJITuA1y2
	5q9mySaeAwKfULjsoNVmjw0fo0dyAqDJUPlUo72jl9gdFbKDHOwiVEXPKlb0Jx/ZOEcuNv3yJDw
	2YjSqM6E4XiM8pR4d87jEoJUYHEGW4seeQ4P6X+arics/mH2x/rlqpa43Ng7qVSVxa51pt6yYlx
	SSFc+iB8b8PEn7MFzTZohXfr7vASaDb55OYmqPisiKB9Nedolqb6SnUTKe+wn+wKHjNhkLZQrx3
	4iSZv2OLfC4yFMgsmz1scAAlaaqmBUlkUY60w=
X-Received: by 2002:a05:622a:24b:b0:517:7d9a:a88 with SMTP id d75a77b69052e-517fe4edb35mr20865721cf.37.1781249886109;
        Fri, 12 Jun 2026 00:38:06 -0700 (PDT)
X-Received: by 2002:a05:622a:24b:b0:517:7d9a:a88 with SMTP id d75a77b69052e-517fe4edb35mr20865481cf.37.1781249885707;
        Fri, 12 Jun 2026 00:38:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a7283sm302576e87.39.2026.06.12.00.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:38:03 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:38:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: Re: [PATCH v4 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP
 and MPSS on EVK boards
Message-ID: <po2gqpbmqw2tnkjn45ywgnsiaz2tpsprr5yowe3lw4y2lxk5ga@m52i77h5ymu4>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2OCBTYWx0ZWRfXx0oJ8K/anRzl
 1J4O/CKcpSziWQuekwoL04ekGed35H9w+Qzj1+nVHcpJs9Z+0LybzZxOht6M7YsEmKRmBhZmMyy
 WkECTjz14m7dkb0y40DH/p0kIRcyY4eNhCELCsanIH1ii33VPyzdvNNaHLOf1nPAYXFTR3Up7bN
 NwOi4m5PYA5FTHZ0EgJ/ZXw22u5RYVWtU8HSq9sxC1ldDnDXCAiTj+LiccWnN83u26RqKYNQZW7
 V2EJl1mOXfueIOA5w425v4tYkF52bgojBUSFfSFmwl109DihDzY2GThbgAR4buJQtxtonD/GvKY
 +aRQMakYTLHefTE43hghg+bdH8aCLqJ/TPhWJ+J/90Zv72AU+EEpQGEio8jmhCoEbB/keWF8QYa
 npbQhecB7XRR+TV6a3bT2YrowICkqfdFH/hTfucJ7hAE6Gjefnm9BkRi0A4bwomzbqOdqkq5co2
 10ExUKJoeqXN43ELomQ==
X-Authority-Analysis: v=2.4 cv=LNpWhpW9 c=1 sm=1 tr=0 ts=6a2bb75f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=2wNq6JH_cIzNK18R0_EA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: ER4Ozhc4bZNH_MeqtpNY6PDwFh9_38cx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2OCBTYWx0ZWRfX1kdNtaQ29mvl
 fWxthN648voXHgW9/Hoc44niOqcVDwNJxMgKbfK7eq4e4m8RnndaKl/ukR/dbEyVUc4j6wxZk7C
 rUeDk/E/lPZPCHxpfpZX3m6OWby+pmE=
X-Proofpoint-GUID: ER4Ozhc4bZNH_MeqtpNY6PDwFh9_38cx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120068

On Mon, Jun 08, 2026 at 06:40:28PM +0530, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
> IQS EVK board.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
>  3 files changed, 57 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
