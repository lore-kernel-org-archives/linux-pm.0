Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E247D952
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261299; cv=none; b=VtWEbqiypXI7C46HiGHPNfxbrWAu/p9wEd0bTM4XcmB6YF90lFwrk3TflujOAmFS8lro/oJumRXW961fI2xkVkgk2YnzUzWWmuncJtKUX/8k2DrKxHAo+sTHODV6hZwkxZAkvch5gQERZOqoJcsCcV1hAhd5PgXxW5xYPMm85Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261299; c=relaxed/simple;
	bh=uz+4m4KqjdRWsTJlmApFhnDsv/1B5b/OVZ9NVMkRA1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+FQrG2wKCqGKQrIRo41ciua+hv4oKuWZd7gRHmMVwaohvgWTWKU4xTeJ0EBXx10j5eC9omigt/equ8ynDr747mygLIlX7mjCTwbxxzh7rfQxqNLkUMejl+q8WjiXoZxOxm2+4x700Xcdtt71yYmyxmM8Ix8Le16VQmSrTZVF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IuaJlwfi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RH5MQbgw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IuaJlwfi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RH5MQbgw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJdVI2242288
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 11:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=q0M1/i8At8M
	RHYTLPNKxinaL7xQ5Kl0z3c2DGIUIcW8=; b=IuaJlwfipDJoonpbRW/ok/pUvvr
	5WMO6PumCPnzFqgT3+7otQ16uevtO8GYBDpyedqFeQd67drLybPjWzPYJIIgM3v4
	SxAxcCc7ysuZyWdbRertcd9z9jAqyd4RzhzPj/Lbfa3+VeMWALCnzbB2ogPDKzyl
	e0McRxVfGWI16M61RLySFH2h2n+OeHiQ7kEBSWdWsTWieckf5rvCBQfg+PHjQFbN
	Ipw/9TeOOyALk+Ks0TxKculoG9GY5xzPMg0CuXGPE8NsMc3O9ApIGW3QxrN2StEq
	4iW5j7H9wAIpA36G4DqqgdGUGD71yLl9Hc82VzECjOwzXbpUVQ5VGRX7rMA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdvmm08qc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 11:14:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e82060977so156062185a.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 04:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788261296; x=1788866096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0M1/i8At8MRHYTLPNKxinaL7xQ5Kl0z3c2DGIUIcW8=;
        b=RH5MQbgwAm5PmBs8bd56pmYj1ABpvjVuTBCYQ5IDwWNjL1OXQ098w2d3Gonw82cGOQ
         Qr3FbSTEz2BNuV4pxj7sqPg8i2hQOIEMzBmgP8ijEzQzDbXkVeuHA0zlZP+QMkWEahoO
         9fFw4yuIDGwqYi3KFUxHtH125kRFHgpIswH9wwRHIup3+cB5nEDbGQUxhoU4NlLVjDFr
         yisI03ZQtMymzZaEkxRwc69c0mmW8KZ0ffvFFR50snd4Mng4vrjqVqUuRgElinDfz224
         hIvcyM7k/e5OTJWsnr57PXyb9N3NQfPQtdwRoqqQRcw5hFL2o2vFXYJDBOgYSPjB2iiq
         wPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788261296; x=1788866096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q0M1/i8At8MRHYTLPNKxinaL7xQ5Kl0z3c2DGIUIcW8=;
        b=XpUWqkabJvTCZdVN0fAfP17tfFjrFGrd+tP8kMSVEjzdha1HAsX+iClOaMk9pn/bVb
         IySFo/DBmHeEjrTtM2Gr9WvWjj5/eMnZSyS/PJj1aLI7hC6I0u2CpFFvasuVvFw8y1or
         hIe3NtU1dKyoK5zy2WZg59MHN4t8V/QxpZfcOogH+hIDPo59bosVxYRHTCRKJ4T7m/3M
         31kiW6A4yZACNnY/3ICcqUMQsJ97uopjeVixt8gj6Q55VANE3b+2Z7fwIusE6SRC105q
         2DwPOIlV1OGwdtWqpWAONChwRE/xherfgA9yJ2nqUas3Lw96GP/9/oB7wG5ZXImsOWEa
         6Myg==
X-Forwarded-Encrypted: i=1; AHgh+Rocnmo2zqaXuSWrkR3ooDlOuUhWzK+8GhhZGhiNZ6ybF8TrS9X5+5dR1JquqaKAwNIOXN7RgOQF9g==@vger.kernel.org
X-Gm-Message-State: AFuF++m/u4YFqlH8EGxqw2Sq76MvaV1othPPp40c7U1h/9u0gIZygrNS
	kGXCifSMc1UhbrMnQg6vDCAH1v7PRJRSeyE9dsP/Ibp898uFVs3Ik1LyyRdViJuTN0augWq4mu3
	W0VVKnYStNXn8k0iPdUoeiOZjLQY8Os3WyhkjfhPiaccphC0e2bBv6axiUSxpwA==
X-Gm-Gg: AR+sD10JuGRg2k8baMkN41YcXa5bY5u2iThdjqqpbuPcjWxzqlWJ92RtWDVf3h4Oq4H
	cAR8LmD439Qr9pqs8tx7LdyzFQSYzIJFM7ZcJfUx9gBBH+j4ts0P63rHfR4DQFJrBeZniRCi5R6
	O3n2e+hJFPGRQ17IkISqJsS5T2B2cZ2X7TvnYchTbrds3A7ubxyo/TdMMnCzTH1x2HmCW6Q7ttq
	yW0pbpuO8fNH0yTvgttNRLRmR/AUBxJ2Xa7X0ymxKC1g2VYN74R8Z3k9opDTsnjt7B7m4BeSVvH
	0TvYgdijunsp9POZh9lXK6+41LRBCzhNUWcEosgidMK4QWJxQ+O8CX/t41zRRVA7XWzWW+GnQ6f
	Eoz5ntYfgkzPTD1XeD7ch9iifIZv0rxwLq2X1nali4i7FuN9MPk2hDPnP0Q==
X-Received: by 2002:a05:620a:84c7:b0:939:4bee:f84b with SMTP id af79cd13be357-9394beeff4dmr560891085a.9.1788261296195;
        Tue, 01 Sep 2026 04:14:56 -0700 (PDT)
X-Received: by 2002:a05:620a:84c7:b0:939:4bee:f84b with SMTP id af79cd13be357-9394beeff4dmr560885885a.9.1788261295699;
        Tue, 01 Sep 2026 04:14:55 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25878ba94csm380686366b.47.2026.09.01.04.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:14:54 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] pmdomain: core: Add a genpd config to support unknown initial status
Date: Tue,  1 Sep 2026 13:14:06 +0200
Message-ID: <20260901111441.122436-4-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901111441.122436-1-ulf.hansson@oss.qualcomm.com>
References: <20260901111441.122436-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0zsc5b7k3TwX2AJCYG94cXleI-vJZh3e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5OSBTYWx0ZWRfX+c+h0XMW7SdB
 eL8usvGBKRWI0kO7jhKAzzrdqAURpiZwDVki2CAHTshR1J903IReUieM3wr0yQwuQwnHQTCKxw1
 9Qo7bFFFANDxLA/wn58WNZMMllOvR8Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5OSBTYWx0ZWRfX1a+CzB9n3GWa
 /hoC2TV87QbP0C2RzXo0M2UpsRFGlMjVn6QWVzrMf9PB2/9Wxo+tBfUoCGZrJVu84pYiH+3ecEX
 noHIaNaOuB3I0z4mx7FRMGW3cVS4l5WogDIOnGTwQeJPOxYi47F+mf27bXAfEQuYlk40/v9We0q
 mVt1tDTRoi1Sz/JxJ0KLi5SJ6qSn1452coBCU7Bs7vOLSyyYg32hUWu4fmC2rE5bLrH91fDrDMP
 X4vqPqUozbNGHUkUZDnKnWwawKued5Cg/Y1t9iRodgYzmoKKuPU2x8WF5pbo+gf62RBaxBet2c+
 ETG35G1kiihNDYLGKrgzjgj3OEDD7YVBRmT1rcDjUPC6TGelAmxH/NWqYDBHgOXU4vZyDXMaRQl
 yDbOGt10d8eYr0GnFiphr2FM+3bO/wqgPCpO2d0R9jtQKnfG9ADqYLiCw72MVkeyYVz9PIgtdvg
 QKAA8cWD23l2c2icJXQ==
X-Proofpoint-GUID: 0zsc5b7k3TwX2AJCYG94cXleI-vJZh3e
X-Authority-Analysis: v=2.4 cv=GfwnWwXL c=1 sm=1 tr=0 ts=6a96b3b0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EPyTabgPSFAr6pNicGcA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010099

It's not always possible for a genpd provider to know the initial status
for its corresponding PM domain(s). To register the PM domain in a safe
state, the genpd provider driver may therefore have to initialize the
genpd's status to be powered off, as a way to prevent the PM domain from
being used when it actually could be powered off.

In these cases we may end up to power on a PM domain through the genpd
subsystem, while from the HW point of view it may already be powered on.
Under these circumstances, it may also be required to keep the PM domain
powered on until all the consumer devices have been probed. In other words,
until the ->sync_state() callback for the genpd provider in question have
been called.

To support this behaviour for a genpd provider, let's introduce a new genpd
configuration, GENPD_FLAG_POWER_UNKNOWN.

Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---

Changes in v2:
	- Rename the config to GENPD_FLAG_POWER_UNKNOWN.

---
 drivers/pmdomain/core.c   | 6 +++++-
 include/linux/pm_domain.h | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 97273ed2f825..ab6110885175 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -189,6 +189,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
 #define genpd_is_dev_name_fw(genpd)	(genpd->flags & GENPD_FLAG_DEV_NAME_FW)
 #define genpd_is_no_sync_state(genpd)	(genpd->flags & GENPD_FLAG_NO_SYNC_STATE)
 #define genpd_is_no_stay_on(genpd)	(genpd->flags & GENPD_FLAG_NO_STAY_ON)
+#define genpd_is_power_unknown(genpd)	(genpd->flags & GENPD_FLAG_POWER_UNKNOWN)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -2446,7 +2447,10 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
 {
-	genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
+	if (genpd_is_power_unknown(genpd))
+		genpd->stay_on = is_off;
+	else
+		genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
 }
 #else
 static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f925614aebdb..14e0e346c610 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -121,6 +121,14 @@ struct dev_pm_domain_list {
  *				powered-off until the ->sync_state() callback is
  *				invoked. This flag informs genpd to allow a
  *				power-off without waiting for ->sync_state().
+ *
+ * GENPD_FLAG_POWER_UNKNOWN:	Use this flag to inform	genpd that its initial
+ *				status for the PM domain is set to powered off,
+ *				which may not correctly reflect the state of the
+ *				HW, as it's unknown. If the PM domain becomes
+ *				powered on during boot, genpd will prevent it
+ *				from being powered off until the ->sync_state
+ *				callback is invoked for it.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -133,6 +141,7 @@ struct dev_pm_domain_list {
 #define GENPD_FLAG_DEV_NAME_FW	 (1U << 8)
 #define GENPD_FLAG_NO_SYNC_STATE (1U << 9)
 #define GENPD_FLAG_NO_STAY_ON	 (1U << 10)
+#define GENPD_FLAG_POWER_UNKNOWN (1U << 11)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.43.0

