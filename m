Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10441A55D
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433938; cv=none; b=og0X1mIv36gvmDhEwroUA99ppU32VD4x0YRQephEFSR+W9CiGbT120BqB0+QfbuaJHys0d7P4kSm4nUv5S38K8hcAAo+aJrawTn/Sa7MLoptvjKfddRMVAZroq3K71sir18JPG7t0KsyAquDWgAe5BixtHpNRU671tumdXocsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433938; c=relaxed/simple;
	bh=6e9pQsXZZQk4BKW/6pEfyREJ9Gd3PYVS4aqYk25zbZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqWT9teRyQ9Q0AF/Monnt2g6AgyQKa3Ixt8gRkSITGMx4WkWZ20wMFqzBS+duzPEn+zKt0x/IihOG8f6gq+hevNhUaZQ27wbRWeQnoPeWBMk8UqATPAvC0E7hNnK68Jlk8BL3T2OcUmy66P6d0vayG7/dKkH2CfQZEQpS5NcmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LJXVP97H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HYjhUylJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LJXVP97H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HYjhUylJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683B0NdW753090
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 11:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lXuegiGWgMC7LS4JW5DZVIPYdBVcElPGergWXc3e79I=; b=LJXVP97HayG1Dv7C
	jQEPU0vh6xtXnb6/P1FBhjS0Fqw74DGzxDyaQ66EdZCaN9TeqcDlPaQyFyXQgqvB
	4qOi8wsjiDTEN6bemi4S8mCZ3k11WwOb+8Zq4Spg/ug9C8Gp9KZ9iK6jea2/1Cg8
	MVAx/KxFPSwWHTrnYldy7VnQq99mww3l7v4awnNm1tH3uOChwS526ZStTjg+/2dt
	k7e9DsRB8Y+3a6djKdubpGFBwbHCIwTziV6Qo3xVbBdvSwd2zzg2GyWq0b949yQf
	P7UnC038QumCkqvlm0SgELGkX/4iL5fA4THrrtQIibSNR5Vp5/mVVW49bwcUsX5U
	7yYZFQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4hf9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 11:12:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so3556166a91.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788433933; x=1789038733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lXuegiGWgMC7LS4JW5DZVIPYdBVcElPGergWXc3e79I=;
        b=HYjhUylJKfLv4jMco6yDIQ1iOtfdz6RRTQBreaSMDpng/SGft/cz+QL9EA7XYQ3vwN
         oHoZi/mU7JSOsOc3HrXytlrSloFQtZAEW2638fIHNX1EY5w6wkcI1KHKjfJvxNYU2wgT
         2orMOcRAJ178P+dbQotxSJWygzo2J3rpFNHbQiPbSQt1oXyJddPrwd4+E25jTXq3Gkw8
         H39y1QeavdHyIvJg53FIO8OCxFb+JuszIhuOmhZv7bjvREBAVEx4/9uIouc0Hu5+ZQ3b
         MBq1E77bgxzzrn/ExNdCMRdzpGKu/Tkc8lvfVyk9TZyH9ZU7Q4maxdRBwYd+DXTLcG5I
         olIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788433933; x=1789038733;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lXuegiGWgMC7LS4JW5DZVIPYdBVcElPGergWXc3e79I=;
        b=WEpfNxFfcM3+djnSIHVDf0bfSJ9UEnbtxQNbyRtdX3zD2erDEDLDxm/t/Qc+zrDoxf
         ojc0IxZ73PxV9yhow7SxeL0Cx8kGljQhSmZSn8DLztZ6Du100NfA0dgUBiEuqCFCgx31
         nAj/AFpW4gw5ox+BEpRroCXGML7NsPzoiW4vIr20FlL0LuX0QjDZoJkkL//+NCzSSHfq
         IgKNvZNXYKEeTh3htTB8yTziy5ubCt98IFMnLQ1vBRZ/ol/MQPvrXR4GIgJ80ZE86o85
         /GvrBz0uyJ0aTYupeteEFZwYeiZ44ffULYHJmUBhBmjSD2QaQ/ryr4azS6bolcIRRsP1
         CCEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUWePJAdLUrG1tJhWS6A2q71BJ7zRu6sCgEbMLjBn3tEjmOvhS0EONOjWMAwKkvZxm6fgEdH5NQQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mKneqb+yC4mF1b0xPvoQg64bZejJBceMSGTJYh3bqQhNAeNyFc
	CVdYvtW2jlFP8RsIVHWRs5uP2kYT7smMx5GLNnMwu/zCjNVRgR+3kikMRgXKrYbclcRN2ktWqx/
	DWIzCHUT24qBwigwpxYdTvv9AtsaH3hEhmo89q154ohtd8drmt52HVgwY+MLTfw==
X-Gm-Gg: AYBFou0Qej6K6TI18VWbse30IzqvN/8krSQiVa8iFWs7dURjybCp94Y6k7Y6KY3+/fE
	cHhGNSQO8H5X0W4XW50h72CmvAjuGNLxy/JZqLaMcjVG3CL1VAHzs4juChAIntknQ6Ywz0itlVr
	GiQZ5jj1OfvZFirigMOPYOvrKbbHH5EZotzrrLxDuGZPFBg4hvJkMp9VbtDR0bUFjxrW0GMfezj
	gUhnTTf82p0hUIqBB0PaQH35SJX5NptgFuoVIYSVgnK9WgJ3jUtc+/tSgSlvF2NKipq5J+TJ2b/
	QaJhQ0TIXNoVRtZmY9R44T4WjEKFpeBJfsP2kFC0dmJ6q4htw5P1Od9O4NvCoxoCwtyMiIjF+RM
	wC3fCkQaCv1pOgyzodNQaxWsqRAWcMsgYEdB5YGDuRIXGjB/cvonRcR3LdupwjbIgOPHboxnhga
	0=
X-Received: by 2002:a17:90b:2d8f:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39aee13d992mr19020403a91.18.1788433933513;
        Thu, 03 Sep 2026 04:12:13 -0700 (PDT)
X-Received: by 2002:a17:90b:2d8f:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39aee13d992mr19020280a91.18.1788433932942;
        Thu, 03 Sep 2026 04:12:12 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm4905284a91.13.2026.09.03.04.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 04:12:12 -0700 (PDT)
Message-ID: <60b12a54-e930-44d6-854c-0d76eabc50af@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 19:12:07 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] pmdomain/cpuidle-psci: Fix behaviours for CPU PM
 domains
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
References: <20260901111441.122436-1-ulf.hansson@oss.qualcomm.com>
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <20260901111441.122436-1-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a99560e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QURvCu9eW4BULfhiHY0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: dmVHvINkcesw5XKvS6gLwfnP9e2N5-5-
X-Proofpoint-ORIG-GUID: dmVHvINkcesw5XKvS6gLwfnP9e2N5-5-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5NyBTYWx0ZWRfX2lxcU1ERLfgY
 pm/oNchdiXdWLefAKVZcIf7ESDdyjSkPl75MfV0MF3FPdF+ukX6kl9FSp+et1POK4whuFakyNWP
 oljE8MfoB0fF/kfFKNi88ZU5Ktxwtho=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5NyBTYWx0ZWRfX86CLpYW2E7rg
 MsZ2wuhANQa5MZiEuMWbi2ip95KK8SNKIzLJmMROx2OjYjN7SNb07ybeszIKX2261r1YrF8d9fa
 YAs4kNMNLcs53yIaQV1ISmUDeeVWLcBwbfVmGzu5RMElhRPOgKEGtzYrfTSetqkWRz5JismqctL
 gxPpC4s60NH5H0iiK5PMk6YvEtrjT1aG8DlJD6HDvA38R+wXaEabTpOaX7qGaFGUaPgXNoF6TV2
 HEYeOzINqZyuJUfb9GdHUXzCBIPXV1NndM4OtnIFUHwkVWGdTHLT1DvaHRzxJu9HN9/ZYPavgaT
 i4NPFZRsTuxjfjQL2yDC1ceZwccz0mOwvd/QauMgJjoQIiPs1lQg93e0NwiJT2sk5idzx9u2qoY
 9GJHVDsUGq7ra4WQuboepYn+W9BVq27c1qpoAB7b5PGEKFIIMBNNf1uRVZCWyofIn6bC6RTjX9V
 2Li4XCfMllg6My2QqqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030097

Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>

On 9/1/2026 7:14 PM, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> This series fixes a couple of different, but highly related problems, when
> dealing with CPU PM domains. More details are available in the commit messages
> for each patch.
> 
> Note that, this series is a follow up to fix problems that have been pointed
> out in a series [1] from Yuanfang Zhang (Qcom), to add support for new
> components for the arm coresight subsystem.
> 
> Changes in v2:
> 	- Dropped the RFC.
> 	- See updates in the changelog for each patch.
> 
> Kind regards
> Uffe
> 
> [1]
> [PATCH v2 00/12] coresight: Add CPU cluster funnel/replicator/tmc support
> https://lore.kernel.org/all/20251218-cpu_cluster_component_pm-v2-0-2335a6ae62a0@oss.qualcomm.com/#r
> 
> 
> Ulf Hansson (5):
>   pmdomain: core: Rename genpd_status_on()
>   pmdomain: core: Allow a non-CPU device in a CPU PM domain to do power
>     on
>   pmdomain: core: Add a genpd config to support unknown initial status
>   cpuidle: psci: Initialize the PM domains in powered off state for OSI
>   cpuidle: psci: Move initialization a bit earlier in the boot sequence
> 
>  drivers/cpuidle/cpuidle-psci-domain.c |   5 +-
>  drivers/cpuidle/cpuidle-psci.c        |   2 +-
>  drivers/pmdomain/core.c               | 111 +++++++++++++++++++++-----
>  include/linux/pm_domain.h             |   9 +++
>  4 files changed, 106 insertions(+), 21 deletions(-)
> 

