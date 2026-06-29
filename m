Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3935E925
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765434; cv=none; b=T9Demd3fupwOarsb3F1eKdcdxaSyKnRwt4tpFVtO1QnsxAiPwM1op4Xrnay1BmNuXsLN7KqwUTWGC9X4BRS17DkcdKTdZQtDDvqRbC7fi5bccKYSuvbd9vq+m5esnEkxLzOaaYMYlB8X77pMKrQhx0yBHUcpiEljV8Ercmtf4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765434; c=relaxed/simple;
	bh=NoBxgTpHGJnabz1qe5DLBuL00WEPQMYrLj1bACR4WDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R0DlhJAo+8gVc96tizyWRKpy7srxr4YWMAj3PHbC3O5SJyI09ZIumWT9LLr2pCvh1ZVUJ4OKa27V2L+mfhISz1OO+puDHq8EsB0Qnp2r4C8XN164XhFBhPua2941GF1Hi20ZGw+qH48gFhE2fZzNLmPXC6IKObW0BnN61EAuv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z8dbbSdS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jS2eqW46; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z8dbbSdS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jS2eqW46"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TGKXjl3450581
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 20:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3tNDKhsz+AVRDAEgoanN+6
	KqNZh86ze/6x9MuT1XmOM=; b=Z8dbbSdSwJKAmhn+bamHo6Xhxbnp8yhQGxcrMN
	Bspp1t9/qsiu/pIh7P9rgmLLxQoccHHn8Ekq6veGeOgcW/7VI6iTPnIySJg8QwLb
	bld5FrZk8945FbLFOiSttQbdsA/1zUk30fZEFVvxt8twp2J1SwlREdSnM5n/O6LL
	PwstPud9xOJpnVusnJ9QEZzmkiYsFBy25iowPcLhQmsFJGqxe1lto/erDeoQxWLx
	RyTIZgDe124oBkwVOdS8siafK0lTp9nDYnJEyCLC74t6FGLBPE5MW1Y6NGe2e4L8
	CopYOY1Prd2KkoOD2IKQw5kS2JttlsGij0Ydr4VwidSB+3bw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjkebx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 20:37:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c011c7cb9so9908997eec.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782765431; x=1783370231; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tNDKhsz+AVRDAEgoanN+6KqNZh86ze/6x9MuT1XmOM=;
        b=jS2eqW467g+1eedKpWNk9QQfiwt7cxse5UGs06S7gBLyeFIdY5Xjs/jcWawZwmBijC
         xKF3LVV7+NCKYmbIKsOEWBih7shARzUrJsD52Hgdjd0HnlQv0En3MwSHrEQw0xKyoHm+
         weMLymIHhKmCIJIq52XDbW5zU4qA6ltA87m7fr77iWXwBvudcMWzUDL8DWLVldtAYYgO
         RMf5fThKYrYqofObPyUGJdnjc/AB3cfDu6G5A+YJlvjS7/+YFwatgRYDECNEY6wfmQLF
         IrwXvOzw57M7w7X4sNiNlaOoCwJlu4GQ8YGygYFfkVFKX6M2Cs0TdbGptKMnJv0d75pN
         xyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782765431; x=1783370231;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tNDKhsz+AVRDAEgoanN+6KqNZh86ze/6x9MuT1XmOM=;
        b=BwO9AFSulBWFJmvb4Yb5QBZn4xStQkYM0UsGKDjjh/oFgy1v9vQe6zvpoDVOpqFvav
         TJAfB5KvpnsrEAnKlITpcliGz16Xcr/Czi7FX8mH49YnFjYyjntIkavmiGy/HgM3XIOU
         5sHJQpOf/QWQR+au4FejceBS2Xx3yMl7OIhOZGCbQ27+8oM0Wcf3rS0qIteeyy1nOlMS
         BLskSxxEXCTxPsqbUnHShY+atmWimcOsMGygWjoNBejKpVb73MPiOBqX25MLYHjd+gYA
         /Vbp3aRJIxjKL6nlxKvbvMzcX8ycByzBCIAeg2JMCVtljhTRTUbqqSk0RZMPzzhjA5k8
         NIpQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxVSM+qvh1RGdFgit289bt2ZbJGcgkfueDCsdkPz2TGA3BYtlS0EL0cellWgQoUaZNzG1eD/+XkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmA3dYv/CKbNxNBBzwEt1crKdFZ8UzP3qCO8ltSWscEpqgfHG/
	1WPOWh4KOO3CzsXxLBQGeDCW7tADolq1Dx1T83HVL7WmSSwaDd55BHtYZjraAeOzBaUdUnpmLFz
	fUq0GPHxNaeGA3XUp7Rz2OW8HqTF0mRjsGOkQVnTNVuwF2ZkGe8LdjbHBortx8ubvN4cANw==
X-Gm-Gg: AfdE7cnuchkaiaglbue/D6856naPqHU7eX6e9gtpB2sCXrk2X7ojzER2Z76dE4FXDpF
	gE8fd4bfghYWyyB/hkHgQ80klSIbeaCnWAHPCZLXwh37NiHB1YX8VLFi6ASsqM26RutDqLlAfgG
	SZf9hkqMcNcDzXT+uV/nu1Wpf2DnZIq+7XDvzRIQ/cz0u128Telw1qK+mr21gBEbLOjE2kxyxIc
	5AWcIdOAOmCiBr2alL5/kAohJ513Xy5sdbJppli8tS6D7bAimxk8Epd8l15kSNjlJIc71Ujip6L
	nsEuqCiLQPhZrYS6uubFBEycHGgtq0f1ZZJQBn+MRDdfsak+SYyC4jRf1fbcWRyvcPTFuSKBsDo
	plZWl/oDxzeKcSbwJ3rzTMbjCqRmL5+3jKNDLWrmZiSJErvu+cTONngoCivDOwDd6
X-Received: by 2002:a05:7300:2213:b0:30a:e52f:9bcf with SMTP id 5a478bee46e88-30ee131ae36mr624156eec.10.1782765431286;
        Mon, 29 Jun 2026 13:37:11 -0700 (PDT)
X-Received: by 2002:a05:7300:2213:b0:30a:e52f:9bcf with SMTP id 5a478bee46e88-30ee131ae36mr624140eec.10.1782765430814;
        Mon, 29 Jun 2026 13:37:10 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab20921sm699283c88.4.2026.06.29.13.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:37:10 -0700 (PDT)
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 13:33:36 -0700
Subject: [PATCH] pmdomain: qcom: rpmhpd: Skip retention by default
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-rpmhpd-skip-ret-v1-1-d94180ad9a29@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKDWQmoC/x3MTQqAIBBA4avErBtQ+yG6SrQQG3OISsaIILx70
 vJbvPdCImFKMFYvCN2c+DwKdF2BC/ZYCXkpBqNMr3o9oMQ9xAXTxhGFLmwbZU1nvXaOoFRRyPP
 zH6c55w/neP5NYQAAAA==
X-Change-ID: 20260618-rpmhpd-skip-ret-430a25af1cce
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782765430; l=3111;
 i=mike.tipton@oss.qualcomm.com; s=20260305; h=from:subject:message-id;
 bh=NoBxgTpHGJnabz1qe5DLBuL00WEPQMYrLj1bACR4WDk=;
 b=yqJL8wqjDaJeajSkR2uRKj2NtChl4CnBuVvnaM16A3rn6cAB3/FgW++axnEGTBFLcZi4eK6KM
 AavL13yNnybAvKqrBD8jcOcDrcr3SMG2mxWdich/vTKBV9o4Rvwobv5
X-Developer-Key: i=mike.tipton@oss.qualcomm.com; a=ed25519;
 pk=vHBMZwmy10j0Vmh8WgVvBGg8Pt14yalDIN7LBSoSRZw=
X-Proofpoint-GUID: xhmkGLtb_9A4ZuS4Ti6eDuKiOmSrqX8y
X-Proofpoint-ORIG-GUID: xhmkGLtb_9A4ZuS4Ti6eDuKiOmSrqX8y
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a42d778 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=r5Zemlu_opgY2UB85KYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE3MyBTYWx0ZWRfX9jyC9PZn2OjU
 ppXFe2rvS8S3MpdQ8+A/c9gH/x45gcyhHlLpp50uYJHIFocAB5vFy9SA3XYvddPVr0CFZLiNaYx
 K38qfrcglMUCoWkniQ+i4CXFrdT2aGQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE3MyBTYWx0ZWRfX4z6i/yrDDEmX
 s1cu0FHQ1dC0u3YfcHCtzMyW7pLEr2UTFSfzGW3eAEf2dBcWByGT1fZ79tMTsJm7WvTNiGjoPMe
 w3Ze1uHMccbQv63EOMgdPFvMMaLwn+GFZAjHW5X6/mvaMc2XhprmHnG7fnRs/TWrrbEljmKZzYA
 5GGCmgmUeK8cjngZVlBgDOABmvox8HnkMAH3maA/YkubJH8zoPS2EcmObMNF/326aknvnBhVv2f
 iUVx/04IAYSMB8TN7y+BDhdo1QZ6XAqLpZ8kZKgk3IcmdiqhwPlIwGt6l0dsFjPbwdDvk3WtHbu
 uX23BXThcNpUxiOHFSXvYLjSma+8jCIi079YZRbW/KkkqnMWT/IYriYy4CFdtheMQ2PdJcfOm6w
 6+3RKOcIyThQv2GoWJSZDOObE/ePXXdDg/BePThV1NM85I3yb2L6xUNu46UulcqZ44UJuoS9Xrg
 +sxnDayGJtf7HHZxE2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290173

Retention is very rarely an operational corner. In the majority of
cases, HW cannot operate properly at Retention levels and so the minimum
operational level when enabling a rail is the first corner above
Retention. A small subset of always-on use cases can operate at
Retention, but those aren't controlled from HLOS.

Currently, we allow Retention by default and only disallow it special
cases. But this leaves us open to various failures when the PD is
enabled without first being voted to an OPP above Retention. Such as
when a child GDSC PD requests to enable its parent RPMh PD. In this
case, the GDSC would get stuck powering on.

Newer chips have started supporting Retention on rails that didn't
previously (such as for MMCX). Instead of adding more special cases to
skip Retention on MMCX, start skipping Retention by default since it's
almost never desired from an HLOS perspective.

Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 63120e703923..35c598b33ac9 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -41,7 +41,6 @@
  * @addr:		Resource address as looped up using resource name from
  *			cmd-db
  * @state_synced:	Indicator that sync_state has been invoked for the rpmhpd resource
- * @skip_retention_level: Indicate that retention level should not be used for the power domain
  */
 struct rpmhpd {
 	struct device	*dev;
@@ -58,7 +57,6 @@ struct rpmhpd {
 	const char	*res_name;
 	u32		addr;
 	bool		state_synced;
-	bool            skip_retention_level;
 };
 
 struct rpmhpd_desc {
@@ -191,7 +189,6 @@ static struct rpmhpd mxc = {
 	.pd = { .name = "mxc", },
 	.peer = &mxc_ao,
 	.res_name = "mxc.lvl",
-	.skip_retention_level = true,
 };
 
 static struct rpmhpd mxc_ao = {
@@ -199,7 +196,6 @@ static struct rpmhpd mxc_ao = {
 	.active_only = true,
 	.peer = &mxc,
 	.res_name = "mxc.lvl",
-	.skip_retention_level = true,
 };
 
 static struct rpmhpd nsp = {
@@ -1093,7 +1089,15 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 		return -EINVAL;
 
 	for (i = 0; i < rpmhpd->level_count; i++) {
-		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
+		/*
+		 * Most HW won't function properly at Retention. The minimum
+		 * operational level is the first level above Retention. The
+		 * small subset of HW that can operate at Retention isn't
+		 * controlled by HLOS. Skip the Retention level to avoid HW
+		 * failures when the PD is enabled without first having an
+		 * explicit OPP level set.
+		 */
+		if (buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
 			continue;
 
 		rpmhpd->level[i] = buf[i];

---
base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
change-id: 20260618-rpmhpd-skip-ret-430a25af1cce

Best regards,
-- 
Mike Tipton <mike.tipton@oss.qualcomm.com>

