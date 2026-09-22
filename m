Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F347D932
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079650; cv=pass; b=jBQqiJvO14r2GxyVQDSYC0sH+hpvnlRuh8vWFaTal8DBmWgjTQQjs3rvseYoNKGk6Bk5IySiVObWXXa9arZGYDdt5/H9ISPRJTChuORcOApHbtEkfZtktTmLTy5rJ6vMryUodNUJ73HJyReTVgrGmBfrQMFY4hoBBKL3vSjU3hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079650; c=relaxed/simple;
	bh=MSdsTB8asp6sbX+GEc7UhobdmE9wd/t8j57szPiLqh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik2jXB/FZmgoVPWcfVkisBKWrOGXMHaT8x/Cm2QD7/p5ETlCVdN6ZvdHdnicaVdnbuUq9Bx04eGRi5w48j2kHhAmhnJxUx0JrokV8GJRTqwU5t00nPZecIdwl6deIkcraTrfBDFXu8/8ni3nVeQDajPlpnNvlEG/WBP07qhixF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y8pVw0Hy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JVnWbDFi; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y8pVw0Hy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JVnWbDFi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBP3T63670695
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+05yLhpdjxIjVjNj5alAxW0Kp4QLw+qzcHO01XuOZE4=; b=Y8pVw0HyVHJ7coKM
	k3sofOBeQp8+A1tWooBMhmH6659wA72pxymQfJNeHY4P6/Pzn4Bg4JEL0P/1AGCk
	xZMHnhHBhci/6OggyqWoQnnVa0PH7qgKP3/Ln2VhSgjQv63mNOhoV6qeNerbOh9Z
	yqHd5foamo6LwbwkrcA80SxABzi31nLF91XWV+EFpMW6x15jsQj6rNy361pT9oAu
	6MIayiHAZDU/BKA4LDDjXHzsidYTIw+ZEWRNTSBG/h4I/hQHXkCYNI3X0jHuqOV5
	Uwz+t87gBXgPMBDV8tNOoF6TlY8fz3MavwroOVv70rVR1W3hm3q1fo42pYcx7vu3
	U/iRww==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurnt874t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:20:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so5451055a12.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 05:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790079647; cv=none;
        d=google.com; s=arc-20260327;
        b=Hp/5GWfXOVX1wBkZfD/FgBgYHLv0Hai7gpDAbdQiIG5J96LUCPZ3uIP4XKTa2fNjvb
         nGdEWG+gj0HjZ1WMGomox4OHX50MWNdREEGnZ+JVUbjGLYeNT9AlM4s/T3Iyb47b4Vil
         aJuq7M4MjqIak8YCqv+M1ewiW4edP0q6yYldEY5JvTVeWDKfl+nrYrbqHHY24rCm1sWA
         1yC2+NB+UQqOeMZhtZAkhARIx5cfRPVqUtDCLeuXgRqWLlZ2STGWiFaBe71BDrEiDoRg
         bfoJscfIWT1O4uLJKgBadO6SEmm3i2wRsWMEcXEFJx9an7Dd28I3voaWuVI4l42hrSPh
         L+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+05yLhpdjxIjVjNj5alAxW0Kp4QLw+qzcHO01XuOZE4=;
        fh=clLMt8BV2bKwmccBzM4VZAqYfEh6uSrctMPMxmNFLuk=;
        b=oqAjJjFPYsb6tzhVEu2BvwEtaba1G7E8c6BIsp5m1I1h52/7MRQveTifnwB8l3ekB7
         OKiso5F8//WCzcE5gIB9Z7F6Ld6zfCmkV7OuV6Ti8DckifKTNgPp/2oSj/OVgZ+A8D3x
         /UEsliJRFPqnWH4DtCcSNepGAippVPV3JSY20ozcPG722+zhCAl+HxnoFX3tta72Zxzr
         xhqlsbJ5UmlD4CoCySnL7zYKzHa2FFXmA8q7aSoAuH7MIfM8KUkr34hvXO30upt2xOgh
         6dTxgUP59n8ujh6Ie9aFlvRkcUpULlfHlIBBNLfYKcbjpnQK2dBFQAhMjU5oUmVTY4Ps
         DZCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790079647; x=1790684447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+05yLhpdjxIjVjNj5alAxW0Kp4QLw+qzcHO01XuOZE4=;
        b=JVnWbDFiC8Sm4sXt14cHmFMJod3cF7+xJIkYEEzznWA9z+MMd1c1J+dO92fej1Cabj
         rqoAeZxvxTUs8//gGUSZm3G5Z6qZdr8xlhjmYe1WQNNA7bCPfJQoEKeavf5QI0bL+oZd
         DgC8XzTXxtacNwLC38JvJose6uMMN11Kp0R0biFw0d8F3eaiLUAfiBVWBaczPgBFkrwh
         6D0sUmUlQvxQilW+QvXFMqWv6KAiA+baGv7RIs240QlkUobVh2U7yJw6EsH1wuZV/c63
         77HiuMgJ0EYQhLl/YzoLc31PLrgN8sYUmrsUTYHmo2pMcEwzkbEVxqIFB59UdcVgQOgG
         BvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079647; x=1790684447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+05yLhpdjxIjVjNj5alAxW0Kp4QLw+qzcHO01XuOZE4=;
        b=AfGW6AxePP1wH21GxzxTQ1C1jYLwoHttxIZCg8wdak6ZkqSHU61EsjG0cdFFstBCVq
         napZdfaLwuMRFzdMv+RbsLP3rBeJZQgYZS97osVrj5vKBsth+TRF6jjlSV+C4YT4izpb
         AE5ipA+eDbtmM7SgYVcdXpZ+c77ENLgCXKguhHRf6HSRqye+Ml8PkSrUWlXADXgVZmP3
         WcJo1CwkMSOWYiqv+MFwLRCA8Rl7eQhj931RQuB8vEotO9Aig5Reuyydo7gz96JxRh1B
         JcBOTGvgoiz+KuNVrtwCUnJfjM2Rp1/H8mqakgnfNYmy3EumCkInGWUjQ+/kI8O2NtAj
         NPtA==
X-Forwarded-Encrypted: i=1; AKwUvBzJV9mMFj5+djRHcoT6MhRnDpMijGt1skjd8AZxLy2zUB2Kw9EGebIUMolom1DnRUppqmCMz9pI8Q==@vger.kernel.org
X-Gm-Message-State: AFuF++npGAPx2wcWVozTbW1j2SMOQRqy+6K1xLjN8BbKvprRe+SXg5VR
	FyjI+TG+9oAX1RMNYCG7mpP791Ymh9xwchvPoVfWSDXeCCiLkgRkvWiCEiSxcG/vqFdZ5oFaRsv
	gA7HfrDDVQys8nQxrYyav7uYlYMPECmHOnUNM+DM3GvOtLXE3uxTwfg0471opv9gfqw2BYDiB+F
	m94mXKlB5MrK+/y9wHrbXKUhXs11HBGSNS+CF3
X-Gm-Gg: AYBFou2/e/1wH5iy5OY8gCoYflag50rJAi9Mf13AshRuaE0GebWlfWSP5xDTau4UHH9
	6lPX2/QLy7vfQyGOJzL1yDSM50bQ+wukZUZFM1MIU8mMvseVB8hFW+G8rDwUYoh+5FsRR6UJlq2
	s+tdadmMOGocQou5hH3zXw/8EleRjY5gN/369Y4e8Ae6Wp3DxbWvNQcUa5RQ==
X-Received: by 2002:a05:6a21:8287:b0:3dd:ddbd:c5a1 with SMTP id adf61e73a8af0-3ddec1bb561mr1447629637.0.1790079646790;
        Tue, 22 Sep 2026 05:20:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:8287:b0:3dd:ddbd:c5a1 with SMTP id
 adf61e73a8af0-3ddec1bb561mr1447597637.0.1790079646271; Tue, 22 Sep 2026
 05:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090134.585588-1-zhangfei.gao@oss.qualcomm.com>
 <CAFkd8hth1ds5j9jbe3vjjpCYkbTVSeTiVsQvzy30YCyFUH83ZQ@mail.gmail.com> <21aff47e-07cf-48b5-9752-b1a9dc7e6095@kernel.org>
In-Reply-To: <21aff47e-07cf-48b5-9752-b1a9dc7e6095@kernel.org>
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 20:20:35 +0800
X-Gm-Features: AcwNN1WMrRCQu0nVlsJVMe76UpuBh2J8SD-x-wYYcin-maJATBqrUQkOk85mQYM
Message-ID: <CAFkd8hsmBeDzWn1OwCgM0bmCmAP_B5iD7=9JqwzYnziwOWB=pQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: add nord cpu-bwmon compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, shengchao.guo@oss.qualcomm.com,
        bartosz.golaszewski@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: JhMjbW2f3mgZpJKov0VgODdlZUYM60MR
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab2729f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=tDlUhY5aTNnqvAx6hSIA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE3OSBTYWx0ZWRfX1qJ5EqO8liR0
 riasZI/HNLO/14qZaVUOg7kybi1Um/HG1WHBZJ/flDYUbhIeIqlcIoNshNiJwsuQm3iGFOREpyY
 D425TykzFh39aYrl7flNicT82mAL3BBQya81J+czNCa26cWyjyZxcAjhC2lYbpKcDf1wIJ44QaG
 tgirEbWXG5F3Ov1zSOrrx7kLPRvz8+ZeN37LhMPCZ6lzBXCvYJz7I7T3RKwEpYjGW645WhFBucn
 5D0X6lHK1TYeWLBe26jI/Ib+dENYV85p7v6rGgRK7c7/+w9NfPlET71j/xew65vIRBGCaXrdOyL
 BbUjqtFlLFNk77M8THUlFXuXUQFCTR7yT+rPbZ8zeGOR/6isiPj2u+jHaJoaLMx87TnZ5VLiMDC
 ePaM0qij29wMM57t4C5m17yWQnxnSIrvstz8Crj0jpB5cRUCWMKbps22YecFvfI+8zLyySRC4rA
 v8JRx7gheJODXFm6ucA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE3OSBTYWx0ZWRfX8CEPkpkH30d1
 Xbgjbs3LHTYlzz9lWRgFaA/A40I98nav8H07KsIJdh5ew5T6JxzOri9xY6YylpKyIy+iWp29ZlL
 zBGEkvJYqVTV511iLINsBWA0H0g2KLA=
X-Proofpoint-GUID: JhMjbW2f3mgZpJKov0VgODdlZUYM60MR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220179

On Tue, Sep 22, 2026 at 7:38=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 22/09/2026 13:21, Zhangfei Gao wrote:
> > On Mon, Aug 31, 2026 at 5:01=E2=80=AFPM Zhangfei Gao <zhangfei.gao@oss.=
qualcomm.com>
> > wrote:
> >
> >> Document the qcom,nord-cpu-bwmon fallback compatible used by the
> >> CPU bandwidth monitors on Nord.
> >>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
> >> ---
> >>
> >> This compatible will be consumed by the Nord bwmon device tree nodes,
> >> sent separately by Shawn Guo.
> >>
> >>  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 =
+
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.ya=
ml
> >> b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.ya=
ml
> >> index 21b4e04727de..8c82103fb86b 100644
> >> ---
> >> a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.ya=
ml
> >> +++
> >> b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.ya=
ml
> >> @@ -30,6 +30,7 @@ properties:
> >>                - qcom,hawi-cpu-bwmon
> >>                - qcom,kaanapali-cpu-bwmon
> >>                - qcom,maili-cpu-bwmon
> >> +              - qcom,nord-cpu-bwmon
> >>                - qcom,qcm2290-cpu-bwmon
> >>                - qcom,qcs615-cpu-bwmon
> >>                - qcom,qcs8300-cpu-bwmon
> >>
> >
> > Hi,
> >
> > Gentle ping on this patch.
> >
> > Shawn has posted the corresponding Nord DTS change [1],
> > which depends on adding the qcom,nord-cpu-bwmon compatible in this patc=
h:
> >
>
> Based on acks here, this should go via qcom soc, so part of DTS patchset.
That's Great.

>
> > [1] https://lkml.org/lkml/2026/9/22/844
>
> Please avoid using lkml, but instead use lore.kernel.org.

Understand, next time will use this instead.
https://lore.kernel.org/linux-arm-msm/20260922080416.484280-1-shengchao.guo=
@oss.qualcomm.com/

Thanks
