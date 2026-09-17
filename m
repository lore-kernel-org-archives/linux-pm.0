Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5CA4657E0
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637975; cv=none; b=nO4/bAzOR+X2CmLypeIYT1kfvqpqa6sJJecMFxukg0cVlwe9GAGQ636KDIOF3BYWCXPOkMVvEEsC46kM3PbzUpwFrB3cpQI5aFTRsr+sJSzXPnK1Qy5I5Wg8vGbKFg9xhpqPqAsgv9pkX1RdLkXBl4pdLJspfCe+33GIPL7CmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637975; c=relaxed/simple;
	bh=M7qWS8Mntg4zY/biFBjW4FSPXQVglxG+o4C8vOJhFKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtS24haEGCXcElmdwHB14yl4eqUjVG1sBsPwU+WtAshZqobKJcr0yJhTBKb47YOKDLG5HNN6UDT3N6s00EcMRurPgaFT+44pNGZCMtcx5ZYPL0/roJ9Hzk6jBg5mtPqYVMceIWxYOi89mm7CV5fK6vfLPNHTOztLrL3efTl4aqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E5UDbCPf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jhqEeRwg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E5UDbCPf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jhqEeRwg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9ZjJm1520180
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 09:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NHIFuCRNhNqful9hjhihdvKZtcjIXWTKtV0
	IPQv2lJ4=; b=E5UDbCPf07H3iXiFyYH2Lue5AM5u6wO5qXwzGh/AC54RpaYu3j1
	JhylSkXeEJuRbO9oIqqjSvThf+UJNzHsq2ixgKJ1YWzWCxzX+34XP8v2uIqrSKQG
	nbnWRmhthARS8dbayX68DiMxX+4tfP5TvmrZs327JQUaVk+twaWHJp36e3NlW2zl
	UO8FLJxfAF1tLzOSigrOOqVOBJc8Tr853gPClVCgbjHWL/pZbUsoWCGb9HqHJkXC
	y4FIK3afAXsJBjUQLQ87vDbAQFZpra/XhxLuVzGEZbrF+Y6ihd2Ye4qx+q1E4xH6
	YJ8tnIPemJEENXOstejnbuwaijJLTNmXdvA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7hbjmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 09:39:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a0b66ecd9so75033885a.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789637949; x=1790242749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHIFuCRNhNqful9hjhihdvKZtcjIXWTKtV0IPQv2lJ4=;
        b=jhqEeRwgk8+m8FevveCFAf/HG+iI6OfZ1IgL/f5q7VINZUPpRfcQ/cFP9gPKkHfEpf
         bP2GRzARYf8ioktV21ZNrxNh/Oux5pwlESwgn0o84c1+E8IK0S//VHWB56yP7ZrYST9y
         hAFbSdvqmzgCSGqcoVDTY1vRTVh3ixkoHY2FFMy4BMep90AVmTGhmYVBIWqi0yAQhYYy
         zzzC+pOUPeapY8+45YPMDmCsMMW4vGWUyLHjYh66yBr8hfIzdNd3p/HpL9+Ei8HiQhS4
         4G7RYyTlP5wHBlXCXD5fnfL6KBGbgF8THRwi78pioWN3tpV3apaqTHjMYinu0luncPCy
         icYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789637949; x=1790242749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHIFuCRNhNqful9hjhihdvKZtcjIXWTKtV0IPQv2lJ4=;
        b=wq131v8uQeG1rSDN/BpIHn9ktDMYK+O95QLtV8bfZhu8WWNibiulyqfrBOsFCtBTw1
         Rwg7chIP4kaZGGcAuu9fZ8Xf+3+D/MFjZs/gAn6DfSyfuWMU7tuSw+mnZmuviIecrts3
         2PxjyWeUPNbdzj5LQxrA+a4xMugUV+cHbdRGa9faWoNZpNwd1wprAiaBlyLFJtuCTRwy
         mG/qlfr19WO9bq64f9jUY9m7EjQBlapqc50imCj1d2b1ObmlWUgp8U7HURdGRtYBL8e/
         zkmA5DpKEz3nkvAu4mELju66cDjkgpdp9oJHbt/SwcTqeQzLUsG0R2uWF42wy14S+dF9
         TMqw==
X-Gm-Message-State: AFuF++lA6bfa2KtyJJ/H6OPc8M5DSDNWnHtqBjZnZNdMwShi6n5ASQF7
	3W2S1fZi/8ctwjDJrP3DgrFxJbHWdm3G8a64a8VhMkUgn0hyyPA8/GVDISEsD3AfB7zF4gXiS+O
	HlIflUCbht3cdTmdyB9EnPXdanR/Q8kataX7LtK8k9JQsis1+M4NQ1GlVI2lHAQ==
X-Gm-Gg: AYBFou2vNPjn3B92yvwYT4p4IBhpLf4xk/3Qpem2MZvWa9kYkeWIOh4upQVPZswGhtK
	OgmQMDR1VoFgZhbDSu2VcXqOW5M8rGsaoeLg+1VHAoxjTWEov4scgKngbZmIEi6qKb+/c5Qik+H
	pKb6+XB2tseJR6dlV5Bp0v9AgG8kRhOQ5cuNi/Qx0wJI0JLUobhPp1OXKntYiEmINMmnkuCXy8Y
	uq9fJIQY4RWwymicGAYDTb+6eCe58dn8cby1D+YuQsWMNEZZoJ/jU002moDROif+Q2fvOrpCIPp
	M1JrP/SKQAvMAkxPfB43svzvRcVsbIC5WviJoUTiE7DqxcvAQUQxxxDdH9rBucsjGMXfos/XN2w
	Lpe5EnDncP1h49zMiXmGC4JKOuiQ=
X-Received: by 2002:a05:620a:4804:b0:939:57ca:7e06 with SMTP id af79cd13be357-93bb76bb33fmr841369585a.9.1789637949615;
        Thu, 17 Sep 2026 02:39:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4804:b0:939:57ca:7e06 with SMTP id af79cd13be357-93bb76bb33fmr841367085a.9.1789637949191;
        Thu, 17 Sep 2026 02:39:09 -0700 (PDT)
Received: from brgl-qcom.local ([90.161.207.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847eab65sm85288425e9.2.2026.09.17.02.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:39:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing fixes for v7.3-rc4
Date: Thu, 17 Sep 2026 11:39:04 +0200
Message-ID: <20260917093904.6692-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEzMSBTYWx0ZWRfX46yXd8oaZOCF
 diFfnIbzCiPJpqPraFDVapzgn62UOdW5siqsznA/3i+uWsjfA6QmZ/T3sFGsQSclZke3m0iij8N
 RiYyrO9s+kn8dBjWbhmCHh4R/ZcGRZQusR59VoP5KtfbZ4n9neTaW5w2/jeUqw/jBbCFET7qXjT
 1/9bepGkOVBBeQW3jN3YDgPp1V/aEHTEmhFnJ5Cz9op1banhUdulTUiU/WuxOp67noG9ZFWXTTz
 v7Ks5adi7FjFNvFY1z7S6s0kKH3/0cKxbNZLKdMEYwft/wGvCMuh2H57GgMS1IrCYzJzYMfFxNZ
 Rf1jovmRddDdxVbt0OLjWxXrxwqy6vrJiC6sztpR1xzuDZCb41BXqOIhiG6TKSdJw57A4LNwrtj
 ZYk7L/RtFRPFlCCJ+Rev7wr/K+Oh8zxYQyY2l0vMHWM5XsPsADgDOesWDB4GKT/QAqgNao1nBy8
 ZyEGiGM513yWQyurp1A==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aabb53e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=BQ2oiuy6hHN+kKmom1QVvA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=9XGRkNYMzx4ocYpevGIA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: GMjEUAclKww3QrPWAqZnCjzUs14YStZa
X-Proofpoint-ORIG-GUID: GMjEUAclKww3QrPWAqZnCjzUs14YStZa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEzMSBTYWx0ZWRfX5hyp90U2gM73
 ESAjuF7ULuoOhVT1b7NMXPZBsrUmKBp2G0FHQLS1xpTmc691nXZ7wBOdg243MVUrlYmiB/J58N1
 Tj5eTGKzQYFl3lKZ+A78xAGFqME9UTA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170131

Linus,

Please pull the following set of power sequencing fixes for the next RC.

Thanks,
Bartosz

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.3-rc4

for you to fetch changes up to 242da4318d97380741516b595af3920207b2f0f1:

  power: sequencing: fix NULL-pointer dereference in pwrseq_device_register() (2026-09-14 09:26:30 +0200)

----------------------------------------------------------------
power sequencing fixes for v7.3-rc4

- fix kconfig issue in pwrseq-thread-gpu
- fix error path logic in pwrseq_unit_enable()
- fix two NULL-pointer dereference bugs in power sequencing core

----------------------------------------------------------------
Bartosz Golaszewski (3):
      power: sequencing: don't call .post_enable() if pwrseq_unit_enable() failed
      power: sequencing: fix NULL-pointer dereference in pwrseq_unit_new()
      power: sequencing: fix NULL-pointer dereference in pwrseq_device_register()

Biju Das (1):
      power: sequencing: Fix build issue with COMPILE_TEST

 drivers/power/sequencing/Kconfig |  3 ++-
 drivers/power/sequencing/core.c  | 11 +++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)
