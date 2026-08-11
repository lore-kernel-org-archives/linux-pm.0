Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03B338936
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457239; cv=none; b=RCibmY4ZUR5NjjLKUpXejdzRpnWCV0vHTAZyo0wtNrn2onf55JN1A9R6UdQrma3yypTPPfhc9Tw4NWxUQYCNa9mA/bVQRijyanzycRX4MKYl05fX9yIR6ZjZh/PLPOXYdx+ZDpkPxgA2UE9amDteAuC0Ggc78cmYW3xg7vlG0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457239; c=relaxed/simple;
	bh=teMokuG5eAWz337OsbJemBey333F13RFcsDFNyApnuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC8N2u1Kwu/5Dx/U7EtGr2CGWLRLkoNDCmx56IYA1+H5N4ITf4tU6sp7U4tJ2xXLT+rfFLyIecKlFV9Giu6/KVMWMM82VUtsKPWbSbmUR3+fz2tu7mLbVVWCazpABwxZTRjw139aprSRGxoIHU9VKP9lPu/a7oig6V24DdpT7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pa/G3Nnt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g3U5bquE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pa/G3Nnt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3U5bquE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX7UA1091534
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vB+L8IQzMVlUf6Dw8qOqlWDCsl3ywdbDtRCKTwpuefs=; b=pa/G3NntkkJH6Hr7
	EZXyeb37cBrycJ/zEXuxp0UQGPD3NwKZ6PkjwKPDos4cNaxJ9PpfG6xsgoLKPsjD
	iB5ggGJaJxhSAlsNrt3CNL88Z3gbiRyFA3FFb1XUKdW2sL0lXIEkpiUm3sFe47Ld
	I/VoJgvhbTspEptjFpqdbRoZtqaifNAISGAnPibEIVU55moA5+Q7Yf4nCDiPd/qG
	Fz9uC6vihrrHAYG/4vj6ndKO/xHkRBcChnMR/Ap37KkiNSiguewDOWx4Zba6z73J
	PtRWCZUQnfArmjgldOexsn0SJZRe2PgaiaVS/tR/sdqXaYjUCVXaQoB0/Z0jIVHF
	QYQCUA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049era2d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:07:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52827090cc5so13767251cf.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786457236; x=1787062036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vB+L8IQzMVlUf6Dw8qOqlWDCsl3ywdbDtRCKTwpuefs=;
        b=g3U5bquEWoJ5rXW7/5pjCpXPubIUuKAjmLXbil37wr6gPLxA5qV7zPBDxEVjzMmOmX
         4Wjrd+6SxJur8N/jjaJ/wFhoqaS0OhlkWQreDhlgs/8RI0j+JnKMaN6yNpOOcn8jUlW1
         vb3i7reWXLS+Fa8DyHNDHmxM+zogyhwjQf20PutquHXuQwPZujhHmj/dsqONhcRyZog4
         xBNLgcMMQZ+zp1LOfyNtBOxn8/AYrIsS0ujNk2R9M9gp6UiJZZRQRnB0CEfBCePHu9AA
         +VwTrjihH/xXwKVdRmk78fbK00M2D53WT1pF6P1hN+2d4wV1v7mwF1r5wnmebcDxsKok
         P/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457236; x=1787062036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vB+L8IQzMVlUf6Dw8qOqlWDCsl3ywdbDtRCKTwpuefs=;
        b=HLcXvmaVHWFcbDYAfpe8JR9SdVfzkZgJT2sT54p1XfN8H+w953BlF1Pb012RyeyNKz
         G9Rh54Gn5wSgYNrZN9QD7Tslidunpa1Vw34FymEqwWsmSY6BOU2CGWbXB+PN7+PEExAM
         4K2Za06mJhZRqlmd/Oj2Bz9tGswAhN3aiCb5JzJGMzAvM/3xvpmA1JuK35ksBieD6Pz2
         zdu44PG3chKG9NMG+jmOYnHwcNCsV+04kBuxK0hwJqYCGD+bnl+nPnDv+2Q5o6BI6w7E
         Qs1WbtOoBYw6baD+5m5DNW0kxT6NvjZi0OMIE+iB+IvDc8fTFnKJPO33im8URiUVQDTP
         yrTA==
X-Forwarded-Encrypted: i=1; AHgh+Rpar/REZpucQPUKAYAUvf4p3x04OCxiOxC3fG2WKc4HfGiwJCIzT8k7Zz9kkYKWBwLywwyUxZWYqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCB7k7skZXXMCDrUazX5JhV6fIyzcR89V9Orotirfrhsg3y3s
	+AwSy3gTX39JuYptut5ihqro3TL9gqZi59f3bfZiPvWTpJuWHRX8SyZWuhNOEg1DM0fNoaPXgLc
	HJMMxLo/VbYoQqyZ7CI/ud3gots8+BVNEoG9Q9TelQon1juxRKFZdvMLtSKOQYA==
X-Gm-Gg: AR+sD13Kt6SXmObX2ZhhuIwGEALESBecuLscWwD5aqaekNUp61Rq1h218U2a5bW+9Wn
	C5rIqTEpB3GtgTt8uyLx5SDsHrmtR7admtzzbUM410/5aba1qnsVAGvhiS4LgI/TX2ZOvl6POUk
	DM3abktIiwklnRtP0s3o7yVJ8MHfBsbLCoxIkuu3MKKholJAg13prtvKmPkzjg9bBPgEp8MRL+d
	DA0eyS7zRn6Tcvm/UHd/CykINK1oFOuF74Hjo4mBl2WK7Pl0v/BR0hnA9Meis5UEMpfcHTVMaW8
	KKpZh3PaZgzycXY7nRiJEDyr9Rq4Ia4xmQgb2vvoYzW2H2os6kWQdIpp+j13ctpEYcS/CBeBjXp
	OWjDWlh4Bv07Q8qOPp45RV7KzLiKKX4sht/V8aheHdOEByj50C9hWe51tlEuylTUca1z3RKit9c
	EFxizU0Y/Q3Q+Qiw==
X-Received: by 2002:a05:622a:1dca:b0:528:317d:eaf3 with SMTP id d75a77b69052e-52d60204d8cmr4446861cf.6.1786457235717;
        Tue, 11 Aug 2026 07:07:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1dca:b0:528:317d:eaf3 with SMTP id d75a77b69052e-52d60204d8cmr4445721cf.6.1786457235149;
        Tue, 11 Aug 2026 07:07:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a0fa3fbca3sm2995831fa.11.2026.08.11.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:07:13 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:07:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 07/15] interconnect: qcom: Add Kuno interconnect provider
 driver
Message-ID: <lpzyzjmnhofp6plxscqsuisoujfdviry6xy6poghyltqtm5ean@dum5bcc3ffqx>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-7-5e0ede4a0c72@oss.qualcomm.com>
 <xmj3xhnvdixooy3l6wro5f7eeehlrlrq44y2mwojzzeb3yjdjf@e3eo2772qctz>
 <f7a76790-0e7f-4c4c-bb33-36134a0f3e29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7a76790-0e7f-4c4c-bb33-36134a0f3e29@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfX9W2+I4TJoe5P
 s+3wLWxA5zzlNnHduKUU03N3l7JhiHI2bOY4ZsWJ4+MSpZG8BN3YOt08Ys+vOZpgxWX1DBajk1/
 3Uxw9860gPUQq3wPby47Y9Tms/zhiDE=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a7b2c94 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ixw1xMl1IcNJksMvGswA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: mqZBTmCHus8de2KdAzITUmP6Mw9WEm98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfXy3u6Tf6ZFAtN
 dfjvZv+48TsF8cyTB8tRrZk1iVPib6FY1EqUk8adewSYJk/Dm02Qo8RXggI4laansc1CjrAG3EL
 LkiHsI1srzCilslKdcNGgl3oioDmx1g4eefv9GeSZYPdrezZzN3nI+E6N5AzqiqhkOf4mXalwk0
 r83STw3NE5Uja3uaJfCny7PokqgIfaoDCh7r+LoG0ypWmACv7Yim8sRZPmnc9wj9FyWeLcQc7V7
 4r4DJE5y6eIn6u6NLaNMl/TViCRFt6gpQHyYSmZpj259U+E7Q7+/5uQde8mJspRiQIGyKwKKbYC
 rR8+XY873ZG9dtxDWUqVwlLVA4bvxsCAhVWRY7NDgmziaKkQZzK90gSuqhfZGzSIegockvTnXvj
 BqW0el0HFJXcU77gTCbdzSOmxs4+jH15uztVzyrF3JoMlV9yUVQdCVu3TghfpZxfdm1ckQQsY8J
 8lppESYuZj0RLT/X7qg==
X-Proofpoint-GUID: mqZBTmCHus8de2KdAzITUmP6Mw9WEm98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110118

On Tue, Aug 11, 2026 at 09:17:08AM +0530, Hardeep Sharma wrote:
> 
> On 8/11/2026 6:30 AM, Dmitry Baryshkov wrote:
> > On Sun, Aug 09, 2026 at 12:57:06PM +0530, Hardeep Sharma wrote:
> > > Add the interconnect provider driver for the Qualcomm Kuno SoC to
> > > enable bus bandwidth voting on the platform. This includes the
> > > aggre-noc and cnoc-main NoC instances with their associated BCM
> > > nodes.
> > > 
> > > Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> > > ---
> > >   drivers/interconnect/qcom/Kconfig  |  13 +
> > >   drivers/interconnect/qcom/Makefile |   2 +
> > >   drivers/interconnect/qcom/kuno.c   | 978 +++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 993 insertions(+)
> > Please add QoS settings.
> > 
> Thanks for review.
> 
> Kuno's NoC QoS is provisioned by RPMh/boot firmware, the same as its SDX75
> baseline.
> 
> The upstream sdx75 interconnect driver programs no AP-side QoS and only
> issues BCM bandwidth votes; Kuno follows that precedent.
> 
> Hence no qcom_icc_qosbox settings and no QoS clocks in the binding —
> matching qcom,sdx75-*.

The QoS-related clocks are a part of the hardware description. Even if
they are not neccessary now, please add them to prevent future schema /
DT changes. See how it was happening to other (mobile) chips.

-- 
With best wishes
Dmitry
