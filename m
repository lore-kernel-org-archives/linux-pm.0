Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6C43B6E1
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784674962; cv=none; b=J+1yldM8MAVSKysMEd7YID+Yz9Pu058hmyyah6lVThCCiRC585GghicfaSeVfX7D7FTWXZvnd0c7FO3z6A94lC67kA3t26ESheSEejUZi+bzQuK6+6HElRwzYN+9htitABI2K5+Z6fkeroHlWUhmICYxpXEn1QALgqd3AFPkMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784674962; c=relaxed/simple;
	bh=+q9SqglFxsF7E/f+oK+IdbC4W/RZaxGV62zp1jJm0U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nngxv5QZ1e8Ti/NKKYT8UvMvNkpQqv8AP7hdj/JMl9LgUPGn3wCMx6byVqnmfSdj548Tm9ShelhZs46cO4So7L6buoxffjvavA685bqeJZ/3qnWEyuq2KCdNuW4EuN+C+52BLverfMrqUgxFoVyy71/QhtT+9hPeocPB13oCZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NAZSj899; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d45LighI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NAZSj899";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d45LighI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LMZDNO3137018
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BVAVqrht2Onqrp5MZWV10fOY+/SgFVFdWpN2lE8H3C8=; b=NAZSj899a4Kt3OpS
	jH80OLf9QjeO2W/lAngczPHrwL+c+Zt/gbU/wioEi2mqCimSfuK/ydiZbseIrZwo
	vM5yFokraMct5OzVPPfNogcYwNRRlkVVxH9eUM8DATjd5NO1WWqwL+9R5jM9LXGc
	EKrHpv/xWifDCqTt3nixdl6mWBWCfgxRTDsLrsttkkotjTp0TlDCrOnrxWZQcH8+
	scTWOweYqfTLRyM774jrqxxGQ9W4dQvL1aDbyRhizcGIXjcqGDmzjd+xB855jbKK
	MtfYqCR/bDkpCkcKLsORpLnoyIrOEFHasFOVMoAsAsWpBNJvwb+hXlFkzonxge9Y
	3k4Clw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d16v9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:02:39 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-745031889b5so14222775137.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784674959; x=1785279759; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVAVqrht2Onqrp5MZWV10fOY+/SgFVFdWpN2lE8H3C8=;
        b=d45LighIslQnAJDrJgOJVGrqcdJE73Oi0JOMpLKdtoOO+/g92rKd14k7jD+wGf/+m3
         qEViotuQamA6q23tCr4XdV5n5ncc49lnTFjvbyw1mWz3/m1WMgps1qAzEpzbFe0O7/+j
         fzzjjmNzxEtKJKj7+D1zWxah6O1jH+Iw1y5oM6B+Z4HUDYPvdEKhudZs81AbnIMg10x1
         DB6CYTMsxy/FwKK7aRpwiAciGJc1G+euBLGNa+dCRpbsOXnqQc0kzJ11RQ3pHkF97XVu
         F3N9Y0kTG3NlKKz5R8tFDL9NvijlOTLUIgWMJOt0CjNwoZrXhlAA31skYYCiHQGVyYL0
         8Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784674959; x=1785279759;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BVAVqrht2Onqrp5MZWV10fOY+/SgFVFdWpN2lE8H3C8=;
        b=rFWtFjD/kf2x202dhaw7stVCdJeaLe7RX2vtvXFZifzJiL20RB7y9xDq39n2x2GeU+
         Y1DQqHF5Rt/ILbLK59ORoYiSrV8bbM0ZKZvV9PQyFv1oEHwYEK+f7ICHI58qCSePDpVk
         JEYvEd86VD6c2k4PiIFcdY4d1f4C3fzJum5rvIGpBigZersifvK3c1t3l3SULFNQDP5U
         lr0DY8M/2jF1ZicTwDbW8GjFyJ53Hx+svz1qWeBkL84UuqOUjyGhIXEQ5yG1HlTYEONy
         1BLFzQ0/dDLx+EqEtfB7c3QkOmALiqYeoaURn+ciTR0UYuC7LoHsYBnD2IbehdcnvthA
         gO5w==
X-Forwarded-Encrypted: i=1; AHgh+RqHtCJdrVOWUgZ3NUGEz6qDgxV4sn4FmdOG/REwz4DW6sw8zzC7Vl6iqju1QTebDAs7JnQzyOT95w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9X66X4sM+aiGmzQ7vIbP9O667RUaoZWqX8XfEIonp40zswBFC
	VWnhJJ7sph9cBKvPMketHoxxD+2AOfdbXRzQXk7pVTY+NCsAH4KS1ywEifBirLUXUTxWMAU6ONq
	rzwh5iqba9eTiA8H3zg+dICQqI1IUhTD5/PK23iNh0bYrUrTzfIkGLHDSofztfA==
X-Gm-Gg: AR+sD1228CVcA0HZlPG2OlK+NiKRIrn1gihRj1IhYZi2PgP+ZyPe9QvSafKQAvrjsik
	qBXC3olj5zt1BrWjMs7JdT0FsmJDFz+XNumUpK3g2+ZjKIDOZqVxnrkPC6mNGmZ4cWSMxNBF9vJ
	9DGotpRw1cl92FNm5ujcGqFlG9tNXFy29lIE6GIk8ieEmHwWMdWEUWCq72sJ7rrz+oueXXJAdPe
	b9J8MFWZeR+XCaF8HhkC1yK3qdpEc4rL7tXD9imtAKoEs/nr/VpfRSeF6AdnyIL6lXxfT9nbWOi
	xVJGPp7+YtiSj1heZusOAYbPCStJUCAJgHH9fGD/9lE0Qc+1a2EiR9fcu4z76qZrnjPLyJ5ddn3
	r55O2O7KpoAeIy4Us13FGgnND7fnM+65u8OjOQFokrnSL7zjcsqbZMflrUP2xeN9q/GElTK5O21
	2vpysEOoJbhEOB9w==
X-Received: by 2002:a05:6102:5788:b0:73e:9fae:584c with SMTP id ada2fe7eead31-7475368b91cmr6846587137.19.1784674958743;
        Tue, 21 Jul 2026 16:02:38 -0700 (PDT)
X-Received: by 2002:a05:6102:5788:b0:73e:9fae:584c with SMTP id ada2fe7eead31-7475368b91cmr6846495137.19.1784674956637;
        Tue, 21 Jul 2026 16:02:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9d316cesm156768e87.53.2026.07.21.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:02:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:02:33 +0300
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
Message-ID: <bn5ldgj4ehyj6nqpkn4thtm7basgww2b23dvpedy6eazcbcn6t@76ztskznun3e>
References: <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
 <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
 <e7eho7ezujbrdzgumshapf2r7hu2jaujib7lvotrqvcj5er5ut@xpd6l2kgipqu>
 <9dc4b29e-e9fb-421a-b789-eb16a68ff915@oss.qualcomm.com>
 <2tu35aavp7sc2npni33ky5bve57idzy3bzp2pk7eh5lryq3r4v@gmm3dhayu4cf>
 <6f179f96-fdd1-4fa9-b26c-df7372eb6d20@oss.qualcomm.com>
 <tq3g6lpb2go4nen3ferx7kzs5g6sshc45ayfyvhjmc3rv3jv7p@fhixqlwbtooa>
 <54250163-678f-41e7-97d0-6596123367f1@oss.qualcomm.com>
 <d7dqqj3qctbqdani5frdwpooppo2sq5odru6s4hxoj6d42sihb@fad3nuhunazt>
 <3b9f1b3d-4c06-4006-82d5-d59ce2101070@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b9f1b3d-4c06-4006-82d5-d59ce2101070@oss.qualcomm.com>
X-Proofpoint-GUID: 7ijxL633Yn58TDrPFAgdIVZa5GadpriQ
X-Proofpoint-ORIG-GUID: 7ijxL633Yn58TDrPFAgdIVZa5GadpriQ
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a5ffa8f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=SUYFn9tju61n4s2jINcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIzOCBTYWx0ZWRfX541Su/TeKtWZ
 QeOBLkAUkJG1Ec08KA+sJkhYuWlxOQXGV+mlIFeMcGBV2tOgXeIUFUZlzU5Dx3A5DlrqLDbHOqz
 aBK6SY6HzHa2o0P6ajbAetXZtBXKz4sEmkWa7l8nqZ4vBWzcu4aWgaN/PeW2vSy7f33DB4oeNoE
 R6wH+1qUanTLXEg3rEhJqjdBkNii02hUmsNIDl/hlF3CbRkifXeu/IkVLesFtHssx9qsw5bWnz6
 OF4rfwHQHSfDWdzbJSbTWmj5zGlApTL/PEA1xcRxBIefDHdG2UaRxeI5y6Q6jcq/K4UKos9Wtuc
 y/zbtuMc1xC27KOL9qnyiAhaM+yxvdB5y/4IDX/XJ9H7oTLUje8rwrsrrik24uhbOsuyZzAHtI6
 8ULq6vEGCB6JDtaS03J8DbQcd+2mzhXyuTgDfolFEz0G8On69qOZR5WM2ATWNl0oqm+xb3Qnla4
 rNX569V/aPkL2zZEgGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIzOCBTYWx0ZWRfXyAf39acOSQsr
 Pihm8Yhp4o0j7FLaeICjGe3k2hTWP9Ymihozde4Wbl34UpsObxBfLBbrz4e0pqQiu4PktgrobBF
 i1wMTSdwLrkgJpjCdn16MXKq72zX2yo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210238

On Thu, Jul 09, 2026 at 10:23:26AM +0200, Daniel Lezcano wrote:
> 
> 
> Le 09/07/2026 à 09:58, Dmitry Baryshkov a écrit :
> > On Thu, Jul 09, 2026 at 09:42:04AM +0200, Daniel Lezcano wrote:
> > > 
> > > 
> > > Le 09/07/2026 à 09:37, Dmitry Baryshkov a écrit :
> > > > On Thu, Jul 09, 2026 at 10:54:26AM +0530, Gaurav Kohli wrote:
> > > > > 
> > > > > 
> > > > > On 7/8/2026 7:55 PM, Dmitry Baryshkov wrote:
> > > > > > On Tue, Jul 07, 2026 at 03:55:13PM +0530, Gaurav Kohli wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 7/7/2026 1:04 AM, Dmitry Baryshkov wrote:
> > > > > > > > On Mon, Jul 06, 2026 at 08:11:35PM +0200, Daniel Lezcano wrote:
> > > > > > > > > On 7/6/26 19:47, Dmitry Baryshkov wrote:
> > > > > > > > > > On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
> > > > > > > > > > > On 7/3/26 17:42, Dmitry Baryshkov wrote:
> > > > > > > > > > > > On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
> > > > > > > > > > > > > 
> > > > > > > > > > > > > 
> > > > > > > > > > > > > On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
> > > > > > > > > > > > > > On 7/3/26 7:03 AM, Gaurav Kohli wrote:
> > > > > > > > > > > > > > > Add Device Tree binding constants for Qualcomm Thermal Mitigation
> > > > > > > > > > > > > > > Device (TMD) types used by remoteproc-backed thermal cooling devices.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Qualcomm remote processors expose thermal mitigation endpoints
> > > > > > > > > > > > > > > through QMI. These endpoints can be registered with the thermal
> > > > > > > > > > > > > > > framework via the `#cooling-cells` property on the remoteproc node.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > The QMI TMD protocol identifies devices using string names (for example,
> > > > > > > > > > > > > > > "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
> > > > > > > > > > > > > > > `#cooling-cells = <3>` requires numeric device id in the form:
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > >          <&phandle device_id min_state max_state>
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Define common TMD device index constants shared across currently
> > > > > > > > > > > > > > > supported platforms. If a future target requires a different mapping,
> > > > > > > > > > > > > > > additional target-specific constants can be introduced while preserving
> > > > > > > > > > > > > > > existing DT ABI.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > > > > > > > 
> > > > > > > > > [ ... ]
> > > > > > > > > 
> > > > > > > > > > > > Why are you using only those TMD devices?
> > > > > > > > > > > > 
> > > > > > > > > > > > > More constants can be added as needed.
> > > > > > > > > > > > 
> > > > > > > > > > > > Kodiak is one of the supported platforms.
> > > > > > > > > > > 
> > > > > > > > > > > What would be the benefit of having more than thirteen cooling devices
> > > > > > > > > > > declared in the thermal framework and having only a couple of them mapped in
> > > > > > > > > > > a thermal zone ?
> > > > > > > > > > > 
> > > > > > > > > > > I agree there are more TMDs but if they are unused for the moment, why do we
> > > > > > > > > > > need to add them ? Can we do that incrementally ?
> > > > > > > > > > 
> > > > > > > > > > That's what I am trying to understand: why the implementation uses only
> > > > > > > > > > the selected two devices, if the modem on Kodiak supports others. How
> > > > > > > > > > can we find out, which TMDs to use on other devices.
> > > > > > > > > 
> > > > > > > > > My understanding is that is an initial thermal setup. Gaurav will add them
> > > > > > > > > step by step while setting up all the thermal zones instead of sending a big
> > > > > > > > > patchset. And TBH, that will be much easier to review.
> > > > > > > > 
> > > > > > > > In such a case it should be noted in the commit message and/or cover
> > > > > > > > letter.
> > > > > > > 
> > > > > > > Thanks for the review/guidance. Not all TMD endpoints are relevant for
> > > > > > > kernel thermal zone binding — some like BCL and cold temperature are handled
> > > > > > > from userspace when needed. The constants here cover only
> > > > > > 
> > > > > > What if there is no userspace? Or the userspace is different from what
> > > > > > you expect? I doubt we have TMD-speaking userspace yet.
> > > > > 
> > > > > Thanks for mail, The TMD userspace implementation is available upstream at
> > > > > https://github.com/qualcomm/qmi-framework.
> > > > 
> > > > Is it?
> > > > 
> > > > lumag@rohan:/tmp/qmi-framework$ git grep -i tmd
> > > > lumag@rohan:/tmp/qmi-framework$
> > > > 
> > > > I found no traces of TMD there. Moreover, I don't see why QMI framework
> > > > implementation would react to thermal events.
> > > > 
> > > > > > > what is needed for modem and CDSP thermal zones on the currently posted
> > > > > > > targets.
> > > > > > 
> > > > > > Again, SLPI, ADSP?
> > > > > 
> > > > > Sorry, I should have said "generic subsystems" rather than listing specific
> > > > > ones. SLPI and ADSP do not require active thermal mitigation on these
> > > > > platforms.
> > > > 
> > > > Could you please provide details, then. What is cpuv_restriction_cold
> > > > TMD?
> > > 
> > > It warms up the zone when the temperature is too cold
> > 
> > So, if we ever get back to supporting warming up, these TMDs would
> > become relevant. Am I right?
> Probably
> 
> Can we do some progress with these TMDs definition ?
> 
> Spending 95% of the effort to discuss 1% of the proposed changes, which is
> always DT discussion, is quite frustrating :/
> 
> You want to add all defines for existing TMDs for all platforms ?
> 
> We are talking about numerical values right ? Why is it a problem to add
> their define later ?

I'm trying to solve a slightly different story. How does a developer,
looking at the list of the TMDs supported on their platform can decide,
which TMDs to add to the driver and which TMDs to ignore. Up to now I
haven't heard, how it was decided that e.g. cdsp_hw is not a viable TMD?
Or how a community developer working on SDM845 or SM8150 phones can
decide, which modem TMDs to use?

-- 
With best wishes
Dmitry
