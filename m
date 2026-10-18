Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9635E1B0;
	Sun, 18 Oct 2026 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295880; cv=none; b=E1nEO6Ar/eOwEHce50CsXa8Og5EYoW4Xo1u646ATplhZCl3NNKVYHjZ8JhyFVxxmKciA/7euVYnJUk4IIcezjH4wgfvSL1HuXEBoIETbgbDd4D3t/6lb+cQLfyrc8qX8OiiV95JWUD4wvFsmkC/d0PKzzhmr7BYZyXs1a9Q4RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295880; c=relaxed/simple;
	bh=aPysawF4KEDPHI2m90iC+9ZugE4OYOZ33lJ5R+Li8Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cp0ZMBmODVRl9zk1mFFWGTP87EH/Pgo9F2Zz6K/M67iuT9gqrQScCu0tUH7HLHKs1mSv7OayeAyekjC2x9wav/NIruhpUAd5JJU6HK9FLwuubPgUvV7eXpiV5aP+yDi8x+L+qIlzd5jOxMqZmVkkPbztfPViNdV53BQ2ArkxOUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnKU69RU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnKU69RU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CA21C2BCC7;
	Sun, 18 Oct 2026 03:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792295879;
	bh=aPysawF4KEDPHI2m90iC+9ZugE4OYOZ33lJ5R+Li8Ew=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dnKU69RUMJaGfnTcdOnXpSHLmYCZxnzZYZVmT2p0xJvQKmqtucsmDTeNmvKUs6QZO
	 fOSffKg8ytgjk3lwoVT47qa4LO6WAb9pvWozTUsZq3ueAppX8rMZmUdTLfCUigQj3L
	 bHu7mFSAJSrz/IamePuMK4CqKU4xpMpbmCoMOToHtuIwhhxZuThdhbWR621URURgnX
	 sIq8RjeH2D+x3mQDfFKe/zX52G8eblM3PG7yO3r1UbnoNpwimD70Tww/fJKEnBt8IK
	 VwB0bB4lN11Vu++lTJQDuz9lRcNb7wYXdi6OxQAr+fzG2WC5Dl7diO/7QvjezwZXhq
	 mCULIp2XST6Rg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67590CCF2C9;
	Sun, 18 Oct 2026 03:57:59 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 18 Oct 2026 03:57:53 +0000
Subject: [PATCH v2] power: supply: gpio-charger: Report discharging without
 input power
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-gpio-charger-offline-v2-1-482795f9e27c@iav.lv>
X-B4-Tracking: v=1; b=H4sIAMBD1GoC/4WNQQ7CIBBFr9LM2jFAwBJX3sN0gXWgkzTQgCGah
 ruLvYDL93/++zsUykwFrsMOmSoXTrGDOg0wLy4GQn52BiXURQphMWycsFc5UMbk/cqRcPZGGq2
 cFOShT7dMnt+H9j51Xri8Uv4cL1X+0j/CKlHiaEctHsZYLdSNXT2vFabW2hew+H1ItQAAAA==
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=0JI2YVyIf0wi7lB7au0hHSHWHOT1281rV/OhX2yynHo=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlXnA8eqtu6MN44cF1weuyG0myFRFnhzbMvu3rFTBD83
 1pb/Fupo5SFQYyLQVZMkWXCIY1bGUuu/vX3MH8AM4eVCWQIAxenAExEZjfD/0rGvRtE1j399Dg2
 sH13ki/7TL6de9kXxRdo+hhFiZzVO8DIsPpx84ayxTcj8hr9gg/feRDOt96ntP398Yl8n5PPTGK
 sZQcA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

From: Igor Velkov <iav@iav.lv>

The status property follows only the charge-status GPIO. Without input
power a charger such as the BQ24133 releases its open-drain STAT pin,
and depending on the board the GPIO then reads as charging.

On Kobol Helios64 the board runs from its battery after a mains loss,
and the charger reports online 0 with status "Charging".

Report "Discharging" whenever the online GPIO is present and inactive.

Fixes: df68c44c720a ("power: supply: gpio-charger: Add support for charger status.")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Changes in v2:
- Report "Discharging" instead of "Not charging" without input power (Sebastian)
- Add Fixes tag (Sebastian)
- Link to v1: https://lore.kernel.org/r/20261008-gpio-charger-offline-v1-1-78740b558402@iav.lv
---
 drivers/power/supply/gpio-charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 2504190eba82..1dad49acc424 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -101,7 +101,10 @@ static int gpio_charger_get_property(struct power_supply *psy,
 		val->intval = gpiod_get_value_cansleep(gpio_charger->gpiod);
 		break;
 	case POWER_SUPPLY_PROP_STATUS:
-		if (gpiod_get_value_cansleep(gpio_charger->charge_status))
+		/* Without input power the battery discharges, whatever the status pin says */
+		if (gpio_charger->gpiod && !gpiod_get_value_cansleep(gpio_charger->gpiod))
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (gpiod_get_value_cansleep(gpio_charger->charge_status))
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261008-gpio-charger-offline-cf51542a10ef

Best regards,
-- 
Igor Velkov <iav@iav.lv>


