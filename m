Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0423346E56
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027271; cv=none; b=XxEl0hse8u9T4Z869SU3TxFd00MTmTWv/H4DsHRTxclfWlUnDqiKmj/RnmgplIZDuuvjnjnfPxIMldUFpzMTdub5cBSValogN8OlUCvxUBM4kaRnNtrwci9/V3zX/fPRj4nFxGdEMKZQN1GiRVLXOL97gQE52zebmd4MKwgc0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027271; c=relaxed/simple;
	bh=2vEu0FMYjbU3hCQR7oBHMixia2zkpzxyg0rkOUGp7fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBTQqXtdNcNtuMQctkmtO4h5Q2wxIGpKLCfuCKIkaBlUCZ9CFimhW+XBDn53v0Nz8IbUa+pIIVO4n1ypsw1LKQq5RfDW6peUTA5aHhVROnDzvRF1Aj+pVOE+9quVXY0yE2ZCNkrkbe9rzxlL4rB+WuseQ3wfdU3HsF7PfZdz4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NxQCeHfe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Emo7kXVK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NxQCeHfe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Emo7kXVK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6312MQ92719339
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 07:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=22A+Sj5chUc1iyVqke9i/KwfXM4BVovOzih
	XMiqpqQI=; b=NxQCeHfeNLOCx9istPa04KOfV0L7++Z5drnpxa+rK4BKxN/bo8L
	MdvhBKm7g7YIW9OrBZKF0BR9Ns5JhDmZthaJPrdZpRNrMqTlpNinCGfB7F8BXkt3
	OTeosUc1hjaef7vOFG015DdKMbsCoHNhgasgjX+Qcdsg9kKY5O+AizQMU+Encrvz
	/wJh+AJRkYipbyGjvzAIfwIP+/rnXspi7NPCCEC6qfifqB8hF5z1qTHVhWko6aZH
	Y18R+jUrlpN3CG79JXt0UVWR3XzdH0sPtoomVgRRQk+LDfgmDprOxamLkJe1Nipm
	vj7Nv76PULg8AEXv5lCkgQOsoECjts4iTvQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kcstr5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 07:07:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35d96923dd2so4352359a91.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775027268; x=1775632068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22A+Sj5chUc1iyVqke9i/KwfXM4BVovOzihXMiqpqQI=;
        b=Emo7kXVKHfGIvuTymLrps6hca5bKSk69ZSbyJji3VX34sayeIRytZ+p9rBWiC9NKbk
         oGXfOE950RjgBhSRuAIje9GwipCh31heEg/xtCOq0TKC5/IWmzNDy5jbfiZqhpjXo/ZQ
         Hzysh8o66NPEFYmYMDgz+1qQwhcgJm1n7yN1G826youEebOYb6PcF1qc/pizjXU4YkpR
         EoUR/oQYiAquZzU1OYTQDlmEzGiE7GvwSOoiqG0lUPpwsKjOjTAZImQqQZWWHTo1q9pd
         +JHN9a7VrboEM6TiQVuJuJZGDFJj9YkO65ptBCav8hZ3N71tb3H5aCUUaFA0iy44QXe8
         eDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027268; x=1775632068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22A+Sj5chUc1iyVqke9i/KwfXM4BVovOzihXMiqpqQI=;
        b=n2jCsnTGcDjiCYbn1UOzPCRRCfz3pXxLBx/eBR1WRbt5OYjE780xgONP9ofEHmhi0Q
         XPpCrlJSM83O6L5fXENSyNswIfo5FnXrBuvVaywxm8M+DWc9j/rXAEV46C9+RtZ/ipSG
         GNIJns4wC36dcJ2RQVTEQ0faTtEDEknbgH3CPSkMcJJNX2u+FAubM+bqRApkxmGsZgFE
         I4kHd5pal/RYTpPG0INtgfFJcr1CJzaAenDPokphSW5xIrxFTJoKm/whw+5DkU8ePi71
         Qe9mw3jX8STLxSlgw6PDW3LUc8G6pLnV+Keb1W82dtrsXcHy7qGP0SWC014+z/8J+WXF
         GquQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGMgEW3XpyWrns9xpkrtA3nanqSJAr1Wy93ayq+GliZcHwIJMDHwC7FTRAjsrv+dSbLWEQQEjtrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbV5QBJBmeXUnWPsb8h3CbJnsfUGilUstI32BECtf9GDrw1k/
	BMEd0MwxQFeXhltllOlTGb2WIqmwS+ST0R9ljS2NKlYHo4xyf4ViALtpleMaFI7MWoc7OV86An8
	Iai9XC+YB1NknBnBdbC/IqlWGmiU/5lD4GxZkmA1AN59gImYMOy4eqxgPI+EYPQ==
X-Gm-Gg: ATEYQzygo2dPb/e8y8Gt3Pn5pqsyPlrHI4HdlFaK81AMyb26TUf4fi/yOz5LdzPNiN6
	cgmPbdEWleNIabl59sKBCCa//bK4R/WYuriaMVTC+ozMO10tiLL14c+kTWRDyhl1c7SkLtYMz6v
	4kIcy2MIJqcNyQCsm8Bzs0Z8kPA6WiqRoTWSUSc383CTcDjEAfN7QZcRbd+bjFuSXQRa6QgP0KT
	gdoEw7xckv3fKH6lhG9jwxrQ/UjZc1aaFf9rbsLOR9Ci7jodG5HbrCXT1dTgMoJb02JjuMKx8lv
	T1Qq5t0pL6gBvE+VP+oG6CyRBChdcayKzg+HtOBhqRBWNY78Sed/e4Vh0722doWH41KOhJoNJnL
	50+hnoxt0W/IYvS88RT+ZAWyuMv+MAA3CZC+0
X-Received: by 2002:a17:90b:33d2:b0:35b:e4d8:bb10 with SMTP id 98e67ed59e1d1-35dc6fae012mr2416062a91.14.1775027267912;
        Wed, 01 Apr 2026 00:07:47 -0700 (PDT)
X-Received: by 2002:a17:90b:33d2:b0:35b:e4d8:bb10 with SMTP id 98e67ed59e1d1-35dc6fae012mr2416032a91.14.1775027267407;
        Wed, 01 Apr 2026 00:07:47 -0700 (PDT)
Received: from work ([120.60.63.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6e2fc9sm3956464a91.15.2026.04.01.00.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:47 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: brgl@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/3] Pwrseq/serdev fixes
Date: Wed,  1 Apr 2026 12:37:32 +0530
Message-ID: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MSBTYWx0ZWRfXzHWNyRS3WWNL
 ins7Qr+/hL2XfEk8t85q7+r2Jcr9448z1Ip+TfgBtxmtBxSeh/UnOXoAb/BoY1tLgOBl5feOA3X
 Qz4zzseZcpm3b7WoNYl9w2I7fU2Otr/4q5kaBAFdFOclob3z6RUUjRoshY0uRiQ+T8iEdvmv0hj
 RUyUwN4P9BeuqdzVW5wr1qEe5T184T3udyZ05gCMpglj2PiQLhxIndpdUZzQLlboopkHlhHYKyL
 XqVqzG8pZHbWJr6+RGzFcJk1XWlLBiUFruy8C63TcxMVrN6dwjlN/ecGW0DodGUnXLLZUn9BnQU
 tvvwpOz0AdvigO+gQ5ZVk/OALH7N5FeYeIVWraeIEZKfZ5ujl35m8OpY4Fuh/qz6D7Rksf5Ya6x
 xZCdnxfLIRXU1myZ3rHyc4o/Q3knfAo4AHWrUsWzUsIUF/ChgyJx0AGRzHnkteWRJ59QRGa1g0o
 xf86ybTjDWyobUerA4A==
X-Authority-Analysis: v=2.4 cv=KNlXzVFo c=1 sm=1 tr=0 ts=69ccc444 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=zTATW481NYPnotdwU90osA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=fsC5vgmolQPFgTpzX2QA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: X-wFfwsoUA7Ey0AvxIO5_sfQk2rQE_wi
X-Proofpoint-GUID: X-wFfwsoUA7Ey0AvxIO5_sfQk2rQE_wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010061

Hi Bartosz,

This series fixes build issues reported by kernel test robot on the recently
merged M.2 Key E pwrseq series.

Patches 2 and 3 can be squashed with offending commits, while patch 1 should be
applied separately.

- Mani 

Manivannan Sadhasivam (3):
  serdev: Add missing stubs for serdev APIs when CONFIG_SERIAL_DEV_BUS
    is not selected
  serdev: Add CONFIG_SERIAL_DEV_BUS guard for
    of_find_serdev_controller_by_node() API
  power: sequencing: pcie-m2: Guard the helper functions making use of
    PCI bus notifier

 drivers/power/sequencing/pwrseq-pcie-m2.c |  9 +++++
 include/linux/serdev.h                    | 46 +++++++++++++++++------
 2 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.51.0

