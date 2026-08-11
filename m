Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F415E25A321
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786427423; cv=none; b=B4Ej5stk6Py3gedKtCSifn5zYkXYm79sHDMSmQgQ/BkUcq0WUCfmWHGjCzHZiKJLFlMDQQe05vXW2fu/FZ5VcheCR8TQRZgEHTJ7YT+bXG1lUdZtUqhdbdilxufzC+S2dMwooLnRP90fBylSg5JDhYSc4eUoq6iyg+lm+hglj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786427423; c=relaxed/simple;
	bh=YxRmzsXwL69qEXZhxMu1pjQ0toXga7vJW3wqY1JbwA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u/lXbN1dC4hA3/2rfnx+8MCOvJVhuf9wBgHrqhSQc4WMbPQ6TBOuiwF6s5RtaLdKXC2zNL8AMh34LHSgCCllU+LoWZ+cZYz2v8gibGJaCoIXyMcruXqvpVZJeHTvIFkfgrZz/C5F6DjhOrB+zfhxylGCrvUkukoVJwitswU0vjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=edyXknsu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RQULlAqe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="edyXknsu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RQULlAqe"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMpwJc2705441
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 05:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zlCU+1Hoxq1rQXyfHtQVCx
	21WrqoA84d1mAPvKqjLm0=; b=edyXknsu7Ac2Lf5UgRXVSbuPpaXr7ciSk3O+XC
	Tz35O8rSIDzaRsBI6jgoJ9eiBaL5wjpFGAm/84bPkMVSUS0SVLRyMpuZN6o1k+fH
	DMz4M0h2fNTI8BbAmNOR21FdTfeJyHMxUoFA+aitAmsiAJINu4qiOnhYnhW4sLAA
	U6WUj6hSHVwkZZBFa4lFDReufwyCg08tRlqByLBYY2VBE1Cl8smE47RHwcY+KEDU
	ecICVq8gN9zsWiuCkk0dd9Oj44aY4z64IoLUglwJBzEMKg+xSp+7tg7jzuuAZAZ0
	pHBEYIDAhZvn+0N4mOs6I+VVL3+YIrgkCnenvK7kANeSAEvA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk62hw0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 05:50:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc6dd43737so10022935ad.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 22:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786427420; x=1787032220; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zlCU+1Hoxq1rQXyfHtQVCx21WrqoA84d1mAPvKqjLm0=;
        b=RQULlAqexEVUp3pbM3KvhYAl4JHdscPBiUqzFuYigQrNpvcDXdFEs90Smdz8H27ZxE
         G83seUNBFOHIgVPsa7JQ/qMFrVWKrstQj1WVxC9bKVCKyqMURNTEzDpSmRtLvnnvjbE0
         mrudy5kLnl1UXDEgy3xakQgWweNhAqhHmboeQRsZXbLxCRdvHmW3Il1d3AkeZwOc50zc
         t/uLVYtwvxBoK5FW0171ggHnaJT4AFuN87of6Vkyt1uxvAluLKGse2oGL7stp2tl81WL
         ucp8i83awecasG9nkRzX4H2GLg2R6Rv7QZyXh5DRNqLfrdWUn/iVXOhCYSZtH1SlGfa9
         pHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786427420; x=1787032220;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zlCU+1Hoxq1rQXyfHtQVCx21WrqoA84d1mAPvKqjLm0=;
        b=RtMlUU1ayHNKRWTq7O5CktcF9K6jo04H9H9v+gMbjiSQNpmUo5wYV+1uzZ1vpnehFd
         rcxgL5dzeH3sj+Sk/wsK5s43YbylA011UmqsRwArMVMA1pnfz2BRlOMbaFc/5F+UP1gi
         L0Z/f3IDDJcM4gd6EYS2UjStrdsQ0+Dm0jxfeYMiD2vlrAFDvPcUV4BzQo5oFYgrCcC9
         cFd+kMCPuSHqzex4XC/KVbKpgCTPz0gOUAR4brGmNE3/6bTWvZyKFgX7tBSU9XsA3YTz
         6+2iAectiPrh+/DCFAfUsGBMKxHkUEZm8vKBZFCdnRd+0RKxQybEqKkZP6yM+6PlVoDr
         UKqg==
X-Gm-Message-State: AOJu0Yw0npHVZCx1bClcjNbpnwkk1yZN5ZfG/1hkiCZjj2j9KaNTKK1t
	+jcTZkwoWU+g0o9E580K76WTSh6t8drcGvMV7b1VvIxK2bOslzTDAyaLiB7EjLGYkp7OYVK5BC1
	v3KGJs+e2ANB2WzQUMfwjPpiRtdbP0MLm+tI1TxPFr5O+PPaYYwozd44lTnhPPT/RmqDyHQ==
X-Gm-Gg: AR+sD13PrljocxUQuuiFS17unbgc/KYYL38PWwK6LzOJkjyda13nHEOd8s3wPFL4Jb6
	fa+qiyoTftQK1NETQwy3/xfTm7H9LPu1W+eTyxhvnRytTE5Kej9JT5OOgewPEHnngilfzXK8sar
	HVMPx6S/YUoiU7FTBoqCYvCx5yBcGQ2ZJVDU0mRjlSWdnuVHynfWKwWGtqytpYGHxXG5mXArvoj
	QyYuuZ7PQttl6EmEvPipTaeVTou9lsDKyLHyH1zhdX9I2HI99Bl+6uUvUxM5Ro252ph45l51TLo
	EH0KcRTMOG7sONcyqEFtjzoXEmXy6LVlrHUpPIgCpvwb//31Wu51/mAG5DGrCpy93QkQEqy1Glp
	Fx7/FRZYlcpLreKYJx1iu3oBHVvfa
X-Received: by 2002:a17:90b:274b:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-392ec71cae0mr893344a91.21.1786427419516;
        Mon, 10 Aug 2026 22:50:19 -0700 (PDT)
X-Received: by 2002:a17:90b:274b:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-392ec71cae0mr893298a91.21.1786427419032;
        Mon, 10 Aug 2026 22:50:19 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d534ab78sm2062289a91.12.2026.08.10.22.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 22:50:18 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Subject: [PATCH 0/2] cpuidle/pmdomain: Correctly track state of excluded
 CPU clusters
Date: Tue, 11 Aug 2026 11:20:00 +0530
Message-Id: <20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAi4emoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ND3ZT83MTMvPj8tLT44mJj3eRUM1NDc8NkQxNDMyWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgAd7Bs8cgAAAA==
X-Change-ID: 20260811-domain_off_ss3-ce65171c1416
To: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786427414; l=2479;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=YxRmzsXwL69qEXZhxMu1pjQ0toXga7vJW3wqY1JbwA8=;
 b=9ZpJsh5hzZn3fUVFYXRZSERpLh4cMMRBFjL4WlJuVSsfwTk6lKhZFtRrDgvrTe/CEzzVvYLdW
 z3jyM5yNswhCeEgvyVIM7qj0PgYMJB4uTzzNHqEBrDgY+FomgR2ZDh5
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7ab81c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=D9W73uoA5fEuy_YkFGwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: WLu74oABsIIx6KXz1HJRciagzkvzwNE3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0NiBTYWx0ZWRfX0Q5fUxJErJnC
 bT0MxMXRzoT8/3StYLe9NVklJL+WniodAlqvBqtrJUPyGlRUzZjbZs/4cZYVhpTQxrRwQkEbK86
 FompVMBKAtGQ94pHZXhqKD7+KUNZbR4=
X-Proofpoint-GUID: WLu74oABsIIx6KXz1HJRciagzkvzwNE3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0NiBTYWx0ZWRfX49LzRN0RxqWP
 j3k4QNx7qs5AHA4HGOWLlFPMcFiio8k5fKmzhPGQuwLwNj5T71aibgJRoiJMCmPWoBIi6SS7ZMj
 b+EursGTqhALgTEJ22ONQeQDoE88sbkm/ofQ9FEkb/ZxlAduHbvvvg5OhyN9gfdWc2z28QZcHpZ
 O+n4z0OGucfKf3+cA2W+2p0ynTBH5+W9zkCMHJT/yRy9aWPF2HuMouv+0UJNHhQq2Uz5AuYO40W
 S9xUNs6J5EtcPrHVebtup75f79zvLRV2khCJdkIK4e9He6A8hhdH8sx5wxJ4ElCmO6PwbpGGTgG
 71Ry9axL3sLfNTuM+xcprAFMFoBS4G99/CxmvqcyDvCWhRnGXOv4tij71bbPoH4n7tEIDyEP9yD
 WYcZ30AOXdrdgZ3hSntcH/eNt6GDtPxf3JjbZQjzFD0wQvxJgcnAPCMsRD86DPqyEm0p5pHuNAA
 kfVVQeCJImxPRemJvNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110046

When CPUs in a cluster are excluded at boot (e.g. via maxcpus=N), their
CPU-cluster genpd is never really powered off, and its reported
idle-state index never reflects the deepest state either. Both issues
independently prevent the parent domain from ever powering off, even
though the excluded clusters never ran any CPU.

Patch 1 addresses the domain status: psci_pd_init() always calls
pm_genpd_init() with is_off=false, so a CPU-cluster genpd is marked ON
at creation regardless of whether any CPU in it has actually powered it
on. For clusters whose CPUs never come online, nothing ever transitions
the domain to OFF afterwards, so it is stuck reporting ON forever. This
patch starts the domain OFF at creation when OSI is in use, since
dt_idle_attach_cpu() and the cpuhp callbacks already power it on
correctly for any CPU that is or becomes online.

Patch 2 addresses the idle-state index for domains that start OFF: even
after patch 1, a domain that starts OFF without ever going through an
actual power-off sequence is left with state_idx=0 (its kzalloc'd
value), i.e. reported as parked at its shallowest idle state instead of
its deepest one. genpd_power_off()/genpd_sync_power_off() gate parent
power-off on every child being at its deepest state index, so these
domains still block the parent from powering off, even though they are
genuinely off. This patch sets state_idx to the deepest state whenever
a domain is initialised OFF, addressing the root cause for every
is_off=true caller of pm_genpd_init(), not just PSCI CPU clusters.

Together, these two patches let the parent domain power off normally
on systems such as hamoa when booted with maxcpus=N, allowing the
deepest system-level low-power mode (SS3) to be entered.

The two patches address independent gaps and have no hard dependency
on each other; either can be merged on its own or in either order.

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
Maulik Shah (2):
      cpuidle: psci: Start CPU-cluster pmdomain OFF when OSI is used
      pmdomain: core: Initialize state_idx to deepest state for OFF domains

 drivers/cpuidle/cpuidle-psci-domain.c | 14 +++++++++++++-
 drivers/pmdomain/core.c               |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)
---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260811-domain_off_ss3-ce65171c1416

Best regards,
--  
Maulik Shah <maulik.shah@oss.qualcomm.com>

