Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269991;
	b=eKrKOgRlt2AxP9E4BAkjAppJYBxoEUpYcySPmm4Nt3X+ub6thZuARucPrG75Mz4X9o/X
	 8LDspuZ8ctFlakroNqzfD6eLHgZSuokcfuJ2ftsXl6dpuV9buuv782l8qm4fbICBynKfr
	 o5VhDURBT1M1uhXA2pvkwtXDRybtwDcNXEnsZfSy+L1WRX2oP/vpC1DX67GJcmNAo4tRf
	 Tlx3ivtcageRfMSxGdKJcFFLDkoWAOfDaSnQyrvPrGRKQ7JM1Ln/Tc/7PJSESl4P4YPOf
	 5ae2P2GYHNNaBzuemo47NEuzrtuSahQ0PBw9mWWhZqJFNCsMIEFjyJjKl3c0pnnmgTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269991;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=S9BGB4PMADB0aBjp0wYCxbN962ZBvNoG56LesM6ShLU=;
	b=Q6kEvLGc1gjO5vFURqIX9kJ40HJaMQu2wfxaGAU80G1tlAeXdQ7DS9vknIkWYyVwRCO0
	 mqvSwFkWKo59FB80LqHPpSGIxLs5+qMlFB95RLZLNZehbZZUohbbi1PC/G9iTB/HOH6wn
	 9J9q/4YXl3PyJls5YnLWkWQwThhgxiLI18dYWmmfDNmU5uMwRI2fvq+FHCLnPYRHyHH0V
	 jDE4ewwOkzDK+5Yi+dUlQmwr2u0qGi6q3KRAITexYxM7YK3E+a28qiGQsPXfj2WhG4bwV
	 Ku+BLNNxuKhWpnGl8YimJ2YBYSwHjfvCr5+qd48ceS39wnxwMIJLnU5XSjW7L8NqBgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Gbbu0PR+;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70060A260C;
	Tue, 10 Nov 2026 00:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF70060A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Gbbu0PR+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794269981; x=1794874781; i=w_armin@gmx.de;
	bh=S9BGB4PMADB0aBjp0wYCxbN962ZBvNoG56LesM6ShLU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gbbu0PR+fFzeuLHl4xSJZtkGChcS2dSaJKA+EwOUsNH0mEkvZn1f9ttd3zjPrD5b
	 AE2hbf/E9eZRr0iRGMtYCsqVGHW0Q8vaAle0l7qpdZZI4HYbuXqFwEQp0xLHcXtTR
	 U041ge3Khep7N1uE8SrfWrqR79GmMDuXcLLoq8TVmhHli8/6UqeZzNXHGE4jXMyTq
	 UL+IXIC9ruhq6xaSlQ43Iz+3f89h/JP7uSl7vfcxnxAVrM11k3geWpJQFetoGbV9D
	 oW8gVzBNZJg+HtvK2NXl/FhDqmu6EIb4DeSCZe0nAz9dZ8/5fvS3F5irNsvS/ZhVu
	 2Kun2zD0QEe8v9d4UA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1wXOSc2BFT-010je8; Tue, 10
 Nov 2026 01:19:41 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bifangknt@qq.com,
	nicokessler@icloud.com,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	wse@tuxedocomputers.com
Subject: [PATCH 1/9] power: supply: core: Add power_supply_has_property_direct()
Date: Tue, 10 Nov 2026 01:06:43 +0100
Message-ID: <20261110001725.851443-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110001725.851443-1-W_Armin@gmx.de>
References: <20261110001725.851443-1-W_Armin@gmx.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mi1MZAeUJUwLxUYyJlAHQWk2OGcqWwOXW3aIOLpaHrahLMAsimn
 hkIvv+++Ad/CI5/2E/N5oyO0qoEy+xkfZBV7RSCL2042uKHalQJrve/+YJ5Qpd072RXLiYs
 ZI0xKynVlZYgzMJ2NPpebtbYgIYJNgOYPwHCnp8bi1fHDECPrZqAu42z3VedWprYd100j6y
 dvx4mlMwV9BX2aZsBsxLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y23E17yrsmE=;YpFOQ/7HNlwDOjLKTLNdyzFB4Zo
 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

Providers of power supply extensions might want to check if a given
power supply supports a given property in order to select a suitable
extension to load.

Add power_supply_has_property_direct() to enable such use cases.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/power/supply/power_supply_core.c | 26 ++++++++++++++++++++----
 include/linux/power_supply.h             |  1 +
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supp=
ly/power_supply_core.c
index 1cc203f2780b..75b53aec5db4 100644
=2D-- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1367,17 +1367,35 @@ bool power_supply_ext_has_property(const struct po=
wer_supply_ext *psy_ext,
 	return false;
 }
=20
-bool power_supply_has_property(struct power_supply *psy,
-			       enum power_supply_property psp)
+/**
+ * power_supply_has_property_direct - Check if a power supply property ex=
ists without checking
+ *				      for extensions
+ * @psy: The power supply
+ * @psp: The power supply property to check
+ *
+ * Check if a given power supply support a given power supply property wi=
thout taking into account
+ * any power supply extesions registered on said power supply. This is mo=
stly useful for determining
+ * if a power supply extension should be registered for the power supply =
or not.
+ */
+bool power_supply_has_property_direct(struct power_supply *psy, enum powe=
r_supply_property psp)
 {
-	struct power_supply_ext_registration *reg;
-
 	if (psy_desc_has_property(psy->desc, psp))
 		return true;
=20
 	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
 		return true;
=20
+	return false;
+}
+EXPORT_SYMBOL_GPL(power_supply_has_property_direct);
+
+bool power_supply_has_property(struct power_supply *psy, enum power_suppl=
y_property psp)
+{
+	struct power_supply_ext_registration *reg;
+
+	if (power_supply_has_property_direct(psy, psp))
+		return true;
+
 	power_supply_for_each_extension(reg, psy) {
 		if (power_supply_ext_has_property(reg->ext, psp))
 			return true;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index cce61137aef4..73bcb127d0fc 100644
=2D-- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -934,6 +934,7 @@ extern int power_supply_is_system_supplied(void);
 static inline int power_supply_is_system_supplied(void) { return -ENOSYS;=
 }
 #endif
=20
+bool power_supply_has_property_direct(struct power_supply *psy, enum powe=
r_supply_property psp);
 extern int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val);
=2D-=20
2.56.0

