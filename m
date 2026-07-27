Received: from outbound.ms.icloud.com (ms-2005g-snip4-11.eps.apple.com [57.103.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF203245031
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114885; cv=none; b=GFlaJgip4RdcYRCIc7cOX5En5Q5YJCbbmhWk3NnrZprBqv3qM1pSWIfwsQ9aNldzp04lL1rY85PGHxuPefshWqZ6o7JDmycB5wpjU3TG303yuBKzN4qhSz2RVaZEoqmgl7wl0Ip09iAIobHLvNPYmTx7fnBBiAr6Vrsk1UdD/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114885; c=relaxed/simple;
	bh=lsIH8akIvl8zPN48kUD78zr73GTmTNT+lnnwF1gqzOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzQ1YFC1HL9ERA+EQE+l7OMmoqn4TP00TOndOqOyQIKpVGMe8p+rmADmUl44TqGtsAm8ZW3NDxf4LKenhiTkkLmLeLlXLPUk5GZiM4Ejk2XS8H5z+WfVJ2AQcLdotUwwEGW5ZekSzcRW0lOnPXZtLzmUMOwP7rZdTmz7BelcyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jDxfjZmW; arc=none smtp.client-ip=57.103.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jDxfjZmW"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id 9505F18000E0;
	Mon, 27 Jul 2026 01:14:39 +0000 (UTC)
X-ICL-RepId: 019fa123-65f9-7ada-a4bb-3aac2f55471d
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgZdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114883; x=1787706883; bh=rC4Riv0SFAojJAQFVFHSRvgLANDmnxVm9kt4jXORV/I=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=jDxfjZmWI5HYCNn+ciunO10lBEv3uwS6fg9w+LV0jwYOTcx3f6IyWTCNlCAF0eRp++us6QxNtPznYHf12XWWM2dG9muqCkviWN58pFucKz+QwlffllofrOk3s8YBnNG3pzzQPqna9xbUpmxzuwDa10RIL4YCFnla1w40FTQxEnndX5f6K8eF5vCWX3Ic3JKeBSmAGjil4D0GNpSRJCXYGfb8r5bUO3HsFcvhxAsbib/M6Qr0OunAEC4mOzVT587p/hnuUyP6pWbBPYe/j4bYeG3Rt71aZAPVBL7z47rcYwAhtrdgK8SH+DOtNYkP6QpnHFyoneIkE5r/RfPdCD7sfg==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id 7353918000F2;
	Mon, 27 Jul 2026 01:14:37 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v4 03/11] power: supply: max17042_battery: Use bool for init_complete
Date: Sun, 26 Jul 2026 21:13:01 -0400
Message-ID: <20260727011319.621794-4-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfXyZjHedhkFQYD
 /FnJa2zhadCiVIsLj+m3ntjwKrfftolcfgqvCjoXWTkpQF33snGTll7FZQWom/Y0aUYbcLgWAMU
 1/yKyW0haQAjhIyQH8ulBx6JVaimWzcwHwE5e7dJilQQTMvOYyRNouVxBPqChMjcqEhPfd4o4T1
 fS3rXskeugJ0Or5psLyOw4OGtb4HU8LNExJ6YQVTld3zn7xsEb2TDlSVobK0gIn8z+AxBvFreKW
 agbGbVTjyujtoCrrO9pNVWsdggX0vSkP/H3MrWqEos5ZA5m7DnVzeMClxyrYeQ2jYGfsSW+dDpn
 Frp52jRbnFNU3PID/NyPy/bmrGPPlhkH7kQrPk7hAf9rRjy8IG7zCkWR2XClaI=
X-Authority-Info-Out: v=2.4 cv=G54R0tk5 c=1 sm=1 tr=0 ts=6a66b101
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iASaqbhQXdlCfafqXlEA:9
X-Proofpoint-GUID: tdBn1xj7yXsg62NMDCWjXjuk0Q01MVpR
X-Proofpoint-ORIG-GUID: tdBn1xj7yXsg62NMDCWjXjuk0Q01MVpR

From: Vincent Cloutier <vincent@cloutier.co>

init_complete is a binary state. Change it from int to bool before adding
retry support.

The initialization worker and probe path update the flag while property
reads sample it. Use READ_ONCE() and WRITE_ONCE() to make those lockless
accesses explicit.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 70c5d5ce945d..e11d73681a67 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -69,11 +69,11 @@ struct max17042_chip {
 	enum max170xx_chip_type chip_type;
 	struct max17042_config_data *config_data;
 	struct work_struct work;
-	int    init_complete;
 	int    irq;
 	int    task_period;
 	bool   enable_current_sense;
 	bool   enable_por_init;
+	bool   init_complete;
 	unsigned int r_sns;
 	int    vmin;	/* in millivolts */
 	int    vmax;	/* in millivolts */
@@ -256,7 +256,7 @@ static int max17042_get_property(struct power_supply *psy,
 	u32 data;
 	u64 data64;
 
-	if (!chip->init_complete)
+	if (!READ_ONCE(chip->init_complete))
 		return -EAGAIN;
 
 	switch (psp) {
@@ -1006,7 +1006,7 @@ static void max17042_init_worker(struct work_struct *work)
 			return;
 	}
 
-	chip->init_complete = 1;
+	WRITE_ONCE(chip->init_complete, true);
 }
 
 #ifdef CONFIG_OF
@@ -1256,7 +1256,7 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 			return ret;
 		schedule_work(&chip->work);
 	} else {
-		chip->init_complete = 1;
+		WRITE_ONCE(chip->init_complete, true);
 	}
 
 	return 0;
-- 
2.55.0

