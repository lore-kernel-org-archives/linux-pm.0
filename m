Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80354A689A
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401763; cv=none; b=WCvEMTSamAy0p333d/SvCp/l8PWGEma/AXDJpAzBAA2p6ThO4fZNTNrFXCfmUo0IKZXQqxvu6fUyS/EYA4mpGCIXvCG15HLldzGTRqz5JME4unHFbh3O95Hd/oDLSmGpX8EalrRjCzwofzS4i4bHB59bAScCN9qQkAsrJ3IRdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401763; c=relaxed/simple;
	bh=boQWDQOzMeM0mYyxvh4btXSCjL15TxkCicZCdFTdFA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJ8Y4MElojqB4YkuBdZJulbwGqlbHJEVM5U4RJvkZHLZFf6GSfONzWzOSs1kUP+c67mvx5WabwwMCNduRl1rAd4UFhp+vz8VIOKYiOO0LefHyHkXZXrDQHYkaQhlxCFU1VNWDDsmIUQdT2LYsF5ZHUAqo+WaM+3La3JFfw/YtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7PzwB9+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fsFpbjOh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7PzwB9+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fsFpbjOh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OsiA1665655
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Tki311xi9AFNNmSdebNepUQk6gEP7uP+G+3
	OGUCHUjg=; b=j7PzwB9+y64ZYfXwMNhufxVxfSdNsg48nqLa+LRxAi3aGs3ouIn
	SVjvLmImBwJ2DHCF1cnPjzTXU96/Kmc/4N/hVIK8QssnITxWbHHiONZ2VqI+OyNt
	Vh5QTOwzPmrpILfyLGqKO38oEuHbWVfJ7wPvc5uMlfRX2jRQ14Py6cphHz1GoK6d
	J70Jzsi4IiAz11QuQF27/zaJImfciZdYOLla4tfwpe5J9srSafSPt33E582FGBTZ
	R2xglDVJvWipEfJ/+v4pQuLQqkWkrihN0fr61ZU730iYbPs5lEJeGswGgBGvP+Ji
	DU9lb7ErfQ0eGvfgWrnf9Tm5u96yESOHzAw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0bva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:22:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ae8e7e546so418734885a.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401761; x=1793006561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tki311xi9AFNNmSdebNepUQk6gEP7uP+G+3OGUCHUjg=;
        b=fsFpbjOhEv04TrZGDKrOrdpPbq2+qHUpp69JnEv/ULzmQszwKtULoabAGBocLVcZIm
         zcICC7/ZS0jgwjYhlIKYNFD5K+n315hlco/STsg1MnuprRV+e6u8T9FoLfIOQoL7CP5F
         NlE/EnmsdEvUgsZDKgnCWRJQCr/WKBVV/wEYAPbf8+xf79zukCQD4qWqIEUwCJNf7KES
         Cdg378QHRWH8Fh8EoVRqyGZuDqQVyPxUvGyApeIeeXTo8X9qWK6GgC/QWxtkzIv3N+Y5
         /0vJNgGnjiHLgNGlHqeoKqVyLZFaiKM4oFeszSQwmxwVhZq+r9nHFGP+YS1ZecnpM0lf
         An6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401761; x=1793006561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tki311xi9AFNNmSdebNepUQk6gEP7uP+G+3OGUCHUjg=;
        b=pQ8aga0WVPc4JUNeKvF1w7BvJDyPyyanpT57QMOB17jBu1BNeKMqawvhwhRDeyHTjk
         DHZ8VohfYItbsNTs3Sr9uYcKi93eNfU9SexvE+yfQX6zXAVd4vtN8vdzzrpSC2dsuIoA
         GoX6zbKqjMFLpJiLzDQIjhXGiKKyB91IF1vObCOtKLskhHdpontneDA0/d1vY4qhBtAj
         EFY3IxCGtVDGTJpNEOud1SXJC0fIUgTTsrQAkv9a8nMAOV3O9FyI7JuINYcoNDKpezoz
         xikneocBC83Abkv7crXPXEkuHx3JhHOrSeT3a9JGgAc6m8GrHMf7I2sIt1IKgDqK/VF9
         RYFQ==
X-Gm-Message-State: AFq9FYLe703E1PrSxrgAjIw6XNSYqmJiUqi2S9VrT0NFxH4CJ/iSvXrr
	D13maENbySUiNOnO0kaWE/pTGgIsp2aftgma1WqxJ2mF3Q3oTdMifF/B7CdNnhqTiLyiHQmlnxW
	NCqGPAQcD2kY3cclrW4SivyhIw72NptqEzWsTuv7BOzCeDk+Juae+l/q/7BXkYg==
X-Gm-Gg: AYBFou1hRZrvUFFKjOi3ojFBr8hxvBD92xJjwMKLK5/B7Oaeel72wPsGb9IsVu5vkem
	aODfo4JTsXF0dAtwSg9QDJKLZCtxwVZ/fBOeH2jQa26f1bW2Fm7Q3hNNBGs4ffSUfqOQc5wOwzZ
	nUYv6rsCDOVPnvHC1DLNGs908PW2mIMx7rifuthvzpGxXWpGb4oGvgG+Jl/PQ5hxWz/sOF8BGqe
	hv7yHXv+rPWORTHdLvSp8TLKvMwZhGFsu5psCM8t64zT0vH3Xx5bptCbh0iuGIlrc/vluzKXphX
	tM9IuVWmbOUjoScZVH/Z1JSY3RQUwKrrhoNorKCR9SV35yR69OR/c8nB9QMSmHfPtUJRhTVLxGJ
	TBFEgFOUUR8cddQnipjcdsERdR7A=
X-Received: by 2002:a05:620a:4402:b0:93c:9c0b:3898 with SMTP id af79cd13be357-93f29d8d9a0mr1029310485a.59.1792401760684;
        Mon, 19 Oct 2026 02:22:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4402:b0:93c:9c0b:3898 with SMTP id af79cd13be357-93f29d8d9a0mr1029287985a.59.1792401753709;
        Mon, 19 Oct 2026 02:22:33 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd47104csm24495771f8f.8.2026.10.19.02.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:22:32 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing updates for v7.4-rc1
Date: Mon, 19 Oct 2026 11:22:28 +0200
Message-ID: <20261019092228.11472-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX5Z/TWPAAJi74
 1Sd1pVKMBVHb+JQaFlCc1pCN6ZACwwEWP2kZepOnk2mChu7hm6r7jk0a86Dad8+OSmnEjMSevUa
 uzMiE4wcn6co5g2reFT3OYukma6ovxM=
X-Proofpoint-ORIG-GUID: UpEZ6PGVFHWYEuEAAgq0Z7rH6FDMn6Dn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX/mdtzfo5BSFy
 3dRy2jq31fohRTgsGCDjxF2KhUIHntbQQ/yXMWcfQSsFIugViLlvFjGOaYyyGEuJSNOT+ms+m/Y
 s9XyZ6g3PQVU8sNQ3FnKXOPwpeKcIOcRdHIM78QtrO698c5/3dHXnHIvzU54/qw6I3AB6yJOabF
 dYrs687HgWvkjnhQNeyzMvfGVdo+U/6Xf/O4n0oWTiXuXdcjcFBBRKbE62XkRM97ieVDZslkjN3
 8xbNTyYw9oSD03frt+S8MWxQ02/FaRx8g6BXnHTSsoVgqrqtOFJvoY3GV7YeMbntOrSPUWFeKk8
 8Uq1WFYcHhDu8AnhI/FTMB1Nn5eHO3WLS3xkt3ZUltVbMY6ANkDggxtmXk8TVjTTDaaJGjWN6IN
 KoouwHkyiLTmGwp6jNQA8p/NBsW7o0fokUop1y92b/KB6GI6c8FNVc0Ce75uFwiPbpNo9xbA2Np
 fHdWjTnHRwUroXOyaYg==
X-Proofpoint-GUID: UpEZ6PGVFHWYEuEAAgq0Z7rH6FDMn6Dn
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad5e161 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=YWQ44TvzZs1heh0XEmYA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037

Linus,

Please pull the following set of power sequencing updates for this merge
window. The bulk of added lines are kunit tests that comprehensively verify
the core functionality of the power sequencing framework. Other than that, we
have another pwrseq driver: Renesas RZ/G3L Power Ready and support for more
models in pwrseq-pcie-m2. We also added a new consumer-facing API in the form
of pwrseq_is_controllable() function which allows consumers to check if
a given target resource is actually host-controllable.

The merge commits you see are:
- immutable branch provided to cross-tree users of the new API:
  pwrseq_is_controllable()
- pulling in of mainline tags whenever upstream fixes would conflict with
  changes planned for v7.4

All the code has spent a considerable amount of time in linux-next.

Thanks,
Bartosz

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.4-rc1

for you to fetch changes up to eadea156f11b2c9a780b60c1699c2da145c9d1f2:

  power: sequencing: pcie-m2: Add Foxconn WCN7850 subsystem PCI ID (2026-10-16 15:41:21 +0200)

----------------------------------------------------------------
power sequencing updates for v7.4-rc1

Power sequencing core:
- add a suite of kunit test cases for the power sequencing core
  functionalities
- provide a new consumer API: pwrseq_is_controllable()

New Drivers:
- add the Renesas RZ/G3L Power Ready driver which provides information
  on power readiness for various IPs on RZ/G3L

Driver changes:
- use pwrseq_is_controllable() to report controllability to consumers in
  pwrseq-qcom-wcn and pwrseq-pcie-m2
- add support for PCIe switch topologies to pwrseq-pcie-m2
- add the PCI ID for Foxconn WCN7850 to pwrseq-pcie-m2

----------------------------------------------------------------
Bartosz Golaszewski (4):
      Merge tag 'v7.3-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into pwrseq/for-next
      power: sequencing: add kunit test cases
      Merge tag 'pwrseq-is-controllable-for-v7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into pwrseq/for-next
      Merge tag 'v7.3-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into pwrseq/for-next

Biju Das (1):
      power: sequencing: Add Renesas RZ/G3L Power Ready driver

Loic Poulain (3):
      power: sequencing: Add pwrseq_is_controllable() API
      power: sequencing: pcie-m2: Report power controllability
      power: sequencing: qcom-wcn: Report power controllability

Val Packett (1):
      power: sequencing: pcie-m2: Add Foxconn WCN7850 subsystem PCI ID

Wei Deng (1):
      power: sequencing: pwrseq-pcie-m2: Support PCIe switch topologies

 drivers/power/sequencing/Kconfig                 |   19 +
 drivers/power/sequencing/Makefile                |    2 +
 drivers/power/sequencing/core.c                  |   49 +
 drivers/power/sequencing/pwrseq-kunit.c          | 1497 ++++++++++++++++++++++
 drivers/power/sequencing/pwrseq-pcie-m2.c        |   47 +-
 drivers/power/sequencing/pwrseq-qcom-wcn.c       |   30 +
 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c |  142 ++
 include/linux/pwrseq/consumer.h                  |    7 +
 include/linux/pwrseq/provider.h                  |    8 +
 9 files changed, 1799 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/sequencing/pwrseq-kunit.c
 create mode 100644 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
