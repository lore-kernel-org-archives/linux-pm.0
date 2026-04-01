Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C636655D
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027275; cv=none; b=C5YUGKkxHtrKOEXn6Gl8MsdKgCgMKMEd/3o7i+Ub5KBQBpY6P5QsnO+jDm2ekXl4+K6vux7/WGhuLtkQArUjxws8gn7RtQgOEQyYdSUZMEC5r+j2bf4N8flPxQZ/JmbpeFO/uqGoJrutfGOw6aTfa5eLoNKiYLlKieZ5EFqoFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027275; c=relaxed/simple;
	bh=T+IWKxfeCPkpA1AnDHhXeuS/tHjUqOlcH1i0llq8gp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQVMZfIMJ4RiMnum51P+7nDSJ1QEQcUjjqWYWLODBxw54KSb5yMm/Bhbc2Qt08kFFsM8OUkVC2i8nbfoTa5tP/mozLTXd+Qm931E8aQ5NqSzdxdM3nWvbOTxhNiqt5tidk089o+YaW12pqBBchPxu8YcOt04uk/42qSAx9TlCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W5mzHLnK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bK2a5bS3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W5mzHLnK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bK2a5bS3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6314SI0k3364203
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 07:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o3ofgjDB/Fu
	qgWrFRH0SxfEDOyGzS/rdc4+8I6d2b2I=; b=W5mzHLnK4o5YZdk5oEXDbVUe9Hz
	heEeXKtoMp8rsi7hzoovX/6hdI+U0f3ubcjRMvUKatBi+OPF/Uu5WoP7kdD6ZX6E
	2z4TVl08VMC/Oj+84lnAoo1jsQdbVdTEtu7L8PzrPLHrpFxx9EKGzRS9G4nkOFTb
	jzUQncKypB8NkwyVNSoi9k2HLHX/BSpGQaJRFOesdX1hCkqvEBKcofwKbCCBe8CT
	x8HfDV0dAcgd+GWsVJQOXjHuwQzcRedzQvwVYxR5FRKVhs7L+lBtIfFD4R1u4kmv
	JkYgvK5bHslndswUGYEXfizOr4T1Z22xEqDeI6H73Tb4wzS8mJlu7hKTv3Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddj49y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 07:07:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3568090851aso20474866a91.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 00:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775027272; x=1775632072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3ofgjDB/FuqgWrFRH0SxfEDOyGzS/rdc4+8I6d2b2I=;
        b=bK2a5bS3uZseaP0N5j/IyN4hTCBl7dVRek7rSV7ptkahqv6PbtkCo/g1PP6H3GmRn6
         vCEB4RndA6CD1ZWrzthwa8FnqAJEJYCPrDvrN8/SQ6etySb4W5GDlLL0ToNFNZvr1AYv
         SZBGWowNqEjTChkby+6/Q2pUJA7gDDdGzfhR9hmNeGa5PnvCl8Vo3q9O1lID5dqEz/qS
         B5P3nk4LpIc1nRAUzbP/3wliBTTbLSWThRJ/NJjukflkrI3GOqpzpXlXgpmkQCknPct2
         L+WUz32s1npLyCledLtNf5qXW/s+aNFAgoxiC6/XVx/l06Z5GRRhYKjAdLByTaqiQi4n
         o6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027272; x=1775632072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3ofgjDB/FuqgWrFRH0SxfEDOyGzS/rdc4+8I6d2b2I=;
        b=jFjt2v2av2BKyIu76+5DzDyVNn2tUFrFKysy/+EhVsMk88j2iadvOU7gy5y9RXvTAZ
         fNIHqTFR1lgSvL5NmVq9/0f3uAlUwIQJweJDtAsia0IeTNpte/tI1n9zvfrJ+Z+yRR9X
         k5QHZZKYf4YQVVr67d7/KNH+1xtMgij0qL7A9sPmNBfX09lAwhGrZq5OrT7Wj57kiEBN
         Vf76USva/d3dFyuozLvG2HZtHOb62P2+VoEkArnN7c5bs4GJVV19jvHw6g65NblnKY+k
         yfFDXD5iGFcbdXm77KM3oiLZCit098LZ3mOlLs3p0fkWoraRjRyMoFjGYaxr5lXD7/Ge
         DfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVSKv8APaQRjZ7hjvA2lFALLSbx6th0h1kgIUS7bsG342GZB9WlfGDPVHrx2S7OQelArPhqHJ0Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtypT/yyIYUlICzxZbm8bpwmrNzBoDlQZmbPX+991J2U00XVhh
	SeSH9mrzL8IwIhpCyfPlfw+OhPkfWvRrl48yWk88s6barpPMm7Z+5QaKDhdu0jo1/WYY0lHHeqW
	FozGcpDkuhPSWbL+XIZJ/d7XIFirsq++50Hi9JNk4XgqEYsUVrV7sluV4N54oMg==
X-Gm-Gg: ATEYQzyK633Kbmrq/AEKnIQmqUBfUr2XtWgfzUUO5oC3JQ4VvP3Yzwsaeuhkr3OrRmP
	/qs4GV19YO8MyWyeh6XgW/S6jSDQYkj8m9riaKJPnIlcmdkKijSN0iZdaY3yTu4hato96d34jBe
	i75f23ju/Ys0x43hMD39BDmPkKU3w8YJynFTZrSwBEcHDQbmxVwz3jonk4ljUZpgOrKDkCMxBnY
	lWA73eCYzgry90/XwfKzUfGDjAM7SFCPc9gdv4RRbfnoNoibJDB6uAI8qxVEHLLUZ60V3v3l0n/
	Cee3/uYPsXKY9z31Yf/2nmAiv8GyEGgFL2VfjkMpqKaFJFhJm6wVilLpn0FAHHPWeV/dl1FF1nz
	cclogal+OjDQiK6rjdDv/Lb6XQzy7hQsyvNC+
X-Received: by 2002:a17:90b:268f:b0:35d:a9bb:1e33 with SMTP id 98e67ed59e1d1-35dc6eb9dd7mr2548382a91.11.1775027271488;
        Wed, 01 Apr 2026 00:07:51 -0700 (PDT)
X-Received: by 2002:a17:90b:268f:b0:35d:a9bb:1e33 with SMTP id 98e67ed59e1d1-35dc6eb9dd7mr2548336a91.11.1775027270961;
        Wed, 01 Apr 2026 00:07:50 -0700 (PDT)
Received: from work ([120.60.63.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6e2fc9sm3956464a91.15.2026.04.01.00.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:50 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: brgl@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] serdev: Add missing stubs for serdev APIs when CONFIG_SERIAL_DEV_BUS is not selected
Date: Wed,  1 Apr 2026 12:37:33 +0530
Message-ID: <20260401070735.107162-2-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69ccc448 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=zTATW481NYPnotdwU90osA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=JxTtsak3BgR7EskHxGAA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 3mnNb0n1NJPf51sDp8XVPEOtb3mLLbYb
X-Proofpoint-ORIG-GUID: 3mnNb0n1NJPf51sDp8XVPEOtb3mLLbYb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MSBTYWx0ZWRfXy8aN7xHLzlGc
 wavCebA9WPl4iTT984aX4SZ12T9HxzD2SemjoNVqaFDudDnyqJZ5fky5d0jLGh0xLMrHmgdyovK
 4z/YeX+irDuGQuMUKPBjVRla+ctB5N4eT9/TmkxasjKTPmrkyTkAU5B95kuRaBkOtAgdOz5eFBU
 GVwclXttft1gDDRDdBacX/b7anKSI0HY59zYHpoaIHxMs5unlIXJaElz9hI/BHfVKEgnAgGLfi8
 FoD2xS978rEN+5euL7+U1Tft8KeJjbCgnN05wMC1V8RIyJ9rxM4qor9TEATEIJRWejr7n9l1w4N
 QtrGIn9i71pKwmVnsR7pG/T+ckpsJkXelS/9UmoeK5wf9LJHI3d5ekerys2+DLhZg/GSPAJyCcp
 jeG7PkFMI758lpP032X3Mys6LVIZtrbOs3tIV5y1KRh9+9d4N8VLQ+kFWjzqLUs/hJFDfu2wzmA
 J/oOo1UrdFTU+Z50dkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010061

Some of the serdev APIs are not guarded by CONFIG_SERIAL_DEV_BUS and also
missing the stubs when the symbol is not selected. This leads to the below
build errors:

   drivers/power/sequencing/pwrseq-pcie-m2.o: in function `pwrseq_pcie_m2_remove_serdev':
>> pwrseq-pcie-m2.c:(.text+0x260): undefined reference to `serdev_device_remove'
   powerpc64-linux-ld: drivers/power/sequencing/pwrseq-pcie-m2.o: in function `pwrseq_m2_pcie_notify':
>> powerpc64-linux-ld: pwrseq-pcie-m2.c:(.text+0x9c8): undefined reference to `serdev_device_alloc'
>> powerpc64-linux-ld: pwrseq-pcie-m2.c:(.text+0xc00): undefined reference to `serdev_device_add'

Fix these issues by adding the CONFIG_SERIAL_DEV_BUS guard to function
prototypes and stubs when the symbol is not selected.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604011226.KGNn5974-lkp@intel.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/linux/serdev.h | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 188c0ba62d50..0de261a26284 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -156,16 +156,6 @@ static inline void serdev_controller_put(struct serdev_controller *ctrl)
 		put_device(&ctrl->dev);
 }
 
-struct serdev_device *serdev_device_alloc(struct serdev_controller *);
-int serdev_device_add(struct serdev_device *);
-void serdev_device_remove(struct serdev_device *);
-
-struct serdev_controller *serdev_controller_alloc(struct device *host,
-						  struct device *parent,
-						  size_t size);
-int serdev_controller_add(struct serdev_controller *);
-void serdev_controller_remove(struct serdev_controller *);
-
 static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl)
 {
 	struct serdev_device *serdev = ctrl->serdev;
@@ -204,6 +194,16 @@ void serdev_device_write_wakeup(struct serdev_device *);
 ssize_t serdev_device_write(struct serdev_device *, const u8 *, size_t, long);
 void serdev_device_write_flush(struct serdev_device *);
 
+struct serdev_device *serdev_device_alloc(struct serdev_controller *);
+int serdev_device_add(struct serdev_device *);
+void serdev_device_remove(struct serdev_device *);
+
+struct serdev_controller *serdev_controller_alloc(struct device *host,
+						  struct device *parent,
+						  size_t size);
+int serdev_controller_add(struct serdev_controller *);
+void serdev_controller_remove(struct serdev_controller *);
+
 /*
  * serdev device driver functions
  */
@@ -264,6 +264,28 @@ static inline ssize_t serdev_device_write(struct serdev_device *sdev,
 }
 static inline void serdev_device_write_flush(struct serdev_device *sdev) {}
 
+static inline struct serdev_device *serdev_device_alloc(struct serdev_controller *)
+{
+	return NULL;
+}
+static inline int serdev_device_add(struct serdev_device *)
+{
+	return -ENODEV;
+}
+static inline void serdev_device_remove(struct serdev_device *) {}
+
+static inline struct serdev_controller *serdev_controller_alloc(struct device *host,
+						  struct device *parent,
+						  size_t size)
+{
+	return NULL;
+}
+static inline int serdev_controller_add(struct serdev_controller *)
+{
+	return -ENODEV;
+}
+static inline void serdev_controller_remove(struct serdev_controller *) {}
+
 #define serdev_device_driver_register(x)
 #define serdev_device_driver_unregister(x)
 
-- 
2.51.0

