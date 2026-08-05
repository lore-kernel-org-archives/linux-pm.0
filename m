Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957638F633
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956047; cv=none; b=rP0Xj2wN7P7HXzGCEa2/bY5GK2kPzfvqOrVlAkorrS5+OBFoVbdnLHH5uGXl997vNR5lCB/tPjt7PLvawXLvbA7WBX8GnSnxVGJKnvwLJ25JsLkVMaNNle//r3ojg1AVBDAEDYIlCmFKK8Sq1IYq0XH42MKDsQzNfhZKdDggQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956047; c=relaxed/simple;
	bh=a4VKzOoGrEMo3udKXvoNtRjOBCfYdwcqE3FWQE35cnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVZw/42qES/N3ykYhDbNXBydKZB7YVQvBfQkZOqlo8zQ33YF+qb2Nuv+2nSut+DXgLLRuWPK3XdnNN4l5E3p6O+vKGeuzSjzkxkW7vHoC3E99xsKvUwDpU34r3iTCOKAGqx10WR7ArjP2i6/CanebphrdBS6tzdqsuJg1Pfn0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lsj+jBk2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mtl/IuH8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lsj+jBk2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mtl/IuH8"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HRvpG3595925
	for <linux-pm@vger.kernel.org>; Wed, 5 Aug 2026 18:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6i34dEsei2Ho6R+21IWx35UIcEVXD2nGfI3
	G0fqR2AY=; b=Lsj+jBk2Urgia6e85FFJsMvBYsAWL3mKJFz23i27En6EZY1e5lK
	a4BdDLxTP8D2l5QFhO2Ur60cjr03FRpdfjhNmGAAXaJJ65Y8LcWeixMWbfR22v4F
	nT+e9Z+6khucE9MsPRoLmn3+yKQ4/a7f+BLFVVnc+t0NEyZIf5lkZ675+lCFWl7G
	/E8KSXVx2ubvvT648JdNOlQ7GSLNghJDsTNSSk2pLq5/goH8TBk+Fy8GgDLv/Tk4
	eM2gEObP0xIeVpoOC2P1M/1SyQZUbhHjfR4wZX2MWzCHvD7G/OExcMQPPdNeY7Jn
	PkpzQpi98uLV/SUVTvdWdA+I2lADj73yZ8A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2c0aknj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 18:54:04 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1985210a12.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785956044; x=1786560844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6i34dEsei2Ho6R+21IWx35UIcEVXD2nGfI3G0fqR2AY=;
        b=Mtl/IuH8jh4BK4xcfTeLg4NlVJ4+7LhfAVVlyyUmVXWC7+3nwcXGdE5rWmKoSusfzX
         9FvN0UHEJe67XhC+ZnclqxWM3W6F2XWopaq0CTDNc62UbKkNhILst0t/EdC5gHozrohc
         WDN+e1GCSZbSBfum2wY7WviH9vYmi8uSkO5jgPuJHpUyRFv9bTTAPS62VoFA/gSHey4n
         ELqu+4OWXbjVws+uXB7ht4LAFSMmRXZGoPT+buCHrJNpehJuhiXa6V/YJlf90DzUpE/p
         +tniWb8+XBINrwpipMklqmfI58PHrjXdiqyiuTk+goCMC/segyQaBH+oYK7kbTUl6lwg
         XRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956044; x=1786560844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6i34dEsei2Ho6R+21IWx35UIcEVXD2nGfI3G0fqR2AY=;
        b=HXiUggmmkrhxfQSyoTL/voxKcog6JlefWLLx30b4HPOgdgJmqz786Pgt5dg6Fm3Gd2
         cfW1IdhXkZFIll1m1l0Pnn8rLIqnYD5KG5VopCbtgVimg2WkfJhv55jjeWYJwx4zs2Em
         oN7MgQWvQ3EwHEwnacl7i9rjMxlmaEZpWumlkth0/LCmqDvTDGU71ZAbu/5Wh6UgRyxa
         TQkKjvXrJaOGqHtQeMNRV2qFbyKSss1X/92cBt4OFkbY+TvjxNYTYrlIoB83td2DzHdR
         rjWyP6XPXA6AcjxPpz/d3AFSx+7V1P2Z2kr/i9KB6VOoTvRGHQnwGGvtU0qU1ZvIGe1l
         1/iw==
X-Forwarded-Encrypted: i=1; AHgh+RpEvmXmSOJUgmpmvLgfG1lLar1SpDQug7S5g2pOdV4Dfn1hB9ceeAO5mQTS7Cf6fdM8ZIq0hlVQZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza5jv1I1EmrUC8+SpIy9yJ0fHtvPunV57vikfPiubTjnTgDpz0
	arDmErbGCWLTal2ckD+g2bEPLrqckQgoD47UndqAxGAKqSWzTDrs8k4WM0fxke0c7/vljdU3tOE
	N+gCZh5fPtz0P6L4xeYFgv1Cx9Ph6nP0FUHDXPCIM5M23sq5HMhF+mLEiDJWpYw==
X-Gm-Gg: AR+sD13g8hnnes8Pzt/W4V0YK5R50iuJueRfPIg9gQb1OuhU4e0mB9tfZfCLDGN8Fon
	rDu+NElSUbsXvRH2TPiYL2wtKFhes6AZaadS8wGvDKiH53UctX7YpquimkDPhiEKw2jXqRGpCcn
	pADJofqQDId4/hsAFFS2FKUkXU0Q97l3U//a6H16forIXaguHfXSXpnA9TEdIcBZsyrCNb+I3iI
	K4qOoFC5tPj6tiIyIGdzOFGvH+8cvVHL7t3WETnghnvB5VuBWi15NEAEfcQMeLK0bRKlbzfojAu
	IhE5sTAhjxMZ6oWQGkerTG733WMeuMTC5gctp3k1cWxBmA+27xkiSxFp4766o2UFC5RxlOOKbnG
	TO5FFO3UyiriC/YKBkH/Sev0KRlZl+hrKTfG4CDmKej/8lGVolQLFMA==
X-Received: by 2002:a05:6a20:6a06:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3cb85df09famr9587258637.3.1785956043875;
        Wed, 05 Aug 2026 11:54:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a06:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3cb85df09famr9587207637.3.1785956043357;
        Wed, 05 Aug 2026 11:54:03 -0700 (PDT)
Received: from hu-eserrao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586402e53sm27472505eec.11.2026.08.05.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:54:02 -0700 (PDT)
From: Elson Serrao <elson.serrao@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] power: supply: add stubs for notifier registration helpers
Date: Wed,  5 Aug 2026 11:54:01 -0700
Message-Id: <20260805185401.3625514-1-elson.serrao@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qt8sl9_jgcf8ZGT_9BQxS4q_op5T5Dh5
X-Authority-Analysis: v=2.4 cv=aOfAb79m c=1 sm=1 tr=0 ts=6a7386cc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8 a=IYNAJtiqTZ58x4Z6ujwA:9
 a=x9snwWr2DeNwDh03kgHS:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1NSBTYWx0ZWRfX91Sa0RL5ENJW
 PW5c3HfBZUZVlqaWfd83D5K84WZ8wM1BroSNARn6a17uYwHFhgW3juFDY+fbQBk5YpazJjzXzQT
 g5pxTpsTdF7NNNscS14TkjRD9upRPuc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1NSBTYWx0ZWRfX1TgU35cdG0Aa
 ddJK2EgDH13h0W+cjoxdWeki4H/mIu18y/QL4CbboslCsa8OrFnh5Pe3GFboviEG2Duye5Zm6DM
 hWYXI7xxDSd/Z+SfEoAEcksv0PHqk39+XSDQIZyb9v6pz16p/HotvQWp5ZXufMCONuBWjjFV9v3
 WNCmFndaOu/DyEYLHUYVC0gI6ISgPRYmg6zBVc3qP0mcO/3fVEatweDbmTsu270dp3kSVqk0bc0
 RZ4DODBLMMJ3jeGkwaAXZTlC4WMybFKu70uXEWkI8GhBsDDqT4YNxWqfr3607UN2dC0mFwwn8WR
 jUtgJ005IfBFLtqx5AuV2Bt4wJvkGYgpYNCli8ZW+CAru40R7S4CVQAkkdKTK7IbiG8cv9rsCnB
 W2CwEaXuIAe3DSXHNqridzqI5vDMwkz//0vODeG1tLC6twkL0QNtlbFRqJmdtb7u4da5eWpOmKS
 ES8y4WkY0apTC+GYAcg==
X-Proofpoint-GUID: qt8sl9_jgcf8ZGT_9BQxS4q_op5T5Dh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050155

power_supply_reg_notifier() and power_supply_unreg_notifier() are declared
unconditionally, with no fallback when CONFIG_POWER_SUPPLY is disabled.
Any driver that calls them unconditionally fails to link:

ERROR: modpost: "power_supply_unreg_notifier" [drivers/usb/dwc3/dwc3.ko]
undefined!
ERROR: modpost: "power_supply_reg_notifier" [drivers/usb/dwc3/dwc3.ko]
undefined!

Fix this by adding stub functions for these calls.

Fixes: 7c87ef27af79 ("usb: dwc3: avoid probe deferral when USB power supply is not available")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/a9dd53b3-0666-404a-99e0-76617ae3f944@infradead.org/
Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>
---
 include/linux/power_supply.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index a9c056f13077..e749d2189335 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -816,15 +816,18 @@ struct power_supply_battery_info {
 	int bti_resistance_tolerance;
 };
 
+#if IS_ENABLED(CONFIG_POWER_SUPPLY)
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
-#if IS_ENABLED(CONFIG_POWER_SUPPLY)
 extern struct power_supply *power_supply_get_by_name(const char *name);
 extern int __must_check power_supply_get_system_batteries(struct device *dev,
 							  struct power_supply ***psys);
 extern void power_supply_put_system_batteries(struct power_supply **psys, int count);
 extern void power_supply_put(struct power_supply *psy);
 #else
+static inline int power_supply_reg_notifier(struct notifier_block *nb)
+{ return -EOPNOTSUPP; }
+static inline void power_supply_unreg_notifier(struct notifier_block *nb) {}
 static inline void power_supply_put(struct power_supply *psy) {}
 static inline struct power_supply *power_supply_get_by_name(const char *name)
 { return NULL; }
-- 
2.34.1

