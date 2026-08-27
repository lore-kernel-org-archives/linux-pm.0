Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C24C6F1E
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853584; cv=none; b=XwWgSzVwX6t4/51EIvLTpAX4JyZb/02FCeOVygW0ws9Y2uiurG2yn1Msri79Daf6ptVLcEDGemglwdq+SDbn40AxqUWtAD2zjfJkOxKyu4H87+bq7Bc1XcTgszGjK+Ra6FzjwDDjlgY7LmblgAmDkvEuoieMYAT87U2UniaKjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853584; c=relaxed/simple;
	bh=GuJ2IiTNAbocaQLtHQ5QQk1lc6LqRCoanYaY2qkKLA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kG7ViB6UkApP5BSI7jFIxtrqiSSviowtBa09elHFmKDOHjKvsZyLwQ40MpZH2hyAbtN3i+VxdlbCMPTiYw/FVNLybMjOFsH5pkhRakIWMSW1c0P0w4XI/sEechK2EU86x73o9AGnWn/ueAkPvhav7bxoJGw7rVmK8n+N5oFkrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bMxcVnYh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ggkCds9D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bMxcVnYh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ggkCds9D"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXb7p873637
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d4/+pFI9X3x+m5kaMfH/DHqftGBwKmr5KIRwmuCGmb8=; b=bMxcVnYhfYd5fNEJ
	rjG+jRjG+rFtOUYWo+LAzlLiR6RK+WHe7LOHYhSaras3OG4qk9JcGO9wSJE5hMFz
	o9Pi/cBz13QNhoCkGlOwrxBAnLpqnaSHr86X8hbXklfdqPBoJOTYnevWJNCPTEgn
	G8jXN2Lg66YzXlQOBm5PYnma7vw0zSqzy7s7IFPM5K58NCHX0S8BnxfCh1eUTpqB
	girVzr+TzWRbg/fDnPb8A0AoYdkk8qiP/FwHM0/Wo3QzgNzGlLmvRbJgaxghydqK
	cVz3EHEatSVQll7TuHE6YEQJSvLTrdQBkwVMVQbvXr9n2rowYXVveM9RrawiXxnY
	W3pifA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0gj7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:59:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so328997a91.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853580; x=1788458380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d4/+pFI9X3x+m5kaMfH/DHqftGBwKmr5KIRwmuCGmb8=;
        b=ggkCds9DmsUuU69tDrqpGevoA2nMtfpgnzTNPCyeFBVfh7IgglOZK9fYl8P6GS+l/J
         3rZ+lsm0zmuFbdKBp37iEhN4Qh/H9mFkXYfpCZcHgSjfoYfBAuReYdufyTePXxNwHTxP
         i0gHmiYNmjg0zEIK3k918rRjrKczi1oibBIQ0/5xJJNlUEUta9dpIECPoYFpESyNso3X
         ILqqYeuXZ90bbAq3OzfwDnAH0STgUl6Xl1/RSHoSEqB9b9LBw1G7XE6f9nfxkd6oPMcT
         uvjZjqqqczETWdwWV7UVzd/K2BkpPDcxfapwq4GPkngXC8/e3+XUG1RXPMJFiq0UFc5e
         NxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853580; x=1788458380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4/+pFI9X3x+m5kaMfH/DHqftGBwKmr5KIRwmuCGmb8=;
        b=ZTNSYyEyAKy7CB6MCSJS3WTG1lICOGg/f883mndDl0iCrL5qlf6eVH3+WtYsA9QxjV
         lKz2PjcYjaGpq1UQilDAnkImHz/OB6bjurHKMs7zpIIdHUv1Ttpxj8IRo78Id6gTR/Pj
         HXmIy5f2WQ3uIWgO4eFS06Uzxjan91iDIQjahDvIh6+oo6xyY1mFdUnVbCZeTIJS+O2d
         mqEI2n0desZ0E9z9iFLv+9xCw1oC0v63y9DOeZLmXu/ZwLazuOw2by6VADAv+pw4tgp5
         5a43rvOlaRfA/TxnGA7r5xhTlP7qPxyFNz5qSNhIPEeALLXWkQl3+QFW24MCjCJWsy6g
         VeUg==
X-Forwarded-Encrypted: i=1; AHgh+RowEtQ+4fB/kyYSryRv9NnJbTfxRhnCHtSY2zY3cvAX/NGz3YTyxxsWjmaH3rx11NrXglZ/Xv41PQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k0/99BLG9LxxAepO1KrTCaE2w9TXd0jCQ3jeIFZH74aGTgfwKk
	rFpetVZ/ywtvHb0QiE6mOlhrhO9NKwsgb3YjiSAStDPzLsFW680p5hkuL3hEYqD6Tt7WKpNAl9L
	UI00g3ZE1ADtTb0A+CyPDfu0Z0wF5LyAQ5IkjznFbfH78xMA94nBePN0eQZCquA==
X-Gm-Gg: AR+sD10TBIVa0lv/vt/JPAVVKn6it/4JLOMz+nAz8P/QKm0zYTfk0QNjqDcWVpy0C6K
	6+f/wNh8mlwdjzE4L3/19qViojj/Grp5J0oH/7eaE5xuY0SkAqh9A87MBjggjsbfaKcMW5bz0EQ
	LNdkCV59fUgiakWLraj/MkBtcgFhrsrQ8kQAlcF7jv8/N8+Ngnw4gWvF6+Cze91/wCabWnOPEZc
	f33wZ4n4GGJhZNjfaaFvsVDjH0RAp4iXqPlBmwiw7zwZYHmodSY/qE5v/Bx6V3enR1jbaEpJS8k
	gjTMBKGELyEId8Wm7vcOWe/hhkFZ24vewdHUBXmTz2stl/nTGmu9XeYmLI6aLY5p1OU4MQTMrEW
	YPWnjCpfZPZ4kSuXlHPoyBfuh/PVzmXc3lw==
X-Received: by 2002:a17:90a:dfcc:b0:380:f389:447b with SMTP id 98e67ed59e1d1-396d0fd3a24mr1900893a91.11.1787853580258;
        Thu, 27 Aug 2026 10:59:40 -0700 (PDT)
X-Received: by 2002:a17:90a:dfcc:b0:380:f389:447b with SMTP id 98e67ed59e1d1-396d0fd3a24mr1900802a91.11.1787853579715;
        Thu, 27 Aug 2026 10:59:39 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:59:39 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:18 +0530
Subject: [PATCH v2 1/9] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=1380;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=GuJ2IiTNAbocaQLtHQ5QQk1lc6LqRCoanYaY2qkKLA8=;
 b=uHr3/INLh9B6c1OSy+HkMvDYKMGogOjcbm6b+zN0jVzPu8xWpULGobB+nh9HS0n4stNuFMgOJ
 VBVVR+W8kmCB6yTAsu4IqWK8QP4Z1T4YLzVn1c50MlZWoGiWls+ogiQ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX6KMdwIrkkRux
 76RV3wLwVOfJLEwplrdFskSDlcHX2cu3nf33pgYZKHRg5ubNo/nR9+Uck6+Wk/A1qSmgGlCB7hu
 eMP0Q/P98/Q6zP7msg46kFv4bw199wl0IR4OHq51N/odcuFKk2+InHz6EcYHqEWA3jQtaF4HcKC
 nC4c+SrX+V+8bSuDec7fUVPIzk44m9zL+sP1VuN6JwQVNvvd0v8OcjmtPOv3FfdYKZO/cXqeQyI
 xqYpCJM7eoybyY9HamtBQ5/0FnpfeCLkb881mAJtuxXwGG2AmdMzmaaknX3ehZ644lcuXh3cVyd
 LGLgnkyspwURxy6xtuX8aS0fGXAYb3pQ4cHkX2IE5M/VLOMK8F7yKPn03CBHvjlpfM0mtqhjf15
 Jsddi3g5SyoCVbijiM+SPelh4RikxKfJ8e89chVgkzwnZBxlJGPKSZX2qE5yznKtRuJlZavYHK0
 5RzzK+xNsfsHzRwDiVg==
X-Proofpoint-GUID: qAhqA8Hz5NHPBjEhFX6JsJOgAiStKu0G
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a907b0d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=sIx0R2CjXXeYvnaWutoA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: qAhqA8Hz5NHPBjEhFX6JsJOgAiStKu0G
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX7Iq8Fgz3glZl
 b09pyf4LvtuuL9ke8+WrOGo9EcoZ4C/Le/6WhKkCDDw2d+pnXiPu3VwgWj7UNqfghI0xNNdektX
 X+Lu1wPnKjGUaM6D8iNX01ppWheIVJI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
invalid and returns -EINVAL. As a result, devices attached to SCMI
performance domains can report failures when relinquishing their
performance vote.

The OPP framework use performance state 0 to indicate that no performance
vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
used (by firmware or linux)  when a device is runtime suspended.

A zero performance state does not require any SCMI performance request
to be sent. Treat it as a no-op and return success instead of reporting
an error.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index 3693423459c9..e390f902a444 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
 		return 0;
 
 	if (!state)
-		return -EINVAL;
+		return 0;
 
 	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);
 	if (ret)

-- 
2.34.1

