Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E22FD694;
	Tue, 28 Jul 2026 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207576; cv=none; b=j7NuC4QJgKjsziVrozx8LyIlFLtC6J4yCfFhhyhB+Sp7PNvDJ6bpWDLZq+YZEHFWn3Jqgs2CSCSEjZVPQ3EC2sWW7S9nWhWgxPpquLOh1VlFiBi1VnIGPBJU+AwX30cGHTL80CJvpjMc4cF3VXuGPD/um/Yb22ewPbhREiFabGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207576; c=relaxed/simple;
	bh=SQdqKIG5Nc9TJjghecwVTnmmzMjxQeCa6rTS9xkzPc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OybaWlhHKXFNHhM+4xQ7wWTDDnbpSxmt8ZcVsCoGIafDuGnzyVkmBVvC9HQeu72OlTRDrUinToW3uqrm6jmVh9F4SW6no8OBkPycXP+iJ6jZmJMB03An3y1XJx8dDYNNcu9TfuFrHAKf3Veo7CSq2DO7pWTq+53z4ZcZU5Po4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mTY6gE5e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mTY6gE5e"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0klaV1094694;
	Tue, 28 Jul 2026 02:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VhPEDQJwAtWw27CXdemZlV0x9cH+JRy8OFQ
	TdVsGCHc=; b=mTY6gE5eogb+VRfiz490mpaN/d+/lghWcVy+1c8UabWIUdHO+Or
	+1bmdW+wBu2wSL7635dG+QCH/iE6MmsTxXy7h2M+5OuBhWbFQIZFKOzDvNCWyEJT
	2Nc+JEMRLvHdGelD6nqPEzwZb9tWr8X0HcdBH6348L+b/bNra/rGF+giPKdSWvIr
	FKGgtR6jCmtTQ3AKczRiCweoP9ICF6eDfdCwm4lY1eNs57tS+S8SOqy85pEYw1zL
	RY57qGbysOd2PjqrRfpM7C7U7qx9PKxnJRiro6oZvnc3DaGOo+J8IxtMG0Qv8eAR
	cRbtYdioZW8coy68PvkqQkrszCxiCRG47Aw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbv6a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:59:28 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S2xS09022270;
	Tue, 28 Jul 2026 02:59:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fpf7ya4bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:59:28 +0000 (GMT)
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66S2xRsA022263;
	Tue, 28 Jul 2026 02:59:27 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-jipihuan-lv.qualcomm.com [10.81.95.164])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 66S2xRcJ022262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:59:27 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4741875)
	id BB749AC7; Mon, 27 Jul 2026 19:59:27 -0700 (PDT)
From: jipinghuang <jipihuan@qti.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jipinghuang <jipihuan@qti.qualcomm.com>
Subject: [PATCH v2] Fixed a bug related to thermal framework boundary conditions: trip points do not need to be updated when polling is active, whereas they must be update to re-enable the irq when polling is inactive
Date: Mon, 27 Jul 2026 19:59:24 -0700
Message-Id: <20260728025924.1598362-1-jipihuan@qti.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: hrdh9SFVpaTrtjh8McCNGZ41gQ1_Il8P
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a681b10 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vB7aHD0Tg5Jax0qT:21 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=K9TXTzV5CTbLTHSpVscA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyNSBTYWx0ZWRfXyTUOx97cDvwU
 Ur2xUkM0ESGEas+6KzaCSwH1ZsiUKO2xJpy8fbKHp0fKq+nFEbMjfmYVV0dNNhanXfIJ7KCalpz
 REAz+eAtTSI2UKHRrq+An5gnz2Vjerk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyNSBTYWx0ZWRfX36jOdcxjypt/
 w4GFgxtV8D40L0gpgac6KrDSZcN78LrVDlvxvnsN1sH5X8+Ykrbtatvu7CLVGDkmcWYUeH3qhaB
 lFmr3a2KvpUcV2JAAvFdE1w7wahCpdSxUwbTHmM06nlAHdOlfm3mvQvZYafCw/qAU4F1177Q4ED
 Ht/fjrbvJMYcbGM7Zcj0PPg5CSwbDrTqX/jeUWRN11noBo5w7gQyV2Bo7PFB1Jw/tM3uxsirsQG
 Ko0vFIO1OJnLyMLaKCkj+mx5LWSBv39vxxGx7S7APd/P97gdtUESgyeKd4/gTmywvCXs6HZwF6D
 /fgJMF1nNnPzSms+50WWEBytKYnyFyHI+OIE89On7nN93nWIf0IfBMOObDUjkco/hOqQLHBgIiv
 YLKiaX8nLqlqfBONZV9Z0mlKMN541r6wVVvnH8mHD8hJSuH6CI1VK/2IhdvJgctmqR4zZPFUy+n
 LnrVfJedHkPGJOPrV9g==
X-Proofpoint-GUID: hrdh9SFVpaTrtjh8McCNGZ41gQ1_Il8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280025

Signed-off-by: jipinghuang <jipihuan@qti.qualcomm.com>
---
 drivers/thermal/thermal_trip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 4b8238468b53..ec4ea7d6f178 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -61,7 +61,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high)
 		return;
 
 	/* No need to change trip points */
-	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
+	if (tz->prev_low_trip == low && tz->prev_high_trip == high && tz->passive)
 		return;
 
 	tz->prev_low_trip = low;
-- 
2.34.1

