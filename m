Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6661F5842
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786508953; cv=none; b=Tq2Bk+0q7zQowqMMH3HKUbPfSwFDuwIL42a9bXPi2CEIMurYQMfZbAKUWRykToir4GwgZ/ADQ7v5bie6//F/EIn7VLBGd8vghfOUYSx9ykQfK3rurDaWaTJf9ZGqf2fbpMNnKXJwbOMC5rsmi3N/uvBYX9wLeLHR81tvfY+TKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786508953; c=relaxed/simple;
	bh=paXb7cPz84ak9iRT+469yi6R122BTm7k+86ToWnqgxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYKhmjYwc3RA2tBvW9zpm4QjEuOMNSLvIkWKOMHlGQv0szWWWThy5P+Gunmr8BO0rvSGVNR6hfxC7ny6hBxr6QCXgcc1WlSY1H66r6zz4wIQY+wJkNfrAAL0o8LmcPYs9JfrvwqEUMc5JnALzGJJhykOeDf0RfEEVc23cJ4+GZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie0ZCCFt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie0ZCCFt"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84f77cc7302so251410b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 21:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786508951; x=1787113751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEJkipxPnylT8R0BXRqJUwVdMYB2oKO4eJNrvtsOxzk=;
        b=Ie0ZCCFt+VnCwT40InHfJoVsc3OV6qbZeOA+1QCJsbaMvm+EoUOkFfktJI6EXnR7oU
         HqbjdyD2J6ZPydPUZ9CEdqX65dPKHhL5iPJCRjNkvIouxkUyYRjRDzC+qYkzPpRvLDND
         6/XGKt6COCMWUvDp0RWft3IPn5xQE6EnMyJAJwhDd5P/yER0eb1gkLHV9eWuc5zpvu/+
         xvlIu+jMxLOgsyfBRF0K6FU5VCUo9v5Tz4LfFgl6RbmioZzSVQaTnYj6QPUiGsC07Ggh
         wt9Gs8jFBrXfdzaiC7nPMfSP65y2n/Wxir9vwZimE97MM0Ff33LfaErJ/eIvOi41TroF
         +RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786508951; x=1787113751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mEJkipxPnylT8R0BXRqJUwVdMYB2oKO4eJNrvtsOxzk=;
        b=iI5HRnbGNklYAYyqEjM8w3ahLNH1+PsqOj3L7tqXsZmOMGNAHHlsqYinyW2vw0uTiL
         B72TDYooQjsqowA81vK/HpwB9v8HeFN25znwY6zotO3/Kc2EKaHgN6idYLSQsA2r4ued
         Date1wpD0y2rT2aQ/9MozOhdI0LEe81pYSC1x5GdHPbd0eKUCJXOivZTo3sBhKvJQuQu
         111z/2bzY5U8qmDFTWoucimlxmHmgMst2Y11S5f8HbkK3fQ1VbXCOjqO43ZEsTX27y50
         MTazp6uRR8GnKU/9WSbFWKwgfBpefNB4BnInDaYZOArO+xpDpKjAVEK6jLEnmW2bNj4b
         Ijbg==
X-Forwarded-Encrypted: i=1; AHgh+RqnBLgA31mRYbl418tuunuIKdEJY7EgGdkT6Tf1/oXUV20LYRrEvBzYvv7Oh7GzBzP9zvjEqULfqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBJ6Nhp3UVU7v+ex8EnCbGga0IlgZ5UiZ57eGX1N8A6WqzWkw
	mrMoV6PsCJPgxbizOLNsYWUYQ5hynDBdBId3QGG6V6Yq0gxyaxQ3l4Nk
X-Gm-Gg: AR+sD13JbkUpib9+/K9sMB1EDVKngErdnyN5jjIwYBA4h3d3rRt/ZLI3cPBeF5x5qrs
	7NirptdpgKnRrdWr2VBCPqUVahbMjUQbQd6cfjBQwaHKruzvxYQx+zBe+/eBKHUc6WGSCR6SMQT
	EvX2+0IzlPBnnjhPjCWxLNaQGd8Fbqw//xzh+h0VaywdfiN9lRSLGRmBSBN3/zeJomvlaVKByhV
	6XVNbDR5lw9rjwGc6w+T1Vd9zdcvziRcKADdF3vekMz+bzFo+5KPv1S4CVsDadpvamIYuOc5h2D
	xT/3CFHvqISxCPD0EhXcDnowl1OPSJX3bLgqRKPXBtQeTZq9WbR9wK5eO3l0HUOG03seV+NLqV9
	0GXt9EO9nY4RUVzeXRiHrw46WIwNt8CZwwCV9BBqR8nGkCIoIthzcbUFByDVuf7vhsTXt+KrJl5
	eiE9eDDtr3NfGQE4+bJiPgFAh0x1EdPDFT4H8nmEZhAFwtRoyXENDiKxzkjBkGj5MPUthS1eXO4
	be8jpYzP/OlFdtAIt9wUCRsuSugdxdxFmtA9JD2jvVWV4QP0qAAbpOsC+sNElVMHjnc1/BEnTBa
	FiKNHA==
X-Received: by 2002:a05:6a00:e05:b0:84e:24f:2667 with SMTP id d2e1a72fcca58-84fb53c3629mr2470608b3a.8.1786508951128;
        Tue, 11 Aug 2026 21:29:11 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1cf41acsm476376b3a.11.2026.08.11.21.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 21:29:10 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	rafael@kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 3/3] usb: phy: Remove redundant OOM message
Date: Wed, 12 Aug 2026 11:28:41 +0700
Message-ID: <20260812042842.15209-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812042842.15209-1-phucduc.bui@gmail.com>
References: <20260812042842.15209-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Remove the dev_dbg() after a failed devres_alloc(). This is
consistent with checkpatch's OOM_MESSAGE convention: no error
message is needed after a kzalloc()-style allocation failure.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/usb/phy/phy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 5a9b9353f343..117a33fa9e91 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -534,10 +534,8 @@ struct  usb_phy *devm_usb_get_phy_by_node(struct device *dev,
 	unsigned long	flags;
 
 	ptr = devres_alloc(devm_usb_phy_release2, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr) {
-		dev_dbg(dev, "failed to allocate memory for devres\n");
+	if (!ptr)
 		goto err0;
-	}
 
 	spin_lock_irqsave(&phy_lock, flags);
 
-- 
2.43.0

