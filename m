Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC13F20F9
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791587261; cv=none; b=DkJhU0JmnIACtNJ1uzQft605x7I8ROm+sNtnLmpQSjEWcd3fSX8guAdfu7y/hr9KPqMPtOX4f6lHjjmPvfczxhp7K+/8w1UY/4obnOqAlGtRAitAJbsuYd35pezwPLNh/Nfw+OdayTksvAi9lUR3KGL3VLF44VE4/WlS5XIRDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791587261; c=relaxed/simple;
	bh=Ve40xAhUwgsJmkDOTf6SSwLlAmWYW2ijle3RYllFIvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE46tNzD1e+ykTu3tz2SErx4C0bqQNSb0124Egr9lTWcaxov5ick5CQhRWPq34Nn/C1SjCALhdlS1vhzHbq5UXe0UXby2i52yur9N8ETzSuG3Ci8IOBQuL18DEQZiKPHO/1hG1MSAbOLCtTb2H9G/UJRudhZMCWDO+okGj0Krao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=poxeMDiZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fkposgGA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="poxeMDiZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fkposgGA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699Ki5ac3372676
	for <linux-pm@vger.kernel.org>; Fri, 9 Oct 2026 23:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eJQ+kf5MnL7xKpNUvo4gkckT
	69br1MaueIPMleCQVbg=; b=poxeMDiZBPhAJbo+sTTvlnZ9TltLVFYzd7SEHzl4
	Pv6xmRRMi5iiW5kRjFFQvb9nfzDRYWMJmDdnUooqJ0HbXW2PrnpRiwWCyjKfYJ6d
	0o+ov4AGkPZP9xBLDU6Pe99UWZFPuIn628qhgF2WHdI1jrMbrQ2Ci3r4WGCeZZWI
	WLdh4M4ktu1ke49A4DolJghNjLGhXlAy9Y6khoBq0HEniT/ZhUE7AUNoiXfL1jki
	QdlhDla+n+nLl8EF3ghk8oAtQxkD63HgfKR0tNHqYqNbsy1WyM7DzDPZ5WSVkbEY
	yAkCUtisPNdh3C6Dm9tJ7IDMvKUt9PAnkuV+kYHtxN8Fsw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8h1ru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 23:07:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e834ff4d0so48367485a.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791587258; x=1792192058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eJQ+kf5MnL7xKpNUvo4gkckT69br1MaueIPMleCQVbg=;
        b=fkposgGAvf7ML+q7EzSzIXtxDkHGrzyEnnPlLiC2EFgS/EBHuP7cFVfgA6C32tGAX0
         hei1Uqj6sQJNothuz/GJjmWBA/XVyNZOWh1IpT+Kq2zJ1x6E902xj8+7o5UzrGMiC8ge
         ogbo5z8PQ9bqWCcJF8S1QdHOPjNqx1FnebhUYAlOZHud89zn4g8XRjpdmJmYy+QwQiES
         mUrsevCTxH7jXnZUMgfNUsWyF6UW7nrbJNY8EdrhXnTK1+ZLk7AiPH174n9ARs15ix49
         wwQvK6vVwh4O7JQzczClIRjubSMmP5xxZ3snVoHUOHwGamFVM3EncNqLAa8LQ/ifd2Ax
         rGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791587258; x=1792192058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJQ+kf5MnL7xKpNUvo4gkckT69br1MaueIPMleCQVbg=;
        b=m5T28+ZpfBg52SE4izQv7zaPTItYhryMe5flMSCZLCGkuMPFQNboKMKkmCWQBC5MaM
         ErQTcWnVl3+FBcFEuDZ/uHWKsyauDZc5hNSY7/xY2eq+eodHMHEeinesQslRN1TGNYJ7
         7iowvx7czPuKQ1chTuQ9i+W5WCdLtMZmRjAPRD8Lm6j97AA6TDiBAcGfsPPtmOLMdMcP
         WWfRJDFUwf29smlOC9FRlkmdoVPUkKa/QUR78Blpg57GAsXPQntL0orOjjVsqlR/W0p/
         d+RIPcZyT6Vyv175KSjVBSbgRp3akfv95xMmbBgeBPheCHLKXo+OBqk4GtlgURopxD5q
         g+mw==
X-Forwarded-Encrypted: i=1; AKwUvByBx4I23X3jiWl8ak4q6Y0VeN+UU9Fw9VPykurdMUbrrTvnj900W/F2rYBPxi1J0isGGJwRL3SbAA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvbXtzOTKJ7x3H7KZm2Fh239+x03i8wcRdnBa+RP3XAsdGBWRd
	osBHzsJ3OjiR4GQMkS7HhpQBHkZCy/FqBPGXFlRxjxOxGq0Q4UIEZ9je0Qv0wpSjKQR/VtuxVoR
	iwZBVFaJ58pC9xxLIxtHrbnOE8fXbGe0vJr2sChnVaVZuhWcYU924K6w1WKQwUQ==
X-Gm-Gg: AYBFou3kl7iOJgs2cle5rhYUmQrXFc8bXzREGa0C9n3j66/rKNO6gjvpH0KUBDeMqsM
	NeUf/dE2Hty+E5gxmsPV+dMAKueQou1Ay9YHsRS/+A2gcmbYf3s0tnxjFbrFUG8kplDSN/z3s7B
	qmGM3CKp43i0HgxHYymMogOrTdtYUBrcI65KQIt6jpqZjnr5e1S/a1JGmzhn4NYQ9MvuxtWEbzT
	fc5EfJ6qBnTSJO4M/p0yVa3lc0kZSuntdiCe1/j2Dqf+gRjcK4uYaf0ypkS3exhFJ7hvGGWs8QX
	2rqYtQ3VQXs2BHw7+zKTNbPfCNm+QsP0F4Xq3LyqoEt4ohAjNBhqWimlIdmyw6xmAhotLIAUHno
	AUpHWLrPg7/eJweNLIVamInJuGptJi/MSam60ah3LIZ15SHub/X9ffLUk5y7BcsEn4CvLSYkq+m
	SkNnytr3dcI8PW
X-Received: by 2002:a05:620a:2b8b:b0:93e:c12c:fbb6 with SMTP id af79cd13be357-93ec12d082emr442616185a.67.1791587257569;
        Fri, 09 Oct 2026 16:07:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8b:b0:93e:c12c:fbb6 with SMTP id af79cd13be357-93ec12d082emr442610785a.67.1791587256954;
        Fri, 09 Oct 2026 16:07:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde36571sm1047516e87.9.2026.10.09.16.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:07:35 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:07:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: fabricioakio@gmail.com
Cc: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: sdm660: Enable keep_alive and
 sync_state
Message-ID: <kpkyqx4lxytqybw2hi7sgjn6yxjpfwiubebpjkbmqxq3rqhfto@eho6emqqfz4o>
References: <20261009-sdm660-icc-sync-state-v1-1-77b8d2501cb2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-sdm660-icc-sync-state-v1-1-77b8d2501cb2@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MiBTYWx0ZWRfXzXXIMVWh5vY2
 1huC64LNRiyEqk8zYJY6rpleevY3800uEmqRbjYdD9jpUJZnHVS0EoPpOLa2Iw994jd9dvLX0AJ
 g7Vzwtj3LwOpHECIorYJ/X+HZ0C+t5Y=
X-Proofpoint-GUID: 9obY-mu4rWuw36jZcdrOh3QtVy0V-1At
X-Proofpoint-ORIG-GUID: 9obY-mu4rWuw36jZcdrOh3QtVy0V-1At
X-Authority-Analysis: v=2.4 cv=AMIlxa6n c=1 sm=1 tr=0 ts=6ac973ba cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=tVI0ZWmoAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=jpwJ7B12E_5cSkMseaMA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MiBTYWx0ZWRfX7nC+gA2ClECY
 dzHUoJOZmUsHyHLc58p9jKs4uvAI9S/CUWJZ4u2aDs2K5IhvAVsejlDQUy9qQ8W9q8AYJePDphJ
 0rcMbPe3lzeVtZiNvqPd58FnM12kBOTTg0JRASGuGtj3Br6ES9GlwyaETJGjDAo5ca1z4xXsfA7
 CpFMX0c/BUuGMW+29+ivmq5XHCSYB7mAPhzNSq9I7uprq7qvnW3IQxlXdf2Bk6TDZYGRchW1eFy
 F5TtZHDh4ZoOvCPTnsVyq4g7pn4+6aKAlT49Wz3KWF6aUooohOy4/HMfcIPCVTkBSnFI0sZPbAK
 JcZr0DCjLSrbQAg1MJGtMLiua97xrxa+UNBjaDBLFxnTDIaV71ua/f/vOBSI07sO3PYkJgW7U/S
 IL/H2LW64k3onTsW7jFtcv2prMdEGdH+rQl6GKZhWaak/F7QxtLQwLlri6mjye8dZX/zAZPn1Pm
 W9vwfSboSK3PMaee8dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090092

On Fri, Oct 09, 2026 at 05:45:41PM -0300, Fabricio Akio via B4 Relay wrote:
> From: Fabricio Akio <fabricioakio@gmail.com>
> 
> The interconnect core starts every node at INT_MAX and only lowers it in
> icc_sync_state(), which this driver never hooks up. Every bus therefore
> stays at its maximum rate, in the active and the sleep set.
> 
> Hook up icc_sync_state(). Releasing those votes also drops buses that no
> driver votes for, so enable keep_alive on the providers with a bus clock,
> as QCM2290 does: it keeps a minimum active-set vote and leaves the sleep
> set free.
> 
> On a Motorola Moto X4 (SDM630) with the screen off, this takes the
> battery current from 117 mA to 68 mA.
> 
> Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
> Konrad Dybcio included the sync_state hook-up for this driver in a 2021
> fix of its paths [1], Marijn Suijten posted it alone the same year [2],
> and Krzysztof Kozlowski for eight Qualcomm drivers in 2022 [3]. Georgi's
> concern then was that buses with no bandwidth user would be turned off
> at sync state. keep_alive, added since for that case, keeps a minimum
> active-set vote on them; QCM2290 and SM6115 use it on all their buses.

I think, at some point we should get sort out if we really need keep
alives on all the busses, but it sounds good for now.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 
> Tested on a Motorola Moto X4 (SDM630), whose board file is not in
> mainline yet, on the sdm660-mainline tree, with sdm630.dtsi's
> interconnect paths as they are in mainline: all six providers synced;
> the eMMC, the SD card and the USB gadget worked, and the phone
> suspended and resumed.
> 
> [1] https://lore.kernel.org/r/20210728222033.52500-1-konrad.dybcio@somainline.org
> [2] https://lore.kernel.org/r/20210904111452.248804-1-marijn.suijten@somainline.org
> [3] https://lore.kernel.org/r/20220427145616.523557-1-krzysztof.kozlowski@linaro.org
> ---
>  drivers/interconnect/qcom/sdm660.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

-- 
With best wishes
Dmitry
