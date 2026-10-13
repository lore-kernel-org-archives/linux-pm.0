Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB14F4753
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895760; cv=none; b=GDD+qLx3nWigvPK53n4IlAThHH9a8eZ41w9JcoJ1wwl+MqwaHHeQ1j8RriEwA7/CpgIR0Aztcb9T0my8kwpjS/rXTiXzUEX7I19pCupD8EBwjj8uB7HE5T4Pe/bG1wAh9+sU8EJdO1aXa7nD+mqpORIvTU0ZrMwfGGCdenKpN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895760; c=relaxed/simple;
	bh=gF+HUjSaBikzjJybtnT6fARnlzadENkUSlr7gWZU02s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EX0kboa3DjGcEyiuGdYwFY785qYUyNSGCxTZ5Cb+MrSHny/QyiZCu2qHtjfhHKZO6/TMoNSpW6D0ljKVdNAuJTquthfQEcDghscxL1y75IixXvBkvZKs/JRlZ0kQWixdUBOclSgM+IzzjAZqB3eO9kGUs9YLcEq7HQqkNBA9ijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UMCUYw8z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HZx6GnYK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UMCUYw8z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HZx6GnYK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DBRIjI949467
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZTOf2SvkpjhLo6ewbTR07v
	dO1sWGSsadUYwXzXxKpiQ=; b=UMCUYw8z4omrrplNqCjAqd4YgJj/O4FPWYhcx1
	S5KH/26OLrhWmWiZnGY9UIG/upxGUZkKAjdZ6dCUfMiWSL9G1WlAzz5F+yfvfhFH
	7/Q+zG4QJ+Xqs1p7ivg8KqhHgipBs7Sx/ztBU16YIDyVuUdLChxgZrMSUsetQhud
	TIM/ulTakYokj7AmLAyCsfNIv1yZHiAml99BOtltqYViQYdlFQ0l0PEopYtjFVx3
	lJA5vgAnziRU0Gw2tR6BNWG1lCr30Mf66Ace4vWAGsc7WTj8j44dT7aLpAmnOx3p
	IqyAzIxKgbe42xv92UOdahdQ6Aa3aj66nMbYPWWdiisKib8A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f629mmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 12:49:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5340b037c6cso29409141cf.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791895757; x=1792500557; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZTOf2SvkpjhLo6ewbTR07vdO1sWGSsadUYwXzXxKpiQ=;
        b=HZx6GnYK68tGfq7Dx7Mc8V1oVh+phD4hZSkeGdPN6o65c/fa5TsdVSZMxHQy0WuViX
         uFQEngvnaRVkhdYOfGqhljZ5B4T/zv3zcZTSlPcOTjsEDKsnVoE+XrAJcVpO7wRLc120
         ehc7hyMdi0DvgktKUU62dw8BVBWX2/fPKtwrOEnAB9SiqSB2pHoVTaK+0NMDZlEJjKPL
         sWFs40nqb1ywIj47ws2Ac32yoEhZ5tjpZUelTxoElC4CnWeb97e78FzbNrr4EEj0g64L
         fVJedRHz1twzLbSTTNBri66B0CyKFfAvV4Q4z5zcGGwhz1sVVzPwqUqCqR0uv40Otcng
         8SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791895757; x=1792500557;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZTOf2SvkpjhLo6ewbTR07vdO1sWGSsadUYwXzXxKpiQ=;
        b=V9JwmkSUWN2nPEtdhYKGtGLnKTf/IOlNRwXPQeerfGDt4QWJADl3NUhEW8+SbSZHYO
         KhDomn8NREjhIBw3ZvAZg9pTgukzWRhNvVW6FggQFxu2mKkMgc/zh6Tbr40izGInkkI4
         frpaDjWRWyFphZdU38NN4kGgEDP3TxF5z6TPHVv8appzAEeP+Yvgd5iqKY9MC53MFuxe
         Rm2JZp8K1Sj/sQPmmupTVkqjR6GqKcT/qM5BXQjL7IPbukuzuiYpCYYlg+woigOUKhrE
         eTx0Z46biC8raBkjbHOpPFVpfUeTiF3kglu6+jNlAH6SoLgM7AOOBJse8lfaeMFW+Xke
         sJdA==
X-Gm-Message-State: AFq9FYJ8Z4u8/y25xShyqh78f+koLVWyVLUOaDsMot3MsQSqp1kABty7
	Z7vdwRsNA7Budv3P4KV3EhqLDOgjTtt26eS3LuZaWXNbjRGL0Yic8rHsa3iRt9nsiH6vgn7tWfK
	k2luDSIah3bUw44B0R9++FMBqZ7lgJ2Xqlmiq9Okb4mVYHWwAXHToJO4jFAo4Jw==
X-Gm-Gg: AYBFou38Vbwy0Ku7WL7suC/KwAeHJtvCntMVOYbhMVJUpS3c9gVJo/2kXtampOfOLNl
	Qxx4cfvYewhPDp3yEoIT2HZMGtd5ps0bItSQr+QEWvVDXwsXC7Okjuef4i7ml63djweTGKZmTfq
	Qz9RXx1wWtxQVpUJxa5nYQHzYuWxpk3cFRL650Ubh1ddEx4d+jtmevfFBKa4CPsddJvZLf4qTZK
	y601068krF7a2zIOXtTP2Ogqb74AwIiylRB8tdUAEdjrVoiE6fj85G5ofh2rFJiDYi2HTUWpI9E
	Yoka2w9BRxvu5+helh4Nu3OJcQat+w/Ms2v2N6aeGkEmL2zXZHxubFr0KSA0Enek9naYoIJaOD4
	8kEa/6u2Y
X-Received: by 2002:a05:620a:7018:b0:93e:b7cc:67bb with SMTP id af79cd13be357-93ebd278519mr1938893985a.54.1791895757312;
        Tue, 13 Oct 2026 05:49:17 -0700 (PDT)
X-Received: by 2002:a05:620a:7018:b0:93e:b7cc:67bb with SMTP id af79cd13be357-93ebd278519mr1938884885a.54.1791895755713;
        Tue, 13 Oct 2026 05:49:15 -0700 (PDT)
Received: from [127.0.1.1] ([86.121.170.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab6361sm4351081f8f.32.2026.10.13.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:49:14 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH 0/4] pmdomain: Preserve boot performance constraints until
 sync_state
Date: Tue, 13 Oct 2026 15:48:38 +0300
Message-Id: <20261013-genpd-boot-performance-floor-v1-0-a765dc83e6d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKYozmoC/yXMTQrCMBAG0KuUWTuQFCziVcRFfr7UiGbCpBWh9
 O5GXb7N26hBMxqdh40Ur9yylA57GCjcXJnBOXbTaMbJGmt4RqmRvcjCFZpEn64EcHqIKJ9cikc
 bJzhvqBdVkfL711+uf7fV3xGW70n7/gHbafHagAAAAA==
X-Change-ID: 20261010-genpd-boot-performance-floor-8afd51d6eab0
To: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=gF+HUjSaBikzjJybtnT6fARnlzadENkUSlr7gWZU02s=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqzijAml/2l7elJObgNZS4YjDmq0pM+mZ+SZnUC
 My6+YrsJ/KJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCas4owAAKCRAbX0TJAJUV
 VqEWD/0U2VU40PoRitj13/NsJCdDOQ/S/ANJmFGlM8rlBdCARZM8sxvlvQXC+aZLFNLx3F56WEL
 eITcpckAEZ2JJ25Q/ysDJRPYrbfF8gY09mdC4VKirMoEp9FKgslV0KnlLKtjdE+HHCX2PWyB/0M
 kwqVmpCBZXJhzlbHPLS0UAjBrH5SpdcjW1iF8DrQ2xjxDf5t6Twi6E91CGeabu8Cei9IZqdTody
 tDU1jaO3D8r0wO9AK5/zWyoBc835bQEFRvsBjzw80i4khI5Bb7uI3YjHreH7zwfzAF0Brjot/Z5
 6JTdzqIv9mrAQZR+rp3YbELx6ZjBMzEQvAVOJiYpMmnf49DAuwSmne5whiksxStqMI//vCuMhkG
 4VTqbn7H7CDIJIOF1U5VO1JRMC4m276mWsrV14uz0ox5UEgLdDVpvMVCijuzAijT4SGv58di9Y6
 Uv6utLPjuLIwFQkmUMRqhBi56VJgSx14iTLhsFQ16whWZypWoGbzYQZMB79nFs2/GKEvlN3DSMb
 PeDHyTOehDHDE6Y/EZtXHjkgQNWKRQoy0fBgCsc/QgrKzobmbS4OuiFdgnuyALhkeBvEWQbYYKs
 bslTwz8bmM9JCMchRjCZ7O3wJatZ8L7gh2knxvUNrqxx/W2pMum2xIgKTuRfUe4Hr3JS+xGTB2K
 KLqw5xSKF+DrLdQ==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6ace28ce cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LTKF18k292_tN2xtfDkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfX3LkNtAKJJXqz
 ar39qsyYIeIwPa/dT0Vlw2c5+m4I7biGbc7BfE7Cwz4PDbLuoJ61KY/kU4ZhXRCK+i7qHp8iqPL
 Dgrav49Bt+nmer8P6VxQSkEtbtTFgYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MCBTYWx0ZWRfX9GBmbzE6r16l
 //TUasbkf7W+yQcxa0GPtbF1uWmGTiHJEk82GBzWndVqdH/sqFCSnirI6Fd52SXipU4jovGnh4J
 OiEXKrD9KnmXLqiYGmt9eIJqCat5AtMgBmJ+TYPSBoQ7tM73yS7enV7g5Zd3td3a79vuHE0oYX8
 g34W+uiImI5qht2l55AOeaLHbENQieYRe0BtCf9CgOwmE3Enb9VIZp7PX8c4g4K0nmnfd/jJv4o
 RNsp2puwY4xwEjP/iIYtzws5UGgY9mLFWf7bzjyHNUKtGzeo8cNGkAFOCakJJa5b37cmH+223rN
 Kbden43bHkBxvEJt2WcJmWQvotKwjsnNeKeRLbotBNWtqB8JWe5NOEh3QIvXYofscwUMcdAOlEt
 TMrUwyUA7hG/UZgJWJgulnJZ9llxZp+fv6lIlwLUNFq5sNyowFNxh0oRwgEMVMCFVq0AiCQVOP8
 z4+ZhuOi893Awtk/dEg==
X-Proofpoint-GUID: 7lG43htQXbRxFV1hPW07b-WYQyVHGyl9
X-Proofpoint-ORIG-GUID: 7lG43htQXbRxFV1hPW07b-WYQyVHGyl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130050

RPM and RPMh providers clamp performance requests until sync_state() to
accommodate hardware configured by firmware. This hides the boot floor
from genpd when aggregating performance requirements towards parents.

Move the floor into genpd, keeping consumer requests separate from the
effective vote. Apply it before runtime power-on and prepare the domain
hierarchy before system suspend. Release it at sync_state() and convert
RPM and RPMh to use the core mechanism.

Assisted-by: LLM
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Abel Vesa (4):
      pmdomain: core: Support a boot performance floor until sync_state
      pmdomain: core: Prepare boot performance floors before system suspend
      pmdomain: qcom: rpmhpd: Let genpd enforce the boot performance floor
      pmdomain: qcom: rpmpd: Let genpd enforce the boot performance floor

 drivers/pmdomain/core.c        | 80 ++++++++++++++++++++++++++++++++++++++----
 drivers/pmdomain/qcom/rpmhpd.c | 17 +++++----
 drivers/pmdomain/qcom/rpmpd.c  | 12 +++----
 include/linux/pm_domain.h      |  6 ++++
 4 files changed, 93 insertions(+), 22 deletions(-)
---
base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
change-id: 20261010-genpd-boot-performance-floor-8afd51d6eab0

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

