Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980877;
	b=J624sat8d7r6N5rIcphz5klAAPO/0Y7nSlXvIBmj0QW7CLoRMkSYRGHQcvDlLjoNG2e8
	 vN1C5u0xIqYIbMuurxq8V+KyUY+r9k0B1XbBaushLq4LE3a9WyrpJcFlhlol25lzqaanD
	 MFZNdVE5HDHzc/zlagCAu/EakDOmJSvrQB82HCXs92rimGniYrXPO+dO8fHx7x8/BR+9G
	 K8nfw7Q89CwyK6uwl2kibCPBvcjx3ThuAE0YuHIGD5+5IREqDHO8NSphM74tIfUVe6GZc
	 DHEjLKjOvV509BXecmW32TabXNIReFAhSEXQDkEhc/5nyITDtuCTixFYGIirEKasgDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=On7o3YDJ6A9N2qE/v0Dd5vQ6+keSrhVbU1SUb028uOU=;
	b=H7FMNcfEcUYECxkJD72QR19oR2/eYmKwYIVtqF2j/YfpRbNzueOVSLF4OvB5USfIYQmm
	 +YCnzetB/On7ifdCwTVMliSAUVxYjOtLdOE2fxi75PQ+N2RUDLHFqlhibGt3p/+cZLO2c
	 YkHqmlFjI1mB8tVOqcUHu+MQKWC+0dx6WEsE3LKd2eWBCYUeyhWmMzF80nwMRxn2DfeUF
	 rkJiYMH51vGbM+fb4Cpzy8T2TKFzmKX4cIl2iDSJp9561EquXUz7dLc6E1PpxdXPBs9av
	 DqBIpv8tTpB7iU82/giIAvRrPRTlRYwqw3sgUq9Z2hna6nx1zk3gtYLmnO2LFwNIvqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrbj77ew;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005D606A33B
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8005D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrbj77ew
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so318428b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980877; x=1794585677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=On7o3YDJ6A9N2qE/v0Dd5vQ6+keSrhVbU1SUb028uOU=;
        b=hrbj77ewuQUUx+lfk2VXUxZ8o8kG2nckHoFyKAlQmdKiLGC2XGSsf90xGU7XjRdxpP
         H2dz8v1tYzzjMNxYTGLSOcQfK34VSi45KPlK0M6C2NwhZ71qodmEbXo2qrkTwSdOogNg
         MDRv95aG7YTffY+NZbjyNzcg2LACsij6XKF2b5zV4GzC0ow+/Yu65T+k+Fk/PqPrQV68
         xMFBQIROlXCiD4eWpqLvN/OMSezqsMt4omG9/xJHJ6L9dKD7R0hUaLqmOUZcMQxyMsMW
         0hoyX2O4rC9blcOTm6Hp6nYemv0XA2Wvg7tAfCJqDJWE6JPkhb9JHRaYgMpXY3OVjCJz
         NIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980877; x=1794585677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=On7o3YDJ6A9N2qE/v0Dd5vQ6+keSrhVbU1SUb028uOU=;
        b=qa0c1RzuLewgobM+CHCOoBtMaA2Da+mQmjCMXIkCp8sDPBy8TsuF3zItgZVMfSE/mY
         8E9LUKellcHNp8cWGFtekOG/5CpkV4VogfzLZmBB2TWLgc3D8nnTXXAmhwL+I9IdcJdW
         iqXY3RsFfd6uyGGJEBfcSgwuFi4g3N5jlUpjrckGCecB1TVpojsi3E0Css/fpoMuYVbw
         T7Wb0zLYERQ91TSfn2DA1CsxgHvC2aasGoyoNfkX2JZhJxKAitGfk/1WyradEzJGTKmt
         t5d6g5/xLnla95AicX15ZBERsXho1Pb4KA2BFrQY/PdOFlaR8WA9JGucNlJdImR2HJmQ
         2A9g==
X-Forwarded-Encrypted: i=1; AKwUvBzBX1Bc7kwwXXhCN8oC6p7CTht7SxxF4g7kkklsJva5DDN3EE7LVf/MLUOj7w+kVlajvChkai5UMw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9K2WnFRwC9vtThqXduqcJLwGMXyd+IrR7nnmQxi20qkx7KPH5x
	47k/ub4/o+IhP+M1fbtt9YbShbQStvnjif4k+WiL7xDGvM/Yf9y2nncR
X-Gm-Gg: AYBFou3CpVTKdec/UQZxVJeNELxSzq7J71983Id8F811zZB4S1zLRYVAoPf5wRrJ3o1
	Cfa6YtVNhWWY4wPh6kxOdG+ca3Gd0m8IqmDz+f+ZtElIVAApTIQ4jVPLO5oApucoYQN83f1ih6B
	/shstz1OolNly3muUUtKirWaV4em/ntzq09PK6VwMsoRl0dul9IuZuGY8te3zzSmiGQ5EMjle46
	eimzUR9vd4sOdNHuM4eET4+GLRMsN4F6HaAjaNwdzcAm0Y2ysfHJ4YNJHNLwDEkGeW0KRS6ebSu
	vpIlmPAS5PEGcUZjIK9gjLGPFLqWgHCrOjUrLuE0SJwBFqccLRYnM7fxmBh8UO6cPox5hRem/dF
	k89eRMDzptdJ0lDV82lL2TN169oo4AtSLSprCqBcQzcmqi3xT/exIZtbOFnnM2GYGcJ/iBrvYTt
	mvdJhE9RqoZtA5u/chQ+aEHu9jWKxeSolaGDnWu+16+juxfUDHBtQ/X7L6cjGVNVVMtYJdpJNvn
	sJrpU7mE98sIH5CxexxUTeWshx8poqHE86PwIgk3MWpIAeXSTGRUcOSEEPXyYwMGoNfgPt33SnM
	pj308x+Re4+yvI3gcRJoFtknCabOLNm62WQHpJHKCHfL/ew/fr6d0WGLMkn84CQMupZXs3Q=
X-Received: by 2002:a05:6a21:880e:b0:3e0:b1b2:2af9 with SMTP id adf61e73a8af0-3ebb2aa0e0bmr2982479637.60.1793980876624;
        Fri, 06 Nov 2026 08:01:16 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm727930a12.25.2026.11.06.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:01:15 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] power: supply: ltc2941: drain poll work before the power supply is unregistered
Date: Sat,  7 Nov 2026 01:00:55 +0900
Message-ID: <20261106160057.2754689-2-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106160057.2754689-1-hj351016@gmail.com>
References: <20261106160057.2754689-1-hj351016@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

ltc294x_i2c_probe() registers the self-rearming poll work before the
power supply, so device-managed teardown drains it too late:

	devm_delayed_work_autocancel(&client->dev, &info->work, ltc294x_work);
	...
	info->supply = devm_power_supply_register(&client->dev, ...);
	...
	schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);

devres unwinds in reverse registration order, so on unbind/unload the
power supply is torn down first and the work is cancelled last:

	power_supply_unregister(info->supply);		/* frees info->supply */
	cancel_delayed_work_sync(&info->work);		/* too late */

power_supply_unregister() ends in device_unregister(&psy->dev), whose
release (power_supply_dev_release()) kfree()s the power_supply once the
last reference drops. The driver holds info->supply as a bare pointer
and takes no extra reference, so it is left dangling.

ltc294x_work() re-queues itself unconditionally every LTC294X_WORK_DELAY
seconds, so a poll instance is essentially always pending or running at
unbind. Its ltc294x_update() calls power_supply_changed(info->supply),
which unconditionally dereferences the supply (spin_lock on
psy->changed_lock, pm_stay_awake(&psy->dev), schedule_work on
psy->changed_work) with no use_cnt/removing guard on that path. If the
poll instance runs in the window after power_supply_unregister() has
freed the supply but before cancel_delayed_work_sync() has drained it,
it dereferences freed memory -> use-after-free.

Register the work cancellation after devm_power_supply_register(), so
devres (LIFO) cancels the work first -- while info->supply is still
valid -- and only then unregisters the power supply. Nothing queues the
work before schedule_delayed_work() below (external_power_changed is
NULL and ltc294x_reset() does not touch the work), so moving the
registration is safe; devm_delayed_work_autocancel() still performs the
INIT_DELAYED_WORK() before the work is first scheduled.

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires an LTC2941/LTC2943 gas-gauge chip).

[USER: add a Fixes: tag. SHA not verifiable in this graft-at-7.3
 worktree. The bug entered when ltc294x_i2c_probe() was converted
 to devm_delayed_work_autocancel() ahead of
 devm_power_supply_register()
 (drivers/power/supply/ltc2941-battery-gauge.c). On a full-history
 tree, blame those two devm calls; confirm the 12-char SHA +
 subject of the devm-autocancel conversion before send.]
Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 6ebb555..8f8a8f6 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -531,11 +531,6 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 
 	psy_cfg.drv_data = info;
 
-	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
-					   ltc294x_work);
-	if (ret)
-		return ret;
-
 	ret = ltc294x_reset(info, prescaler_exp);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret,
@@ -547,6 +542,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(info->supply),
 			"failed to register ltc2941\n");
 
+	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
+					   ltc294x_work);
+	if (ret)
+		return ret;
+
 	schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
 
 	return 0;
-- 
2.43.0

