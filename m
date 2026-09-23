Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39A41F35A
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185658; cv=none; b=Xfec+YhV2rTWEzH7tCLubXgt61aO2zI9/859T1vFcxWA1qvtVDX8JM4c1iaVvtGUWsCPZP0z4Vd/9UQG8cF8ZLWgJfJNEwCXpN8OnParWT3rKQ3Jk1I0e9gQY5mbmwBliEAINq7kuxeVTTGD2wKh5XJ9vLfT89D9LuGxdPK9VZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185658; c=relaxed/simple;
	bh=yVrM8sJaHGXl26LeCM8G7k1yqbumhmWeqCmDq5/L7Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQtksiFmkLuMRdNnHdu9ClW0Qq8Ot27udcdb4SIgOQJCkLw0AB5W4fT3GPc5yXJ+IoJJcnlEQP2YuR2u7jIWNUwAHA8xsQ5yHmgk7tBwnzSjqj3wrR/42IBUjg2DDPTr3NjA3esOhlJyO4L8vKFZHYCkFUGgmg3CDKruIeuGHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WIWAqEv6; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WIWAqEv6"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so755050a91.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790185653; x=1790790453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jAVRGQRwud/0zcQSf2CKVKNedLQyxLV6xXHev/2q8II=;
        b=WIWAqEv6u1l9XVKDQP1FMT2wvYLOp9REyDm5+m0uATBjDFDs1mJ+WJVSvNlpt0RtVL
         YuQW4QW8FfZCV8pM7pVDbmGhlg872Vyq/s+XoaAZwofyLs9W08rsyhnJOHZn1YqlH+Li
         641VuNvd8PMCR1OCBVNLrYPnCtcFPsNIbyrnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185653; x=1790790453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jAVRGQRwud/0zcQSf2CKVKNedLQyxLV6xXHev/2q8II=;
        b=Z3cajhQSokyB1soWpM9hcQvMbHXjZLrO0us/ZQiyyedahmITf4FT+E5yOoSWLp9D3t
         zkrqJJ9cFE+Y+stY4D5431ZWF+Q+gMlXNvpIx8Rw5Zt5458DIJfiV7TdiSzkPJ1hXIGf
         jgFOiwDo1oAyy8nJtsRVopd/OnUPQwswMT32YcDqEF7ewKDfoav8hzpOqOfOhURBRoTs
         fWFzNF3eiSTS1+gnqV64LM6I3ELy3phkAiwcjNXCuqoxzhOeUgVybpwmv7JDqpjnNC5A
         ydnaVSGynqmiXckJUGH4vRax7fa/mihu1e2hVgYl2OGE/G++VCF+f9eNIcTiXDm/QTss
         cigw==
X-Forwarded-Encrypted: i=1; AKwUvBxxI3IuzoV9E0vJjIpW/mdr4iSeWwTikfMJaXMPX9g40ZTHOC7d1PBTs08hZZQz6XDxdNN9tsHFlg==@vger.kernel.org
X-Gm-Message-State: AFuF++n9IZnM9CvSOqa3qjJTTCRAp2iu9Pmk1K+WtyNEukI531/2WehR
	fhJ/KPxrrdPnQ6P/IF/nbGGOzEPsJBwvkDEI8d5Vql0iVEAL6Ezx1jL9qrv+k0qpMA==
X-Gm-Gg: AYBFou2NP87mJ+t9pNglEUchvnoPYKJrmsKJF/hx8CnTLdhEDAVimHtM9PguZ7R/IBl
	2IbcIvHBJ0SU2AMViwkXqZWRiUTv9Q0oZIIuc9NxY8jojQW7xnU6tyDkgNVZr1mcbc/4PcRfNsl
	/YcJFpKgkNvI1CfINJqHY1Z4I8eEuhW0c4fLK4PWc8UPOp+CXyQ9I4t0Q2sEmIWr7MSWTR1RpE2
	H9hWZmcd26A4bJ3myqtI5KLMr6qfvg0XTCYEcjE/EGFl7yHA6LpkPTv5uD4FghWvdhPhGJndbGP
	NpU5fIpJCEF88HHrbE/zfKrsOLKib8Q5rivZ1cjmB5YJuCkbjfHfk0r60CfQuIi8b9numMgBxKa
	cUsgTl5wmadnDFZtGNwXYSxVRB8TSLQy3rJBrarMUYRZp+4vndVyFWiENj0qyIsx0A2ng8Wt+MB
	nYcVTmbWmVcA79yd19qN/Cqo8t9FcDrogwxudXAkC0MyvWy2aHR8cy1MPCwKQam1H6tY85mdE35
	ZLWx7UAGJxP1HmJJMpWLkTg9zTRrLk5qK6wnA==
X-Received: by 2002:a17:90b:37c3:b0:3a0:4146:2954 with SMTP id 98e67ed59e1d1-3a07e6be0b0mr2933474a91.27.1790185653491;
        Wed, 23 Sep 2026 10:47:33 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:642b:a4c2:7ea5:5668])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3a097663e1dsm158337a91.7.2026.09.23.10.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:47:32 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/8] PM: runtime: Correct pm_runtime_autosuspend_expiration() doc
Date: Wed, 23 Sep 2026 10:40:25 -0700
Message-ID: <20260923104031.v2.1.Ifc8b2d1742729cc82f46220d85c6382fdee1fc8b@changeid>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923174711.1283986-1-briannorris@chromium.org>
References: <20260923174711.1283986-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "adjusted to be nonzero" comment may be a relic from when this API
previously used jiffies, although I'm not quite sure about that either.
In any case, it doesn't seem correct today.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
* New in v2

 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index bb008dfe85a1..7e75f6d5df07 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -169,7 +169,7 @@ static void pm_runtime_cancel_pending(struct device *dev)
  * Compute the autosuspend-delay expiration time based on the device's
  * power.last_busy time.  If the delay has already expired or is disabled
  * (negative) or the power.use_autosuspend flag isn't set, return 0.
- * Otherwise return the expiration time in nanoseconds (adjusted to be nonzero).
+ * Otherwise return the expiration time in nanoseconds.
  *
  * This function may be called either with or without dev->power.lock held.
  * Either way it can be racy, since power.last_busy may be updated at any time.
-- 
2.56.0.rc1.310.g51773c2048-goog

