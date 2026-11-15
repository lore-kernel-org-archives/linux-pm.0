Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758371;
	b=5EZs6UOcOMzxF19xCOKbJSxgNsXrQCNG1jyhiI6x2yYCXxFx4vVRYSJy3vU5LdX0KzUt
	 7jzd28Vw/7dRqRiCNtfaVMnTmZH3LZ1phycAHIKw7RyRQzTi0o1ZOBv5Bwzs3wujRYRFV
	 yyM2frFbPRnHj0k1eT0JxQB5SXuJqRaaWsFDk/2cebnb9nrU4T7NBEd3NIp/0aMA9BWYI
	 MTggUKrwrFLN15bBUJXSCsSxYwHQTyjOHazPofJacP4Om8RJz2zMeXxN0FHwmXhHhFtdY
	 eQNwZQS+VwEn8aIdIbt0DVj4W40tMZBxTcL+pxxTIA96lcnIzWWfdZ+zQRyGHbNPGdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758371;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rU0kaOlqF9hCuvhvsgIDlYklK2QFRWqi/dYW1+IFo+I=;
	b=y7yGzOltd+fO8Sj6ZsEs6pVXUpb2WGpP8cAGzpYsno2LUrfTVHeyOSe0WMAsPrgRRlU+
	 kM1TkiF2t280G4J5EFYDIwnaZlrwU2JsCehHY9ZMScD0BQ7yIdCz3Mx3FV25XtmCL3ezE
	 jK/CLprhWpe+FLY8mK6GQSsbx6syIf+VXhYGMuFED3glkHS0hZqchJ3rr+LLuLhTYdqKd
	 CZ3XvWFfQrEiwie4IXOJ9w0RwDR76NTkrER4iS8X56uT5qlpW7U7+zKt9v3sFmCMekLeD
	 JJJymUyqnJr7pRFMMdZ+ssgB/lrHUrtRPtdSXaVbebIbSZ7dFWRPz3sHcRZA1qq9KCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ixfoMr+z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Y//5Sxd+";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8268606A329
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 15:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8268606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ixfoMr+z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y//5Sxd+
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFFBHsm2643422
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 15:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rU0kaOlqF9hCuvhvsgIDlYklK2QFRWqi/dYW1+IFo+I=; b=ixfoMr+zQPJ5pPB4
	N3Jra/9kLU4Tps7ooXjkJ16KY+CjnGJSpAb6BzhHiRwrfZdu0tIvNABYVeBzikph
	OE1Nco6B9zP2r/yu4zTkFbH3iE1Mc8AqCPBKIFJCnYIV3wA6M6qgTDzYVrs3NW5F
	fBVSL8F6IW8ImljVD5/xCZvixQdLcGvM+Dbo+lW38Mh5CyrvUzCmGAG6lxdgL/LO
	UmiuW1kQqnkCrwq3G+juHFX6+SjLE2shmtFHGc6aWUd7mwbT6u5EPDzixK/fyP/2
	1655qe+dpmL0LrohoCsU4n3IdZt4Ylg00PHln0cVxLXAOKXPAWONk0wcM0cvIwyS
	44s74w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqkcu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 15:59:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f3969a2a7so431121985a.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794758369; x=1795363169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rU0kaOlqF9hCuvhvsgIDlYklK2QFRWqi/dYW1+IFo+I=;
        b=Y//5Sxd+AU9S5rMWaNS28SKRgN5qtLzGzuiO4ZYF8UT6qU+fVXcWAIuz+kaqfGCPZc
         b3jt24nfFxHiAqYRZo+cxcIxH2qOYpOdOTj9lInruUwG+2ItNZwBkMYzdFhclOja9QCA
         hccUIxD6Q2/Cp3LimHL/WgAhDX4ZHdb1JSnhMstqQ+oVtOOenw2DfcRzVAmg4d4/3Rtw
         Rp1UotJrFehNQKAF2GOJFTrUUV1WM8vmK8dW8p03N0krgjo6clnDCCMwLJhr5XxzLBrA
         7Y2qFW2HxUkQtTdExWcBQQz0ObdkH6u+x4pv0IAe5KGgKN1QCD2h9CeDsQeW1RV4eXBU
         yZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794758369; x=1795363169;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rU0kaOlqF9hCuvhvsgIDlYklK2QFRWqi/dYW1+IFo+I=;
        b=u0UbbUVgw3icgRXT8TBeia1pqidEpwxyUrh60nRF6nZWIr90fC/QA1HacSeMlEPlYr
         +iOTentVg5D2RpT5vedksuPMlWhDuzUabfAqI/fLj0dIdZwVW6Nlpe+nQrI3w+5a+F3w
         FwWaJe+ECb8i9kOFWaYtFULa/5CN2z+bhAAZR3qg4IdiHnl2CRaMUc3kGbQL9/T+EEoA
         7u8lThmM7/jSWblJwDlIJ7OabNfEhy1+Dg96VpFoANaP60z1557rNs60VChAR6VIAAH0
         HFB9ROlU+HXbl9Tg/O0ovqYnAY0wePdsRdRjNG9jAwCa0G24zWNGxAYjbSLr5JKkexDD
         +7dg==
X-Forwarded-Encrypted: i=1; AL+hErGn6jEW3HrN8UHpqsdA1RdiJCut2c2vGKXLbEut38o7R/F0JTG1cwcHgwnQZCPeEwzyi7R1CGlIag==@vger.kernel.org
X-Gm-Message-State: APuU4Z/W4YJO5u12Qjv+Q7z5DorSg6W5jR3QbCupaisWr00n5EPk9QWB
	4QTuslrVhb8mMCH+o0F9dxVIzH0Bc33/oVwbcZ1NZA/6+8I4toMbEVQORtJqx7v6poTjQAyQZmw
	F6Fe7RtvYrMZqZ7F4mzXHv75Z8LEG1dMZ7zbrzrnkDHjUDjtpFk/5d3EZbjePow==
X-Gm-Gg: AYBFou1Yvm5uEI+/nWF9K6MwMP/PyTrjMTUg1XZaGZyxmsbGNSy7Pp3OvTw/J3G6IsJ
	d884tsMFHR+6YslwKxyYyI5KLD2xrYho+KWhBm4jnxckLRLlPvHmS4SjTsCZenkHpnHD3I0I0YV
	I0N1vdLpn3AsvOoW74AUAQPLLvmFURPvrVeHrd9G3MZxgeS0iGDP8C7oouaTHlKnqMowOen4W1K
	kCXIaVb3teEQq4wiHyAzOMEJqBnHzAOSN3hkC9nU0sfVcG5GDRiocrEqnsjxgD0LTu+wxeFIYqp
	MUUjYrWSOFU4Qp2DU0c19JPeuY3OhZIP2yvPjW712y7wuk9mZJL7gZXl8/kOEDSjCidCktXVjLy
	IbVlc0sKZuqS+wb56LZIks82BLWDKHUP+QAhwAVyoIdGUECeyPGv05kxzyTey2MSX+ekt1ceyh7
	b/veAfR9uG1l2bWti+Y3/yPNiiFdsc6B8yG/XGx21XUGCEZkmTgWzKy+C5jYDKI9M3SIr/PGdhI
	MlXkU9i0zmeEwdpEyp+tdFMt2H/e/243UUOCQlrP7R/
X-Received: by 2002:a05:620a:bcb:b0:93e:c12c:4402 with SMTP id af79cd13be357-9494bcb40d5mr1383889285a.79.1794758368720;
        Sun, 15 Nov 2026 07:59:28 -0800 (PST)
X-Received: by 2002:a05:620a:bcb:b0:93e:c12c:4402 with SMTP id af79cd13be357-9494bcb40d5mr1383885485a.79.1794758368150;
        Sun, 15 Nov 2026 07:59:28 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611bdsm3439393a12.8.2026.11.15.07.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 07:59:26 -0800 (PST)
Message-ID: <42350f50-d20b-4141-9ff5-bbfad5fec2a7@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:59:24 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: don't clamp gfx and gmxc before
 sync_state
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, Oleg Keri
 <okerixx@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <rob.clark@oss.qualcomm.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20261021080517.2161-1-okerixx@gmail.com>
 <CAPx+jO8N4yLD8pZ2vr9_3MD9==FFMdvQG+=1JjDoe2kG7DR1iA@mail.gmail.com>
Content-Language: en-US, nl
In-Reply-To: <CAPx+jO8N4yLD8pZ2vr9_3MD9==FFMdvQG+=1JjDoe2kG7DR1iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KelHIgYD c=1 sm=1 tr=0 ts=6af9d6e1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=6R6alxyDzFe-mgSiMmgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA2MyBTYWx0ZWRfX5UmTmvHIR8jZ
 y2UtkbEeWLSWpfkITtIuKmYQWMWSIAKvbVYlr7C3g5S0RpgbT2dwM71zVWDJ7L/0GU1sKzR6Yje
 wcEsNsA7Wjw9lT3DD9PBy79f7qJq8G0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA2MyBTYWx0ZWRfX+I1VjSgEkWOZ
 gMCAiSh32BkpPfGtIloo4+Kpxog/r5govhQj8V5O9a9fzTxd0t0Eiq/1VmYm7+LorYTrLriaFvS
 ciOG6iJvN00oU9E16JQ9cazAbrN2VSig3ozI+lzUOHrBAmiHueeOg/BDmTLA12z8gKoXST9p+kG
 xrmHzL4u/iPWqLuNIIyr5VWX5bKrbFOWXBgHifPb0vgcOIFVGZUVwk89HRo2pHt2Boay7BZ5wAi
 aH3ND/oXgPJfdGisYCzvhUmSAsAdDyrAlR6G22/YLr+mpkXiA5bJbTdKS146ZIzweV9qiekQ6z2
 GDkIvA7yAAMLbWFn3PWobwhqewDYWFKaPFgpnGREveMtHa1xha44bCc51zU7lZa9WnjmXF7x7Tr
 5EXXLhr4V0JRa3sVoX2eHUbNx1pPmO3y5MVMB88TkGWVjHEKKq3jNfIxhC8hJIj7heNev26l7+I
 amNAr1Cac8PA2RTQEJw==
X-Proofpoint-GUID: RjX87Gh2ZLpQj31P-h6xpcbr-XGbXArJ
X-Proofpoint-ORIG-GUID: RjX87Gh2ZLpQj31P-h6xpcbr-XGbXArJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150063

Hi Ulf,

On 13-Nov-26 18:48, Ulf Hansson wrote:
> On Wed, Oct 21, 2026 at 10:05 AM Oleg Keri <okerixx@gmail.com> wrote:
>>
>> Until rpmhpd's sync_state every vote is clamped to the highest corner,
>> so that hardware the bootloader left running keeps the rail level it
>> needs until its driver takes over.  Nothing the bootloader leaves behind
>> runs on the GPU rails, but the clamp hits them anyway: the GPU clock
>> controller's probe runtime-resumes and suspends its GFX and GMXC
>> domains, and from then on both rails are pinned at their highest corner
>> until sync_state.
>>
>> On Glymur gfx.lvl has 14 levels and the clamp holds the rail at the top
>> one, 0x1d0, while the GMU's own performance table ends at level 11,
>> 0x1c4.  With the GPU driver and firmware built in, the GMU boots long
>> before sync_state, and its CLX DCVS calibration does not survive a gfx
>> rail held that high: the firmware gives up with HFI_F2H_MSG_ERROR
>> 0x007306c7 (ResMgrCalibrateDcvsLvl), the first HFI_H2F_MSG_GX_BW_PERF_VOTE
>> times out and the first GPU init fails.  On the Lenovo Yoga Slim 7x
>> Gen 11 this means the compositor cannot start at first login.  Pinning
>> gfx at level 11 or 12 instead fails the same way, level 10 and below
>> boot fine, and pinning gmxc alone has no effect.
>>
>> Leave gfx and gmxc out of the clamp: they have no bootloader-configured
>> consumer to protect, and the GMU votes them through its own RSC.
>>
>> Fixes: 93b6c8d10fad ("drm/msm/a8xx: Enable CLX feature on Adreno X2-85")
>> Link: https://lore.kernel.org/r/179248663855.32151.9955864156939592299@gmail.com
>> Acked-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> 
> Applied for fixes and by adding a stable tag, thanks!

Nice, thank you.

Talking about regression fixes, any chance you can take a look at
this MMC fix, which as the cover letter explains also is sorta
a regression fix (the root cause is not a regression but other
7.4 changes make it easier to trigger):

https://lore.kernel.org/linux-mmc/20261112124430.110629-1-johannes.goede@oss.qualcomm.com/

and if your happy with the fix can you queue this up for
7/4-rc# merging?

Regards,

Hans





