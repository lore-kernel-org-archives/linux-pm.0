Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76F388E72
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377528; cv=none; b=LGQ+yMu+lX3YBunVwTu2KBQLjFtU9+jTaRFPH3J1p4rsw7rcjcxZpp9KqG0/o1IvNKlcCPwhg4leQhGEMMNAqpOxkNitvO/u9MluSJChHRlKqMdxe+c+6Q/xR4dYPo3D3QVmVyCRrrQGH2PV9XSiZJ0XGY2pkuNl01jeHLm77e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377528; c=relaxed/simple;
	bh=MCVpaX2gIbOJhkO9nAk1RfjqghwZyieOvZzdJeQku+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVuBSPLMqEMbeBVxXVNMFKDca82lL0SydBC7VtkBrjR37x4fyokzq5q/nJkDtE3LeNSh2wqkJJCjhDgVuAUExbREPdDSNBwM73ORthU3o/ZFbT7wHKreFD3hHcwK3vwiqO12ZHMnVQqLbsNsuj/mMNBpBxUHps3wE3xwfDtVQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BPxfa7Vy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QMdPNfUG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BPxfa7Vy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QMdPNfUG"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P8pHKL1629574
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 08:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+Q1VwGWgIs7hhG7IINuL4CeMOuBSnxD4O/8
	EcGMMIdU=; b=BPxfa7Vyeem7nTbVE2uQL9FuctPcpe0VialSXO510JLF2LBPNL+
	tL3JaggAWWKkH+cYA6wZkAUM8GQfMwq6AmxozaZSCD44pfzgXZjSIgFCqFGzbf+Q
	PR99vJgyTFhT3esxhinXF4BsZDPYpfPAae5HdARrfBIC0zQSaMIO5fllye2hs0mG
	zMzRgmkSqrLgI6knDvD6pm1b835oWzd3p6CrEPbnFsVTkic2XKCPAfkgXYdgCwT6
	i92uaSRLxvg9SjCnFTosdN78SB14T2hUJXdSgZY2xkxcqo4g/tS864ce5/pjA6Yq
	8hmNShfMcLQmrIjD+D3u7rEwcCgaBxqiCZw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q0ygu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 08:52:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-920aa2e130eso336612185a.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782377525; x=1782982325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q1VwGWgIs7hhG7IINuL4CeMOuBSnxD4O/8EcGMMIdU=;
        b=QMdPNfUG71X4dRjjmwIGTJFsvfa9r7bPcdS5NiXia3oWI6zKOk1OrVMzyUjSyCi5ZL
         cCCkMA9LyM6/V8gxam03+m1PL7vk+Kwjl15m5RaFiNwQjdwnmDdecZ3sUABaL4mwtj9r
         EhMowhidF9jS88pOy6m+04sxrzG8HRbb+7UwnDQwf+nyZcYtE2xSHyNbQAOc0MnoQE2V
         DpHpMYQNiF3/jH9CezzmLSWuhsGVraaD1qbupSuIPFmq7SZaQl8/Xux0it568p6YBNod
         63FbqBcCeLtawcmq89QsAcjSEjDAr+JdCYkQcA6FgKZ9rMw6oWuaRSMQAN/C3CMatMOm
         wzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377525; x=1782982325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q1VwGWgIs7hhG7IINuL4CeMOuBSnxD4O/8EcGMMIdU=;
        b=hMRgyr/lOVAb4bFlhmtRhak/vhNiJKc3NqvI8AgOqN2Ec9TzOFkOQUbUkC9PzYtv9a
         OL3VwTdfhU92zxOCAk6rzjDkFBzJQPs4v1gPvGnyDuq+1uaE5qnrTNy0+2GPZGWQmird
         KFJ5lRhFBwxTX7G2BTRg/Dx/q7Z1Mf+6Z4coRXVMmq6tlEnXWHlV0lMnw+KAs7I+flsq
         CFnC2G3cai7Fltx4DG6wrMBf1eKKhapITeyArdoytNCmKbMYBM3WfybTmZlP0dfDiFt9
         /yCGOaFVDp6uktQ/4cH/eFWx6A+FdOsf05zhsueGIYn0+zqJiWRtMXXpTBZqaPHNHJ17
         Z/Kg==
X-Gm-Message-State: AOJu0YzvKZjqO2fXhw9qIhdNiF1WNqEld5wtft486wwQUjdBNxB5IuPT
	3u3rVBz4CGVE+atGkN9BV3uMldgJHupGr82x9tf4FJ7JvGCom0QFuhY1r9+ZN6Zp3ySacKW96pz
	SYzHFWMXe/HTagtjR5d78+jyZ4XxmPj81hlBxF1ftk0nBTOwxGbVUS4DF+GuPGJpoJFFseCga
X-Gm-Gg: AfdE7ckk8e6/pzx9swp5NVsuqatO+E4gvE/nQLK+8eSM2we3JyJzXIBESPjt8cAX2OB
	yGxqONO5x/9q1YSJCdYkSgwm2x6D+3soHgIyl8/+GACNulc9ul1ZzeCO+IuJM47V4CJljTxpKD6
	Sjv+zpunXkDZ2xSxSsihgBuEo1hA+q7kh+9NnognHC2F+kzkwQ9nOc9XuwMgx3RqePVCFisapMX
	GfFB38XNwXpcz3Zm9V73Z0+2Qbp1LDHVVXjUSOKToXs22DOaW5dmUQzdls0y7jPz24gOXDZ9FOx
	m4TI0zWYIN3i6e37HGzXg7BMcn6s/cld5EpGAzDK8uNi8BOMAig9MFFIEEJ7ZzdQlBCQEQmTGl1
	h/zvYGEpfzcZ2cwkG30+DB2cbA3DDcsA6ONXeymY=
X-Received: by 2002:a05:620a:2a0a:b0:915:9e84:85df with SMTP id af79cd13be357-9293a6b1751mr211904585a.17.1782377525285;
        Thu, 25 Jun 2026 01:52:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0a:b0:915:9e84:85df with SMTP id af79cd13be357-9293a6b1751mr211902285a.17.1782377524881;
        Thu, 25 Jun 2026 01:52:04 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:9f56:d19a:8af4:e2dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d998esm13295380f8f.24.2026.06.25.01.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:52:04 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing fixes for v7.2-rc1
Date: Thu, 25 Jun 2026 10:51:58 +0200
Message-ID: <20260625085158.11090-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jXamw60XIrE1Uwprvt-1CTafGeM5t6Uc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA3NSBTYWx0ZWRfX41g2Ag58S8M1
 8m5VvshAzJX8sN30pnDa/N8oSyXbJ1cxqdjmYl8fWet5flM62EIYHU3oP+Z03dR4ezKKdu2nCwC
 xiUbvS1fBJMtAsdT0EM2LiysWoG8cSk=
X-Proofpoint-GUID: jXamw60XIrE1Uwprvt-1CTafGeM5t6Uc
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3cec35 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=eQjbZGtN3h2LHCcRpysA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA3NSBTYWx0ZWRfX/m8+SB5UgMtc
 WCQqDdKH5tUt+y+PgwrFT7P1oZpJcMVruB1zvFvEXWQt09C1MT2sdXyfIuqCqRpuZQ9R89JIpD4
 GuNoT2YRvBT+phOu0y+EUPDP6v0nDAuF0AtFrTXHm9jsaGsd+Dzt2XibW6EvKbqIK7QEpMPktjj
 Uj36zuvrf/ToDn+u5oSRPAq1ObwjUcS9Up8YUM4Xwfv7fIB7usok8ugVkMiVVTxgqzdhW5+XraA
 FSvJWe+Egcwg2ug07BWzylRBbo3ZkhUnRh4ZZLxkSCRxbZzr6v6j3e0NLhMAMWAE/M93B/dQ+rB
 Lr+xZzWSzn01XB2xEv8JLEzcPhdJASyNs2srATA43Bb2mTjQAQlzfWKE5W7YoCHFbCsfilsaoaT
 xF1cdivoMkewGkzyBdSrVO0LHzftu12AAvE3Ll9+G2W+Mz76POg+i46egR7moQ6ta+tOqsWvz6i
 /0q9oUT+zkpb9ZQfP3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250075

Linus,

Please pull the following set of pwrseq fixes for the upcoming RC.

Thanks,
Bartosz

The following changes since commit 31e6aeafcdde965aa10e10e93ee186520555ec3d:

  Merge tag 'pwrseq-updates-for-v7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux (2026-06-16 07:38:04 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.2-rc1

for you to fetch changes up to 2d5a7d406ecece5837af1e278ffbbf6c0315560a:

  power: sequencing: fix ABBA deadlock in pwrseq_device_unregister() (2026-06-22 10:05:39 +0200)

----------------------------------------------------------------
power sequencing fixes for v7.2-rc1

- fix an ABBA deadlock in pwrseq unregister path
- fix a use-after-free bug in pwrseq core
- sort PCI device IDs in ascending order in pwrseq-pcie-m2

----------------------------------------------------------------
Bartosz Golaszewski (1):
      power: sequencing: fix ABBA deadlock in pwrseq_device_unregister()

Wei Deng (1):
      power: sequencing: pcie-m2: Sort PCI device IDs in ascending order

Wentao Liang (1):
      pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()

 drivers/power/sequencing/core.c           | 23 +++++++++++++++--------
 drivers/power/sequencing/pwrseq-pcie-m2.c |  4 ++--
 2 files changed, 17 insertions(+), 10 deletions(-)
