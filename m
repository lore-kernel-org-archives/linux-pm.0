Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E323A9BD
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918063; cv=none; b=Y0TxbrNA2V43dCmUMPjWnL/XWOZJ9l/nZ5CJVbrLpyjMXBpz5T6In9Fx708DFktb4AFxIZnGPQkQHilSXhufG/HSSJsWHDSyA492NqtdyRptVxbWKrGwA+5WWnsHEiAk+zxtM/STPhSBMwJsTWbudXucekZXu/aRT/F8LboKBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918063; c=relaxed/simple;
	bh=UkRdJUdZpZZHT4v9BpxTkD73SSfqTtiXvqdqJgtaJlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiCujA2JHjhn4uK219DRsC3TjTLdXyQ9JCKp8ulq6EGFdjxkurPVii2VHyOckBQQA8WkPrAG73SQZn0bRZAumoy0cYJ73tWfuL74v07ORuRCHWzM8eCu86z655IXKFILQMGa6nc3cKS5H5xmCobZovCwpCTbKTrL9WxMfeUJqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tplk1dNF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FoKmcM8v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tplk1dNF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FoKmcM8v"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V0DKuJ3539981
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0ks5/MECiU+6M8bwHy2sQ/Az
	zteX/sEkGMHcLgyfLDw=; b=Tplk1dNF1X+HKHFLmV7EUninlPstXsnxOpF6LC2H
	XxNbSUAD478CTzLS5wmU/Y7+/FRKRneuACXgqb4wGYEA4XbDHyEAu4IYQ/Px9Pv/
	UABgHZNBfYxWNm3LYYYJf1PpyLIIgeU+T/IsKT+B/fM8QgvjO+P8yJ1SGWBsF18/
	EIzCJMllYxhzsovUuHFNQ/aVXTWkQAPHhlJT4Z0xO++FaRsLEFcAp/YthaBKzOYZ
	arotXznbVbZLVKQAkYPdlDYVUOFosANeDM4dRm0QX1ZowzCk894rXaVoPNupfTNk
	VVD6H05kLwHXu911I61/ElF2QGBaPrUoY7wQ/TB1Txllbg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q59u377-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:47:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5091782ab06so264889221cf.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 17:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774918059; x=1775522859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ks5/MECiU+6M8bwHy2sQ/AzzteX/sEkGMHcLgyfLDw=;
        b=FoKmcM8v3GOsSdqNbiUYhm3NOvqpVp2OnRdNK1tMu3MMg7ujma3IhoElSkyE8pewB+
         qfufnhg5YXNhEGHLU3EWvxX3Lk6aRdf9JhFn5udh2F+LCUQpcx0kKLz/SaJhiJ8uYFFW
         zHQJrJbfFRl7bI/POdFhwn4UR42xZfrjO7vgF7hFpKinsHKLfvkgH5H6A+xBD9HSr+U1
         AEF9BTM4BK8nhl+ZGCkdSb/V5/C1OzvZ/I35UhFt48HFfsiM1W86CaMmawv6mLi+BOeA
         WS1Y5ywGMcY4P+1fz8JlFkwj7geuNA3ZR+BfFWAKLZbc3KLAvyJAxsTkmC07fHxWxWfe
         bAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918059; x=1775522859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ks5/MECiU+6M8bwHy2sQ/AzzteX/sEkGMHcLgyfLDw=;
        b=Ub6A6n4fS2I/a/NwjmmUpG1OcGzXpvVXNsXP1sbfksdSSyPAPK77h92HkUxoH7fqyO
         M2c9+MBClvbrJWSBrSLkN2Nb0BeBpp3DkMH4VX2vOdZfRBD/Eef3S8BZkEFqTaoGEMgZ
         bxDj6ik/fmv3+MnOKQrxGSMq3gmr9Cm4A7J0IBM7nsLMLVZT/fu951OmK8l3P7F/4sXm
         6PkFW5K+YZ14AFNISdEkXg+y8vlZHBbOl+HkwemNSoWpsG/T+3lq0QWUklYyTruzWsLs
         2zbBn+BSgU3+vmxeNhKaxbiSSTVL23pZv6EYwE3oURvfnk54/9/jFf4IAs+jUadUNFuW
         6eCw==
X-Forwarded-Encrypted: i=1; AJvYcCVVP2w01l2QtsLUuSJHkDHngEo4VjSOuekaUdxPF0oCmtCEAhamTffpz/qSmzTnJZcposjIpO2qpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjuFKr+VMVZeczdP7ZeLYmLNyOyYtx43QntpGqu9VYJgoCe3g
	NquIAHypaz1c0DToC0jvpbj9UOdh6T6b1YFvIQ1mNFA3s8vAhUDAD/Wfs6KsN28Rto9lm7wQqfu
	DdcGqgKy6og0E0HFZhCCyXKmLX+irE62kx/WeMclV59xBGOZvzoOWJnDhzhBykA==
X-Gm-Gg: ATEYQzyM+wEV0YAxoCjGJvJqInHIJJn1VMj+eWilpScoGSRqd4F53k6E4n7q99HdH2O
	+rWN7eZ/Rb74/c0H7ZQ0/QouhF7NPqYL6KGBxkq+mKGuqHERTmOzbVLBLQn/SXGP8jB76ym+cyo
	QfzQNfgF3xh4l2T3YmH0eC/LIX6F2ZmzBbfUtYYabF1yPxkbeTdTjKwVcqvMbt2Eim9pxj2GyeX
	6/Qbxk/4BbMza3Er1PJCGuKPHB6FWQPx7ugNZkSSWOcQTsl+jwjx2BBTOI+y1ijM4JiKoJ9coSQ
	GcA3XGN1nBgiDAtBepsiU6IUpvMRuKkrnOGa1hIX0PIwRdtbveHa495gxzA7/oqi5oAU7zE9TIm
	f/LJZDJzktuwlTXmxP5WG9yweO6najJwE7fzzdguKKf6IeiwgTFzHZngSVxQlzQ+YKBItO2a1yZ
	fgNgQ+NaERcVoHBLZdFhGJ5ToMo8mVadjd6jk=
X-Received: by 2002:ac8:5f13:0:b0:509:3940:30ea with SMTP id d75a77b69052e-50ba391e97dmr194703541cf.55.1774918059517;
        Mon, 30 Mar 2026 17:47:39 -0700 (PDT)
X-Received: by 2002:ac8:5f13:0:b0:509:3940:30ea with SMTP id d75a77b69052e-50ba391e97dmr194702741cf.55.1774918057633;
        Mon, 30 Mar 2026 17:47:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2bc25ad35sm157626e87.20.2026.03.30.17.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:47:35 -0700 (PDT)
Date: Tue, 31 Mar 2026 03:47:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: add Hawi interconnect provider
 driver
Message-ID: <3jsmcfrpmjapron5jc65ueiz4jwunfss5r2saarsfzebex3bf2@mase353jnpgw>
References: <20260330-icc-hawi-v1-0-4b54a9e7d38c@oss.qualcomm.com>
 <20260330-icc-hawi-v1-2-4b54a9e7d38c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-icc-hawi-v1-2-4b54a9e7d38c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: oNuJeGdMlv9dgD51gkZOcQjOAgJoOpyX
X-Proofpoint-GUID: oNuJeGdMlv9dgD51gkZOcQjOAgJoOpyX
X-Authority-Analysis: v=2.4 cv=EcXFgfmC c=1 sm=1 tr=0 ts=69cb19ac cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=X2bA-DTC1ecWuKQBpGMA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAwMyBTYWx0ZWRfX+9ZZWf0/aSYH
 yxnhjz9RGmtawPvuh16hjcmaBckI5ioAv+1VZEtJQsTpmGxv5NVA8a/y3iwOxF9m9il+R31xdVJ
 mX7Lh8ivdPn/xU4+fKugEfWMrcFsZQ2NLWhdQy5LqcjruXiDfJ+nyZUC7722X0ESJy+ilJQHuz5
 nLthPuKY19fy567+IOYdV5IHcqXHEUlZorI8wZ8+s5KrB7OCANEnX2PwEe6+514m3RWKhTcI2xJ
 VPm2b4OoTDGwGBQzX+72+6InhdSF4eruMeKASpVD/NNqHFb3K7JZ7vGMN035hX3s3dga1T0mzAo
 DVY/sJrGbTY2WtQ41axTyp0s7Z6kDjKy+gQIpk0MAfY4c2A5PX+Uk6bgLluqGFb8IRudRStMGGM
 NtcSZrkvFwxDCrx67vB7er8yzQucE7xDtlJcwSpx3FztS+8XU86x5ajzG+njWmQoAEi2za334Iz
 rGylBcV/zJ6j3zHPjDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310003

On Mon, Mar 30, 2026 at 05:40:01PM -0700, Vivek Aknurwar wrote:
> Add driver for the Qualcomm interconnect buses found in Hawi
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/hawi.c   | 2021 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 2032 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
