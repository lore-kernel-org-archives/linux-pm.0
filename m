Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB70480DC9
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328024; cv=none; b=Q0pTLzLYWOkt3nS1KqfCOe4HqkA9ahCVoYeC51/80rceAkdYFWX83AILRYhxpACG7xorcWa6zSZcHeLykO0Y/pg7Gxe5/dzq4fxsaE65bKdkrGJDArgoWalOixvLvJOmeH7OwyYbqaS3kX6SAvB1JWKhRufm2JPwghvDY54KAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328024; c=relaxed/simple;
	bh=fp61jno8++niFT6E61fh+qdDmseCUv/upWK5jKW9rF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iO+1GsbB+g18Z3pi7KsLbjCrRW+Wwa/N265bes0REtIKZWaNt32RufJg4GotRmrDOwvwiV4OSnFfn0SwsLebC6NhJfkdHuUwIPvQxRUTO93wJSB4xiOw9MkPzWUbRomc7UexaVxwPhBurfBObQrzxSoB54D31DUzbyfZF9YZy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f8rGe151; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DG65KFXj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f8rGe151";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DG65KFXj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6668NIp14073011
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 08:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SzbP8oJYA7lcUAvmgkMoQ6cRClvc0YKd16KRtgIXt4M=; b=f8rGe151LJsniXpU
	96LdGu/jqjnjIE9VAtNKvKoyKmLrJmqZkJyZsytDw52r2osPlT5depUOmREMAQ20
	0yxKLLrrqx1MsBAitZ6P1qKIARnntyqa/5RUsSF/yrnkGy8/JXXTCkK+0n4GdCjP
	oLmNyN1tgHbSqEy91tvmdOO/9drBRFLR7u+7QByjlAJzv3rgwBWefnpOxkNmL4hX
	ptOAFY9bgE/9vFbVTDmbb9UITNX8sSCc0HGZi0v66/EHFAOlv+XEZWkBUijWKxv4
	D4eq58U+J3g7iWbBvExRkbcWWs7qsmqmDTZuTMo9I00r3TrqDd0iGGwibjKHdZ5u
	ePw8pw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8840n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:53:33 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84622d6102dso3752370b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783328013; x=1783932813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzbP8oJYA7lcUAvmgkMoQ6cRClvc0YKd16KRtgIXt4M=;
        b=DG65KFXjj2u/VxKtFhNRUNe5reii3s6GpyzxcS1libSqqlBuQA6oT+5Xb2EA/IXGFW
         c7t2oxuJ75WGA8FasWTLRd9/BN6x4tr3UjdT1ZzaBi3oAe2vL0lY/w+pvxuMoIj8pG4p
         drybezu7E81WJ7aYNPMy+mxaaEPBQ/p+hXQ/jZgH6vJ4xhaebbIhGfgs/U4U5pqjzOhH
         fTw2puOjGu0AswPh+iugkZoT9PRgtsmeAJ4JqJ04yXOLvrr3yVezkwW1tLBCc7i971wS
         IzmJhQzrvI8tidDSkRS4GsH1IiSsFLJOZ1suhxVML6yinEo2DB91XhwRAZqTamcHKlpe
         O3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328013; x=1783932813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SzbP8oJYA7lcUAvmgkMoQ6cRClvc0YKd16KRtgIXt4M=;
        b=hx/pTlKuGBwiDQY32MHC/DPx0Vd8E8aauZ53nbhxZL5pOevLBps5T++JSgOAJhKVn2
         hbMErmvVLJRlW31/uxqjpAUjQCHwp7F7t3kNg7WG3/FIZvYHd9QkBJmQs2/816MLsvfN
         Y26xhdcIulx+WT5KCjAw98gQnqL7L425GfW6azaV8Anbmt2R28uf9Y7WouD2dbJ9PRMX
         PuaOjPUc3QwYFk9qkWdOrpYJ8w8rFKsuHHV/O0E920H+8PZFFC9rYt4W5i+RPTkX9k0k
         25L9A56+4YB/oy/I2lRcf9edgU+GEHUSbZvAMakjADXG+lmbor9SRyIjlYy8s1lKO1CS
         dkGg==
X-Forwarded-Encrypted: i=1; AHgh+RpKFXMsvzPx10HQjmUBb+PU4hMyA6Px16U6wGmNzKVcUhRwBjYr7T8rMGPb/dB1RjPLrrniQJXw8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6uGZIxg1lJeSvRVpEfQFIWp4s1e6X0HXwtDQKlLNuGB4FKu6
	7fIcbRVWqVQI+OL+1LXFOG1rbqbLdA5TmyjjCmeODJa6hGdQ5CEMvR5bxW9m1HRftwAk8y/8odm
	ib1+rBDhO0Nv05EBEE9ji0BRbzJXLuBxz96QGUCl86jtKM7xuGq+fZmbxpm6V9g==
X-Gm-Gg: AfdE7cktph/CmXz8KvVR7xyVAAGPPs6OfROGzIWzEXgniuSWxdUgxP1vaPGgbWwqpwl
	kzZiREG15EG6xd2wn6Rmb1HXCHF/Qhctejh1qlpMtQ+TF/ViK1WcFHHhi/qe55RZEhME0E7bpPV
	G61d+ecumIdaVwOSdA2z0PxGcAhMAkh3NW8NiRG49h+vACeKSxDB5qMnmP0wq2+Ow4WgOHaVx1i
	VklgSsVCzymTjOQUsmSW/vZyOSyME/KEMfZa6cTtab1bM0WMfwc89hgrTPkhdjqXf1J/KKrwSs8
	90KIQUnvNOFM1o43BJViEoJoxNzVCU26fyAHWM1BEHReqT4GwpbveL/wpXq9Ij10oXFXhHYzCyr
	q2vI4htryBH/ibbYruAeol8XBtgALR+6T+AyI6eXu8NAs
X-Received: by 2002:a05:6a00:8d1:b0:846:169c:d815 with SMTP id d2e1a72fcca58-847f6fa81f3mr9020158b3a.60.1783328012994;
        Mon, 06 Jul 2026 01:53:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d1:b0:846:169c:d815 with SMTP id d2e1a72fcca58-847f6fa81f3mr9020065b3a.60.1783328011084;
        Mon, 06 Jul 2026 01:53:31 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9e12csm3411834b3a.21.2026.07.06.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:53:30 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:23:09 +0530
Subject: [PATCH v3 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-1-92feb5a7b926@oss.qualcomm.com>
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
In-Reply-To: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783327997; l=1909;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=fp61jno8++niFT6E61fh+qdDmseCUv/upWK5jKW9rF4=;
 b=QFmAfkS9VAoslxTguMBvbNBSXqWyknyttP23vjMCsCwplLnXi944ZWXmo6yYFdAODXns3ZOub
 /XzkupnyRmmD+41Ciqz5xjENstNf0XZD0vQ5xfPLqFXAp5koTp4fuDt
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfX3M4n9cO4HkcL
 dS2/tD7TtP4vzpT98UmZmtg4fWasRrNk2tLmn/Z5+11JlbZnStC3h84BzHq+HhM8Wrz0UYTN6+s
 FmotLVL308KdP9lLgRvvT5rZ+u4cKis=
X-Proofpoint-GUID: w_rdBMKUM75ALZSFct1vAv0l2egeLOaw
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4b6d0d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=TpI2hjkGOM-ZtQ_OKuoA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: w_rdBMKUM75ALZSFct1vAv0l2egeLOaw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfX6erkkYrx9RX9
 hLRxLJh10nYuGnhqr0wHs4/oQrFxilcSROueI1WjnnlACGSFb0S/mDNrekEvo3ncMUqkh6UWIwU
 +KuxsRTdNI5h2Cu6jN6KyiMT+bFkfm6XWx1E+7OiV9x4c3fykSbpI0UpmmkGlNHh2Qq/DBs2d1F
 5r3VBJWxYaBTdlpbc1ueg4nYlMCx3KTgr1n0U+H8ZCUjAU4raznutG1BBgl6RhfFC8ZlkQTPV7M
 VARyhAjJa59XAasnenQ3IjuUOwWHN/8mEBSsL0HZfKnm5yYZCScPmuooLYTQb7YhyyeMo1QEB+j
 Ppg2L7eVG3XgCxoUfHcWGYjjgsoPGsGEuBLWeYTUB6o/qcSnaicaKriWV1bAjK/upwrF37Qc+kk
 M1QLXab4OzVvPxZrPsHSXTfQ9o77q9kAuovobMThNLYv3fPSH3yv6oS5gcj3AITNl3x65fZx/xk
 1WNv36m6YhbWOQmaWvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060089

When a runtime resume callback returns an error, rpm_callback() sets
power.runtime_error on the device.  This causes all subsequent calls to
rpm_resume() to return -EINVAL immediately at the top of the function
without invoking the callback again, making the failure permanent until
runtime PM is explicitly re-initialized.

Unlike suspend failures, resume failures should be retryable.  If a
device's resume callback fails, there is no reason to permanently block
future resume attempts on that device and all of its consumers.

Fix this by moving the power.runtime_error assignment out of the generic
rpm_callback() and into rpm_suspend() at its fail label, where suspend
callback failures are handled.  Resume callback failures now return the
error to the caller but leave power.runtime_error clear, allowing the
next resume attempt to invoke the callback normally.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/base/power/runtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 335288e8b5b3..fab38bc98113 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -469,9 +469,6 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
 	if (retval == -EACCES)
 		retval = -EAGAIN;
 
-	if (retval != -EAGAIN && retval != -EBUSY)
-		dev->power.runtime_error = retval;
-
 	return retval;
 }
 
@@ -751,6 +748,9 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
 
+	if (retval != -EAGAIN && retval != -EBUSY)
+		dev->power.runtime_error = retval;
+
 	/*
 	 * On transient errors, if the callback routine failed an autosuspend,
 	 * and if the last_busy time has been updated so that there is a new

-- 
2.34.1

