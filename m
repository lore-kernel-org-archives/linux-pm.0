Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316E3BFE5B
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360254; cv=none; b=dAfeJ4ScJ9vInIXHBsc+jXMGuJCakzZ7m43lnlhjw1X6usUB8oMrcWVj4wkj4uC2CWW5HzyoVOayW7aFda+TBnDAlNWECp0rQSvm8w+6UxmAfsUCHpNOOlP9adJTUD2ubjnXvnNp1RGNN7P0LGJei0Yo5NhyqTeM6rw/Bgz5s6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360254; c=relaxed/simple;
	bh=A0krs6Bck7EjDJIBG8xA4ndC5PfN2KdNtnF2rLmI3VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iy3hsIE+awSlzx11/1a0NiknrrFlaqc1NX1ccRq9SpfcEgJwHB8fyPORBldlt7pwSN9KbiNm3MsbzV9oCPI6+0qH1/XoA36RWqwy3DR/0no+wI+ZOajzUfF6BFjs8e4VU2db115Lb2rWo3Rj2Qnm4gHOlQWPk/R/x/YTkI9HRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mn1nJ8M6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kCGNqio3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mn1nJ8M6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kCGNqio3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AA08uU009863
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TKbFuaww8n3D7BMFAaE4ne
	biGBw0LjKgLO9bnPYoC/I=; b=mn1nJ8M6X29YGQhL+yFYRYPv+N67mPEJo8gJCb
	xOjeVw6cLm4l/dVe9DHlHMrsg8sb8gySl5YxzuOo1IDEbgzkH8A5HwjsHdpukKQ1
	hRKdZOEuF7FBLmKnW+7DQzedFDb/BpVTbNk1TvxyKuGmuY7w6srTMN+Vktg1gEli
	8ccujJwfZOUD8z5HDn9uatkztyvU1WBIPqqXj9te7IRZSF4T+ayU2uvVZ5JGAM+E
	Fm0Q6Bj54DsIfkbLsfClcSCpXtmD29HFRzCFa/+fcharEqTqxgw5zNbgnDEN/XRx
	0NGmKTH5+KEsU/KdGyCz+IXZ3BrT9EZLdIDMMkIxkQ7UtZmQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fycger837-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:10:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c07f25de2so13361851cf.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786360251; x=1786965051; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TKbFuaww8n3D7BMFAaE4nebiGBw0LjKgLO9bnPYoC/I=;
        b=kCGNqio31b0b2hQXAlrx4M4C21a8ylQqBClGDpyvXmsIoGSpkfb6961XiruI8nokQQ
         hwLNY3Jo38mtVHWX2l5ezdx8Rf/9SBALQEKSvzpUqwyJka5ircvtw3Ax5oeQUeed+CW1
         KlSkPdagQX0xrHq9bguRYm22YmjUEMSeP8tdiZHqyy+peVYWD+ZXJzq6ogc1XvA9CHi8
         pKp/OXOJ3gVctlgwAIJbLPeIbX1mkAi8RL9QoctLRuLcj1txONoBbeuQs6seHdOAbh5A
         899EmGDTPz0o73OgOXpdG9Gp3xaUk9Eaw+htOh8srJoWQPdNYQKjRuRv3ZXdZs4GI6wF
         8YQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786360251; x=1786965051;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TKbFuaww8n3D7BMFAaE4nebiGBw0LjKgLO9bnPYoC/I=;
        b=OfhXbm+P+wLmgQBoRAfCoVr5v5tYslKauRxDipEaqZNhmCxbTqTx6zX3SfHGqfxHcl
         cdQ89BHg+nBmyA7fUenqnhSCvb3W96G/0nD510IhAiPlpSloEVQ6x2YlcJhCMXxsQ6Oe
         SkeBfWmGGEdNiFvF5AEA6V/S/ToRXNAhx4FWI/8iyIMfRR8Bw1QNvQoEO+JY37SgEuSm
         H29D8em87KLebjOgaYQam+R5ILE7UJsbfRwxDNQ95muUBPQgD3a7YKvUMHAgDY+LWxfJ
         pzl/ojGnBzwkvEOnCFrMcs7LXr+WkkcHirGadzJbCHxOBj9ZXrMsCc6DOaekFmfKtnjv
         zg4w==
X-Forwarded-Encrypted: i=1; AHgh+RpsBfD5H6/9Gk+Jsa6/oM2wJNdAYY/BcmbdirtsyRJeITAhnr2+L4ghCrSTPoAecV8LO23ZfDctKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQxXs+DA4PUI4ZHJMSuIND6eGYSyRcJtdw3PE18PKGyNPT+KE
	nbAAPVKp4/w524Mb4ATXnN1Z8rrzxnqkqJkhzP07OqN6LW9hUxodIc4KBLsAdZmdCMc5jhVJDQm
	Ckzcq4HCNuYIqoI/7+4GP+7i774haQ5/pXUd5MRxZnBmaWEJ4QxIcE8C7odCjMg==
X-Gm-Gg: AR+sD13822rNVIpMY3kvgDaWFPziZej1gVRnXVWH3jNmW3U/zZ3t8MRWN+DrPV4p3+5
	tuHWoKMoWOSy0BSsm/ne3DweUCWWeGw++SOUNBT6gywSol1+Vy8ua/GhR7iyzEtWbkr0g7YgT02
	RPX665XIuX2dcUubplwHHVYyEUfRxnEVESqJ6SamSqxDz5eijmTNeYb6pJ6XUqMPHkDzVu+AQru
	BLH69gjA8fi2bOOjSBpIy76SFG3dXHoWM/ibJFzyCWDHl6O0zfpQvFT4+oAXSgn8P75ndkrsdmh
	Pid/Qc9KNksUi24hOc/nUWpF5vUBN0gDhKH6L355HGyd4eST8epRC3PChnhVSRyCD2v0dUd2WOC
	lr5BT
X-Received: by 2002:a05:622a:228e:b0:51c:6b6:9d0b with SMTP id d75a77b69052e-52d2092d7ccmr220634941cf.2.1786360251068;
        Mon, 10 Aug 2026 04:10:51 -0700 (PDT)
X-Received: by 2002:a05:622a:228e:b0:51c:6b6:9d0b with SMTP id d75a77b69052e-52d2092d7ccmr220634461cf.2.1786360250490;
        Mon, 10 Aug 2026 04:10:50 -0700 (PDT)
Received: from hackbox.lan ([82.77.85.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021fb89bsm32115893f8f.30.2026.08.10.04.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 04:10:49 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 14:10:38 +0300
Subject: [PATCH] pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power
 domains for Eliza
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-v1-1-5e10fad1e456@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK2xeWoC/yXNQQ6CMBBA0auQWTtJS4SgVzEuSjvgGKclHTSNh
 Ltbdfk2/2+glJkUzs0GmV6snGKFPTTgby7OhByqoTVtbwZrcJGQxHFEFwIKq3KcUYpHEV8wRaQ
 Hvx32kx87ezLHgTqosSXTxOU3ulz/1ud4J79+67DvH0pilbyKAAAA
X-Change-ID: 20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-6fcb519048e5
To: Ulf Hansson <ulfh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Wangao Wang <wangao.wang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=A0krs6Bck7EjDJIBG8xA4ndC5PfN2KdNtnF2rLmI3VA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqebGzglzE90RLi0vS4UU6LhLij1gvpxufle6Kk
 IwF2wU2nQuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCanmxswAKCRAbX0TJAJUV
 ViolD/9VmWNHFWXKIlH8cSkTT8F6TM2mcSD3ghkCgSCpe5sw33qMzvS+IR6xUMamFIhYFfg2PN6
 A96Fj9ug7MMpp21jK9or+RlNUcdt4jJU2zd1N3IypX4PJemAZoFmK2rXepB0PDQt84cr9ITLE7f
 A6c4MSwfy1WJKD7MPQhn1eHk3NGeGl0JjUC9yknvud4iAfaM5pOLWBRdJ4UvqkXWl1veIX94rWD
 y1FvrKZMQ1sX1IYmXcFFnMQK1ys9QUbxMGmz0WL6ujWqergTJPDxOjVlAQc1Du0s2PwSdnBg+ux
 nHvNN340oFpC01Hgxlt+coQJoif5KpDqJl9lD73+fZ4v87R34uVkEodV6fyoG1xEqrKlFo+M8RG
 RLIW5PV2AXsScnlX0gf3PT0BoGHgP5Rkd2bkFe2eubuNU0XYr55lRQ2RvTtD9PYy8RHHImKRX7W
 ZuWp1ElIWxdSPQcJxY/PbeFPJ6azb+APC43WRkN/ItGAB0962WEZR1+fajSNXLqZKFP918AgImm
 kPVB9NeZk8p016tIYBxp4Qmm5PR2KECw8THVXslloEdStfXAnFujyXGgGltEDf8k69BVj39YvRY
 WbmA+kRrDM9rgpIiqObetJmhXQCYrnQmJ8qGDoWMB4k5pHVk80AMc6CXtEJFp6NAz7YyBAXghMJ
 lhwCi4L0MfRESAg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: 32cMTaxlu82vISN5VuSFiL8Qqb0usXKj
X-Authority-Analysis: v=2.4 cv=R4cz39RX c=1 sm=1 tr=0 ts=6a79b1bb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=GMu+mMXmPKlJm/I3Pt7gOg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CmDW9zyJ3gJnRC1ms4wA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 32cMTaxlu82vISN5VuSFiL8Qqb0usXKj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA5NyBTYWx0ZWRfX5FKj1I7yd3CQ
 CysR+fNZXWanc9pO0LvsLLwmQIk99+Dn3uJEeZyk/1J4zfz423Lo41LCu3tINzgN3RJxMmQgzkM
 LZBPJQJ9p4luojKlgXNRN8Gm86gtl4c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA5NyBTYWx0ZWRfX/Wud1eKdgJL3
 DDzihy1IuHUZRTAWh4rRw+55WSy39U3zWyHSB2QA3q3NY51+Q8l1JaoWBLYKOg4z6rVAols9mY4
 9qOF1XNTxW6UDHE4gAiSNtvosSthz06dqtsgvD459+7JSKywqLNbLN4HIOOx2uIaFY/jFrX6Jrz
 3dDGIhojIxMImNgT6rmX/0XlgjFjGNA1GmqJx8sOURNvmJJPw+TQmvuAmBAaXot1f+DlejKrb6B
 Q/m47QZvaRb5hisqLVy1v7Lr+6oaDQmKsOSJ0EfmrDP0USY6teQeMzNKFC19L6oKowr7m5Ruq34
 XitKss/SK4nRrJn6obFo6jXOb7UCpYlTM1PC3JiyW0UmikeaMKYIUler/zPSydCxpmCpifkbISe
 WFYDCJVasRuiBD5+i5VKvxL+s5ZUbcI7H+3S7fJdPfV3NHPcQ69dnlxS2vBWzzj5bJJGzSEnRjJ
 DMM5QpOG7O33O6Vklmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100097

MXC and MMCX were initially omitted as they were believed to have no
consumers, and they were not present downstream either.

The Iris video codec requires these power domains, so add MXC and MMCX
along with the MXC_AO and MMCX_AO.

Fixes: f387ecdd492f ("pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains")
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 90743275942d..96e4bd2f5a14 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -241,9 +241,13 @@ static struct rpmhpd *eliza_rpmhpds[] = {
 	[RPMHPD_GFX] = &gfx,
 	[RPMHPD_LCX] = &lcx,
 	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
 	[RPMHPD_MSS] = &mss,
 	[RPMHPD_MX] = &mx,
 	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
 	[RPMHPD_NSP] = &nsp,
 };
 

---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-6fcb519048e5

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

