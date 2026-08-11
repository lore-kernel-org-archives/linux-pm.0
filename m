Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8244780C
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459717; cv=none; b=EMeWiQRuuWokyE5F5d9TwLKsg35EJVL45RbAC86eBUAk6UbMo9EN9vm0ZkZWSRV/EyyOUX1lS3aZ5mXccGAOiY4XbtfVRA8WWjv66cpIUeGsjm2UdC80BOLCnUbfXI3VPROqy28BeKck7yTjHr8wO8Y0MGSt9aWY2Nr/0ueTcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459717; c=relaxed/simple;
	bh=/+YlJY5BYIYZfwM0fc/bHNiyB5S/K7DAZiSoGFz2vbY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O9BxS5gzh4PCRmOTShNTDIn6nv/8gcOTD7SCb66vrii+A6Lw9uIqhJvfiFUWK9iAsgpTdUjJsvXP4UA9ohabrgBNU4ot3oswwx/j69SKY53zdCX8iPQk9JaC1Mr5FmccuPIu2yf33089yjIIfGr4IWusYG1XD01sSOqQSG6o+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VBKAc/92; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ezJbY1Yp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VBKAc/92";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ezJbY1Yp"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXIfh462556
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bhd0YqdVK8eKaDMmYDNoH6LtglvUe5IlrG8I9K3Piow=; b=VBKAc/92QxgXGoev
	NBkn1ksFj//0EkPBEDbUm7Q0lVUM7zucK+T1UDpzHHgar559pfU3dSjBWSA1Gs+O
	qmCEi59u7VOzj58bQCGwt7Ch7hyJ4tKSmnWR69cpQCSBg6gwf6MGsiSskDQ12YUV
	GVO021MWoE0qbxJXluf5J8uQiWnwWLmQ56PDVo6Cqh06u4N6c4dJ2h3deEbic1Tn
	vmbW1GSxwD9em0zxM5wqDPkrJh69jiT5sRIvxGs6J3DUhMwqnUhyDI4lnnNN5Rpy
	ecPRP9OKytBcnmhTWkdBrhYUjEluuULwCYfZs71oZCObZg4G+j0WG7KttK8/v+av
	wUXluQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mgex5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:48:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso58339411cf.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786459714; x=1787064514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bhd0YqdVK8eKaDMmYDNoH6LtglvUe5IlrG8I9K3Piow=;
        b=ezJbY1Yp9Q8FrpqCYr30GnrKcxcg9/hz7XqSMpDeg+CtjU34iQlQKzV1Geg8nf5DwN
         PYTnRxjS90oASkCeGieAgePVw8Gq+9EHUgtneT8Fh/ieMNVR5lr8yGMiVcztIxgUhvPz
         n/80fwFb5ZBn9vAWiWkyuQlsidzZyQg3S25E4AMbF8Qd3DAdUer2LsVWiA6YwVH6gvYo
         z+6k/l+ZjuAErbjWhxk0tIjQJxsaDvG4xAv048RT5PyWkuXEUfwNq0MtTVsWo3to+y4M
         ueaYD88P3LmWAG6dHoTLNlOR7RbvF/oBU5BFhOdqEIsFnrE3y6akrpOFXR+PP244yoeX
         hjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459714; x=1787064514;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bhd0YqdVK8eKaDMmYDNoH6LtglvUe5IlrG8I9K3Piow=;
        b=L5k40maISkUCb1UniKmZT4M1J4rrUpjMNGPtOkqwR7DA4Jvkd0iwSpc0OOO0ClO7mx
         mdGePjiMCs85lPwkVW0a/cdJuflEpyd1HvmJoB6Y1nS5oGs2mi8clQ+6jiYJs6h5tdKA
         AaL6nWYStr37VN23Yrlb9C1AoAgV06jsIuqGNPFxsyAdHmRpY2OM/hOMqUZi637qfxJV
         Z/6PBdxxZ2O6X6PkF1HDGEHanBWraRihWGNc1kTn1/DecQW4yRHzX6eYm9XARS5jOpDw
         +SM2VF1nx993/sfXtaIPecj4OhpmPZDObdDZ0kW5CTP2X/m1KCUIyFlD+rD+YO7mx74f
         5UXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp78Fp14w3emql7kS47xg0YNsd3B09JlMqlUj8BMNpubMMSkBMCHsL2vL4rl+b+eJdAteMhwJO4eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztKDWHrj+aUEKGaYrFZVJETX6IgY492gMhg9BD3jWC19qMGRIb
	rxBJ+/3uVRPoDAuYBTolebcDDG13l/j/O+/4XQmwlrNMVe5+ixDEu1zCEOhRTOYlujsWdpF2XAs
	Ip9wiIJWERJgxONoMCtbk0T9UrD2cV7xIq3xHz/SInei9/TwjWHFom6Zn+AurGxkmeHqaoCzD
X-Gm-Gg: AR+sD122DT2vrAH05YSvzY8WuAjAe38LY0LpkAp8D511WM3/hxp/7dzTmU+jc18PhQH
	DBKjdAIS0QGjomRYFPejker7o4XjG/3n0UA99zHkHT8KYbnSwsaqXNI/9h7sbJdOYzdkOg39VVF
	OHuBG80Yb1bjjNJY78sLNRRSTeIZ1g9Ws3lRE3d0fGgwcycr3+Dq8cevcccuqMYaX1CaAQXKEOz
	jGyUZ3anLrDILCKszLmMC99t//PdYKEzVFN4dMowaD3sSaXuN3E9/cMR4Fy2wv2XHC3aYHDzLml
	6BtQGot9FcfrviveAjaFLBH0sc9hoHCVl5zdkPFrP6E3xyQGtTso1ASoQq5DeT06LdGPajw/thm
	radjHcagd9h6Cs7oOjD+1yshyRckMk9Tmzu7Mp9awjKw34DECv4Uoihlf4xgXKjo=
X-Received: by 2002:a05:622a:118d:b0:52c:dde9:5cd5 with SMTP id d75a77b69052e-52d585e7a53mr34618561cf.21.1786459714094;
        Tue, 11 Aug 2026 07:48:34 -0700 (PDT)
X-Received: by 2002:a05:622a:118d:b0:52c:dde9:5cd5 with SMTP id d75a77b69052e-52d585e7a53mr34618141cf.21.1786459713751;
        Tue, 11 Aug 2026 07:48:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b467:f322:cd3a:615c? ([2a05:6e02:1041:c10:b467:f322:cd3a:615c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac76asm4438521f8f.2.2026.08.11.07.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 07:48:32 -0700 (PDT)
Message-ID: <cf0365de-77ee-4ae9-96bf-0652c172f425@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 16:48:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] thermal drivers fixes for v7.3-rc1
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        "Bryan B. Lima" <bblima@usp.br>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pBysC-ZkPFcyIRVRztlvrfUWLa9gfpta
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMyBTYWx0ZWRfXxBzWPqb/1Ibq
 4jRb3UF0kbVtZgddGNVbLJ2KdjQlKsFudvx4wAh+17vRwPuWczHYeKQlUVxDn5LcCP1mfwpNCK8
 IN87wqIMW8p7wXBTvUF+qd6EYI5g2v9dXmQ7K8XMslcx++osiU+pwOFaC3Lvj1P9xYw9lDUb33g
 F5kOzZhfZFzHiw3SCAy4Qhlb8EZ9CzXFWlo0RU1roI+gBHOVnQ2btWtGSwO47k4HuiOrlGY+aQk
 mNr0e435LRZY6nJZYoGke7teQTRFOTw7PMi2AKaT6T9FoCORTjwF/umKC96Zm7Os4O2MNeTLBDO
 ahozpTFN2yzMywk7ByzFiWP6MC+uGza7y5WSWAduXDBYYJ2UrZMAQlY16eNcFlwu3VC3gUdyuVq
 Plgr4yNOiwiSn6W14aohDlL98sfWG1kp6YqaEKwnk1LXl5VqbfHHdBSWz7pCruu6HflQQ/1O1KI
 Ksln1a4tXLrWqACMdZA==
X-Proofpoint-ORIG-GUID: pBysC-ZkPFcyIRVRztlvrfUWLa9gfpta
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7b3642 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=8JwhlBZ4vlciGuUxUlUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMyBTYWx0ZWRfX5lJzZ9bbJuO1
 SU2GmoIV5uONOb6UoTJEPiietUwJhclEYR9dsSyiwpLk1X7Ih9v7lB94ztUtOkkaBSTjbKZqiNT
 WqGrFWAIBvguN3Zz/X7am9Th+fo+1/g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110123


Hi Rafael,

please ignore this PR because there is a missing SoB.

I'll fix it and meanwhile update the linux-next branch so it will fix 
the build issue.

On 8/11/26 12:54, Daniel Lezcano wrote:
> Hi Rafael,
> 
> please consider the following changes since commit 
> 55c16e15ff9f91bc994a20124b83faf27f0e3690:
> 
>    thermal/drivers: Remove redundant error messages on IRQ request 
> failure (2026-08-07 17:27:28 +0200)
> 
> are available in the Git repository at:
> 
> 
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
> tags/thermal-v7.3-rc1-fixes
> 
> for you to fetch changes up to 22114b21259b3656019cc0cb3214618f5eb278dd:
> 
>    thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header 
> (2026-08-11 12:43:45 +0200)
> 
> ----------------------------------------------------------------
> - Fix missing bitfield include headers in Armada and QCom SPM BMG
>    drivers (Daniel Lezcano)
> 
> - Fix missed file when manually applying a change after a conflict
>    resolution for the QCom SPMI ADC TM5 Gen3 (Daniel Lezcano)
> 
> ----------------------------------------------------------------
> Daniel Lezcano (3):
>        thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 file
>        thermal/drivers/armada: Fix missing bitfields include
>        thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header
> 
>   drivers/thermal/armada_thermal.c              |   1 +
>   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434 ++++++++++++++++++ 
> ++++++++
>   drivers/thermal/qcom/qcom-spmi-mbg-tm.c       |   2 +-
>   3 files changed, 436 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c

