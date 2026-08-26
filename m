Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2773B71C8
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732108; cv=none; b=Q5L77xTAR3D4AeYKiRptv8sJHoDvmwcJhv+5ee8UvsPVgJNG93PbZRRy2WejzBGCRfCgQzqnQqBh2GO1HBvKEEKUAAG+iUYWVwGSaOyLmT7336bATdKPpqpX+gYPZPT4lpbedRmg6j4NqM2VjUZb3L8Slyoe0QRq00yEFiOIAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732108; c=relaxed/simple;
	bh=eoHc5C3jceHdErQYT+D5RFGdh4CnRCG6lVo1TACPAzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rzlxj52jR377xJL+eY7VuUtsyy9nhbvQzwzMeQDkY346otakv1mfVQM09p9FUILYq9yjStgBWDXWXAI+gTgCbnj/cpWA2SrYyLaE1RI5vjYJkOOj0WrmBVJ78SHTsOkuW0Fgzk49hDjxz34vFKBBDyjmw1On5yiQ8WeyluJANIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MLi8R+yA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QovV7n9K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MLi8R+yA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QovV7n9K"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RcGX3794471
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 08:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=CSYxcgBu8HvkrGOpHZIhqeDfTYDzYS5Fka6
	MnULN4wg=; b=MLi8R+yAbsp1Gp2UfNxoXAbk8HpDCFQigJrjKA1IuZ7HR+locR3
	kmuqjTeec089k0Mi3DjLuqWsd87wvk5V2uzAcuJ/2kku/LKEK8WWG5Cy0qzfP489
	XQ6QVft7PL+G3QzHyB23vW1aNoqt5tNcZY6FAdAhUrp16XiIuvUuo+MC9iWpdKvi
	TxSZZLq8bUR0NZp/Lj95/uQkwbRKuGeBPzXHAzNVxgu776kL1OjqEHybBkBzNosa
	qw39FLXqbcez63I15sYE57kX9Xq2xq5/kGpcQrvMJ8MAfd+C6TAq9v7O8YMiAh5X
	KzzFcM1cQwIHK8NOAqQKNIOxjWXdbkkdU0g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx8s5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 08:15:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c21c01cf3so12517551cf.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787732105; x=1788336905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CSYxcgBu8HvkrGOpHZIhqeDfTYDzYS5Fka6MnULN4wg=;
        b=QovV7n9KHR5OJPJTdYxOEUhzw8wrxTgH91o6KgTrOElga27V/oCwuz137wVzJCnfrk
         NayD0RuWVsZr3NzppNRYA4y/e8r9A106IR3fziEcW8n+6OVyndZwQJFC3TLY0zzqhTMg
         4n1AZpkEUJz2mL2hSb/EN8acZrqJgVnpcPl/izptPFezZwmx1/I+DobvPhVb/Q03wRVo
         IlGfPX7UtV9qnDlO4jlyblddVxBk70tAz++/zg+5fEK4uKQZt74x/4GtLosXwfllqIGt
         4QcrU2oe5hnrc6SEm+oum1Z4+UUM+RaovA855Md1xdO870/Or+5/6o5+EOqdDMbxsobx
         UtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787732105; x=1788336905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSYxcgBu8HvkrGOpHZIhqeDfTYDzYS5Fka6MnULN4wg=;
        b=bQTsLsTazD6rOwAAZhFlmMmoXkyh8CMESoGaA/gdSmP0jG2ypuj9BKjoatGDviqlkd
         i1myjlcUO6FcbC2+0FK2hg4suSGOPyHqcer2jYeU73IIVQonK/iewanbLdPvceKbPQXa
         YrqqzNiSRSJEmh0z+CJ8LfVlMQQDOfU/Dpyl6yRn6fjvdMq/oA2rrapdhJM4F+hVLhJS
         YFvNACLDzR+W69E6bvl3aatv6By0wZY24vWIQHdtACRU7P8SOTqMqXfM2O6Q39iz3ap3
         Txwmqwcwv5IAClxa9eIcejZtczwBiZibwlHH/nBd40+W4HaYmegu/03lC/G/4UClBV2N
         ZecA==
X-Gm-Message-State: AFuF++llKa9Xk2Jy616gb17R5qVWLXP7xLleueW67ovDZX5kmFxuNg3+
	AjMT3sCFzxvdZGHmhxaCm23MnG/LsI4JtSmBIugx28qtceOCecmp7+F2SpfKcgo0LhWoDdDnvFv
	Y84ygk6aGu7YQbjMlsAbkiA6E9dtW4jVz6yakdh+g1RxpQgfduxsbQP/d8IU6RA==
X-Gm-Gg: AR+sD10O3i6DpOlqcFok1R4yn5U6fm6i22gboTUvUlWsGpbJjfWaZRfUcf5VZTVQvZ3
	NScgDIOSnjYDXxYlJ9wL9F0enLG4PwTqV9YlGBScRGpNjxhpQTTUc9nklVsh4Oo7Lbbm7mMfAem
	behIL9q4Rl/MdOL54geHxMlbYb0H6Djvw3ooppmpcqZ0EdGh1MLZZV08o9N6u/XNMm7Cayz1+RH
	Nw5EE4TZ6EncOPtEVUPxk3iNwST/u/jgYlmjdF4LmxQtaIdB0MD+Z+Iccql4gjYjvArP8p/DZEY
	BDr0I/ADU9VSNlR3m1J3PjYuMx0JS1WMeSyVIZ/CQCHuPO9u3UgL8LI1oZT4RklBYEl2XUVTKqj
	uQH6Vn06KtQc/GvdBJe+fu68FXHaD
X-Received: by 2002:a05:622a:4d08:b0:52d:cc1a:a02d with SMTP id d75a77b69052e-52e4241c79fmr50862801cf.41.1787732105110;
        Wed, 26 Aug 2026 01:15:05 -0700 (PDT)
X-Received: by 2002:a05:622a:4d08:b0:52d:cc1a:a02d with SMTP id d75a77b69052e-52e4241c79fmr50862461cf.41.1787732104716;
        Wed, 26 Aug 2026 01:15:04 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dfd4:a0a3:2df2:7724])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b22ffsm328907466b.42.2026.08.26.01.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:15:03 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing updates for v7.3-rc1 - part 2
Date: Wed, 26 Aug 2026 10:14:57 +0200
Message-ID: <20260826081458.26747-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8ea08a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=XeMjKHE7Nn-_tcF_2mwA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 84N9c_NgaoQU7Mzp-LHThO34zdA-WHyC
X-Proofpoint-ORIG-GUID: 84N9c_NgaoQU7Mzp-LHThO34zdA-WHyC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2NyBTYWx0ZWRfXwYdSO0+hGlgQ
 kcWJdV+Lga0908TqETNHhxUX+2XFK/hcjv5er3U9EGd26WnkPUI1ctBQR2erkoZJIiiMSpGU9Ke
 c/JaDUNP4er7NvRMBy71bBvauoGGx1jJaSbV1jltkNRhk6U4m3aXgAT+qkMakLK9GW2DixqTDZ2
 JykmeXWhLD0MsepyQgg1x5fDonk0DxXB60F8G6IIcozurlkzz+LjWm57ApS21lTq6aBZ3yUcFmd
 iEL2nLYp22ZCHh93Ye9O8e7QuoLygcMkNInOHKR+HEpvlNfiib7al8X44B/stI8JGVEv4oW0Yh7
 vK1T3EV1qhIdHjMmHDOReKDVUQooP5Eg1EyxOjYlVBR96VqcCyLT/p+8ta2Q4XA3Odddiwg2Sa2
 pDpe8z3hQyfPnfSirgHQC1DEn9odCBlOdQn2TiPOtbtC79aJfFKt7CQMNm8V3/hw1ui6pfkyctJ
 riKH5hP7O3eSnokLZAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2NyBTYWx0ZWRfX0Xlq7QDcgu5g
 0MDOYjsB5tlFxgcqtnG7LMTEnaveDy7oWPSvp+Gmfv2HK5gXC9nOe0D5NTLzlupMxSIXs4BYTBE
 4f5P7mz5u3IVOZSnRng4PJ+/MC7vjvo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260067

Linus,

Please pull the following one-commit PR for the v7.3 cycle. This is part 2
of the power sequencing updates and it does a tree-wide rename of two of the
public functions to better reflect their actual semantics. This has been acked
by the maintainers of the affected subsystems.

Thanks,
Bartosz

The following changes since commit a39ac4651e3b9d2ca78b6d3dc2a81a6bd25fa616:

  power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID (2026-07-24 14:36:39 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.3-rc1-part2

for you to fetch changes up to d51fc9d4cd6eb18ac82913d83ecf7bd8c85f71ee:

  power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable() (2026-08-26 10:05:45 +0200)

----------------------------------------------------------------
power sequencing updates for v7.3-rc1

- rename pwrseq_power_on/off() to pwrseq_enable/disable() tree-wide

----------------------------------------------------------------
Bartosz Golaszewski (1):
      power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()

 Documentation/driver-api/pwrseq.rst      |  4 ++--
 drivers/bluetooth/hci_qca.c              |  4 ++--
 drivers/gpu/drm/imagination/pvr_power.c  |  4 ++--
 drivers/net/wireless/ath/ath10k/snoc.c   |  6 +++---
 drivers/pci/pwrctrl/generic.c            |  4 ++--
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  4 ++--
 drivers/power/sequencing/core.c          | 16 ++++++++--------
 include/linux/pwrseq/consumer.h          |  8 ++++----
 8 files changed, 25 insertions(+), 25 deletions(-)
