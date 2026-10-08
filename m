Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626048B374
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450914; cv=none; b=tE3qaBSkLCWe84sF8XQiY7ccYI3jwiCXtJJEmxriy8qc54pldflfRFn3LqjRvUbv+1iDf0npMZl/NVSlihkOFVBACZAO/YaTVuLNhdw9e1wV0QBtVLHbK5lqp/U2gNLAoLuPK0dCGbI7lAewG/uWoIYvlqMOvPQq5aAKFosa6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450914; c=relaxed/simple;
	bh=113p4ykh8ScJOnJfNzKtu+V5B9+90KAXuvG5v0O91k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VwULtgg+qp3/Ay4e3r4QHT4J4MDxHa1PouL9nypFZaoTjM3ytByonycgOUqQZFVR+w4H/LdWQ+m6EQ7DtOFEEIIj/ZH/pnEiqOv0U6e7n5MBKuHY8pEnuWEwrCFXQ0r8IRlojWwXgHuC4X11bigc1bwzEDzl2gTTBaP6EeLiM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jBUtKU/D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ibiWVYWR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jBUtKU/D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ibiWVYWR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987K7f02189885
	for <linux-pm@vger.kernel.org>; Thu, 8 Oct 2026 09:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TvipoBdu+Q4EluVkauoEQN
	zOfsiG011NF+IbDFeh9YU=; b=jBUtKU/DezNVixPrlKsbCN+Wsgz881MWgxEYWy
	Az7MhlhkBs61MGFq9dyK+FGTCSTJ8Cdog12KkvC8GjlXhSLfPfnAyjYPOdaFsBIT
	anoloS4ssym/D//EjqpTQCFJTeGvcQPluoW7bWdbQXNPK82zRRU+aCdb1S7vH92Z
	Io0fexsCwSkc7+WC706XG5d9p5LjC6IjBBbvvUYXG1ct+CwfSC16Gc6K8MDVWNGG
	6xlMF1ouHvPV/7cCvAI3qdeJDEtl/VvKySlD+giRCnDL02bK3HgxjCJiTLhgjjPw
	+ZFEW459uf3ogbPV2cGfJ2kT+DAPnLTiU1LfyXLT2Zv7cAxA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3a2x1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 09:15:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e82060977so169256485a.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791450905; x=1792055705; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TvipoBdu+Q4EluVkauoEQNzOfsiG011NF+IbDFeh9YU=;
        b=ibiWVYWRQT0fTCJcyF1Zb58jpVij3I3Lq+85fks+bePct9fubQF/MfJKgfxTOfAlaT
         WOebTz5Lnf088v0V+7Fman8TOf4wusw6wrbA5EP2EKZkhUwcKoU0iGYobaka1uFk5u4Q
         bCN+vn1rLvoxN+3gb+F4urWgKGcQXrbwLkDQImUj/HWdvhzOWFEMk9XY8gyWkiQntdmJ
         W3Jv0HRu0Pavjxs1a+Oy9L4LAK3m/bBnSZ9crVTWqMbG2gAvPauN/i6I90tAgMYPvdWH
         HmiObNX5FJeUfJoP0VLc2DqqdWznByCBhTPkkSnEyCwdpG/2D5os/KQw5yGhN066LeL/
         ipQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791450905; x=1792055705;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TvipoBdu+Q4EluVkauoEQNzOfsiG011NF+IbDFeh9YU=;
        b=PZ5CzdkOzI2XMi/Nqmyugutgle/GMe4rBvRPpig12fWnSxDG5GwYFoq1Nf0oKxRpG8
         7cWsz5tKojX7JBEb8Y2cTH6V7qCLvm3cliiEOMnDN9mMeD1fGAwQF0o6Gb826Y8mWtDH
         +DzjB4a6M3EknD2w0XeipwH4bgS8+2fcMNTi/o8cfF+7epA4F8Cmg0wPzn2uqypIRRn8
         6gC+lZcF2RXjzudcAjXfeZvG3DOdYev0NthB4mPRqthIvZWNtHsv8tP70uEedfha0Bbs
         Oq5eGXyO0PhA5wLrZfuAoNG0Brk1B0m6eQt02wXkN8ZW5DzrZl6yO9SjDXNoT1Cja+c+
         fUNg==
X-Forwarded-Encrypted: i=1; AKwUvBx2e/VU1vGykULwqG+9xLcx7Eizn3HEN1W6d6vFBbSGfzJXepfKcZSHJyXrX/dnf20OpMto4Og4ZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lWz0bbQyqhiiGrh3MFyJTD+/D40Bp4BfN+d2z6EUcDbUux5mm+
	E3PI9pxeY01w9nsypBI5BgU0wlwSXNY12uv00TwJmCy2jhJ2W86pjdSpiX1P2GeNkLqKy0Dhox0
	3hoiXAqTVXJTl13zY6dm2Dt9Fe7t27kYlldcm9/oE6om8JJWAOufp5C/vD62gIaL4hu46gcWo
X-Gm-Gg: AYBFou1a9MlHO2TT31NNaotTy3M5uZ+WRIF6VzvW+9QSqi2U1mPnKB2mTT7qkwJioBQ
	j1IehWTUx9wE7Ec54/ChUHUN5fQPrVkbpTZ8uOZq5CtfXQlUlNhQdbtz4TDK+xNbclGPBQzeOFt
	bwdeOf1l++deQVU5YOgEQhoLnTneBjUfV8cjn33V7Y5kfYZwnuugmMuFhtk54Qbchz0ZZfeXhcl
	u8L0dyLUj33gC6qukK2EvpLzbZsMg+dcoYpZrm6e6SAHdkGQLYsCdgRYNob1xYBaGEXUntd0eht
	IRY2LZUEIMdUB9oC9CaZyPgtjjmWZzZxnr3wyd0DjIkdYPMIo6+EH8PesdBKNl5MWBbRV1V3Ghz
	jqMaVO5cJZYnjDgy3
X-Received: by 2002:a05:620a:2681:b0:93b:cb64:25a5 with SMTP id af79cd13be357-93eaae73186mr317541185a.12.1791450905084;
        Thu, 08 Oct 2026 02:15:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2681:b0:93b:cb64:25a5 with SMTP id af79cd13be357-93eaae73186mr317537985a.12.1791450904500;
        Thu, 08 Oct 2026 02:15:04 -0700 (PDT)
Received: from [172.17.0.1] ([95.80.216.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c75b4e399sm9111402f8f.56.2026.10.08.02.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:15:03 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 11:14:57 +0200
Subject: [PATCH] power: supply: qcom_battmgr: report full batteries
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-battmgr-full-v1-1-4f5485a9c421@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDWZWgiuIhbtGIz4S1siEXdXL
 L/Fexd4dsIequQCx4d4WZcInSZAg1l6VtJGQ4ZZrhELZU0Ic+9Ut0+TQiIkbUtt2UBMNsednN+
 ubn773Y5M4X3AfT+j/YuecAAAAA==
X-Change-ID: 20261008-battmgr-full-0cc0c1b91bea
To: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3064;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=113p4ykh8ScJOnJfNzKtu+V5B9+90KAXuvG5v0O91k0=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBqx18WX1uMHhp9ygEpsT3qH6XpuJtVblRMy27+l
 cIQNcb3yGiJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCasdfFhUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUmEBAAtKCGuYmSy03rB+XXoOx4vxERiosT0mm3sAXM6Fh
 pAPdS7ZjAfIy+DPtwaEXOtCoNN/x24Z76c02muqUSbbZaYFS8kL1kLpU0RMLg4Nk5iiWb1ARZtW
 EIRr0eyGFI+O2bo2UH76eUPN9wvEHfbuwo3A4O6Oz4UDhg/4/X5t3+dGFYkPzjNwJzhCqfQhOuO
 Tiulp45pZMcxjzPXG/2ND32TpSlNLIvieuUj4vd55OCa8/mbMmHsf8vOltpSinfzwDFJ3Q+frFf
 7680+LS78FhLYjTI+nyI/k0YG29D8oye0Gc0tpDSMNMc61RvckS9e6B3p71ruW/DtQ1X7qwZOA4
 HZVUIMbeyCkBJ4LNKUBcV8oDa+0BpYzaEZoHvGYmoN+GT4twhetjYkxvkdny8/UQS72cEyVsD0o
 uxzczTUOUHcBF0ICCyoAIcOBITo/znymo8Q86xKqthTIVatzSnipFlIEnp6wH8XblARlP0uxJvT
 ltjNLSnkTMCNKpdhgCaPKiRcD3WElo7kOmd30ezlc+uZE5xu+snG/9l2BiVbdkX9e+/e0aHsIAP
 J0k7IsE03nRqhhw9r/ccZjAe9OsWT1+1ro+Vq5ANXcCAtOYPKkuDuD/rYqN4BV/mu+KaoJO3Psc
 JLWdyxzZWumxPPfCoaBi4l/mJpedd3CMistEbzp0635M=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ac75f1a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=QXLwtwpwLcHiQIpul8D27g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ehu19JASJfBuvZPKHZAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfX0qQq9SJCVe1Y
 rE27vbm79/Kc7lBF+BwCGHx6nIxPdaLFP7Hk01I8kRcngvR/5oJV7wgx/tc6Kw4Gxaf8WQK8TIX
 /eE+bZzuNCy3bkoFSJgxrMj/VAUAhH4=
X-Proofpoint-GUID: uDe3aidfmiYVDA0GoeN40YgNTUNV3gfv
X-Proofpoint-ORIG-GUID: uDe3aidfmiYVDA0GoeN40YgNTUNV3gfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfXwADsSnlE62/t
 4bWNWt4SnaSw7jF3wn337XjKMIMatMJBKPD9He0vVx1qDfuTqDdYB/TKhuiiy5d6Y5/tEidmHwK
 RejFMJd8za85MFsZnsmE+0yUXpK7f8PGf8/ukDVfzpeMCxhzVfAOGmI/mXdVFmj03C2NBvw0awX
 1QL45CB2HnFtgcuz4LFxLyRxPlthZOqtL3yHFf5CIQUufWmWXmRSlDXgcsHSjsv0kWSrXz95zMY
 TH0b3sGhecyhYj39PINl/I2JUVgbYrQsx9cbTaPc4E1YOiyu1XS/TJhvsfjI7+Z60Y0X8wL/DlI
 KjT01wnp+RrNyOr4I+K2fcgZsILxgYm5QN6LRgmgIwn2wXD4QXFkSGsAhhLz4+qanYVZn00js+e
 IOfZq0FepXUdSIshydbHM9CWiJMOu02FGVAFQo+z9PvY23B1sXOD5aVJMPNIyfHwqc+Z6HPC0FP
 qmZscEbmYPAS9sVmyMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080036

The SC8280XP battery-status response has no explicit full state. When a
battery reaches its full capacity on external power, neither the charging
nor discharging bit is set. The driver consequently reports "Not
charging", which can make userspace show the system as battery powered.

Use the response's power-online bit and the reported capacity to identify
a battery that is full while externally powered. Preserve "Not charging"
for a battery whose charging is inhibited below its full capacity.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Assisted-by: LLM
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 7716eb9e1aff..97cbe966ea84 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1261,6 +1261,7 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 	unsigned int opcode = le32_to_cpu(resp->hdr.opcode);
 	unsigned int source;
 	unsigned int state;
+	unsigned int power_state;
 	size_t payload_len = len - sizeof(struct pmic_glink_hdr);
 
 	if (payload_len < sizeof(__le32)) {
@@ -1310,18 +1311,23 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 		}
 
 		state = le32_to_cpu(resp->status.battery_state);
+		battmgr->status.capacity = le32_to_cpu(resp->status.capacity) * 1000;
+		battmgr->status.power_now = le32_to_cpu(resp->status.rate) * 1000;
+		battmgr->status.voltage_now = le32_to_cpu(resp->status.battery_voltage) * 1000;
+		battmgr->status.temperature = qcom_battmgr_sc8280xp_convert_temp(le32_to_cpu(resp->status.temperature));
+
+		power_state = le32_to_cpu(resp->status.power_state);
 		if (state & BIT(0))
 			battmgr->status.status = POWER_SUPPLY_STATUS_DISCHARGING;
 		else if (state & BIT(1))
 			battmgr->status.status = POWER_SUPPLY_STATUS_CHARGING;
+		else if ((power_state & BIT(0)) &&
+			 battmgr->info.last_full_capacity &&
+			 battmgr->status.capacity >= battmgr->info.last_full_capacity)
+			battmgr->status.status = POWER_SUPPLY_STATUS_FULL;
 		else
 			battmgr->status.status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 
-		battmgr->status.capacity = le32_to_cpu(resp->status.capacity) * 1000;
-		battmgr->status.power_now = le32_to_cpu(resp->status.rate) * 1000;
-		battmgr->status.voltage_now = le32_to_cpu(resp->status.battery_voltage) * 1000;
-		battmgr->status.temperature = qcom_battmgr_sc8280xp_convert_temp(le32_to_cpu(resp->status.temperature));
-
 		source = le32_to_cpu(resp->status.charging_source);
 		battmgr->ac.online = source == BATTMGR_CHARGING_SOURCE_AC;
 		battmgr->usb.online = source == BATTMGR_CHARGING_SOURCE_USB;

---
base-commit: f0406245cb9855e6318335a8a223551354291a46
change-id: 20261008-battmgr-full-0cc0c1b91bea

Best regards,
--  
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

