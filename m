Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BC2EFDA4
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263519; cv=none; b=LabyIEy7x1IZvPMGort6WYiNVQtpiaOYPvn89usu47you1m3C9r/ERpgpMiityYX2irwU6yJmryRBYnTsgnPzdfonN6KB2Tfjrkw9PwbfuoteXrEIPyO+9Z7T/7zQ/c9QJq8KlWWEt4hXcMSPUALOOo8u2hqk06CF3qnLG4YGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263519; c=relaxed/simple;
	bh=JTOLL9d3J2M7CQtlACYHdeYR92eURwShlicAst1N8vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJkujCINKub0bQrimhwbPzuL+CF0kFO3968zSy0KSI/tboe/U4r/htrIU/6XxeTucoUm5C9I8xrC3fPJKEQmWhbZ1F+9Q1hZrQssDeneYGsYeHPhgaoNs8VKmTSpa9lhuMiaFFB+eO5BNPFjVmnt3TT6N8yG7ENQes3szUKaW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IrRwnxu5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OfrqfE5C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IrRwnxu5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OfrqfE5C"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648HUANc2515654
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 18:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xvIgIYJ41skyqFgKEJnH2VxWPToCrLPXMzc
	FlpqrmFY=; b=IrRwnxu5rTopBRABvwpXxLWLx9iF+ipRq+3tChPZIXY3pzx/SVk
	jxTza2yutKvcCNKPAMTb/uQGm2LJ1yqwSPCzMicdYYdHcU8v+yKUyKKeWFCTEpmF
	A7cbmMN1GocoF9UOkbVzeBbcuF778AQ+T1EWSLBlVleUj11D0kNjw/unTnfE4yvO
	k/Gr85Mw+ru7FWaAjvKDbYivu1mXaybKpodB4Rn/Jde40/Yzl9IioAPuXH2wzkxE
	tyVWxoR8Z/udN3rU0ZZ2yvD1w8xJjhMtcymf5ku9ng6vmpScqjKYoLYhwUraADg7
	k9VPuaqAunLO0wtbbXasibD8JWz5MyAEVXg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1m9nr4d3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 18:05:17 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-612ef4e6c54so3961819137.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778263516; x=1778868316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvIgIYJ41skyqFgKEJnH2VxWPToCrLPXMzcFlpqrmFY=;
        b=OfrqfE5CLYIh2OeSvmDM4p8ch/5p5OrD/iPcnIh7o2ezScOLvbjwQkCqTr0ymRrQpy
         XpNT1stkEg8T0bb3D/uiiClTB0oWLhW7R+VDZe/kiWtjbM63Vsk+HWPi8fs2CIT7oR0G
         b2qJIgQKEIicQ1BledN+6tkOV8jZU/CWhH8C9bf5M6Zgqt12qq8FYqk0vDZUYU1pDwO0
         +MbjUe0ftzMOivg1GDPfHO07b7cYYHIGqPlWy9sglgDoE6toXe5LMyN93bJ9BD9EILst
         zd+qFuErgAT3wb/d2YJSw8ODfOY7nm2/TrtCX66krEMnFNcqa22kBM68+PpcNkNbFTFX
         j9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778263516; x=1778868316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvIgIYJ41skyqFgKEJnH2VxWPToCrLPXMzcFlpqrmFY=;
        b=pEkRdtcoXBLA10aPKyqDdWyjI+5Qh9dEBe4c8Kgrhu5xZxBdR91q+T0c6FnQnIeWYj
         T5psAeU1x0YD5EoZnmWa72vkAG4jGS7AhC5lse0h3W8SPa+wTzUIxPdn8CRfNZp8InZc
         rkydv9DjcLTdE82Dc4FZd2L6y8gVquNeEJU8Uea/ekRBZLaB9w59Fh1QAaye5d5kXdHx
         DHnrENB8cCyMYuJ3qALzhqmTEvKjeLT9DcuGtQGWP5FCX3Mssf2FguJVfh6TYgYjCHBQ
         lSB7ykQbYCICTCf0FmuJOZTbR4EONFgzlRUJ7tjE6oxaj01ltohpx/2al7coaa8C1JHy
         C6iA==
X-Forwarded-Encrypted: i=1; AFNElJ9do4EViFrjloWrT4vQkzB3Mzh7Ixk1Fl7fzkaxDf2aJcQLxz1bm1pc83u2ugHd0FTRHFuo2oBNbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8bYn7urBsGCAuiDwkFfX6bgQEEDE25Z7RBXQd0yazBD1C03Iu
	vzJeUTohXuG8XBHkyD/eT+rzAtM8wDdSVc9AdsKPSUw/d7GDcZu/l8V+ntIzQleziOPLVQabgds
	aKzsk15sTVBFOZcPlXrhStnlrnUEWO1Hbwh121vcIYioR0t5YzvJnoUWiBTDbPQ==
X-Gm-Gg: Acq92OEDy9GDIK7Bbb0TF3zB9jKO/rwuntvxHbUDz1bp3KqT6tIo22mCgJI/aGLKZiX
	MfGHAIOEcFlCbUVTpIBE50nk+jsphCPz3QnDIvW4fNDPJCC+G6VJmuyZdSBxFlgaUo3nlsHwTEN
	9UsyiC1/BfqQUd451esk8CZjPmcZcLqUF0w6zgIuQ2pIpfBTfPaT+U4KawtJSjazD9YlDoWOP1x
	hjwfnPMqrlGS7Gz0oz1I2unx5dKcglXsTSaTo8ToBBxahhoPG5uN6NJ5MgK9h7/Q6TRbgNmlhj9
	XX3D2zco41+bxaS5zxrfpGLPCdNiON2HmMIke49fylGgGESph+C3ZrEMcgd27jpcLo5QxLx7ETQ
	1nqK5HZ93oazO14gnCvWkQIlfHne3v9JuAdZz84dc4EZjglt/kg==
X-Received: by 2002:a05:6102:4411:b0:5eb:fc32:935c with SMTP id ada2fe7eead31-630f8e75b53mr8355511137.3.1778263516314;
        Fri, 08 May 2026 11:05:16 -0700 (PDT)
X-Received: by 2002:a05:6102:4411:b0:5eb:fc32:935c with SMTP id ada2fe7eead31-630f8e75b53mr8355458137.3.1778263515866;
        Fri, 08 May 2026 11:05:15 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:cda6:5a1c:b564:d3ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd32afasm11654825e9.5.2026.05.08.11.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:05:15 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, lukasz.luba@arm.com, rafael@kernel.org
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] thermal/core: Decouple release paths for tz and cdev
Date: Fri,  8 May 2026 20:05:07 +0200
Message-ID: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DaEnbPtW c=1 sm=1 tr=0 ts=69fe25dd cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KxbFjwlCNysaOuIQBKIA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: pTyAWahObaMjqJKa2g3lC54GFrsrkdV2
X-Proofpoint-ORIG-GUID: pTyAWahObaMjqJKa2g3lC54GFrsrkdV2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4MCBTYWx0ZWRfX6Ddq7Fvdnuc0
 hYdABh8LeJS/bTIZfOoV39cWuzH8J2US98Oh0ZIyMRsnsp0YSutUHwpJdcPS01079qzHPyEuU7T
 /xZJU81pV4J/03oSDNx5/pdWNeWXsrUKWB8qtHq1MeTn8UqPOwolIVHn0cgAl8vI3zJpi4V1mP/
 iMWEgIYAB2j0X8muEVXW1Z5p/P3w9kyE5QlB0QLZUhrs8lCNBQv0Xa+Ehu+cggr29pr3yap9MtA
 wquubbch/aV52D6DGRGWhVr4SV/P2g71MaVSoYfxxSQ2i08bJ8ZNRnNv8yhUOHbco5qGuV5O9/V
 3ydrI/FSAq0p1se1b06jV9SrOHP/W+RsoVpIYjbPzkhI6Frsuccmw0q9UzVoSuDurb79/bA5YH7
 IWZrpBfaqufswhVSRLAwu0gOxSQZbanJmf2IcBWRgYZpIoMU3lDR6eL6Drd5QDgdGaWqsioCI6b
 nTH5sCbuzsQQt40AP0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080180

This series cleans up the lifetime handling of thermal devices.

Currently, the thermal class release callback handles both thermal
zones and cooling devices by checking the device name prefix. This
approach is fragile and mixes responsibilities across different object
types.

The first two patches introduce dedicated struct device release
callbacks for thermal zones and cooling devices. This removes the need
to rely on device names and keeps the lifetime management local to
each object.

The last two patches convert the thermal class to a dynamically
allocated object and simplify the initialization logic by using the
class pointer itself as a guard instead of a separate boolean flag.

Overall, this results in a clearer separation of responsibilities and
more robust lifetime management aligned with the device model.

No functional change intended.

---

Daniel Lezcano (4):
  thermal/core: Add dedicated release callback for cooling devices
  thermal/core: Add dedicated release callback for thermal zones
  thermal/core: Allocate the thermal class dynamically
  thermal/core: Use the thermal class pointer as init guard

 drivers/thermal/thermal_core.c | 73 ++++++++++++++++------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

-- 
2.43.0

