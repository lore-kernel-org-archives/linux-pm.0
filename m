Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928B3DFC6E
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764181; cv=none; b=Em6YxVMre+Z4ASTP4YoI0Oeq/aR1cyU5E9ipSLpIj1h2H5DE9mQh+3reQTh9Cqjup0Ub2Cu9LKawtetUgZAaLcBXhndt8FuQWCSNfl54IdhSAWtrwlh2ePDVuxvJeBdbSrLPSa44K+FUx5FhxcvVnL+DnzmPqpPc5nO5P3n4YMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764181; c=relaxed/simple;
	bh=PMt/S965DBrZcSHo/mx/GlpkYgz3KyfWQCDcoogPVDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ozdnw7DuLRqDYyyIP+K1H1oXq54bSqDsFC5ac8NwzyAICn8AMKadP3pyz8ELlCM/QHIuMVASdTI598QQq/sLEVDIoIesZKAn5/xzHOLIdG083K7O5VIi+DsrK0Y2AmpNW8Htmcroa44vxrrJWONow+feaSOmz6JRpTmv5FlzKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TNxWrG1V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DCEEhg+c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TNxWrG1V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DCEEhg+c"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeqIp2239249
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TSEOS7FzfulIGgplAzzxDVRV
	URGWpeZGkmEG7M0BRYc=; b=TNxWrG1V9cFtHOA7GwVrqbitOhhxXQaiEqWg8fzJ
	+sLGVdUfUGRpvq014GRvN/kRxViA1KU/we2/9roTmstiJyNK8Z66EoV+I+Z8pMho
	yXtuz3V7i3OejWJFlOJv3FqGo3BxoNP9JX4aAxp2FcqsfJgQaKfaOjwDm6uKMhBX
	qI5K8ZS599kSIKbvIS61BMYrCMmR2HsQulXCvi7LzV5wwzyezyH+/yMHNvOQleVN
	ohVmUNdeB8j1zM7yJVfJB7u5tGm9IxHq56tFrmMmJEHSlwnzPjd/byip2FqdRrHO
	onjKWmlU4BWLCglZIABsJr5iUfrnaDqGhDii71DgMDiekQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e566bhuww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:09:38 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1270dcd11c1so15632231c88.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778764178; x=1779368978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TSEOS7FzfulIGgplAzzxDVRVURGWpeZGkmEG7M0BRYc=;
        b=DCEEhg+cI8unhMsP0GySKm/3XTNGCcTzO0IGIz1TAh4Wcl1qUnsJR6GTIy6bV+/cC0
         XQVagVIDJ52K/TAGMHxg46Zmdq2v0GayO3cSG0Jv6ofzHCEiEK0adg/lad3tt8WSqUXQ
         KsLYHEDdMThkNZIKexJZCcfj9Yq02AFQ9MdGdaEA6ezHxQSvmyKIgImPAIBW0nXMezS9
         bK833jp6XJdH7rljSDICiOGXWtWHOeSl99p1ZnSfu/ASPLgUEw5bp3PgzCEWI3nWPYvx
         I9bjnoDUHATEFzTFbNdJ1NYWoCSgRCcDQHM7sA7HAvLV45lJpCqlyw3OR/Wr/HBOgb0X
         qtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778764178; x=1779368978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSEOS7FzfulIGgplAzzxDVRVURGWpeZGkmEG7M0BRYc=;
        b=Q0LW/A8O2sLDUP9y/KQvUC0/DReft3iUuDmm/cALz9W5QDyoMWhTMpO2PTUH73j5Yh
         V/H/iWwdHB3G2PKqlQgHOVfN8mYMTiOsP46Y0F3gK8K/Zk5cpyfGzx2kWmIAYd9jSAy1
         4CbZUcVSi4PRRM1cTcKHV1A4zt3an4vGZXRRec7xJZvc8bTaz/3dtFpdlXW+JkCjxVYd
         geVb5Ux4slekqNLomUBknT2KgvpTSzMm5Wm9F6+ZQ0jN4oeWg7OuHNe20cI18eZld5OC
         88Uhqooa4AnCGdOadHgCcNCIZzpB3TI1keeKcc3YdxJKMGCyWtmqtTpB6slOcr0Ew+4G
         2Usg==
X-Forwarded-Encrypted: i=1; AFNElJ9jBVI9W6QPsqNuVGIbB+EXb2iImaSYA/S2i8gtERdp2MqYh0sn1bQtX57ACCGGaU2jGKgFOI32uw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5JZTFamJJ+NRv2N8FsjH75m15gyeglE+KuCZm477xFnM+GO/j
	DbIVOlzXjs6gvf8hKw48t9JmDAN5ri2BUu0Uor0sy2yRFk9xCI+vVVnG6usaUp8iuoToZAoJ1fg
	HAN/ds4E0aWb7TSgwv6F5Ibta8E23HOoeEnTVZCF7z7LTRa0fS/cNWNESrIPR2g==
X-Gm-Gg: Acq92OGZqSlK0IpGCIGJDbKShGesF6SneWU1Fjyv8XIVRnWSP3LzMBtd56Y3he5opI4
	I26usxCwVtFe23JbnuP8s40Vw8XsqjLcvoowJand2ZIkijUfvhYAzool9FM/2T8sjp6t/gIQSdD
	UmDdKaBENbHQS8VIkyQLR/1WLe5dkvgnSXO7aLBt9bm1m5WWd29jOtlniBXg637eULvihlHDLdg
	QTuOuJxbRCxuHJznax7buAjVaiGXvUntU3qA7YxLlP6gTn9+pbYcONkbI36RG+UFDIQc6LHdNRH
	yfCc55xiM9/9J/7hyXmJnNAuzrqcgDEsQFFrVSLN/97sh+029Rm0YhwyTxsMUBQVzc343cpzSkF
	CkG0fIH5NqEO8IUBB1EbJ8x3bnX6IzMZ3bRr0HDiSgVChlXHQW4T3GzfsdQRjh2BhWfYDU2mfti
	U=
X-Received: by 2002:a05:7022:1a81:b0:128:ca83:5aa3 with SMTP id a92af1059eb24-1349a6f91b5mr4300099c88.1.1778764177516;
        Thu, 14 May 2026 06:09:37 -0700 (PDT)
X-Received: by 2002:a05:7022:1a81:b0:128:ca83:5aa3 with SMTP id a92af1059eb24-1349a6f91b5mr4300067c88.1.1778764176882;
        Thu, 14 May 2026 06:09:36 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351d9sm4393185c88.9.2026.05.14.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:09:36 -0700 (PDT)
Date: Thu, 14 May 2026 06:09:34 -0700
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: eliza: Add SDCC1 slave node
Message-ID: <agXJjhDdsZE4VHAE@hu-mdtipton-lv.qualcomm.com>
References: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-0-b1edf81bac3b@oss.qualcomm.com>
 <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-2-b1edf81bac3b@oss.qualcomm.com>
 <0aa79750-ac75-4111-ac82-ad5672157c90@kernel.org>
 <3y7hyzwy7n5yqlmyywyuls374j55i7aqfgyiuabf4tubu7slut@pnhrvqulz7dh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3y7hyzwy7n5yqlmyywyuls374j55i7aqfgyiuabf4tubu7slut@pnhrvqulz7dh>
X-Proofpoint-ORIG-GUID: gu-rjg8qzBbGiSSfT1PJqyWLZdi1l4uv
X-Authority-Analysis: v=2.4 cv=WsMb99fv c=1 sm=1 tr=0 ts=6a05c992 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=zvVpzuEAzJinQkndZGQA:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEzMSBTYWx0ZWRfX/V39q2NCbnCd
 lR51+8iAuNKfTyt0D0s5JUT2wCZGzoU04wcsDihn9t5dlcyj1dgQnJJo/zCHkRM9ZVB0ut/tWf5
 auQExMV71qrB+Rb5/B6uj898mEgAgOUWeAt+OV+VmNjeLDLLWwhAQBNQuoGiLdHje1Kxy8trA1V
 dCKyDj0dK3fLLHJ4U1sBuEkZtaIS3adogbbbUlQMGHtDYkwh0ss9omgs+XW+KVQdOlDPbwu0XwB
 lmpRxYwjpGpHBWl7n9GHwWI9BJfrWLbeRiLmCrAojv2E9g8f/rOeoTVhGON8h/8G0QdfxoH91WM
 51J7GG7jyRsr1ZTNvC9b9XUM0jDc9cdDEGJBaPsQhpFOQR5vNo2QNR39s0yUXclzCOe15hSh8DB
 0614xuRWIT3ASqs7hQsiWtURAOOkQXORfIfP5W7TVpg5DjaqJWS7JwHBFTkqzJcEcc9jx5YKx8r
 23Hy2Z9REFodPDVHF9Q==
X-Proofpoint-GUID: gu-rjg8qzBbGiSSfT1PJqyWLZdi1l4uv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140131

On Thu, May 14, 2026 at 01:39:24PM +0300, Abel Vesa wrote:
> On 26-05-14 12:52:21, Georgi Djakov wrote:
> > On 5/12/26 3:18 PM, Abel Vesa wrote:
> > > The Eliza interconnect provider is missing the SDCC1 CNOC CFG slave
> > > node. Add qhs_sdc1 to the provider node table and qsm_cfg links so
> > > SDCC1 interconnect paths can resolve to a provider node.
> > > 
> > > Bump the qsm_cfg link count to match the new entry.
> > > 
> > > Fixes: a39efc80ff50 ("interconnect: qcom: Add Eliza interconnect provider driver")
> > > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > > ---
> > >   drivers/interconnect/qcom/eliza.c | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/interconnect/qcom/eliza.c b/drivers/interconnect/qcom/eliza.c
> > > index a4f7903f0524..6d12a1c3c034 100644
> > > --- a/drivers/interconnect/qcom/eliza.c
> > > +++ b/drivers/interconnect/qcom/eliza.c
> > > @@ -127,6 +127,12 @@ static struct qcom_icc_node qhs_qup2 = {
> > >   	.buswidth = 4,
> > >   };
> > > +static struct qcom_icc_node qhs_sdc1 = {
> > > +	.name = "qhs_sdc1",
> > > +	.channels = 1,
> > > +	.buswidth = 4,
> > > +};
> > > +
> > >   static struct qcom_icc_node qhs_sdc2 = {
> > >   	.name = "qhs_sdc2",
> > >   	.channels = 1,
> > > @@ -383,7 +389,7 @@ static struct qcom_icc_node qsm_cfg = {
> > >   	.name = "qsm_cfg",
> > >   	.channels = 1,
> > >   	.buswidth = 4,
> > > -	.num_links = 29,
> > > +	.num_links = 30,
> > >   	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
> > >   			&qhs_camera_cfg, &qhs_clk_ctl,
> > >   			&qhs_crypto0_cfg, &qhs_display_cfg,
> > > @@ -392,7 +398,7 @@ static struct qcom_icc_node qsm_cfg = {
> > >   			&qhs_mss_cfg, &qhs_pcie_0_cfg,
> > >   			&qhs_prng, &qhs_qdss_cfg,
> > >   			&qhs_qspi, &qhs_qup1,
> > > -			&qhs_qup2, &qhs_sdc2,
> > > +			&qhs_qup2, &qhs_sdc1, &qhs_sdc2,
> > >   			&qhs_tcsr, &qhs_tlmm,
> > >   			&qhs_ufs_mem_cfg, &qhs_usb3_0,
> > >   			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
> > 
> > Should we also add the sdc1 to some BCM?
> 
> AFAICT, it should not. Even downstream doesn't add it.

It should be on CN0. Downstream not adding it to CN0 was also an
oversight. It shouldn't make much difference in this case since CN0 is
an on-off BCM and other BCMs along the path to qhs_sdc1 would indirectly
keep CNOC alive, but it should technically be on CN0 just like qhs_sdc2.

Thanks,
Mike
