Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F13815F5
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307656; cv=none; b=PNoSpO7/Y7/nRk48NCb3Vi9nWgHB9AxOiArX9PX5sx1JRBgYYukIuwoZglNQ5BJQCNiuITczv9TBDx7VR91NDXtLU9s73vtl6ylAQQqE3jFPwwv0PUWwg8alWAK3wE5IYYc/iWPun7tmTVw9CM6JrGFpZmhWrNvA22PKmclHLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307656; c=relaxed/simple;
	bh=4QF9F6Mi1IakMkxw/M1uGq0XCyBXL/snCuE/s2NrHrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EixnvPL5nokfLDy3RLy8e+wbE0o1JT/eVpBjmDgaDbMtJJni+E7JmYkr02IqwGNGx0jkVSAQnnyzRRE+b3Mbgqjnxw54eSOTZEezvXe4FvJah8ct2CV5ycsLGh7+C3zZTzLX0QL0+n4tpFBFB5ctIiLVM9gZvAtN8o3Aa4Bp+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nss4dijd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eaCHZYaK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nss4dijd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eaCHZYaK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqXMO3634272
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 23:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D6BkZqnoNSPJB7maqyMGa4CK
	xe+HKu9cufTWT7EWliI=; b=nss4dijdYz+3jG5IqnSRYhGPWRu0RLrpYJ6Yh79h
	ZdDGSHj2kpo4H8N4WWOgvegyZd38YWkewALLnpGTjF1/ZjEu/rZ8sPIpUw6pCtr8
	ZUgoEUpHNcUcuvImOIkHo3rtV2QGkmpy+MZIDmZ7L18l1M5NULv/YVcAMFp9CdCV
	mWHKMObhnPcdfaA9Mp3kq8UUG7YZYShfVUsQPazyljho9glqnMl6q3tKHzaqzQJu
	UI3bq2xi7RZT7EDYU0xz5UP8pW0ECkoW0fr3lYoAiCHw+d7b50w9SsrRvftyNa9u
	RiUog9zp1krfrLNQwx3mEBlS4xAqlTVXglq9LLZLnZXNLQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4jcta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 23:14:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50917996cfaso57377171cf.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774307654; x=1774912454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D6BkZqnoNSPJB7maqyMGa4CKxe+HKu9cufTWT7EWliI=;
        b=eaCHZYaKelAOKp+CBlaSNPMqJbM/a2dmD4Q3bcFkdZuxLIWxlLDyO/Sfkrv4XMGVhl
         xATbPY04yjQGiBRVznq4lpbopXccaqQlmwcbVozNiMplyRM/yA9KbT0XRjvigerU+Vui
         S5kLQn4iwZ2s2U8AKKVUpXtaQORfLvzpJK6I4ZCQSZJygSxYnOxP/lbpKLkDa3UEJLgg
         E3l2AlwMbiH+jSAhPk4x93kEje6nzd6pQLSV15Qk5layzTLm5WyqI3fA8jSVnEoPEP7v
         M5BY2eVEGhpLM8GGgp/f1DdCaVIzJU09qBvA+hGDdGLFswyixlpGINNqKaVTDXxVbCvC
         oSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774307654; x=1774912454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6BkZqnoNSPJB7maqyMGa4CKxe+HKu9cufTWT7EWliI=;
        b=cQaX4ve5vtpj7fP6zYhK6xMpY2skxopI7w/bxvy4TntZQcWaZzXQ1QrmB4sQOqdDE7
         9rmgyv9QYZNIJVYUGdAvEWMer70CG2e27W6DRrEqSkjMeeOBp5cxLCiZ1yCyQKX+dKQl
         RKB7xpyZjeKSj8yL+gxukuJEbgbOWazWjEtn0DxI9XB+buZMGc9YFBCwo8DMMSGWYRjT
         H7XijaziY9s6RnGRGrut5B1bUr1HFklAPQi7yjnJ0mMYVCIjcMlj/IJ+CUUACga7Hzzu
         noAi6UUr3q8FRKOWhfV/AqTarfUxDCZHgs5DEWX95S8Sq+3eRwJhk/M/xe5+IuVSgBC2
         MtQg==
X-Forwarded-Encrypted: i=1; AJvYcCUvNz1IiaLe5H2IZarJ2UApiJY75C5cUy7cG9nFFyl5o8Mkw2HXLckaVIO/qH7jM0ieRojWn0VeNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7LY2Iuv4zUF00i56cvY7A11dG7QJCuGZT5BnYPDzjAHvW0mv
	vUUdhUfXr+eY6DR5cyW+X9Y4gcaQihtrpIP6HV4xVXmGsb5SdoGvmcj7D0BUu1Z4hp4plOg+Def
	bNvuxOVUfpYMb6GnaZ98BqvaeMG5E5HIVIWKAl7A0kYEHVwkjCBqIkeGwFhbN6A==
X-Gm-Gg: ATEYQzzI/ADfKYGr+mpFS62JaCsAOQ1DMHgZxdybcw4a40xhGQQ0lC5w2+F6NQd7nF2
	/R/feypKQFmBjyFX3Qh5pF0LP51wtCoeCHjuUagG8Rad+zFgEayNTHuuCSgNQHDGN7h5YD0NxdW
	g8ojU9nYJnL78y2XPhFFwih9BxiRFb96B+mWpSrVqHh+V82lUI2uFewFG1GiQlTAz1GcJiyOAHH
	xyoP2cn0trb2sghCD2GY7skyaeugKHpFnLe5DhtYhoTSBzdNNVQ0wm5mBUZPk12HafNwNWyDN03
	PNbj+c2QXcFi9TmbzaN3gnSmf7NwzGdnhYnwm1D0/OmkS48XLakkiR441NDKYr+EgPXzctqzjqs
	FGTMKt29bFj9TYk/4wXYmFHXS7bfAtiS1KqDqSqAc3J5iNYizV4xDvzlMBpcy1GVYizxCrxtHIK
	lEDorWczN6w7N35yfjwTe1nxdjWOHqPZmO25A=
X-Received: by 2002:a05:622a:4c15:b0:50b:38c1:c6a with SMTP id d75a77b69052e-50b38c10fadmr221443001cf.19.1774307654190;
        Mon, 23 Mar 2026 16:14:14 -0700 (PDT)
X-Received: by 2002:a05:622a:4c15:b0:50b:38c1:c6a with SMTP id d75a77b69052e-50b38c10fadmr221442641cf.19.1774307653733;
        Mon, 23 Mar 2026 16:14:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf9aa7cd0sm28541251fa.32.2026.03.23.16.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:14:11 -0700 (PDT)
Date: Tue, 24 Mar 2026 01:14:08 +0200
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
Message-ID: <75zgkrwvjsmnvjeyosl326vcudklj6yhhyskdrsm23kbzhgve3@64nezs6c54kz>
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-4-7892b8d5f2ea@oss.qualcomm.com>
 <abb14718-3d94-426a-a0f0-d101470951ad@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb14718-3d94-426a-a0f0-d101470951ad@oss.qualcomm.com>
X-Proofpoint-GUID: KAFLrMer1dIyXKsCKa1SfIQQKN9JJmEl
X-Proofpoint-ORIG-GUID: KAFLrMer1dIyXKsCKa1SfIQQKN9JJmEl
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c1c947 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=8nUxU6PwJs9B8C3Or1gA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE3MSBTYWx0ZWRfXzh7E8VdiNbBn
 xM+wlOiVxDgccvr2jZtxxeVe3q4xhOzfP2qSq0QqKVHuKrXHOtr2tDacWl9j65n3AdKkagcDcNZ
 E2HFSKV/wgqDhY4LmvI617DfgeiqZ7Pr/1n1YeGd9WBWCK5f+o56MHqgiLRb/9Z68rmxtUZd6Qo
 Hckh/PdVciplPoBrB0dREVM5lonjN0wQIQHLTpXAtqxVCfE6IxRaD8MOIxHoefVWEHdmH2UPDTY
 ihLfNWm+IDe5+RYICdpgod6mjWNgMlEr4KNGJpw/JDcvQmB95HDrKwy5OIspWSJ4eYlrtPtmacC
 2zPiVArz1WC5X5fZKqhvWNfJ9aZF8C1g4fT+ZMr/CH2epXeF7GmILb8IBEvRld2BOkHciUoKMuM
 CIXVmfr1GPXramOEzdw1U9zhs416w71bWZozA4OLvtL5EOfRGcFjrdNxRfO8pWDTeEMSu2eJtjc
 +bcEimijMwkEgoLjetQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230171

On Mon, Mar 23, 2026 at 11:32:33AM +0100, Konrad Dybcio wrote:
> On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
> > MSM8974 requires a separate get_bw callback, since on that platform
> > increasing the clock rate for some of the NoCs during boot may lead to
> > hangs. For the details see commit 9caf2d956cfa ("interconnect: qcom:
> > msm8974: Don't boost the NoC rate during boot").
> 
> Is there a single specific bus where this causes an issue, or is
> setting *any* resource to INT_MAX problematic?

I'd refer this to Luca. I didn't experiment that much (and also note,
this behaviour might be firmware-specific).

My goal for this patchset was to port as close as possible. We can drop
the get_bw later, after enabling more interconnects, writing the QoS,
etc.

-- 
With best wishes
Dmitry
