Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB03A169F
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575785; cv=none; b=d7gZr8jkrWlkkjsaILEPdkqpsiwXLVgUPm8QGSyUmr3OsK6aimKakqR9yukQZatECvUb8/Qf09cTbE2BOLEZZzkBfBk4+Kof379D74sscRTODdCllVsB/SBsSTXn/1UeiHzDTAiS2rGebSDoEH9qSf/UOYRkuL2fRe6ZkkOG/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575785; c=relaxed/simple;
	bh=3jZJCDBmdKair7R/qKaAWXxKmatvkMOd5u4ong8jp54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVqGA6WoLWneaGFkDULRZDLxgOKOCjYFDJNfg4ZULc7yW9OstpjvLhRe3eKNfiPuM2+KIR6Rj3/zgXVaSezZThM37m8Fh5dlNbhW2LJ0XNCRJTr8LtBKECA9hffehdNoRzHy+6MvA1LS5s1xuXa2h+w/lDxznFdk9k07zU4fFA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qu6vcqH7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QOswu39z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qu6vcqH7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QOswu39z"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S5P3qW674763
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=; b=Qu6vcqH7S4kRiMyv
	i07dUB9ZPuUXS2A1oPiLsOegxUYPHLPLw1wJ+OoJ7RNr0p3FF9+CmtRAhC6FUEfd
	zlUwZxAsVcDJJGmE5Je2B8gWng00cPxdjVKpB/aShU4U1S0psa29+ELZ364CKT6O
	UsejVbsaGWiqUk/jxZ/tmmRUvCRKkWsp68jmCZukO4J4dHxPRKoyA0BILvvEzKa7
	Je3aXnJCxGZP25vNaxQQsu11VHTiRai5CWRa8fX0YHiBQwXp/zvZixE8EWUjm+vB
	U4grO12+/Z2w2Bf56XMRSHTot6X2G0OE4rY5IHcDAF2VbibXbSwDxrUm5BI1cZsY
	pxdcKQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s04df-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:09:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so2802459a91.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790575783; x=1791180583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=;
        b=QOswu39zXZxFg5P0ZCwF4XIdzN4rRYaBTxX4bVUKqm+wtk7YKlS1JETFB1PJBfEtcu
         gfS3cAJkdqPO8LXx6Flc+ZnMnu6qGRo07q9fD1sRrY7XpOdnzNRlT3JZlquLscHv0DBA
         7sHzLvqbZeS4azAzo/df+clmgqkL9jaFcuWvD+xwDSBtG1PEfKULMD6Rr5NpmgxzmsFn
         2f1NnBBrJpJB5UAisBgEu9zrUeGtB4Z1P8LD4pS9cCx2Ft0mLB8zeG+jmUsSN+FedrLY
         QSZpmWdm2IvyQJ5CdyYQL7eKBhqnkH1r4pe6RKtrV3RpuJEcCGiZnym6wB8R1O9V48+K
         x7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575783; x=1791180583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+ql9HRxwiF7Hsvr+2veecKSO1rWsvRUfuJvm2uvKQo=;
        b=OwBe/JVjZEwjXWmSUk6i2hin6NsMXfeuu1n1NQfkA8xXYn/Xh/mEWznEfidTSRlEBk
         02H1oKutaHWrycpZTeYftIyj7H8vLqYoHo1CoSCEVKGuJN96c64R3x9cTAtMego+XTRv
         ioQAbwfZewoft2gdKio8eRhanjS6ceRoYwTcLGvCnMC5wkwSvoXrMNeCwcHu9Iis7jBH
         yyZINJIZ/0AXbb/1XRPmjRKTpEJWciTv/SBgq1nGVE2bzLc9u+7S08TZBKKAcai8f69A
         7kfVUJIzewGb8v0JmZ7UNcFTTElwYIW8NdFBil3wBmSp4b661LQTBZOW6L3q9lp11N3+
         7/ig==
X-Forwarded-Encrypted: i=1; AKwUvBxK9lNIpajzfGFhOx3k/Om6G56r0jG4hfcDbrw6u4r6jU8vwOwMoFu5+wI8wfu2AmXSb18+m9O5fQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2BrTYQtWhwmLxmxx208JHbfETcIczMpR81ZCyixovb3VyA7Py
	7LtCFRlk6btN+IsRAdk9cIgN6hh6Q1SsaOGUQuppclHlj9YnqFQQ4Ja/uKvctd4bb4BvDwZW2Jx
	H0ZfTzuRH/5OOddlR4C5HUPNaN1Jd8jgsZ9TpZoX/ZHP8ub1ZqUMsRN9zFslzuQ==
X-Gm-Gg: AYBFou2szy+0MF/JdublLT8rcjfHedWdBrWitJTS79gTdgV9qOtQSp6cuwZj48HNF68
	7PL310gVrlKC08odIpDeotysgWOXahJZqp9qMl8Hdj3nXWBqnXgxL7HAXqXZlHmxsp6MHfvD36s
	GsgebBA4fDH6ymNB2pUDMZy7OjUgHVxzGeGerlMW8h/5L65IRv7QgrPOstsUm8ZwPm4I21QSTce
	CW8Cz1db0WEiZow2VxSSoLA4JE3MGbC7AmRdH4D6qenD5BIHmm/ptz6AI6VOI+TFb8/1MivElh0
	640Ad/c6kXfhV1I82QXC5iqoSr27fcpG3nnx97YuGiH6rds0kAP3LDUiLRDlvED59xfqKWZNgrh
	I1SCIr1E87ddfldBMxiS3UYqr8eIdTO5eHiOQ
X-Received: by 2002:a17:90b:184c:b0:39e:2e79:7ce7 with SMTP id 98e67ed59e1d1-3a098ad9d5amr9242808a91.6.1790575782679;
        Sun, 27 Sep 2026 23:09:42 -0700 (PDT)
X-Received: by 2002:a17:90b:184c:b0:39e:2e79:7ce7 with SMTP id 98e67ed59e1d1-3a098ad9d5amr9242801a91.6.1790575782242;
        Sun, 27 Sep 2026 23:09:42 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm20040846a91.1.2026.09.27.23.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:09:41 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:39:13 +0530
Subject: [PATCH v26 01/10] power: reset: reboot-mode: Support up to 3 magic
 values per mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-arm-psci-system_reset2-vendor-reboots-v26-1-b24e2348e8e1@oss.qualcomm.com>
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
In-Reply-To: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790575761; l=4572;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=3jZJCDBmdKair7R/qKaAWXxKmatvkMOd5u4ong8jp54=;
 b=QeAHZsAp20Q/jJCfU0sVRC8qYt8yx1L7bKt60XOL6rRI3iIvey7f0Eo5M5KzqJEpqT21hBH0Q
 gWQU/cZslhvCN8sZaKkCtwPVaE3vcptPiB9jjJgHgb1268rdRDxu5zl
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfXwWcC7Bdi2Ql+
 BC4JU/tXmAn4HANRs53PlWSslpH/m7wZE2eY4RfMfBSSzZWO2dl7nEMRaP9Efu1fjNW2+USYq/p
 khmfRcEPsxJKH/K200EaFPmtVDwpp66GlNC9FT7716QsCE/xyMHt3cg8PJD45cQAN5ehi+9lwRQ
 7ES8rh/GdTjWPNLj3KtHh7MtooHpmvSAcPaF7Qm57/UvJ6mj53OYulS7RkhfzrZqpDByvhoTwoZ
 plzqHWfUO49+3hNO+14hjJphnDvRTwwZvPGCQpFUbkQVpfKaR0x7tiEZTMHqYTykAlEKs3INaWO
 +F74nfzNdSk4uYwHB1dZP43ct3Ot80JkdNRW5FyOYYdo6oAeGgGp2P/nt47uxEVuOnVwYqt0HmN
 XUBlvxiMimR37R1eMNAU0fxfyw2ALBRU7wDbdEzWeTZEthVmJs9IVyRq8go/ezTckQ2ie6nN/Wv
 dIXG+pZ3ObfF1HsxSxA==
X-Proofpoint-ORIG-GUID: ihRo0FC4wILR4QbRjxA4xe1zfgzAeCR-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX9gi36V2Llhy7
 XUv5piKueL/uf/PJg5VPCklDflbkvhDznJqy45ts/vNzsajqareKTPgsGO0dYb0X415PcWvyqeB
 HopItQaAdQ3nHLpxikB7aaD5yFraAUY=
X-Proofpoint-GUID: ihRo0FC4wILR4QbRjxA4xe1zfgzAeCR-
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba04a7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_usNffLPL2KliZ4tEdwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280024

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

