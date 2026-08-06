Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCF38550E
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991362; cv=none; b=neX9CkWNTdLaz7aAeLr97Pd8Es0bSIvRKHRTXzvFwvNRKhLP9TwKrO6sYfG2YurZlJHFOBSmxfnHmmq46A6f1HEx3vs/HcS4Avw9Iima6FVxafAf6odK2ZPbw4KOssQ7ybDJdK1h6MRaNntw40U7dOVw6qOMBF3yXjrZlZdyIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991362; c=relaxed/simple;
	bh=y60PM7shWIfnAog1HGtuhVVErq+xQPRXd3bT2mw3YH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YaxATyceKFPGg2TdQcWdH3P7BySsab6xWn7LYtyIerZQyH4PKJXampAAtdCVpQcIwJ33/A3N9w9+yFoGatHNv08HE63y4KydsZOn1YEKByKlgsI31jBC5QSgy3zsMc6YiNWRiPY4tkfUPKF/Z0OAvH+m30u1/HpVgfrHL5fK7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aE+SgHKc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TpjBPZZh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aE+SgHKc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TpjBPZZh"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NappS1354144
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 04:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=OxkpP+B3KTOEth7pSc13tmMtbh/LvC35eqY
	3CGywja4=; b=aE+SgHKcjayy+xh1htUtdjVX0X39Q4ff4on7gVs96TtMyu7wUCG
	K4JsQOGasZuG/Hj85UlgaGk4U2NA8uT3HaBb5TqsCBjC6PaVmsDM1ZpmzprgNjIi
	xPuRUK7ZdZCCmoSI/A01RP90iw70xHFKuHu8Pc65aeOa4IGrbFhuc2uAWDPWIKbA
	cM4hXMIc0/EingqWo5g77tXhd2eLh1/BxPOPsneDE+ZeB5wHUIVbScbcHWsanKMk
	JtLb4RocNKKXzzNKfFLjON81kXSEi3IPwVvtsbzio9BzgWKSba0VOGWvi0agTTXU
	L6IFwhN6GNKVfG+MfhipIV8woIdHCzDPf7A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9dmja02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 04:42:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2672327a91.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 21:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785991359; x=1786596159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OxkpP+B3KTOEth7pSc13tmMtbh/LvC35eqY3CGywja4=;
        b=TpjBPZZh+yvGSKsItJkypcfzI7qFg48Rqtv9roCl6UeS/MmU59AUFk+ugwJCA0n5Ml
         Xq17NBgoZpx22M3ZGsuxNpIKaynt6x0MZZCunxSabUvxwgo9ZLSuIYQ3m0nw5rOTasEE
         01wSA58cK4NuDVF89ZEDMp/Q1zP2uHcCmV059qV7KCyITMIfAq/WzcAq7Z8k/ZxeWaPg
         1sWbeTVR9UgnI4N4qIzqOAjlLBT2rnrjVLCmSFoML6+vjBy9s1MdEWymiwLzirh//PzK
         OjxIHC9Cu6Jf6GMn4nbAYLXhz+KVt+ErYZAY/7yFkkm+OnI64ebygduoau0euEiJgmTo
         QdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785991359; x=1786596159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OxkpP+B3KTOEth7pSc13tmMtbh/LvC35eqY3CGywja4=;
        b=oEcsTUJ8kC5OidkgRBwlk29Rhxvzl3EBxJlnk51AtClEnXgRJgcuK9NVYME8DgrX0d
         SS7elExh0J54DFtBLz9WDU2ihd0CIYIdIMRhDrXfrWgN6VlU7f0w2yKFscs1YD8iP+QD
         H0+0uvZ0W1LUv7jS+1bUH2At5qI+bQaLjwDZ1i7h7I+O1IKjHn4rf/o8n7CRdiFk77Su
         qK65h7gqFRFMhg/tJokj1G5ngh/rU2LvPNhD41VNtMxHPzEFT8RSG7AWuj9KG2F35sQc
         qO2lflHjvVp4rFfRq9DozfLog2wc92lNbIkwyIg7dPwA5BV2WIIeC6OTogjODYdnaVHR
         aOzg==
X-Forwarded-Encrypted: i=1; AHgh+Rofo8QccoBRoGAW5opOFedTcTUQfbB7iQPGzrXY95p4t7+tA0FqiCXx00RTlYUiW3L4UXu2ipUyNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeH3+wUlIVPzPBKcOYuCBZM24w81AGdn2ZWLfEbLD3VDPcdPhu
	YWFDfscsQM+UQ0fNtl6LmZ5awI/TaLE5JJnMKKJlksqQwCPIPEU/N7GUNP/7n5TJ9gkdOlX6BjM
	/v8FZOJu3e6TpWyTfjsIgeyQKPsxOIYENEC1McZoc8WWWTrEMmgldy3asLE4jBQ==
X-Gm-Gg: AR+sD13p5BhzjSEGY7mqrXi8hpklgGIocrGekOFjmZL8PvJlb1QDDt/5eWP80vMK6eF
	SKpxaXvSelK5ueA1XDytnBawtfdYXi0MY2NYEBVYV6bCJqE5oAZ4Pko8ZocXLyh8jOQ+UlQD1sV
	4csf0LHNC8zyYOQMnLL5Em7lL5PK0eZ+FnTlZiO23jR/I4e4BtAbH37/piaCWBRIpqmx9zbq5zo
	vSHlXf1LJwfTaAOd45pILUKxsxU4D+YOsdG7ooHrBQq/zrIau6fV93fZQK7+2rbnHRhIPavhxeh
	8ue2yN7yafxSDzQJSP81fEVT8gGi79zIa11s6TgJMEQJxpuOgvvUl36VpfgbY5LexcvOr4KbDMA
	AbhlSPeph/jfYeDupjY7ea868aDMqY9zKF7fBhj7j5hdoonpHbfNX8XUGM6PclcsFFC2Oj0Am0y
	/H52/l+J/y61YbWdQ=
X-Received: by 2002:a17:90b:1c84:b0:38f:1e1a:515e with SMTP id 98e67ed59e1d1-3903c5b1688mr11080974a91.14.1785991359085;
        Wed, 05 Aug 2026 21:42:39 -0700 (PDT)
X-Received: by 2002:a17:90b:1c84:b0:38f:1e1a:515e with SMTP id 98e67ed59e1d1-3903c5b1688mr11080946a91.14.1785991358663;
        Wed, 05 Aug 2026 21:42:38 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586402e53sm32643473eec.11.2026.08.05.21.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 21:42:38 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, linux-arm-msm@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/2] sched/cpufreq: Fix schedutil's boost frequency handling
Date: Thu,  6 Aug 2026 10:12:28 +0530
Message-Id: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJR1jVla c=1 sm=1 tr=0 ts=6a7410bf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=u79KipZrAc_WApTfGJkA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: V3yZNA10S3HhNZSvP_4Eg25SAqNxojRn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMiBTYWx0ZWRfX/76wcmaPH23D
 A+PdPArSD6XBc/29u0I3eXGIcldxikFrudPqpTA15Gx6uCObMPZKoWKlEZ+PzRPV8Xnh59+J9Sz
 nux6z/rub4O1PmjpWiADXZ6bFTXh5h8=
X-Proofpoint-ORIG-GUID: V3yZNA10S3HhNZSvP_4Eg25SAqNxojRn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMiBTYWx0ZWRfX4fLyuXyYwLcu
 BIgOY61uJ35t8b8L3QMBJ+gPkB4RAc6QxF4Sq/fWyXGUcCY37onU+53vUCV8JZYxyKf5FefYfIp
 3trXFx7Vbs1GXRRaN4WlRAbyHhKR5wkFTxH7RDXx6geOkhxzTuHdqe7PAMf+q2aNWRoAChat6IW
 JpdiygfsUEwPilnif5DarYQD8DCqplss1hn0StU4tyXweGIiFfA3wr/rSig+tPqtjkXG93bALtV
 71PiDwSPEXRObrZLU0p5CEwiyPEsov63Uh14f8tFR1JKgVRVp1XVSIwByZoIl8bKBVVd1XLNIpv
 dtXAapMerXFKG+wEpKlbYrOCanedmfi79oTKk4LrlLWF+BHI98AAyy3eNexIJlB14TM4uQueou8
 Ler5s9+t/g2N6BZhqoU8ebbqFfc0HeJye9myJPTttqCzd4V+D0BUJ+fmhsPnSN+twED5EIjC7Z/
 BK/E8t6E/+6uEHE8yrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060032

capacity_freq_ref, exposed to schedutil via get_capacity_ref_freq(),
was introduced by commit 9942cb22ea45 ("sched/topology: Add a new
arch_scale_freq_ref() method") as a fixed anchor that does not move at
runtime. However, schedutil uses that same fixed anchor as the reference
plugged into map_util_freq() which saturates exactly at capacity_freq_ref.
As a result, a system with cpufreq boost enabled effectively never runs at
boost frequencies under schedutil-governed load.

This series fixes this by plugging in policy-max into the map_util_freq
equation and allowing cpuinfo max to fallback to a non-boost value when
disabled.

Drivers that rely on the current behaviour (upward bump only) may be
affected; We should handle such cases in the driver side without
breaking core behaviour.

Logs:

# cd /sys/devices/system/cpu/cpufreq/
# ls
boost  policy0  policy12  policy6
# cat boost
0
# cat policy6/scaling_max_freq
4454400
# echo 1 > boost
# cat policy6/scaling_max_freq
4723200
# echo 0 > boost
# cat policy6/scaling_max_freq
4723200

# echo 1 > boost
# cat policy6/stats/time_in_state
355200 36958
4454400 650
4588800 0
4723200 0
#

Logs: With this series

# cd /sys/devices/system/cpu/cpufreq/
# ls
boost  policy0  policy12  policy6
# cat boost
0
# cat policy6/scaling_max_freq
4454400
# echo 1 > boost
# cat policy6/scaling_max_freq
4723200
# echo 0 > policy6/boost
# cat policy6/scaling_max_freq
4454400

# cat policy6/boost
0

# cat policy6/stats/time_in_state
355200 40147
4454400 79
4588800 0
4723200 0

# echo 1 > policy6/boost

# cat policy6/stats/time_in_state
355200 44834
4454400 93
4588800 25
4723200 569

Ananthu C V (1):
  cpufreq: allow cpuinfo max to decrease when boost is disabled

Sibi Sankar (1):
  sched/cpufreq: Update schedutil's DVFS request to reach the boost
    frequencies

 drivers/cpufreq/freq_table.c     |  7 +------
 kernel/sched/cpufreq_schedutil.c | 13 ++++++++++---
 2 files changed, 11 insertions(+), 9 deletions(-)


base-commit: 0f6da28aab51b16762ed82e8fdeaa5042da45b08
-- 
2.34.1

