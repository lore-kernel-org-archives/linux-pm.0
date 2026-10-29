Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264485;
	b=Ww33Ahu2mO915UZ3p1V+0Y1L+e1FwNniGQSBrPoYgQXBOGPAVVu6UG6sFaHh83PwqPbJ
	 IjGqDdwP63Jo0YYTVBiSR8fh5/ryhEsNDh9ybl5FTN/YWdv6Ri++6A5iQDBZzIZFtLTRf
	 cavaZ3RJm0zZ0+fevTkVKy6lcadWX4K83SeBfKliSN0hyOBB03expTOQrSwMjuODJTSmw
	 xReqdXSZ50QbRsAb4lEoCZr03EowGdn9/xwvH0N1KiUYonrtKw3XrGxYSDvdowrL8f30i
	 c516zPPWk3AxHwngTYlkaGBIfgGBBGTeQvSD29aHXuAWzqRJUmO0pD/zhgdcRbrgR6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=;
	b=Th7VO0jH88ogyBuSzkgJ6nO6yuiXVMZB7XPusy3eru86IZdFf2T1f1OjIyqV0zoTkaDA
	 Nqyqg7Fe1HK0RTYzBdFIpCnD/ktvFn2mXGKP8fjC+hGOwUldb2ZRjHM8eq23Glj8SNd3X
	 pU6SbughR4lgYOWMqWscGhVWkcIWiZIP42VxjxuEmnmFgHh10HETSIrysnfXwkuhSuih6
	 gCuk81O8ITkt6APy6a/ZB6KfcN4B7G/n/KhxU9AVgnCL84UG/XLIJLZ8iwG4n88tF8vd2
	 2bkdldCtjh+Nq5A8ujzx5Tjmn6shmRpuGDj9LtgH1g55rVXo7rhBZNigbhLKd7h0Kyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B+ubSU34;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cxlhKFJb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1F606A31A
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B1F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B+ubSU34;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cxlhKFJb
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vEUq3825009
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=; b=B+ubSU34TnQmuqRf
	jUXoP6JgBr03nskbsZWwAdWWZq9rE9HnL8IdPQhFieB8jO4nLxj+z3SjdEgYg3rf
	Zbm/1TlJN38AuDcQ3nG+SdmrdvFDUoS/hdtYMU1JUihyMbbKiC8c4vv0CSgezLeK
	OVSHeDstB7ytpTB/VuklL9JHWoA+xCa5faXM0NPaync6ur05YARM1rEda8628Y5y
	TWxy9ZWMNt3mSngWoe8goa8ZSBazScNs5XetO7eSCCjyY3u4aePg5IKH5Rnr58p/
	gAIdrrcCHKAyVEDmM4sx3hnlxzVsK4rFK67J4g4uQuHbRJ/fMq+1aEJho4A3ZNKC
	uDHmnw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3hk2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:01:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so1087173a12.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793264482; x=1793869282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=;
        b=cxlhKFJb67aefDWHZNLRI47Avg0occJVCH9ivurLfzwWEQcyy+qMsYFO346afu6NuX
         Oa3JhQTLBmjtTV1zBxQxMy4DPiQwT9E3ae4ZYfQOCAg4zVdXsw3+xLHghKGUIBNyuL2L
         9PcDnH+8MaY9daWerMUb+4Fyqpond9fES6aJ5Fvr0tMWdVTQmDAy4R7LoGkcUYQcnsab
         LgWlK7tGgvyrMdICNrKU0OLX3RUIm7DXC+uUUTQ3EHFekxJzTOw9xNgn9PfCqPy0guSN
         PpzdLMu6LnDxMrf8k0cHmcPXustXbHGUmQbdjpKNL2I2UyXiOtQ0ftRzLUABBOCUV54R
         zCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264482; x=1793869282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=;
        b=M66l6+MsgrLAkma6BUgXdJobitRF1VLcUymwBmVcGAxyh6moS8/VlPVqK9g1aePoPC
         YwxGk6YZw8uzbSGGyYaXJ+hNXmUMvCQJjwjbQ9gaae/K+hoz8PAWyo2oCTba8EpfRoJK
         LJOs+h+dxyXx8x+FprLS4ft49NbeUFApRAZO826vSomoCnXcRrZSKSgDtSQXvVFaA+jv
         zjhVM/H5DF87ErbQfwx8SDQ/sb3dFL7bMWpFGdzef/zO8EGcDQ3M1LP8tsLHI6XKK8hL
         3eJTWvqYMv6H1XEub7ECYgvnH7pX25iS7hFhavtSPDZ9xTxz0chC9jCnmsHyGuh/dytE
         8e9g==
X-Forwarded-Encrypted: i=1; AKwUvByEZlrWyCiIHn6iAjSVypaZIn5C6s1J/mJn8eoDVYzwh9CbZBSQvtC8llMv/d0UM4NtTma/hrFI8g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJouonvwUFiUZ1Rq4Go6Ay7J7ezNuhazkDWmMcIGLuvZgCAhX82
	rLC1oK57s+mdYpP4LKQvRone9gdAK1zta9bXyBvgCNUvU6HHRiDAQZIYUHYxWTKzLNp11jFQ3cN
	KF4JIP1a1RfftgXsSQAwZYgDbts+bkWHa+tuC7POmLHVV1sSfgw/GKF5vjKRiLg==
X-Gm-Gg: AYBFou0/4D2UWuaOmxDVUOOGTKNM28kNcyG9cUd+MHCL+RpSYADVwYRvslIbXoKl6g4
	7rEkfy50rwlhthdkIxYsxCMddi5baQ7G26nMc7ErYIyohYb1DqtRNlQhyZJVMNcddeJMIPoy9vB
	UW5eyAtpoOOij/rk1t1yRga/hhyEkG17hFACEjIUgRFOTdkuGgtUnWOi8oPvuZFU4pBvjBK76Z/
	YBbLS4ihWZMnAwJYhZJjQIL0WkE5FTcQR2noKnHFCgqOWIY/gUz9RsdlCH/R+mFCNmi9jWRwoAa
	6mWWtATqyS7JKhDTwhtWCFqyUK08SGVrIGFKD2QLX766qGf/UADGnT4IIRjtzelVCzDhJJPY2Th
	5McgCwcgQPxRF8qxQr3hUH1uS7ZIIHYOlucS/UYCj1Vvge0Deo8ZfaP4TvMeb4mzxfme54B9kFR
	EPPVMB84KU
X-Received: by 2002:a17:90a:c886:b0:3ac:9e76:aa9b with SMTP id 98e67ed59e1d1-3ae57e2b795mr3492856a91.7.1793264481312;
        Thu, 29 Oct 2026 02:01:21 -0700 (PDT)
X-Received: by 2002:a17:90a:c886:b0:3ac:9e76:aa9b with SMTP id 98e67ed59e1d1-3ae57e2b795mr3492841a91.7.1793264480794;
        Thu, 29 Oct 2026 02:01:20 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7ad710sm3197385a91.3.2026.10.29.02.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:01:20 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:30:55 +0530
Subject: [PATCH v27 01/10] power: reset: reboot-mode: Support up to 3 magic
 values per mode
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
Message-Id: <20261029-arm-psci-system_reset2-vendor-reboots-v27-1-fa4b3ff1359b@oss.qualcomm.com>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793264458; l=4572;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=3jZJCDBmdKair7R/qKaAWXxKmatvkMOd5u4ong8jp54=;
 b=pwt0UJhchuo9nRGpdPR4BB+yIn09z57FaxDRxlb2ix4AAxBac4tXKc6+sgbl7Lmrp1t16D/Mb
 l1rXyaHrrKtDBUIJR68JnHgXfn60pn9DJIDCO7wBnMbX2W5pYeUyOhd
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX02DvsmJb3neE
 PSfPnWkdTPKfvSgndPqCZbYmrPEaiHgdN4kZJWCvuyL93V6XzIwu+HXcOeE1d/zDEdsBECVg6AT
 aLU4FZC0B0xK0bgZGWjZfVCJ0MQfz8Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX0ngJUwoLidEI
 xJI46k7M6Hlxa6rTdeu9iAads8blbml3/6dlnfZZ3RvTM7OD5j2jaeUytjj8zmDkwaiEA0KJMv1
 3ase8A/HuB0P+G25DVLTFYMaFGl2N3Rk+hNvyOKHfbuGx/5TKKtuz9rHTUz8Wj7XUouRhpvZgrp
 DtW0qj5/clWWmlITnvEKSZHWYCyO31yRajlwLHd0KCKwBu9JPBEr+hjcWunogqkpyGJ3BelpVcd
 675RYp9uGavZpp1XIWvtbnIPLcQl5Nb+P4/K+gJ+jjSAZAeX3yYyViKaIs64fRkpR7FVbbPIxY5
 43zDxYcmomLXl4J1h+OC8BYwK6SJXj02h48duYOE7IdKTNhCYUtRTrOKBc6iyds4pQdpR01SjNB
 J/ojpHBI9k0cdSBtQdwnn5RrTnSGXwMSJi+38jZI/G9sn41IrwpgAjJ3hJheTqLO98A4PYoej7m
 wDn/VKjyzeWjdWQ+c2A==
X-Proofpoint-ORIG-GUID: nn3tE9S6CPnP5d6coAqrOkph5GaCiPTE
X-Proofpoint-GUID: nn3tE9S6CPnP5d6coAqrOkph5GaCiPTE
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae30b64 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_usNffLPL2KliZ4tEdwA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290034

ARM PSCI vendor-specific resets, require a 32-bit reset_type and a 64-bit
cookie as arguments. This cannot be implemented via the reboot-mode
framework, which supports a single 32-bit argument as magic value.

Extend the reboot-mode framework to support up to three 32-bit arguments
as magic, per reboot-mode.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 46 +++++++++++++++++++++++++++------------
 include/linux/reboot-mode.h       |  3 +++
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 3611bed341e1..328fa37598df 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -20,7 +20,8 @@
 
 struct mode_info {
 	const char *mode;
-	u32 magic;
+	u32 magic[3];
+	u32 count;
 	struct list_head list;
 };
 
@@ -72,8 +73,7 @@ static const struct class reboot_mode_class = {
 	.dev_groups = reboot_mode_groups,
 };
 
-static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
-					  const char *cmd)
+static struct mode_info *get_reboot_mode_info(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
 	struct mode_info *info;
@@ -84,11 +84,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 
 	list_for_each_entry(info, &reboot->head, list)
 		if (!strcmp(info->mode, cmd))
-			return info->magic;
+			return info;
 
 	/* try to match again, replacing characters impossible in DT */
 	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
-		return 0;
+		return NULL;
 
 	strreplace(cmd_, ' ', '-');
 	strreplace(cmd_, ',', '-');
@@ -96,21 +96,25 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 
 	list_for_each_entry(info, &reboot->head, list)
 		if (!strcmp(info->mode, cmd_))
-			return info->magic;
+			return info;
 
-	return 0;
+	return NULL;
 }
 
 static int reboot_mode_notify(struct notifier_block *this,
 			      unsigned long mode, void *cmd)
 {
 	struct reboot_mode_driver *reboot;
-	unsigned int magic;
+	struct mode_info *info;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
-	magic = get_reboot_mode_magic(reboot, cmd);
-	if (magic)
-		reboot->write(reboot, magic);
+	info = get_reboot_mode_info(reboot, cmd);
+	if (info && info->count) {
+		if (reboot->write_array)
+			reboot->write_array(reboot, info->magic, info->count);
+		else if (reboot->write && info->magic[0])
+			reboot->write(reboot, info->magic[0]);
+	}
 
 	return NOTIFY_DONE;
 }
@@ -173,16 +177,22 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
-	u32 magic;
+	u32 magic[3];
+	int count;
 	int ret;
 
 	INIT_LIST_HEAD(&reboot->head);
 
 	for_each_property_of_node(np, prop) {
+		memset(magic, 0, sizeof(magic));
+
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
 
-		if (device_property_read_u32(reboot->dev, prop->name, &magic)) {
+		count = device_property_count_u32(reboot->dev, prop->name);
+
+		if (count <= 0 || count > ARRAY_SIZE(magic) ||
+		    device_property_read_u32_array(reboot->dev, prop->name, magic, count)) {
 			dev_dbg(reboot->dev, "reboot mode %s without magic number\n",
 				prop->name);
 			continue;
@@ -194,7 +204,15 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 			goto error;
 		}
 
-		info->magic = magic;
+		if (!memchr_inv(magic, 0, count * sizeof(u32))) {
+			dev_dbg(reboot->dev, "reboot mode %s with zero magic values\n",
+				prop->name);
+			info->count = 0;
+		} else {
+			memcpy(info->magic, magic, count * sizeof(u32));
+			info->count = count;
+		}
+
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret = -ENOMEM;
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d6..29ae39935d69 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,10 +2,13 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/types.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
+	int (*write_array)(struct reboot_mode_driver *reboot, const u32 *magic, int count);
 	struct notifier_block reboot_notifier;
 };
 

-- 
2.34.1

