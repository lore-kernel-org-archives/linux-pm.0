Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCBC3EB0E3
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495775; cv=none; b=P8OkO9YI8N5M2gfH6CJu5J11Ou8mc4dz/s4jdeVirA9ljP7YeptNs74yiCdStjqSfdJbD+X1Jf6N3gxf1HDpOXH0D+1VBHvfHUtgHK+zQZ6AKBuoLQVDX8P/zg56d1h8vfxszSytCknwEl6EXtuhTtWezaI+X1MgD22bJOaiafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495775; c=relaxed/simple;
	bh=kOOmbLFrG8QsZwkEOkrXY4yYRRBcRDCtei1KlyOaFog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSqKTMge+V81K4oxLCGaPXmjQZSE9kJYhhza9N0amr5Du6MAaQI2dI4P9+cgcx7wusb5DbtMC9CV1sbi/f/co9oqujZaD3CUP/cqAhHZnfHJs+IoMCPL9JCm2DYvYB3GjXpV1Hh6L/KCBfZpj5EdPBqKf3eU450VuhLbK+ynnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HwiQ9wyI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hHMKfKQv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HwiQ9wyI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hHMKfKQv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAC26A3560088
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GLY9j9Bk41aAiT69kbw7H9yfLznQqyIDZa0bLbpKQhs=; b=HwiQ9wyI4kUtSogO
	w0Ia0DA0/+zGXersKzKidABSr6xm9ehcho3hsRW6Lr8wSYDmlGsB/C+LYkNE4I90
	8Z8TNpGnhtf17noY9yQdM9VIvETkgkZc3g6RInUt/vlMvWbLwtbuJM9lgE45Y9Tl
	C1jLNB+jdXpyrwxZI7s0EVu5mquTghI9OUUDbxQkYn/V/eQBxkBrWq7FZQ2ieaYJ
	kClnM1TuBbmDJ5PBI5HcoTEIAxiL4LQTEzg3Ubpu/E60TGM4bEV5vN6wn1i77YhK
	YzK8caDKz/lVmDGPHbjCQkRKzQK6yNVpzgAsHWxtvYfAK57GaUEjXmTDH0tFjo+7
	/B/Otg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frse4087g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:02:50 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a442461e63so63351b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 04:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785495770; x=1786100570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GLY9j9Bk41aAiT69kbw7H9yfLznQqyIDZa0bLbpKQhs=;
        b=hHMKfKQvOmfHG+MUIgfDwyadSRt4lBkLkYToViTCcIzuFsVqK1nJUHz3GircyY5tGU
         6WkJDB9hMPwWJL1PvH/LMYgiepO0zj9wt65cZxS0jr5iDyO2lgT57cM7AD20pog5Uio0
         AZWE8BJRR9W/7cVEY49iQhZaj5Ti7IzfWhdsp8a6UZwj9EVgUY+D8TznaPNKrW1NUjTE
         sZqJZsYtEto3IEM/UOINd1Wjb8TkVblCq61q54XLb7b2dpTGFeXOUrbo/HSH91oNyHtG
         tXbhLHwx3f+koAgnaayB/dn6gv9iZ01bZstzu+r3nxX1x2Uq3sGU5gg813mLFNd2pP4Q
         hahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785495770; x=1786100570;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLY9j9Bk41aAiT69kbw7H9yfLznQqyIDZa0bLbpKQhs=;
        b=dGtq1hbq5Z9s6yOJeXry+scaKeglY+BaUOXw+VeE4Rwmz1enwtdnonqWayS5MQaQst
         huBwpAuvmrGyq9tZyw1ajy3gFAKRg57JZtWukKGDk02V7MIYYa37fWCOZu80eKUOv6rh
         LDi2NfPvVrnHpn/ni9ogzZ7AP7s6w5EuO3XZoAr2Y/N0wOXZEVHM+0qNY11cHQMdN3Ph
         ZEXaoDXNOt9yqJqFX4uKqjw4rCJD1ZV9OBSToKBPBIedxlv15oD1PQaC8VEw1ASm7byb
         t+F/PVctqkREdMAZTk242OUIK44tkp8Sd/NJgL1XiGI42C8uoF9qQRJ7FMWrK9qNCkmy
         IrNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzIGiZ7twmKTRwMnjHAHsUYyBgC54kbzKLjYbJl0Am0NfJ0T5wRoPRsQHY8bD+dWqeBqs9u78gHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAimniA/Wnko1UF3XZfCgXhcAFO1QteEAA8WIKXfFSLXbXhVai
	rDwmvFEPbON933TF3Pczitg3zogSeYEfKk/tR14iwweP7cdG0lKk/jy1L841bCvi/PdxAn/DaB6
	D0advjSPP94szihP42skaS+AahBIHhIHGG/3XDnnkx3BSEs5RGSYDcg3b2V6xUzRhuX/AfQ==
X-Gm-Gg: AR+sD11wmXP6bepHZah6A3hk9aZ+70StPR1KoICDvLXMgRFopdinCNpvHumZXFh6qVA
	RaFilYKKBGwmtX/uLjZ/qEhkinJnh4ZS+SLsHQdElTFbJe4d6emdbxhufMfEYNAly2+sQeuLZyd
	a+XiG8IncwdhOjiEgwlaptjEobFzQFlp2zFqYn0LPG4g6t7prufBcXtnmD/486iGKtcjTkzDOrv
	MimnMqq/vY90lPeRWiZ/EwfhQ9Mi6Vh/wo/G+XSLdaILIh6JdXWm8udIzOBjAMldX1oI+H5AhH4
	5CCPYWv+D6SLhbY1XdXIzjUxhhCqIXDsBh2pM+cmIRCM6k/9zsmtbomM+HHTUdYU3tnMwNmqRL0
	tYJ10o3PdBsrYI0lOFsmCHRZD
X-Received: by 2002:a05:6808:15a3:b0:496:d5:7b22 with SMTP id 5614622812f47-4ae4c44f120mr1014194b6e.1.1785495770110;
        Fri, 31 Jul 2026 04:02:50 -0700 (PDT)
X-Received: by 2002:a05:6808:15a3:b0:496:d5:7b22 with SMTP id 5614622812f47-4ae4c44f120mr1014178b6e.1.1785495769744;
        Fri, 31 Jul 2026 04:02:49 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b0fasm113417766b.5.2026.07.31.04.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 04:02:48 -0700 (PDT)
Message-ID: <96246a96-31ad-48d8-b32e-2c4df5830d96@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 13:02:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix use-after-free of
 battmgr on remove
To: Fan Wu <fanwu01@zju.edu.cn>, linux-pm@vger.kernel.org
Cc: sre@kernel.org, andersson@kernel.org, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260731022006.317192-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260731022006.317192-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HslG3UTS c=1 sm=1 tr=0 ts=6a6c80da cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aDI3_xmd8nExmCF51jIA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: DOfajy70-9Wj5HRUdgLGVS5ksL1ILjxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA4MyBTYWx0ZWRfX59B8SkcoLvbk
 xZXLVXK8FkHIPopBRVaoZjALkdke3/mvZYdbEyUjEI3DX/G+8dHLU/RjzVcMcdTg/9feYakzo+M
 O/E/rsug8UpAc9kvOlt+qjAMnscnJZdG2QIS4QDvCwKgKwFvb/6ii90e2ktCONrpnYmf5QVk4if
 wQ/PFulA0NkW3FCqVrIZFigBnvx9g+pafaMg67eDwAlmiGYo9qX3+WzSAscmGJs+is0rCAYyM+d
 0yldvvUUXWm9zKdmE4w5fkGyRFjFAhivZfqDcUKRSLRFtUx23CE2/baQpuPhVD45e+X65a7V3ce
 0ALIwrKonA3V0K4Gg9Ft6YfW+Db6R19XLKEPugxsQzPz5SfIAeAwQ7ipbvobaYlNqH4e0TNTEla
 qmAQ0oAOY6F9WkWj3a5cW3pc/VsdqA8/JGBGkNoNj+jDmfID+iI3UhWF6Bc20HCRgcPabg+kXyq
 ugkGXgVxgPZWP1sJQZA==
X-Proofpoint-GUID: DOfajy70-9Wj5HRUdgLGVS5ksL1ILjxS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA4MyBTYWx0ZWRfX8Za/ew55ZGu/
 GkkrrbxC35H6wM1wtRp+QtCUbFs5Zb4HZVw/wbHLZU1NZfPMpfiMuaBzSbfM/kl/VaMyGjW25gG
 qewKE2a3C2sbW4y3451IoBdfP6Ekf6Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310083

On 7/31/26 4:20 AM, Fan Wu wrote:
> qcom_battmgr_pdr_notify() queues enable_work when the PMIC GLINK service
> comes up. The worker recovers battmgr through container_of() and issues a
> firmware request.
> 
> The driver has no remove callback, so a pending or running enable_work can
> access battmgr after devres frees it. The PMIC GLINK client stays on the
> client list until its devres release action, so a PDR notification can
> also queue the work while remove is running.
> 
> Add a remove callback that disables and drains enable_work before devres
> release. Unlike cancel_work_sync(), disable_work_sync() also blocks a later
> PDR notification from queueing the work. Store battmgr with
> auxiliary_set_drvdata() in probe so remove can retrieve it.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
> Cc: stable@vger.kernel.org # v6.10+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
