Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9453B6361
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716924; cv=none; b=WsmTPZETZjrlZ5e6UfGBwYPzrQFhdx+dPBSU1qOblUjeeC8wSrmeXlKoWehDaiSdVZTpZwaavQ7PEU32HQI3RgrLZ4aqhDIJlVoiQgvb2WThPa8eUTlogvRugSIFNVpQItQlThw6OpOC7j9m0V3i+QhMNyc9TkrHjH1uhufSLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716924; c=relaxed/simple;
	bh=D4MkQzC4e6r+xfiK+qEe+qqQEWxxVH4bsIqDfNAAFfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5p2JK6fCn5/KSHD5Q2BCiwf2h5lnm2hVItHaFKS/lbDfLjlazEnRUv5v4seMg/rqoXtsY+Gjk7uzsIJRJWL20rvv/71MMP4jBnKiEVgibph4drsErWIIIEjEkgPjjDhPIQDw41cFuisVd2/xpEE94zSubqNpdaKi53c4I1W3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JNeFBHDV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LoereU7W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JNeFBHDV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LoereU7W"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EDwxpE1852405
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 14:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Grmji2USRcszlNMGFmSZZQXZx3yzhaErBDz
	hawXe400=; b=JNeFBHDVyR88UCXquPbhGQ29nrAOjhomQ5p5W2AXHDgJIorQ4/0
	ctk3Y0zxb42OhBlwKhjfJgguvDC/Lm5Hzh/rwytjWFSL7szsgn4fv7dfnOhEUzJh
	uPzr66DzdoBZr4rniRGWOdlVr+M4NVviGAZyvwSCmNgrydYYTYZPBgQHMW2lSUrB
	+NX1rsEaJnrSLHZ9NWpY1xU6tXREL71HNIqq0Qe9f3qFlNy8s1MUzPP11W/VRNaf
	8wORhIW82uvm0cX16+YPMAG7N+oFKyMdmfBUYwlL+4jEX5iSwVe1FNxAfLns/pl8
	S8m/FSLFieV6cDIY52RYaLyWjFURrB5NdPQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g206398xn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 14:15:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52d7b3adda4so11430001cf.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786716910; x=1787321710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Grmji2USRcszlNMGFmSZZQXZx3yzhaErBDzhawXe400=;
        b=LoereU7WgfpU68IIHQA40QBD/JwxCmkl3lOFTs5TUM3QlGtQfRS4AOzjehgjIyBvNA
         oVO0HQo6epxX9ZPqWVXMPq3NWLbACsSpD4GNWyo3bDGguKfQzK/NtHHpWZkvvPCJjNjW
         wpCG1rdgogPvUQGAb2L0+ShHQKmniB/sM8Dqee4S63Y52X9JoBL9TlRZLVx8rD3cCCpJ
         57sNLqMyYsfw6fS3PKhHRdN3PcUjiUhAvaVgsgcutUt/NKQiiYHpbFlJ2E8FyVdv5hsI
         yvGJW9OdOQ/bHG2XlFVyS5x0Xyny/nvkDmEybmnK2sg+BN6QERFtVWIORk35mmxMidDj
         ziGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786716910; x=1787321710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Grmji2USRcszlNMGFmSZZQXZx3yzhaErBDzhawXe400=;
        b=K7o1ZUox4n9ht2B94VKlQZSAZ1ni5imLLOeTS0XbY+REGveMeOW+M8VXHfOKgxFLsQ
         NYrZTjN2S9NhANoiGfYqKzVssel9/jxhX5UQxhQMh+dNHTRsyqgUN81U9jJ4XTRdUwn3
         kCqZ21MHUw6Ip7SKCAbbeVGVyyocyLLaJJFFG8MEK29JMlli81mFXuOVQAJJpWZF6rls
         xdZKyP3FYXXGYYkedpzqWKHmasqPmxywMo71pyMAhXCjUZMLV3MvJz4aREtrhHBfbAjc
         7ss4CtTda2l0/jRbw0eujHIAJkKwpTcT+YE4VK9l1M8SMJ88rdtJxwWaAKgXN6IBxEUd
         744Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVaZQiuaMX+m9GKQUsgxVlXFMwJ02ChE1jde8GYjyNJP5q6xxIeQccsMi4HKFiECGsdH5Y3qfOLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtQLoQHYYebWyJEVjnIdVz4VWiwwyEngwGpWFG/PNA3JQx4ps
	ENll8OIp5uXbi8UD0nl/96FLXfW8U8JOibUWJ4n+wjNZKnzVlLydt8fxrBhF0DCU9eksfwvZHVB
	L3Dvv04r0421KITL6hPtnQpVJ+Qpc+Kjn5+/+hvzuXyCAAhiq6+P3rOyZscrXJw==
X-Gm-Gg: AR+sD11gC/5RsRtWBV3Fj/7lBiOkgoDyPo4Vyx1xYTbcjHCOBien1rZwmRhPB9HRgdu
	1b6yd3gbkz3FddO2GqAsYB1ted3/yj/EJbIxu677x5PYeXDfBCl4vi3vPDycClgxPA+HcB54b0n
	0dRJlmb95IMgYyjpQKTxzhhKKsj4Hokwr+jnfNsKo4MWHc8iSCdOIFpwv5riY/JbYFH/FP7PDLb
	F9GIGoOU948EFpNzCHwVZX02BjpF69FDkgsOLMpRpskO6jtcEHFuYSx44NSVPKXUPRrGSZTijBy
	8iw8c+DOdYq7BPvUAEesBz+2dm1Z4iZd25XGi83z3Fy2RQifN+Yjf0jOHrT9SKSuJR5Gz+OOITt
	cqbHH0blsgNpkef0hmevZSYetiGrvoYbzl1SmRz3qE7/11OziNklygSHDKQ==
X-Received: by 2002:a05:622a:410d:b0:52d:7b88:dbdd with SMTP id d75a77b69052e-52d85488733mr74098001cf.31.1786716910149;
        Fri, 14 Aug 2026 07:15:10 -0700 (PDT)
X-Received: by 2002:a05:622a:410d:b0:52d:7b88:dbdd with SMTP id d75a77b69052e-52d85488733mr74096981cf.31.1786716909699;
        Fri, 14 Aug 2026 07:15:09 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2123821bfasm107533666b.51.2026.08.14.07.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:15:07 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v7.2-rc8
Date: Fri, 14 Aug 2026 16:15:04 +0200
Message-ID: <20260814141504.127436-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEwOCBTYWx0ZWRfX7d1o3JVspiXt
 UrvpN4UbFytxaG7x6R8qPNDe51aB+F53rXqCkngplpHKS25725nzbylkNLvZbAm4vYLgHJ/4BEy
 E3rEZngQqblUegXknkpsuV+RnB5Jhag=
X-Authority-Analysis: v=2.4 cv=Z/Hc2nRA c=1 sm=1 tr=0 ts=6a7f22ee cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=eqoPJbdPTMY7M5JGM9oA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: M5LFwn4I8yV9lXvL3AV_0TwA1PyVh_5m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEwOCBTYWx0ZWRfX96aIw/qYxrxl
 80G+gDug26DqgiNvroXFXxXGr6j7n9qxA6G0shL9rgvYTEgs/oS3hbs6gwyh4Cmuwb7iSlDLLkd
 pSf/trxAd+zMD2WThOVKN+qGVt3X1cFhveQ51x/Hs9BOK1BPmFGnEgurfewTg4JKNjuyFPh7bVD
 W2hRaG1/VjQjo1x2Z/tPHPvj0KUOHUqDXzeca1vdnKG19D90N3agukfkXVm6+heqJCfCMy0wcZ0
 nHJI3hrA8GsqxshSris6isWKDGY804VemSo3B+uz8YV5xrZ3Wa8l5m/p4HDbNlFDNqW+wKDTamw
 13iFfzVgGkNy30CaoDmZALjeGnlfpTI8D+/a6IqeejRRVjDmw2sSqyjAAUghXnNz3D53tjAw3/8
 xQfUaDV9oIP61eBxBmhXQzBIO/lswf7tR38h120+3NCH6t/KMDZS1aAAil5YVr2ySdNORjDlJiB
 m+XFzJQEeA1DQwrJLig==
X-Proofpoint-GUID: M5LFwn4I8yV9lXvL3AV_0TwA1PyVh_5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140108

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v7.2-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit a4876f11aa1d076802676e23f8af500706e780e3:

  pmdomain: mediatek: Fix possible nullptr KP in HWV cleanup/on-check (2026-07-13 12:42:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.2-rc2-2

for you to fetch changes up to 090a95dbe13df9965279b588d97eda134831769c:

  pmdomain: mediatek: mfg: initialize prev_o in mtk_mfg_attach_dev() (2026-08-12 11:09:12 +0200)

----------------------------------------------------------------
pmdomain providers:
 - arm: Don't treat performance state 0 as an error
 - mediatek: Fix mt8183 hang on boot
 - mediatek: Fix potential null pointer dereference
 - mediatek: Prevent using uninitialized data
 - mediatek: Avoid setting RTFF's CLK_DIS before NRESTORE
 - qcom: Add missing MXC and MMCX power domains for Eliza

----------------------------------------------------------------
Abel Vesa (1):
      pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power domains for Eliza

AngeloGioacchino Del Regno (1):
      pmdomains: mediatek: Avoid setting RTFF's CLK_DIS before NRESTORE

Dmitry Osipenko (1):
      pmdomain: mediatek: Fix mt8183 hang on boot

Guangshuo Li (1):
      pmdomain: mediatek: fix remaining %pOF after of_node_put()

Karl Mehltretter (1):
      pmdomain: mediatek: mfg: initialize prev_o in mtk_mfg_attach_dev()

Praveen Talari (1):
      pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0

 drivers/pmdomain/arm/scmi_perf_domain.c       |  2 +-
 drivers/pmdomain/mediatek/mt8183-pm-domains.h |  7 +++++--
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c  |  2 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 30 +++++++++++++--------------
 drivers/pmdomain/qcom/rpmhpd.c                |  4 ++++
 5 files changed, 26 insertions(+), 19 deletions(-)
