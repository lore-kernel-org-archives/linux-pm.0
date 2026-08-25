Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A93DEFFB;
	Tue, 25 Aug 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648797; cv=none; b=g4zN3pIUUtvkFM9VD+BRopLNNxQK975i8SaGPUaqgDO25f7ShkKeQY1ufEfDxxQ9Zj+CoOu5tvLvm8R3szJTyZ8W74ulJ7RUTol3hZk6uTZ5GMXlzSQN9+065K07TY77zRZA+tEoHLkfcdZDfYu1ohgeTFcYdNXCRyNcuUNxkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648797; c=relaxed/simple;
	bh=N8hQgVJQMRAjgDI24HZAuZWZq78U14wkgAqVoXqX+SI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YAAgjsNa0Q+6YS/kIR2HlIXRESu3ufH0pDTP50R3gZWf9M91HNmlAgO+ugrTido/FzJ4GIUDWGIrm3xypq97/4noJpkbTG5ciZKFSVRWufX7DaTj/ovYIT+NeqUBZtO9O5lIyzDZwR284ipXD3E/Q4B87hTdIIKMcxhqWMcloII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qg9PpeN0; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qg9PpeN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787648789; bh=N8hQgVJQMRAjgDI24HZAuZWZq78U14wkgAqVoXqX+SI=;
	h=Date:To:Cc:From:Subject;
	b=qg9PpeN04PKead5C+F7BK4V3BkRUvdBwFJLLn6xiB4wAhK+QZycAdxMGvEqeEsuK0
	 CjqZC193uu0SjrizxWS3WDZF5st1Y3TuXuG63rZhhDHs9yB22Qp4xCDo/5LE1IuQQ3
	 haP89dXKDmAO3dT+tFpMQBhgbWn/WciNhL1fYL2w=
Received: from [192.168.255.10] ([111.206.145.19])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 19BB7613; Tue, 25 Aug 2026 17:06:27 +0800
X-QQ-mid: xmsmtpt1787648787ty2oehi27
Message-ID: <tencent_FEA132DE8F67C73343A948D94E5ED262F608@qq.com>
X-QQ-XMAILINFO: N2zgDHximsrqO0isq5V7teGyXL66b9NHqA4PnH8qdOF9rhtx7SJO0BwBDj9NbP
	 WXKDMjto8818yOT0vFFGn+7paRZyQ5zwJ/wcKRQWO4HX6AaCRie1VQNaJANby/ro0lCEK+0JEsDU
	 /tsygYfDoVMlrxfWCAAuTEjPwu8+sSgSEMCJQZEz9AiV5ImEb7OEKnTLKnr0stzYF1chqTUO18rC
	 wCXIlxB3Q3V6rl8X5xulEgOkjgk7bzmOpgIJG/iRh6p2gAmUmWudSWHyqgyN1acMMSVsrXh9AeRZ
	 A0Xd8LU3cWWt+JYojT0iLBfNnDe2XXhtVy4B3p3T87EJYchV/w/r8XUUVg62HqqJ5aiNLWLFgsba
	 r0u3lhKh1VlecsTvlyNrQSZFI2A3xjeogs0CLbDYCK1O0ROtLrRj2t0s6Da2+zLnuwXzQlhKP/2V
	 syCX6i73thJh7P+deBnK5cgSN4bOrlpnVCJ6zFsK8k63VZhiCAVCyyRaiIUnZ47n/S3rWlYiUQpt
	 +REoTgnDcUxSFB55xZ+SyhufjWs8oK3RVBBtDoQahtMQv2zE5Pmu+EeRg/+lAQ3OSK7Ml+z9WDas
	 27iV8QwapsHAJnp7YlJG8hwlK7om90CMIO3wc+cDbKepVqVaS9mDgq1smUy5folga0e22mvBnfvn
	 SbDn1qNCCbAVeAPxA3hZK6ed7dcXUixJur49TheB7iF8+QfI9w1TIbInWuJbkhswe3LSHJ0D2suZ
	 L1kpClp6eDYYXCg1Ik/s2vCdX7XiMa98bWhdc10qjqApI7uirlFYItFcpmRi9yXTE8YCMduJk875
	 jjxqRkELnYaLYJD763OtAi34633be2lWlWepHyvk3C7Xe2pN15XSCTbHI/oQAxG+UmXo49lODZGR
	 9PQ1uJJ0Q7uVQwVsoAuZGhuRFgRxMzL59dbvyM8FdGum4/VQkKRfcdRZOLJdSg62KKr2d6NA7HGD
	 qi+fh3l6lkLUX0uM65mgEDCgjs0VSJ9IDD2GWbOp7OCWP0tYt2gAa5eDnzqf00Gn+hnl4QndBDIB
	 M3n0+SUgEQPt/PtX82403ZQnltQGnJJS5hU2FUJWtmcfj/glvK
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-OQ-MSGID: <611829c0-62eb-43d8-988b-514de61619be@qq.com>
Date: Tue, 25 Aug 2026 17:06:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sre@kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] power: supply: bq256xx: fix uninitialized battery info
 pointer in bq256xx_hw_init
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In bq256xx_hw_init(), the local pointer `bat_info` is passed to
power_supply_get_battery_info() without being initialized. When that
function fails with an error other than -ENOMEM it does not set the
output pointer, yet the code went on to dereference it while applying
"default" values, leading to a general protection fault (NULL
dereference).

Initialize the pointer to NULL and return the error immediately instead
of dereferencing an uninitialized pointer. The battery information is
only used on the success path, where it is guaranteed to be valid.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 4b1f81b1ed86..6a5f73bcb928 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1556,7 +1556,7 @@ static int bq256xx_power_supply_init(struct bq256xx_device *bq,
 
 static int bq256xx_hw_init(struct bq256xx_device *bq)
 {
-    struct power_supply_battery_info *bat_info;
+    struct power_supply_battery_info *bat_info = NULL;
     int wd_reg_val = BQ256XX_WATCHDOG_DIS;
     int ret = 0;
     int i;
@@ -1581,33 +1581,14 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
     if (ret == -ENOMEM)
         return ret;
 
-    if (ret) {
-        dev_warn(bq->dev, "battery info missing, default values will be applied\n");
-
-        bat_info->constant_charge_current_max_ua =
-                bq->chip_info->bq256xx_def_ichg;
-
-        bat_info->constant_charge_voltage_max_uv =
-                bq->chip_info->bq256xx_def_vbatreg;
-
-        bat_info->precharge_current_ua =
-                bq->chip_info->bq256xx_def_iprechg;
-
-        bat_info->charge_term_current_ua =
-                bq->chip_info->bq256xx_def_iterm;
+    if (ret)
+        return ret;
 
-        bq->init_data.ichg_max =
-                bq->chip_info->bq256xx_max_ichg;
+    bq->init_data.ichg_max =
+        bat_info->constant_charge_current_max_ua;
 
-        bq->init_data.vbatreg_max =
-                bq->chip_info->bq256xx_max_vbatreg;
-    } else {
-        bq->init_data.ichg_max =
-            bat_info->constant_charge_current_max_ua;
-
-        bq->init_data.vbatreg_max =
-            bat_info->constant_charge_voltage_max_uv;
-    }
+    bq->init_data.vbatreg_max =
+        bat_info->constant_charge_voltage_max_uv;
 
     ret = bq->chip_info->bq256xx_set_vindpm(bq, bq->init_data.vindpm);
     if (ret)


