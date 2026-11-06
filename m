Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980883;
	b=226aZD7OmVHyFldn7wzlwmNrYco/VwLGMWSB9NGZli+ToBGapyLHTbXmTZoBTcWWiNNZ
	 41yNFxqTjYzjZyKb9bKBO2FZ4F1+gWZazFY2kTTQh6ZR7yPMR6hbXWXBUbHdOZd4FqRnB
	 jc7QQ6FdYkG5roHfNx2+5lfXqEpiYB1H/lRDL+SNT7mv6tYS4SRrCCUR+4XloOWUr4M8J
	 l8c9Rd5JWw+aJ2RXxt8J7HPQGO6vEPEVMXEcn2kjvLM182k+7cjPQzgCMmHyXhVHEksI7
	 JEOId6py4SbLolCIEHh6xtBPrCpp7DxkmNsm5o0Y+8jE/1eyA0Fj835PnM/qZLt80qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WqCbehPeg42mkM3NuhRGWk2/Ovgf7IzdbwtVD2E9nX8=;
	b=MA6JxC5sWq11J2Rp+sg30keUZ+KTsTC956iBftLGh0fEDpiA6IvTTcKz9M/W/GLSfMJO
	 1mEscc84VwMy9wlun1SXND2dSLScGMLz0CSoHC3J0mLwGuzaq9LQU2ewx1J+aQigHpu9A
	 DdmoZlSVrS20xLcahsn21taZcs4P3I9lR0C6sfNTTdEUxIuROrlUN9+3S0ruCeh8twI2b
	 I0PhV5AAWPl4lTjgpSPWGntyRXIO6KRIRU6bjtWNqEqn6UcLmZ4RS9xoIOxSV57m5oYD/
	 4FQhGEi+9W8zywRgyiYXKaZSGsCdLsTkFXa1QZmJFqZbTWEVgQON/211bMrey0WTtfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ld0Zb1H9;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEF606A332
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3DEF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ld0Zb1H9
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a070755c8cso346826b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980882; x=1794585682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqCbehPeg42mkM3NuhRGWk2/Ovgf7IzdbwtVD2E9nX8=;
        b=Ld0Zb1H9Hs2Iza5rEis+Nqc9xJbRIVRAbPZ+jljOKT0qkbRWKzvB5KmtyGtgUfhxS1
         T2qn7YhWKw+984g0RZFh0FDZf/0W1b66sN5u8fUkyzFkOe6kwkjEkUd/3PehrdUFx8MN
         Hm+rHc6oqCOkgGN/MNO5xefwGFuZDJlcBWz51fRglmDNFtTPid5qx8aqZqR52DhholCt
         PUddWG4eZ5L3zzxVb1w7Hfc10PWdw0WQsNeS8ykIjmUXLyOTfzhD8wXV8aecNnXebaO9
         Z8UiNUTJUYWnDAiFPatY7GPuZUzugT8KS1v/k/M0rRYDP0EN84ezaoPFyPDvmppbdDxm
         9WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980882; x=1794585682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WqCbehPeg42mkM3NuhRGWk2/Ovgf7IzdbwtVD2E9nX8=;
        b=erlJHTA74DS7ljrfujkXPrDCe6tPOSj9WQZo25PflzLV2+N8nfyVSV0XNB3TzGwhMp
         JC7wlw/bBjZbpAAekinygelNB4j+J+8lfQ9Fo239DTyQbBjNuFQrYOhHISCHKpvckwFr
         xRuIPGqjPh9iVVCLJOr5Ubf/5NUKZ66/6arrKOGszggS5HPKXg7pET15q9ioT/k0HThG
         32BruYrpuwZLaADTd1ECox1qDGJZSBLLi23cWRN+jtGR2nm7zmmGZu0z/p1kmFbr+hHA
         OVPpFiboi1nmFL6o4TG7ZK0Ntlq8YlM1AB8XOvC1Ix20U8FdwPwhAQJf06+7RS3zRH5m
         CWxQ==
X-Forwarded-Encrypted: i=1; AKwUvByhdiJzEC+Mma65NRfQGoQG5I5WvysD2UoEBiQjKmoTO7BBUgyY5lhSmw1JoGRplNT8TUg9cNtcXg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8/LdOMV+ZyblIWLb4+R/VZFnU8v35Kq3eDrR1lqg8H/hhYTiI8
	5Aq5lywaQ6Nf5WH5uFhFbqgpjU/Ho/cFEAnq8bhsnHi+9i5TpmvaxMR2
X-Gm-Gg: AYBFou0Ptruy0TRpuS6+6GZuOsjYs+7PZBD6iicAtctMuWLY8AZ0w2uqOkk9GYimjFt
	Pw/jvV0B5+Y6+YrzsnFl7mAluK+XXDElQiz10l05DV3MWqC4J1imz3qQzbOdoI1Kdz8pBJH9BsB
	3N5aNlphquih5yRJ5CLK2SOGFUiNxCo8Vr4AoRFN+dDl+VGJCmIommWE//RIzpGNiXqnZUnXio1
	IeI/FZYsvWChhEy4c0lXdmwbfFKzHedt0R20p9s3ZSM6nxRRPIna7KV4iZ+GcVTpYs3XZbdzlVw
	gowfVu3jBNmC/S15FU2Ver/E0z53Ab/HtLX8ZOar5i8I4g+B05ViDBWN6K09mmmTq5zAIRw1hhW
	t9zPa5rTs2ky0NWMQsjtNMLtHss/Gi4ekl1OXbqISuwMPoDbeO6bCtAwqziKk9+XBD3D9uONQek
	GJTHVb9VFxgAPEL8Az8VBH3Pn1Ev2zn+f65UobQoCMjdMIwKQWj4sbQ/s+0ww+c+zYws2G+b48H
	V13ZPdB6UAdAi6a7Tbfz1i9LzFQCSl9LzW/+wfrZb3xJMv+o1EuDhI1Eep5mGMM1/EQ0JC9CvCm
	V7Nc3B161/Lua1e7ntXlv5TEy06D1ZDs2mSp7avsaqFCTnBm
X-Received: by 2002:a05:6300:2201:b0:3e1:549e:614f with SMTP id adf61e73a8af0-3ebb299d444mr3364948637.57.1793980882239;
        Fri, 06 Nov 2026 08:01:22 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm727930a12.25.2026.11.06.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:01:20 -0800 (PST)
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
Subject: [PATCH 2/3] power: supply: axp20x_usb_power: drain vbus_detect work before unregistering the supply
Date: Sat,  7 Nov 2026 01:00:56 +0900
Message-ID: <20261106160057.2754689-3-hj351016@gmail.com>
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

axp20x_usb_power_probe() registers the self-rearming vbus_detect poll
work for device-managed cancellation before it registers the power
supply:

	devm_delayed_work_autocancel(dev, &power->vbus_detect,
				     axp_data->axp20x_read_vbus);
	...
	power->supply = devm_power_supply_register(dev, ...);

devres unwinds in reverse registration order, so on unbind/unload the
power supply is torn down first and the work is cancelled last:

	power_supply_unregister(power->supply);		/* frees power->supply */
	cancel_delayed_work_sync(&power->vbus_detect);	/* too late */

power_supply_unregister() ends in device_unregister(&psy->dev), whose
release (power_supply_dev_release()) kfree()s the power_supply once the
last reference drops. The driver holds power->supply as a bare pointer
and takes no extra reference, so it is left dangling.

The vbus_detect handler (axp20x_usb_power_poll_vbus() /
axp717_usb_power_poll_vbus()) calls power_supply_changed(power->supply)
and re-queues itself via axp20x_usb_vbus_needs_polling(), so a poll
instance is essentially always pending or running whenever VBUS polling
is in use. It is also queued from the USB power IRQ. power_supply_changed()
unconditionally dereferences the supply (spin_lock on psy->changed_lock,
pm_stay_awake(&psy->dev), schedule_work on psy->changed_work) with no
use_cnt/removing guard on that path. If a poll instance runs in the
window after power_supply_unregister() has freed the supply but before
cancel_delayed_work_sync() has drained it, it dereferences freed
memory -> use-after-free.

Register the work cancellation after devm_power_supply_register(), so
devres (LIFO) cancels the work first -- while power->supply is still
valid -- and only then unregisters the supply. This mirrors the existing
"request irqs after registering" ordering in the same function: the IRQ
handler and the final queue_delayed_work() are the only things that
queue the work, and both already run after the supply is registered, so
devm_delayed_work_autocancel() still performs INIT_DELAYED_WORK() before
the work can first be scheduled.

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires an AXP20x/AXP717-class PMIC).

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 7625366..5274e1e 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -979,11 +979,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_delayed_work_autocancel(dev, &power->vbus_detect,
-					   axp_data->axp20x_read_vbus);
-	if (ret)
-		return ret;
-
 	if (power->vbus_mon_bit) {
 		/* Enable vbus valid checking */
 		ret = regmap_field_write(power->vbus_mon_bit, 1);
@@ -1018,6 +1013,17 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(power->supply),
 				     "Failed to register power supply\n");
 
+	/*
+	 * Register the vbus_detect poll work for device-managed cancellation
+	 * only after the power supply: devres unwinds LIFO, so the work -- whose
+	 * handler dereferences power->supply via power_supply_changed() -- must
+	 * be cancelled before the supply is unregistered and freed.
+	 */
+	ret = devm_delayed_work_autocancel(dev, &power->vbus_detect,
+					   axp_data->axp20x_read_vbus);
+	if (ret)
+		return ret;
+
 	/* Request irqs after registering, as irqs may trigger immediately */
 	for (i = 0; i < axp_data->num_irq_names; i++) {
 		irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
-- 
2.43.0

