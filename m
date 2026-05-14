Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14590397AFF
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750214; cv=none; b=M/LuahqE0LyN1NETc3iXwSpABOechmmxZXz+9K/9DPi9FiEkdZJga3S1gYvDkMFT9L7W4AxH4+JiDpgPzvwEMy+ivxNQ8Kbzr+ZCcugUSc2l0QY2ZyGnKWWwX1yneBnwDgSA3E4aK2ie7xqXBJ2VEypEElrlMj2E5B6/IAifGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750214; c=relaxed/simple;
	bh=A922+v4yQg3BZMTUGtFZPP1hW9d8+K3XYPsGdSwLV9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKb4tBY5GLGi1UYInuPJbt8idXkmp/jyoiZ3UboCljMTVMbtRV/eFPOXk12841C/Qm0tJ31WVTwyJCU4rkTQBYBMwS4Kj+1ET4VJZWGYMuMukqod0UaED8m/ZO5ldxZemonxxRg8UbOKEgFOn/Np5oZBcndKJ8QL1Qs+vKHXGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lg+AS4og; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B8ZBoB3m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lg+AS4og";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B8ZBoB3m"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E91wrT2524309
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KMMIowNNNMF9IiEXOsQR1pgtS+EOO8C3IKv0+6OioA8=; b=lg+AS4oghde3QkS0
	BguIxmlZ3HtdNhHqbAb7b/3jeyxOczoQWtCbPGFUljo3ufuXvlZaS3Wn9eUICGl5
	tqiV/FGsIwF30OaG/WhqX3CIeVzQb2BbZ3g8PkBx3tpg4e1L5tWKhjaIHQCUmtSG
	1qV5DwcmXRSF7dacz4Lz5KZCd/PHkyzuWcC8neEJRIatiMxTKJmy981S64AhfVgL
	QbO1y7aoqCO3YIHC9oM9WXVbXBfXxwMsurX1/1HCURcVsNomrbQ9j0FHmF+dyj0H
	LfQ2SH61JNBcD7PrUbW/k5WvXNHWRPz7lefONOqqMla23ntEAsaFiwD1cdM3B8vm
	5MHwZw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjk7u8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 09:16:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d9a6a853bso155178731cf.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778750211; x=1779355011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KMMIowNNNMF9IiEXOsQR1pgtS+EOO8C3IKv0+6OioA8=;
        b=B8ZBoB3msMmqQRRRBKYHZrhnQHfu+yaj0KPwti4ay0hCd5/D28mtoeGB9XPoNUE3Qy
         IfHGkEhZhVBiWXdUaLMDSYkldJNXQ3prqcmhQORKMSLPBv+utLJsscisE0MsRGj9UorS
         oYnZoT4C34Jz5e1XrkhXMIbEPVmYoQEWWdYixkWRHL++EQkCUwARZ05CkzNji1RmxT9c
         iu3ouog+Q9uslzkJ7VX+A6WajYesZ0xAUZwhbaOnM9vInWdQKOOBW3ZFkfMrWvIC6/bz
         1DNqd6DMnN1MbArRAMPlOwJDSIfJEnXVPoTglgQ32CxUcNs2OrrKu3FTETT0I2yQFy7Q
         /jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778750211; x=1779355011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMMIowNNNMF9IiEXOsQR1pgtS+EOO8C3IKv0+6OioA8=;
        b=JgH3D65Sty0X4xGECKcmyximPqw1IKOQr8Si7e0CT8W8BxRyMy+JrzKpxExhRj8Z3O
         cP8a7wRI0jNXmSjRhps50+ap2iwDD5GbYQ975c2LnEi/Hgdn4OOrZRCns2frj0vypx4Z
         E1t0+BkL63ayYW+TEpqA+uRYSiqqxiU/GnDUvNSQPvOVHR/sb6Ol28BItm227ltKWjcm
         55SXHrGblZwRHHLCzWgYu0HaHPZZdO1Py3s5+1b2jefApOQsNFu2ao5QHFIP99SupjP5
         LrTQLzAobZhfG94wkdWsfvdQXIjSQkO60Q+iN3xAbIvqLuMm+TqznxIs1ENbOKoRDZ9j
         VGqg==
X-Forwarded-Encrypted: i=1; AFNElJ9e5bJGR21XHFNeFsNxPWnfhjE0ZW6m+qBytgcg/iSE96DRhFfI2chDC+7ihLc+B0FX7zBpYYRzTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FYERoxSAsX/aiNYifwqRIbYKjRRUURYdMkw4M38BSeapejp5
	N0uKONSRPKeL15YERhUGjVufTycyl45qM++9DLd9bZO70tmJ1MzG3ZPKas/Rne/c007+63mmV/O
	cKzLgo4M7BIyQiXK2s/xApRamrHW6O3PfByhZGL0liO099pw3FWUYPDXXMT3Z2A==
X-Gm-Gg: Acq92OElU+qUMC+bselQ/59mf4/PC5xX/Oxhw3qAoZIuar1xxpjFggJPoXUDPKtqdiN
	hG9ERDr2XxPJfbr1uixpZxaIrihv3V6BX8OuF+uSw0rz0ta7/Ck+iMu6vxM7ycO2MypNoRu6vu4
	PGn5fJ2EwGecv0CdJ/XytyuvYN2gmUukh7ALMP4As/rxv7Xa9wHXslhzLndRqF2LmuhkI+H0WOO
	FbpL90ch9uw4djQwW6hAwtRZB65hg3D8xHJGnfu7AqXij+4NFwSWe1ROXmY9va/ubi/vhIlbMdg
	ZkF7/g3anKbFZIxtDpT7/qSr9RTq97Y4i63jYbSQtaA2Re2nioI3wBYYWGOWhTiqvS9P8lSSqKp
	7w5gLLd8yp3iqRZLqwdFYsyVJOV05Z5Njjse6+hCpEO9gc90gSm/26ZFkA6JcOvfyDRMdAnPM5K
	eQkHEDFRxoX3KjsajvSazlpMjS+Vo+GzdU98k=
X-Received: by 2002:ac8:59cc:0:b0:50f:bdeb:1e47 with SMTP id d75a77b69052e-5162f5c9524mr99616331cf.44.1778750211417;
        Thu, 14 May 2026 02:16:51 -0700 (PDT)
X-Received: by 2002:ac8:59cc:0:b0:50f:bdeb:1e47 with SMTP id d75a77b69052e-5162f5c9524mr99615971cf.44.1778750210849;
        Thu, 14 May 2026 02:16:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945c58139dsm4605241fa.0.2026.05.14.02.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:16:49 -0700 (PDT)
Date: Thu, 14 May 2026 12:16:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com
Subject: Re: [PATCH 2/2] soc: qcom: rpmpd: Add Shikra RPM Power Domains
Message-ID: <ezpigr442rjnodqcg5fqsyaik3tkp4yyw3cbu6j75ra2vidnnj@7svqkcz45sdi>
References: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
 <20260429-add_rpmpd_shikra-v1-2-fdba28564380@oss.qualcomm.com>
 <e032c072-57b3-44b4-84a7-5aff062b9c00@oss.qualcomm.com>
 <20260514084512.q5pzh226zdkuw53f@hu-kotarake-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514084512.q5pzh226zdkuw53f@hu-kotarake-hyd.qualcomm.com>
X-Proofpoint-GUID: OV3fq2GCls6i79EAZp5jnOomVtymn5oe
X-Proofpoint-ORIG-GUID: OV3fq2GCls6i79EAZp5jnOomVtymn5oe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA5MSBTYWx0ZWRfXzu/EeBDh0aAD
 rjkqnHvLGn9J+AbyclJYramk93aabDY02iukw38uxnSj/Y3nZ6zFqnayT4GeCHKI7YlwFHP5las
 FzUvKr82IMjRz45ncvI+fIlGfbBTn60saW1YxUirk5E1sNWRWxaisNvF0JUOkl5N7LfCxnw9hf2
 tPnlUtdeSxN/OsCMMXbYAd3XBcQcIaqcixa/VxfQuaTUDwLtZjfHPMhYMcNNHOyvojiyFZQ5KiT
 PHu2x2wqXYKZFw6xNDhOmS/mlJHfe1z8Vtl99ShMLN0VobjcYPv+Ef+bJuIs2f+BqaQx73R+aSt
 gxR1vI5UURXiEldPuH4tCL2jv28QL4NESN8StQX7Vr6dZ2LKweJeK0GFYPgstnyDPvyBObd6mxW
 7LqXSwxDiTwMLeaprMz40G79f/jo1VPkydDKRPZAvlh9B4zeokc1N4PwLqTdJChVMlBx8i8y7cD
 R9Y3UkuaQoyGrn3WAHQ==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a059304 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=CrRiqOPGEFRxvRNxu2QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140091

On Thu, May 14, 2026 at 02:15:12PM +0530, Rakesh Kota wrote:
> On Tue, May 12, 2026 at 02:16:07PM +0200, Konrad Dybcio wrote:
> > On 4/29/26 4:09 PM, Rakesh Kota wrote:
> > > Add RPM Power Domains support for the Shikra platform.
> > > 
> > > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > > ---
> > >  drivers/pmdomain/qcom/rpmpd.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
> > > index 15a11ff282c3f86b1e86c6604d165e297620f6cf..6f751ee5a7833912d54d2bcfd5d85837ab7a97d3 100644
> > > --- a/drivers/pmdomain/qcom/rpmpd.c
> > > +++ b/drivers/pmdomain/qcom/rpmpd.c
> > > @@ -863,6 +863,21 @@ static const struct rpmpd_desc sdm660_desc = {
> > >  	.max_state = RPM_SMD_LEVEL_TURBO,
> > >  };
> > >  
> > > +static struct rpmpd *shikra_rpmpds[] = {
> > > +	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
> > > +	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
> > > +	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
> > > +	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
> > > +	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
> > > +	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
> > > +};
> > 
> > This is identical to sm6125_rpmpds. If you're sure the list is correct
> > and complete (no LPI domains etc.), you can drop this patch, and proceed
> > with just this change:
> >
> There is one difference — the max_state for Shikra is
> RPM_SMD_LEVEL_TURBO_NO_CPR, whereas sm6125 uses RPM_SMD_LEVEL_BINNING. 

It's handled in the DT. As such, programming model and the domain list
looks the same and compatible.

> 
> regards
> Rakesh Kota
> 
> > diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> > index 0bf1e13a9964..e7d9e8e65641 100644
> > --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> > +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> > @@ -73,6 +73,10 @@ properties:
> >            - enum:
> >                - qcom,msm8937-rpmpd
> >            - const: qcom,msm8917-rpmpd
> > +      - items:
> > +          - enum:
> > +              - qcom,shikra-rpmpd
> > +          - const: qcom,sm6125-rpmpd
> >  
> >    '#power-domain-cells':
> >      const: 1
> > 
> > 
> > Konrad

-- 
With best wishes
Dmitry
