Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA672628D
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678391; cv=none; b=vGt+AcMcobJABl87HiCpqrsaeEy2uc0Gd1Sp/042HssMOny0h2GTwROk1IVoW0qz3Z3s2KgfkSjZ5Ymlq8jfHCxwjyw5l9VVyJFtmWWfLlrprlpk4e5WE2Zo3VjtCgu0IfuxlEuDtA3jlbJpC9+dywGVxdDnw2FE3CVyeBuPG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678391; c=relaxed/simple;
	bh=fp61jno8++niFT6E61fh+qdDmseCUv/upWK5jKW9rF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpEG/fCT0cLrx/9VEZvc8eAYPtzuAe+0IjHCM+yvA7SGG+tXSFgtRoXllJ/fJxz266hT6MfvXjize3K9xkbhwEhC4UowzmRTS09x9dUMmwNCZ6HWpCK5IqDTaugHrgWvJcCM+lxZvzHqIP0X4QycaxyCZHhD/vd5iUFXRp05Dkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PvQhTW5/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J3H7cvl9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvQhTW5/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3H7cvl9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7eePa092361
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SzbP8oJYA7lcUAvmgkMoQ6cRClvc0YKd16KRtgIXt4M=; b=PvQhTW5/4hhjrrgA
	97x8FdCr98oqEst1fYU3R2AzLlMri3EztcmjXQEmfP9rIXZSoCXJAEmMmmNk0BaK
	GgrLTOjooFFW2+YRRaQi8NENS0KwqtQ28HQQa6yGLRzQiOokZ74boC0nvUECFYXF
	W8v9oOkFArWQT2Z2HztJzl2p5NbYiL5RyKxKH+lJ0RdV1SBbD/QOKwqGl65T0Kls
	1Krp2A1+TqCq6MjYZWqU8ZryHFjAxK5RBGuvybVwiffXhnyH0QB9cLC+LgJxkVfB
	DPYWn9V+gh2Ri1TRSKhYY92rjGr/tfN70eTg6NeDflXCLd87ew0m9Sc6z+lGYdtY
	BA/0xg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjc5tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:13:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84854c2f888so1515523b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783678388; x=1784283188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzbP8oJYA7lcUAvmgkMoQ6cRClvc0YKd16KRtgIXt4M=;
        b=J3H7cvl92HkhugqYBmQcNDuHwQc1kSTanpTYAfp+6x6iO/5bQV7H8w4RuZJhrAjVyw
         W2J2TMkauEbwo6yyWFY8YmdvERR0XKtSh0azooMYTfiL3AQfD3GN8213lWm65EddyqAp
         9Qj7Xt9v1S2cAy9Y99+R2WKZSEdZ6ydvwcp5u2u4M5eeiszWDMWZKNwJiYm6AvhVxSvo
         LPZiNa3YCpIg41LCQ7GCvaX4XjNc9X3DATrVX4jVfXsLOw1tVBbynfN9UM6DFIWybHWw
         iSus6LLc5vv82SAtuvsORrKx98tJ54sE8Rq9wNJWzUd0o3uNIbzSEkyPAOZeQZ20DtAo
         GQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783678388; x=1784283188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzbP8oJYA7lcUAvmgkMoQ6cRClvc0YKd16KRtgIXt4M=;
        b=QSR6KdQa+a+RA8WVW5fC5DEUYuaDbLUmUnWTfGrLYO+dLIlFJksIxALb9073hHO47d
         N2pEA6iHnOdWxJ+eg0WZGUpS08cVdKjlvICDQyDbPb0JcTJqTaySVc9TQJC8XewAdBjS
         xb2NsKLF9Mb3hSWMwsXiUR98baAvZS7SSfw6alkOj4/OV6WbrekKxBS5MGkviQA5aCnW
         SL06vbeT2DYJfgIo43H6515F5sSYIreBvoAhjI/pefJ7BPYBa4Cj5VKzPmC3TWBZplDR
         +dhBlmqXfVamUteVEO8Qk7t1EjZTB/xU+zSJ+kavKA7qcQtRPCr1k3wxiLlLG3Gty/h8
         ZbOg==
X-Forwarded-Encrypted: i=1; AHgh+RrVVNuF7tngv97m18tBhqAeCkCPGkcjU/lZUmCRuKaeV7RZhvk33lSP+BinLmduJfhhSGCpuaMG0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN21sMuqb8hrah/rAWLeJXhAG1zbK8omXtgS5qGnok7t0qGGOH
	onabP7fgnEzN/r58xzDHPcfxEl/caEInkXoQBEv9x09p52LqK6R0qg+VOFlJpa32UmSxKRvb+0S
	341DmNGZlVAQ92hvOKx/5f5JlK581//4n378fkxO7LaUQw1PBWQVqoaJJ6fKewg==
X-Gm-Gg: AfdE7cmyakaSGBygXwdVQsbzjuMcPse07cKjGBup8ajT1rF76K78yoWT7mLxmHpf9DG
	zyR/CNZPa6iWCjjUsWhpLWunUN5aVUZKBcE0rN8v+BLrZB1PO9weoPUo9GK8R+X+s6xoAYDWlOE
	leo9GcnZm1yUM4pMCX9WMaitKjsA1PR68hW+dfw5Yfjl1uM3XEVWxphHdOnetSyjRR7eUe5dPQi
	FkAZSSOJAQv9uw1TXOee2LyZd2adxyCU0GrMN8+B8o5bt/3OMTrX0GCHY86nWwOfl5yxsk346H2
	X2Ub+hJfxAd77oBu1qGTh2dRj6fCMB8eod7NuCMvlI/DBC9BKSSNzJ9WfReH1sToUnbOCruddTb
	/mPLL4TYB3QVmdZyBWRtEOD+Vjb+Rutgi2ooQeUhQkG9x
X-Received: by 2002:a05:6a00:288d:b0:848:804d:9c5c with SMTP id d2e1a72fcca58-848804da18bmr438263b3a.38.1783678388540;
        Fri, 10 Jul 2026 03:13:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:288d:b0:848:804d:9c5c with SMTP id d2e1a72fcca58-848804da18bmr438231b3a.38.1783678387676;
        Fri, 10 Jul 2026 03:13:07 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a96fsm9977815b3a.46.2026.07.10.03.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:13:07 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:42:43 +0530
Subject: [PATCH v4 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-1-be81d6c15043@oss.qualcomm.com>
References: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-0-be81d6c15043@oss.qualcomm.com>
In-Reply-To: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-0-be81d6c15043@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783678373; l=1909;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=fp61jno8++niFT6E61fh+qdDmseCUv/upWK5jKW9rF4=;
 b=GXSYLi8r438TIXhUlxg8cHoKyYWoGVzcZUQcWC2ddFq1Wud8IbjmowbFPWlatss/e0WWZvCUa
 nMcPZtXkklCDp/PDbkouYtwW0n6usAERIFxGeC2QhTHh3bnb3YoVwj3
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5OSBTYWx0ZWRfX0NYkTVwiC/Cy
 wmshZzs/e+3n2XTHRzYSMNbnxc9oyYVlrtv7QInGi6e8Y9bZHEW85zLKUgjTY8pRjmEwHl2mk9O
 gO6aEhJ3Lg+0HA4mk3wDAEHDqz4sqgt55UJu+LTM3a839mJpOLELTQMhvH4OlrN/4pIsRK5QvVT
 fVpgpTUjJmg+4rp0imEnZzE8Xnfg3dPhvbK30htbB8MAfE4JoJxoIDLFFbYf6ygGKGjrPsu6Rwg
 L4D5XtAsqF4+Lj1ZHBB7LMm4D8aNC63Y3N6lbSxSWlNBcqi7CD1utPqQKtTh3Jehm3ZbV4y95Bb
 bnCb60HBa5DWjYXJT/9pkTSrenZVA0nKzI0/e9EbGR2rw1Zp0IBuxbSj/dwOOUkq/t7/PoLAHi2
 bXGptERrUm/EBdb2NFi4UeyjEQqbAftZAGbIiFs3FR7ZsWk4oHEh7w+ZEDr/IfmDC1AzsZMsLen
 pvHmw3X6J2lEDdQKLTQ==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50c5b5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=TpI2hjkGOM-ZtQ_OKuoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 5Gh3lWgp1rnF3VB2Ms-K0d7OOp_fNbhA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5OSBTYWx0ZWRfX8+97uz6t8pRC
 9sJdv1byaz5u1wiEAcnxrkmoLWiWO0QAXcJ48s1eUqJtRsYPyJJIdlDkgfQiBQnGUY31+1UsyIR
 4mr4txEIXMGkxxOiJwwSPkdiEwfpyyI=
X-Proofpoint-ORIG-GUID: 5Gh3lWgp1rnF3VB2Ms-K0d7OOp_fNbhA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100099

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

