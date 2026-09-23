Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E83B6C00
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165733; cv=pass; b=q1szeZQmKwwYh9WJLJaLp2yARtP0wVy5r/lekyaNvrtMHbBej1BqB3TDlooUSB4JWM/xX2C6RHDQytms0jrqaieU5CijpFDBgwN+51k/JJWEtQqvXOY+cZBLfhvmXMgApvLTFe7Plt39XHtB3cgmZ8/50hlKGGZ9JxH4OawNGhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165733; c=relaxed/simple;
	bh=5KBcdSffm4dlIV0YyVdl2Jl/eg8JxhlguKWSqYByvUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5/tVBriY+wMDwivYaj1lMriANeVFJA0nH3EF2gpMvIhlkRutbpE3TMeWnfWwGNirvrtjS+4DPbTdPmI4A4pdn5KmK4h6qnusQaj5kIJdLQ+bXRk86NLIVgm0WZYjHJQHI+d51VWzbklLqGYrgrpaB03zSONmU/r4BN1C7lETGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKz+l+81; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EVX25L0f; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKz+l+81";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EVX25L0f"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbYku3028025
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xwqrr5YcknBVVx+rZGdCo6L8R95M6EOo6myZTngecug=; b=WKz+l+81SIY+I4oS
	44zECxavKPfTQl2Ns1Sv4L2Pn0/8Um+wFPtB/28MmwIY6yj2odPRvm/KTXW/ek/D
	I6GetvLF6GlwfekM0XS2dvgEy272WAZfO3MXK3ijOSBQw3UxZz5tzmgw815dDdu6
	uptlzcNi4faF0Jn1s7rX68LpQPyYpSPXh2o3PmQtyQfzEYn4P8mtcbZFjfgMSnF0
	P/082aJeYcp84krLOma+xfMW3d/ozdR8bnL6qqFL/5SxQelHa4rf17v0x0VDAeLt
	nmdLdzn2yHYmtmAdVSBWF7qa1spMbHxYrbQu5H5VZ/GbFlN9laX0jZQSoo1BJtdp
	5KIgUw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwarqx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:15:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df5a65671eso9348605ad.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 05:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790165729; cv=none;
        d=google.com; s=arc-20260327;
        b=AxJ6cbr0gwlmqC51CEZopVbhgLENQgJj9c5vyg+EbaCxt/oRFBtr2FQ+xw1eufoqJ6
         kI7Z433hSUXgr7JBcpx6EFdFnIp8kUl6hqzfuTGVxZHiZZuO0PXFNciP6o4tZxfgrru9
         eX0j7nDFX9PudEfgThsHaAWkil/3tO92dHBGSJewitXcfSenmgf4j8tZStwTclSljG6D
         D8l06T0byEe9xrYHu9E7jrgb3rHsZYrvlVhIpQwhyizXz06/nX1MRrsGzx+79oxy06ga
         7dX6I1KolPQj8/LXoRSABV4dLi1IiLKS9nSAzLJl74Hg8/H7YZZvqfBjET3JHoEPpAgr
         HIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xwqrr5YcknBVVx+rZGdCo6L8R95M6EOo6myZTngecug=;
        fh=e3PxCAUuF4IPB7M+/eKncKsNomuTK6uP9evB89AJSg0=;
        b=s3JNJJnIRkEqA15k+LXtV9hsEQmMkxbJy4Xxnq+v4dkQOEcdiYT7oU7yOVXUpG47RS
         GsP5Tvhwhli0jOwITxXqJv7iRasUMBEagbjNP30MqPeZ8sC0aD+f8U1x9YwCXpYpnsDX
         JUa478LA4Hn4DAf52tb0+iW9GHUCttfvg8sY1tBCGk9CjVclEQEWNGmRVKeflo8V+VC5
         k35QxtJUjpBjwRTkBH2w59s8w6HPslGCBryfqj5nwkKWOiEdfOfg/NbJvrBG43h4V8EY
         7yGnViEjATxi5XcFs0Aq3J4cGBanRdtGFXnCdnA2AtmvwCHnIp8o4t1vHsxtA5Eji0cF
         OlEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790165729; x=1790770529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xwqrr5YcknBVVx+rZGdCo6L8R95M6EOo6myZTngecug=;
        b=EVX25L0fGlnLRW2u6CMGQA8ZBMKAr7o/2ih2YrodxzZhcAOGVBjz9xwP4SpJdpsbgS
         6TKoSkBHszHyg9IgDs8CZtUso5ubxGPEwD4ocXZIkhR/YEstDLcdQmIFebcn7F86B+dJ
         fDTh93ZrXwEoA67PNiz/oFgiDjk70GsWcXF5EVNPtMHev4qiZRA30k387V3HCwcUjkv1
         RtC7lcKl1QiG71DphoxtTZW85oflKwNNTOZWfuO391AW/1+kueJn3XkmD7VJY8N+xnfy
         xiIAVUkE4nWVbcUJ4a/BPfstEx39KKDvheFEcqm58s8b+t7AjomyGkIvu1fZfZBR+nqP
         c23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790165729; x=1790770529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwqrr5YcknBVVx+rZGdCo6L8R95M6EOo6myZTngecug=;
        b=W7S+7FSItqNC6z/XhIz9UpYZt5pclM4MDF5nH+MdtAVzTjEU1YDtNIb9KOvnBw04DH
         nIm73+BEcW3CLeCq64K4ztt92P+Yaqx3iZ+ZoL4/5Ukz7rahTlROHeD9Z/sGkRGUViJ4
         IBEhRwviL6vxiShhcgwB9TML6j/X96mevZOQS+9kMldHlWr5FY74BEDzCIVrHnxvNEGa
         XKzp/cfKlbMB2Xuh8Jurdra0fzTRPkKCcxsFXl+6TkJKKUs5MvDyTIGJDH7exnuewQEt
         VGF6U4YHuFchvlnvc8cxLtGcfB0M0PcNSP6+DDTh30pG7hxJhPlRJoEyK8Le0AYmnL+s
         wShA==
X-Forwarded-Encrypted: i=1; AKwUvBwXNeCxWoUgYrUvmvl8NkQkIo38BEtve5Q8PpxeXpdx/ED3fuDFOu8SgtCP2VWsNskG9xmtwcUYIA==@vger.kernel.org
X-Gm-Message-State: AFuF++l9PAsYwYXeK4CJz9DhMssTUpmv8yaYVeGnBofmwOby8kXkrokg
	7r1cJkCX14qNsDCgjFObDiatnmb6+vPewXKbzclFnFF44q0IlJAmufn4bipfj1eDrwJxrpi5pKK
	EAfkOBwPbgU9Ec1AnxH4T2BFHWURjfjdHCMMW5SEo0mHyB/sFH60e0XGkkrkaReqHmKhVIQWwsJ
	qe2YpH5Naotndg4pDPtEpPbL8OTclOvfsBcUti
X-Gm-Gg: AYBFou1oa96OFv5sHyNoEopcpcqZUyAXMHuELAoPIs4I5ZtyuHVU2EuK9x7ovrF4Xn8
	metiZykCc9I35yldyjN+K27uzU82NoKnmW7cCw8OSGMCO3B7kPAJnaIEZIKIDtAzWmbreQqUYF/
	nNnd4xAuXYqtKfc/nve+S0iMIayJSVa8Ohc05ViyxaHUbhOLnGzZ0SQiDEf1VIIYd01Uu3
X-Received: by 2002:a17:902:fc44:b0:2d7:5da6:2af4 with SMTP id d9443c01a7336-2df609dab94mr31311585ad.4.1790165723863;
        Wed, 23 Sep 2026 05:15:23 -0700 (PDT)
X-Received: by 2002:a17:902:fc44:b0:2d7:5da6:2af4 with SMTP id
 d9443c01a7336-2df609dab94mr31311365ad.4.1790165723390; Wed, 23 Sep 2026
 05:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921033708.14433-1-phucduc.bui@gmail.com>
In-Reply-To: <20260921033708.14433-1-phucduc.bui@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:15:11 +0200
X-Gm-Features: AcwNN1VsaeqV92H7KEZC7boQTZb58RsMU14eBT7KgfgQJPOV9CTm7Q_Kcg0tGjo
Message-ID: <CAPx+jO_RAw54HMsgCSaxghtgakJ0rANSY-WY35SE1i766mMsvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] pmdomain: imx: Use pm_runtime_resume_and_get()
To: phucduc.bui@gmail.com
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, rafael.j.wysocki@intel.com,
        Jacky Bai <ping.bai@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Xu Yang <xu.yang_2@nxp.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ming Qian <ming.qian@oss.nxp.com>, u.kleine-koenig@baylibre.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Guoniu Zhou <guoniu.zhou@oss.nxp.com>, linux-pm@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX8QpFUqkgTMFY
 4Mj7kjEeHB5lv2f/m2Q44z7xLYP3tgemCH94gzRstCxmPbvNqyecYSEaXU9GXwTct1JjtmCTgJW
 kdXgn9TIMTmHpeREusb+Qq5Nj2KZPXQs7ICxP8Tfp4cS0RWsRQsaccANoBuDyXuOoI+k4vvc/rP
 NjnhPeiyjEHGe5iXRWjA2UM56DZwkYRAF8eFk1dDSfg1NoK7JNGIEo45giTQmCNoxNlqym9/6oG
 WOsmb2cbdTmyKbvYsiCf7srvlvBCagO+vJ1NlSgWY65gMwA2oHZyfldKh8Eb0gmePZSGiHXKrcf
 Drx+GQqHBM4YBPjl60tiphn6WdLbxr2mIsUGMcXvg1oEhOqbp4YxVmh1dAO6ue1tuOAUPUZgZ/O
 jShClbvu2juPq7iUboXEA7sNGJ6liL9QfolYxg/seZWTlR2CeewWyr4O9KUGJv6Y0CCp+fVeK4L
 JJDb8I35nfHDWY4ei4A==
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6ab3c2e1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=B7rF2LB79GkdTgAebh8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: DeO3vZKzgd8owL7matiYcSDpSOgMZbzn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX0Nn0AknbmgkF
 cYirp9DNHKU2cnI1h/y1yjX8BQGQSdP8nyQK5WF1vbLSeJFO0QbpRgJvHp/88oGw96nC5YWr6ox
 H2wyFN63ZG/IT1II/mBzdfNssyaZRW8=
X-Proofpoint-ORIG-GUID: DeO3vZKzgd8owL7matiYcSDpSOgMZbzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230048

On Mon, Sep 21, 2026 at 5:37=E2=80=AFAM <phucduc.bui@gmail.com> wrote:
>
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Hi all,
>
> This series replaces open-coded pm_runtime_get_sync() and
> pm_runtime_put_noidle() error handling with
> pm_runtime_resume_and_get() in the i.MX power domain drivers.
>
> No functional change.
>
> Found by manual code inspection.
>
> Best regards,
> Phuc
>
> bui duc phuc (3):
>   pmdomain: imx: gpcv2: Use pm_runtime_resume_and_get()
>   pmdomain: imx8m-blk-ctrl: Use pm_runtime_resume_and_get()
>   pmdomain: imx93-blk-ctrl: Use pm_runtime_resume_and_get()
>
>  drivers/pmdomain/imx/gpcv2.c          | 16 +++-------------
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 15 +++++----------
>  drivers/pmdomain/imx/imx93-blk-ctrl.c |  3 +--
>  3 files changed, 9 insertions(+), 25 deletions(-)
>
> --
> 2.43.0
>

The series applied for next, thanks!

Kind regards
Uffe
