Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757C30E0DC
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046446; cv=none; b=YzpXJPPz1Zsyq7eQUlhllobXzYmUg/9Ldl6kyPx22Ij93CGlIKQvdTgaBXY12d6x8FXm7dZLfDlh+OSfx6nw8bopmBPUF1BOHsJNkvfosEVTFLIpqT5rdBoI6ldzB80lbA2r6v89WAIPLjOc562eXuFfOKeetERO1d4DDlGHUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046446; c=relaxed/simple;
	bh=tfQ80EpOUgxiBDCFkb17UhX5SlzGTcK/AArT6gv7o+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujMf6vcpQuvIIpkKRAWTTWeu7T743Ap1azWHtlhVABiqtAVCXOnwWpnBQQqj9sAmQCwrwk8Wxd+yD8klR3s3tqsatw+kpBBiTUvUZYoVXP/+TdE3OGtsLdHqN1x6ClizRohZi/arl0JmuD4IRno46htv63S+mULQH/iD/Wljfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VxERZepF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AEfT3xyr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VxERZepF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AEfT3xyr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OAU90s1959469
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 16:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rtXoSblsbaF
	WN/8XxSRRAiVAodNjpE2GqTEHjcsMM4Q=; b=VxERZepFz6f2PiZqXq1jGRVtf+l
	sCZsfWYPORpeyoXtA8eMtCoWQKL+ag4m8WInuCRl5wdDzlosnMnSudSrv2NeIRL/
	32kr+KyUmk8QelueH0qa4Z5MSdPJgrrIe/5i7TfgUarA5e3GziiOKWHHZTwO8a/F
	e+nBpfpCEb7caTv77JevpWsN2FssCy+NIh8YNVDL/Ho/5fYAuo9TE8Wd8tcPJVnU
	2pdnQIHBWL0Vh/brh7lEVuV9INDeR47rCvi4c/TyNxmvVRz7zJ49YXmNDTxlvsAI
	tL3GdxKOR0JZhDshkYd6+XiOAJHxKxAoFTy1w2UixUxk7+fkFDJFV2lQ/EQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr2nrjj0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 16:00:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50da529ff48so190060661cf.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777046442; x=1777651242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtXoSblsbaFWN/8XxSRRAiVAodNjpE2GqTEHjcsMM4Q=;
        b=AEfT3xyr9b7mw7iiNWW/AMFxRobmRAEJiVwFJDaapNxDhRt2Oji6Ep5PwaZG02bwpB
         69fzqHl6L37flgIncXc5IELtqmAQFmwMOBNzpcMbh8+RgXMnJg8CSDViKyIYE8G0wUzD
         MbElaXvwn5klUtbTYrYcIMlkcVuruTR+xq/vrVuh8P0RghVvhYLqS6x16BhiGk3Y951e
         jI9zG3MkR2n07VKurC6NmWNkjoKMiWVU7mBTS0Psp+J2w8R9Nb50Tc4zH9/OtkOw6gfQ
         dRDd5ChNoglGyDkaFJhGslTBIdudx5lFsOHwKTCYB8IKKmKDWzzwXVPGbKGbzIR1Vora
         vWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046442; x=1777651242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rtXoSblsbaFWN/8XxSRRAiVAodNjpE2GqTEHjcsMM4Q=;
        b=Rea3P9c/2a9ldb3UtFEOPSyXKJTx7tujKsdiZRSSvdqE7J8+WTNwkEfd/jZzsjmisc
         XHWfBmz0xTeSaYQ/XTepaNUGSNycEFpfIsI3ySCe92L+QN3scXf8KwjQ5p2ezicxWRLi
         I6xRvfte19Q/A3pQfliguk/9fRLKMxGElujKxm8lbxDYSTjSR0W3L9i41wdtscoRuclS
         4tNHOGgXXIz/+VZX89Y4qYPjAUzUFPVn5lP9HgJPrHynI9YijYedo4vvlNeDBHXUw5+C
         RMLxk/bS4alpMmLWXHVes/ETQ727qG+eu9N3NFrSzIr9vFXVVKEUowt7LPryZa8xoMcJ
         z0fg==
X-Forwarded-Encrypted: i=1; AFNElJ/KKlB5EP3C1auvtVqE3+6Um46n5qWGv+ArMQbHxyPqal8pKvAL0NSDEn8Pc8FzE/FzGBuRgbGCog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+8LdO9fVaj60a0lw9H/gGsTnErXQqGjv9N2wbofmG0QNU8MM
	TKuBHnXAfgyWV6bXlZ0x+61UbGP3Lgw27peaVQ6zqFnnzXARuVPEG7yXzL5mgjv+FCIWy1DiPWR
	LdX9VZU6haqevYuQFFdjhETwJzK3+9z2i7n/jamx3fDP0+J7D5B1Tkw4ErZJzr+xYVsgKU40c
X-Gm-Gg: AeBDievzUbYcB62+xr3PG9cWgnq/2grfvGke0G0Ec26h9OIUknKlTOzBZrBt6H1AAPh
	+hgmXlBn6MAounFw4Y7RVeO00oEmR+LPYck4bBf0mL4t02dduK/QJ8NLdaobKlzGneX873OlE/s
	6Bf4XITHsdLmEYfCU398G07ibyA9bZ338xiDigzORwUUdCqAVTEYCKC0A9BMKgTL/2GPS/p6X1b
	SlvkauS7lgLWPqNspQdsDP88Qzu7O20+xK14QyJZRHM3m8AhH/LqNlSP79czQ0ObkhAUnlsB5TC
	SwbN5jpXQs4AjLzdO5HvmBiNSXBjjGhouz98ZUrEPXcWwCkQsPpPwUan7tdAfPlsSpJhBNqBiWP
	4JhN3VY4D/otxKmt3BlU2CG5XMYL33Blo1L0WylpN7WETlE7Kzapg/jFhLlt1
X-Received: by 2002:ac8:6f0a:0:b0:50f:be4f:465e with SMTP id d75a77b69052e-50fbe4f4916mr184555081cf.53.1777046442008;
        Fri, 24 Apr 2026 09:00:42 -0700 (PDT)
X-Received: by 2002:ac8:6f0a:0:b0:50f:be4f:465e with SMTP id d75a77b69052e-50fbe4f4916mr184554081cf.53.1777046441356;
        Fri, 24 Apr 2026 09:00:41 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1ab3:98b0:9e96:47bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm25405491f8f.21.2026.04.24.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 09:00:40 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 2/2] thermal/drivers/tegra/soctherma: Switch to devm cooling device registration
Date: Fri, 24 Apr 2026 18:00:19 +0200
Message-ID: <20260424160019.41710-2-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424160019.41710-1-daniel.lezcano@oss.qualcomm.com>
References: <20260424160019.41710-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE1NCBTYWx0ZWRfX3wZjz68ArPdJ
 pK0RyorvFO3sRWd+s+OQnj4ty6+9aU1Kcw0iDOOFKU8+z9vUiemZoE+tIDjn0e+8Kx62h6fwzGi
 AtO003PGIAFaBpZKmiXOG+ixQVBnXnzwufeCNteXIOXqGO6ROzUa312vEDc23/lBMdIW4nsed9u
 aKMyfhwL3NWEswrfWjJSEgP8pUmZvlGQ2YLuICYDCYmxySDxgWR3LpQKQd3fK1CLXdUHVcW3jgA
 hrpTg327hXAGy0q5GcTXmcAkc3TOpslaLDHNk18u6GMuU8f1yiZUNVL87gmeaMMKmb+hrNdkkJm
 sCjpXHawayvdlhW2351283KxxBCEAzbMEqVVkCtX+3mV8iWLFF9DhclpzICLv5R1vjciJlMiNN2
 IulCe+ZV6kCiHO4h80K2EM4MJJCo5U95aBVHl+XneBejK1bP3yehuiebzkE+KwXUuJjLdBw8f7I
 OMA/zJy+V5Yprh2Xs+A==
X-Authority-Analysis: v=2.4 cv=UqpT8ewB c=1 sm=1 tr=0 ts=69eb93ac cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=SD-xzoykHkTshkma-kIA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 7bSeUlufvyzDmZ9TpkjUHqg1uAsi6rGD
X-Proofpoint-GUID: 7bSeUlufvyzDmZ9TpkjUHqg1uAsi6rGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240154

Use devm_thermal_of_cooling_device_register() to simplify resource
management and avoid manual cleanup in error paths.

As a side effect this change has the benefit of solving an existing
issue. Before, the function tegra_soctherm_remove() only called
debugfs_remove_recursive() and never called thermal_cooling_device_unregister()
for any of the cooling devices registered here.

After the driver removal, the thermal framework's cdev list would
still hold references to thermal_cooling_device objects whose devdata
pointer (ts) pointed to memory already freed by the platform device's
devm cleanup.

With this change, the cooling device is unregistered when the driver
is removed, thus fixing the issue above.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/thermal/tegra/soctherm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 40c3715e84c5..6a56638c98f1 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1707,9 +1707,9 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 			stc->init = true;
 		} else {
 
-			tcd = thermal_of_cooling_device_register(np_stcc,
-							 (char *)name, ts,
-							 &throt_cooling_ops);
+			tcd = devm_thermal_of_cooling_device_register(dev, np_stcc,
+								      (char *)name, ts,
+								      &throt_cooling_ops);
 			if (IS_ERR_OR_NULL(tcd)) {
 				dev_err(dev,
 					"throttle-cfg: %s: failed to register cooling device\n",
-- 
2.43.0

