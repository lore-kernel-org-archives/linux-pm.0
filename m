Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E44B2CC9
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191735; cv=none; b=BxLGHxZXSvNfOmPMCkEhE7HUhEf1eIhYwhZwWMxLv2pLBsEekZi7bMlJSmH0FUwKO1KiK4iaaQ4Pl15WKgQhoc0mApMvQQl5HWsigRLJ0HkPoNy27k9/ujD5o8WgkJcCbevOFRitQNxBOfV94I/QUeYKzuSHKBTEsGjSinBqtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191735; c=relaxed/simple;
	bh=QKJUweDWl1eKJLRIxMGBTMDa4jR2KLLIxTXKyTzBC5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmLjtxf3srncA8tRUI1lKE+PGwvlFAXcJfB3NbEzoySErAUykL6AiOpunXuF0sYuMBM7Zu49aVDvoFIGpouZcPEReKJxhax/Eafiq0DkS0ywxQEdPihN8jZTAvsBd2YXzQ96adxIuNzk+/lVBI2yQ2AjDJQdBY/OCce0+pbFxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFNqDfvm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFNqDfvm"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-484374f54d0so1013800f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191731; x=1788796531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2x78xUJ0YRw0EVGMKYL0iQj1+Dct+8QGumz4+LqlKTg=;
        b=KFNqDfvmnMNwQ7XPnqdFUcb94kFw9oISuOznRbF9qsF6INKGlsqXCnDSvadc0l7GA7
         UsRwi3FRW1NcTWM8jfhlbdQrTdII43E1YrAeQNTFhvtfXfmWiqZhCJp8U2ZaX8DTQhsZ
         j1wIdT8WxgiBrcz1V3kkcI4qWWArS3rb0IzxBIec0v6v327AJFzfz2XiQNp2vpP7tY7r
         LlwbqZX/2ZzbQofM44FHGWwKv/8aY2/YRwB3G2DunZp39HzFExSM76zSb9k1jEdCEQC2
         +IbbciEsFnYoDCB/5PkZTsegPtYXdJ4srpZQIFA/TILTWUTDcKt2uJcSooPl/sfb5Snm
         gBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191731; x=1788796531;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2x78xUJ0YRw0EVGMKYL0iQj1+Dct+8QGumz4+LqlKTg=;
        b=kgHHigLA0r1omb+NY7YTZr73t8S33IsEdtE0pKjerbL3b5vlmoO33772IyTlRboXog
         rWpd8HcZ5tYyh9PoMyx4XBttIFkG/jRJahouRq/4Ip6ZhdKrmcZOCPyXUg/KUFl5utJa
         +qHwukV+i2qubj4OxnchmYq0T7ScBicP3oTTI2zkk7rKFI7xDyPZt+TABcY+CqYWbmys
         9dz6iw2Op7+t9zscq6dCVE5kwL1BXBH5iOIYh3nWyNkWRrsTF2d5RBXeEHNXdndZ6i4A
         Y9uE1rJq7YTJIzNcYuvu8roGpA0R2NUOhHw0HuJfAmJv2CPj4mVHHKjYKzmANdCcJesd
         Xn8A==
X-Gm-Message-State: AFuF++nskjKtmyOXeKduiPsZzjKNm6ckLIe5MXwwU5xfWqBjHG++KgZl
	itAfNA8CLatEQ/LyEk4qihArbdfeAkApvxXtub8wCGT4LRl20PC7O9ln
X-Gm-Gg: AYBFou1hIK+lDksMEb+VgffpYfiFkhPKl7sIn3emcWLdnmqiPrtEGPuh2650OXgmgpO
	G0GvODBYJAaOA/7ykg68SRBZII6QV8JXRa7AQ8xG7QFPOdA25VvbGK1kfCdKlMCAmfKBOYW4d5B
	h5hx5TRAES20iVZq5et2LAuUxZs6LFB/7mLyehi4evEIM5epgHcbwovoZuxhx7o7YRIg7zMz/wb
	ieSp1hHtK545BNNrpuLEIFCNgXeAOjiit51v8dHUhAn3J0ZMvhZ0CETpd73MZ2mTmp7YGbWEUrZ
	yEbM6qMa1lX48Tgs+bZmJz9pPqpFCNFfMoORRzfO/+x2En2wYMeaP8XNW6rke1ZOpbbSr0lXxyL
	GrKzQ89aCsywaGLBljvCv2ohGkUCTv4DknR8brCKdMtUETr+jYgOd7XLI4OrW/rBM3rgqQhWjZb
	xwIYjomQiv9RqsrzJ7LIfjPcqSGYX2iKcb/uAXQdtvgcqHPh4eYOcX6dkBW6NQsdc2fGdVTmoqT
	MhZrMALmlgtm0ioKuzkQnW2
X-Received: by 2002:adf:ec8c:0:b0:484:4164:af7f with SMTP id ffacd0b85a97d-4844164afafmr1193686f8f.16.1788191731537;
        Mon, 31 Aug 2026 08:55:31 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48436e2af3asm12949099f8f.12.2026.08.31.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:55:28 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 5/5] power: use tabs in power_supply_get_property_direct
Date: Mon, 31 Aug 2026 12:53:39 -0300
Message-ID: <20260831155339.181487-6-ivanrwcm25@gmail.com>
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

The return statement was indented with spaces; use tabs to match
kernel coding style and silence checkpatch.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index c041806f4f9e..8f464583c5b0 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1442,7 +1442,7 @@ EXPORT_SYMBOL_GPL(power_supply_get_property);
 int power_supply_get_property_direct(struct power_supply *psy, enum power_supply_property psp,
 				     union power_supply_propval *val)
 {
-        return __power_supply_get_property(psy, psp, val, false);
+	return __power_supply_get_property(psy, psp, val, false);
 }
 EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
 
-- 
2.43.0

