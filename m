Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789642;
	b=0QYkBtsATZnQVCO+vl+9YvzEMxUotvT03AYXObPtyeD+5hsd9W0SK78Yrf647aUbQuOP
	 QnjypiYOqp63f0xc8Qwx6KovQldJkF1ACwyMa0R+eEek+8+glsbzA7cGiwmwWfhkgXw6k
	 ZiqIhyhd2lmLLDZdYiDwf7Z2hgBK6nvbJppmOGkrUJnJ/Ki1E6uM/JrtzvU9CyHuy/7ec
	 /iwe4M4dI2L7pSkCbKEANC3syZSdD4ivMRatvRaGkutQ8ZI0+gUs/SZSdjFtup774y8m6
	 b14UwJMYYgIfOA9ObzxSoWkyYoU8lJqfSu6+5y86xLfAYDFCqfJyTlqEg+hRWpoqrUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789642;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G+/mPIAlAmNu65ne7MgAhXOg6Anmd5RRFn5vcEzFy+E=;
	b=KK/uS5xmmEsbxXR8rFJhF76bKp9L05bk4pwScG+0LbsZ3TKa/f/vLDUCN7cb63X4pnD3
	 8ArNGoq12rlt72KDDzdG0dgW4YV0aqISHn9VtLTF3ULfq0Fn7cNzSffypY+PR0jX2h7wj
	 hkfsmoRLbH60nsjdh3WNaJ9YLZ9OnrfkFcVh6Zu+Pb+Cgl3bmIu+67B+5hd9vIxg3bpJL
	 N41YEARUtHGp9Bc5tu5tumMGK7+z5mY2VrJim064nLY/7RiASq4QKwUge0OEAKN9a1qIz
	 KPn1d5j0gSAyKlhIo+E8vfs8YzcsDuiWM7S+EcYQDKrkfS1qU9ZvTlR8kIssERwEm6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O7E+Q1pL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J3vR0tts;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45905606A6B0
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45905606A6B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O7E+Q1pL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J3vR0tts
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Kei685979
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G+/mPIAlAmNu65ne7MgAhXOg6Anmd5RRFn5vcEzFy+E=; b=O7E+Q1pLySSzaAPl
	9lJy5CK6cZMgMC4XZYlp5dOmD5x7bEmhBRO50n6zO8njZqgn5kbpfukpQaGai9IU
	b7MbnkuFO/K1MdySqxX794+8oUwvfknkIJCXPoQshJfGP0l3I7DH9eVxGFeG6oML
	jHrGjccLL9+whIidtIjb0KRbA/t8lcyfw/mGWEXBbXW4P8XOL7bF4MLYkQotye40
	h0Ur+dvq929u295mNm5ZfBo7TynZ+2a3LQAWyR+ZHIZEORpvUpXhwnrn1TduytMU
	J0bd3aZoLtZHJ9emPgsBaq9APHQAAeRpev3mwCn7GeRMhkn8RuZCZKCo4yb6vI8x
	4ojPJQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49bcy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:21 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cde02b50dd6so5639551a12.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795789641; x=1796394441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+/mPIAlAmNu65ne7MgAhXOg6Anmd5RRFn5vcEzFy+E=;
        b=J3vR0ttsryF9TLvmAw6ZI4gPNJ3P2iDKgyFNtQ6Om33FLqycnZngcAKNztFvmInJFA
         ADkQSomWzK2gfk9s6v2ahXWjReWPc5XcLcN2+WZRuNahUk7pfIjYVwFlh/drKl+fc1Su
         fChEERt5/d7pkqrGAFLAQrYmAClxeQDUjr8tD/OMXfEMgRPY8zqSXFrgSF0zWtLQxvsn
         irzRZflbVfhcQo1zQL6vFJvDIwBa3aIapvB2/V86VEgMG0w6xHm4f0cl8A/PeFKpPNrW
         VpScqdfw9X+VB0QVHsttUr26qTrh0JvMvBuj6eYEaRe9uZ4a5tKzPc2c6E+HpiuZyiZk
         GbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789641; x=1796394441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+/mPIAlAmNu65ne7MgAhXOg6Anmd5RRFn5vcEzFy+E=;
        b=LL74AY5dMySVkesrBIXedibaTVPJVhZAdQsQpSDUlyCbL3P79N9pV6HRRjj4uB6Cms
         UDJacU1y/Vq8/9C85yKhW3JrhnGFV3fDUxdw2W5sTqA119GbWsymcaOujpE3hYEnoBK2
         GQ+b0Rtco6XzG7ZJxuVAvmZDC4RFP4mvI9ucQcxaWYqFQ0C7bVeeDZRWjoV3GNwN0Ndj
         ZDU0MkrIAMhOv4RfPtH15Qb/k931z0lcmAqgAntYXyjXoK8jbuUmeg87D1jZ9n7Fmpa4
         ICapxSVBOJDCO4rNP05P8JgpHecX75ezxEDlrhGcq+1l5/TAzYojkl4tngVmpfvsib6m
         MZrw==
X-Forwarded-Encrypted: i=1; AL+hErFVYPR9z42pHF9XwvN+Cp9FyYXXHxSOZc4A8ODlRkheTlzkMy6z55WBnROQuVPXmk/qJIAzmJTV4w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8w1Krl1rRR1x75MkRAUOrNOD+aWojcCZt2dwUL+Hkr8UsNhtTa
	/sV95RN80kfMHOsYapxuPUiZntlDARA8yZ+X9Wx1a/oxOr6HnwxPb2/7+gi4zETEEeNLs31WX58
	UDA+K2mcFOyxL7QVhIudrXprIxKw3j1m32vGBBZAXbVhWJr8nXiISqYZOBESvkH/lbQV+SQ==
X-Gm-Gg: AZFdTZf1zwS5WZvWsQAKNXkrCiX4zG/ZvZEnr7EZnE8xQccLvsyPe74UrjmfZDt6Ca2
	Xcw7a18saOc0ql7rHqv7XVUfRNEbNCxihQeupmM4fN9f6gFmq3l8niedmWAL+4aXE7GeLheq8h6
	otoJqPc20lGY7LqAmpFTG7qXEClawjXJkuFj+Ee8kmr3p0xY0GuFDeDIK1HL3rvbQ3URAk/Bjx+
	eSKAWELEjqdOwHMWXUi6/QfpxQvqWgrafs/D89LZegaArNOUheTzymhs2kwcuMjPcHiu/BLlCo5
	xhMYiSquUQYQM3v+pkmn8hVgV1Ap5PTOyNckYQPLvsjtJbAEAxzcIskcjWsbn4VnJyrSHbh+JVV
	3rsseBXVAPyIAnQOjhGPt+VLM9rpBTmsYI9b40/08mhG9jXKXVfXPZYGs3NBrJMqe3alzo2RrEE
	Ff3T5nHGsbaQ==
X-Received: by 2002:a17:902:f708:b0:2ed:1fba:e5eb with SMTP id d9443c01a7336-2f03f1e849emr181429255ad.27.1795789640752;
        Fri, 27 Nov 2026 06:27:20 -0800 (PST)
X-Received: by 2002:a17:902:f708:b0:2ed:1fba:e5eb with SMTP id d9443c01a7336-2f03f1e849emr181428765ad.27.1795789640266;
        Fri, 27 Nov 2026 06:27:20 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84285sm120324055ad.3.2026.11.27.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:27:19 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 19:56:54 +0530
Subject: [PATCH v28 01/10] power: reset: reboot-mode: Support up to 3 magic
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
Message-Id: <20261127-arm-psci-system_reset2-vendor-reboots-v28-1-da05a33b08d8@oss.qualcomm.com>
References: <20261127-arm-psci-system_reset2-vendor-reboots-v28-0-da05a33b08d8@oss.qualcomm.com>
In-Reply-To: <20261127-arm-psci-system_reset2-vendor-reboots-v28-0-da05a33b08d8@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795789617; l=4639;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=s+/OOgO8ouYEbBmn5eaEqRu0J/fLnxD34GTBaKHGJJQ=;
 b=Zr3zY7l6pVS0J3mfCCWbdt2hj4OwyspykPKTI4tmwiwhAVmXyOemVxAeR8jcXBr5Lj4wg5+eW
 yeXhKf7gCd0Cy7e4MK0qzeMXTZNGVORK6M88L3P1kURcn6Bgw7H0YLN
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-GUID: eQMIEESqsZk1Owc2mFOo1l29nSUqxA-x
X-Proofpoint-ORIG-GUID: eQMIEESqsZk1Owc2mFOo1l29nSUqxA-x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX+NLRZfLwEo/t
 X+kEGLkyaSHTb6iGj9wRub84zm1OVOSyvg7MnEecnFQwIFecMjweLDewI2jJ8XDy+zuXeET+Y8F
 dw9e+wp8i7umGprkxYg3UkKUGjZJAF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX941r5EkLNCXD
 7zUJzxh9R0yMbsRRjMGwnYvTGAjosMVOR800qb/FDwGenEinqeQq0GqPSqLYSSmwGKKLzQwzzMg
 sH1d2F7kuVwgFDv+mSj7a1rGEhpw0t6oWhSy2ljYs7UrrFIflxjNUxqa+Nvy7PDOyB5AV/N0ZmY
 cEi+4tA5wRtr9V3zQPGdMvcKWDjDIB9MsR98onxahWIGcm54I8UJN9CqbpqBn+QwpOZTKblmowv
 lluPKmT0oe13bmzvljXUHt8sfihsNq1PU4A/VrIo+CSDmZpxPPZhiGwlLf+R57vovlAtaa81L8E
 IyrIjWtUnV9nglsee3E1YdbopKmkeKZAqO7UvcVeE62PJFMd6kzCgY1PrU2ExAf+qWUcQjfSFWs
 kJKBM560gFDkoUn9m7NUtV64kGcdccdiPIBt0h7hO4eL5TVx7bTlSwNm7jDuoR3m+z11xv+xH9T
 JTR4xFA5I7PkysL2KoQ==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b099349 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=_usNffLPL2KliZ4tEdwA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270057

ARM PSCI vendor-specific resets, require a 32-bit reset_type and a 64-bit
cookie as arguments. This cannot be implemented via the reboot-mode
framework, which supports a single 32-bit argument as magic value.

Extend the reboot-mode framework to support up to three 32-bit arguments
as magic, per reboot-mode.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 46 +++++++++++++++++++++++++++------------
 include/linux/reboot-mode.h       |  3 +++
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 3611bed341e14..328fa37598df3 100644
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
index 4a2abb38d1d61..29ae39935d690 100644
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

