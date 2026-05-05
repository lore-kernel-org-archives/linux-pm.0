Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336444279FC
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984097; cv=none; b=dLFcxmbmZS/kmLBcTEAqKk9FoU/PvZNOY955ZPdKq4rgWBEv3n8fG35SfgqKaGX0gSYycV8h7FcL3bEURo1tIujJ6/DOeHqnIkgNa62WJohKv/vPclec+cPHs9zadNni+qBb6OlpeRIQpEljPYsfh0WxQ7u472flm8D16QmCrCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984097; c=relaxed/simple;
	bh=QVSB9zeW1cVzDZImJhmHKrMSkvonZyQf+Q0wWptgK30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQgyHzCg03EIlB5ttijBwyDrja0M2vktEUnotqF6rViBBrlHB9REdGuxttvLwmeBON8AjWQAJYqVzMfTFJNjbVHOHgzgknJlerPfeNEByjaTPB1Owau82HDvuveqTxPt9LjzCQVssPxhd5SFAzVthH5xuU+a6RstpGVy1mZl8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WbABQrPT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dzOO/uI4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WbABQrPT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dzOO/uI4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6457WcXx1960442
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 12:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+ioGBgPg0meuZmu17V+uTlq0
	kyQl/5OzhCXSdlo9Zp0=; b=WbABQrPT3PY4U20cAxhjIVRutXNGLPDsFseVBz9V
	8o4pvRnRhbRbvn/qEOoOpo0JKGMrgvdLh0pWYQIXDXctRKVFfarsgY9k9oG9fKdM
	MPaXH5lZt6XRGEMppR9SMtzweevlyFKYJPjCRY6ppQDi1Hm/hxRQ1eEy7r7wFwaw
	66jhGJl7bY0fKpWE+bcpX71mUNLcKg/1bExz5hv1ltpKVyz1JlIYkBbV9ZGRhKTh
	4QImP+IIBoinege0FcsfkaDZYKaVpPdlfnRoRVixuoN14LcBEfY2V4mojg9i7l79
	fsyF10qEd8qqvMIoB3K/tKBj3pLhnh/82DdeoE3Hfn5Y5w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5dva6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 12:28:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50da529ff48so120225411cf.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777984095; x=1778588895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ioGBgPg0meuZmu17V+uTlq0kyQl/5OzhCXSdlo9Zp0=;
        b=dzOO/uI4vuCsdr5BbTx/jVvrC8aPKhBQ09wy+AMLdVclWhZJZlihOpqQNf2b0pnchJ
         L/qDcpOdLOs96lyPBxSS2f+1x2xsIoD1rz/SOuBus6EdenCcN1yPcw1cKmqmtb5ydx10
         t5opkpwzRANx4t48G9on1VZheTo9OgFxAHpyP6/dN/reHnS0+cVAfbANuNGeXe6J7fM1
         lGHpvt3n2z+Oz7iEdc6AaxgGykVeOVj27r3985kjhVWou+z8cS2e3/lMcrDTwPFKmVO8
         Wr0srloT7MRg3K9y/zQwRyuL3rAD6bSlgwAmn8oukImU2/PLbrY5WXrbPfS+u7jiBTrg
         M5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777984095; x=1778588895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ioGBgPg0meuZmu17V+uTlq0kyQl/5OzhCXSdlo9Zp0=;
        b=NQhxj5vJvkfWw/ksuEM9P/Mjsudy88Otu0ngddRf/4vQAbDI914E+FUsVyKFE8rfQq
         Hiv4b6Rqy89iNm1GSb/vSOo/E8uws0UUePGzPjtvA5+mhloOHmaOGMgdN4wYUD5+tmMH
         tG8iVMtBdRNuACSjZooJlA1yCgjnET7g4ZJ5FwLCOH3F0PYZId1EsqXDjHxGOWaCrUpZ
         cEjSEXT2nEsI3fYJJ7PmfaRcjwdDFrm+UTSVeaZbj139xXiOLwt4X8w5mN8pcx/hUBSl
         0lJKs1FchXH3tK3i/chVrybZ3JrbeB/j0b2IbAX4E84RaJN5wE7oNx7uk2xSYQF1VMZl
         vfGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xqxP03VIs0wXGR8oOsjGuPVPkmQVg0EqW2IzKWvw1FFcaZekl+QCSraD6PmkjmMTopqA//kUmlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtGqnZiPgardLR/DrB4NCSDbUIMs7IBc0k0zhxm7m9pwHiVpy
	jctCUp38nOeQ2HcBRYDEtG5cxrsPDUbhDOFW+N3HCRlJ/V7QAmS3hk0qzRn+RRLtufPM0/KMTwp
	rk+jI05Bg4iexsHOn7zSu9xLuFU0aEJYh8H/JahvDrNQVN8u8d924jOfnynrSHw==
X-Gm-Gg: AeBDievgD21mdipoxDZuXTIve6sIpuMJ2yG6rn751TjcN+oCWCIPrIQLpLFc0rN5MEL
	ZDVIwyw/FFkdwXWeG+DBhqhcbINREZT+3Ct38/DeoGjF1CHLY0BAhLSitRg8vPh/ih6+lc1x+kT
	5jCzEEBewmtZ0cFqjgOS2qC6eKq2jTI1h7RggUnTLABFB9/ng3mzUjCJbJ/4dXUjRhFCUpHTqkX
	LJWhFIOx60uto08uC1Hc707ojbx44f+N0O+AeEZSKKjxNu7yoPytuMwmTaH0ENFJdklGyugYWvj
	6cXrx9mgLgAsSGgNZLVw9UKIzg5G6ZulBiCAjJJ9uPHkucKjESu3E/KVqlLe73HaFCShGLU5Pfr
	HF7zELuKvy9Vg79jUs+nRIb5COk7JIqEEFM/E3GvCjMF+ti8GsUtvEegTXa8HBYNC0JTg9bOWBr
	45aG2vIBP4ZDzx+nJnQ6+AftdFRUSWQEmBUpQ6PrF3DN00zw==
X-Received: by 2002:a05:622a:199d:b0:50b:4b2f:1606 with SMTP id d75a77b69052e-5104be2d0abmr204278451cf.15.1777984094407;
        Tue, 05 May 2026 05:28:14 -0700 (PDT)
X-Received: by 2002:a05:622a:199d:b0:50b:4b2f:1606 with SMTP id d75a77b69052e-5104be2d0abmr204277971cf.15.1777984093941;
        Tue, 05 May 2026 05:28:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c346ccdsm3833837e87.72.2026.05.05.05.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:28:12 -0700 (PDT)
Date: Tue, 5 May 2026 15:28:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Move MODULE_DEVICE_TABLE next to the table
 itself
Message-ID: <et542nhqmxzs3vii53inljlfhvs2g7p57etntggrx6q47vig2a@ixtxrribjjsc>
References: <20260505102854.186925-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505102854.186925-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExOCBTYWx0ZWRfX9cZK00jV8CHo
 aPCzpJYA3TbF9wHhQaX2yZXNJu3v5Ck2CRYnQSR6vcur7ALd/tByqZkB9MzHRt2nj8dc2lcGQoi
 X83u24yLOSZmhlOGFMcusqKa6DGf6Y/1P2/KwMwBTNJnmJGEgele1XRnHkGGlz9z0Vuo5BHkdsR
 vVFgLUe5A53UXXXrILb55rSn+Dh2NDGQR7z569VBSIff5xDU/d2jLnTX8YDuM5M4sVXobxb21T/
 tp4nMgKeO3ci8e2QLQ8B+/Lcmp9X8SCH+7nQiiLTiI8YnYIka9QK93pkMfDucIm8MpED+ANqIUG
 ZRXJ+VKrsJJsX0sH4c5gMByF09pNcxJzRaTOUKL+5U5Tu8126ALGWQB1KJzvm5jdpdpsF4JJfQF
 QhTtf7oTvEYHNW4ZTDhfUd93kbbp22wSuynYghlJbaR5MMSyy9d8wbmGEHAQgcJDLno90vG/f0b
 iKjZgWvOUp3jWbRuhNg==
X-Proofpoint-GUID: Z4fq7SbgSg5VuceuglGIKAo5jd3cU1Sx
X-Proofpoint-ORIG-GUID: Z4fq7SbgSg5VuceuglGIKAo5jd3cU1Sx
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f9e25f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=kQAhAZ4d5FSSWymYSLQA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050118

On Tue, May 05, 2026 at 12:28:55PM +0200, Krzysztof Kozlowski wrote:
> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
> 
> Most of the privers already have this correctly placed, so adjust
> the missing ones.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/msm8953.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
