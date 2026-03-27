Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDAC35C1A0
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643617; cv=none; b=eTSz+lVf1TqQNb2Iqrpi5h1ihtDG3qtx71SOZ5n0du5C1c4lgHBKL8LJH4DvmBIqBhweQJJBcTLzx8NW3/8ZLBKP4BcclPGu03Pw1nfWknkjhIFGW1p0lvQb90++6QWKyFw56s2rEDf2GqEVypxewpsLxr2w30uls3dgBIi5cY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643617; c=relaxed/simple;
	bh=keFw1/XjbB7jwqX5zESU+f6p/vJiLEdwKlMIJTnF7eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN5+XNx1hKhPEXLusVDnNrRqC877sD660fn577wMNyiaOZdweTb3y6Qb1j6CQIFidYkCm1IpoXb31MvMDnue2dfpkcxDabmijiM7qiNB3zKWEya56Hg5lnG6qL4NoWW9Wk87swY0qPBiPIm2wwvAAzYagJiUgqGAyhr8lsNNnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCBt9pCx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TCXOnD0D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCBt9pCx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TCXOnD0D"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RI2gn5083233
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 20:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rW0LpKAnyyF0Y3CdhoPuNAvMCsetS7o2O7ydNPWwqCs=; b=kCBt9pCxn0HTwQMA
	TxAnHiB86/KNNPHCKrXrk2Ve2IanSLoR1ldkjw8TYfMzF+LgVjMZH8UtBBEsZtv/
	Pm/HHxwS9qGh9uCUGRLIT7xAr7DDAzEpdXu4bFT07etq+qV7i1aObdkMUvWXj5Cw
	TJySeAcQCr7J4Lo8TkUIDN6Hvrw+jhEUfeL96VDfAoH+g4y2ccDpiw8vUmyfucq0
	owklJbFB16ns2kRSZYu/Htz2gkW8/qXeVZ5b96WnIf8Qu2ZyGtR4JPVOSHSJrnZA
	EgNaQgs6dsmdxLh7INEEEDmRYk20/x4w73GB5f1eq0n07JAVU57VsfO/XUqPdclS
	1IQ0bg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5jcx3dqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 20:33:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b52a2d70cso70448091cf.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774643614; x=1775248414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rW0LpKAnyyF0Y3CdhoPuNAvMCsetS7o2O7ydNPWwqCs=;
        b=TCXOnD0DkziihurKzpZrLPkciOvVhgP7TF+XyOwidQWb4oKxLiuKlF0Oet2nFANu6H
         ZGaCm3nIEawlaX6oiQ8IQjWsgSLXrRqkKlfkZ/yijktBbHxBKyGrIT+Kqozr4I1K/htQ
         yOS1dN5s9lS+1E153Izf+kiA6hPSCKIEVMeT0Vv+x9TzdqJxiy1uTsPjy+BZxqwAVDPX
         DO6913aindk56r3Pu0fLb5s+5WobZqj3yqtIB6SgcGy2m96k088Tx8yYNyGLOqkYptx9
         LsXq6k7k2NDczq4exqORITuh3s9mNnItpJxJtexzyS1xxY9t4EKw3w8EVVqfgzRwDsPq
         izeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774643614; x=1775248414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW0LpKAnyyF0Y3CdhoPuNAvMCsetS7o2O7ydNPWwqCs=;
        b=JKzs8HIexhbK+kUJ3e8krfcWp4cxi/Gk1vpV7RBrC/GvonQZk7A4/SIOnz3XtTdmpq
         cgBK9eR5IjketlPOj5cwABCFo/5A54EAKz5rWivUcJfgPfeBzmWPf2R9foAVbe/HRFF8
         MQ/nN50snnqHQScFNpbEsgdw+K0yw7BwmKqQNuMZTXsIDL6Vv/WEyXS90OMPXhy+V+Jm
         dlupKLwaMhLmJTD/Dyh1lUsYkRZJqBC+lwEUMvDMPz+xi66KtSbNdHNk8Mo+MqasRdjD
         t+/AyDx3A7sTr75WEHHq0pvQVBaC1BK8jtoTCjMIouzkI0xZXMbVBkIn+820Sa1kqdOW
         +INQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBiesdnysccs+/sSpFpv4+AnrkXsRpHO9NyLfbNBgZwrYReZF6IBmoPCFODhWyAJT0ta7SMCmKig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vas1HZvdodKUOr2ugrwpUHwbfNbzo35R/fs9vxJ+GEiGubkA
	VwrcVmtiGMHJtDijNYqeXOShYAC5McQqBG+lxKtfn95Kh2c7x/ukc0yi4cBj2ZnhrZs2uKo1wdn
	AJ2h/Lw6BQbuQKLCp5peplRHQUyqTn2X1gMx+b0uP/uIdo39Usr1xGjhZMxzx7g==
X-Gm-Gg: ATEYQzyv/WpQYxVBOHKrS4SB6aAUQAVapB6IM1P/z6wOFViK0sdAvn9hvsDh0tYr/VS
	tFM6xuu8+BxGvxjLYK5a8s2YrZaM3k4oyaVVSp4TnpbP9hr4sZkm6SZf2697PSmZ6CcXhODJm8q
	XAeEuzicisxdv+AXwjydymt465oeis7LJg2gsO6ycaPvnJi4Xlr67upPVAcGEwCqMUpc09unYDW
	8daIkNMIXDMuCBUKOPbCmNNQ9TB7ykl7BglrG5gcebKil15qgewm83BEfh4vS3yW4y8wQIHYLEu
	vT2lfIoOU9Wa/VD46jrZl5mseUKJelx1ZBpJKzC2pLuzMOzh9lGVLJI/CVzMRZrGiLIkoYR67Rp
	OO1Yqk9V0MTbNZmFiVCbLnlSlqoprYnP/h4h2GyFHKWSMjvEAWkioH9WlKcNGYIeTgcCGppyH1+
	Z4+AKNTkefz/pQlVpGSfu5js3HwuYuydzqHuw=
X-Received: by 2002:a05:622a:15d0:b0:50b:28b9:b0a1 with SMTP id d75a77b69052e-50ba391db58mr53731461cf.45.1774643614368;
        Fri, 27 Mar 2026 13:33:34 -0700 (PDT)
X-Received: by 2002:a05:622a:15d0:b0:50b:28b9:b0a1 with SMTP id d75a77b69052e-50ba391db58mr53730961cf.45.1774643613843;
        Fri, 27 Mar 2026 13:33:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b1455e14sm6079e87.64.2026.03.27.13.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:33:32 -0700 (PDT)
Date: Fri, 27 Mar 2026 22:33:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/7] MSM8953/SDM632 rpmpd/mss fixes
Message-ID: <lv2ali4zgsfdh54yd74cx5mvec2z5kg7v4rkayyukpjt6juyft@vzprb3rvewkm>
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
X-Authority-Analysis: v=2.4 cv=NfTrFmD4 c=1 sm=1 tr=0 ts=69c6e99f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=OuZLqq7tAAAA:8 a=4YYDNayrJdHcgVGABboA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: 1PP9CVoRYKEtJUKfMbNyrscfJvg3a46d
X-Proofpoint-ORIG-GUID: 1PP9CVoRYKEtJUKfMbNyrscfJvg3a46d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDE0MyBTYWx0ZWRfX8YF85+j0KkEV
 UuUfu2fLVC2exDmTMHBccRkvmqrIBjdvmzEesjZ0qYiwSZPB7e1d8J9MnYf3zQh9UT/HmlE/aTY
 PCC4EjrtX+pM88K/iqNkuG5n4wfPY/yMV7x3oWU/vt/jz8ApmTv6X8j5vHQYTQ6l+JL616fw6qB
 uedghL2LNJpVxHipWPmNIM5Wkmfb4Wmc4AzBhnFO9VidbZoO0n/+BZo6g9Cx5zxCO+cLAtaHc2n
 yYpH0gk31vFAVXmTCBFs00+TUrpW02UqroI4Ji8b8KIdX0sj5xT8MGWWm9XQZNEJaBwHkDZ8Gzi
 ZgLjXieOUEdq4a12vo84RNhE6QQZZ3c/IWIek2PU0dx9QpepCU9XVgsqa4O1yWJl1xr75382J5Z
 UJJ9a2cK5Jzyiq1PpMLijdISkouzpo4ARAXZ6YcRhoBKjd25x8p80dc6OIlE1lMKjDreuBsK5jN
 B8vLzQFKMP+TsQH3m3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270143

On Fri, Mar 27, 2026 at 09:11:42PM +0100, Barnabás Czémán wrote:
> SDM632 pm domains are different from MSM8953 because MSM8953
> is defining pm8953_s1 as regulator but SDM632 is defining it
> as pm domain.
> 
> This patch series correcting the pm domains defined in rpmpd
> driver and splitting the MSS resources for the both SoC to match
> the reality.
> 
> These changes was discussed in a previous threads:
> https://lore.kernel.org/all/2b057aa5-4416-4fd4-aeab-6bc23acbb53d@oss.qualcomm.com/

Was 4.9 never expected to work on MSM8953? Or did it require firmware
changes?

> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

-- 
With best wishes
Dmitry
