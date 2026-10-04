Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02476395AE6
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791154578; cv=none; b=h8xVoibG6gPiD4IIrKL89encJy10gPcYZIafX7V/ysGlkHVIyzEe+hPwwpeH+W5g+DVQy92ZDnbkbg/X3lAFljqJWpL/EWmgI16ASjOMNhh60CNtjo/yCwnjdTEa65VQnNCtFJFSVmPuBEFJdLwMXN5Le51pPocF5gVHkA7syFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791154578; c=relaxed/simple;
	bh=eCoocw/muAdBEHjF88L2mfVpD5sQO9Zs2UHQ4OwzCmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liJAMjerf5wPNT+rsE9/uD63Bl1TK6yh6NM7EyWKLfEz7tykTNZKwzXV6fuQUGhciN6PeDF48oYDcdd5pHqc62fmld8YQ8xDnrjQXq+C/C+iefP7LUrJtMfb1SeNH9Bx8Y2qYpWk3jqZ5vT1ZtPj/KMhMMdLUJen6/fZiVEcPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastmailteam.com; spf=pass smtp.mailfrom=fastmailteam.com; dkim=pass (2048-bit key) header.d=fastmailteam.com header.i=@fastmailteam.com header.b=hz4twurD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnIwxMwE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastmailteam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmailteam.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmailteam.com header.i=@fastmailteam.com header.b="hz4twurD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnIwxMwE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D9102EC0635
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 18:56:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 04 Oct 2026 18:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	fastmailteam.com; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1791154573; x=
	1791240973; bh=HY3DFH/2+qAHjGL1keCAY9gW94QHm2k5f81Z3ktBps4=; b=h
	z4twurDSdQzQSfuZuSYA3k4Smgmv2vZdXxtNwhbyUC1tZnSqg47f1JULxmhq1480
	ZKOkqqLjLts24NEi42oGDayih3C2AGD9YzNb2On1863bZuqNJKCiGvyFprOyY+Oe
	xs9b86b56NkvgvIFpsy5p8/V0DJbeBE6Z5IG+pqXqj5XYM1/k3+PVX93fVnjHhbS
	wDI3ZYmvmvq9KIzFwMfkoPcFI1/QuzTsPU1S67/9KT2UqEztTqelr1BIrSWF4v0Q
	gCdnWpWBJXdfy+HoTrQdbQwdtr908F0JK6xTF2cb9P4dS2+B0KweOrqlOJz2aPOA
	9PUemQsIUbgLSoANxzXlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791154573; x=1791240973; bh=HY3DFH/2+qAHjGL1keCAY9gW94QHm2k5f81
	Z3ktBps4=; b=JnIwxMwEDopyTMv9G7XhW8N/HQsjaG+XkcUpzON+af7NOhnvgKn
	rACclQrjrFrmO2R7H6otmBN+DponaI2gzSfHJcYuvE/eyomdbmO6AXAOQ/Eii2zl
	dxWvl2OC/wuX0H5WOcByQFefHKqrrf47qeiDaL/nTvtgFMI7G0E8QkZ9QeVTxO1/
	FIt+SzXmIqjTQH5nYzQ9KxAPjIUSjiS66bNp5ezvFSwjUvg4hk2O8OPSbxQFpe2y
	1txLTFqPz3CgpwBsB7QS+mSW5FAgT8b9DuGwazBFgovZXDYMQmYbXuxgZY5XEdEZ
	BZa9FSRvhsbi8yGDzd2Mj1ZFwHaKI9XHwzw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmailteam.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791154573; d=fastmailteam.com;
	mf=PGFuZHJld0BmYXN0bWFpbHRlYW0uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:nXUsvvNX72+issLkhCdEI6DClN0egMFYNfrZWQj43pKvUtp
	2ykF1tKba04kx2m8BFQBd8lAglhko036XnZxk6wn42flUaKeKC0pcyrgfopUmQkk
	kqytz6yj3s0+8l9lWWZ9VHRU3Je/aBM4pa4oB1p2OCU3+NN7vuhen5/o04X3tQou
	IV7FrAHgdlQsprWN3MEReFPpZINfnm8czK2lmlhDabzOW1EUumLrINmQg1m7cYXw
	SWVgUZomdmZ/wteCDRPEz0rrs+F9Na5lGFQ7cQ1z+06xWRWY7h/2hgPH0Wbf2lZL
	KDGXCUsvG0Z9Ud+samnOhi4xyzKBf853o1BuWlg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:F8MH6fqE5fOl4R42t0Z+xRdc9TtYeI8UBGIlwQw1+rQ=:eCoocw/muAdBEHjF88L2mfVpD5sQO9Zs2UHQ4OwzCmA=;
X-ME-Sender: <xms:jdnCavNaGG27G7mQWNCPUgFHN2LWa7NKdYUvTWXhDqu1dbhVAJshuQ>
    <xme:jdnCaqbBuvigFQ19f8mQiiC0PV4hunNGo_k7B6Iu4jJH4a-V9jm3wN2FsBf4316pb
    gLYUBRl9GV3b-6BAHcJQ09byilloptqN0mc82NmQK18mgczmA>
X-ME-Received: <xmr:jdnCau-TjvPb4-hDv5lxJ2aFeK-ffwhR710PPxJdBP-_KYaw02_ZdiTOLBvS-ViwzcH3cjXfZmkG_F2KeHdTIO6WPsVGy54tTCJAhbT6RH0>
X-ME-Proxy-Cause: dmFkZTFN02SPjk6ep1voePZiXrWsR7ZDTU/dLU3zzgSAEcARE5XGnBYkEaHvq65JqdjFKW
    7TBRAWCtu3iP/QrH9xC+RGCkagTQOPbP0A1brN2qx8QvHrnbE42sjzb/bxRP+iUjZfp+hv
    1MPjgXd/oVA7wOw0+pxE9v8JDoaYT2P0BZ5y/+PC0Yb84x9iPu5jTTlgFkM6+cXMJSB4U4
    MFCyyVjV+tmzrAqPmLqSotNUBkEK2URRkB6q1ANqGAsgUBgN2/ij+zEjnAdrmGrtA2FRDP
    Z5rRRPxLBznqtkw2Fr0SyOVlRmwcBpDVdW4V5EHzOEactG8I7eTj131UKHV4z6py8iG7gC
    HD0qJbumNo+yvn8Y5DhzVQZh4FT+0c2O92oL8nWMKe8q9/uuo513lFJK54QSib054dR9n3
    qZWqukECabiFkehC2VXdKG5S5A+XSufD3w7ewtMZtTccGkXFkBKx8rfa9QBdzE++F8mOja
    VxJjVemfH9zlYAvxDjBcdNld1dxN0BdLxBWleImo80d1Yn0nRHGN4Hjt15WCzmJWe3htfv
    +OjdJsCcU9prt8WxccgYb6YtcdjVht0AoxALCqw/q2mzkwMxzvMVnNIarbkpF1BGFBfUn/
    IKGSF//LNig1BeR4KUpmx9OY/xjKqsmflhsbOxaZRVscPQkP12uNESWgL3Hg
X-ME-Proxy: <xmx:jdnCarSdveaYPF63P0M33uxoCOb3mPvwMDnHlbe8Dae2eKddCMkCSw>
    <xmx:jdnCaocWAog7on9teWxZ_KRrrwyvhAT4avAU2k1aOvWgIsQ87C7N9w>
    <xmx:jdnCatTiCdCJxNoThOdMT8q8XGHqn_GOtG_a9B9VqLiqFEuApzcAPQ>
    <xmx:jdnCakLkjcXbdz65VBaIKeMe_0wOlmeftOocLps7xzTgDUOJQILF4Q>
    <xmx:jdnCanIGHvInYnb6trdnS7cd5AYlokhBz5Qg5vSAhgrWzGHQ0hHPoK_n>
Feedback-ID: ib8be4bd5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 18:56:10 -0400 (EDT)
From: Andrew Pam <andrew@fastmailteam.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Matt DeVillier <matt.devillier@gmail.com>,
	chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Pam <andrew@fastmailteam.com>
Subject: [PATCH] power: supply: cros_charge-control: restore EC state on resume
Date: Mon,  5 Oct 2026 09:56:06 +1100
Message-ID: <20261004225606.30577-1-andrew@fastmailteam.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EC resets its charge control configuration when the AP powers off,
so configured sustainer thresholds and charge behaviour are lost across
hibernation.

Nothing notices the reset. Commit 4fc88ba435da ("power: supply:
cros_charge-control: adopt EC charge state on probe") made the driver
initialise its cached state from the EC, but it does so only on probe,
and a resume is not a probe. Sysfs therefore keeps reporting the
configured values while the EC charges the battery to full. On a
Framework Laptop 16 (Ryzen AI 300, charge control command version 3)
with charge_control_end_threshold set to 80, a hibernate and resume
cycle leaves the attribute still reading 80 while the battery charges
past it to 100%.

Add a system sleep resume hook that reprograms the EC from the cached
state. The same EC behaviour and the same fix already exist for another
driver, see commit 2643187ccb86 ("platform/x86: ayaneo-ec: Add suspend
hook").

Reprogramming the EC is only strictly required after hibernation, but it
is cheap and idempotent, so hook every resume path rather than rely on
the EC preserving its state across each kind of sleep transition.

Note that re-reading the state from the EC on resume, by reusing
cros_chctl_init_state() or otherwise, would be wrong even on the command
versions that support GET: the EC has been reset to its defaults by the
time the hook runs, so adopting that state would silently discard the
configuration the user asked for. The driver's cached state is the only
remaining record of it, which is why it is pushed to the EC rather than
refreshed from it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Andrew Pam <andrew@fastmailteam.com>
---
 drivers/power/supply/cros_charge-control.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 07bcc6a9aeef..77023dcd1851 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -13,6 +13,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/types.h>
 
 #define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
@@ -420,6 +421,7 @@ static int cros_chctl_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 	priv->cros_ec = cros_ec;
+	platform_set_drvdata(pdev, priv);
 
 	if (priv->cmd_version == 1)
 		priv->psy_ext = &cros_chctl_psy_ext_v1;
@@ -439,6 +441,23 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	return devm_battery_hook_register(dev, &priv->battery_hook);
 }
 
+static int cros_chctl_resume(struct device *dev)
+{
+	struct cros_chctl_priv *priv = dev_get_drvdata(dev);
+
+	/*
+	 * The EC resets its charge control state when the AP powers off, so the
+	 * configuration is lost across hibernation. As the driver never reads
+	 * the state back from the EC, the values exposed to userspace would
+	 * still describe the lost configuration. Reprogram the EC from the
+	 * cached state to keep both in sync.
+	 */
+	guard(mutex)(&priv->lock);
+	return cros_chctl_configure_ec(priv);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cros_chctl_pm_ops, NULL, cros_chctl_resume);
+
 static const struct platform_device_id cros_chctl_id[] = {
 	{ .name = "cros-charge-control" },
 	{ }
@@ -447,6 +466,7 @@ MODULE_DEVICE_TABLE(platform, cros_chctl_id);
 
 static struct platform_driver cros_chctl_driver = {
 	.driver.name	= "cros-charge-control",
+	.driver.pm	= pm_sleep_ptr(&cros_chctl_pm_ops),
 	.probe		= cros_chctl_probe,
 	.id_table	= cros_chctl_id,
 };

base-commit: b33596a615d163372f5e7519338d860cbfc37217
-- 
2.53.0

