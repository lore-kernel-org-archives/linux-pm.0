Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928359;
	b=cgZJlOsoXuHK4h4q800lj5ZFmWeyxadIoqlQ7Odcc/BUfIm6hyZXnfQF5fRFzT+TUCgH
	 e/zADd5+QSUvVODKRdJ3+UHmmVHyd/NCB7ElMlLzhH+TovczS0rJXrGUXpdptzawsgZaT
	 DFzAea8VmlHBTRCtlmyPOp+7PX3RMtxJ7AocslIV+DbFkwTOI4aZo22PayJlo43w73bSw
	 vGPiVNTVn1rbBe7lAoKo2vMGDtdknz00Mh30b0726doih5RjJ8zwXidiJpHy7/qUnjgWC
	 BlurSxuBPLDGK9EYTxo3QD6gIaJNnAUfYGwaqkUD0vSrltIc4xzfXCj4llqmTXIGzSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928359;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yfONaqddD8UXBNocHwtt7Rf4SRNKJWwYuslLBqBQeEQ=;
	b=bLeOQp+ESXIJrD3Kci68IQQUHsjKg1sPb8J5nlqd8a0ztW74KBmRuCRBGYFjzKzoUyo3
	 jrKTtDbfNVvefgnlf0R0QyK8+jSh9clvYtMMHkLR4E8YsTXoOVXWqOYvG4zGO9yr0lHmX
	 v/SnuQOq1wUvZCdkTixrwx9kbvOj53mTV6UwIalsnLRaLreQ6pUogfsu98gvDoFicPSgs
	 kcqvtA+I4PAbTOmSFN8jBMhuuZtU2u0TL3G7Nf6c41bSDXw6G3SGMY1MRudp62rKNSftF
	 ZxecplWHYuz6GHolyDyww9OXfT8e/3167cWfJd5xASw/Mb7ZynlegrE4vfoyDW/EKGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lrz6+fZE;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE6606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 15:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lrz6+fZE
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHBw7WV2303915;
	Tue, 17 Nov 2026 15:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yfONaqddD8UXBNocHwtt7Rf4SRNKJWwYuslLBqBQe
	EQ=; b=lrz6+fZEdhINGqC0ptja45j5pUhPuZMfnYFuEP/xre+S+7wUkSFRWxoRo
	qf/YEyuF0R5qFlKfdqi9hUqs23mjI3+5BkrazclzLLtak+yDwN/S75MBkbiXk7O3
	8CZmjphrgs7T7uAkZR1oGNWtWb1LEBl6bxTcF/wuDNXOJDJX2PVIUXjIN2aIewRD
	2PxTPqHhd1ZoJAObMX/l0tgIR95yfYSZtPcIVHiq0UFcmMq1pxvXJXkDR16Y7AWm
	CsVP68sgYWHoK3ods5xpsBw3YQC4BVoed4t7uj6UKQQ/wOZC2LoDgsUjbC+KXkNb
	PXf+yE+oM4kJDsLw35IApeEYdoiXA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf9vk7wg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:12:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC4sR11803092;
	Tue, 17 Nov 2026 15:12:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt4s3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:12:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFCRti48431552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:12:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97FF62004D;
	Tue, 17 Nov 2026 15:12:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D55C120043;
	Tue, 17 Nov 2026 15:12:25 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.181])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 15:12:25 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: rafael@kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@kernel.org
Cc: sshegde@linux.ibm.com, christian.loehle@arm.com,
        Yury Norov <ynorov@nvidia.com>
Subject: [PATCH RESEND] cpuidle: Use cpumask_intersects_and where applicable
Date: Tue, 17 Nov 2026 20:42:18 +0530
Message-ID: <20261117151218.731219-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hqvCSNb1nZEf4Ev2ignstIOtqwKni5wa
X-Authority-Analysis: v=2.4 cv=dtxOmFg4 c=1 sm=1 tr=0 ts=6afc6ede cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8
 a=ti0QXwtRaSYbIWswJqAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1OSBTYWx0ZWRfX+2USRydybPOT
 UQ008/7LBgUKNp+DWe06nJxjGSGFUb1yaTDf1Cij5j+6peGbY9gspdyBgeKCSO2lJq7/DiEkAbt
 GHwhRGpVSxHRFQz2bzC15AQ3QEchczZ55CRC60eEdAVzEXZZ/bTeuhphZl+AyFTJOncHK+ryCAy
 gbTP09ZJA8K/+sAllO7yNAscL4IYe+b/hzcJ+BhviduwMWbQ15r3EUOIuo8RQ6Ta4cHA+NmfXnh
 /9W34Sq5yBNG0aFTUtoWe/BStftPWKgxzeZnNxH8u0SetlDys7rMPnUoSV94C1IAQYJx5cn979d
 i7AWpkJMycLpp+e/nnIlz4LxRQuUBx3Za05k6u8EWEqyL45/3GcoubergV+HXhg0mPfMQmhNjAK
 WkvWten+CZ9hmTBSS3BDECGtqjwfLLeqUSEXsfurHyYRrzYeEnBGp8Ttb/NiO6a5sLDZpmP59q2
 BHcHfMjqRnXvCkYcjdA==
X-Proofpoint-ORIG-GUID: hqvCSNb1nZEf4Ev2ignstIOtqwKni5wa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1OSBTYWx0ZWRfX53zOnFVdWZhQ
 zqMRtkeqAeW+eptLyOKdZs0orxYIjO32SBdAdU6sWzWeFfcl6L+XZDZhqBStWEz938mDpG4me6h
 yZP8PPMM83F6h4oq3GE1+UWP+Stfblk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170059

cpumask_first_and_and returns, usually the first CPU in the intersection
of the three cpumasks. However, if the returned CPU is not used or
only to check it against nr_cpu_ids, that implies to check whether the
three cpumasks have a bit in common. I.e use cpumask_intersects_and.

cpumask_first_and_and uses ffs on (addr1[idx] & addr2[idx] & addr3[idx])
whereas cpumask_intersects_and checks only
(addr1[idx] & addr2[idx] & addr3[idx]).

So replace such an occurrence.

Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
This is resend of the v1 series posted as independent patch
https://lore.kernel.org/all/20261111075945.3930230-1-sshegde@linux.ibm.com/#t

 drivers/cpuidle/coupled.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index fb91a9e0e3c2..40db5c86a466 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -439,8 +439,8 @@ static int cpuidle_coupled_clear_pokes(int cpu)
 
 static bool cpuidle_coupled_any_pokes_pending(struct cpuidle_coupled *coupled)
 {
-	return cpumask_first_and_and(cpu_online_mask, &coupled->coupled_cpus,
-				     &cpuidle_coupled_poke_pending) < nr_cpu_ids;
+	return cpumask_intersects_and(cpu_online_mask, &coupled->coupled_cpus,
+				      &cpuidle_coupled_poke_pending);
 }
 
 /**
-- 
2.52.0

