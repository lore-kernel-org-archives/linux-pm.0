Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E54908D7;
	Mon, 27 Jul 2026 03:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124262; cv=none; b=XY7UtpQVj8HLNvjNJV8dOonWOxKjLqzBmjytyndjt7aDs35Y9k5x1QSEp6BAOZjN8fPGV3NqdsLLuaatnnU6tKio2plCViQ+taenXhWPYT85X7XIVQtna3u/sx+4lGlYh52HXM6kIOdOAQEtR2w+BuuoaDmBTUQD18ebrDQvOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124262; c=relaxed/simple;
	bh=SdnzaNponC8K8aEpuIfM/Pomn7Z72ppEXNDIvkqCTPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pERwNahFVyOXqiM/fX0DFMG03LoFTo69iiq7uJFAu1YaLcA2Dk9La8V6qI82udY9c3E7LuEj0wQlWVMe2RQ7NAryXB+i4TPmH4JwmUd17zXciElLnfJ6+tUfsprGV8C0K7mOKQmPhwwGfQYaIudNQKTsAOKZoJZOQG4zpx40jTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O5vtFLGZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O5vtFLGZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1fcIL2416949;
	Mon, 27 Jul 2026 03:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NTbyiIYbQDf/iOr4Hu4MyioEXHrrpQ6oqDk
	uRdUsc9A=; b=O5vtFLGZP6GigJ27GQ2DxSRU8oZAnBu1J01dB33NKRSL+cbaeRn
	vsvqfBvl1XJzNJAr6Q+eGXGBZ54lLW0CY2nWVHKGO94JMb7Lbq+XZK5S9S0CExGZ
	KdUb3wd7EIklIlt3CQZ7Lh/IH85p68IhwtiTW0LvWOT8GtRTF6uqDDSEL8W0Tgwu
	iwKzZzZ6gwjvFVSyBDRdFIypujsbP+w3qyG8aDon8qakYiGKi5aW/cSgoiS0MhhE
	js9VyUV6iwLuNEv5UVf8THqMoWvZhIkEZS42/NEhz7h1UKShO7GvldEW49+H+aso
	CYbUaWke/7V7Qcw/eUuVdEfRujgMk/a+sOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fngyssje9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 03:50:55 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R3orpr025108;
	Mon, 27 Jul 2026 03:50:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 4fmp7hp3xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 03:50:54 +0000 (GMT)
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66R3osmm025124;
	Mon, 27 Jul 2026 03:50:54 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-jipihuan-lv.qualcomm.com [10.81.95.164])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 66R3osuD025123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 03:50:54 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4741875)
	id 0E51FABB; Sun, 26 Jul 2026 20:50:54 -0700 (PDT)
From: jipinghuang <jipihuan@qti.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jipinghuang <jipihuan@qti.qualcomm.com>
Subject: [PATCH] Fixed a bug related to thermal framework boundary conditions: trip points do not need to be updated when polling is active, whereas they must be update to re-enable the irq when polling is inactive
Date: Sun, 26 Jul 2026 20:50:37 -0700
Message-Id: <20260727035037.554303-1-jipihuan@qti.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAzNCBTYWx0ZWRfX6ppZIeXI/N9f
 rIOYexOmqbAPQ/005xROj5iAoskd/THOJ0SaxOLoRc6c+gnLBL5XKX3HOqVzsQAtZQhNkaWIhjm
 FuZhoiIbJkwgcl8W5M0l8h49gAkh5bi/fD494X4t2VBl/HefbR4GR7umR/o9zUGX/3TA5jakNlE
 ujDWHPIiZ1TwJQ5yQX/U94Sj4Ij3zpTx2Ld8puivLlG0FKzjQ8hryuR17mm1ShW4BDGOgDQcam0
 hOC4rSZLVO8dmE8Uqr97pn/R7RUqFultbjyGN4hzwxj12dtg8L1958Go4u1PSV04U4IYqlRabBd
 uKjtC3xY9wysburuDBx+q6eG/EmdWCgX6Hsigv808KpEPLhW1lWidE5P0fornD6+v6JjzZGNcl9
 N3JttUvbv+Hf5ro2/WExpkk0TiqhJGpH9Z+Tt4hU+FJmaHBm/XvBPMD+ZkLWcndHhS1wMyY7vzZ
 nicrEDuUbTRuZ+hDDdg==
X-Proofpoint-GUID: KnUsrnerFWJnf-ei_RuQ-ZEDKGaxHhTt
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a66d59f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vB7aHD0Tg5Jax0qT:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=K9TXTzV5CTbLTHSpVscA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDAzNCBTYWx0ZWRfX8gNTxJ8suYuN
 imBGlfVKkCizo5prqoE50Sek14kNvdc3xATM4NAjscgARupY0Ed1qLxTZCLHMFzNTGeQznmv5ou
 TqPymM/6Px7FuMLD7+GdoJmCgkE/wug=
X-Proofpoint-ORIG-GUID: KnUsrnerFWJnf-ei_RuQ-ZEDKGaxHhTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270034

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

