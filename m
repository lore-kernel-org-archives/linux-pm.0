Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D13F6C32
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532694; cv=none; b=tgxgq08JE1dSC7BLD5wzh3q0uAeunIYwGADIj16J6OPU9TnIAbllPulUIRJa5OsJqVlc8bFEnr9qYVnqpH1AlrN0obbKif4ih0Og+eOIyAdA+VTFEkWdpnLBhInJZMWmxtTb81sYG+2d4FUwcppblWnVaRJ1kXv+xF2nzpZ0dXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532694; c=relaxed/simple;
	bh=skvGd6YlvxaIuF4YmVpLO7yCWWrcpj4DtUxM11rryI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR5SaVL7GRlLxJn8cBUH9n+gMMT1+MCJJrktteKk6eqpsiGu8oLKzoPVrPFSa65iL2FECGhi8YLp+TwuxxyYrNNiCv3wLj7LJkKIZ48Riim9ucigT9xMn8AP93oHyREBvWZmR8BH5JBMtVSP+HrFpa41uyFKtc1dz/2cWP+qCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n13Wqe40; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ICQnQbKw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n13Wqe40";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ICQnQbKw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZjHe589904
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 14:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c9Ck0QD4Q7uF2y8iLxRHBejsWgQqF6dlYb0G+SA4o3w=; b=n13Wqe40NpJaY/ak
	DTxNJZqoge5BrEQkmweaAdchXrI4wNUyx0n80JFGavfuM8wYbx0dCQC2chxiaP0B
	fTUw7WhF7akYhF5wvtrt5a/pBoQoOHJFGaeF8MY7HvT7lKxb7g0vpCHdCq7T801E
	dt1ELbfU/P5dZhrlwZ3pak4ZvdmaP2VeYGUwvvzrYfkNyuiKJliXUG4nwiAYUlW1
	/q0LGfQMTyLWUPq4YitnF1WtQRz4C9KDS8ZuxiQ7njRp/yqHqBSwV5IGLPPEadr2
	3gYS7lci11+thh4+nzIwUI9stmeptYrvEIgUPMUYNH06wfRavxQrO8lpEGv9OHM9
	OjHpSg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2c9jvf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 14:11:32 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6db540d17so5986315a34.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781532691; x=1782137491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c9Ck0QD4Q7uF2y8iLxRHBejsWgQqF6dlYb0G+SA4o3w=;
        b=ICQnQbKwCJVn7YFpVZYwasylS/81A/SZ4hIqgzsuQxZ929ap4SzQAWTiztaG5/lNlL
         LyvcjbyVSSf6Us+OI2IlbDnqnc/yUlAGxVgP9bnROT/OtCluwgSPJSnmN/ASGugN6wn0
         Yg3eb+stpFIn7V4jPWttfhbQmQDsZjImu5EUxBwlhBWxN7XED4SFxkMpXCpq+04E6LZh
         H0VpFu/QrwH9PSdVrI/x4z/YSMe5FFNRDin5x82R5rUB/YVFt582bde6YZmmLw0Gpzw0
         A039z5qgPkgjkfCGkOeolgSjnf1PC74aJzhtWzFTmX7Hjptq1/tkgqpAer+yvTUmz2jx
         MqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532691; x=1782137491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Ck0QD4Q7uF2y8iLxRHBejsWgQqF6dlYb0G+SA4o3w=;
        b=szxf5Coo2qMCcbRnZKiCohp4cDEPDsLKpnl77hIR5BDrCQQ8cQDD7g9XQ8hTWcxxo9
         0s9TxGHDX/btdSzfJaPtHNY5MgbAS4IiejK+sc7g57O9/3Ic4KiEW1/5TQnQ3QG4AdIP
         NCe+NBJak4z0Zu2Gv5LvE15Fh1wXH3kfrzNjpfYi1+y+Ca8L6rUN3s76MtAFv57VbihN
         6wBH7Evf4E/AbkhskT5HFWRC+BF+1tfx/L/TsJzMDjyQHXlCojTxb/jN+9ZipsR2vhJt
         Aitjv+xBv/o9rSDGENYrkQj3NGJl0fH4ugB4HWYvp1i2b1hhkFZv0EDj3HC+1OpDDNCH
         8VQA==
X-Forwarded-Encrypted: i=1; AFNElJ9EVDh22exB4ZjL2E7xwRK5QdfeM1Xa7wcuzQzuukg8URK1JKBlYpmDtyP2TrmWf1F3B6fwLP/ALA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBmXOcuScb+EOtp0kShTJBcBnVuJwJmtXzQ605zw7Stbiz/hq
	UWQM43LAvUQXcFnh+lTo8IXn80ebaA5Xv9930/8ZzVMLaI/3y6C5C3l6EzlcKwZgxsGAYzdGXkX
	IIr30OzpHnM0H4nQy2KFP4+rD8A7tEZqsir3M75LjGvSEN0SJ688XsaBPj+tC5wE3TsyNRg==
X-Gm-Gg: Acq92OHDAoLpTS/s/ZOer0dC70N8hRFSXH+RlNduT7afRhkWNIV7fKHiAoQF3dDSAmj
	B0hfyZScLJKTenfQJ+tzSoB9h+IbKdxj/klCY9AFMSgweFlMJpqTS6PRF/znnRjGsJMS7dHCeuq
	I/pcu0QKWVZ2GwKfzRPmN0JANaP2RnUOsrFBkATNqN95k23uBdJc/SIQtrkY7T27uigKGo74xAk
	KoPEfITZex2dPAOylg4BvIof4hewV5FeZ7DIhFfepkbV1k/oO4jryefpg10bee5CvuaZxA9L/ed
	xqQuP1xaoXb1FqgLyVEB3QxTXs61J2/I3cmU2wS6kYnzpUoa7xE4C2EIYKjw8ijspqXos017XPz
	51I0lTlusjwFf1cwHKBa0JcSE4ymDpmJT0FERV9Km+c3MXQzeUVtPGvGTG5cads62CW2DNNBbAz
	Ao8G9pR0+GHWBwCeSwtgzyZuxKv+/dO+ccpQY=
X-Received: by 2002:a05:6820:f021:b0:69e:3d6d:3757 with SMTP id 006d021491bc7-69eec9b0ecbmr6711434eaf.55.1781532691487;
        Mon, 15 Jun 2026 07:11:31 -0700 (PDT)
X-Received: by 2002:a05:6820:f021:b0:69e:3d6d:3757 with SMTP id 006d021491bc7-69eec9b0ecbmr6711408eaf.55.1781532691009;
        Mon, 15 Jun 2026 07:11:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1bb12csm2806235e87.84.2026.06.15.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:11:28 -0700 (PDT)
Date: Mon, 15 Jun 2026 17:11:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
Message-ID: <hebyboondtxyyetwuwggoiysurz335xzn7asf6yit3qrexap3x@kngk2m5xum3x>
References: <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
 <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE0OSBTYWx0ZWRfXwtb3MIAzqlwe
 b+cn5OBueVTUyC3Hw5xgUlfDuX4FLe1Tt0yGEONRQDRVw+WPKtC/kWuxNV/DrEE8VRqX6uGCwlT
 o04MV7h1vT2WE5nMoRYTsiwbknKDLB2q0Edva+3x49hfiGwrRiW2lvdMiVEgc87lqTYAVfKftFv
 UB3Zkyt81ynp0yFkblMAxdS+Q8/r1f0gkcWnIhm+u+OY7Rzd45h9zfcnypxdIAZ/yOS0RIQAHMe
 kyzl1pUbpZEMeILoMI33VgXKMb4A0ih1WfgiNuwPa3iY/twbxA9ehuQIRa1hfoRVghQNXauuL3S
 +3Im5qwybxjldZ15l7F14XdoZLKCDqBkU0jmpGjpveIXlaLB9PJkVcbwHgxSNqDApbO9xYgVRoR
 4etuETfzW1GmQsuYiWjSbtXVG4GnEW6X/LWgySzlJ2rDFV8gqavZhrTNRPfl83lAAJQ8GdSz3SV
 SnDo1BlbxUvaC/1Yxqg==
X-Proofpoint-ORIG-GUID: QwMWegJcbFQuXGwXxXN1SNoVCBUB0B5O
X-Proofpoint-GUID: QwMWegJcbFQuXGwXxXN1SNoVCBUB0B5O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE0OSBTYWx0ZWRfX0UvEaRKl9/Xm
 V+X0IebS5mUP62653j2SPcymFvbvb8es5DUiC907AOLMkD9l4B4C12qndZB6wK/pxyragprBat9
 A20UqYqzs8CYLq4M1qw4YLNYoZ4rhBw=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a300814 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=f6XOEFucdkFPB0-045EA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150149

On Mon, Jun 15, 2026 at 02:30:49PM +0200, Daniel Lezcano wrote:
> Hi Gaurav,
> 
> Le 15/06/2026 à 14:12, Gaurav Kohli a écrit :
> > 
> > 
> > On 6/15/2026 4:04 PM, Daniel Lezcano wrote:
> > > On 6/13/26 13:05, Gaurav Kohli wrote:
> > > > 
> > > > 
> > > > On 6/13/2026 1:11 PM, Krzysztof Kozlowski wrote:
> > > > > On 12/06/2026 15:52, Gaurav Kohli wrote:
> > > > > > 
> > > > > > 
> > > > > > On 6/11/2026 5:53 PM, Krzysztof Kozlowski wrote:
> > > > > > > On 11/06/2026 13:12, Gaurav Kohli wrote:
> > > > > > > > > Why? And where is this generic property defined? You cannot just
> > > > > > > > > sprinkle generic properties in random bindings.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Ack, will add why part.
> > > > > > > > These names are matched with the thermal
> > > > > > > > mitigation device identifiers
> > > > > > > > populated by remote firmware over QMI and define
> > > > > > > > mitigation devices are
> > > > > > > > exposed as cooling devices.
> > > > > > > 
> > > > > > > No, -names correspond to values passed via DT, not
> > > > > > > some remote firmware.
> > > > > > > The remote firmware should give you interface which
> > > > > > > is explicit and does
> > > > > > > not need such properties.
> > > > > > 
> > > > > > thanks Krzysztof for review, We need tmd-names because
> > > > > > of following reasons:
> > > > > > 
> > > > > > Following Daniel's series [1], the thermal framework supports
> > > > > > mapping multiple cooling devices per remoteproc/device via indexed
> > > > > > cooling-cells.
> > > > > > 
> > > > > > 1) The thermal framework's cooling-maps reference
> > > > > > cooling devices by index (for #cooling-cells = <3>).
> > > > > > Without tmd- names,
> > > > > > there's no way to know which index corresponds to which
> > > > > > TMD, as firmware
> > > > > > may return tmd-names in any order.
> > > > > > 
> > > > > > below are the changes post new thermal mapping changes:
> > > > > > DT: tmd-names = "cdsp_sw", "xyz";
> > > > > > Firmware: ["cdsp_sw", "xyz1", "xyz2",]
> > > > > > Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)
> > > > > 
> > > > > names property are not to instruct drivers to register or not to
> > > > > register something.
> > > > > 
> > > > > I don't understand the problem and explanation in the binding is
> > > > > basically non-existing.
> > > > > 
> > > > > Remember that all lists and indices ARE FIXED, so driver knows exactly
> > > > > which index means what.
> > > > > 
> > > > 
> > > > thanks for review, shall i use driver data, which is basically
> > > > pas data structure like below:
> > > > 
> > > > static const struct qcom_pas_data {
> > > >      .crash_reason_smem = 601,
> > > >      .firmware_name = "cdsp.mdt",
> > > >      .tmd_names = (const char *[]){"xyz", NULL},
> > > >      .num_tmds = 1,
> > > > 
> > > > Is something like above acceptable? and this will also help to
> > > > filter tmd names as well?
> > > 
> > > 
> > > How the thermal framework will bind the thermal zone with the TMD ?
> > > (node pointer, id) ?
> > > 
> > 
> > Hi Daniel,
> > 
> > thanks for review.
> > 
> > With id only, in this case instead of taking tmd names from device tree,
> > qmi_tmd will take tmd name from pas_data(driver) and register with the
> > cooling framework with id only. Please let us know if this looks fine.
> May be I'm missing something but:
> 
>  - The QMI TMD returns a list of names, not ids
>  - The QMI TMD may return the list in different order than assumed
>  - The cooling map index points to the name of the TMD in the DT
>  - This name is used to match the name in the aformentionned list
>  - The index in the list and the id in the DT can differ

Would it be better if we define standard indices for the standard names?
This way we decouple the actual firmware strings from the DT.

> Krzysztof , I don't get why having the TMD names as properties is wrong,
> they describes the existing TMDs on the system and the cooling maps index
> points to the one to be connected with thermal zone.

-- 
With best wishes
Dmitry
