Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211B33D512
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139185; cv=none; b=q3b3RWttmdU6mCTecZnMW0WQU7Be0c+Psu2ZeLJb2UfTgjCASR7QAPzQoio77D5KaaNQ1URBMO8DcAt5cPCepl04cUOvVEmDs5lce1iJFVbIhesf9MBUox3TH8uwdGCK6aygp6G2No+TRXChjazRRFWV/sRMsqlhoTaBxawNrUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139185; c=relaxed/simple;
	bh=Ce9+SAsfP/+CFmQPP39cghQOIDmK1UbSevA/koZEFho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFE1lo87vqhevQYQLyLnpp1/FLCGQ3cDxVUcLxJ+GDIqutHWjs3Veh6oI6YogA/wCuj7z92i+90G/Khs9DFBUy8jNtbZnY6bUyus6whRFNS80oamNuNgyZKqBOf9ZAwjzbSJ7QU1hqdRYHrMim6rjd4GRyASNnBtpsn6TpT8mEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HGgOiD8V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gEh2SDBi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HGgOiD8V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gEh2SDBi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLCj5t2387051
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tIla3JLeBXd
	KNdERyaSRd2/nhYyuYQKd6ooLh2sH54Y=; b=HGgOiD8VPZn5JAlsOB1hVye+xNL
	rXK6NjTXhMgqTExImDuhgZSNzm+AAni/4YCSBJyvVXp+rrZHRhGKALxY8gSX1e9/
	au4X3BXNW3Z1UVD8rArcNOJ2TmLoiMkA9GwGd2Ab5BwDAR0MrvBQhvMvVV4lDZ8p
	Opzwq1LI20H+U0pRWTW10ZHNHAKrsLnvyNVR8/n8vY/IRMxtKtKqM42SKnE0kpOW
	RftD4Dse57sStnFLcvre19k5qFeC1JHroyhfI5AeCp91Zx9G20Jo0Ddv2ksGmg7R
	THePQ4ccNPOUUv4H3bY4EqhVMAnigf4rox7Bdo0ZiJF0TFugNpjcJhXL2tA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86w0x04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so5983860eec.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 20:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776139182; x=1776743982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIla3JLeBXdKNdERyaSRd2/nhYyuYQKd6ooLh2sH54Y=;
        b=gEh2SDBiedX0Bs/KVIZ/inmz8uOozpu9thJwIBwM5hMOwkkXF08ll1XrQovNWPKRo7
         An+PZsbavahluBooyUEm5sgie7apArgJhoUTBTra/UgaunIs6GB21s2eB3I4nPtAsJjN
         OgAnjQ/Ox8LPh4G4sGVw/9bHGCVwQz8VaBI7ye8TbBPthvuKV28DArt8XrFDOZup48KW
         VRi1b4hZf5IhlYEwHuVBsoX/8kmmvzjHmnpmGjEVhTw96MBEB03Dj62sR8o0xIxwOP3N
         L801PIqQC6lN6P9aaV3JhzsCWHwS8ezHVb7PVgpnRhCOnzZ4sckUUt4Hspr7lb27M8ap
         fCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776139182; x=1776743982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIla3JLeBXdKNdERyaSRd2/nhYyuYQKd6ooLh2sH54Y=;
        b=dnasPf6GFurdbBlXN3SE6w6h6DjmZbzR06qPo5/g8p7i9NmNwvL/sPNvBLuQODKIHR
         k+zr1Or3VMEYJJL40V6A78PwSZTTW7a7+aT7gnaGvlIERWqxzp4BPuVDICMF76VHpIta
         +4DT4GHcYS3J2k76ApdmMDz9HfhVaBpWpYWvREvXC3QAYb9m1GB+hZoH+thBAoZ1D1E5
         hF5pQ42r9YC4BzZS22hysXujAkeuPKBDGSiSgO8aeEWP4WuOx4crAW/xC/UnFFXhR8VM
         jfwQLc5hodcTERV/k3mOn3r7DYeqYw4tPLpY2ZCknjUIUpsNQsZeqCQBBfhGa++59+r4
         D3BQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PGZ2LE7KwJI/3doc8s29tlc/mDg7+qsDdGT9kddmjlhNAWMod41aPJvw4fdKdfit5s9++Frm3rA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/vZuHE2bMjseg5BOO3gGrIcylKXysP9U+ALwlfV+5bq3RFMtZ
	h3r4hxfxcSUpuTdrfKhKFCKTceMvFOImOYuhVIl9ZRfa8Au2btOedxWzidwUA314t9Oqls4ruWB
	avzqeYsAXayYUoVNSrPcfR+u/MMcHYq5IVy9710LqMgwVK9GTULKLgEeqkKtXbg==
X-Gm-Gg: AeBDieve001cVPTqHRDR/mInMTfzt2zyKpEtYBESQzLu4bOxI2PtVioCl/RMA0Qox5p
	w5juHBN+EyubZZqLCNFhkfLCmNBXZjlGWvkMdHrQfLV7J4/hyJ57c+npKn8uI9HI8vZljOXTs2h
	rg8roRH3Z5lKAsTvHPhoAmA2UhQpTkKZZ2H0hosIb5NgEpUG7bCZhmwGjgvOjCfqL5UUp2Z1AET
	jnGaPFlpH1l6mtVCIf4wPB1K5QyQ7CcFkS1Hkn/TJRvlea2lCy9QclkCLNvfyxhGDpc2nUmnFiC
	42QXvIpjfAHDXsdWw9tx/1B5ri/Y4GVNk/r2cU7j/6GSG6yRTxytJV5eRIn1UeB54fqaSv1+V+k
	eHja6FQn/vBCn3b28+APiSFtFSTImB/WMXVWBA5HpNrOmxx1XqZHJCVvLxWJc7ZDVk8hU17Rmkk
	uHbscP2w==
X-Received: by 2002:a05:693c:25c7:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2d58678f385mr9574991eec.4.1776139181668;
        Mon, 13 Apr 2026 20:59:41 -0700 (PDT)
X-Received: by 2002:a05:693c:25c7:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2d58678f385mr9574977eec.4.1776139181156;
        Mon, 13 Apr 2026 20:59:41 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d80acca4c5sm13949983eec.19.2026.04.13.20.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 20:59:40 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH 1/3] dt-bindings: power: qcom,rpmhpd: Fix whitespace in RPMHPD defines
Date: Tue, 14 Apr 2026 11:59:07 +0800
Message-ID: <20260414035909.652992-2-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
References: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6i5inFVxrgvGUHXxgXg-zS-wqomDwhSr
X-Authority-Analysis: v=2.4 cv=HKfz0Itv c=1 sm=1 tr=0 ts=69ddbbae cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=6qMARqoqku_Fr_bgoQ4A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAzNCBTYWx0ZWRfX14irGKNf3d6g
 bwlJFU9F07aNXPSiIWk6NmyHepv3WWfUbF5MvctPuJp3At1Ad/T12h+rh7P1B078kPt0IgIkdlp
 kjmi0iTQujdfm+XzsuS2whksSL0NRFtMyg70acyefnoYe4titWDvZ1TeosFWDA9fxDhYt8alQVc
 CZy+RNjGfSrMVm/2uG9ivGoJPlTJUj9xKytY6eW++5qlbwoqMppv1B8lzJ/FHFuGTZsaqWuqHs5
 7nfEindI23FR/YSUwy3JpDYxIWG0xt6itvxiTsVdChWoYZdD61N1nBHOqSHHeiE6S0IwuOIwphK
 32rMcd23OwYfZwR4Vz0ZeCJTQlIg1cHe8ITe3wnckP3GEZ21pzujSVm72Z3lYdgSfZP7jZba9xY
 6fjxUV2G2b9p1OsD0GkqgbsOLcXpKnxzJVK6ElA1wxDHgL3CmGKt9AopRTBi/C1OQaiLIkq9Dma
 IumeB6/OaK1ZnD0bNQA==
X-Proofpoint-GUID: 6i5inFVxrgvGUHXxgXg-zS-wqomDwhSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140034

Some RPMHPD_* defines in the Generic RPMH Power Domain Indexes section
were using spaces instead of tabs for alignment. Fix them to be
consistent with the rest of the file.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 67e2634fdc99..74e910150956 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -7,7 +7,7 @@
 #define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
 
 /* Generic RPMH Power Domain Indexes */
-#define RPMHPD_CX               0
+#define RPMHPD_CX		0
 #define RPMHPD_CX_AO		1
 #define RPMHPD_EBI		2
 #define RPMHPD_GFX		3
@@ -19,14 +19,14 @@
 #define RPMHPD_MX_AO		9
 #define RPMHPD_MXC		10
 #define RPMHPD_MXC_AO		11
-#define RPMHPD_MSS              12
+#define RPMHPD_MSS		12
 #define RPMHPD_NSP		13
-#define RPMHPD_NSP0             14
-#define RPMHPD_NSP1             15
-#define RPMHPD_QPHY             16
-#define RPMHPD_DDR              17
-#define RPMHPD_XO               18
-#define RPMHPD_NSP2             19
+#define RPMHPD_NSP0		14
+#define RPMHPD_NSP1		15
+#define RPMHPD_QPHY		16
+#define RPMHPD_DDR		17
+#define RPMHPD_XO		18
+#define RPMHPD_NSP2		19
 #define RPMHPD_GMXC		20
 #define RPMHPD_DCX		21
 #define RPMHPD_GBX		22
-- 
2.43.0

