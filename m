Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A58495E5;
	Fri, 24 Apr 2026 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993420; cv=none; b=kSbAM4UDKkTuq59kz7TrwlguaKuH0xcMBKHAFyFq+eZr4uNvWVttGv8fyBGyZ/2xg1n03BWQVu68uMNvgQ1r/kpwx6frPkIYN72SUq3gLLAr0hy3jOhMp9D317n5oxvZU0+fV1h7CaWjVR5ohveuOo7QtdzS8zC8VI8Y/dJr1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993420; c=relaxed/simple;
	bh=niKI0Fdnr73pUt8ud0IpeCJ1/qsta5AV18WFsQj/1mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GEtWTsLQ0FDCjs6xtzgagFwTLNhmhCxxUvXiiBbpauD5yLZylvXTILbW2TrQsHFhofNBA4JTUTDf0XV6r8O2Ln4p+PlpgCcI6pt2PhYu375l4NVroSzGyCiJ0ljpKF2PzNUiog1KpgJCXaosDdtzc7Vw33eGpT3R2hRyTRUnZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubuntu.. (unknown [202.112.113.208])
	by APP-03 (Coremail) with SMTP id rQCowAC3usH2wuppP2AADw--.19102S2;
	Fri, 24 Apr 2026 09:10:22 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: sre@kernel.org,
	philipp@uvos.xyz
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: cpcap-battery: Fix missing nvmem_device_put() causing reference leak
Date: Fri, 24 Apr 2026 09:10:13 +0800
Message-ID: <20260424011013.879639-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3usH2wuppP2AADw--.19102S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy3Gw4xGw4DXF1DXrWxCrg_yoW8Ar4kpF
	W7GayYyry7WFnrJ347Jr4UuF98K3ySk343KFyxK34j9ry8J3yYyryYyasrJrWUtrWkJF1F
	qFWfX3W8Gw13JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbsYFJUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In cpcap_battery_detect_battery_type(), the reference to an nvmem
device obtained via nvmem_device_find() is not released with
nvmem_device_put() on the success or read-failure paths, causing a
permanent reference leak. The driver’s retry logic on subsequent
battery property reads can compound this leak, preventing the nvmem
device from ever being freed.

Found by code review.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Cc: stable@vger.kernel.org
Fixes: fd46821e85de ("power: supply: cpcap-battery: Add battery type auto detection for mapphone devices")
---
 drivers/power/supply/cpcap-battery.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 7b7bdce3162f..59c741993ef8 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -439,10 +439,13 @@ static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
 	if (IS_ERR_OR_NULL(nvmem)) {
 		ddata->check_nvmem = true;
 		dev_info_once(ddata->dev, "Can not find battery nvmem device. Assuming generic lipo battery\n");
-	} else if (nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
-		battery_id = 0;
-		ddata->check_nvmem = true;
-		dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
+	} else {
+		if (nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
+			battery_id = 0;
+			ddata->check_nvmem = true;
+			dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
+		}
+		nvmem_device_put(nvmem);
 	}
 
 	switch (battery_id) {
-- 
2.43.0

