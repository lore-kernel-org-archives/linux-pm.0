Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70171FC110
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967925; cv=none; b=DiPnydqfFy71EiXKSIjYI1xysKsKQ2V+Nmgx/5xNc/4RzcPpBWrAktkkwcUv540nhuV7tEW94lXoXPEar9M2joHFpo8D3Ol9ZNTZ83Kd7A3TyXHP/A6Q1VVccFby4tqGi1dB9n/B1QUscbfsZ8Ll2zHdzjmhUB1lOXX+Z3EHXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967925; c=relaxed/simple;
	bh=HC7a/uepR7yvM+Hy3L9YmOmBswicpOMbE7n49YtuKAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKjhc1iIWaI28EasmP7hDrrBJopPg25fpKzoRDkr5ep2iI1KKGNHujTF6rj4LWDfrl27aNUdl1pwNSQAil1/ikV9sh5YA5Y9uzHkwhcXr2hBWcJHvTr6lXafHaCo1F0WBn/AsFa2vnswF28kgt9Aq+oaYHs020fNHxrboYZ+Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8O9KAo4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8O9KAo4"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296d553142so695491b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 17:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773967924; x=1774572724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baxsixP3ts7CN2kPTC0RUZ6mfLu0lUxnu4cjazVMzu0=;
        b=Y8O9KAo4bfybBtRDJWsUPenrYdnfINSIC3XzLKqDTRyMzdbE69JOpU+ymE1K/PxBTt
         e/fvD7gE0y9JhflmkA2ULlOSzLBvw2CEyvSgaTk53u0Zu3+yoZKts3SbcEJ0hAhMdc7J
         OCzzZX58IqR1Hz545GGBtQ58mgbvTW3rKQbtHjukRTtQRwziLm1p2RMHyqm/E81Zpc10
         phor+grdv6mdwlNzCTM1niMZwXy1PppN/YnF8as56L63CFBxHkJOrRWGeFESJy2kS8s+
         UroaO05Fu0D4lgKJFk+sDXgE/SruUJM6v9E9G0xT9F9amSpCp7fHfYkcunqBBEqMGu74
         utDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967924; x=1774572724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baxsixP3ts7CN2kPTC0RUZ6mfLu0lUxnu4cjazVMzu0=;
        b=O78b++G1DtUTkTskHEFnI7haXhsldrIsHuuV3FsvV2E5kv0+ZQSyBMqWRJzwwWFU9n
         llRwKiXfVUgQYJ2G7Q/u4kMEMzoJ7g2QevJAQTszKNYGoI1fXzLcB7P1T/HiUlhfZe1T
         gjPYP7EbfKCNUgKEUaBZSSV2B2jhYunw/HhiJFYJc9LmRQHS/SVyg51B11yPfHtjGBQF
         tr9y1gyBpnCcCdAw+6YBiVBbFeYie5f4TmlmR3D0jtn3AIhEOPaYzKK3oTSm0m9FEifE
         Z/QcCgFJ9DrwKOcCoPWMvodFWCr7AUAneKs5CT23QZUz9VMZLif8dBPJnK8865+GXfoI
         mWDA==
X-Forwarded-Encrypted: i=1; AJvYcCUPvpdlFdKqOxy3OP03gW6iVtZkPuZIAtrNuetxtob9DH3URei0OPh+wNiqz9Sm0LWOGqEOZFxj0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5hWpTN9/FExTca7072UOSniQDLB9x3vKvWjNCubN8pDw8k04g
	J7vcjM+EXZUxbXly15x28dGlsUG07PRms48fzR3vq+4EyMyWkDNAu8Fj
X-Gm-Gg: ATEYQzxRjgkq2RxFY5UPjQkdKLRT9gqXqwNMZYjALhRnI4WGJGH+KeoA7WhY5lknLLR
	ktvT7B3e7VGJZV57/Q19O9nEJWamN+8iG12Ww8YAD5AVAiaHnM2P3Z6XjTJNMDz1vulDXbxpkQU
	WytnW0pC+e0aZpanFs58h1c+DkkcgbcerroZSH83RSf9OnettivT+N6DM9KZ20SzvQtcGtscl20
	cInPvgsv/i4yf/GoiK31Bk9wuS2rxK6nU3/Xecpli+pAJP/dZsyfsLIFMQoBHgYLx8eNTI9jQGv
	ceC3JvKCQRvuakY4op0AmzeZpNlipLKZeRuCWFxb9a1HCvSO0ohLMq10kYFCJAqyXGi74kQv0tq
	7YaSBN2I7Rb5AObNDRQVeMuJ2AmW999mxQ380EYmcVNyUXzdnG41PM1PJdSSzhKFFAph+J/giOj
	v3xypBWdHpM04Zh/P5vsBH8Or/7BND
X-Received: by 2002:a05:6a00:10c9:b0:82a:60ad:87e with SMTP id d2e1a72fcca58-82a8c289509mr968680b3a.19.1773967923987;
        Thu, 19 Mar 2026 17:52:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da438sm370240b3a.43.2026.03.19.17.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:52:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/1] writeback: don't block sync for filesystems with no data integrity guarantees
Date: Thu, 19 Mar 2026 17:51:44 -0700
Message-ID: <20260320005145.2483161-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
---------
v2: https://lore.kernel.org/linux-fsdevel/20260319194540.3463371-1-joannelkoong@gmail.com/
v2 -> v3:
* Move SB_I_NO_DATA_INTEGRITY check to sync_inodes_sb() instead of
  sync_inodes_one_sb() (David)
* Move comment block (David)

v1: https://lore.kernel.org/linux-fsdevel/20260318225604.71545-1-joannelkoong@gmail.com/
v1 -> v2:
* Still kick off flusher threads for writeback for SB_I_NO_DATA_INTEGRITY,
  instead of skipping that entirely (Jan)
* Improve commit message (me)

Joanne Koong (1):
  writeback: don't block sync for filesystems with no data integrity
    guarantees

 fs/fs-writeback.c              | 18 ++++++++++++------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 5 files changed, 15 insertions(+), 20 deletions(-)

-- 
2.52.0

