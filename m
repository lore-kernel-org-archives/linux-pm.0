Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4182235A384
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035323; cv=none; b=hdGWSKwTxr32EeFU5zJn4KryWrT4dR9QUjHZQJBiCCmDBrY9t6WFJCBcJYXJFn1YL/20LipckdV4oSWibuY/3DW9veZaqP5yeKjt6xP7znNywP3p1Osk7OhuQMmuieEBq1eva6JGEC1UP/5pg2brmTA8ascRYqTFi7CziuvPGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035323; c=relaxed/simple;
	bh=SMWFUGavbE0VkV3fmehSGnnelO+VQoVhuLxrVUV1NJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxO+eOR+ZgwO+XmJ4KZtFh/uoHQX3tWKniHHtSofPaoPWi4g7gQmXe09SviyY4wC1cu97EQwLOQaH/41uaDyFJPqUcZovvf6b07OlKg/bIUNBUWB50e8Q9cm0yoL91SoSEmPCmJpSsFSzNG7gJFzl9tHEL78zjcJlX/wfuAlWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h7H627hj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LMMMyiab; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h7H627hj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LMMMyiab"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OCNrfu4167383
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 12:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zpLKuxXcZNSD9Vho3/l2L+f7
	A1uq769GitjtFC6qSuk=; b=h7H627hjnNzIT4c2kGVLnScxEsMoBp4avuK/E/Vq
	nHgRCQvHezOfYS2SpWo+6rP514C5dJCbGn6ryWrCF9l+VPYy+ukb5wUlUq13Q3RO
	Xr7cNqADfWiwTGzQJ9PoUupLwtNoLe1W9Y/SFZ4XBCyNiBTUBc7OfannRQUj4xWB
	tNk3aPmZ1+0zEJWl4QieEdBNTgxYK404wsALEvtUW4TmkisADwN0ej8yuVji+EyS
	00CmK8xulfKpL3QoVszjG0Ta9r2J3Qh0I+bDCScT1oCmt7kP7V78xuSLOQhjp6WB
	aYQhUGAcHINZLr5ZBylrVowY7OWf83qmj82YktxH6aoNZw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr48n1fp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 12:55:15 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0ba59a830so12060794eec.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777035315; x=1777640115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpLKuxXcZNSD9Vho3/l2L+f7A1uq769GitjtFC6qSuk=;
        b=LMMMyiabSEcuqx09Bo3e3mEzAahpzlydP70Nw6bUedv92Rx6Un3lH6zdHIFyOcsc4S
         CsHsNQDFj4lFzoRQtw+xtKZ8SKdKtcCMTOA2UCt0TsfVM+I10YHUoq+8k/O2/rhatkEb
         UuMCnMk7E+b7vWIA0WjFIxSuG2PheAaJIJeInjofZOwk6Xrmt5yXeS2nvPWsoTcfjV/H
         Vydu1EEyxUeR9L7sUzp6krox42spVl8Lc9zdO5ZLgCYT0RjCsfP/T4eDTLClHRhNq54T
         ijKVG/AE5RrBmgHcu4OolpfpJ3ibRFtF/Aa4XlBCn9zUzVGcK8b8rxcvuAP8SL1722hT
         XlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777035315; x=1777640115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpLKuxXcZNSD9Vho3/l2L+f7A1uq769GitjtFC6qSuk=;
        b=RSyScYxM9tLPvEfK5Wm5AtTB7ZGrJygvIVdLDgV7OgdjGoXS5FhPck7VqMQgEkVau2
         F1NmTkx82LdcFbn8UbzgTNIbtWKNvVzYw2d1hElOUlR+NFCCB0DQWH0ZwzXYyROl8vi1
         4NkpHPbSIPiSEHibVnYKh/3X0sjW7jQmYdTSJY8Rp2fjgaygbCewVQgLBYb2fRm0Q/mS
         /MiIjHgIhk/Ow6CWtTM6egg5+TVBC3SL0fbqvvKmQ0VKZXGipHRCaD11zrd2g9iuYLsR
         MBV5JMg63lxplzxbGHRWZDDQVwhvaTXHhz9qbV/myn9/y6uoYemDqI5BIorNehIYn9+L
         9U2w==
X-Forwarded-Encrypted: i=1; AFNElJ+1HUXnKpxQGpN8dOAiktrD80Nxxgv3YcjmL/4hnBd82FqibXpcOpC51MjRhQYcreay/OaBWFK22w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdtWIYzBCiIEN/gbpob/gkmtX0N3ASJ733lmW5XAq/Zv1g2r9c
	JiIHgLm4ZKqf/hzQx7/570V5+yM4AT9P2Xa/01Uq6T0M7+4ecFNscqvhWnVX+9JmCV8Es/fco8w
	X3pzfMWs8LiFmbkd7CCItJNnkqGH0JtX38/0naJnqm2bFwYEJb8sq7kOdECu9MnNCDFE+aw==
X-Gm-Gg: AeBDietnyemK6sUvR20+vjTj02TQtG4ag+A16hAVnvOjjQigdRypJfs+CJnprM03Awd
	iTjj/rPXz/aV1o88NGlN4n1dfYmCI09lL9n/YyIVbRq8QIUPjO9grrdfoImKG1ebfeO1Nk2/Iv2
	8RruHZFXZrBMZtRGvd5vYkgkbACgzVpsIgbZV6IVeHF9QX3osP1eMXZPUhmUUEzWL4UgIZlgXQt
	8+i7b8t4ept7dNRfO6HhvziPP3MycPOd1uATyRWOSBjmHT5ud9Dn0HbzMQANhlotK4FFQCj0Q+3
	KapuVVUl56WIsovPjd8ybES34FaJ0Hlx6WjXU+NPc/SS5BGjy39dNCALETxvF3oMopHckVrmGlw
	6/VyIRCI9tMtL5hWhTy8z8UtWrdoHUxth9OtwuvuLA5HkLi4bMEoaQhCADmDuskHI2umq7ePqYg
	4=
X-Received: by 2002:a05:7301:168a:b0:2d1:815f:19c1 with SMTP id 5a478bee46e88-2e479c0427dmr15313624eec.15.1777035314745;
        Fri, 24 Apr 2026 05:55:14 -0700 (PDT)
X-Received: by 2002:a05:7301:168a:b0:2d1:815f:19c1 with SMTP id 5a478bee46e88-2e479c0427dmr15313604eec.15.1777035314221;
        Fri, 24 Apr 2026 05:55:14 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm31824043eec.28.2026.04.24.05.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:55:13 -0700 (PDT)
Date: Fri, 24 Apr 2026 20:55:08 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Document Nord
 Temperature Sensor
Message-ID: <aetoLNvH5jeK3Cmo@QCOM-aGQu4IUr3Y>
References: <20260420065409.1249030-1-shengchao.guo@oss.qualcomm.com>
 <a4f6b7f5-6566-4c73-9c4f-e43c3cafa75a@oss.qualcomm.com>
 <68723e33-53ca-4a66-8777-945cdcfce6fa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68723e33-53ca-4a66-8777-945cdcfce6fa@oss.qualcomm.com>
X-Proofpoint-GUID: emx7-X7d_lznkzN238hJo0TPz6z6xxTo
X-Authority-Analysis: v=2.4 cv=VOjtWdPX c=1 sm=1 tr=0 ts=69eb6833 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Uo6MfCy8GOolxduyRh8A:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: emx7-X7d_lznkzN238hJo0TPz6z6xxTo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExOSBTYWx0ZWRfX43G9ZgVbtriP
 2pUCf2qPYdsg9CKiwt+AMhQzLV6B1JfADYQj6R3OJMQEgLySu23XNkoQx1bwwHLwnyezboirKHG
 Vb+IRrWn3/ZS6xq6zylg2YEAYRWGOFFbDUdqMOKTCbtGhanwkgXrTLNMiWrlmQGXbgUTlizn2GZ
 lOyAy5iCYKxyCV2tDXdqYYN5huH4CYorM2A/nz8q5hLtl3cLDKa1jNB2IHtWwRe16AMl3Oq4hCw
 LON9MR28YGpz5tNPIim3LipXxYrn0unW6RIYzys8nKGOeTYIXbyl51oegdj3CC2kNQqmspuAt3l
 Q+XJTrDm9p1JBSoLycA3n+gBFvkXpnkyzpIlIMdczAeBvcrGJcxDEaspibTWseq+CpP+8SVg85W
 3J/E9M3TqIpRR/WtFkeVwwiF/ig67HHq2KCZvNbkbiTWzQVZNe8mZLDapaFkoQYC7kOPzOJz5se
 aMx9h8EPw5Bmxs8lJyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240119

On Fri, Apr 24, 2026 at 02:12:44PM +0200, Daniel Lezcano wrote:
> On 4/20/26 11:19, Pankaj Patil wrote:
> > On 4/20/2026 12:24 PM, Shawn Guo wrote:
> > > From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> > > 
> > > Add compatible for Temperature Sensor (TSENS) of Nord SoC with
> > > a fallback on qcom,tsens-v2.
> > > 
> > > Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> > > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> > 
> > Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > 
> > > ---
> 
> Krzystof,
> 
> are you ok with this change ?

Hi Daniel,

I plan to improve the commit log per Krzystof's comment on another Nord
binding patch.  Hopefully he will ack the new version.

Shawn
