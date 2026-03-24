Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126033D6C7
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392678; cv=none; b=qfpiof+gGR3XpDO5UcRLrE2uMqalhEi2/5ZBx1v1QdzrVWnTqGfE8HDzFw/DIqUO/UBsW4J8YLkI5PPngt4f9atpz1/jFkmZNO7B9dTfBywbyUDcDOpC8Pr0HYN8o9wM1ncXqGkpgRZqAnKW1nsMpRNjuo/rs/6KBc21GlMkGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392678; c=relaxed/simple;
	bh=jfo8OB3h3iXt3h+nZR0znNzllKjX6tOd0BY0feLB0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeZjCoOehTx/z7nwuDIdSg2U5DFihasVndONd9ovkBf+uDjT2XNArZ0X9/HQwVbZ9oCWSyMfPYd27EnsiDQYtOOn50ieklhnNzrKjcXj5TncNr8e+OcS2FMbYU1jqsIcZXYMa4zoyWk2IkZze4OwbQ5ofMQhshUyQJbiTdbmi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g62vyGwf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jFZnHrEY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g62vyGwf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jFZnHrEY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJCxg62340459
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0u8uB6GNrhdJsmH1ConLZooY
	IPLJEAZiTZjJQILyV7g=; b=g62vyGwf4+VBUvoexOz56S/vSMc/YFMB3YxqzwXx
	a8JfOUSR6YZCiIx6p9lg7MMvPXdHXU8eEQ9J26239/cwvnGfizUv5Y6Q1/rtsRvI
	dSkDV8DRbUjaScAvEFpSHMukjWNkk8EzgjuhAPvHl+CiEYx4MBNcpdvbQrSU/lCY
	FbnCgPnlQz5NkC605RPzhABqfIi0QXjiw8pp16t83zPlRUMBnP5iAKVL2rIwueHO
	Hotn8rIRZRo9kWxiA0/U9D/8Mgs1fI8g4mJBm9z40h3Q2eRgncZzUji033O7jbHP
	a1SJ2S4x7+zc8un6PW+d8Efo14wqnUzkeY0aqKPE8TkNIg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw42g9r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:51:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5091327215dso79531cf.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 15:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774392676; x=1774997476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0u8uB6GNrhdJsmH1ConLZooYIPLJEAZiTZjJQILyV7g=;
        b=jFZnHrEYOqxLwIR73hU229UmcfgqcV7CmY+uMovusSQdEcP0f+xZ0fvuXyJ8oia996
         x0qh0hhznN/T5BndVduBZybCjC+l+OfQGpoX5YCh6P5G//VyPY0lofCUJI+5U+7u2qY6
         2o9zV1YjzE+EEgisIMdjbow1cNL5pe7dHJs/6q2SJHf4W5uQSN+TPlWSrGTX6687AhtT
         Jg0Cox5EJxka56/tKh6QFmoroD/0AFuCLRHTbIwtKc1++wTqtEBXawHAUSSG5vSx9tuW
         F1p2A4h5tCz4i5Eod6CAVLT83Sps6fIDBegsGOEwIzsEj1rnIgzwLQPyXaIHhxMDOiLw
         idaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392676; x=1774997476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u8uB6GNrhdJsmH1ConLZooYIPLJEAZiTZjJQILyV7g=;
        b=khpRL9k1Dp5kAgPJWFBI6qDwYAnPLU+uVxVPhKyxex6zCE5VdcLUJdBy1a+PTlmmC2
         A5oZA8TRC/wjI1eCl3FlFPWRHitSsPlhOhX8kG79kWLuUNLKQl70+/wPcpvHOB7W3j3s
         oBTA6C7YUu7GbN3bJdEQD2nQQXeeDOWjEmV99rQ8QYfgn2FuPbXZ/nLrPQ3t8cfxOuO3
         WfS0IUpCFK0s/QDjMqh9N//bZjWWERtjOAbaF1vX8pGUTivH/BD7nfoyDYrhPe+Z41u6
         ViIIJjSC9CFg5N+HfGO1zO2v1zTPymtndZijgaKTcxysRDEt+bRk1h6gobE9Sx6ABpAP
         mlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUzO0TqkYGt661CYoaJwgyakjoQpL1ZFiMj1NZJvnN74lLRwyZVQM0TauvQsxPPAgUMUo5U0z+SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2OuSeI1PlJhWYs3ERdMblJY6JyV+HRL9cUZwIRn7LlGf17ml
	eDNkCLVLY7UwjG7+wxSP4ZVYXl8rQ2zpqGvY28kAKkXWKESBS6eeoRvVI2WN2MlHe46xv9Z4P4h
	vOQcD7I56ED8AmNFptABHVdeua7bkHz2bhnFrfW78RM4bMUpY/hNcYN0C3+tVVA==
X-Gm-Gg: ATEYQzz7KXHOf26BTH4DPXK+oDm5zjejEfqvGgOnOR55YgQ3lFryIyJp5rYmLLWFfET
	Sm62eVLZ1kRjUehOjyOx3hPeh8nL0MI2BJu39Z1EMF7Yb/i80BHOLVuiUTycyJ7HArh8HpdKi9Y
	yy/3zjyQA0G0Sd915BEYk/ITzwIezhEWYoUVUiW3BJEJG4pOh8MaOIipl/pjYka2PTdXQoVZyKj
	5Oa7IJolIp22gg+Ic9oo3m9nz5Zq1wBv0ptv3NRGBFKZZUI7Jny8t06yu5xLQVImsijpAuKVBqd
	ZwCMl2cnkXVAeGSSulafwEt5BkALrsM7ky+OVysDRja3yJON52tOZMjjaw4swQ1nYHHdMhpAtnY
	k7Ivl5EbR8zweQto2Dent0c3ce0ws97rlSaqAE4epyRho0Zfsf0eVGC7cG46Y3rrtLUJFpfSDDp
	J7kPLMLq4yPAO2YKNBHMctMnLjADtFvjSi6Ks=
X-Received: by 2002:a05:622a:305:b0:50b:6cc1:38c6 with SMTP id d75a77b69052e-50b80e45d7amr21331781cf.55.1774392675759;
        Tue, 24 Mar 2026 15:51:15 -0700 (PDT)
X-Received: by 2002:a05:622a:305:b0:50b:6cc1:38c6 with SMTP id d75a77b69052e-50b80e45d7amr21331501cf.55.1774392675338;
        Tue, 24 Mar 2026 15:51:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a298511b9csm704111e87.58.2026.03.24.15.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:51:13 -0700 (PDT)
Date: Wed, 25 Mar 2026 00:51:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] interconnect: qcom: icc-rpm: allow overwriting
 get_bw callback
Message-ID: <2453s5yfmk2xrgyuabyhahge2cl2uykdlpcxlmwe35uf44sjpg@pbc3a6fxtlya>
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-4-7892b8d5f2ea@oss.qualcomm.com>
 <abb14718-3d94-426a-a0f0-d101470951ad@oss.qualcomm.com>
 <75zgkrwvjsmnvjeyosl326vcudklj6yhhyskdrsm23kbzhgve3@64nezs6c54kz>
 <1376fad4-efc3-4b7d-bff8-9510ab0d3800@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376fad4-efc3-4b7d-bff8-9510ab0d3800@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3NiBTYWx0ZWRfX3E5Q9qtF2v64
 H6123sX3oWI3MUgeTa3J5x3m4tIyf8A0EX4se3Uz6P03lPVTUrNFcZsSKAMRMoL5zQrbMRJpLsb
 p5t5UOU9vctjVReGiKfn6aO5N7epifOF6nkJ/WgHf6CrD6D7sYeW5ez+l/M3zgyAojtaJiCJdfB
 sRwEIWWpWbCAJZObxs8Bqd2lLBzVoRhvOMx918qjBUcBojbwUZnvE3CCENMdqf7KKtH+3WQtDJD
 ta9Im9z+V6t5neZNo7NO0dLyz0WKxOBFoWL5n4AVfBrStxLgyH48xEsrkyFIZvnNTeDzVoFl9Xn
 i7mWXSZgYs0MuSsH7cBo8So+HlBazJE8Q2sLXUNExVW2ho7Q0PbJHycudM22Huqq6/J7Sp5/ksO
 luxRqyLmjnImwFpgKns2o9Q5REQUEsj7RJbZo7IQwu/9uYE36QLqznyWF4WI/RdTBjsbP1l5H9s
 tqec4uzVOLxjLqQD8Cw==
X-Proofpoint-GUID: IJZs4K1ApKMncaHt5KniSCeOIBKot9xs
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c31564 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=PuShR9hzWyKW_qgfHhoA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: IJZs4K1ApKMncaHt5KniSCeOIBKot9xs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240176

On Tue, Mar 24, 2026 at 12:34:35PM +0100, Konrad Dybcio wrote:
> On 3/24/26 12:14 AM, Dmitry Baryshkov wrote:
> > On Mon, Mar 23, 2026 at 11:32:33AM +0100, Konrad Dybcio wrote:
> >> On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
> >>> MSM8974 requires a separate get_bw callback, since on that platform
> >>> increasing the clock rate for some of the NoCs during boot may lead to
> >>> hangs. For the details see commit 9caf2d956cfa ("interconnect: qcom:
> >>> msm8974: Don't boost the NoC rate during boot").
> >>
> >> Is there a single specific bus where this causes an issue, or is
> >> setting *any* resource to INT_MAX problematic?
> > 
> > I'd refer this to Luca. I didn't experiment that much (and also note,
> > this behaviour might be firmware-specific).
> 
> In case anyone's interested, it _seems like_ it's
> 
> (RPM_KEY_BW + RPM_BUS_MASTER_REQ/RPM_BUS_SLAVE_REQ) failing with certain
> nodes

Yes. And if you check, these nodes have QoS settings in the DT. Later
kernels have added a guard check (.qos.ap_owned) and dropped mas/slv IDs
for similar nodes.

> > My goal for this patchset was to port as close as possible. We can drop
> > the get_bw later, after enabling more interconnects, writing the QoS,
> > etc.
> 
> That's fine

Rb?

-- 
With best wishes
Dmitry
