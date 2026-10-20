Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506397;
	b=ydNtgiXkvch9TRREd8WiG3JgP0AsNJ1cwxe9ISLKOZ8ircDwWgjtZWxrc1LNAI0TgtSJ
	 qPmQe90VPuElqYn6D5+oMRM2ppeTaXA0CBLnc4FvTwuLgujBuYuH3u9qczzRr/944CNhU
	 sOr2shVsK/1wQcVkibrhjPDweWkp22B87ANSE9I2oWRgpqjCYRaskVe5a+/KrPbkshI4H
	 5m9CbMNWxwENsRiPLodJxyKmg22FiO6MTRlGoKDKpw4fhnt2hE7VYJ5qUdAJcbf+LQWVq
	 P/fSwZB+CHLNRmascxHE08hruAlDwyQdOAhHa9p/IvEvAw8lAZ5bHF0e0UAB2Tja1Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506397;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JHq2L56t//wbyoO+11weOskejxecAUIHbZU7bhxKdLc=;
	b=l6dyyCRIgjo9jQDcuMvsM8nskjzj8IOK9Hia4dUZrflSQ5tEALMSwUIWRq1YTu+F1Nux
	 aTqGgOS0wiO3oc5f+hcw9Wnzrd6qA3To/Rb5NAfAs4QboTvq1bRW8O8hZCCq1GnWAfcOz
	 +zHcC7d9q5D/882bcjQW2fqrxDVfGu8C7+xifryli7YJTR0VT23dVbCIuaxbmE6asrx4u
	 Sq7TWDDRQ2eqeb7Lm6xTt14RIHnpJBud5s+XeIkK3eY1tsBb4/ZwUOPewXKaPHR8qjC4p
	 25Pjbel776typgfxR7d8/YSOyjM9WgwRocfEoJTQE36icUk8E22YsWYuzE+NtJAN93Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N9weUZMr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CCbTEtvi;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F1606A31B
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1F1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N9weUZMr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CCbTEtvi
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KD9txm2809577
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JHq2L56t//wbyoO+11weOs
	kejxecAUIHbZU7bhxKdLc=; b=N9weUZMrBc3yK8X3ExRyuRwmah+yiMPm7GU4s4
	r+cK8x84bovh/jFQYKlkP9tzmuQ7r/SIYqplKE38v5Ai5MQ/a0T+Fc8VkMUeusCX
	2QdbMNrn4fyWdaf3qVpqKCAdy4SHvl1Yg4X8b4eWF4spL8AXOPfljHgGrDjm10BE
	wFtNjiiIpvU8XL/HepXHsVjCnWpzAyGDGw6Oj4ctkdVybzRDP5WYHqQ2a7cngSsp
	C+TFgZ4/2C1EH8pdnEiQyZA/g3tUvPh41/s2jG4K1UzYkXjMqRawOGZPoSfCt+S6
	kQMU2e6IhEyxYX3JshE/FklRQ733jhqCddA3tH4i2XDSJhog==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p2w98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:26:36 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cb9d27ddcfso867767137.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792506395; x=1793111195; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JHq2L56t//wbyoO+11weOskejxecAUIHbZU7bhxKdLc=;
        b=CCbTEtviezla96tC8rxfWVyQr8Whtqqn9vWklrQgWXfpezHAM8hkYcFhsto1BuTel6
         vOutBE8mmChMabzK4PWzLvqDl223nb7PWsQvcRvcyzvQLxmDzAsWpuAuV0zgdNLox29P
         nHmBiVRPOd7K852fDJkTJ/hOwys5Xs4BaP8b54NvY4KhysTCnNNTYuSI/ljp3tx2dYc8
         16Hhh3jNSCfkbeVlVWNtR3TX25e/zwIElg1XCPBDXR4ccncCTOIYcoEsvFIJDaBDdAF3
         543vsVPsbPJdV8Q4fJIRgjwEoTG9XcfLHZoDCLigpIeOayNt2l3AMRhe8Mr9iTxC4kKi
         5p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792506395; x=1793111195;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JHq2L56t//wbyoO+11weOskejxecAUIHbZU7bhxKdLc=;
        b=pOv4GMaP33oKdOS+jc1/Uz8oN6Nw62TNdeaRNIyNGizA3wFAGSrBqd1anz5DqJJ6XO
         JZmZlO3of5rT1ri4S6n42EBpxg+EFwopoGsR4jtQIzQPPL7zvdnc8b34BqHdznJJsQmX
         +TrnY6KR4/SW0MryB1/zHcO16lfBbbrIfVPM2TvnxPRkcZ7yCz/cD4jruLENeorbLgMk
         mSl0MIue/VFxu+xPTt5k6qzHu/bUR7isIIMBIhieTivOKlfnAbYyWWX45gkeSr7gfENf
         wuHw73vxc4aTAwht6IqeTYanMuLbvThxGoFMTaZJ/eg3HoXr0yle8ZaeZiTglqjKKHG5
         L41g==
X-Gm-Message-State: AFq9FYIhUh76oHGwqKcBtM7SwUe6/u5sfIK2EVHMF3AcfLCi6iozHODB
	Rcv/T4tq0a2VIX0uYW/AZUBpfmA4NQWG5ISsWBa6Xkok24X60fl3a8QAn6vF+FXmfCmMHaUwK0w
	v0/PDAymf8LBSj1YfBhKSly5Io6r7xEHtkyVQcw+9/YUAQUwBU3RDJzN0gvg/Qg1LTYob9A==
X-Gm-Gg: AYBFou09X3lOAmdCF3M7g0g7qd3twIsUluO0WNN7zhHIkwqkq0e+Q6vsf1kVrzkUpOZ
	+idfkE1BnXaFf28WkIC36A8mzfaL2iF7WtcQic394XG0UHbCkaKMLNVOI/A8Y4TH0Z5RlNBkCoY
	loAF+TgT29gD/Q/C9CanslJQFsqbcTTnT3anytoQ/OnTVONhIgAw4wFVi7DpwPa1DpmpLD6RNUR
	NvW/V2KzUbpjw3FZ0V+CfsFMGgmHlribM29q5UzNuZxyI35dOtL2c2N6Hp24mWcoocy6noGYb6B
	k27W9KPknhFO9br1g0yPr6486aOfYl+7xm2O++FIyBVeSwBeW6cS1V5xnBKF0J0Wead94PeX706
	wA8TGnoSCoWy1rT4fLeGvztOui0EiwwTxkMUWQbnTXgWjjvprswfPm8CXVXfgZUgswqMOhsV0pR
	0k4kkt9tXCt7ovsnUjLTWFZh//dK684jXJGYWiY9/MXikQluZOrFE=
X-Received: by 2002:a05:6102:e06:b0:7c3:9b0c:a75 with SMTP id ada2fe7eead31-7cc3691d1femr2646884137.12.1792506395077;
        Tue, 20 Oct 2026 07:26:35 -0700 (PDT)
X-Received: by 2002:a05:6102:e06:b0:7c3:9b0c:a75 with SMTP id ada2fe7eead31-7cc3691d1femr2646872137.12.1792506394517;
        Tue, 20 Oct 2026 07:26:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d0fb:daf1:3106:3697])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cb8d5csm80483915e9.6.2026.10.20.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:26:31 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 16:26:30 +0200
Subject: [PATCH] cpuidle: psci: Do not log probe deferral as an error
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cpuidle-defer-v1-1-c86e0d450b4f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABV612oC/x3MQQqAIBBG4avErBN0koiuEi1Kf2sgLJQiiO6et
 PwW7z2UkQSZ+uqhhEuy7LHA1BW5dYoLlPhiYs2t0ayVO07xG5RHQFIWrensjMDcUGmOhCD3/xv
 G9/0Ab4IH7V8AAAA=
X-Change-ID: 20261020-cpuidle-defer-4e6184bef223
To: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: a2W48EjGTMSaIOgIdE2TYdaYzUI9Q_oZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NyBTYWx0ZWRfXyT3IZrrsUfdU
 2Tj4S7C+biyx8jxweyLv++LFV1ZX2FO81TfKeZo3dL0gWEev8zm0n+x4JwL1/2EaPlcubSXy7AB
 oI47p0N4rbFewidW3lQgbhSHBryGE/c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NyBTYWx0ZWRfXxX7RuGVYv+hi
 oxhF/wvmTdtO6WcTV7KVDGp/bYbTReq+ygnAF90BTLqkikKSIr7EC990F6PR7m/sg4Z9Rl4NNG5
 +INFMIYweVDwtv7dj/j/La1VtVC70LaWXFEOspHXW4SFb2AtM9Le51Dp0xWGSuyo+OxncI+SkvP
 MnGM5NcsxbxVidhJV1yvJm6vHhFMJYl4FtPG6KY1HUX1YTKHvffmyGy1lJXvpfpVUUVK46eDikZ
 NqAQ4FoCgTDjgYm9gDNxLHKdnvhlm/jC5gp9Ln2oxuXMS2RNOXRTBN8gHL78/A+l9MRRx4Wkiu3
 ggBGKqG6wsq2C4bMpUGJcPlpVb7wTJN1ra52tpiPeePmuEazxMHTzTgzFzYzNkUjZlJGucg46B/
 /QBo1mbePW0i9Unqr13c84X90bK0V8IfbkjjQFTc6htfgigfkV4VYMsny6zGeWZZNqXAUuYttvX
 g9cWt8GshEo+CP1pINA==
X-Proofpoint-GUID: a2W48EjGTMSaIOgIdE2TYdaYzUI9Q_oZ
X-Authority-Analysis: v=2.4 cv=crUOAF4i c=1 sm=1 tr=0 ts=6ad77a1c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=kuKeJkFhgiUoOUCgA38A:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200057

psci_cpuidle_domain_probe() reports every failure with pr_err(),
including -EPROBE_DEFER. dt_idle_pd_init_topology() returns that
whenever a parent domain is not registered yet, which is a normal and
recoverable condition, so an otherwise successful boot still logs an
error:

  CPUidle PSCI: failed to create CPU PM domains ret=-517

Report the failure with dev_err_probe() instead, which downgrade
-EPROBE_DEFER to a debug message while still logging genuine errors.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b9e4ad7d43a3310a76ce62018dff0af1488e33d2..aa73a2fa14b3af4d1e3edd607e058ba96132bad7 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -173,8 +173,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	dt_idle_pd_remove_topology(np);
 	psci_pd_remove();
 exit:
-	pr_err("failed to create CPU PM domains ret=%d\n", ret);
-	return ret;
+	return dev_err_probe(&pdev->dev, ret, "failed to create CPU PM domains\n");
 }
 
 static struct platform_driver psci_cpuidle_domain_driver = {

---
base-commit: f49a343b305c0b6c19a3b50c0bbf10bcd0e2e8fd
change-id: 20261020-cpuidle-defer-4e6184bef223

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

