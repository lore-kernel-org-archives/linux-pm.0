Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9DB384CDF
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871073; cv=none; b=dcBBqK4QAXhqa4rK2NGCS7qmp8W7lG7AR/1DVChZU4CcxB8RlarPOhm7i9EEEkjBixI6WhNx8tJdSAEuQ2pVqYWtgpWsqZbAyMvWKZpSxAjKaVbksBXXHH8hKbqLP0b6+yUCTW4Qj2sj3aGBtOuiq6768YoX33NNY67HHPyGitM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871073; c=relaxed/simple;
	bh=WxhLrdxWoS3p0+Dx0yvDZ4xjG2ikKQkrruoWOpoCTqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VP5KhqEEh2NGbLCI9RtqSrjzBd54jcucR1AvGASbmNHB8vdK6efjWH883ZAKPOvFpuqhLoliSA9Ov9EnmDGXdOpQm4jZVxuU4r8OU/hJP6/76htS5Zlu0DqehD4gxFLcQKG3HUNuLpZoFqdiFvVR5y76eKGQJfgOuhgPr5OHSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvOkiqMv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmlYk8l1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvOkiqMv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmlYk8l1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778871066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uhprfnNhUrNF5Py1hQunNOKUDjGww1uCDzfWCNs8mHo=;
	b=NvOkiqMv3tgQXNQoQs2uLbVLqeTFmv70w7m20GxDnXNtSuY/W+nGMDjgs5lrVPkS0mXYUL
	7eb+V+lfVZE/c5eK6lymfAaVnvnq761mM3z5o7QwZ2edPexcM3qtRQDfHoJ5tWzMmQhbkU
	/bgTKemrn41SfLYyjnH6quQlvsQw3fc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-AVv5lmPAMoqBjPRulEqMBA-1; Fri, 15 May 2026 14:51:05 -0400
X-MC-Unique: AVv5lmPAMoqBjPRulEqMBA-1
X-Mimecast-MFC-AGG-ID: AVv5lmPAMoqBjPRulEqMBA_1778871064
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so26469f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 11:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778871064; x=1779475864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhprfnNhUrNF5Py1hQunNOKUDjGww1uCDzfWCNs8mHo=;
        b=VmlYk8l1/k+UOLhtbsrQJ/iCSibhxaKUBOknaMLh5CgWgIoxTVFgP9vhsqD6/cul5H
         H659ejEVDSBoX3ar3ex+vdsp1Ng2x6ikTuqY41IINtHYlZO3rjWcPRYnEI/AOS0x5Oxx
         XB+Qhr3Rj/zqCuO5TzDCQzYtyyzm1haFhrenPsWLVOvAK51+SE+Og/g1P/eSRbDqATZq
         92kfjrD3fFzAuDGcZZ2VU47XDHzWQNjBQnQyUMDm4itYD+UWZXORZc0Seu3Wm8dNEz0E
         3PvQvBCbyL1OAj2ayMS6TgBGGbRNt0LiDUdDTiErO3u/wg0tpBke9RAuRVUoDzSei/i2
         Dlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871064; x=1779475864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhprfnNhUrNF5Py1hQunNOKUDjGww1uCDzfWCNs8mHo=;
        b=UJXsuaVaZ1rVy5B76yWUAnOggOWydxFdoLRvXHrWqrKoL0B+YcoxQtxTWoly2zWxiD
         z9R03MMJgwrCx5NMtA0Vxt45Hnd8Z9kom01BZ4AQ4QeIYoMu7z/jrh7OcJTXq2a5zsek
         gJr+2yTjoSw00p7U002l7O1XCP5hS7vlUQrTzVXYqevDjpWjARF6OOfrzKNrTgSGGKGa
         4NJptLrP9JXLioO3GYvXiUVFVJLp0Wx4qhpH+MOZTmedKZATBH+7suIg720sHn3djnTd
         E7n8fbreD9N1DIhNCyAJpeFTfZ8+ZdDp6vnDw+jOeEy4HScUBqe/szX1m9CObeWOQ39N
         20Qw==
X-Forwarded-Encrypted: i=1; AFNElJ+rfz/zlkb2oMHAJcNJrRw3QA/gQVgp/pNX3RzPw1xpX09SV7z7xKAsY8ccgICnZjQisVXbnIs79w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLc/bopyxerTi7TNWYzJmi09hENYg4O/lDlf10tAOwVJI9Z1C
	K0DYQCs7p0ZFAuVylkplX5k9JbperVVNQw4gcmAB10EZDQpgW8sc6OIKJoKu6muasED+Ya2Glqu
	kgewG/vyh8aPYF3uwHGcwMPx6YS/fwPAShKCAj7qVZqwNKZ/iYvIFWgL1/Tz5
X-Gm-Gg: Acq92OF7nkYDVieaol8qzE5t2ng/xJvi12+Ya06RQcd+6Ai0H8cKMLDrIyyFligdHVx
	+3B4nDgV3e8IDaCwgVUHjdec2Rj3z0uo/KPZdfOZ7uR9bVAH64gl1ryY4g7eBM2vY5QqxfGOfhS
	OamPHeR5L8CG+ue+0fWVpMLw3z7QzkSmFy83T0Eqnmy2deDIWPmfIVn4BfsjCMWKwFf8v/lSQkv
	S2fmT8aoByXKdYREVHJvLwD8ECDiBoULd2BnwltvmRcMLc9SusxyWL308kSkLl7ivw1p1pu1pVC
	IfGEQPS5dsOFB/ydb1TqTEFZmgCVfeVzZg2ZCwwvP6DZMDQhD+D/aLsZij99Van07TdrengRwcE
	RDN9UMSxLIdeLdmFSYqinmiMc6gcnw6UwWfk=
X-Received: by 2002:a05:6000:4b07:b0:44f:69f4:39b5 with SMTP id ffacd0b85a97d-45d9502e84dmr14791856f8f.29.1778871064233;
        Fri, 15 May 2026 11:51:04 -0700 (PDT)
X-Received: by 2002:a05:6000:4b07:b0:44f:69f4:39b5 with SMTP id ffacd0b85a97d-45d9502e84dmr14791826f8f.29.1778871063793;
        Fri, 15 May 2026 11:51:03 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm17740021f8f.18.2026.05.15.11.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:51:03 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Paul Cercueil <paul@crapouillou.net>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] include: Remove unused jz4740-battery.h
Date: Fri, 15 May 2026 21:50:41 +0300
Message-ID: <20260515185043.1523363-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last user was removed in commit aea12071d6fc
("power/supply: Drop obsolete JZ4740 driver") and replaced by
a self-contained IIO-based driver. No file includes this header.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 include/linux/power/jz4740-battery.h | 15 ---------------
 1 file changed, 15 deletions(-)
 delete mode 100644 include/linux/power/jz4740-battery.h

diff --git a/include/linux/power/jz4740-battery.h b/include/linux/power/jz4740-battery.h
deleted file mode 100644
index 10da211678c8..000000000000
--- a/include/linux/power/jz4740-battery.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2009, Jiejing Zhang <kzjeef@gmail.com>
- */
-
-#ifndef __JZ4740_BATTERY_H
-#define __JZ4740_BATTERY_H
-
-struct jz_battery_platform_data {
-	struct power_supply_info info;
-	int gpio_charge;	/* GPIO port of Charger state */
-	int gpio_charge_active_low;
-};
-
-#endif
-- 
2.53.0

