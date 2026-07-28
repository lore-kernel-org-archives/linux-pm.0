Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C97F4908D5;
	Tue, 28 Jul 2026 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206950; cv=none; b=JDFXYPyDc+wdcm1adaYdnaz6F3jZnhZ5l/+XQGmsVznqNm0Sm5Pkhr1nGhpk/fRg1+X9TEo0QSY2Uo1Dhez8DfQtwL1QRPnLQw46Q4H1jmIk5uQzPDmgqbDZu6GtWQBhL09e5PFHQBmhEej5cDVKpl/5CQnwDSLGyL1ZxOImjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206950; c=relaxed/simple;
	bh=SdnzaNponC8K8aEpuIfM/Pomn7Z72ppEXNDIvkqCTPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r0AJnq90KftCb4CQMG75d4cFsKJ1vxpvRw3HgEmQfzlczuDISbiS9GRxIMW8JRA6zUYuzH2QkEKj6vguc6J3utPA4D7Tv3R9Hzg0YPDuSEOJTV/9aRrGtUEkxZMxZkbep314SOSmKLp1KP1XEsRjcOnidOBXS/+kQSUnqE+K7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DzLCHAT4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DzLCHAT4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0ktqn1165824;
	Tue, 28 Jul 2026 02:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NTbyiIYbQDf/iOr4Hu4MyioEXHrrpQ6oqDk
	uRdUsc9A=; b=DzLCHAT4ZeIgQvFwhOej3uDdMs/bxnJFAFDcjagpUCpkfPl62zb
	VELjHug9pKdcGwC+5eXXYFbK1497yxPz525XzT3tQEifNbWkViAlIW62bKGJlUHM
	g4B3vBYCHEUzKrjcBD0NKjgT7g6xsQx8Wfl+EnoQCkpdf9leWAr62yvrvAHD1GVj
	mfodg693EBbhlcH9voatbkvmGG8OeVkFJeqCWpjPX/Gw6U0DySz5HtOR7wZvD47O
	FMiZxEBEyKtgnsYF0M08mgf701cVv/gQ4ctPS2qrwODKEe9vstC4fK/Qzlja/YBs
	h29/8v4/0nEdlv+kv91NgpdwIt6kkJW6I4Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4ukuynq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:49:00 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S2mxbZ019674;
	Tue, 28 Jul 2026 02:48:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4fpgxn1arb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:48:59 +0000 (GMT)
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66S2mxN0019668;
	Tue, 28 Jul 2026 02:48:59 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-jipihuan-lv.qualcomm.com [10.81.95.164])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 66S2mx58019667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:48:59 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4741875)
	id 86B81ABD; Mon, 27 Jul 2026 19:48:59 -0700 (PDT)
From: jipinghuang <jipihuan@qti.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jipinghuang <jipihuan@qti.qualcomm.com>
Subject: [PATCH] Fixed a bug related to thermal framework boundary conditions: trip points do not need to be updated when polling is active, whereas they must be update to re-enable the irq when polling is inactive
Date: Mon, 27 Jul 2026 19:48:56 -0700
Message-Id: <20260728024856.1596951-1-jipihuan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: -8WAZY9_fbJFB7FmNV5opdzd5jZoLcSU
X-Proofpoint-ORIG-GUID: -8WAZY9_fbJFB7FmNV5opdzd5jZoLcSU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyMyBTYWx0ZWRfX5vV0S+6FcRLh
 ckj8myV0R4He7+vzG9Nwjks0hkh/f9jlbI5QEuw4Jb3OEu1LZilaWI37gCBqWoiNmubuzO/mPHh
 nOxxB63RpjLHwz5B313TZWrYYrQc6Y0=
X-Authority-Analysis: v=2.4 cv=PeHPQChd c=1 sm=1 tr=0 ts=6a68189c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vB7aHD0Tg5Jax0qT:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=K9TXTzV5CTbLTHSpVscA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyMyBTYWx0ZWRfX3z2RV8KCjTm9
 rlt5sZLTDkWD2+5BcV9LVMM/MJlKZSe0g4zGQBj+dLoOC5qZVfP89W6gkY40nGxE7CeXcwRCM88
 1dpZxyI8TCYQWeu5qY6AMxnYnTjeSZNBX9LthU5YwOajCrqcGBD/chOv+AF4wusWdzCs9vH34+u
 DzfWFxNNUJID+LhS7xgL8ErFGBDETDZPZptoJtZaHQ2XW9R/xMVor5BaLIRFO+p65IpHP4XQZ7p
 hlutFgv5Yz5ftsJSVMUGdRTT4qrr0yjsFCUYczgWpo0/EVDTP0wr5QhFmWG38R/6pxPaaw68ID3
 S5cMBSe7ctTfPpWYYHUB7fP9nwgwlC2Y6Dkvp+qH/3wdmBW8caWOJ3rxgYz697BoaGmPsdNZri2
 LmAN4yD8S+R1TZpg+zseUoSQ/9blJe5HIe+shEv45r9uIqV/XfSJQahw0chOA8227gOr6MiKb3w
 ifamWFTyWbx0yQ047Ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280023

Signed-off-by: jipinghuang <jipihuan@qti.qualcomm.com>
---
 drivers/thermal/thermal_trip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 4b8238468b53..b6f868f7a310 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -61,7 +61,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high)
 		return;
 
 	/* No need to change trip points */
-	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
+	if (tz->prev_low_trip == low && tz->prev_high_trip == high && tz->temperature >= trip_temp)
 		return;
 
 	tz->prev_low_trip = low;
-- 
2.34.1

