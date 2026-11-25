Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615883;
	b=cTNiGv+7q3UFmjJfoBCEG8v/oau+7cq4om1gSOKQAfSIHYo8XJxkr7WtthRWYzc62u0f
	 QNkpN9SAANzTPG85pX8zDxTzX9QeUoH7+65/u0uPzo/VY59luxoxnI4kR5U/Nu1pit80u
	 Y+9pAw0KupLtPtKGAAONUhBpHeuXBXvqaMzJKZQWB1D1BRHXYo2an+LiC0hbHljv3k68X
	 JCkiLDFnO8niQyEBNiKgVGqY/LG1FbjXr4HuBB3w823Wx2JMVe0u0JExmxO6BTQjatRrW
	 Je5LnmNmAuR8R19ttmoTibhg24gfKQ6LL6E/x+gBbS3a/lKMx9Oh+tyUmHbvn9mtG/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=9q9ZV6hxre1DSle+3LQ4ROJ9Q5MDUzG9R9oacCyb1qQ=;
	b=raKLteIlQ/T12niIKJGFY9J3y8k3rq0PTvwfhjziuF2PR10Ry+/E4vlyIGXsEMXAzjzL
	 HoNUR/+8ZDtabpUer1C05cHCCDLj6bfw17nxHTAvCUqPPCuYeOxNqURYYjUqzrSm63KwC
	 H+Gjp6tiybjVihckySMCDgf/OTM8ZlL2IFr80dY8Cz1KZuq3e4ijwg1Ij+pT7whUiH6uq
	 zOSr90heO7aeY+lyFgnmbpVv6NOOaJEFkNA6rY2BvJb2VtMNSwWvley5W1Q7qnDB1+W29
	 b9FIy1os/nWbUfT9l080U39w+26earUF9YMuWlrGAgUkB6wM6JiPrRzP+AgKq35kgwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiERTDgJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F8606A693;
	Wed, 25 Nov 2026 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiERTDgJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E281F000CF;
	Wed, 25 Nov 2026 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615882;
	bh=9q9ZV6hxre1DSle+3LQ4ROJ9Q5MDUzG9R9oacCyb1qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RiERTDgJUwhHTuQSFe6kepNiyIYdbacSmNobVRXK/dnqioM2DFtZArGN0DWnc5W2g
	 lp3CrjCcMYa48trN9CGdJQP5YARyP8lI22trf/dGWlzexDfoXjKrQ2dCwgzrPTR4N6
	 WPmBNZW/Kh/qoN7HIzx1CGcRVBhtlIo3Hv6QwxTvJsA6hd1oufHxofMabP2Mm9zx7o
	 qthpvGbMyjIGOrEOBl8/p3MpPG8RoQf9sKlfFl2FOQjYQWu23Meee7l3m93Y8LCTMk
	 QdRQkZGkZ43znzQ2NHyxjUSwYO2tWYKKlw6Jqn9oxts46L0CcxMrj+dOM2+59XiVBa
	 bKih4qwd3fClA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/5] ACPI: fan: Adjust driver removal code ordering
Date: Wed, 25 Nov 2026 15:08:48 +0100
Message-ID: <3445012.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <2859850.mvXUDI8C0e@rafael.j.wysocki>
References: <2859850.mvXUDI8C0e@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Change the ordering of acpi_fan_remove() code so that it reflects the
ordering of the rollback path in acpi_fan_probe() where the sysfs
attributes are removed when the thermal class cooling device is not
there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---

v1 -> v2:
   * Add R-by from Armin (thanks!)

---
 drivers/acpi/fan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index d4f1d9a1d62d..d000bf0ef58c 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -560,10 +560,10 @@ static void acpi_fan_remove(struct platform_device *pdev)
 {
 	struct acpi_fan *fan = platform_get_drvdata(pdev);
 
+	thermal_cooling_device_unregister(fan->cdev);
+
 	if (fan->has_fst)
 		acpi_fan_delete_attributes(fan);
-
-	thermal_cooling_device_unregister(fan->cdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.51.0




