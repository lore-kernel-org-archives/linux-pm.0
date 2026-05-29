Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522633BE621
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049926; cv=none; b=hRF/DadS637mof2/uGpHqp2QOTqgxi+g/aHCAsig1+TlLZLbGfj1I0GZCQUmAXLqWOOmRcRbe6C6LgDsDWSt2NBFo4buYfNY85vmOLTuPGGa1EYHmiTRoMr0DLHpsNmrnX4fhuUqRhvsMil3xOAZ1zyLVkqruDwYTr9nDk7Hcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049926; c=relaxed/simple;
	bh=zviK7dUflFAaqxqaW6Ow9ed+50ob1vfFG4YB7CN3Phw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBoPdyx88jkfVZ2DJ1feeLMOEQZebMzm27gKtLytmfltIG1jpZT2027KYsGKg2EMirErtDZZuSWtqoJqCXTDTpaecldz3GZa2Mi/qldUdYtklWQBwK2UIhvyFMqDHzq2DkwbXl+ucGOWGy240Qf5Wtr1F92imp08bB1GRv9EjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QUIaHm84; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QUIaHm84"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so97593805e9.0
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780049923; x=1780654723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY9hQa0QdThun7r+BEm3YkBz0hQU6Eaf0ALusqx9WLI=;
        b=QUIaHm84F0/b6CN3GrsbGWb7S7/Rzyt5MHJqryl8yiH8suLv/usDgqzKojJjEjy6ua
         gEMd3TtGyQiC4Zfuo+WwhdHSDZoozz0wzESCOkdw+26T4XIeOFy2Kw9hrhXjbtzG8ssN
         eVyE5hn2iMhbFBldLFiVKXFfJAveV6XKWCAHjH0hhzFxWoP8qgxlSLS54qZZRnltAUMc
         TjlGnkZzgttE3I8lEnMR9esu3fGXRoZcpy5eCxnLWqF8u2/UhNYsP557gAldftv0KFhy
         69sjQqCXmQY6Ns10WSTGx0EFzZf0yM9EJTta8t+i9Bm/F6XceVvhnhF3Fgavol3GgL/c
         X9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049923; x=1780654723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SY9hQa0QdThun7r+BEm3YkBz0hQU6Eaf0ALusqx9WLI=;
        b=tTkRvzJa4LvYEpL5nK9nsP/mRbTO+yjFrZT7yGOl/aXVwyHbmXoRR5ukg8dmOAcf+h
         ZFMgP+5di8EqrRyyaufGKltqeTjBy+30MuDWXEz7IOP6axuQ7bahoVdxEFOwjSYDODe8
         t72j54PAfndJhlvqZPVAFwsEYJr7nO5rKGIlgIHeP6zxZnBCfpkocG5sZFZcH8T6yQv9
         Qpd+Bt/gCF0bOQeF/wi7Bql8G5u7BpEdnyYmYKI2I2m7RBDNNHFcLn7+x2yqRAp5AvYu
         vYFJVMNy1695Ba/8b3Gh5u0xg0KbgTN0S9SAw5DjcJgSmR8xj0MgKj0S9M7UhJVAHjVR
         2+dQ==
X-Forwarded-Encrypted: i=1; AFNElJ/p9P1V3rbxmyeXNdmoXw3xMcRTo+5YGxw717lzl+M84xAa+U+AhTckjga1cQJUqHdqWhSzBuo4Og==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0fLg/rOKCvZoWfqW6aV41xjoa0S9mWr9GvEuz6P1WpZNEBq/
	WJfLCaI3+FAqf/fs9zKpgnL2fKcJ0BCzOHiUL5uttjoCVn+upjCsYtBnH3kAdXom5v0=
X-Gm-Gg: Acq92OHQ9xf9Lx1CIMf5QFHy3MyecqgdiP5be9Gl7CjMudF3F4Rv0ixWejNIayrgWIU
	utJ4CXLagmm0al0cBw+idJog8A+MWG+PHNxNcbGvNFGo1REg3/ZQBPrWlg1K0K6z0XErJzL8cVm
	6unAPvMBAIjFbNzCTH8VrjlWW3xKfgb89TuuXkgnVO67/lORntd7adN+4KafzzhSgwogd67es3v
	Sg2cW9Q+yJ09YfjReBoyeUgpeq3AZUv5UYP3jLBfqj+Yupihi70VxEurIMjd1C5ESWkzGo+6tAj
	rv6c21fr5GedF/6ibwFkAvsnNLAL+aaAXbY7jju5voaXDFjLtejR4uqt/CoFLqEyIA4pUe9Y7yC
	2nS/C4gamSg36T0yoD285ucVkJD425ShtLWW2aSnlE4fIKeI6OX7NpQ4wqdBtiqJHIH9A6bKnBj
	pHLkJ23RH8cxmV1QsQmRbnSjuaM6oOisYu4KghDK/wGWB79GA74jotuDl3tbEzQXAOlQ0d6oTGN
	FYB0W1cPfD8dmziMorSO1jnLA==
X-Received: by 2002:a05:600c:8582:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-4909c0bb2e7mr32632275e9.27.1780049922821;
        Fri, 29 May 2026 03:18:42 -0700 (PDT)
Received: from localhost (p200300f65f47db043f932d8b97293bf6.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3f93:2d8b:9729:3bf6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909c130ef9sm11926505e9.35.2026.05.29.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:18:42 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] power: supply: max17042: Drop driver data in of and platform device id arrays
Date: Fri, 29 May 2026 12:18:18 +0200
Message-ID:  <c4703f00d5a4d1debe51f1ce82afa11d2fdf04e0.1780048925.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zviK7dUflFAaqxqaW6Ow9ed+50ob1vfFG4YB7CN3Phw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGWfvaSx7MZS/OgeCURzCAKaLJ2woBtyFkSi60 SvwoFGEWPSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahln7wAKCRCPgPtYfRL+ TvJwB/9/7xLn3R0HLchYlbhbMdVMZyiPtONy6hhXXy1JlRnbJLKlf542zA983TUbbWsbSq9G4ql VmGvCyg8dWXDemFCKafnEG/tMd/P0dXMW6ZEkl0IVhZXeyKXtKhp2fwrWJ1P5S7vPxV54sMc57J 6bBRbqCxHBebo6a26ux4c6vf06fhfHLJSYWU/zNqNpldrn1UUuoGIGIU9KLyS/K/qCHAlMmmF3Y tn6pTiOW2CO/CfE8RILJItGxgBW6Gwk41DrfGOTzJg/HaxxHS9pFLj5qxHTwOO2xIqf64tBblST oQohf7KUCPnZk4gnE+JSI67kcfiV9GsazUP/T2BLJ2lAEJUr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These values are not used, the relevant distinction happens in the mfd
parent driver. So they can be dropped.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/power/supply/max17042_battery.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 167fb3fb3732..3c50f5ba0591 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1298,7 +1298,7 @@ static SIMPLE_DEV_PM_OPS(max17042_pm_ops, max17042_suspend,
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id max17042_acpi_match[] = {
-	{ "MAX17047", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ "MAX17047" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, max17042_acpi_match);
@@ -1346,12 +1346,12 @@ static const struct i2c_device_id max17042_id[] = {
 MODULE_DEVICE_TABLE(i2c, max17042_id);
 
 static const struct platform_device_id max17042_platform_id[] = {
-	{ "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
-	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
-	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
-	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
-	{ "max77705-battery", MAXIM_DEVICE_TYPE_MAX17047 },
-	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ .name = "max17042" },
+	{ .name = "max17047" },
+	{ .name = "max17050" },
+	{ .name = "max17055" },
+	{ .name = "max77705-battery" },
+	{ .name = "max77849-battery" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, max17042_platform_id);
-- 
2.47.3

