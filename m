Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637343A5448
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996659; cv=none; b=Erw03cPqgJc8WrV7x2VkFxJGVl/JRS5Op9eC4l314UWapxE7guL8owTWoVo1/9yinb05F6c5UEH7OT8vJMZ7v5iSJSIf1gPL5FppuNXXfnhJIHKXKMnJ13KA0cNUXO4WM+qqUnFyaCu0CuWXdR2OSj15pQIUprQmSwNvff0T2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996659; c=relaxed/simple;
	bh=330Zn5ca1hs2v3E8g2cbztx9xr7ZelihicIvV93DrL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwXluR/ZhKr+f/f+X0bfsfi2Ca4O8z3DLcqzSd96zysR/vGNsh+P05rIf7pymallvgf6rhSUgS/FWRK5dco7VuXZD/k1EkkZjD9QLCGWHg19u168jAELL+uKxymYwrMg/lVrNUY9z3fFWr2eSpaY75tz2eaOYM2hRCvUhD6hc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JAFsIbg+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WLUgKjvw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JAFsIbg+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WLUgKjvw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597ra5u1923159
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 09:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CFzxUUzHhYIgdrM9Cp7Q1mlQeQKF/qEFJ+1fHe7CqxE=; b=JAFsIbg+nSsu65G1
	dRHUDnhX9MA5E+GrEMN1cZoxZ4MkCeH0DmMN8Rog/TnVLKAUWc+ZmP+bntEqrZxp
	YUmEY8qwyOoWgFUxfZSEOxs5miMSEvV3rjCo6mhUvvqcg6GasB40LYOKr509H7re
	AqOfKL9IRYLAWrHQp812E1n8ayxgZ/z7buGye+6AsxEoqdaGJBOfQHI7hU1pZUbn
	c2KFLkYjKUu3Ju1RJSTJGTRj4ewc6l8cgrCCF/GfjGfwy1J/jOl/9FRC4T6hd9nt
	tHYOdqwHb65+YfmD84LMO8rdxemx4/bm3DtWGpLwR/k7J6VqRpgT8WEaj8XjmfmK
	c8QFjg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4gew7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 09:17:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8628dc1802so2343644a12.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780996655; x=1781601455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFzxUUzHhYIgdrM9Cp7Q1mlQeQKF/qEFJ+1fHe7CqxE=;
        b=WLUgKjvw+5YNvyXgvteUGLzKARQ5FRkx9jdR6WHq+7Q7vV9uvg/XYeRtKQN1kCMQIF
         KN8QAV3uZRUCD4zNY2RCVgvSPUOBwQce5Exl7YCkq6pozkllLJXw3Up2WpH1Nse7+Lbg
         Dh4k4RykrFD2mDGi7s/1R3bFUrJGkSTYBnrXNvwH9zVSBB0Rs0pDApDlbx1JafK3shzJ
         QfsY7zuAH4PwMu0AkWrlsPOYFgpd/OMPOhWSn/qWhRzPTdbTH+zVPeyN4KLsAeMU3d6B
         mgztqJW49O+sXuoqdakqVKdlPFvSybY8ozUdGWDUglL3p6sqIPqzw/6w0KuHiXQomGCA
         NzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996655; x=1781601455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CFzxUUzHhYIgdrM9Cp7Q1mlQeQKF/qEFJ+1fHe7CqxE=;
        b=LaPqieep+SmGLC2f8pXOwPkVxv1mv3lnffG2mw19xzMWMvgW8LnfVhYpx5gpJ2wc6B
         MMIEKlpFaRF1pRPs1XRD1Cp8wfoCu1l7Jg/TVBlH9h18azivNSlUCQVi4PKfra3Y+Qki
         bc1PDtZaj7AfpvJstTxj4GFOUfOEvwxqMllueowV/mAyj4s6MG44OXUKaYgs6CTn5st2
         SwzKBxGg5Ys4NTg6ICZ5qx8Lhe0bA2HLWpL0wc0/ZwGz+tVP6lEmLHC/W7TAoeYZIW4y
         BpbzW75mBKowSGKO5jp+V6CVjr7kjNfDH1hDW/nzPo4hfU02b4BiUTwxF+cx8FLoQQM6
         4Uvg==
X-Forwarded-Encrypted: i=1; AFNElJ8gRfTRcb1pZqZxtejVap426q1yMTpRYX/yX5wZACsSLIheWNX3Df+A4N9W5qoUWbY/Fnbi0hoZBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxor55pHiDvDc1eahTrrfKkCR0vILvKaK+IeGr+gPrLU3mYLjZp
	Ix0a/ovTUsi5IfDb/xaCGPMXVdJkIyvHZJVYcJcpcTa7VzQg0f12guiWPs7SQqBIlTPXWoWXShx
	A7DYqJJtiupUBfY32y/pIvb/TCMgnPXmv7ALhrbfUTj5UXKibv3hrR2sK7z/5NA==
X-Gm-Gg: Acq92OF/aRiiEoXzRaKXp69kCS8tsWP1vinIwdsXJJ0Jer6X0i37IAHljuGKo/+7dJo
	nlmZcTb6RptGH8+T6oy5s8WcrNC+wCE7lW7uRsrJGr+CxrCYOVn06Wnso2xr/GXtMMQOfJOKZ0y
	Nzq+RIAIERok0vEB8SijBHMoyRO44SdTIFOSPyHgVXMAfSQvZWbZuLlndEpKrLdb8M/2x3IGkhu
	pYs0beKUn0tZibJ8nu2LNaJM4qieXA1DxJyE26BdLu9BNyzRwjDuOLJrsqnH8q6MXMrMaIl8sNE
	BkB+oOGWpMbSHacj476/iD2Kubc/5aYVR/nEVL7rOaWjaqF/0ZflDUSJ1Q7lqhRzOhn8HiT+OQw
	QLWxoHrLTloAaVK+NAtpXjpejv0qOn1mZ3A4Dv/mlQjH+pZ6zF9Pufh1H3im5MW8cNh9j
X-Received: by 2002:a05:6a00:10c4:b0:842:4982:81c with SMTP id d2e1a72fcca58-842b0d5d2e7mr19387304b3a.20.1780996654920;
        Tue, 09 Jun 2026 02:17:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c4:b0:842:4982:81c with SMTP id d2e1a72fcca58-842b0d5d2e7mr19387263b3a.20.1780996654279;
        Tue, 09 Jun 2026 02:17:34 -0700 (PDT)
Received: from hu-drajpura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fa877sm20974879b3a.51.2026.06.09.02.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:17:33 -0700 (PDT)
From: DhruvinRajpura <dhruvin.rajpura@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 14:46:43 +0530
Subject: [PATCH 2/2] power: supply: qcom_battmgr: Add thermal mitigation
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-cooling_device_reg-v1-2-e15bddcb0086@qti.qualcomm.com>
References: <20260609-cooling_device_reg-v1-0-e15bddcb0086@qti.qualcomm.com>
In-Reply-To: <20260609-cooling_device_reg-v1-0-e15bddcb0086@qti.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dhruvin.rajpura@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
        jishnu.prakash@oss.qualcomm.com,
        Dhruvin Rajpura <drajpura@qti.qualcomm.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Umang Chheda <quic_uchheda@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780996639; l=13463;
 i=drajpura@qti.qualcomm.com; h=from:subject:message-id;
 bh=VJ2CGf/mC6eRUxM8K/QYpGz84W7Qe1qdsXTOg3dFjlc=;
 b=mFfL8llpjCPp7dECJ5J8r5nafgjMt7N0GT5DGNcRJIzYFXMmrGyuJSCKs3PA8ujH2bKDB1H6Z
 tlVWWhKBLu/Dz9WyDIsL2t4/QjqtT6lKZ3voeo0Ifv7Z/l9M8svLO8l
X-Developer-Key: i=drajpura@qti.qualcomm.com; a=ed25519;
 pk=955XCRKkDWtR3Z/wycEd5zolAQt3Q1z7vODzFB/Wn1g=
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a27da30 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=KCVx3LFSaJSWsAEuBpQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kYIazXmj1U722FIV17i2HLI4e9VT8LUt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NSBTYWx0ZWRfX3EmbYiXU4wXZ
 rvT40J4wIlC7UQwB9+B29tUP7d456pRYnQbDDLmfgdtB73ZINaawqDRaHvs8AV025/+JSsS4QPU
 iLHqKsRaue6QI+yqBNbhjcGbRqXl5mzSlfYKB36dsfs7hv2/ohIdim9X+RV0d1FFGzvYjmQIcWP
 OhfamgQmmDnyJbjMB3rrhSyV9j1KFNq21DEgqw+Yo1UCzCcTg1D7A/+mDEMdcOa1X2foX3q511w
 IWms5FGAp/Rs8HRktZLd44hAa7F2FNfIBBGhIfoUSl4ndHgnYY2/xrEYtIegYGquZdJAr70EYce
 1+aBgcCJGnsaxgTf5oq6QvA/BxBgnYEMBt8bvU7fEvqg6bT1dLq0TbgdR0ro6kluaDD6rqECiTp
 vaUD+MAJDEEMdn3kWc0OCyQw5XExfsUqNZJwKvWSe9RVUZsOirZJt8/EFWeT5n89KtD7PdczBOK
 aTbzBYjQOFpsPPM4Lew==
X-Proofpoint-ORIG-GUID: kYIazXmj1U722FIV17i2HLI4e9VT8LUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090085

From: Dhruvin Rajpura <drajpura@qti.qualcomm.com>

Earlier commit c85c191694cb ("power: supply: remove faulty cooling
logic") removed the automatic cooling device registration from
the power supply framework due to inverted cooling logic and
missing CHARGE_CONTROL_LIMIT_MAX validation across drivers. As
a result, drivers that need thermal mitigation support must now
explicitly register their own cooling devices with correct
semantics.

The battery charger firmware exposes a fast charge current (FCC)
limit property that can be used to throttle charging current in
response to thermal events. Without explicit cooling device
registration, the thermal framework has no way to reduce charging
current when the device is under thermal stress, which can lead
to excessive heat buildup during charging. Register a thermal
cooling device that maps discrete current levels defined in the
qcom,thermal-mitigation DT property to cooling states, where
level 0 represents the hardware maximum current queried from
firmware and each subsequent level reduces current to the next
DT-defined value. Track the last applied FCC value so thermal
limits are preserved across firmware protection domain restart
(PDR) events. Expose CHARGE_CONTROL_LIMIT and
CHARGE_CONTROL_LIMIT_MAX as power supply properties to allow
userspace to observe and control the current throttle level.

Co-developed-by: Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Signed-off-by: Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Co-developed-by: Umang Chheda <quic_uchheda@quicinc.com>
Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 256 ++++++++++++++++++++++++++++++++++++
 1 file changed, 256 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 490137a23d00..cbc129e9aa17 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -14,6 +14,7 @@
 #include <linux/soc/qcom/pdr.h>
 #include <linux/soc/qcom/pmic_glink.h>
 #include <linux/math.h>
+#include <linux/thermal.h>
 #include <linux/units.h>
 
 #define BATTMGR_CHEMISTRY_LEN	4
@@ -283,6 +284,7 @@ struct qcom_battmgr_status {
 
 	unsigned int discharge_time;
 	unsigned int charge_time;
+	unsigned int max_charge_ctl_limit;
 };
 
 struct qcom_battmgr_ac {
@@ -321,9 +323,18 @@ struct qcom_battmgr {
 	enum qcom_battmgr_unit unit;
 
 	int error;
+
+	int curr_thermal_level;
+	int num_thermal_levels;
+
+	u32 *thermal_levels;
+	u32 thermal_fcc_ua;
+	u32 last_fcc_ua;
+
 	struct completion ack;
 
 	bool service_up;
+	bool thermal_dev_registered;
 
 	struct qcom_battmgr_info info;
 	struct qcom_battmgr_status status;
@@ -449,6 +460,8 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
 	[POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = BATT_CHG_CTRL_START_THR,
 	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT] = BATT_CHG_CTRL_LIM,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX] = BATT_CHG_CTRL_LIM_MAX,
 };
 
 static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
@@ -612,6 +625,12 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 			return -ENODATA;
 		val->intval = battmgr->status.percent;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		val->intval = battmgr->curr_thermal_level;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+		val->intval = battmgr->num_thermal_levels;
+		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		val->intval = battmgr->status.temperature;
 		break;
@@ -770,6 +789,55 @@ static int qcom_battmgr_bat_is_writeable(struct power_supply *psy,
 	return 0;
 }
 
+static int __battery_psy_set_charge_current(struct qcom_battmgr *battmgr,
+					    u32 fcc_ua)
+{
+	int ret;
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_SET,
+					    BATT_CHG_CTRL_LIM, fcc_ua);
+	mutex_unlock(&battmgr->lock);
+	if (ret < 0) {
+		dev_err(battmgr->dev, "Failed to set FCC %u, ret=%d\n", fcc_ua, ret);
+	} else {
+		dev_dbg(battmgr->dev, "Set FCC to %u uA\n", fcc_ua);
+		battmgr->last_fcc_ua = fcc_ua;
+	}
+
+	return ret;
+}
+
+static int battery_psy_set_charge_current(struct qcom_battmgr *battmgr,
+					  int val)
+{
+	u32 fcc_ua, prev_fcc_ua;
+	int ret;
+
+	if (!battmgr->num_thermal_levels)
+		return 0;
+
+	if (battmgr->num_thermal_levels < 0) {
+		dev_err(battmgr->dev, "Incorrect num_thermal_levels\n");
+		return -EINVAL;
+	}
+
+	if (val < 0 || val > battmgr->num_thermal_levels)
+		return -EINVAL;
+
+	fcc_ua = battmgr->thermal_levels[val];
+	prev_fcc_ua = battmgr->thermal_fcc_ua;
+	battmgr->thermal_fcc_ua = fcc_ua;
+
+	ret = __battery_psy_set_charge_current(battmgr, fcc_ua);
+	if (!ret)
+		battmgr->curr_thermal_level = val;
+	else
+		battmgr->thermal_fcc_ua = prev_fcc_ua;
+
+	return ret;
+}
+
 static int qcom_battmgr_bat_set_property(struct power_supply *psy,
 					 enum power_supply_property psp,
 					 const union power_supply_propval *pval)
@@ -784,6 +852,8 @@ static int qcom_battmgr_bat_set_property(struct power_supply *psy,
 		return qcom_battmgr_set_charge_start_threshold(battmgr, pval->intval);
 	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
 		return qcom_battmgr_set_charge_end_threshold(battmgr, pval->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		return battery_psy_set_charge_current(battmgr, pval->intval);
 	default:
 		return -EINVAL;
 	}
@@ -791,6 +861,19 @@ static int qcom_battmgr_bat_set_property(struct power_supply *psy,
 	return 0;
 }
 
+static int qcom_battmgr_prop_is_writeable(struct power_supply *psy,
+					  enum power_supply_property prop)
+{
+	switch (prop) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const enum power_supply_property sc8280xp_bat_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -872,6 +955,8 @@ static const enum power_supply_property sm8350_bat_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
@@ -892,6 +977,8 @@ static const struct power_supply_desc sm8350_bat_psy_desc = {
 	.properties = sm8350_bat_props,
 	.num_properties = ARRAY_SIZE(sm8350_bat_props),
 	.get_property = qcom_battmgr_bat_get_property,
+	.set_property = qcom_battmgr_bat_set_property,
+	.property_is_writeable = qcom_battmgr_prop_is_writeable,
 };
 
 static const enum power_supply_property sm8550_bat_props[] = {
@@ -1434,6 +1521,11 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		case BATT_CURR_NOW:
 			battmgr->status.current_now = le32_to_cpu(resp->intval.value);
 			break;
+		case BATT_CHG_CTRL_LIM:
+			break;
+		case BATT_CHG_CTRL_LIM_MAX:
+			battmgr->status.max_charge_ctl_limit = le32_to_cpu(resp->intval.value);
+			break;
 		case BATT_TEMP:
 			val = le32_to_cpu(resp->intval.value);
 			battmgr->status.temperature = DIV_ROUND_CLOSEST(val, 10);
@@ -1479,6 +1571,25 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 			break;
 		}
 		break;
+
+	case BATTMGR_BAT_PROPERTY_SET:
+		property = le32_to_cpu(resp->intval.property);
+		if (payload_len != sizeof(resp->intval)) {
+			dev_warn(battmgr->dev,
+				 "invalid payload length for %#x request: %zd\n",
+				 property, payload_len);
+			battmgr->error = -ENODATA;
+			return;
+		}
+
+		battmgr->error = le32_to_cpu(resp->intval.result);
+		if (battmgr->error) {
+			dev_err(battmgr->dev, "Error in response for opcode :%#x prop_id :%u, ret :%d\n",
+				opcode, property, battmgr->error);
+			goto out_complete;
+		}
+		break;
+
 	case BATTMGR_USB_PROPERTY_GET:
 		property = le32_to_cpu(resp->intval.property);
 		if (payload_len != sizeof(resp->intval)) {
@@ -1583,6 +1694,133 @@ static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
 		qcom_battmgr_sm8350_callback(battmgr, data, len);
 }
 
+static int
+qcom_battmgr_chg_get_max_charge_cntl_limit(struct thermal_cooling_device *tcd,
+					   unsigned long *state)
+{
+	struct qcom_battmgr *battmgr = tcd->devdata;
+
+	*state = battmgr->num_thermal_levels;
+
+	return 0;
+}
+
+static int
+qcom_battmgr_chg_get_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
+					   unsigned long *state)
+{
+	struct qcom_battmgr *battmgr = tcd->devdata;
+
+	*state = battmgr->curr_thermal_level;
+
+	return 0;
+}
+
+static int
+qcom_battmgr_set_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
+				       unsigned long state)
+{
+	struct qcom_battmgr *battmgr = tcd->devdata;
+
+	return battery_psy_set_charge_current(battmgr, (int)state);
+}
+
+static const struct thermal_cooling_device_ops battery_tcd_ops = {
+	.get_max_state = qcom_battmgr_chg_get_max_charge_cntl_limit,
+	.get_cur_state = qcom_battmgr_chg_get_cur_charge_cntl_limit,
+	.set_cur_state = qcom_battmgr_set_cur_charge_cntl_limit,
+};
+
+static int qcom_battmgr_register_thermal_cooling_device(struct qcom_battmgr *battmgr)
+{
+	struct thermal_cooling_device *tcd;
+	u32 prev;
+	int ret, i;
+
+	/* Skip registering thermal cooling device if thermal levels are not defined */
+	if (!battmgr->num_thermal_levels)
+		return 0;
+
+	if (battmgr->thermal_dev_registered)
+		return 0;
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_GET,
+					    BATT_CHG_CTRL_LIM_MAX, 0);
+	mutex_unlock(&battmgr->lock);
+
+	if (ret < 0) {
+		dev_err(battmgr->dev, "Unable to read CHG_CTRL_LIMIT_MAX ret :%d\n", ret);
+		return ret;
+	}
+
+	prev = battmgr->status.max_charge_ctl_limit;
+
+	for (i = 1; i <= battmgr->num_thermal_levels; i++) {
+		if (battmgr->thermal_levels[i] > prev) {
+			dev_err(battmgr->dev, "Thermal values not defined as expected\n");
+			return -EINVAL;
+		}
+		prev = battmgr->thermal_levels[i];
+	}
+
+	battmgr->thermal_levels[0] = battmgr->status.max_charge_ctl_limit;
+	battmgr->thermal_fcc_ua = battmgr->status.max_charge_ctl_limit;
+
+	/* Register Thermal Cooling Device */
+	tcd = devm_thermal_of_cooling_device_register(battmgr->dev,
+						      battmgr->dev->of_node,
+						      (char *)battmgr->bat_psy->desc->name,
+						      battmgr, &battery_tcd_ops);
+	if (IS_ERR_OR_NULL(tcd)) {
+		ret = PTR_ERR_OR_ZERO(tcd);
+		dev_err(battmgr->dev, "Failed to register thermal cooling device ret=%d\n", ret);
+		return ret;
+	}
+
+	battmgr->thermal_dev_registered = true;
+
+	return ret;
+}
+
+static int qcom_battmgr_parse_dt(struct qcom_battmgr *battmgr)
+{
+	struct device_node *node = battmgr->dev->of_node;
+	int len, ret;
+
+	ret = of_property_count_elems_of_size(node, "qcom,thermal-mitigation", sizeof(u32));
+	if (ret == -EINVAL)
+		return 0;               /* property not defined, thermal mitigation disabled */
+	if (ret <= 0)
+		return ret;              /* real error, propagate */
+
+	len = ret;
+
+	battmgr->thermal_levels = devm_kcalloc(battmgr->dev, len + 1,
+					       sizeof(*battmgr->thermal_levels),
+					       GFP_KERNEL);
+	if (!battmgr->thermal_levels)
+		return -ENOMEM;
+
+	/*
+	 * Element 0 is for normal charging current. Elements from index 1
+	 * onwards is for thermal mitigation charging currents.
+	 */
+
+	ret = of_property_read_u32_array(node, "qcom,thermal-mitigation",
+					 &battmgr->thermal_levels[1], len);
+	if (ret < 0) {
+		dev_err(battmgr->dev, "Error in reading qcom,thermal-mitigation, ret=%d\n",
+			ret);
+
+		return ret;
+	}
+
+	battmgr->num_thermal_levels = len;
+
+	return ret;
+}
+
 static void qcom_battmgr_enable_worker(struct work_struct *work)
 {
 	struct qcom_battmgr *battmgr = container_of(work, struct qcom_battmgr, enable_work);
@@ -1596,6 +1834,18 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 	ret = qcom_battmgr_request(battmgr, &req, sizeof(req));
 	if (ret)
 		dev_err(battmgr->dev, "failed to request power notifications\n");
+
+	if (!battmgr->thermal_dev_registered) {
+		ret = qcom_battmgr_register_thermal_cooling_device(battmgr);
+		if (ret < 0)
+			dev_err(battmgr->dev, "failed to register thermal cooling device ret:%d\n",
+				ret);
+	} else if (battmgr->last_fcc_ua) {
+		ret = __battery_psy_set_charge_current(battmgr, battmgr->last_fcc_ua);
+		if (ret < 0)
+			dev_err(battmgr->dev, "Failed to set FCC (%u uA), ret:%d\n",
+				battmgr->last_fcc_ua, ret);
+	}
 }
 
 static void qcom_battmgr_pdr_notify(void *priv, int state)
@@ -1690,6 +1940,12 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
 					     "failed to register wireless charing power supply\n");
 	} else {
+		ret = qcom_battmgr_parse_dt(battmgr);
+		if (ret < 0) {
+			dev_err(dev, "Failed to parse thermal mitigation levels ret:%d\n", ret);
+			return ret;
+		}
+
 		if (battmgr->variant == QCOM_BATTMGR_SM8550)
 			psy_desc = &sm8550_bat_psy_desc;
 		else

-- 
2.34.1

