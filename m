Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8B381AFF
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583918; cv=none; b=N5KYxJA+taXOzOrWCGDtVs9IUJtmXEHek8ICS3aQlgiwO+G5wTLkzxW/k/v+rcJNu7qCkYJmquATjZ5CBXFvka0BfZr4R0z026Q7Q142WRqykGnDC3W0BIrDS2v3ElzZUcKUbJMrx4Lo9EbDrFo2tJqqbiDMBa6fMjhkXZCM1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583918; c=relaxed/simple;
	bh=CRMMeKMYr/uFkbFihLtIDhSkzHmLcV1nUBdzd1/G2T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5LbC/XcPcRo0fDaiK2Bc5JQs5EQCUsbYOilFYZArFsSO6LOT14BsRghpvYrNOJyRTZCPRm7OK4+PQMmFnM02Q2aVHE0MUIEIYk5BFBnMOgfbfpTc9bkbawASOxs6c8Wft/fNprPFGR0NSgnAcZ3uP2HrQSj4CeFBa9BCB4Ax/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UQpqkWK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MArVtA5i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UQpqkWK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MArVtA5i"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960G37887939
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 07:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6wdOtbgBM/5Qv1dBByCOfeS0K8UvhwHlRKLvCJbRTSQ=; b=UQpqkWK8LYeS2fez
	0r0MQIMp2KhwUUdw6mBqJ3xpU5R50LgaOAAXL4Q9+cWoSeBRvS6UytRQkPQC1GP/
	e1p10P+I5qowIhEljqLRuK7q8BLF/TQsZqtrO89BfRB2sjB17/s2sNNp3WYiCPBv
	ocVOw8xZ8lG+uqoiA61R16GgwCmt2Fi7lms/Wqhmw0kuzcp6lDulXtIYgXe66le1
	Qi5RZWN1VbKuH4hBchk9Pk4MycGkzAhP5RMQzS3hcNRvSmiHKIKsXWXV80MqqOyN
	AeS+kwCMdFudC0cD51m39hnXZB7gHHO3llWb5tPSDCV/qpPTc4t3lB/6anc4cal9
	LQl0gQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq33dwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 07:58:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-744e7c36621so392700137.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783583915; x=1784188715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6wdOtbgBM/5Qv1dBByCOfeS0K8UvhwHlRKLvCJbRTSQ=;
        b=MArVtA5icLsumrMiJHcS0yEIPcLVtNNU5TLEXqRuNZX9oEHKGx5dij0slGvJPQvo4N
         7vE7izUXWhAK5tK4QFBYofg7Dt0MA5sYhY1oh2qqdMuHtJMbdr/lLOZ1Fd+o/DGAGXAP
         Yz+0qHpiFhZUBqn72T535ViaE3faqRAiH6uyg6IW1aY+YIwZ28+kp6zS4JTF9h5v7J+3
         KtXqpDGHGyEBL/OumBH36kexEJy9ndtub/nq00V3Vbtc/gxVQfJWpth8FORWExGcN6/B
         vxyB5JCHtWxNTNQUC1UNH1gJgKyWm1SiU9sX9aIhDndQaCCI0Q/KeHCOZxUOvgx2liEX
         no3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583915; x=1784188715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6wdOtbgBM/5Qv1dBByCOfeS0K8UvhwHlRKLvCJbRTSQ=;
        b=Sy9+/lDOYlZ+29nsPrXDtHWoJV5bEZPg+/WQpBDi+PdsoXkHKNGItvRPaazz/a+Ip2
         4yIvJQzrCTV1hJLmjI13G5Bli12WRQbJwGUYls5/pYKNmj+y4L9KIB/CfLxLEuX3AOxS
         Uv5i09VJblrnHSNtcl7uGxJ85+xTyrCBTWhGCVsAF9egiYs0A52+GNIibBVJ/KfshWi3
         /pWO7G333Bwr8Wb1MWRPSRi71N7IDrahQg/el0/IIHmaeV7NoihsuDPuvCmXuDtMD43t
         wROEcw1s9sqSqsMmxruJVC8gpekxrQfBJwS+z7qsVtPkb6bBVQoE/MEwCV51NAM/CNb1
         gOzw==
X-Forwarded-Encrypted: i=1; AHgh+RquLSRQWfdZW7ZPEAxq4yc8VhWUYQ9h6+hVRlgIVoxsgZ5kuuF/Aqmygeib9RxZ1S/cMMIVRzyqaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOJY606bLLYs+XM7wZ0nOdeChJHuWd9i4ztutYNkBom2cjF/S
	PVzMdbTw6h104G/i7lSMDvzQq885mGQpwZx3RJU4kLFCWn3YUiFg81nX2kDPTi9fdcMcelt8eDj
	RtPf5cPuoOKPWzIydMVLWxksAEgMuhrE6SA+3Yl0IkJwqZ0S75ZvqiZle8YcwBw==
X-Gm-Gg: AfdE7cko4+XG9IP+5Gk3NVADUvOxjlv5fYpWQeVd4Q8ogwUEVpy98P7pU0qA0RzLPsr
	hu8ZFMfQo6574WUabJ5XV64Kv/e3r+tedtRlkNsjMNZpEmdZd3ujRnAMU632Q6flQKbvs6ch7tA
	EX+yEXvMDa7gzuxJS4G2tA38v7PFaj2Nw6faGgr6A6pSwxkMTCUWvBFHehVzje/ggmTVM/psoY3
	xU7GdkmVQi7sgPHEV8XfBHTqGADzCRh1yeDtc8sKhEbzFc6pL3HbcKmabezr0O09/mr7DDoMrCT
	tT81B4+zqKTbHzE6OvsySsXzb/HBiws7sSft85QV2oF1aFEo2n5QEtJEFRrGXOu4OiK+/+XOsSE
	hsW2abO4ICVRfJXKXPJflYZ07z3ek8t/Y2LkfmERsDuXbh++MuNW8/HVA73nHcdvTm5CZ1s2ESr
	ckMsNWHLv42jXgiSFYqSLGP5p0
X-Received: by 2002:a05:6102:c0f:b0:739:626d:4473 with SMTP id ada2fe7eead31-744dfbf230bmr3721756137.0.1783583915224;
        Thu, 09 Jul 2026 00:58:35 -0700 (PDT)
X-Received: by 2002:a05:6102:c0f:b0:739:626d:4473 with SMTP id ada2fe7eead31-744dfbf230bmr3721735137.0.1783583914774;
        Thu, 09 Jul 2026 00:58:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b007f68765sm2199158e87.10.2026.07.09.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:58:33 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:58:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD
 device type constants
Message-ID: <d7dqqj3qctbqdani5frdwpooppo2sq5odru6s4hxoj6d42sihb@fad3nuhunazt>
References: <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
 <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
 <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
 <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
 <e7eho7ezujbrdzgumshapf2r7hu2jaujib7lvotrqvcj5er5ut@xpd6l2kgipqu>
 <9dc4b29e-e9fb-421a-b789-eb16a68ff915@oss.qualcomm.com>
 <2tu35aavp7sc2npni33ky5bve57idzy3bzp2pk7eh5lryq3r4v@gmm3dhayu4cf>
 <6f179f96-fdd1-4fa9-b26c-df7372eb6d20@oss.qualcomm.com>
 <tq3g6lpb2go4nen3ferx7kzs5g6sshc45ayfyvhjmc3rv3jv7p@fhixqlwbtooa>
 <54250163-678f-41e7-97d0-6596123367f1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54250163-678f-41e7-97d0-6596123367f1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: SHvYG60gOjzux_nM1ZMUP1ZfgqtIAVtJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3NCBTYWx0ZWRfXxE/WwKhz3EVp
 Y2586o8mGfzgNYwy4Rjr/Pm51nG7P9g4taZP2CSt8uIFs8Co01SPRS83bobrDBL+moswfgzFZ3v
 OaJhmwqKYCMD506EJ65gDNt4cgwvALWFgUtA0vI1jAs5SvecsCSxxKtcKwUJxr7B3BXJBOoE3bZ
 FefjMUgFnB2+4hXgyLXeNhnJTOzTOTbC7AVEBHP+6u3eetcBd8uxofQfwX92nE3xJb+SQWdBXrL
 WxxZjQc4C3d8Y0PMrV0KpVM2HZ57SobI+ldJwBUE2T5Q/gut4hz8SprQqbSfUOQ+JxJfY564M9r
 ss8ZIlfg/m5++2hrXjohH8kuTxlNOToTtC7mO+fGFf2bjTXeJB2R7lzWmRlJptytZh30Y48mvVd
 XOKHqt/wjGpLxF5J4pn2CaENqnmUM9ay6/1gan+fO/l71vvxvZEgQJw8i4AzzoEgWM74hu+tprP
 BGRLPN3bN0dZc0EsaBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3NCBTYWx0ZWRfX3ddPITX+viiP
 w9QPrG8i/AckqxSBbHdZ3XX44lapULVhE1uGgyS1b4CAusqIHN947gSHLq6NLONKzVU49+5azt7
 dzGOymwtvlEdXDVdDylfL4NRh9khMs4=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4f54ab cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=eKure5Gis9_f7ihs6EMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: SHvYG60gOjzux_nM1ZMUP1ZfgqtIAVtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090074

On Thu, Jul 09, 2026 at 09:42:04AM +0200, Daniel Lezcano wrote:
> 
> 
> Le 09/07/2026 à 09:37, Dmitry Baryshkov a écrit :
> > On Thu, Jul 09, 2026 at 10:54:26AM +0530, Gaurav Kohli wrote:
> > > 
> > > 
> > > On 7/8/2026 7:55 PM, Dmitry Baryshkov wrote:
> > > > On Tue, Jul 07, 2026 at 03:55:13PM +0530, Gaurav Kohli wrote:
> > > > > 
> > > > > 
> > > > > On 7/7/2026 1:04 AM, Dmitry Baryshkov wrote:
> > > > > > On Mon, Jul 06, 2026 at 08:11:35PM +0200, Daniel Lezcano wrote:
> > > > > > > On 7/6/26 19:47, Dmitry Baryshkov wrote:
> > > > > > > > On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
> > > > > > > > > On 7/3/26 17:42, Dmitry Baryshkov wrote:
> > > > > > > > > > On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
> > > > > > > > > > > > On 7/3/26 7:03 AM, Gaurav Kohli wrote:
> > > > > > > > > > > > > Add Device Tree binding constants for Qualcomm Thermal Mitigation
> > > > > > > > > > > > > Device (TMD) types used by remoteproc-backed thermal cooling devices.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Qualcomm remote processors expose thermal mitigation endpoints
> > > > > > > > > > > > > through QMI. These endpoints can be registered with the thermal
> > > > > > > > > > > > > framework via the `#cooling-cells` property on the remoteproc node.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > The QMI TMD protocol identifies devices using string names (for example,
> > > > > > > > > > > > > "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
> > > > > > > > > > > > > `#cooling-cells = <3>` requires numeric device id in the form:
> > > > > > > > > > > > > 
> > > > > > > > > > > > >         <&phandle device_id min_state max_state>
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Define common TMD device index constants shared across currently
> > > > > > > > > > > > > supported platforms. If a future target requires a different mapping,
> > > > > > > > > > > > > additional target-specific constants can be introduced while preserving
> > > > > > > > > > > > > existing DT ABI.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > > > > > 
> > > > > > > [ ... ]
> > > > > > > 
> > > > > > > > > > Why are you using only those TMD devices?
> > > > > > > > > > 
> > > > > > > > > > > More constants can be added as needed.
> > > > > > > > > > 
> > > > > > > > > > Kodiak is one of the supported platforms.
> > > > > > > > > 
> > > > > > > > > What would be the benefit of having more than thirteen cooling devices
> > > > > > > > > declared in the thermal framework and having only a couple of them mapped in
> > > > > > > > > a thermal zone ?
> > > > > > > > > 
> > > > > > > > > I agree there are more TMDs but if they are unused for the moment, why do we
> > > > > > > > > need to add them ? Can we do that incrementally ?
> > > > > > > > 
> > > > > > > > That's what I am trying to understand: why the implementation uses only
> > > > > > > > the selected two devices, if the modem on Kodiak supports others. How
> > > > > > > > can we find out, which TMDs to use on other devices.
> > > > > > > 
> > > > > > > My understanding is that is an initial thermal setup. Gaurav will add them
> > > > > > > step by step while setting up all the thermal zones instead of sending a big
> > > > > > > patchset. And TBH, that will be much easier to review.
> > > > > > 
> > > > > > In such a case it should be noted in the commit message and/or cover
> > > > > > letter.
> > > > > 
> > > > > Thanks for the review/guidance. Not all TMD endpoints are relevant for
> > > > > kernel thermal zone binding — some like BCL and cold temperature are handled
> > > > > from userspace when needed. The constants here cover only
> > > > 
> > > > What if there is no userspace? Or the userspace is different from what
> > > > you expect? I doubt we have TMD-speaking userspace yet.
> > > 
> > > Thanks for mail, The TMD userspace implementation is available upstream at
> > > https://github.com/qualcomm/qmi-framework.
> > 
> > Is it?
> > 
> > lumag@rohan:/tmp/qmi-framework$ git grep -i tmd
> > lumag@rohan:/tmp/qmi-framework$
> > 
> > I found no traces of TMD there. Moreover, I don't see why QMI framework
> > implementation would react to thermal events.
> > 
> > > > > what is needed for modem and CDSP thermal zones on the currently posted
> > > > > targets.
> > > > 
> > > > Again, SLPI, ADSP?
> > > 
> > > Sorry, I should have said "generic subsystems" rather than listing specific
> > > ones. SLPI and ADSP do not require active thermal mitigation on these
> > > platforms.
> > 
> > Could you please provide details, then. What is cpuv_restriction_cold
> > TMD?
> 
> It warms up the zone when the temperature is too cold

So, if we ever get back to supporting warming up, these TMDs would
become relevant. Am I right?


-- 
With best wishes
Dmitry
