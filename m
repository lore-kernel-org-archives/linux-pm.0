Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C63C3F6F
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992406; cv=none; b=AnrthJ5uv1t5nWF33EfW8TbenOyl77RCIV8BfBlYPbs0ykSpH+WkXuH4Fje+pcOCCGszQulzftCweaD+y1XoqKMhYe4UTdVEcVzRv+pWz0sS7511s1Ty9hVN/06SOgiULfF4zxvEp96xtx5I+dmh8ttgMV9R065RC4grl9CaOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992406; c=relaxed/simple;
	bh=8y7/zMoAU5J83AFr8Wyv1UTO4I735JbfICWLuS7AJ38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkDq5n8JZu0H5tRoCV/VLX8NCX0oz4qvi/gvybHd9GoMKNvYEdYMmE5SyV5ubw6HIyD24S9yQh32nmgCedj528m7N+2Tsg4M/x0zZu2YMqb3OYEknKnvinHCQ/PjOm3CpHxYtrx5lZsWvHa4Egi/hDd2tjpBgoezmiMHV4Q14PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jY7FEHMH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=awXAjIJg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jY7FEHMH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="awXAjIJg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdxKl1413969
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sXBRdDppBAPCJg9q01FQoe64
	56Ok5dkROCyGIu6mvo8=; b=jY7FEHMHa4U5+m/pn8RZKDGeIRm2gvbq9RvFWkrQ
	0tL3oM2j7JoLkqLp4VCfGn5TTOo7ZYBMqF0sZw6t23msrINtSQo0MC2asvJZ2WBi
	1pJEThWv7Q+xq/083llZ8gDAIYLVpUHufo5mtmjOa6NRdHMttuIHymKtIFAsprG0
	0P9A6y8VStBGGu2aRXrfr2IQ1dH7QRA+I/xAdFwoV/43ADSUGORUTAZRXtavpZpT
	ljabt8l7RHduw/5X2iYa1QIUyn7R5WcvT7rOAx3x9Bh3eyDZrTrOhZAZ3/VRGAvp
	l4Bypa2IyS+u1pevZHakPIlvam913mON8T36LmI37QMhTQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d14cq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:06:43 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7a532e31dadso2702918137.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992403; x=1790597203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sXBRdDppBAPCJg9q01FQoe6456Ok5dkROCyGIu6mvo8=;
        b=awXAjIJg8HkMsHPROe95CkeKtXoh23ce3G50kcQJXTu2Ai9x9gX3Kr1Yzoe/cbZhb8
         sodXa9LBcrL2pHEVR3P8A7Tk7PzMv3GNQlQBMHNBqjabnSbuXMfxKunuhVPv8bq8hDE5
         qNVVTeoLyapwtaWepycAQjHjIau/3EATj4VxWu5u6KFNGwzq9SG6zl+i8wTJmadv82w2
         ALY8qEpctPNDsSAhBHJiNcDEGzm6kk5OqWlhIVQuKs3DKDSSxPkBe32H705lfrUVIisR
         RcIc4zbavGSOEo1kLDAX8pjyNn0nIAyk+MFBCh+QeZ6vUfPB2hz9R7VHXgDB/5SOKJNS
         0VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992403; x=1790597203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXBRdDppBAPCJg9q01FQoe6456Ok5dkROCyGIu6mvo8=;
        b=bdzh6rxjTtOaq/C9V70YHf99nE68mvqHK70SqmS7nGzY+GS9eO0jR1PG7Ihq4EbONk
         15UnHRiOqgYWYLkbuw9vcNMJxSYxUtW/r/mgxeJpF3eWDx0JDtRYVAgawbSq13472pCM
         BjWxYWYlmihGJSTWnEzF6amHCHmPv8ciUCzF9zSy9MbiBefaJYHhbSLxjNHSXNYBI4qB
         uHTat4gGcV7ZYHQpJos2H2Urbnp9ylEwKD79ojdwRG+dEB+tAnkanje+j0hTCEz5g8Mr
         7mJsBImtn/MbeMta/zv5sC073P+lB2fPCDkIbYDNA7ta7aY+ObgPgRdFk57KFpk/ub8d
         MH/A==
X-Forwarded-Encrypted: i=1; AKwUvBxE6WfZA8SEpXm/9r29nPRVZnYCx7qhl2KY7kZMPBXDRFdv/813N27qIf253wT3yPczo/pWh/aH6g==@vger.kernel.org
X-Gm-Message-State: AFuF++m6vyz2MFfLccdUTqzzVfzt97JhC2Vt7XBR/U4w4hOKPMX/C91/
	U6oMbq7HNdkaE6TrjpoD/Jy8A7///nUcn+DvyZB8FC5lDc9dSNpAmSIXt5Vi3E1BG1+pPFPZnyk
	wVs1mwJZ+q0yAHAwRhbmhcrTBtS+xMEb8kvEIiQrMEECly8dH0RlMHmIH2Ic56g==
X-Gm-Gg: AYBFou2di1gwEZ9O7ufXmqYxmtnc6ExGgN9NIjzwmYzsM2KFoSGh8cV5/YNayksuzif
	d86FAF8VAM/p0FRnlyNh4X/9wn364DV1wwcort/mJb+jbnOJ6Ht9RlMZFYdyHnJmUKZUwRgxenF
	JL1revWFkOv/ZZQTUGqs6C5xlCqOQfB0GNaUqmvS3Fro9aby9D3tyPlio8OfjST4ekNXdqFB932
	EvfDWsgVqdaXTL5B+bzwQlOKlESzcTUBFfGyEeCIp6L9O8yD6dbgls42Mq4VLjeo8M84Oo2a0SQ
	JazsXZCyn8NB61dm+AoIqXjCXqXO779L0RqPak9+PSa8tWYZhjklgUIrJHiKOitlMKOGOm7rYrx
	/LZZULXFehtPGRfw=
X-Received: by 2002:a05:6102:578f:b0:7a6:a24e:811f with SMTP id ada2fe7eead31-7a6a25dcbf7mr2563243137.7.1789992403334;
        Mon, 21 Sep 2026 05:06:43 -0700 (PDT)
X-Received: by 2002:a05:6102:578f:b0:7a6:a24e:811f with SMTP id ada2fe7eead31-7a6a25dcbf7mr2563185137.7.1789992402738;
        Mon, 21 Sep 2026 05:06:42 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd115d78sm218942615e9.14.2026.09.21.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:06:41 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:06:39 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 10/11] clk: qcom: gcc-ipq5210: add UNIPHY XPCS reset
 entries
Message-ID: <itryi53qwodsqngkeck2ev7hrzg5udg4phmxraicmwngwhpndg@4nqxbftjy75b>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-10-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-10-d242e3d49648@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: HRmCndgEHdFVt--iSWGkQxynB5P4pCXV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX5MXfseyrmtnG
 bt7Kiww7vuNX28m0zz+8yxNpTNXa+O1c3afsuLuMymGGyyvpwaE3b2NawVEbKVHAw7iH/MtKdQ9
 QutdIjLhmwxqQDG5faoh6GOCwb4N28I=
X-Proofpoint-GUID: HRmCndgEHdFVt--iSWGkQxynB5P4pCXV
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab11dd4 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=22JUz5MsYadeaJqTxQMA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX/NC3tUGnPzN9
 ncpiScpprDF0kvUxMlf+Mjy+Wvgt/lvGTKVMFxMoxjokYV+xIUR0zpj5Km0vNKxk3Dk5JGhfYIC
 NcZlLycz1/ROeX0MtjDXTQvpxfSFJx4vwxKvLRb1xOk44BIgiBzixrs2oeMWSwR3uKqGAptBEam
 pZl0mp3DaQE9Xv/izvJLaCS8XiVd3X1XORuF9T6nwaehy5ebJ4barz8ol/2DbTdJWGz5xRunUZs
 wApRXcN0M4lDcyc5sHYjeRg4u0ya0OzP5s3KGFtlmwCfe/i1PXk5Txx9UPSfoZtZ8N0bERz7dRE
 kBK1IVzkHfOl36Ner8lAQGwySP5zT3YrID9j9It+ezdcyKaHcVfaFf0MkkzUy7rH/ISnqfmLCQL
 R6OakdxJstZYe4qrFPOA9LlLp5FohAW82VuFBVOcAui/3M3ULy2IKPPLcsfnKedGtTVWiTM/54x
 B4ylCgm99K1o2PZwTFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210175

On 26-09-21 11:49:43, Kathiravan Thirumoorthy wrote:
> Add reset entries for the UNIPHY0, UNIPHY1, and UNIPHY2 XPCS blocks.
> These resets are required by the NSS block for proper operation.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
