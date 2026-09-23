Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF603F58D9
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174075; cv=none; b=Q0WlV9H1xwreFw1mnNO9rLPeLuXmucPq5Bjx4O24tS48jj1A5Gx+tuK61LEHXPE7CkJhdfXwiCqT3wBdjEz4TxbkY0hkM+GIhv4rXCQmxdp2EUhMdiWljVIEZcPxRLKSXaD9Mgo9zOon4CRXVvRxzzAUlB1WlMef+9nPaRd+Wnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174075; c=relaxed/simple;
	bh=Qrnv8qH2T52Rds3B+tQNiGt/EbIPH7XsOJpXNsPQrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfnQ7E7v8++mJRdmqImXuJDZfjsZapz61jVzrOM2WG0SFt82XaZh2Hyh0PHCzTQPV2hZOJBWMYi5Tm2VfCr/N9z7e5VmS1Phpt2EUrv3nKbJPOY5kyv5jnIyV0TJl0UvfFqYZPfS1j5P/4vGqt6lkVpCb0Hy1N9nPokonokDWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ikQ1ZZ2B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RZxgGuyp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ikQ1ZZ2B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RZxgGuyp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbh7r3772305
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zIe6pwh84/c
	gjHJc/ZPARHNyhcZMHDOU3m6rWSmarLw=; b=ikQ1ZZ2BFuINY/2LgptjZuBxSZ9
	maJ8cvWkja4BeenhvIDsjh8wgPedC7Xw2N5feeqFdBY23San0Dj7Y2BwvSOLGmH9
	AkvnYGBtSNqe/5XclDKw2z7kJXLeCkNyjuns8IXQzJouYNEsyhSdaH2x1RRmkXAw
	TO4V19U0GGeAO+/0GoHDKMa8MfiPkGXJjUYn3mxBRGthvc66EBYTux0B5m4Z+SKR
	uBedOgiyg7oAgvPe/kxRqBSZ+TCrr2AgyOJzlOUL7Bp7BXAtr4/ywiO1L3fsYfuN
	kRAHhF9ZbaVhiO2f6nohIyjr9l+x6u0ijOwB/7+8orJL3QELqqCv805Cqqw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvdb60vv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:32 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7909e307799so849257137.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790174072; x=1790778872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zIe6pwh84/cgjHJc/ZPARHNyhcZMHDOU3m6rWSmarLw=;
        b=RZxgGuyp30paNOCtp4x4aOLjOn8hkrKIJ3+DvmAcQ4KbkG6qWxW4UrWUz0AvkRFxRC
         Ufp03T/CJ7cMj57wYeceeGpy+wk/9DdrudoDIqz9wYTIlBeIizid8cPN+jzC/6+8sAuA
         8q8Rcxcx8xUeR7CXgmz11UMN2OJNioHfpo49csQ/QX1pCcuTiUQIO55fbcFZhlQ4IZq6
         ul1RTQVXTJcA/9vaRbD9X9SvVX7i75JGRKMMgDW3SKnPlRIwg6XoLJXSGiexlgi60XSW
         jNPbP3XU72ZvDIjzAfIHVeESu2Z3GltJUdn2HG9fCEksibcB+n1FP64QbWHpc6yVF1/z
         W5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174072; x=1790778872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zIe6pwh84/cgjHJc/ZPARHNyhcZMHDOU3m6rWSmarLw=;
        b=Uk1jivXkvqytNZ/SzaK2wSmswH1VvoYncZdwy6dvmUaEEYxvnjhdm01ve0fB5ZSVDV
         USQHp3oqIf7GfH87Z6cXS8AB6Hkz9dHuesZ7s83PL9K0k9GZ03KGtwQcXy7QNHWY0Tf+
         3drLHf1yzeXJx2f0dxyW8qmisXYf+Zz3OiYEiErDd2WoTPIqZX2MKVP1/RyYRRxYQHBI
         vPuQeEbepOkUniXkjGILT8vssQ/LtJFnOvgvILp7fSP4nfXAA/uwnr+cOLjIsGm51/2m
         4QHF+1MXkQfsWPTk7YOIkB3gCw9zaqw9ZNEJ5zZvDTXmJOE4zlFs5R7m5jjcpaHBA6B/
         Ccng==
X-Gm-Message-State: AFuF++l8u1KhWSUBLC61k8EfY15lEwgbsHL072Co50fOVIk2YW03vSw8
	NF5/Tl+fapoz2oc/LrOLIrmAL+HaJwpDQvjK4chXyI3sb0Dbje1grXUxkiJHqbd4zwcwOOYSTKT
	O+tU/t6gnJ9xR8RU3+0HD+1EhvjXcxQWvBZHFVjckQWOgmkyES72L1l9Khy0+gg==
X-Gm-Gg: AYBFou0nMjRdwV4RX/YDwmBknOdUJYTrUJkVxGQyznomHFkPB3m/9J3J/DvlwWGVsAz
	9d5Qwz1xt1+uJy2Hoxpv1TjaK0NdmnaXTIrMmuqmsQM6Q+wrF5tzG7MzXxyolDzttiAfkFe2sy8
	Ddh+Lv3neFPO9swdoYASMQvyWvi2+lMMVgjrLS3DT70OTfQBOI+cmUPO7Dm9nhspxW1Ym0qws6O
	XPPk39sy2JpK3syEY6q9D8kfyOmsorltdbIKb9I6aVLG5oILartFAsuPreyzZ8hgDd85rN4aUI5
	mfi74yZjBlPRH4a/1doAyxv/TGyahOKCeFFLd7K4ufXePR8wMBuI2OUn65Ti4KrrQ7VX6w5L61C
	ToxjvO9SmqsTQHetNoEgU15bT0Tk=
X-Received: by 2002:a05:6102:9d6:b0:7a7:1b62:2d3 with SMTP id ada2fe7eead31-7ac1d705bd0mr2441612137.37.1790174071814;
        Wed, 23 Sep 2026 07:34:31 -0700 (PDT)
X-Received: by 2002:a05:6102:9d6:b0:7a7:1b62:2d3 with SMTP id ada2fe7eead31-7ac1d705bd0mr2441596137.37.1790174071365;
        Wed, 23 Sep 2026 07:34:31 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a913:ba43:96d7:743c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm58213905e9.0.2026.09.23.07.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:34:30 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 5/6] powercap: dtpm: Rename Rockchip virtual node descriptor
Date: Wed, 23 Sep 2026 16:34:15 +0200
Message-ID: <20260923143416.3713485-6-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
References: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KGVXVSnv3jKaOCgjM9fhXfiac_JCUC-T
X-Proofpoint-ORIG-GUID: KGVXVSnv3jKaOCgjM9fhXfiac_JCUC-T
X-Authority-Analysis: v=2.4 cv=QeXzLcbv c=1 sm=1 tr=0 ts=6ab3e378 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=_NZqlvP9bvTAGtRSC3sA:9
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX1zQwRybUOx+k
 Hc/IbLlu5tsltlkJcul6HJLfKWdD43ZAXgLr18MtdqeTMgKdZ2n+CXMN4iMg4r8LucydZKxmwoT
 NkorETc8q8kKFUoUGq5O71NrOpCpzVY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX7Jilce3b0xlc
 1fzzSjQA+pCCIE7+ic302K4oWf3X4EFOfa94vau4bQQdsDCxudcPcFXNATBDlAzLn8v3QKD1j0O
 Cbj/Ji9L4S+ceiJbOnczCiLCVD0iKAIP1PEzyvK/6UGwT5EzMmW52RuJ8lqp3xZNwsIhLN+vLS4
 3UqhVJQFnjObaG3mS25xj74hySerG+kdpEPW/jlfSpceRChza4vKCtO9c4vNdMUEpLbqHoG6vk7
 eARDIxiv68E/itGmds7LjMpH86B2T/t8G1CaIlQ+rW70NH3aFL8T4Kzo17WwN22cZOn7bJI+SP4
 Xzt9IgS0ZOwpN68fT2A/5usbWaMkXbjDkVxHFGlDNoCtlhcadUXG5OHitPZphqY5DtL5RdADzVT
 A3/87pnN09XQhfrAcL/quvHI8tQfV89YTbi+RrAdR3Of8C23XT9w/nS3VFUSXGaZYt13a/AFn8B
 7cRIlZB/BaK01RYfMeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058

The virtual DTPM node descriptor is named after the RK3399 even though
it does not contain any SoC-specific information.

Rename it to rockchip_virtual so it can be reused by other Rockchip SoC
hierarchies.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/soc/rockchip/dtpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index 451417ae5715..5f7f238a15fe 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -11,7 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
-static struct dtpm_node rk3399_virtual = {
+static struct dtpm_node rockchip_virtual = {
 	.type = DTPM_NODE_VIRTUAL,
 };
 
@@ -33,12 +33,12 @@ static struct dtpm_node rk3399_gpu = {
 static struct powercap_node __initdata rk3399_nodes[] = {
 	[0] = {
 		.name = "rk3399",
-		.data = &rk3399_virtual,
+		.data = &rockchip_virtual,
 	},
 	[1] = {
 		.name = "package",
 		.parent = &rk3399_nodes[0],
-		.data = &rk3399_virtual,
+		.data = &rockchip_virtual,
 	},
 	[2] = {
 		.name = "cpu0-cpufreq",
-- 
2.43.0

