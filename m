Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960A46DFF6
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191664; cv=none; b=Jox6T0tppOm5AS3JMif2r85t7C+Xkg0XMz9Xv5fa+DbBp7YNLYXg4OnMm3VdzF1Sb7mO6rUIEzcvPhPHGV3zJWJmBRX8drlLxM8MJlHu7Moi0ptjP2UQxKHdypxAdVGskzz/BMeWgzsDxPgSoXogewyuRH0zTkZcW/HRUBzfjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191664; c=relaxed/simple;
	bh=fiA0RXJ+cutJQ46iLKVyryXs5YV53pyfmTaFz17lMu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpL+pnRCdWqQS2J5zk6Ope81qny7swpR4YbmuKrbnVaeJEhcbiACYIBFNJEGNQPjXwWS5bWsQRg3m/BtVEfbRiSrFTj0de2m94vWYn61BEchDPvYW5BSV2WC4nzvevYS3WGE7P/lLg+1Tj+a3jF/nPTRr0UZD8e05P5FMSxMt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdLVwoS7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdLVwoS7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f633e6058so2913291f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191662; x=1788796462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XWjANEXWVZsBsiiF2NEG2eJr+Ug/Njepr9rhQdCzDS4=;
        b=LdLVwoS7irBRHkYFp7vyWw7blDgZRuWvhXEfDsOXrfmn+xoH+RQGcYQH83mlrf5QWI
         Rx3RHJHt4N2TVf/RFz6hl9uktmPBq9dae4ic3FXORT197SDvFmRsemJ6WkGivVz/RuFx
         qEB8UGY7zBoydeEu5WmseHPtpuK/e/Oe0KAlOVtKzzfXSOK/DZQTzXcCH3r17Y8ztsgz
         8nL0nxtWFAUEZJ735QrafZjmGbHDg1AQzYA+K5zveDpyilMtHK57daM0hTkZJoJB/pCm
         87aJM6PzEjdrqwUTVyEY0SxP0LShPxhSPyopL81Tq7y9ccPGmLp6TfwPcJnskeLi48Xh
         +MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191662; x=1788796462;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWjANEXWVZsBsiiF2NEG2eJr+Ug/Njepr9rhQdCzDS4=;
        b=i/oLqy9UFUrdP/uO6sqPk1xmaFKsC9cSyWVFdwDHyryoRncYOj2jzpw/4oqvQdGEPn
         D6Ot1+iJzIbL9pb/x5fve5OR55Lgsz2ttRYQc/27JUMzuiChR+3586KvZg02BSOH9gjV
         cIltb7A0Xe37VF4b6Q7fFXuleykvTgyPY9Jq4SRnjKaUucQ/owmJIc9PwWDtkCQ7DrC6
         Rcrd5ug2MsVN0Uuf0MOJi7YhJ8tJlKgGWlo98PLoFFkOX5u8N4AtCrigs0yOk8CEKtSU
         s86mgdcvlaGED90FzZNzLTTxj79igoibpKio9QoyOMIZU0QT1UgO1ATWZcylRbhM+LRC
         vNeA==
X-Gm-Message-State: AFuF++lFF1/56d8fcoS0MlGhUUy6cco+mSJpP10ntJ+ze853kNAymJ7T
	+ZzA5nH7i/N46XZMGiFw8bUKqSNQH1zM0S0w3BJtfrVNh8maaP7IgaCBwPoPZnUevA8=
X-Gm-Gg: AYBFou1QqA9O5994DK/j5sl/LewZtmhq/pnYXDvmsjpRpBhvIv4svKNxmC3zVI6AuNR
	eW7lZaeTk8F4yfvLtAC5Y40E+6Ii8ZMmourDaSnBsMOm5wuf0xvI4lDeDk7LRwRluFGZkOElane
	HLYzGG4+Ygy7eG3IWSFDobE5nalL75MHMVQdQA9CVU0QOSjQZYkJwGCKlnMCrERo3vht9xr1M44
	oMsuQNo+MlbKJCyZ+iEb2qxjsJXpPoSyhQ7zzar0IZne8b0Pfz0dQlPZNVU58qahs3K2IHMkXSh
	dfqfKrUpGBmFhZueeB+8CfGLT5PUypdeO3zTj6dtaNTuOXzt/XprmXJUHLLce2FZHUUjkF65Md5
	joOztOuvoV9bLhr5Qn8g9YGjrCIAZCxuPYIDm40dZLZefsggIB13QJJHN1Yh3ltRaw8ThU9mQ2o
	L457IyB8PPvUxFqVVKrhq/lO9P31dzKpx7oZeHWXZGxhbeOWZTLobf03AnEWWkSfg9HbSayYLf9
	J7WUgl1wdLyALGlv9gLsfZi
X-Received: by 2002:a5d:5e12:0:b0:482:ea99:6166 with SMTP id ffacd0b85a97d-482f79a72d9mr33372858f8f.7.1788191661680;
        Mon, 31 Aug 2026 08:54:21 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48436e2af3asm12949099f8f.12.2026.08.31.08.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:54:20 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 2/5] power: restore hwmon if extension update fails
Date: Mon, 31 Aug 2026 12:53:36 -0300
Message-ID: <20260831155339.181487-3-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831155339.181487-1-ivanrwcm25@gmail.com>
References: <20260831155339.181487-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

power_supply_update_sysfs_and_hwmon() removes the existing hwmon group
before recreating it. If recreation fails, register_extension() rolled
back the extension but left hwmon absent.

After tearing down the failed extension, best-effort recreate hwmon so
the supply keeps its previous monitoring attributes when possible.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index f550f70ca586..c041806f4f9e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1595,6 +1595,16 @@ int power_supply_register_extension(struct power_supply *psy, const struct power
 
 sysfs_hwmon_failed:
 	power_supply_sysfs_remove_extension(psy, ext);
+	list_del(&reg->list_head);
+	kfree(reg);
+	/*
+	 * update_sysfs_and_hwmon() may have already torn down hwmon before
+	 * failing to recreate it. Recreate without the failed extension.
+	 */
+	if (power_supply_add_hwmon_sysfs(psy))
+		dev_warn(&psy->dev, "failed to restore hwmon after extension error\n");
+	return ret;
+
 sysfs_add_failed:
 	list_del(&reg->list_head);
 	kfree(reg);
-- 
2.43.0

