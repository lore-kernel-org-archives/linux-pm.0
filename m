Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376596;
	b=GbLjAPDXCdKpT8Q9wqIpaUYtpxKB3MWhdirZsNHKKY/xCuCv/vijaRnUgiIN622RPDAH
	 0M9Z/OklELfJWHP7pKx0mV+qxqR0+igmU+8Fe28VIC64T9lPQCYm2FYkIFPjx8+upLzQ5
	 mRV49zuF0REXLTcBwGj+cH2bYDzLx8WXNKupByxkqdnGYUX2izMkaEtdlEbfkQMRfAyLW
	 Vg+xlr5aMyU5b72QOCvxNGKaKTnrWFzmf8KSNGIF2YD/vUo6SgZxYqKXd3aJXHYnK/xpq
	 styWrVSqd3CZf4Qq1qSnkgmeywl9nb7pDbsaZobWDlQ5nymGRfmzc10ZquogXhDJowg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1AYa/vYlLDzFz5Cu7GUcbH8FmJ6yEd4e4C14u7b+OtQ=;
	b=ppNuK/iyW6IUjHFxq/CbI8tNuty+B6GwwhIoO7V4p5LxdRIUwgz5O8BsQ2SELh8tZa9N
	 T/1TOBL8iH++VTi+iIohX2gFR/edTIHtb6rhmO+Pmz2ONwQ2y8mtfiQ+E81UzRH1icllD
	 jSoo6YDkOnq3KOr8PjVfCbfu4mU6G3SQuA3WVojtDHpImNFPaZXPETHfdiM5A4e6B0lat
	 rCeAkBf+ofKhtO/x1jDX0EZB88zx8ID20Noj5cTCfyuWfwxJxVdrrH5pa3/L91PI/neuY
	 XDfQhC21wQ0E3ABshmDBt1Y/rl4bgp+iMmjt9yX9kUFRuozr6tmuq0Z6Aed2/gLWY/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ay4KeWRO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gdMHw8W+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C3606A339
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 16:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 487C3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ay4KeWRO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gdMHw8W+
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UERFUp3515574
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 16:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1AYa/vYlLDzFz5Cu7GUcbH
	8FmJ6yEd4e4C14u7b+OtQ=; b=Ay4KeWROteb22jNsNnpmqiD9vdwZdIDane//9R
	MRyU9iQCSeI5A4bZuP/skHDNo8pkiXeGYAagPkOt6AdO+zJO44L0H++osXtjnyFK
	fjnOfKdV3GtWSYnY4ZyS83w0NmhETl2/BAWSimvAUAdHRreKE3zjpmLEhadH6A1F
	vyC/uclG0HvyGh1it4rm7H89hautcvNge/65WoPDoYj2/fcvggd3lZrfs9T8lZi+
	wstwkmCX04y0Z9uIRqXN+rVCBes6JPFzkub6jfifEtjuVSWoivOiYWysfrW7ThlN
	VZ5rFoVeiO2HimC7DOfaQnYOpUM3ftb2R+f3kTfPLQ6D5iEg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkya7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 16:09:55 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf3a0a498fso755305137.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793376594; x=1793981394; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1AYa/vYlLDzFz5Cu7GUcbH8FmJ6yEd4e4C14u7b+OtQ=;
        b=gdMHw8W+BK5aReKWdTiklht8fUZ7wtAhQuVV72BTK9Rjg6Sl2OG9mzsTW8J6f/kKbG
         WTDNscg2+mvrL3zssK7ZKCB3TCNBkVMI0bFB5Y988v7O6l7EiwUwtyHbrEkhfTTt33Rc
         zH1Tz0S8ddiREsehtjITTu96i7pcwLx7r8PzXQRW2bc8myYX8pD6vNae5QJJ7ZMesBQO
         rDuOQySn7PQQuBG1qb23RftOXjPlGs0cg1J8Ri7TBa6zgYCvf7Hqq4BksrPCEGCjnhA/
         hAV++ZmO13kjdXm1YnGfhQ16HLE3Y5CWPBjcIiWfapt1AwyRcSQ7DENAFaVVKU2cOEXx
         czXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793376594; x=1793981394;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1AYa/vYlLDzFz5Cu7GUcbH8FmJ6yEd4e4C14u7b+OtQ=;
        b=oPLAVIJy99UQob/8VOlhHmsfNtBsKo6v4m9pdGjUo64r27PQH75LPF0Sme5HX4V9k/
         +niLgAgeZXBIQFoSZArNKjuzjLpnnjekjV3FlVsQa1NeUjT9t/k91JsOfwiwwDIAP8Cd
         Jpac4jW98q4LUbDk5ac6P6TsKx0iqpEdPhGchKtkcOlINmUNbvdtwuTIoOcBFGLW6sO4
         jPt+dTrTVKOSQeQqUEvYWzOY/OLRDAAfM2to/mmk/cZJsWQBAqqfieSM9xmRy6GZaboZ
         hIDJI8Aju6oYPiWVxurwtOX5JsB3q+qIv5FwB/9cf0ywvidHeIuXnrWYV7VHjPdj7rPv
         xt0g==
X-Gm-Message-State: AFq9FYL+p48bE/mWHldBSD83n30ivNPYtspf68wWTqA4ilODQxuZFCXn
	byo7AaI9UKK4+Z69cEp1fcxLHQg5HquRk45oxAcVugi2R/sDf1zUZT0pQ0X9qmJkuPG3bNRbFzA
	hhZfqoW69Cbh99O/L19yl/pQsriykg+ToOwqC34dFoWP7+P65ko4uVzPuNJt3EQ==
X-Gm-Gg: AYBFou289gic9AMOEmTmggbqmchrmMAgqWpgA3Dxc+fBI+edxkdvE5mvCDo5kshBlTn
	AbWlDa8A6r2m1ltp3A67pLSWXHgthBRNQWYXEh0zZrpdFkk8TIhH4dkOnFw1C3wD0icOtgPmzUK
	wEgYO851EsODesu25EWBXCmrsCpLojdKtGPenzinCBUDWRWaVQxKq0cRxfAiQHygQNJPv+dml9A
	1Aj6Af1wzap/TZMxdfN72lPUtOBEBM1ZK+Gy6OX0Ol643O3AQLscICaWD3wpFFhivuuuGlDAM1x
	AtBLsTW7r8thjsk7BOlZvUmjgUMTRNNqyv/Lx0hD4WJu6fd6ErYEmHCublnbC2yr2Lx1i8GTvz4
	U8D0tOHO8mvfZSB75igEpuZFpFoaDah+EUGRPiTIc2xji2pAeNS0v/naGNQiJmbHmWHxgcacFcr
	4QlAiHmNqxdSKEiR2udlvg6slsDFX5xZAyzWPhSq3tH76VW2I+xGRqMGUpo+TOS8+k4UJhoRGOk
	3PpPBtgexQ1m2JBsNI3nJ520uWI
X-Received: by 2002:a05:6102:370d:b0:7cb:cfcf:3d01 with SMTP id ada2fe7eead31-7d05432ac0amr2197852137.33.1793376594349;
        Fri, 30 Oct 2026 09:09:54 -0700 (PDT)
X-Received: by 2002:a05:6102:370d:b0:7cb:cfcf:3d01 with SMTP id ada2fe7eead31-7d05432ac0amr2197839137.33.1793376593802;
        Fri, 30 Oct 2026 09:09:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:9d77:8e43:b62f:d85d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7246fsm4044103f8f.19.2026.10.30.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:09:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 17:09:52 +0100
Subject: [PATCH] PM: Use IRQ safety to handle sleepable PM clock operations
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-clk-leak-v1-1-db8cb68a5a8d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAE/B5GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA2MD3eScbN2c1MRsXePURLM082TzlEQjUyWg8oKi1LTMCrBR0bG1tQD
 0pZsUWgAAAA==
X-Change-ID: 20261030-clk-leak-3ea6f7c7da25
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: cuguvc2JkdtzegFKBu82elruOMaN7Ip2
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4c153 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=q1VT6stkq7JPu4EZEUQA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NCBTYWx0ZWRfX1qHBpqNRNcJG
 3zsZeHciUPcGM0b91wGi/OeJBWQJHcturSBCLPYENpdI+H52XYVjD73RasfWOLwnkcutp1ispW8
 a96YIs30F8CQ4JBYnUtxHuwDJDQEW9IUtWquFqOAj93PzqiqBLPv5HGcENFm5IEWgOUDnITkXlb
 F82fKJZ3Yjd8U7/Q5Ht/yIVy2gYt1ZnPeIr4yRvl1OEnx431Ydd3B4Y4S8X4jZDqI6ywRV6zr8T
 VM3mYgj7Dxnc8HD5nPvTsfvSTnYP7sIo/R/cOZn7W+sPoMx32DA4kAU16yOr2Ui0cMJ2tHy5N1z
 5o19CXzqieugUNsaQBTM3Qw+r7PuaR4MFjPqb8Yqnk92ntJif1fpHufKWj/p/EKSynWgANpc8Vi
 iX/KI5w6Sc/uYhXtk8hx26Q48O0ETa4frF8tCSdRj+TsYAjo/j5wP5B0hB9yrnQITyAF5Wi6z8R
 cac1nuGReeGa4lIr64Q==
X-Proofpoint-ORIG-GUID: cuguvc2JkdtzegFKBu82elruOMaN7Ip2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NCBTYWx0ZWRfX04lYudDXDKK2
 d8hjx3PteHgl/RB5URE8iWV2PggwPNtjW/5XIdI4x01kt25L6h3X5IcOUaEgNBYBA9xB5tDu04v
 fHszrryW8JeOlBpqhR7EmlVOLpLp1Ps=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300064

The PM clock runtime PM handling currently performs unprepare/prepare
in suspend/resume operations only for clocks that exclusively implement
prepare/unprepare operations.

However, this logic only considers the clock itself and ignores its
parent hierarchy. As a result, a clock that uses enable/disable
operations but has an ancestor that relies solely on prepare/unprepare
may leave permanent prepare references on both itself and its parents.
This prevents those ancestor clocks from being fully disabled.

For example, on Qualcomm platforms, this can keep the RPM XO clock
prepared (and so active) during runtime or system suspend even after
its consumers have been disabled.

Use the device's IRQ-safety setting to determine whether PM clock
operations may sleep. For usual non-IRQ-safe devices, defer clock
preparation and mark the clock operations as sleepable. Suspend can
then use clk_disable_unprepare() to release the clock's prepare and
enable references.

This changes behavior for all pm_clk users. Preparing and unpreparing
clocks across suspend and resume is generally expected, devices that
require PM clock operations to run in atomic context remain IRQ-safe.

Reported-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/base/power/clock_ops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 3b8ba27802a800bac29abd8e21756ccdb0f2a716..b919a1d08cf4611067e626dd1131be870200838b 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -33,7 +33,7 @@ struct pm_clock_entry {
 	char *con_id;
 	struct clk *clk;
 	enum pce_status status;
-	bool enabled_when_prepared;
+	bool sleepable;
 };
 
 /**
@@ -177,10 +177,10 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 	if (IS_ERR(ce->clk)) {
 		ce->status = PCE_STATUS_ERROR;
 		return;
-	} else if (clk_is_enabled_when_prepared(ce->clk)) {
+	} else if (!dev->power.irq_safe) {
 		/* we defer preparing the clock in that case */
 		ce->status = PCE_STATUS_ACQUIRED;
-		ce->enabled_when_prepared = true;
+		ce->sleepable = true;
 	} else if (clk_prepare(ce->clk)) {
 		ce->status = PCE_STATUS_ERROR;
 		dev_err(dev, "clk_prepare() failed\n");
@@ -223,7 +223,7 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
 
 	pm_clk_list_lock(psd);
 	list_add_tail(&ce->node, &psd->clock_list);
-	if (ce->enabled_when_prepared)
+	if (ce->sleepable)
 		psd->clock_op_might_sleep++;
 	pm_clk_list_unlock(psd);
 	return 0;
@@ -371,7 +371,7 @@ void pm_clk_remove_clk(struct device *dev, struct clk *clk)
 
  remove:
 	list_del(&ce->node);
-	if (ce->enabled_when_prepared)
+	if (ce->sleepable)
 		psd->clock_op_might_sleep--;
 	pm_clk_list_unlock(psd);
 
@@ -485,7 +485,7 @@ int pm_clk_suspend(struct device *dev)
 
 	list_for_each_entry_reverse(ce, &psd->clock_list, node) {
 		if (ce->status == PCE_STATUS_ENABLED) {
-			if (ce->enabled_when_prepared) {
+			if (ce->sleepable) {
 				clk_disable_unprepare(ce->clk);
 				ce->status = PCE_STATUS_ACQUIRED;
 			} else {

---
base-commit: e726cf08ee6ba7e8b852c77760f12c59f90f1338
change-id: 20261030-clk-leak-3ea6f7c7da25

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

