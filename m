Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF73A7F59
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877566; cv=none; b=KT4QQrW1DkdFbYkrdsU5qJLQoNlp274kbrtMC7BaVI79zIgPgkyiyMS3sZbRyTztDPUjRyFSF11CBnF8hY0TXLf+DcJvZmyEzCkqY688XaMj6sKfNipxzpWcZ3LdrrgnoSLLGC32vjuDEYjqHmRYfVqmtDuwZrq5u4CMxk0lTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877566; c=relaxed/simple;
	bh=TTQO6xNT4+ZFAJc+p+fBQr7kWhLYOrv86Pelwq77JSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rC4a8t1C0g3WTKjgLWNgifuEC2RbtnVgxShrrbJ/qM1BdR4ZWMVyr86Jzl95ok8ZnrkeUAmDKYiSC/q3fNaXDpnxGYlpAY5VTTUDXdJBCQLVD/esG8rVdo4kjTw7H81nzDgp3qCOAGZmikg6tFEW6Nyuse36x2tOXG7AZFK7ydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npjA9KyW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hACkGyAr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npjA9KyW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hACkGyAr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4smaq1897512
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nSSKfbrDBA6kV4AouFVgN1sSPJ12hs/Z0PrpD062x9E=; b=npjA9KyWxrODPK/B
	2ZcuckTlwC501EqXnW/9LDzom5vgcQImmEFJvOxPrufqEbeT51iBFz0+Bzxozp3W
	HcXNE5VPB5IuL52g9BKF8pzsGqdCNnQW/YE+AZ+GDO9iZEpvwlmsQ4I+Qi7cPYZd
	JqH6oz+3XTx7d63Z1pPW/kQ5BL7rlOeYf8ziWhPcrGQtF2NkKnoJoob/diBio7y5
	pJ0Cv6SlUW3vom1YBlNvecIQX5O97gQhll+F6562kd5MGv4XZhv0iZbQq9Ai+Nqu
	AiiBa6dWH/LVxYsekp6lWmN0+YlJsbeAo/3eWfnhb2ZSDIS1N1msjZ35125JiW0X
	EKCwiA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm1em8ftq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccd1958e8fso2126495ad.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784877563; x=1785482363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nSSKfbrDBA6kV4AouFVgN1sSPJ12hs/Z0PrpD062x9E=;
        b=hACkGyArTcPGThX+e0vub6g5klM/x95GSygdUv5sVoDQXPTnQoW7r1y5JPQhTVlqJK
         7di8QGm5W0312OA2ehxguH0piXtfG5Y8uZJwUdRsWgA4V54T4hsFFyNTOZ7KIHfmCS2F
         baDH4NcvEBNUtUIbiMH/o/CCFYDHmvcL1Q6+zgVmcQRqcy1/AwFX1Cr95cUu6HxF2bO2
         lksUNZaNjjuXm6TmJZPk4atp8ykSd3ApxAV8h9OGE4tITYyS8nOgvCKG+RG+EisKyhoH
         aDZM4dvScx49Pm8SM4GewGNyUDyw0aSP9fgFRa6xvmMswMdeJeid7f1A0MgSRu1Gual6
         jOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877563; x=1785482363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSSKfbrDBA6kV4AouFVgN1sSPJ12hs/Z0PrpD062x9E=;
        b=NSMNAmFebOyiPwo9A19OiwedsY7lLQREK1q/s/9muHwMCM6cu67h42yiC9wnUOwT2K
         J5i4AVhdnW44TI+xiXEEv9SOEfX7mhOh6dDsBr/iGXoa5/soo0uANhUJqg9eW/OXhuLE
         heR975oPznq58O5qdZkcKrHOQ5RqY9RgvhYEeZRVslZ7J0HGZt2AwPaTu/QWNstx/Wl3
         jGA9edG/FLj+L/2yTeaEUJsRHP8RwmDrLCmd+ZfQqAAP9uMGY6uUbcIOYJEN5cGB+l9Z
         kT36lgnkzBkELmqFY08o6S0RoaspEKmTg8TOb6uhj+SlfV64eIofG5vxWcy2N94EUvJp
         GGBA==
X-Forwarded-Encrypted: i=1; AHgh+RrxxNMgg5E0o81f35RwhxAHRSXLtsiMPw/J43kXv5+bEf9vRhCZxpUuXH3g0g+4/O15k1ypQoY4fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0X3BcCxkEoOcIc+Juc3XtQrJvXtohk0/y/wRFfu4al387/j8
	52EbcS1bsafbp35YV777xtP66v60aKqpmVwoQ3A4+uBBTr7POtC289HjfBmO4ffdmEGFqh1V2Po
	7LC95vP4CqVlc4vaQe6gcjns1FTWTv2WcbfQnGoVVY6kWjRo0VAOenMk8xfnGew==
X-Gm-Gg: AR+sD1346v0aPRJrMUZSwnsRZR29MJ2e7k+gQoxxP/TLL6eqdANGH9F5M0DBypNWtOH
	zb8RG+GA7GoIL8PLhPjDjU5ET1qG5ggautzWhVbm/I2GFeqGdZ1UgXr+rITGrTuk63PEpr7fCJU
	NSrT4Xlbkhw6K6wDhtGrbIzMRaPAZ63EaIIYnPyvgVAJQFfazgkjE9XG4KaaUktNJsXe6jn9Pr0
	Jul5N3xW3hEbiBfcih7RH2shvuK3fsVlF13aKWEp2xSiIarmbL71/EX9luoCzvs6yugUqNVbjPr
	qTNAJZsHOeHRl03YFBJ0e1njSSXYzGJZflR3oXV8lDZjuhRrtuFUlssiTgUWoa9ppcBT+jZ7Xcc
	PSJ5rjqsiUUuNzAFReLh/EtWXtGJ8R64AhaSg/ZVHg71oM1mFyQGPZeV8ay/h/YImZrFSvntlmV
	GQO+leUAr1jFVGbZlZKs9khJWQnZs=
X-Received: by 2002:a17:903:1b07:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2cfa6c567d6mr78816085ad.22.1784877558348;
        Fri, 24 Jul 2026 00:19:18 -0700 (PDT)
X-Received: by 2002:a17:903:1b07:b0:2c9:e2c1:4fb5 with SMTP id d9443c01a7336-2cfa6c567d6mr78815845ad.22.1784877557972;
        Fri, 24 Jul 2026 00:19:17 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efe3afbsm45993805ad.33.2026.07.24.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:19:17 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 12:48:10 +0530
Subject: [PATCH RFC 05/10] PM / devfreq: Add new track_remote flag for
 governors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-rfc_v8_scmi_memlat-v1-5-cb732bcff1f4@oss.qualcomm.com>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
In-Reply-To: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784877514; l=3635;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=59NPtGqSBHQF7ZdSEQTKlbhHTzbuDIOFGJTtQD3qeLM=;
 b=/Y1gUkrABenFv0sYOLB9F9uLwyaV7q70opsOpYpYHrxm90y3JRI9nU8of7ERTXbtfg7yeeVa5
 xlFxLBvZvm/BRmgU07gxLL3ol3/t4Nk/JehrI8/G029d4rfFZ378iDR
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfX6KUYtvwIGb6A
 zAhqcgVPrAZ0uZIex/6Yy5kbeqXu/50zqugEhgZRfRq9X5H4Qi7qmtshGgeac8huMv/fphusXKJ
 6O5SKZHU91PRTXmIqNVCSH+/bX/bzUE=
X-Authority-Analysis: v=2.4 cv=BIODalQG c=1 sm=1 tr=0 ts=6a6311fb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_Sn8c3TY04LLovrI2V0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: SANvQHk6qEnmvrNZFZGcPUqckYoqBtoK
X-Proofpoint-GUID: SANvQHk6qEnmvrNZFZGcPUqckYoqBtoK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfX5LQ7BpxmJT3r
 3N+aEx6AxFa550uxCY2xGmwaJGO2SGj0LmG1PLLwqP8rWKwt7bLl1BYjXso1eJ3tsx18o2hBy0B
 Xcb8rgo60Ox+zsB2kVZnz8hdNkDQZLwiTWBz96rRYgmR/ms32+zk1eS+yuRzeuKmSwIieFFE6jh
 b7fAkH+i17wGZ2B/TAJPxXn0ERYL6WySH98kcpb7WI/vwKhakkRqe1xPgUo+9bOcDYYTW04240h
 jQb5HFJdT/mk5iZOITu/xgJG9zxoBp/p6ADNHVgnvqAVo5TfOeZRezxi8kEG4HzU8g0TOYokkfu
 762XFvkiUD8pg7fupR2X40d9rvu40w8/QVEU3r6jIwvkQHUESWUidOSZwWfdYYXM0c8tZRxN1Q9
 I2ERdvWdpREnvGa+VZrqgEGsjV51yj/fMzIUee8RTHouRkwkTMxHNqknPiwTPfgCQ1Iz3YhuIqR
 VpK5VLZO6Qpw79zO/Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240065

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Some devfreq governors need to track frequency changes performed on remote
devices rather than driving the frequency updates themselves. In such
cases, the device's frequency is already updated by an external entity and
devfreq only needs to keep its transition statistics and notifier
subscribers in sync.

Add a new DEVFREQ_GOV_FLAG_TRACK_REMOTE governor flag. When set,
devfreq_set_target() skips the profile->target() update sequence but still
emits the DEVFREQ_PRECHANGE/DEVFREQ_POSTCHANGE notification pair and the
devfreq_frequency trace event, so transition-notifier subscribers (passive
governor, devfreq cooling, etc.) and tracing observe the remote frequency
change exactly as they would on the normal path, and the transition
statistics are refreshed.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Co-developed-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 drivers/devfreq/devfreq.c        | 21 +++++++++++++++++++++
 include/linux/devfreq-governor.h |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2f27a239e34a..71c6ced9e4e1 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -348,6 +348,26 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	unsigned long cur_freq;
 	int err = 0;
 
+	/*
+	 * When a remote agent (e.g. firmware) owns the frequency, skip the
+	 * local profile->target() call. Still emit the PRECHANGE/POSTCHANGE
+	 * pair and the trace event so that transition-notifier subscribers
+	 * (passive governor, devfreq cooling, etc.) and tracing observe the
+	 * frequency change exactly as they would on the normal path.
+	 */
+	if (devfreq->governor &&
+	    IS_SUPPORTED_FLAG(devfreq->governor->flags, TRACK_REMOTE)) {
+		freqs.old = devfreq->previous_freq;
+		freqs.new = new_freq;
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+
+		if (trace_devfreq_frequency_enabled() && new_freq != freqs.old)
+			trace_devfreq_frequency(devfreq, new_freq, freqs.old);
+
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+		goto update_status;
+	}
+
 	if (devfreq->profile->get_cur_freq)
 		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
 	else
@@ -375,6 +395,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 
+update_status:
 	if (devfreq_update_status(devfreq, new_freq))
 		dev_warn(&devfreq->dev,
 			 "Couldn't update frequency transition information.\n");
diff --git a/include/linux/devfreq-governor.h b/include/linux/devfreq-governor.h
index 2853f571dfdf..e4f7b6cb07bc 100644
--- a/include/linux/devfreq-governor.h
+++ b/include/linux/devfreq-governor.h
@@ -33,9 +33,14 @@
  *   : This governor is never changeable to other governors.
  * - DEVFREQ_GOV_FLAG_IRQ_DRIVEN
  *   : The devfreq won't schedule the work for this governor.
+ * - DEVFREQ_GOV_FLAG_TRACK_REMOTE
+ *   : The governor only tracks frequency changes performed by a remote
+ *     agent (e.g. firmware); devfreq skips the local profile->target()
+ *     call and just keeps its statistics and notifiers in sync.
  */
 #define DEVFREQ_GOV_FLAG_IMMUTABLE			BIT(0)
 #define DEVFREQ_GOV_FLAG_IRQ_DRIVEN			BIT(1)
+#define DEVFREQ_GOV_FLAG_TRACK_REMOTE			BIT(2)
 
 /*
  * Definition of governor attribute flags except for common sysfs attributes

-- 
2.34.1

