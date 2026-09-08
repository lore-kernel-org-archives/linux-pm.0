Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C935DA78
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2026 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848097; cv=none; b=SZrmqcyUVK07hBE3+bllDIbYdsOpTqF0jn906bA01IHItJ3uv8Dit+911wMaSkM3QA9rI6SaisHPKLXrY3w7+353LUCfZ1WqAlFZ9fzPVSA2KSOrI2hhnBs+yOR7ZHAoGZ8fv2gJ6uFikE1mqj1Sal79H35Xoq5YZgSxqHsqb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848097; c=relaxed/simple;
	bh=7v//YBccA+Wta/WJmdeX/TznEKFSuxoImEEytIwQxeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PVyKXJXmj0WVgY4DiCvc0Siew7wtepT3aw2KxQdAT6/TMTeELFpr+Fqwlt++ugQlUINW5LLV7u/Xw4O5aczRn2SS5BStbapYEYc7oRb220dybKRvOcgmsfj6z8md7zbwjCAv2SJyV8MqN1VXD0lI+ILtMz3DXSfkeLnNclO1pig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH65YUce; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH65YUce"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-7edccf768b0so1181106a34.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788848095; x=1789452895; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TuA/xmu86f2+uzRrjt1sV1QoY+5IdkmNTkwkB6MMzEY=;
        b=iH65YUcef1DKqbf/QEK1m1KOlygSHejiTqO/AgNIb/3M/bkbANS5lPqo4ewCw7PDCI
         OY+4h0o/ZQ2sCwwQBDe6/qDqElH9iSHk/enhulQwcDcX4gw4+HEphmI1L/Z5hkQ5ePCR
         k+X9qw9yFXQ37AkCHx6ld1+MtrgnxejGLyslhMpVd3eOSMmqU0nBV5xRkWzYOujKVEvx
         rWkirAvQJBUdYmwKumexAOY2R30hb3xh9LKuQCPEvEhG7xzgkim7yl/WEJnQZ3rMhAEs
         cY6u2UMAkR1ijkV98B1yMvLwxapf9ip/xj6MrdAaPz5Dym5uzOXUVv2GrrTalwP61a3B
         f9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848095; x=1789452895;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TuA/xmu86f2+uzRrjt1sV1QoY+5IdkmNTkwkB6MMzEY=;
        b=RzVFiOPlNF5uEdY/LpO+oAUMttxg5bg1y6XVVWIzqAVmOHROyKyFS2iD96c11PLgNP
         xBkQFIIawPw+zZsCjKz/QnCPGif1Srh8X4tJj7afk/R0YQIaLIyRt5lJfd5hz1JfsnTP
         Hx2h651cLWsxokRFU1IRGH3Z6nl0hSGby9BgorhKCprRjhqbqo9RslJvw+90uneNxW+4
         6CQMJ0ffUgPoy+odbILX/UgCKaD9KP89ZKChlWozEEJtiERrOMbl1sBozrnmhNSX3R4H
         TleA2zW+uhAzL457x+SUHlt8dU45DXq4L92IA88WTeCtPgBoOT5714BIUZLrnsY+F1l5
         gTbg==
X-Forwarded-Encrypted: i=1; AKwUvBzrz/4iv+qXBGSm9DzmJqCLpgXVn8GKINEYNP+pFnWshY6zn2J1CZtCs30DldWG84TDrffMyWAKvw==@vger.kernel.org
X-Gm-Message-State: AFuF++lV+vU6uEHWFsMYYMzGQX4aJsB2+6GKMW6HBaecOaI7cuis5Uk/
	zt4Ny8yua9Odpl75sQZ6whmFf9nXhTlSE4rWg5gZa5WLxEtKfkabv+N0
X-Gm-Gg: AYBFou01UgL5VyToBuVd3hDH7CQIFo/qecXS+AjsTTudS5DRM/aj0fb/qM8fVKuN4Tr
	EjzMYn1L0Xc3AzT1nvVlMwVs2eonu98rvVh14U00WK+HHIZDf/Y5DBGuPMZ6RuGW5WySxHoREGB
	60bqlkbT05a2Yv7HameUSFcFYFaqk39gWYkK7ST/NdaWH5SwrKv+3S/5sSqjCKvK146v4PYu8ad
	mo0Rc/6szme7EC6HxbQ+0EGIKbXewz5SR6byNUwfA9dXQmFNL0EBfUrZp3BB3PNKUQXb3jMunSo
	mvazN+7pWVcoBsY8LkUI4uycgRf8hIhEOoDqGBRf/S7jiRdR76Gy8z0nqLEkSXylbU0JRtzbJkW
	UT2RlzKKLF2bHXp8DPyNS7T9pzjHkkrtR317ZKPisbZKRgXbLf0zwmPDG2xw49MAqo2D7oxdG6o
	CHYQhsunnow2KImQA9J8sBvU0MHwFJ5fX9s1hBrSVkYhut1lq8yMwDbluM
X-Received: by 2002:a05:6820:1890:b0:6b1:b31f:132e with SMTP id 006d021491bc7-6b6fabd2e99mr16401107eaf.6.1788848094953;
        Mon, 07 Sep 2026 23:14:54 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fde1b9a9c5sm5038843a34.17.2026.09.07.23.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:14:53 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 08 Sep 2026 01:14:46 -0500
Subject: [PATCH] power: supply: bq24190_charger: don't reset registers
 across system suspend
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rbrue-suez-upstreaming-bq24190_charger-no-reset-regs-sys-suspend-v1-1-b7f7c784959c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWOwQrCMBBEf6Xs2YW0lNb6KyKSNtMYwbTuNqKW/
 rtRDzPwDsOblRQSoHQoVhI8goYpZih3BQ0XGz04uMxUmaoxndmz9JLAmvDmNOsisLcQPff3qi4
 7c84j8RCOEwsUS26vrK+cpDOiY+va2rbD6JrRUNbMgjE8fxeOpz9r6q8Ylq+Xtu0DNQu646QAA
 AA=
X-Change-ID: 20260908-rbrue-suez-upstreaming-bq24190_charger-no-reset-regs-sys-suspend-ad74a7cfd6f0
To: Sebastian Reichel <sre@kernel.org>, 
 "Mark A. Greer" <mgreer@animalcreek.com>, 
 Anton Vorontsov <anton@enomsg.org>
Cc: Hans de Goede <hansg@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848093; l=8369;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=7v//YBccA+Wta/WJmdeX/TznEKFSuxoImEEytIwQxeg=;
 b=0BK1BbsepJFy53AzEMU6iHDU88RdgpU2hcN9U8wLb2JXc9+xpxNXwgb0SV/0iTig/bY/dJtti
 BEgqNm+uMDfDqqBnhtU6C309scMI1boFqqADaox5ESJ61ONUZFPSJhB
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

bq24190_pm_suspend() calls bq24190_register_reset(), which returns every
register to its power-on default, and bq24190_pm_resume() does it again
before re-applying the probe-time configuration. On any board that wires
the charger's interrupt this makes system suspend unusable.

The reset re-arms the chip's 40 s i2c watchdog. bq24190_set_config() turns
that watchdog off at probe, deliberately: as the comment there explains,
the same write also takes the part out of default mode into host mode.
Nothing pets it while the system is asleep, so it expires, resets the
registers again and pulses INT. The charger interrupt is a system wake
source -- armed unconditionally in probe since commit f385e6e2a153 ("power:
bq24190_charger: Use PM runtime autosuspend"), and still enabled by default
after the conversion to the wake irq API [1] -- so the pulse wakes the
machine.

Measured on an MT8173 board (Amazon Fire HD 10 2017, BQ24297) by swapping
only this driver between builds with and without this change, asking for
a 150 s suspend each time:

  on charger, with the reset:     41-43 s, 7 runs of 7
  on charger, without the reset:  150 s,   3 runs of 3
  on battery, with the reset:     40-41 s, 3 runs of 3
  on battery, without the reset:  150 s,   3 runs of 3

It is not a charging-only problem. The watchdog runs from VBUS or from
the battery, so an unplugged tablet loses suspend in the same way.

ftrace names the wake source. Across the resume, the first device
interrupt after the machine comes back is the charger:

  1270.760799: suspend_resume: machine_suspend[3] end
  1270.775683: irq_handler_entry: irq=25 name=bq24190-charger
  1270.776156: irq_handler_entry: irq=250 name=11010000.i2c

Everything between is IPI and arch_timer from bringing the secondary CPUs
back up, and no RTC interrupt appears anywhere in the trace -- the 150 s
wake alarm never fired. The cause leaves nothing behind for userspace to
find, because WATCHDOG_FAULT is in the latch-on-read fault register and
the driver's own interrupt handler has already consumed it.

The reset also discards host configuration that nothing restores. Resume
calls bq24190_set_config(), which writes only the watchdog, SYS_MIN,
IPRECHG, ITERM, ICHG and VREG, so:

 - IINLIM returns to its power-on default. Boards without a charger-type
   detector set the input limit from userspace; measured here, one ordinary
   suspend/resume silently took input_current_limit from 1500 mA to 500 mA,
   and to 100 mA when running from the battery, where the default differs.

 - EN_HIZ is cleared, so a charger the host put into high-impedance mode
   starts drawing from VBUS again the moment the system sleeps.

There is no way to have both. Default mode is what the reset is for, and on
this part default mode and a disarmed watchdog are mutually exclusive: a
write to any register moves the chip into host mode, and it only returns to
default mode when the watchdog times out. Parking it in default mode for
the sleep therefore always leaves a timer armed that will fire, and on any
board that wires INT that firing is a wake. A per-board opt-out would not
be choosing between two workable configurations, only between a working
suspend and a broken one.

Resetting in suspend buys nothing worth this. The part is in host mode with
its watchdog off; it charges on its own, switching from constant current to
constant voltage and terminating when the battery is full, and nothing in
it can expire or change while the host sleeps. Resetting on resume is
weaker
still: the host is awake and about to reconfigure the chip, so the reset
only guarantees the loss.

The one thing the reset does guard against is a host that never comes back:
a chip in host mode keeps whatever it was last told, where default mode
would revert to the power-on values. But that is the state the driver
leaves it in for all of normal runtime operation already, so sleep is not
special, and the part still makes its own constant-current to
constant-voltage transition and terminates when the battery is full.

So drop it in both directions. The suspend callback has nothing left to do
and goes away. Resume re-applies the probe-time configuration, which is
idempotent and also recovers a part that did somehow fall back to default
mode, since bq24190_set_config() starts by turning the watchdog off.

This has been proposed before. Hans de Goede sent the same change in 2017
[2] and Sebastian Reichel agreed with the reasoning [3], but v6 kept the
reset on by default and added the "disable-reset" device property instead
[4]. That property cannot answer this: it is set only from x86 platform
code -- i2c-cht-wc and x86-android-tablets -- and is not in bq24190.yaml,
so no DT board can reach it. Every in-tree DT user of this driver
(tegra124-xiaomi-mocha, qcom-msm8974-lge-nexus5-hammerhead,
qcom-msm8974pro-oneplus-bacon, rk3188-bqedison2qc) wires the charger
interrupt and so has the same wake armed, with no way to opt out. If some
board does want the reset, it would be better expressed the other way
round.

The vendor kernel for this board does not reset across suspend either: its
driver, drivers/power/mt81xx/bq24297.c, only masks the charger interrupt on
suspend and unmasks it on resume.

Reproduced on a BQ24297. The reasoning applies to the family, but the other
parts were not available to test.

[1] https://lore.kernel.org/all/20260908-rbrue-suez-upstreaming-bq24190_charger-use-wake-irq-api-v1-1-c3f10ae2a34a@gmail.com/
[2] https://lore.kernel.org/all/20170322145536.30570-5-hdegoede@redhat.com/
[3] https://lore.kernel.org/all/20170323112052.ukyazi4pnji7n6st@earth/
[4] https://lore.kernel.org/all/20170414165233.4532-1-hdegoede@redhat.com/

Fixes: d7bf353fd0aa ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/power/supply/bq24190_charger.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 4bea6fd83c36..fef277bb18d3 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -2242,25 +2242,6 @@ static __maybe_unused int bq24190_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static __maybe_unused int bq24190_pm_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
-	int error;
-
-	error = pm_runtime_resume_and_get(bdi->dev);
-	if (error < 0)
-		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-
-	bq24190_register_reset(bdi);
-
-	if (error >= 0) {
-		pm_runtime_put_autosuspend(bdi->dev);
-	}
-
-	return 0;
-}
-
 static __maybe_unused int bq24190_pm_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -2274,7 +2255,14 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
 
-	bq24190_register_reset(bdi);
+	/*
+	 * The chip kept its configuration through the sleep: it is in host
+	 * mode with the i2c watchdog off, so nothing expired and nothing was
+	 * reset. Do not reset it here either -- a userspace setting such as
+	 * EN_HIZ or IINLIM would otherwise be silently lost on every resume.
+	 * Re-applying the probe-time configuration is idempotent and cheap,
+	 * and covers a part that did somehow fall back to default mode.
+	 */
 	bq24190_set_config(bdi);
 	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 
@@ -2293,7 +2281,7 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 static const struct dev_pm_ops bq24190_pm_ops = {
 	SET_RUNTIME_PM_OPS(bq24190_runtime_suspend, bq24190_runtime_resume,
 			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(bq24190_pm_suspend, bq24190_pm_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, bq24190_pm_resume)
 };
 
 static const struct i2c_device_id bq24190_i2c_ids[] = {

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260908-rbrue-suez-upstreaming-bq24190_charger-no-reset-regs-sys-suspend-ad74a7cfd6f0

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

