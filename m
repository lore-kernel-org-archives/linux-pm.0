Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499446;
	b=lZap/ePGaF8pn3bsCVNtbiKFzKXbLpMSSuTXzQoHvwqkTfyJFZlbVj3ez9TZUBXyW3ij
	 6WXH7RY+ki0CcAUDOzTND4HLL2Dw9q0bpcyYUBC+zY/pfVlZCEKOac1Qsunh/qOooh9Bl
	 5Wp05mEj7JXok9OH+aNItbvuzgd7x+XmENwRul7hJLD3kDUOJ8N3b0bJ1A5KvfMEE/GwW
	 RlO2rnHzPx7PKTnZ99YmvC9dEYWLPB9AqlCLOtDC8VkTkem0NcxAlZaZXFgnfpJ2oiUCm
	 omM/L9zJBghooKBr5SlwGgNcEtWtus4+pbfHQlOO7wCgfoQcJWvK0RgbhAVnTCb7YhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499446;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=33S+qNYSGyc9SP1Rjy7h+vlSjkGvft8MHkiYlXGDjZI=;
	b=ar9dyL+yXN/aIR5itP3KI31oZkjsqEOHR+mv4ua7W+pEtCWuBfdh5kt+j3KnzYdEPb++
	 rKrZSnl05AlFK3dohG0+ccSyzf2sxUfUDlWaShIpr7C79uRyG65ElAUIeerw6v8Tqa9Yj
	 k5kPC9tc0sYA5do1EZofS/lGqtZ20KKxPjoQ15N4MKG0wylhfXI8LXdUB/b34garB2jbJ
	 t7D93ewkeQ6SgKHyS2sdRYktWZuxCklstCyR/3VPqy34D/gvLpdZzydGH0rsILbQSJ3fW
	 v2AtwvYBT2M1FiSNu8vRYU96HJUx6g1bqdkjU7saaCwKANs0SSMDxfKPL/FFpglzU7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ma1yFGXx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F8KaPbg9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A5606A32D
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 16:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C01A5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ma1yFGXx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F8KaPbg9
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFZaSs2293614
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 16:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=33S+qNYSGyc9SP1Rjy7h+vlSjkGvft8MHki
	YlXGDjZI=; b=Ma1yFGXx4I1PsAb5TX5656beIdHuj971dDQg8PRUlbgqGprvn7b
	FpJzjtSjVPBcW2KCEopp6BwquOVFu7w/XqZrgCdqZ2WvKSn0Xyhp9E3jV687n1GV
	qoN6LBs6HoIi9nTc9DmGqCNuOz03aaTthSFN7OpUlLwlI3QXsvfH3ekRjIOUIgMA
	V0rgPCxScwWj9EDKtknpFDNB6uvmnWhqvwE1/bX9Pz/dtLPKRAU+Ufn12kM8s4Sh
	46mnIJx0pywelYkHFZMBMx/g+cQRhR95r+FGOfK8ke8zeDnuyxW74z3UC5hy6EFm
	zqySUPQoGqFwm0t3BzYgeRbEE+TLXe6Iy9Q==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs016nr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 16:04:04 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c83124d530so5063239e0c.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794499444; x=1795104244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=33S+qNYSGyc9SP1Rjy7h+vlSjkGvft8MHkiYlXGDjZI=;
        b=F8KaPbg9dtyHNC88gk0UPLPHL31rIJL2DoxcUINpDfSc4gh+hRDErBVXZucxs8jRrT
         Sc16gqn9c+iNe/SNBPL/sFUgU530mPUBiPrN++rZwbJ8BwWN4EPRw6x1w3/LhGnaoohP
         nd5tSeaPiRq6/gvaRkWP/ErL9igIxEl+ElZ7AkrSto9kUd087ySqanAog69c8U6DSRxG
         9heHHvb8c/FN5F93stkyKfIyJFXTZ8Pzxse//DHIGKPpdMepgHAz1WLPRQmyD81Xzg62
         lUaEkpMn/cIgRWdPgHUg2hR35U1QZ7duAkhj+HD+BduAzb6c2H6H0g19x2gTh/uYPahN
         cL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499444; x=1795104244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33S+qNYSGyc9SP1Rjy7h+vlSjkGvft8MHkiYlXGDjZI=;
        b=tolm7vt6rjLlRVhF2e7T6cw+MbKVwWo3DWMiU4yGRiuENiOyxIk653vWmoKkziXTjn
         Khq894cSRTOyEYDVhOnI1+wUPUTiSuh2Bt5g5N5YY9bDows5TtkDt422q1PRXq9vpV4a
         SJnx92u9vqiIFoUUrF9BqwpdMaZwmijzjWGM3EwZSNBC+4w9V85GnA55JZTnzutfuGQ7
         rwa8xr+t8SxAnedWapXFNN7geUkiTcXz0LVYLYdT0DnTuUdMXINT4SSqRfaq3bashCXf
         KY7BU9etLktRc/N2MHv3AiJM6oZOZjqELJKrGggi13j+f6m2YmO/iyRz6y0uKO++yvfT
         4rbA==
X-Gm-Message-State: APuU4Z/bAyVSpubXskzYLFjRJ1sWJKzcyfAHy7pYadoFI9F+l3x/4B/g
	5G5jkYwLmG4++uf9M0O8Lb33huqWRc0IiaaLlkU22AXeAjUvvja9x1U+w0OrWEsFVutPw8a53LH
	oRS0ecRcFEOMgvfqTbPoUuqwh0kt/7fomsw8dVq+T+IZs7je2h7HD1ujgbTUB7Q==
X-Gm-Gg: AYBFou0ZcDCeMlQfZqCf9qh+iTPm51tHuiy6BI005ez1pOeEdl01OhekeWHGGTVHhGC
	ntUXSObByal0OTSTDdlBXSz0wfZX905z5ADfgyIlyw5lBWpZufKgH5CiOdpXtw6T0EZQEmv11ux
	kpy4OdX2bF8IOV/s7yNXOm21C+aGZMP9/9NLUk3zobza+fYGb+CXIuE6wmuSsX+EWOnpZb7RT7m
	LvNsPj66OKfTqNrGtjwDKYvES0gvmuAxBEnVW+ssI9TvyKA9YC6XdTh1mdlA3ZQyolt1x//WgFg
	Zls8lZgpgZdViWcG668stE+4VD79alwTZX0FRYANiiri6x3FhpNWM5yAISje2mLnZ7KwHshpDVu
	/gBODOhB3xcc8t3A4g/OjMGwkXG7RLZ+Ic69CmYegsROQD56nl4+WutpbJczla/1/16q559kCCF
	derFrTS8ILYleUpeVQs8rg59ZvNI+awF1omDhErYfAUVAdjWgKxKcUAAx3ZI2NKg==
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr2745026e0c.8.1794499443742;
        Thu, 12 Nov 2026 08:04:03 -0800 (PST)
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr2744998e0c.8.1794499443328;
        Thu, 12 Nov 2026 08:04:03 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm78040185e9.4.2026.11.12.08.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:04:02 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing fixes for v7.4-rc3
Date: Thu, 12 Nov 2026 17:03:59 +0100
Message-ID: <20261112160359.52742-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2MyBTYWx0ZWRfX3GUBdH5ol/C2
 iVmaNtaYSpVqZVO/oQ3X/D4Np3pyzWG2BJ2LkcYIO1Z6ShfOGTIdmDlzx6P7m878yVm+SO4WSor
 yYlv+Ob/yNDxHr9r/xphH3vBeAs5tjNB5fCTEVAIMjiQ8SyOHrZFqBE/2x5LEqo4zuFCpanovex
 ym7K2vCzhxDWjmKiswwZBa6TtQxaVg2AUUfeNFO8dd4X9MGXiAB3kcay1Q0yOlRlfNl+nPU3V0/
 rE7J5Jp7ichDWLrZfRDO5uky4pq6FBkLXKLrV4epdDyeGkxp4hlzsFkXguVuOk6xuOHyF5RkWZ/
 Pt13NyRZCXyqeeedFtvZG+Y7VZWYGtjfV0/zLxVKY6YbIU7yAvfKkt/tmJljvK99aZCvPVAG8HH
 jJ0by6C1sEBiQeIW4FC6urzwShmS8oiikN5mOFRUIGwoNoXO6xW5VDJUkVaeAUnta60kW/nf/Jp
 JPtiuAjPecUeO0uhPdA==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5e374 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=Cb2_Q8YfTQsDjjc_npEA:9
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2MyBTYWx0ZWRfX6elYxnz9bMcf
 b2LkWuI+Zipluk/BQJjK/RoOP9x8gpggpffzkC2JZCPvYYnjqsI1pJHEcNk9qO0+whwmHTjtvBp
 0oLKiTQrGsFBDJQZ9TsnNlPGmHZmxMs=
X-Proofpoint-GUID: UxjAPGYvQir2vFh5uW11gw8ukDdMrJxQ
X-Proofpoint-ORIG-GUID: UxjAPGYvQir2vFh5uW11gw8ukDdMrJxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120063

Linus,

Please pull the following set of power sequencing fixes for the next RC.

Thanks,
Bartosz

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.4-rc3

for you to fetch changes up to b149b12f6a52997eded725ae5deae24620dbbbff:

  power: sequencing: pcie-m2: fix serdev controller reference leak (2026-11-12 16:59:21 +0100)

----------------------------------------------------------------
power sequencing fixes for v7.4-rc3

- fix a use-after-free bug and a serdev reference leak in pwrseq-pcie-m2
- increase WCN7850 power-up delay in pwrseq-qcom-wcn
- make the API contract for pwrseq descriptor serialization clearer

----------------------------------------------------------------
Bartosz Golaszewski (4):
      power: sequencing: core: add a note on descriptor serialization
      power: sequencing: pcie-m2: fix use-after-free in pwrseq_pcie_m2_vregs_enable()
      power: sequencing: pcie-m2: use devm_mutex_init()
      power: sequencing: pcie-m2: fix serdev controller reference leak

Shuai Zhang (1):
      power: sequencing: qcom-wcn: increase WCN7850 power-up delay

 drivers/power/sequencing/core.c            |  5 +++
 drivers/power/sequencing/pwrseq-pcie-m2.c  | 63 +++++++++++++-----------------
 drivers/power/sequencing/pwrseq-qcom-wcn.c |  2 +-
 3 files changed, 34 insertions(+), 36 deletions(-)
