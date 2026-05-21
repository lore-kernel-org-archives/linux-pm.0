Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3933ADB3
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406479; cv=none; b=X6i85ce5/BuWgV+oDT6WDhBJOdaPqUlYVQZ+d5ahcG0VpjO09lry7R179C+PzldjnbA9nr/MlWRLFt9TbfkEKgskSqFSv8FgHfnyLybV8n9Quz/0Y6zsUIHHjnk4j6x2uqFUjTgFtNyag6zhPNOH4zvGycYm4EVBYX+p6U4NzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406479; c=relaxed/simple;
	bh=qbgaf1n68DHq/ELd4w9KpIi8F5a8IXtU26iY8qjPv+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADhQIkZPfuw//i1PqnzjViPX1VTvHjUABg6yah59AocGhhYVO+fMWNTW0/qrzqPAg0yYWkDgz2Qdx8IT3MIXXKxa1vDDRWqwCoZYB55wLUzx2OqvUG1Dl8N0m9tNQtRxVXqOYgWeEVqK2N9LkyNdfMY9pIPNSh19TbFQOuCWqTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bw0IrQcu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FASdOSfO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bw0IrQcu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FASdOSfO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGkCqD1556848
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 23:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rs2uyQSF1oPVMVFPdQ925UWlTzbTR3sEuXIcmBLGD7w=; b=bw0IrQcum001/hsw
	TnifcMrpE8M0m/xhzScjbFu4FLrpb6opcg4DWfU6lAHYeJ72l5oDCXHgWOI6hg8u
	0IdFeDcVVD0Lxkjm+wRKvs52cNIwohZ+IXA//8gFs8R93Av85ouweaqvC2iUlLQm
	whcVdLyE7HWfmDwYdRTUhnt2RUzJ5JTRY1rKTzG12x1vE/6Ejeox0/wBqTjRR5ms
	58EiMCE753r9BA8O6+KVrRWWxji6z/bIixR2WojpXTQ/4patx2pE7ehgqs6XA/VY
	lR0foj6k4/AA0znZvYVS7tUCJCbkuSe2BskJ6c7QGffRCerwrR1/+Dx4chU3MQ3F
	NZX+3w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa4vxp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 23:34:37 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9569b029e1cso3626382241.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 16:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779406476; x=1780011276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rs2uyQSF1oPVMVFPdQ925UWlTzbTR3sEuXIcmBLGD7w=;
        b=FASdOSfOdG7be9XaMNXJVhEpW+ymWd9S3D2dS1SDQs3iz6ZWbCqhybeAoNRo9os14Q
         abbhzKEXlBX2FzqIaVXCmTyYNn+tbhNj+4fjd5X6ZDKokqiZ73tjTphwgFl+CbjwkSm6
         AdY25J0Iu0K6fKmbtc3ud5QH5hSw4GdbV0AA1qicQrgbg+9EX++fb1CYqolMUwhYtzJg
         +D/eql82GjwVbN4gmxC3RALvaQeSizRLsNkn22NTe8En6pmOKt+eT8Vymb3ToJh34Dcx
         fWpVc+noBkDqRb572XESHBvreUIUYNOEgt5ww2vW5lDMaOnO2W/Roy5CQU4Uj+diwl3I
         a5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406476; x=1780011276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs2uyQSF1oPVMVFPdQ925UWlTzbTR3sEuXIcmBLGD7w=;
        b=AljU1Dltl3yiENXxtBgk4ppMRpj5pK3zt6UZu+HmoQlYzkt75rGag1XJprEuf9+7M3
         cslxMnAZBDU1RsC3MDjtPhlZi14r0eUKPjKOL8b9lpUZrtK8i/X8hLLfnw8wG47veI1r
         S5QYhm9LsgcVR9Pw10a6VX4SiNh0ChP6zjkW6bm6EcXmqQfKLUCrbp/v2Mmnsg9zCjRd
         3uQgMMN1U1pI/VjfYRJFvAymIONQfI/bZCl7jkgjUxJNaKd/4ahpJvQQkxnQkDq+XAWD
         nJCyVlJkwL/VdXgHssSjHVEfCET+HBf0Ag880H4yjB4ZUlU4iSdQ75NTV+hJIAw0wx+v
         Gcpw==
X-Forwarded-Encrypted: i=1; AFNElJ8SbMyaDlfMz6zkRsBxjHw09J3rFnVgiP/wWw7RbyfsbsomywM9fjZPiu8ht60fLnPUTIQXFxqCuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwNcUykEPHFTKq2y4EzBdlLFNYiQ6fQX/4jXWA3rVegrdhNO5
	aIaAcUiudSiJiT6/LSa6/IwPQ1kBQjBi5HcppKiMq/FEhNf17cVv2XdUUwDR6+F392S7C8CSvXn
	cZL1NzUeLvVEG28yJXv0L2XCVIIHbayIz5IQVs9/qLulR1w1wV27DtIiwGYquQtyWvf8yAw==
X-Gm-Gg: Acq92OH0cuNubyQoCkisRBtZi5yFBGfxr4IfvOsaGBP3WIArILvLnJWuW5PzEDi4OsB
	x6nMeJ9yuryg/fB+jSaOfa2o0pdX1dBZI475zsXPO59xemgSngQR4PkZ6trazVauYREcELT3WDC
	Z1rQnna1XN8D4USxUjr84JnYYMd7hfwLEvGDdbOArNSZNFG4CsfCUw5eLAOY6JtrPOs8xy0ZIGN
	hA7GmC5tZ3QRPiSep5//tl3mqvmDBV5MY6Uc+cDD+Swa5rWFr1JLR9ast8yNqs8sasGlYlIFWE1
	m/WlYffJKz78VBxRCqMrMXTqISlc+TnkbxTVeEFjuXr2fJCBawhcwaB0bPyXduxdUw5n2VwH6vT
	iJyVrsqDvmgrnn3vsBJ+pABNxSQHLWRkwL29RVVtu8Qry6ou3HdscJ4oWopdVUJRXazrlEprOwW
	RZHE4K8FgATj/qNh4zBkv5X7GX3Dxw9BPC+KQhsxPTpfXmPw==
X-Received: by 2002:a05:6102:3046:b0:631:487a:23ab with SMTP id ada2fe7eead31-67c7151ace8mr672975137.5.1779406476024;
        Thu, 21 May 2026 16:34:36 -0700 (PDT)
X-Received: by 2002:a05:6102:3046:b0:631:487a:23ab with SMTP id ada2fe7eead31-67c7151ace8mr672954137.5.1779406475625;
        Thu, 21 May 2026 16:34:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa328721bbsm74863e87.50.2026.05.21.16.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:34:33 -0700 (PDT)
Date: Fri, 22 May 2026 02:34:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, jishnu.prakash@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: pmic-glink: Document
 batteryless property
Message-ID: <bsrozsgwneuzbwaz7r4elv43pk3zuprziosnok4kpsvo4fgwtu@oq36cnmsyrka>
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
 <20260518-add_dc_in_support-v1-1-31fbaa329879@oss.qualcomm.com>
 <fd58d6d7-26cf-4b11-82ad-05b4863b6dd1@kernel.org>
 <20260519082526.odmn5dqi2jftwnln@hu-kotarake-hyd.qualcomm.com>
 <20260519-first-wine-bulldog-a6a4c7@quoll>
 <20260521071341.q4efqssppvettaey@hu-kamalw-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521071341.q4efqssppvettaey@hu-kamalw-hyd.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIzNiBTYWx0ZWRfX//Kokvittth5
 TOX9GaqDxXrQlRhvr4xUrupMv3ajLIxRIXuS63R1CY8Ay9j77CpEw8q7NUge1Hy5XmMyskgjVY6
 ME5vI6K1JV5bazUODrGe1/ltDIbf0hzEY0yFYp33IrbsLC6p1u/IP2l+RFDucPTTWncNVrA1TlN
 U40qUv/DaRfR1Dwo+id2L2GwAlI4SyDjYIQOXYO6ixTfCNiq2Oq33v5Vg6Js8d/5k+Ioe2IFWta
 Fm22ZWWQH9YSWkdkpwrBqMC8CZSYWgCL5eOmyddS2/hgULrzikykm+hrSjeGimpebJ5EhithXTT
 Mh6XMBkvVeCp8Mi3nlVRBMCuBkOgMcI+vO/vAq+xHwgZzI4hF+r6/rZsclFny/ScjaezwPekRpp
 83FJhimgONRH25EYX0zXVVtqAnrFRRzBKTJCx2479CvnjPKUglTm53cLnb8gmKhrVzZrHnFSQuL
 vqqWYZ3nTxQnWz/tp+Q==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0f968d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=aZZmYXB-Xrw4pg2EUBEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: ZBV803eUe5uj-C8vEypW9VSioyva4OM-
X-Proofpoint-GUID: ZBV803eUe5uj-C8vEypW9VSioyva4OM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210236

On Thu, May 21, 2026 at 12:43:41PM +0530, Kamal Wadhwa wrote:
> On Tue, May 19, 2026 at 12:35:13PM +0200, Krzysztof Kozlowski wrote:
> > On Tue, May 19, 2026 at 01:55:26PM +0530, Rakesh Kota wrote:
> > > 
> > > > And isn't lack of monitored battery property enough to indicate that?
> > > 
> > > Regarding monitored-battery — its absence alone isn't sufficient. The
> > > BATT_ID line on debug boards is pulled to ~10kΩ, which is used during
> > > development phase where some battery properties are still present. The
> > > same ~10kΩ value is also used on some genuinely battery-less production
> > > platforms where no battery properties exist, making auto-detection
> > > unreliable. Hence the need for an explicit DT property to identify
> > > hardware platforms where no battery populated. 
> > 
> > I don't understand this logic. So you claim you have debug boards which
> > do not have battery, but define monitored-battery? Then these are wrong
> > and fix them first.
> 
> Actually our firmware treats the debug board as a "fake battery" rather then
> a "no-battery" case.
> 
> This is done to avoid triggering shutdown or trigger power/thermal related
> mitigations to kick in from the HLOS (android) that is configured mainly for
> battery-backed devices.
> 
> Note that we can know if its a debug board, just by looking at the battery
> ID resistance or the battery profile name in the power supply properties
> for `qcom-battmgr-bat` in sysfs.
> 
> However, the problem started with the boards that are battery-less and
> unfortunetely used the same debug board batt ID resistance value, so from
> the firmware side the batteryless board is also seen same as a board with
> debug-board connected.

Which devices are using this resistance value? Can this be fixed by
resoldering the devices? Can we fix this by pushing this property into
the adsp_dtb.mbn and then using it for those affected devices only?

> Since firmware does not have a way to dynamically tell if it on a
> debug-board powered device or a DCIN powered device, We are required to
> add this new DT property.

No, you are not. It's just a solution that you are proposing. One of a
plenty. Please start by describing the problem:

Device BigVendor some-EVK v1.23 has a hardware flow, the soldered in
resistance makes ADSP firmware emulate a fake battery rather than
completely ignoring the battery when reporting PSY properties. This is
confusing for the users of that EVK, which are assumed to be not able to
resolder 0203-size resistance, etc.

-- 
With best wishes
Dmitry
