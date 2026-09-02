Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD643149B
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343521; cv=none; b=duNR5lhQEBvys2FhBeDaNCPBk7vq7PAjY4F6ruU3yyhA8m/gKgC6ktuR+cM1WBtBkUg3AO8Cp3f9DY9vvubNf+C6Kope0neOKQF6filv2bAmZt6qx35iR33OokZcQCkeheCpu2+Wr81m5laTwSkiQLOdYiXGaJZzS3u3lG0P4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343521; c=relaxed/simple;
	bh=fGO4RplatNuXpDwpIkS3PIxnYbi9rKjtyM7If6v8PbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDq3y3htyboJy8gF4Hfu7OP+EWYqObKfOl8b74f05VxVB1MP0avLegPmwCBYaYjeLTI+AjMxYXf01/+Axj3BXhWoMbspgRyR/mEs5UxF7MKQ5GecbsrOjzYOiHjDSpoqZ0TQYkva78smsbYFuYikPDkNgyAqxDAWK1Rl72kuQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tqv0yeIi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a9U4a0Vo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tqv0yeIi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a9U4a0Vo"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829NKvo528553
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 10:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UObzRMWFCbP75V/KjEzbft/x3L2cCcud32HQTacNGec=; b=Tqv0yeIiPRwmmsaR
	Pw11uZO2np9Mq/XrQw83Pq+4k4Eaey5F9mjwJ8rnWt0AxtNGDL//z6vG9eIJayLa
	qCIdSGLrHuv+NsmMaJKOoEFyrfg9zqNeCFPlLVTcfZtc1OA06Yc0x9ammn4AfrOT
	LJjvcqP3iqjBHrYYZaBED+b9/3n6+zvvgstSgE9NsPa74SatqHt5VJjtnQwSFJwi
	tpFN1ox3O46aRGygmArWcPK4frSKk1anxGM+S2PwBPlQh5+XRt3d8IgINo1xoxXK
	qjFz4EWj6iAcq/zaNIfb6BGTKPliIekVaA2V7o8cTCQgYb4mat/cAKLQPuHs3GN1
	0JvExA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge397bcaw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 10:05:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1350101a91.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788343518; x=1788948318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UObzRMWFCbP75V/KjEzbft/x3L2cCcud32HQTacNGec=;
        b=a9U4a0VorLxR7r96Tohbt/wNBKzYKhNbw47uReDL2CXE21gmvnNXw3sh3dlfPqociK
         L4xN8YuVDYnIoh9K6D/QZpLwQ4fOxCZhcAyZYrE1fkbUsw/eSFyEqv6Pxj+NqPcqLQ/W
         LZeqeRTN/SeSy/6mbvcCErFcsSd//KqZF+qoQsSLrxOltlm9n70ECvPWyGhwVVJWuo5S
         G5ZrrUxp9qVi9u1CY3Rybgy12/eWRSLBXScU2uh9+hFHbuM/NPvqM5u19LKE6ZsAcKXs
         cgFxd2PlXKwhz91e97CV+biZM2/dcFJsuMBWsSHekgqaSam6huNvpTIQsQ8LLUFw+bDJ
         LJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788343518; x=1788948318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UObzRMWFCbP75V/KjEzbft/x3L2cCcud32HQTacNGec=;
        b=OqE9wqahSUYtmXSYJU3ZofC+ZZfV5idrfKNaKOyHVhfC1j+yaLGjW/qx9ESgWWolIR
         soaPXlJvPhlMXsRhBVtbB1unwGzoSr7oG5CcMGDxxs8l18iTnE2/xqKGzttjtOdm6TPk
         67xGLGGMA8RRxYTxcv9cPmuPw8ajcxGAGoDdvste61MGWDxypF8YUim0EqmcKAbEKTG6
         jlcsUnHhSoYdmnuy4S/PzmgoHvP3FcLEj3EA72FzdBJ1fuUEbGFDPKs+sboJb2hTw1RP
         KwOhJSkfGkXPUd6MNmeV/W5V7BJVlGezlwY0uvOZNE2rlOQugmBC3lIseWu+gPbxbTU7
         9Knw==
X-Forwarded-Encrypted: i=1; AKwUvBxNTo1TnSSqbO8TJU9pjLMdOcgn281uBIc6whoriz5ugr6TPsS2SpUDxVh2KqvOZLrrYxy2XHfsFg==@vger.kernel.org
X-Gm-Message-State: AFuF++mnL+NPAM3Nyx33ce7tcnWWyZqhfFHyRkldETNt6gDtaxcJCf0T
	is5rw80pVFaZ1Svx+vEH3Gxpn8YXXR/0/w2tu8YVkDsiIkWIxJ6HJf92i9+OATZabNWApokTbel
	aKWdbt6gom1qCoLWNrPeMStX9X/ZSDe8D9wbG7PmNuk6GoiVPf1ezh+kxpbkoTg==
X-Gm-Gg: AYBFou3OtCKYHKKrcpV3iXNx8th7b5fuKuGZJ1NDfxpcD0BUtMoc4Ndpn6PuurJv1We
	CphwHkGLwLMABGvps2KbY4CoZdNdSHFgNkNsTiO8d5/tPowEUdgpHx+3kQFFCSmoWFpz5oVXSyX
	Pgip8mLe97nkrVuivjM090BSkfFMIdPM5oopx15c6ck9N2/pR00xS9puPfPMathic1T1ab//8ds
	UyqT+6c46bO7G4HupdVZ+jVXlYNu8RXdvK04xcppJCqmXwkaL1vRGJLVV9858Z/sTGmGIIQR6kk
	3PGnohWHTgWDPI5dNPMs4yai6PF/oUh+sV8lB/JPDCvaztiiIgBg0Fca6EDpRXfVSGbR1rnRZrL
	470VJUe5mq83ZPCtovSv8GAluxm8he6azn4MFVHXL3dw=
X-Received: by 2002:a17:90b:28cd:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39aee0e6633mr5456144a91.16.1788343517850;
        Wed, 02 Sep 2026 03:05:17 -0700 (PDT)
X-Received: by 2002:a17:90b:28cd:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39aee0e6633mr5456020a91.16.1788343517229;
        Wed, 02 Sep 2026 03:05:17 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430eafc907sm5093202c88.9.2026.09.02.03.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 03:05:16 -0700 (PDT)
Date: Wed, 2 Sep 2026 18:05:10 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add NMXC power domain for Nord SoC
Message-ID: <apf01nNGO-7E86J4@QCOM-aGQu4IUr3Y>
References: <20260826135454.658615-1-shengchao.guo@oss.qualcomm.com>
 <CAPx+jO8RVUv=mqDZ-GeJa=dEYdNCK9L8Vi=UCDY9GqQ1TefCsQ@mail.gmail.com>
 <apfVvXLAW0j7g3pD@QCOM-aGQu4IUr3Y>
 <CAPx+jO-q3JwY=i6P0K_r4OBie9bnPaR5kUm8+T8uGFq1oK9vFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO-q3JwY=i6P0K_r4OBie9bnPaR5kUm8+T8uGFq1oK9vFA@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4OCBTYWx0ZWRfXyhXrhZcIRbZc
 2vEJpYoXaBC+urIN86/7tvEXcmzcNrbheu/bjs5PcvBXthMcuOpMekY3s1BgXM6eZxLNu0lhpve
 R8ojCmdF14WB7J20+nEjYqSBxjYTsiNrfciXtx1LAIPHsRXyr6UMHLm1OBLstL4nZaDWMzSVFql
 hXOPwoM/ThIzQsMvtWbjTL7HLo7d4mux3fqIeXfKqodfskSI2Wzww1QEcmWtRCaznlA2hOgNOuR
 /doyrjW0EoUO4/kRlht7MFkYna4PU/rSutQ6FDZeFjRMn+9h4LciP5Zq2lrkSxhFBaG8IJw1+We
 Y0OvXasGZSE+/GLSzft3X/4RWj7ClY/Nvik2RwbTidP8hnLESGNcv9PDTO2RFzXBIRbc3u7YwTm
 6QldvIzsUoHluO336hzNtqJNt747cm03YmVJteTdSSdWSAHkb3st1nBDSQSJXWFj+UNNqP9H7hn
 EE+1yTP/JBu0/wJGYbQ==
X-Proofpoint-GUID: FZ6vPiNv_7axB2sH6dyFNOBNhoiLlTU0
X-Proofpoint-ORIG-GUID: FZ6vPiNv_7axB2sH6dyFNOBNhoiLlTU0
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a97f4de cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dbI9BitF8MENLqa2HooA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4OCBTYWx0ZWRfXxJvgYWmxVHRL
 5xNUyIHMcl+jVAkkC6zEXhEXlk6GLMIS0xS6vP0ke5jZuf7DRHhh9qlfkW9+6yfNlTQB45RmQ/K
 FhKOA3zoKkkCLQDzBD1lkw3zJmEJffg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020088

On Wed, Sep 02, 2026 at 11:42:29AM +0200, Ulf Hansson wrote:
> On Wed, Sep 2, 2026 at 9:52 AM Shawn Guo <shengchao.guo@oss.qualcomm.com> wrote:
> >
> > On Tue, Sep 01, 2026 at 05:46:09PM +0200, Ulf Hansson wrote:
> > > On Wed, Aug 26, 2026 at 3:55 PM Shawn Guo
> > > <shengchao.guo@oss.qualcomm.com> wrote:
> > > >
> > > > The Nord CDSP subsystems do not take their memory rail from the shared
> > > > MX rail like all other Qualcomm SoCs, but from a dedicated NMXC RPMh
> > > > resource. Add the nmxc.lvl RPMh resource and register it in the Nord
> > > > power domain table.
> > > >
> > > > Changes for v2:
> > > > - Drop remoteproc changes since "mx" of remoteproc is just the name of
> > > >   memory rail input which can be wired up to NMXC power domain in DT
> > > > - Link to v1: https://lore.kernel.org/all/20260826102746.633076-1-shengchao.guo@oss.qualcomm.com/
> > > >
> > > > Anurag Pateriya (2):
> > > >   dt-bindings: power: qcom,rpmhpd: Add NMXC power domain index
> > > >   pmdomain: qcom: rpmhpd: Add NMXC power domain for Nord
> > > >
> > > >  drivers/pmdomain/qcom/rpmhpd.c          | 6 ++++++
> > > >  include/dt-bindings/power/qcom,rpmhpd.h | 1 +
> > > >  2 files changed, 7 insertions(+)
> > > >
> > >
> > > Applied for next, thanks!
> >
> > Thank you, Ulf!
> >
> > Could you maintain a immutable branch for qcom,rpmhpd.h patch? I have
> > dependant DTS patches planned, so an immutable branch would help Bjorn
> > to resolve the dependency.
> 
> I am always applying the updated dt bindings to an immutable branch
> called dt. Allowing SoC maintainers to pull it in, for the purpose
> that you just described.

Awesome! Thank you Uffe!

Shawn
