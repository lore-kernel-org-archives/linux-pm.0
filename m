Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6333F385
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729050; cv=none; b=m0AavgS9/6GP5PaZy/YQZnzqG8cvXekDc3Bg+nbjTmAMK2lXhn9R5KvyitT5rahMytKUe8Ew6Iaib73wbiT89J00sg7B1K3qNbFvr3grPZDm3DDBNqO8+axGOroxIVjANVko3u1kIchLozfOBls62YAA6BMhnM3ub8lrKJxHTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729050; c=relaxed/simple;
	bh=vXRowRzjtjaxrwD+rji2hr2nDDh0fvUrsn1Nk+7jjc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bywXee7zWT/+inPpLwadG22u5yA6SqGuQgoo6eMmAPL5lda9sCYX/IQ+ZYTDL48JCfAWrQj75neP0u4Cwq6+Hn/cvysowBV5FWNFLfakrukZYKTl9qbIH7INeJEVUIslsnJN9YZszsuIPzrw0w3TEjT43T6nfgsHgL4QRvjZxbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C7+uhPs8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ye7S7/eC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7+uhPs8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ye7S7/eC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWric755498
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jRWoVSO4ykvp/ib+Cr2av0mo
	9ut/H+oT06MlZHe2x9o=; b=C7+uhPs8U4bTkQ5F+4B4PNYp4shC6tF+Jc3mFOfV
	skKHC87TgKJSHWYnD0BCLZa/hXViOh9r5Erjr5UD8/MmoXPpYWgkTcKAfgZ+Rgzv
	q68qu6HMMSEmmxH6YDjt3uDjMNWkpSEMlNzNNu1En7loPQr3N9GEmHe9l0Wd5RzZ
	eVhSHtGq3vKqzzzprglO+TruUsEPAw/YVc5NU7/SYrPoMNLV80391ylgaqngWJnY
	OGNymrbsGMSPo26Yz7qQzBoWLu0mkIoV/323zWhV3CHxOBViMd0C9AF22V9YKnta
	Gp+jmb4Pt3K7qxKWk/+ou21nWNU8aloLukigNNj8bg9rjg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4tg7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:04:08 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-96966afe3d1so11449502241.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784729046; x=1785333846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jRWoVSO4ykvp/ib+Cr2av0mo9ut/H+oT06MlZHe2x9o=;
        b=Ye7S7/eCwHCKP4kPuLMYFODk0zMHWKvfZRs84/3X+xEYVjn8zqMKiQOiXKI8UymqAw
         RPdtXqgSh4wWBB3f3MeqSVn1Ng//UCMeTYH+n1uXwiiUCuWhotNQP9EYpo55ngS8bnEi
         DxziBaRmhu/SrFvnrSRQpJucsQ7saPekIUmzWcdqOLCywPpa/iqMsdII4hgha3JKUbbR
         SiW27Ai4Hxj1nMb0mpJprdH40/xgAWqBU2r2n9szi6ceZUMP4FVtlXx3L2tAtLba2nvP
         EDdL5+qm0gr7snQ2zd94pZHGRkHjxP9bOhtCPNOeYzhOHVLJy2/yH4Vgt8chDc1OuF+1
         xyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729046; x=1785333846;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jRWoVSO4ykvp/ib+Cr2av0mo9ut/H+oT06MlZHe2x9o=;
        b=HEZ8MGKewFTY7dSfKUp+e0GLxBvq0treXlWh2Xqsq67NC6+UR0tbPN8zyzqWjCkH4c
         l4C2HeLQRV1GIUq1mBe1lUSQt+VwYZhML9eXGpmMUi6xKCnnLC5q3A9Rag0FUZKKoYmV
         oQZXXsjQVtiysOsVbKXsFag5LRR+9tEK3fWcNpGpPN0/nTxCCMZlrJ0UXCKoHKiAqEdM
         XRHWqElkAC84PXan1K/SRnzjqrb/JJWGDUJU8Tu7vSqzqJvMQoFSNJ6iH8ZWtkXGZZCF
         Zq3rcVU0Nxu4zLiixWCJNLz/lKB7O2OiT/XR4DftPDNvmoevcGoANi8rf09FF2O8FsaW
         +4rQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrxbnl2wNTrT9fALOHKm/g03F+IcJjkBdiAPDFeHEwMPTaJQ7+Eh6Qvzq1x+t2JNUJN52OmIIxxwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5CAxEPIZF3G0UgASW36CEAJBLcVtKxs4fBMrxcCblWvT5mlf
	yMn8bj7A/8wvXZZnM+qlYvX1ELj/+9f6szW5bhLtZZjBwBT9n245dtSsSlxTJZBomxFK3E14Xjj
	1dpbp3tLYSDTc6wCaFVGwJwWbKlDeX2sH5svkA+HZw6dhuqJbA/MnQv3uoRry5w==
X-Gm-Gg: AR+sD10+EsCg45/3dx96WP+FU041OEp8USFyqi+jOpCiG351gBtRigPQ4bD9CQH9ukY
	t30HHYZndAqadOypFF6vv0RuyhTRpEfVFE1YvmceH5Dd5PkIcLWpxDP//uxleamGGeDYz7yRC2W
	cahsgIZJz/bvhXIdwEMFMVLcOvkF5k/YoUtMLKB+an0MnhBa5j3wXLcJck3pmW+DDPU9/4JIyF4
	qJHRR9Kd4HA9nrNpJ6rkbbROut+PP8slW7GEn05VWSZWSLI3VV76vJPLbdszpK0wzvSbQ2pSDwx
	g7p0FeKbq0kxPzyiCnV4Kyu4Qk8Xs19ilhBwYRQBZuqXJMYjKKr6B7BW85GrHp9AiEkdVMq8J7c
	f24KhKxFP7aLi4vHT12EMrvJ2mHYwFjUYu0mh0UHo73sk7ImJEkatVucx+VlwbBp3bwfIF8Wpa3
	dkE7jE0oQ4BFil+A==
X-Received: by 2002:a05:6102:6a81:b0:738:a8a5:4c89 with SMTP id ada2fe7eead31-747536cc599mr8709192137.18.1784729046685;
        Wed, 22 Jul 2026 07:04:06 -0700 (PDT)
X-Received: by 2002:a05:6102:6a81:b0:738:a8a5:4c89 with SMTP id ada2fe7eead31-747536cc599mr8709058137.18.1784729043791;
        Wed, 22 Jul 2026 07:04:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef6c41f9esm4375821fa.26.2026.07.22.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:04:02 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:04:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jishnu.prakash@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com
Subject: Re: [PATCH 0/2] qcom_battmgr: Add batteryless DC-adapter MAINS
 support
Message-ID: <aimahyy7gnnw44pdedtt5xovq7nqw236fb6hwsm2fqjzagmcm2@7767eiubcdz2>
References: <56a54a34-1040-44ae-92e2-ce65a3d3acb5@oss.qualcomm.com>
 <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>
 <ag-NLvh4ROgTCs_L@baldur>
 <d4001407-cdb0-48ee-a138-87c94b5dab01@oss.qualcomm.com>
 <20260702111737.2qtjcfskulav4usd@hu-kotarake-hyd.qualcomm.com>
 <5d5c693b-bd07-40a4-aea5-d9e1884aac50@kernel.org>
 <20260703091319.5kcsqjtx4e4rshsy@hu-kotarake-hyd.qualcomm.com>
 <7c7ab43f-45c0-48bc-921a-8820408c88c9@kernel.org>
 <20260716084850.gssw67izy6vq36tg@hu-kotarake-hyd.qualcomm.com>
 <alltBcYWULOv7nEv@baldur>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alltBcYWULOv7nEv@baldur>
X-Proofpoint-GUID: VhNR2bIGkIXiGxOgutQm7JVfx21OemAX
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60cdd8 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=Hma63FIqJW4f3ALk-BsA:9
 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfX801nw2hHZZEX
 fJTgt2VO1N1nubePOIWcTFliLlZWmJxiukJUIYFNs+LsaT1Z0JbJewIaIX3hjpcKPUJaoxt4qyo
 z7bsf6tkEdvf/ZSDoK+s9NIsPaJZn3q3Kk6Xc4nrxQp+tPckx7xIN4pubbl+lYKoQ0J7ZcN3X+m
 eJX9RSvDUQGlpW3mvecCSIhGFgd0Rk3JyjC8BtNJv56yw9K3bCuYgwMxKmwpQ7+fpdqeKLdny6Z
 xEqCrmlWKZy6mnFGCZXItmrnBsqae/8QAc+KZQfUtz2f+8pYBfT3J3yz1Hxq7W00yiOkfsI7hOd
 d/uj/mLPH9866bIs/H1IZAGfWxRdtZ1FpLz1SuJ8U91rF6RGfQhG18u7lSBBibyvVXMasWC7T40
 XHQTBil3DjLDEo8Sj6zWPCgGsz+zSg1qtSJzZCKDfgF/mIqZH2cZIDw99S9B566UzapRu8yw2ZB
 ev9Cklc2Fr1C7fNM0BA==
X-Proofpoint-ORIG-GUID: VhNR2bIGkIXiGxOgutQm7JVfx21OemAX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfX/SKBpDGeuGdF
 loN9FkhppvK1vI1sis7OuSuWBn4DJrWakumLJWI0aPK6XtyeJ+9agCnvzkb1zqvtYdqM0R5HMes
 Fs85ESR+3n9Of3TquXSbJhJeGDvt9zA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220137

On Thu, Jul 16, 2026 at 06:54:36PM -0500, Bjorn Andersson wrote:
> On Thu, Jul 16, 2026 at 02:18:50PM +0530, Rakesh Kota wrote:
> 
> I think this is similar to if we had a discrete charger block that we
> describe in DeviceTree, we would somehow have to describe the
> "configuration" of that component.
> 
> But I don't think you considered those other use cases. Perhaps this
> should be an optional qcom,battmgr-interfaces = "ac", "usb" ...; taking
> the list of interfaces that is actually implemented.

I like this idea.

-- 
With best wishes
Dmitry
