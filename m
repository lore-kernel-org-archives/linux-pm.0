Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355944519AA
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362715; cv=none; b=iaBtsSQuB2nbH0pfaELrx5Sf1v2g1cVYAm8DN9lEBUzLXL0NAlKpf46inuBNK/UNYeq4CVJOJhwFd0eU/ikmG1gKfmBMljHXPSql7eeMldqeg5ANKL7ZUbmst6td1krr/Jxx/YjRwswsAXy7yhvez7oGlozrCcXU4PWvKiTMIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362715; c=relaxed/simple;
	bh=cwwZ1AvHUGpQ0cX0o0ag7M/FKmG+jLvaiSKvBHQ1LUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WG972uqfsW9rCvpQfonAng5fS7+Iq5l7n7rU7WYBc5x4VgGDBllHxFM3HWfG6cJ+U2u7nyBBHy+xxk3GktZzOaWpMwXOwnFE8wGa9RvPo/kVRu4drBy7tFUvKVtTDdIiV/y5PGeWwZkfrm0zNiAzZoMXhQDaJqdGK6XjUpNH/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P603HSJq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DeXn2VcX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P603HSJq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DeXn2VcX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jbfl1873507
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 08:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ofN0xqNd1KAV8nhkxjJDPKF7aC74Hh9gM7raBNbLz50=; b=P603HSJqg5tlDHMV
	7FUTb+LYuPySuw72yexv1KsqSEtHA0LUNdHqTfAIat8pAvKPdLahK4yxMlggPFKZ
	jWAAlEVa25C3YTlbChMdUug5Y+Wp3CXT4nCvCk3Ml3qt7ii7dY8oDA5jhP8ElDJk
	Ec74g9U6ChKWsr52aIv1OLBU6HWETMdC8nrohr5YoMhQB0Rt2yuVOJEI4L5/TiOP
	3iRypcb9HmmDLWGWpvlkMnObBo5pPufLQSAxlVXzfrdqLGgmYst6hJ4qCErssUia
	SZ/CuhOEN0bCXFlf/hGFhrwLRROKFgW6yXDlDQpD5kgnzf01tmMUPrU8Y9pNj6T2
	3EwAVA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8rkpd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 08:45:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb98809caso533144985a.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791362712; x=1791967512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofN0xqNd1KAV8nhkxjJDPKF7aC74Hh9gM7raBNbLz50=;
        b=DeXn2VcXwffyjyfddIMqHOR3E7Zlg3DZet6ZHWI44EhM42BNl8SP6+/onolSYm7Aj2
         Z4d/LqkZ2ccI+7vnic9F6zqRHNXb3JSrZYF6suU+poU8sVrTV0QVLCPX6zsptGQAceEW
         fFJjB91R+pMG/w/oiZSJAYAmve87ddNrbZs6051pvK7kRDpTwAsfcpXo99iRXjTjvz+J
         IWpHxblSbT+88s1rXMEGdd6EcKdp3GQQOaobM1FPJSiuqou+0mqJRfOvWefMYHP5br2c
         RNHKNJhh4KL0sZr4H6tTKMPut76hih9Zix7zO2Vgq/Tmh+FMapSJd4T7BbRIT5CHVfZp
         SeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791362712; x=1791967512;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ofN0xqNd1KAV8nhkxjJDPKF7aC74Hh9gM7raBNbLz50=;
        b=S/c19O42NXjbDdWtYNnRdoFtiBpqJpD+zvfEhOk9g+452zdjXv9lL8iiyTrrNIhKvn
         156ah1XCPwUD0d+m3pJFoeWQJ1029lS1AwVg/wONI92F+dLaUy5mQxGlwU3bjYVsW3SK
         G66ZEeyfwP5fQRgYSbum3/7DaUZE8DK2+jxICjmkjlXZjEMDQXX6o2Ub+kqRNpl0Fb7c
         xYSKOD6cEDoYQDCHk5AvKpbgy53hbB3CrykXRY+fqT1ES4iINiCH2oalMomhuapWdGVb
         0DDC5ndl1Y8x6+fxN+kWJHNJV6PGywrBb+0KqeAZslmrKgAJxy+k6M/FGLRIMQGnbD3M
         Hy3g==
X-Forwarded-Encrypted: i=1; AKwUvBzZ3c0fjpNjZ1MweDBQsw8JpOlAdJzuXWUwHfAL/3Qfi/FVgmu+zinjQFuGdq1Ue7MO/AiEYidtYg==@vger.kernel.org
X-Gm-Message-State: AFuF++lxUIMRRuPsTBWP4Htlsitt7dthgbCRPk161a8ovVVrsY7HrGCo
	R1K7+sBh3X3geekQCwdrvrFtAxCF7ePfi8Akc34SbAxpKzZLtWhxNjiWoJ5hOGYuMd6DBqh6iGS
	+dHyw3I+t1bHLuHhTm1foPVD2AkjZXNm0wbkymZJecxEep9UD3r11yWX8mZDu1w==
X-Gm-Gg: AYBFou2cIAbEtTIH17FNRRS1CL85D5mEK+/WYk/jg9SDVD0wDD8T2Qv5ypYd4BkaHiP
	g5I8EsevBhT7dQ80BB0C581wb7pyPHsOvM3VG8c92Y0vxOHIoDolTqQrorGKLLnWgWqX9G3yNbK
	N3hWV7aVf/z7PdAfuK0j0uH9WlNPFGIIyUZmgVZm4d8pDMICqtv2jUCx7jgUsN5TVKE0IuhZMWr
	difcjETPMVPyjqKyEYWtfO0eQAqAaSwXxc99yGOXKaHCqUwtZLK3jZqvKGlJhfwZxjh/NSPH7XR
	6sFxosFXaRtkqSIAKLhnEh7w9igVaTW2onrMztCwhSAhacNmfbUOLnCSs9QkRxgqYOx/80b+bK8
	Ch3Y413zc10v7YUdUnjUpMgiUxIYNran7aHd7seRN0/gq
X-Received: by 2002:a05:620a:1721:b0:93e:9809:dc00 with SMTP id af79cd13be357-93e9b8f03demr282564985a.83.1791362712103;
        Wed, 07 Oct 2026 01:45:12 -0700 (PDT)
X-Received: by 2002:a05:620a:1721:b0:93e:9809:dc00 with SMTP id af79cd13be357-93e9b8f03demr282562285a.83.1791362711696;
        Wed, 07 Oct 2026 01:45:11 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c7256434bsm3895171f8f.15.2026.10.07.01.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 01:45:11 -0700 (PDT)
Message-ID: <5ce48dc0-b8ac-4d6b-9918-8d4af08ce719@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 10:45:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v16 5/6] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Francesco Valla <francesco@valla.it>
References: <20261007-pscrr-framework-v16-0-3642c277bebb@oss.qualcomm.com>
 <20261007-pscrr-framework-v16-5-3642c277bebb@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261007-pscrr-framework-v16-5-3642c277bebb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfX3kLhSQZ0BZ/X
 F9MBaR5c+NjeFc5I7NjJclizbapnO5utbE0I6WzlNWxqfqj4j1rhN/5QEnLmDxIXOVEDR/Uz7AM
 VwksSXgUIh6ErmOF/3dhz44Plqo7Osg=
X-Proofpoint-ORIG-GUID: ts-nMKcvmoiBwHjV67EO7xUgMLp0lkIn
X-Proofpoint-GUID: ts-nMKcvmoiBwHjV67EO7xUgMLp0lkIn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfX1C7tY1/aVrm9
 tsbNzf4mbaBkDI/V+Weof2FYkZqxUouXojlaAnucwHcFEqO1xxEZdhSva8mceo7R1A8Ldjyxl3H
 ++KKTbmXnC8g2LRMtUbtMVxKASNBJPVrDwN1C4xWKEAers+YORqsbsStWO2KCRpfqE4AVmq7J0F
 N28IbInxuSBZbgLh1cPZ1GPJ2tx0XGer40vMbR0UStlEunvnfvOPxe2+RTQCzwZyy0hrH8bJmBh
 Kk12l4uNG/9XkoBFyNPOMYHTtmRFWmeNkrE7H+IJkZ4g1PUswxa8bYcnd3SQ1DxQ7QbpCfIkbxF
 mVmsF4RGW1m4EFyrn2yq6SEQ9Rm4wmW4p0zetT3vFpRFkyp/QcR5yHgj76UjRGfEvrRH8y7FyQ/
 /n+Iph3w+gQStgH7o/JBzhF0rxmmn7F3eFLy6UfPn2m2vkFn/sjxgITLHdGG3EqozOHcS/Gggbv
 2p2Gvn/+L09p5oq4NZw==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac60699 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ESGm2P_6vxgoHrSgdVYA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070034

On 10/7/26 09:06, Faruque Ansari wrote:
> Introduce the Power State Change Reasons Recording (PSCRR) framework: a
> generic mechanism to record why the last power state change (shutdown or
> reboot) happened - under-voltage, thermal, watchdog, software-triggered,
> etc. - so a postmortem reason survives a reboot or an abrupt power loss.
> 
> PSCRR is built around providers. A provider is either a hardware reason
> source (a PMIC, SoC reset controller or watchdog exposing a reset cause)
> or a recorder that persists the reason across a power cycle (an NVMEM or
> RTC scratch cell). Each provider gets a directory under
> /sys/kernel/pscrr/providerN/ exposing its name, backing device, the set
> of observed reasons (as tokens), its capabilities, the reasons it
> supports and - for recorders - a record policy. The reason set is
> deliberately not collapsed to a single winning cause, since resets are
> often multi-causal.
> 
> Reasons are the numeric enum psc_reason values from reboot.h, shared with
> the POWER_ON_REASON_* vocabulary, so they store compactly in small
> battery-backed cells. The current reason (get/set_psc_reason(), set by
> the thermal/regulator/hw_protection paths) is written to every recorder
> from the reboot notifier.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reported-by: Francesco Valla <francesco@valla.it>
> Closes: https://lore.kernel.org/all/178749889134.204450.5740187753642158305.b4-review@b4/
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> 
Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
