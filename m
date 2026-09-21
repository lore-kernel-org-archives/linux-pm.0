Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0F493D38
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992453; cv=none; b=D1jIQiKmJvmO9hRqwhoW0TSofaVaafLoRkfuDJKOQhCULTruMAsRl4O01/PD/eR7jHxc4RIk8bO0rQ6hVG4MjDP/8b8OLGn1u8nHXtxPZjMlyLxrkSZGyXhbvzFb5rypAaosHse3BFHIBMko2ilSsWu4V/k3v9Y2iSjEjZLpcYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992453; c=relaxed/simple;
	bh=aI+TcTaxp3qATHFDOIc+09KqwGvOBm/VOg2yW5Pt6c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYyrPSbHNstvFaqGuljorzWDDE4sk03Jtqbws2bZ1ZfwtVImywKieJWpsXKSfuQTujaOYadYIU/DD9yjLK1wBP+wUlfDHjBxSeh69rcrc8fJ69fFSJoxl3VE2qpcnGnGw0vHfwbUitBaiy04o2dUkVKl79FLh58jyGL+oGLZWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=edHCoD7A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WVWHtlzi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="edHCoD7A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVWHtlzi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAe8IV419308
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mrmIbXeN2TBMf2KsRlbZFCo/
	xNhOB/akjMxEecMlLrQ=; b=edHCoD7AmB/TowptwnhrUHlYRxIeu7lrGS/fubpA
	J0PBp4aDsLxuDDvc5lFjzEXjf/kp0brI8AJp38E6uxFiz8w6R5tXNDiUxWy5c4eu
	zurbSHWEzRpwgakncAWIFygU5mlXX4pBKi73/ZS74kcM9HrVA92LhXcJQ0Ztgwik
	uTx0WbLvMiYR+dYvGDcQMPyzCpTv8k/6JeBNf7PUuHMbqQe1CLJzMugnjM+x9sZi
	1PqaF0UIhhClNk0unCSTRa6+yBryPSDi6Ek1IXxNl7BiL9C701wJg1rupyfkzoh7
	/2UnmAE2NiqyeyArt9Uj+zWlKyxFrCXuNGe0tIsfmngWGA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq95bm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:07:28 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78d25a8ff32so720205137.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992447; x=1790597247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mrmIbXeN2TBMf2KsRlbZFCo/xNhOB/akjMxEecMlLrQ=;
        b=WVWHtlziABnNFi18DkJAP8FuSEQgxmnjKM0JXpU343tZGj3NUJLVQXhQAME9JnalvC
         bClYrlkVF1k5wCRdc/zRT5kXaG8x6oZH7VHyAT9SIFwuaFx57irjbCBNxyA6K8lcSLrK
         Qybqc3/haYbNEQSzcjJd0eUnpdDPhaM8yatlnnPfTw+MCy1HUOLB18YZ6b6Xtj337Mdh
         K11S3usU2SvpTfRsG0G5ZruvxOWuSozlA022y0DURriM0+gZ2GDCN2BpVxrInXBPZ08t
         sCWghZogggUG8ynnuyObzAjyQAJ2cbHmRE8WFCyY+ZL4ANhIfHVseEwOCjk19e/lXtgI
         fJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992447; x=1790597247;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrmIbXeN2TBMf2KsRlbZFCo/xNhOB/akjMxEecMlLrQ=;
        b=fDm4nAw9OxQ7wwuAgG6rNRWRkCYeWzzpE8N2shp2NmSY4BfLJ63CYW4760s80y069z
         9xHW93/TWkBI3PWftGJRmPCHfloiCqQJp/o62kghunMDwEUGXL5Kd7rG5sWyEpmy3upM
         DkaR3ex5+lv+foce0aNLVSV3zSodLiuy3IQzcreNxR3m8a5b83IXxHgK2VW+v/LM54dM
         XiDdZTzhXJiqPP6+IF6guDmz9fFCvpwKPE3PlZ6PZqW/2RvYX8R4qqG2iJwcLu1WEwY3
         gBt5HYcZ5Bvwc/6GmhiwF0XaoGbytMEGpySm129MRA3izAPXudLdQ2qDVVeONV7tDuPQ
         W/Ig==
X-Forwarded-Encrypted: i=1; AKwUvBy7tD/K3v1KOF+bKZUnzzDHjzHXUtocQpbFc16ZF18tJy/3yzJQzz0AV9gIY7X/2n5CXZ6Ypanr4g==@vger.kernel.org
X-Gm-Message-State: AFuF++lZUDIbMF6U3/5d3cRqza1zuEi2sj7WCz5VDhd61qX+4hFffKXr
	rhr6y81BbZRnZyk7xixxgH9lURZR+itwLWOh4Oaej+w8gM0Y7ckD8a6iAoFLTWvmj3pNi9vNGIS
	4scYdBXLUY982nUHA3VKviytxwhenMOtcapAhKlVcBkeDNkEidsj/M4fpBGuzGA==
X-Gm-Gg: AYBFou22krhKC8OD2eGdWStKH8vV1jWkuQopifOWz6CuihJUT+lluvbgmWlHdqJ7pjW
	aehkgoLyxrpFtAum9ikJH+GhL/602wr/ho9n+oTP8s8KgB1YsPRTa7jde79aDZ+OtMmyYsjbzqY
	V5IsTFU+fbk5809ejLcCxRkPmeGvFYY9XX6hEYomFOPM4/M6kKqhIZ8EP+hqnkESHKQ1JdaNp9x
	zveHvMi9h9i0I9wjQdPMnToBJDM+SOMC5qI/XUPYm2gRZqri14RoECEl33Z+60pFSSnkwDtEPlR
	AeyoUhRsgfeyUI7CJaR4uhi9F2YOj3HgKOIoBhSDls0dPiyFAXGw7mTkXOkK8e+t/oAuywVmCIc
	drcm+35yu/0fGOw==
X-Received: by 2002:a05:6102:3f0e:b0:7a1:f980:e93f with SMTP id ada2fe7eead31-7a55d796d12mr3921082137.27.1789992446866;
        Mon, 21 Sep 2026 05:07:26 -0700 (PDT)
X-Received: by 2002:a05:6102:3f0e:b0:7a1:f980:e93f with SMTP id ada2fe7eead31-7a55d796d12mr3920971137.27.1789992446153;
        Mon, 21 Sep 2026 05:07:26 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm233127095e9.3.2026.09.21.05.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:07:25 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:07:23 +0300
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
Subject: Re: [PATCH 11/11] clk: qcom: apss-ipq5424: fix 'ipa' typos
Message-ID: <oez5n4yxcusxjuw5pt7gtqqa2drnvbvzhmpaau2s3rybwxdzr4@7qpaaeevdfzb>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-11-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-11-d242e3d49648@oss.qualcomm.com>
X-Proofpoint-GUID: cBMVOwIv9-_fkgb3wNAGvlC90q4Q-qad
X-Proofpoint-ORIG-GUID: cBMVOwIv9-_fkgb3wNAGvlC90q4Q-qad
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab11e00 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=D9-gj5qkw8m8MH5a88kA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfXx7fZWz44vMhY
 Qf4WA/MR46jFSJ2WOU7GP7xIz4TPlrqkjcApEEo/L+saWgMLlpLPakQ3mkH4vZM9Lv6hA6evwmK
 rtF2dCNHt8bXigKPQ1v+8QEnt/CcUwqNOB9JH9x4eiCy2eeMA6y3XYli2xYc852Pe1RFWzsJQOP
 xGOqv4GMOhvK1Uonpa6+YYXEhOH3ZUqy8u2/LeKGmg0GBRuOKl0/roCg6zd5DcTnePTLi82aJQT
 gW2Nso9LTFCA1fO4G0YLwOyUoq2e4X/KE8IAvhG6+b+TI+HRor/bQu2mYFwFuw4CZl/GVGCyMTk
 C7UIfoaG+fFJidQLH+wMC9oPIljLypuhbllaCI/gfr4OQH5rgb4kkOrB3Ww0fjBCNItGG4G0q8z
 sY8TCB+rbM25S4rMm32qu83Y6N0VGTs5dROR1ykZkFPMw6wBrE9W/VNSZ1pHpJwUXUo7a0zmlhP
 85KD2liRsSh53R/5CEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX9WfgQpgCo5g1
 MpfioG+JOEkSxgypCmc/Q1bF82awj1U/BVUxUI9/OjfwRYKVA0kUkytGEtITYqOaLLST6ij0k51
 xC1DEat3QO0xh5PVR9KLuAeA6NbrQ4M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210175

On 26-09-21 11:49:44, Kathiravan Thirumoorthy wrote:
> Replace incorrect occurrences of "ipa" with "ipq".
> 
> Compile-tested only.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
