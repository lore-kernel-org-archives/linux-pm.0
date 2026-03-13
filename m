Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5E381AE8
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393250; cv=none; b=WPIYvmr3I/9kZgu+KxTrccKGBVesftbiV4G7vmZyw1pmjSqxwxkp4cYhHltcFrkKXaA6in1b/rVWkg9sf+1MsSZ/LnuTkq2JH2AcUalEJTbd9nhP8LyAEr2oHWYU0rNyirMhEUTqPwKHwtdL7gQb6tDxTNzeJS2HouERU5eV6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393250; c=relaxed/simple;
	bh=Lx5WFue5oW4kfR5hQeh9wzc3KNwNxj5rAg2ypVsEJ34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QN74yLhSL4yL/Z41WdKR0JBGAtiA502wOBQtD+eNe0bZE9J7zuclXVS5mPCj75OGkdPTrLHM6SE98+5AIWyL9fbPYyLuiaRhZszG9d67vxpetm7TtAL9Vz05zR/Bboe3Xn6hWTbBEeWeZLitkvJue5G8oOMRFHb4+JvGK2dx0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TllV5Q4Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ixF0h3nG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TllV5Q4Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ixF0h3nG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D8vC8W481530
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 09:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=daSY9W82s92E15WYvw5c+gSlE6rIO09HFJi
	7OIZMsaQ=; b=TllV5Q4QNnDBrxI/j5Xj38EjqL1ZnZuGB0cxi3ha2tSDO7s8dw/
	IomdxDIcm6zyXuAluHHi8+U2wvMEzD12xxVT7nddt4R/ohUFhWsoOLJinf3mwTTC
	yTwFSfipcstOO28anHOsipylQpquNbyQEV+SJlnpoK5WtqhE9gsPuHHsQSVCj3Cn
	q//jbDt49u/aBVqlyA0iE1CzUBYfdZBcxSkN9Hze/ZWZBCICvkpn4sIftXnewIwu
	PZHVBBQuRGkFMbCXxaIJbrjL3Px6cQsEYOTXXfxip16bKWAI0mHFUTj1DZ8hmbvn
	nVE/X9DUs3LeEu6/RwiHozbY2Hz3Z4vL66g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfh7r282-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 09:14:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd83cfb36cso1372112985a.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773393247; x=1773998047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=daSY9W82s92E15WYvw5c+gSlE6rIO09HFJi7OIZMsaQ=;
        b=ixF0h3nGkJeX7uZr/oiSaaMiaI7QRf8n7iGdh7h62Frn31oXGTxBDWdyMk4lRCZe2j
         /qmppefdQtjauDoT621XPbbJoA2EupxPvfo0uAK/4OKXglcJ2xivPjFU71ntjN/GIRhj
         rerccI50d2KvDoHxS4KmEuCaEwF91Ozw9tSePn3zLqPCZAyE/UKfmdXuvF+rEU2fO14I
         Ctuaqf7kpm6Bn4BAP4PA+X4LzqoDtcpYo80zTLgSFEkPJeNy3WrDikgaQ8923fW6T6Co
         BNlpOq353i0+oCXV7S1TCgaiD3qK8axYH/Gt/YKRLV6MmDoeRrzPF6qfDiRMhzI92OvE
         u0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773393247; x=1773998047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daSY9W82s92E15WYvw5c+gSlE6rIO09HFJi7OIZMsaQ=;
        b=rIqBIHF3eOqY3rRbCsOe3YllOtMzQea7DLFfplftA9scMdtaE11WoP5+JNtVkqXRUd
         3XrFA+N5BFI/Rsrotf1EVnq17+JKE9doNGVz6PrGO6j4pgdUR6Ym3AtM8DZ9KZcFmMY5
         s7MapaKfxu7uOIsvigptihnuahTiPv+4HAHd8Eez697g8bXPnpYeVAl+1EhAEwHISWqt
         bBJcTOK9v+Px0BNA/d5ShcTm0P4+p5By76k4ODm7GvvO6XMSxAbsPqfU0ROuHGdhNe7z
         lbe53K9TJ3+dg5xOduJaFSFjDp9L9uYySMkjFI00WKL1awMXwHXzf2Vxan/AXHvMq+B7
         P49w==
X-Gm-Message-State: AOJu0YygdzfpvL+RZE01iZ4YsrJ0E5PeqyfjGxRAX8/0TgIB7ZyKFjap
	/HiPF3Uiqy9zpIXvL+GBDiJ7c+6Kleau3iqkhq/3AluWr+cbr/59OBvF8dQVG74Umi4HeEurSee
	PhyawYfVAYtSNIZJIrg62iSvltfGECRYYUatD+6iwN/TSWfrBoWQOMHQ7pM/Mzw==
X-Gm-Gg: ATEYQzzVl3ZKmdeFCjPwW4E9QODoZJ9h2HAYDF0xQmZQ/jLicKScZSqcxKgjIDPw+OP
	ZJ3TUyxEuVqLVy6FV12hILQ0wo+rZhrHBKYSCSzxvea1BC//b6q4JPESUgzfqvDD9AfugKRcWce
	6MWa8imL4Dwb9h5jE8JQS18mIeClDt/mLp8/2a4vWR9qGqRxO+w4DvouVYl8ex/NdkZxKs7Afm0
	LAwDSG7VWcGVFI7DjjHPLZdEbDelvqckeyQUSyki20UMSwXWRilLWoKtI+GjnwhDAKhxmiI17vY
	b6Ila7dEiH8LIRJSOrMUkEYsn2amQXKImCT2m8WL2SCmErWFSTpkbG1f+MhJTC/wbPGqSInk52I
	0FhiQL0C29mE67H6/Rtl5CY/BOak4etHYrYWprrm7HXmVG/e+lVI=
X-Received: by 2002:a05:620a:294b:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cdb5ba2738mr340466185a.68.1773393247107;
        Fri, 13 Mar 2026 02:14:07 -0700 (PDT)
X-Received: by 2002:a05:620a:294b:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cdb5ba2738mr340464085a.68.1773393246706;
        Fri, 13 Mar 2026 02:14:06 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:840f:d4e5:5fc0:62f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm14846358f8f.31.2026.03.13.02.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 02:14:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing fixes for v7.0-rc4
Date: Fri, 13 Mar 2026 10:14:03 +0100
Message-ID: <20260313091403.7973-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WU316XwOZD991TNo7YYnMWmOB-oLhpYH
X-Proofpoint-GUID: WU316XwOZD991TNo7YYnMWmOB-oLhpYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA3MSBTYWx0ZWRfX5jY7wnCGsi1a
 kngov+YJKlVDHAmlY4mhmrceOt6nQgHdJzKb8yqkKOj3JCz7oaNU/as7e+NRccOAR1De4Gce/7d
 DSyw+2zA/bFxn/kCX3A4rs4gTgrOjuwHx7ZwfnfHKGJEJ5IKdu/J1WAVsccg2O0/ppEfHAB5IoP
 VNK93OEDOes4uVeyyt7VJjOhgv2LjXVYXlVhin7V4VCdv2g0FogXk+nmMJhvEfG/fs1Jp13Qm3g
 6zLpzDYsCMLoKeMWoAQePjrl2c6IhMQUVyWL90G1ElA7Rws1yVXYc/zClJS61ci5i9C17gRivVO
 Ecr/9IEDhCcMl1HjJrVwSAcSk1rW9q2V/y8zI403XLhfuiwc0wU11c5XRrCBeeeLJ2VoevqFpxw
 6/CP98NBZm/h3q2VVVC2q04m9W63BcuoRkjykSe13AqgIKiS2DeVLX0+/CcltohKQTqORiFR5Yv
 jvpvma3k4xjoXWWiuBw==
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=69b3d55f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=BVoyThpuoFDG_nbEgP8A:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130071

Linus,

Please pull the following driver fix for the next RC.

Thanks,
Bartosz

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.0-rc4

for you to fetch changes up to 5c3daa5301693d2e5364483a3405649a0fdaed98:

  power: sequencing: pcie-m2: Fix device node reference leak in probe (2026-03-04 09:16:41 +0100)

----------------------------------------------------------------
power sequencing fixes for v7.0-rc4

- fix OF-node reference leak in pwrseq-pcie-m2

----------------------------------------------------------------
Felix Gu (1):
      power: sequencing: pcie-m2: Fix device node reference leak in probe

 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
