Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312082;
	b=ftXOBwhSH1QI/XWLZj1RB+v87ox9kVMybyBHKZC8MSvCCHxXZiqfamnTGP4+97c4G0c1
	 4oUrTRXAlw4WdZvOokVwDq8vymQSCBoiEdo8MNN1KxK3ZJIFxyZSb2dhWwEckJtrk2rMG
	 gaDB4DIaLT4ibXXLDUvOzYWG0Sw+lLgnbmqMtEImpjopCgIcWf/XZDasN9/hZ5kiv3nei
	 rYHj73/W5sw2FqefOaq0cs7P14UBSyCjNGcmaNQdy6LEN2p9dt0acboCsXNH0pGY+wfxp
	 19ZZTmB6PYOCz26prACfQXoTZ64JqBywHeSd8tkxObr+XyXcy7BPqvH0CLUyPo8oyGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312082;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+HjTA2u/nFFnlptpw3vP/7vPNz5BhgJXN3PJAfK0Fwk=;
	b=hONl/OD5g3pOjZIL+wf7qih6q53y+zFvXPGk4BL5M4YsKyypIuNEZvPHSqU3MwVkbJGq
	 BjY1Dy59CzmftKAag5ZU6veo8CMLu9isD6+EWBJWhc9rxKdzUmcg2BxOqpNrj6KiFuVg2
	 5406tiHnwgtH2PETaLlk1fZT3FKewp3+YVAc/nkWFPhGwnLtiyaZSgKTvhlMFXAbGQRP/
	 jWM1m8zkTIswUjbQ6mKg1sTOGqWhX9Sk1A3HwStvYtkr4lVS7dWBd9KPVgJXoKiGh1afB
	 gJigHZSs6p8oM1CzQqiJQwEHCwsYqtEBMmfapcSEstcEjHu/s0KrEZE43Z+n1sElGjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VIVXVRNy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A5OWfPiB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB4606A321
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCB4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VIVXVRNy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A5OWfPiB
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABA9fB2124840
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+HjTA2u/nFFnlptpw3vP/7vPNz5BhgJXN3PJAfK0Fwk=; b=VIVXVRNywWo5vm8J
	bGdTWBwZbFG5ZXcadzh9nqIX911rWfi/LxdVoACKRPhAuXUI34injqgc4/jDJKVW
	skJHp9WmlwL7TYoIRpY0p/vgyGwsnywuyxgGDwp/z3rDYPWqpBIwpp55Mbyb7WQd
	GbY/5OZYcKjWH5x7oS6Soj2SIpQ15IRIQmmkter4TXPsWMepeA+9ZPf+DJzAYAjq
	3fXElNdasSblOsLx/b62/hOuMndYtxj0AMM5kwNQZYsdJ0jeHfGkeMUUPutaQgSU
	f11Jj1Rr/WmH9OkW8t7Pu9Q7uipQPnMmtGd3EFNgm1n0Eq+Dbf7VPwI2HjrQMR9J
	XVb4Ww==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkk26h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:20 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98304865f02so1531401241.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794312080; x=1794916880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HjTA2u/nFFnlptpw3vP/7vPNz5BhgJXN3PJAfK0Fwk=;
        b=A5OWfPiBdSWYPfFqvY8bNFWB6j1M2GrUJLmRxGd9k1LqCCdkkzO8nvWOmW5r6dbX1X
         SYIkUbRUn96VgBaQQdDUqvmn372YbxtTvrBAy7oist+FbPmJZgP9m9UjgA0XHsro9cLw
         /yW3pDvsDye+gZ50U18yGEFbLVLXdORXnIngm3+oNWiChibcR3esT30hczM3BUspxQq+
         uC6KJjUPjW5djWlGnnbD6f3DHIKgasC63Y9Tw922n9fS420QrBIErMcVVnoFoZTlTrS+
         WsfWVGxdBPXvjI/cKXUecoyVILRk3NmMKHAL5Ccjrj7xfBeeK8waQcKTAf1R+klYRein
         wcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312080; x=1794916880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+HjTA2u/nFFnlptpw3vP/7vPNz5BhgJXN3PJAfK0Fwk=;
        b=uNyXU3RUCjOiytbUTIfoIKgpGAWBbhjfPgset0djgVgsthVBDozOoTeS48YxvyLTQR
         qh9RkgbSm7YDgo7xu54Er/qTlCiE/o/ujQqOeP66PtMQgqswHMMbbGC2tSwHBInhcgb9
         6DKKNevg8ksXVqkjV736MIx7M5X4hJ5fqS9KER7p5csGkzmy1BeeAXSy4eJJUiJCo6Ta
         +/kTcXsPKO1V85FnOR8emMRaU7uaMt7PNWCA5Bm5WarBP/x6xSPrKhxF6tZ3NU23/mhE
         RKuTS2qq7iG0PJhmFNz4ShU0XgiRdeuMcuEyiF3/IHDTR8HyyoRMyJ3Hu9r3vryD7hrh
         iU8A==
X-Gm-Message-State: APuU4Z/fq6w6rKGKbfNy1lGYAoZamTKGkpHjn3b18xE8RhWg1Sihg6XQ
	RAglpHhg34Oo45YARREU1uYWm481RYc5QdG8yBIstHca0BZEtjjGGAhr5uSC7wu+H70Ujk3c9AR
	5xlRmp7KqWvSeXGMTmo5HGDCG4wnHhheCktXls1NsU7qPjwUSsfIeMzn6rsMcHQ==
X-Gm-Gg: AYBFou24QwOfSMFV5Q6CfpdadjOCeaQFM4Hm/GXQ0jeJgdZ4uxmEQoWOwh+7K9COfXy
	29Px6m1Jl+IC+4s4q1ReK99Z+EQ+IxN+rR10LdnevSkpo0/wjANpwj2FYtiD3i+e1tCIxxRI+dU
	6kBWs/PEgB0kc5QQKY9HLDEGJGEyWX/E3GAWybDn+ew9fL2PHCoBOH48OxGeLE2AGlcCLiA0cNx
	NYLv0bgaT52o9ls5UV4Fc/sLYooIitaw3ySSbjf189qYOMrd0GiC20u7/bfmgo074P7prcAEgHA
	EFyQr3gWTSwateX7hoy9N27u8usjvo68XX9KRSgEEDed+vQHbu6NxM5yvICPlNNgF9H4FnS7Fbx
	QqEikbNoCwvLXVR+8D/TGzudfk1Bq80GByQ+5jjff5poQazewF5zFE1Pr2o+odDEu5f1GhsfY2I
	Cb1dyHR+U6VdKXDYLrOMgcML6p6kLEeb5PqsLY34hBntEDQ5vmZmPIyRGEVu0eMG9aUmt960lyi
	cfmJkAXwQ9XcCcvUsXZNSrT+Jo=
X-Received: by 2002:a05:6102:54a3:b0:7cb:70ed:ff90 with SMTP id ada2fe7eead31-7d301c1a4b4mr947569137.26.1794312074929;
        Tue, 10 Nov 2026 04:01:14 -0800 (PST)
X-Received: by 2002:a05:6102:54a3:b0:7cb:70ed:ff90 with SMTP id ada2fe7eead31-7d301c1a4b4mr947517137.26.1794312074188;
        Tue, 10 Nov 2026 04:01:14 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:a91e:6b1:bddc:2951])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2cb2sm56820295e9.3.2026.11.10.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:01:13 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 13:01:08 +0100
Subject: [PATCH v2 1/2] PM: clk: Derive PM clock locking from the device's
 IRQ safety
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
Message-Id: <20261110-clk-leak-v2-1-d044cf0c3f1d@oss.qualcomm.com>
References: <20261110-clk-leak-v2-0-d044cf0c3f1d@oss.qualcomm.com>
In-Reply-To: <20261110-clk-leak-v2-0-d044cf0c3f1d@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: knXf84pnEAJjRaCiykRjls0UNLmTkVTk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NyBTYWx0ZWRfX5g2bgVk6d/mn
 kQiyUskWhGMrFjwtwh1sS1VaurVOH5uWkurwkUICtX/4CbcXnxcixt75dnyErb0E25aXaMKfQQ6
 xbgboPmVD0mCKSvdb9wAhfXDn0i9V/k=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af30790 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=axtgUO-RdfAEZTjPD4QA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: knXf84pnEAJjRaCiykRjls0UNLmTkVTk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NyBTYWx0ZWRfX/ABF+ulZV1DP
 l0zkysDnnzfc6TYEuhPq4d7+du/cGn8TXpLwpL/NVxGc/tYPz9Kk6j6YHqRaZORR+6vF4J/acRd
 3YtTmBClOyrCR9e1f9Amna7kxdBa7iV6KeQOZtS9CeAjHiVmvakXszKeKC2fH1i5ogLtD/x91RS
 /nuLRgNnmaXdJjk6Sl6iM7airp1HUYuRnofr4SCslYOnwT6yW2MdMfrfkQqGMM37sjOhiMEGnig
 g6PSRQCmgsRl7nEE88/WTC2v4XaDVaboPZzbcGaYaZUwmEMRwAvDiD9DN+UGrbhtD8/oTxl7nZN
 Gtuj9nMLglq1yDKsKW1XeCzX4d3cHJYo+Wt4nQsU4Q3+b6vfA0bk6JkUGS0EuTEbFSxT/N6cOD1
 kGhkI1JoVtSQV9Nei51DkccNqK1awAQGVgzomiPwQjgGW/dwpXEe5Ha40ZVac22/HFXOq4L29NH
 0l+1JltJ9oPaHeifVlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100047

pm_clk_suspend() and pm_clk_resume() take the pm_subsys_data spinlock
when every clock in the list can be gated atomically and the mutex
otherwise. That is tracked by a clock_op_might_sleep count.

Whether the operations may sleep is a property of the device rather
than of the clocks though, runtime PM only invokes the callbacks with
interrupts disabled for an IRQ-safe device.

Use pm_runtime_is_irq_safe() and drop the count, the retry loop and
the caller name argument. Devices that are not IRQ-safe now always
take the mutex, which is legal as they only suspend in process context.

The count also rejected an IRQ-safe device holding a clock that is
enabled when prepared, with -EPERM. __pm_clk_enable() now does that
instead.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/base/power/clock_ops.c | 135 +++++++++++++++++++----------------------
 include/linux/pm.h             |   1 -
 2 files changed, 62 insertions(+), 74 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 3b8ba27802a800bac29abd8e21756ccdb0f2a716..6f66e11a12428fb718abca197f5519b1ee21ff90 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -40,14 +40,13 @@ struct pm_clock_entry {
  * pm_clk_list_lock - ensure exclusive access for modifying the PM clock
  *		      entry list.
  * @psd: pm_subsys_data instance corresponding to the PM clock entry list
- *	 and clk_op_might_sleep count to be modified.
+ *	 to be modified.
  *
- * Get exclusive access before modifying the PM clock entry list and the
- * clock_op_might_sleep count to guard against concurrent modifications.
- * This also protects against a concurrent clock_op_might_sleep and PM clock
- * entry list usage in pm_clk_suspend()/pm_clk_resume() that may or may not
- * happen in atomic context, hence both the mutex and the spinlock must be
- * taken here.
+ * Get exclusive access before modifying the PM clock entry list to guard
+ * against concurrent modifications. This also protects against a concurrent
+ * PM clock entry list usage in pm_clk_suspend()/pm_clk_resume() that may or
+ * may not happen in atomic context, hence both the mutex and the spinlock
+ * must be taken here.
  */
 static void pm_clk_list_lock(struct pm_subsys_data *psd)
 	__acquires(&psd->lock)
@@ -70,72 +69,51 @@ static void pm_clk_list_unlock(struct pm_subsys_data *psd)
 
 /**
  * pm_clk_op_lock - ensure exclusive access for performing clock operations.
+ * @dev: device the clock operations are performed for.
  * @psd: pm_subsys_data instance corresponding to the PM clock entry list
- *	 and clk_op_might_sleep count being used.
+ *	 being used.
  * @flags: stored irq flags.
- * @fn: string for the caller function's name.
  *
- * This is used by pm_clk_suspend() and pm_clk_resume() to guard
- * against concurrent modifications to the clock entry list and the
- * clock_op_might_sleep count. If clock_op_might_sleep is != 0 then
- * only the mutex can be locked and those functions can only be used in
- * non atomic context. If clock_op_might_sleep == 0 then these functions
- * may be used in any context and only the spinlock can be locked.
- * Returns -EINVAL if called in atomic context when clock ops might sleep.
+ * This is used by pm_clk_suspend() and pm_clk_resume() to guard against
+ * concurrent modifications to the clock entry list.
+ *
+ * An IRQ-safe device may runtime suspend and resume with interrupts
+ * disabled, so for such a device only the spinlock can be taken and the
+ * clock operations are restricted to the atomic clk_enable()/clk_disable().
+ * Any other device is suspended and resumed in process context only, so
+ * the mutex is taken instead and the clock operations are allowed to
+ * sleep.
  */
-static int pm_clk_op_lock(struct pm_subsys_data *psd, unsigned long *flags,
-			  const char *fn)
+static void pm_clk_op_lock(struct device *dev, struct pm_subsys_data *psd,
+			   unsigned long *flags)
 	/* sparse annotations don't work here as exit state isn't static */
 {
-	bool atomic_context = in_atomic() || irqs_disabled();
-
-try_again:
-	spin_lock_irqsave(&psd->lock, *flags);
-	if (!psd->clock_op_might_sleep) {
+	if (pm_runtime_is_irq_safe(dev)) {
+		spin_lock_irqsave(&psd->lock, *flags);
 		/* the __release is there to work around sparse limitations */
 		__release(&psd->lock);
-		return 0;
-	}
-
-	/* bail out if in atomic context */
-	if (atomic_context) {
-		pr_err("%s: atomic context with clock_ops_might_sleep = %d",
-		       fn, psd->clock_op_might_sleep);
-		spin_unlock_irqrestore(&psd->lock, *flags);
-		might_sleep();
-		return -EPERM;
+	} else {
+		mutex_lock(&psd->clock_mutex);
 	}
-
-	/* we must switch to the mutex */
-	spin_unlock_irqrestore(&psd->lock, *flags);
-	mutex_lock(&psd->clock_mutex);
-
-	/*
-	 * There was a possibility for psd->clock_op_might_sleep
-	 * to become 0 above. Keep the mutex only if not the case.
-	 */
-	if (likely(psd->clock_op_might_sleep))
-		return 0;
-
-	mutex_unlock(&psd->clock_mutex);
-	goto try_again;
 }
 
 /**
  * pm_clk_op_unlock - counterpart to pm_clk_op_lock().
+ * @dev: the same device previously passed to pm_clk_op_lock().
  * @psd: the same pm_subsys_data instance previously passed to
  *	 pm_clk_op_lock().
  * @flags: irq flags provided by pm_clk_op_lock().
  */
-static void pm_clk_op_unlock(struct pm_subsys_data *psd, unsigned long *flags)
+static void pm_clk_op_unlock(struct device *dev, struct pm_subsys_data *psd,
+			     unsigned long *flags)
 	/* sparse annotations don't work here as entry state isn't static */
 {
-	if (psd->clock_op_might_sleep) {
-		mutex_unlock(&psd->clock_mutex);
-	} else {
+	if (pm_runtime_is_irq_safe(dev)) {
 		/* the __acquire is there to work around sparse limitations */
 		__acquire(&psd->lock);
 		spin_unlock_irqrestore(&psd->lock, *flags);
+	} else {
+		mutex_unlock(&psd->clock_mutex);
 	}
 }
 
@@ -143,26 +121,44 @@ static void pm_clk_op_unlock(struct pm_subsys_data *psd, unsigned long *flags)
  * __pm_clk_enable - Enable a clock, reporting any errors
  * @dev: The device for the given clock
  * @ce: PM clock entry corresponding to the clock.
+ * @sleepable: Whether the clock operations are allowed to sleep.
+ *
+ * Returns -EPERM if the clock can only be started by preparing it while that
+ * is not allowed here.
  */
-static inline void __pm_clk_enable(struct device *dev, struct pm_clock_entry *ce)
+static inline int __pm_clk_enable(struct device *dev, struct pm_clock_entry *ce,
+				  bool sleepable)
 {
 	int ret;
 
 	switch (ce->status) {
 	case PCE_STATUS_ACQUIRED:
+		if (!sleepable) {
+			/*
+			 * An entry left unprepared is an entry whose clock is
+			 * enabled when prepared, so it cannot be started
+			 * without sleeping and the device must not be
+			 * IRQ-safe.
+			 */
+			dev_err(dev, "clk %pC cannot be enabled atomically\n",
+				ce->clk);
+			return -EPERM;
+		}
 		ret = clk_prepare_enable(ce->clk);
 		break;
 	case PCE_STATUS_PREPARED:
 		ret = clk_enable(ce->clk);
 		break;
 	default:
-		return;
+		return 0;
 	}
 	if (!ret)
 		ce->status = PCE_STATUS_ENABLED;
 	else
 		dev_err(dev, "%s: failed to enable clk %p, error %d\n",
 			__func__, ce->clk, ret);
+
+	return 0;
 }
 
 /**
@@ -223,8 +219,6 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
 
 	pm_clk_list_lock(psd);
 	list_add_tail(&ce->node, &psd->clock_list);
-	if (ce->enabled_when_prepared)
-		psd->clock_op_might_sleep++;
 	pm_clk_list_unlock(psd);
 	return 0;
 }
@@ -371,8 +365,6 @@ void pm_clk_remove_clk(struct device *dev, struct clk *clk)
 
  remove:
 	list_del(&ce->node);
-	if (ce->enabled_when_prepared)
-		psd->clock_op_might_sleep--;
 	pm_clk_list_unlock(psd);
 
 	__pm_clk_remove(ce);
@@ -384,7 +376,7 @@ EXPORT_SYMBOL_GPL(pm_clk_remove_clk);
  * @dev: Device to initialize the list of PM clocks for.
  *
  * Initialize the lock and clock_list members of the device's pm_subsys_data
- * object, set the count of clocks that might sleep to 0.
+ * object.
  */
 void pm_clk_init(struct device *dev)
 {
@@ -392,7 +384,6 @@ void pm_clk_init(struct device *dev)
 	if (psd) {
 		INIT_LIST_HEAD(&psd->clock_list);
 		mutex_init(&psd->clock_mutex);
-		psd->clock_op_might_sleep = 0;
 	}
 }
 EXPORT_SYMBOL_GPL(pm_clk_init);
@@ -433,7 +424,6 @@ void pm_clk_destroy(struct device *dev)
 
 	list_for_each_entry_safe_reverse(ce, c, &psd->clock_list, node)
 		list_move(&ce->node, &list);
-	psd->clock_op_might_sleep = 0;
 
 	pm_clk_list_unlock(psd);
 
@@ -472,16 +462,13 @@ int pm_clk_suspend(struct device *dev)
 	struct pm_subsys_data *psd = dev_to_psd(dev);
 	struct pm_clock_entry *ce;
 	unsigned long flags;
-	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
 	if (!psd)
 		return 0;
 
-	ret = pm_clk_op_lock(psd, &flags, __func__);
-	if (ret)
-		return ret;
+	pm_clk_op_lock(dev, psd, &flags);
 
 	list_for_each_entry_reverse(ce, &psd->clock_list, node) {
 		if (ce->status == PCE_STATUS_ENABLED) {
@@ -495,7 +482,7 @@ int pm_clk_suspend(struct device *dev)
 		}
 	}
 
-	pm_clk_op_unlock(psd, &flags);
+	pm_clk_op_unlock(dev, psd, &flags);
 
 	return 0;
 }
@@ -508,25 +495,27 @@ EXPORT_SYMBOL_GPL(pm_clk_suspend);
 int pm_clk_resume(struct device *dev)
 {
 	struct pm_subsys_data *psd = dev_to_psd(dev);
+	bool sleepable = !pm_runtime_is_irq_safe(dev);
 	struct pm_clock_entry *ce;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
 	if (!psd)
 		return 0;
 
-	ret = pm_clk_op_lock(psd, &flags, __func__);
-	if (ret)
-		return ret;
+	pm_clk_op_lock(dev, psd, &flags);
 
-	list_for_each_entry(ce, &psd->clock_list, node)
-		__pm_clk_enable(dev, ce);
+	list_for_each_entry(ce, &psd->clock_list, node) {
+		ret = __pm_clk_enable(dev, ce, sleepable);
+		if (ret)
+			break;
+	}
 
-	pm_clk_op_unlock(psd, &flags);
+	pm_clk_op_unlock(dev, psd, &flags);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pm_clk_resume);
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index ef3f1310e749c34d4aff75a2fd7e95b9f2ef3a10..c38c59b8a52831ea44ba3ce89217c99a616adda9 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -636,7 +636,6 @@ struct pm_subsys_data {
 	spinlock_t lock;
 	unsigned int refcount;
 #ifdef CONFIG_PM_CLK
-	unsigned int clock_op_might_sleep;
 	struct mutex clock_mutex;
 	struct list_head clock_list;
 #endif

-- 
2.34.1

