Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9F23D7FF
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326835; cv=none; b=mJ4UkJu0zP5JKhCc6S9TMBSKsRzgvG8arszOUrRsiuXkWAArmoje5ZQQr9rI6atIdXCaKU+LUtnsQ2Gw4XF13efK8k/nmVJsxIaqX/5v4+BNTfYtWtceE7fChIK3Zsw9MefWHTJ6w4bannlpw1SyJJ8O6giv67xR+bvqMFbQDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326835; c=relaxed/simple;
	bh=VJF6Lc+wvuhwwUZ5wyL5elyVGsjfwYxjyDBU4SiQ/j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7B06nd5q3W6rU/lwmI/joLA4mgbWEMnk6ywLCgKsDSfdJeRP8g5UBObAIaUetXvhNjD+K7m2PopUElvDlCEUqhmhPci0pXa5xyGUr0IF8wra9ARa5d33W5V4+zxTGdt3RFh9jSpo37enCX3gMXuDlb1mIlScAsgI96PLTPLJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ONTHvUhH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZCij8NMR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ONTHvUhH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCij8NMR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCokxH2029747
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0Q7GiUt40Eatw9r3S8IuomLGZZsRqDzMMhg
	kiTbs1T8=; b=ONTHvUhHQb+0k0oStm0KGe9cZjo33ZZyosHPPor/UP4gbip+TlY
	W+Hh9ZOFoGXMHf7bvio25ZdtmVjy2KkdnvJwh0en+QGbRuo/JEWupwMxdmAuW7H6
	VO7TIp7ezCVkS8Oyq0XzkwbsXmxZogLqLv1WOHnB54BGDc3lYpltiAxoIxjutFHM
	2eN6qhIxKelauDGkkrVK4mt+5R8CSh9D8NsaMF+zEsz6oQsNJrZ2MJWA6wctNeFq
	UUovbWi+osTg2VebU4RNsdp79KMJ8wDy+dIOMy+/WAVeJon6x53AO5Yiq20jsmGa
	h0vLlMgxs2Q2wG+2eeXR/HtLq6/StVMXIfQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fue2cfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:40:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1a9764f0so12287431cf.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787326821; x=1787931621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Q7GiUt40Eatw9r3S8IuomLGZZsRqDzMMhgkiTbs1T8=;
        b=ZCij8NMRZ6SmWIc68kTQZNgTzNZL59Iixp05n++ktnIVBjR5eBHhKXQp+qQmJ6eA9h
         3rqaJu2F/FYNw8XiXRCm1odXJWOdsCo0O137TCaRQg4dwOWttMkBEtLfq2d6WTLKGUgt
         4JeEoZDOFw9FhJcOMqe6pBeexrcY4YQwZmVHE4uJ2ht9vn0+T0yvEsYnIQo1mb585yhh
         1VVw7IZZP6Wdv7jEZo0TEH4nZVteQEp8lcxVKOgO6CdiKDHZYlwYtgyBxI4RtRlp2KnV
         ADsf5Rw1sUT9kicrJWaXe+dSKbBvqTFXPBA1iwYVQUTgL8QLS25K1LJSz7FxZhtx9u7y
         7XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326821; x=1787931621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Q7GiUt40Eatw9r3S8IuomLGZZsRqDzMMhgkiTbs1T8=;
        b=QxgOM59tORnNGGln/LUx8rSr3R49vbLNUdclZTJDk1MJ++10iig6kRDZpQ1tQZJ1rd
         GmF1Pf/CbBLBjHFrKqzhaeFpQeI80nRSE5UUOCGSvnP+I9ciTYImj8bJ06fyredeI7gu
         0LKJGtZ3pXeBENKk9Pu2hJB+YV7Mu0KxcOWHMeZVl/es2U1kcZtggckum721aI7wtYZc
         lyOcSPSxrr3+sn27lPDW7tW8g8VM+/lyakIXhQmpPMolTgD9/Ae0tBhcK/8rrRrMk85Z
         mv9L9/QkaAMLn7Ou6aZF/fRCDYXGIxEyOqcA8lyPiutJYqw0BzuqiiCWHYCbItr1heXO
         /BLg==
X-Forwarded-Encrypted: i=1; AHgh+RoUgLya5i1pH/PdmqWUklujFA+Z1gxcWeY0mppwxOleu6X94OCXjNQ2/FJjKiIGT518S+IQIUD4Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPBwdveWgzAW+HZdTGKN7QcLag3Z2+AOzAHmaDwGJMUskiEcf
	azBUYMCKWNkCReUSI+3oNe9yXgL02przl5nhPXdAntiiteAHQW79xrEc6e/WMn9Qsqy/Xx9w05Q
	0nc96a+QL0JLcExJlMFwTCkpVmbuGSUIgSHVsccBhJjTapEkcR71dRiuVNeYfuA==
X-Gm-Gg: AR+sD11zycWbeknFS8cdkNJZj+OTJdszn1RZ2Q3J2Fs8D1EPoS3f0CfKvDkHkoXJWoa
	UXv2fcQhiBtu9//A/UISxXxaStv760dyeVgJNs/7rSL7vMOQ2N5GLarBmIfTEXOuRNNrj8XE8Uw
	QPhdW4b6yJw40b0FGmLsEsUGepjaUudiw12DHTcSeY0zgppanZQQN3EBJxYN8c2mf0CuMRhmhhV
	Ql0S822kg/7+DkkiErvNvJQp8M3/TWVdCsUf/mji5kOvU5K+4IA11arcFItaSMWsrJVPget08B1
	9U+X7CcRdxcV4siKNWHbiM8xxOn2o7tUiCsvWfErUR5/uH0pfXeanu2NGj9i1/n1+NJpKK5XH0Z
	AFChlNlq/v28WUjRFVt7Pwr4vB46S
X-Received: by 2002:ac8:5745:0:b0:51b:fcb4:7576 with SMTP id d75a77b69052e-52df5739ac0mr66610651cf.15.1787326820452;
        Fri, 21 Aug 2026 08:40:20 -0700 (PDT)
X-Received: by 2002:ac8:5745:0:b0:51b:fcb4:7576 with SMTP id d75a77b69052e-52df5739ac0mr66609891cf.15.1787326819936;
        Fri, 21 Aug 2026 08:40:19 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c338dsm14640533f8f.25.2026.08.21.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:40:18 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] power: supply: Fix power limit documentation
Date: Fri, 21 Aug 2026 17:39:49 +0200
Message-ID: <20260821153949.2914201-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyMiBTYWx0ZWRfXwjfMRmcwnX6O
 0+alHtKTiLF9Qn47s1reLMp96pRlc0mzQKQjZOh+lVxtFBV6O4+xFUsygJGiBzn99HA7U9wZ/XU
 vLNgVOnQgGR4X5jb5QAjIkOAzgmkW7I=
X-Authority-Analysis: v=2.4 cv=U9+iy+ru c=1 sm=1 tr=0 ts=6a887166 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=arXYI40Hz2FkRTtgrrYA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: RmWAw-YqtEkvrStWxtUG3_9Y2ta-NYYK
X-Proofpoint-ORIG-GUID: RmWAw-YqtEkvrStWxtUG3_9Y2ta-NYYK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyMiBTYWx0ZWRfXxgK7UZYmaN7G
 BrGAoOan1vVjIL3xTlULHNRhOInaFZO+hvHORQID6J5J6SSsXzbAlM/CIbPnZuMWwC3L14DCaAK
 rKkCC1Dv///gYBKvYg0ZesbGzZ6YuQ86w5GGgXnA27/RdiryRo15+dqEEfaS9Gv4UEJVR03OPAr
 E3Go10zqdOFRSb7rQP5FDu8gfDmOYS5kJKpIXIvVyu0Gq/pB06i+Gp0CKYAKVfVc/Mqf29QaazM
 oTX1NL9W9XiRsOERxqmh57QT1Iii/K5qQv1mnMP01a+jX63a5bdrGwiV939eP2KPBHPYruwqod3
 JPZ232FoRu+Htw9ToEwI0BoOnIlFB408x5afPdmeQ+lOWBmTZ0e4aEUQgF0JZdnfGz+LQsO4icV
 FQvRhoHuPhGYgSpyhb3fz1PrW1NRA5LljdWNYOs2t1nacPQ4RwJ8DgN+Rnh5cWWLXwdf5+QNI37
 lih5JgkXgjmtkHJJi0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210122

The documentation for the input current and voltage limits recommends
using those properties for problems that can be solved using a power
limit. This contradicts the recommendation to prefer input_power_limit
for such cases.

Similarly, the input_power_limit documentation recommends using the
current or voltage limits for problems that can be solved with a power
limit, which conveys the opposite of the intended meaning.

Fix the wording to clarify that input_power_limit should be preferred
whenever a power limit can address the problem, while current or
voltage limits should be used when it cannot.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-power | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 32697b926cc8..f0ef87d365dd 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -600,8 +600,8 @@ Description:
 		supply. Normally this is configured based on the type of
 		connection made (e.g. A configured SDP should output a maximum
 		of 500mA so the input current limit is set to the same value).
-		Use preferably input_power_limit, and for problems that can be
-		solved using power limit use input_current_limit.
+		Use preferably input_power_limit, and for problems that can not
+		be solved using power limit use input_current_limit.
 
 		Access: Read, Write
 
@@ -618,8 +618,8 @@ Description:
 		input power to 5V when the screen is on to meet Google's skin
 		temperature targets). Note that this feature should not be
 		used for safety critical things.
-		Use preferably input_power_limit, and for problems that can be
-		solved using power limit use input_voltage_limit.
+		Use preferably input_power_limit, and for problems that can not
+		be solved using power limit use input_voltage_limit.
 
 		Access: Read, Write
 
@@ -633,7 +633,7 @@ Description:
 		in the supply. Normally this is configured based on
 		system-level knowledge or user input. Use preferably this
 		feature to limit the incoming power and use current/voltage
-		limit only for problems that can be solved using power limit.
+		limit only for problems that can not be solved using power limit.
 
 		Access: Read, Write
 
-- 
2.43.0

