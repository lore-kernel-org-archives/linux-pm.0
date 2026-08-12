Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49078347BBD
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786508940; cv=none; b=rRZ1aZkpYFSC+cLVw2v4fUBarq9iHzq+o0CFtk9D4gBcrVSVSZYhFgM8cBzSoq3QDvvyCSOKF8V6yqugBisudghzvfkCexDG1pL6Xch3RWInWx8tB+uUbA2B3OvwYhuWw+sN3jl9AEQllYCCKNESYn7EFrmU6aQZDUZdOB4xp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786508940; c=relaxed/simple;
	bh=2foUZN1ZarhKYhGz7BeiGVU/I65V4tdXI2iSXk3/sT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVS8bdR+5Qwa5s5talKdh6Jud+6N/G3i4f6ZeZvxtur5vXVsZDtDecF788gHaRuAUKTeoQsZ3e0fih2jaf+qSKKOkDhOGuWoGmmOiZRjhhJGHO0h2s675XhB1hBFeSpSeb58fwfdpH0LSSr2Qm6T7PyYUAYacmqtu3mGNTRA9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrfAnPyS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrfAnPyS"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485ef63b68so635081b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 21:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786508938; x=1787113738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zfSxF//v+gtVkwTrvrITkpqbqxQrUBxyO3+NJDg4Ey8=;
        b=OrfAnPyS78j3Gau3MAHiPjpToLevJ5iHWNo70Edl4HtmP0+tatNwTx2I/7Jcn47gnM
         N+k9zxy5vNEh6e2/TGVtyvIIdFsnBZOnr6xMEyjdjysH4J4/yDoBz49lxCzmGzFwKxd2
         ar3YWTFvvfXczK7WIHv1FM3IGHtlHFfExcRdUd/W1xOB4W02oACyHFsBYYQQ1QX5BPYd
         k9osLZ3IDxx12sKEMJWFObMz21uaNa/7oT0q5ZP4/Edcg6Nhl30MIOHwmJSg62qH5tbo
         4ZlW88NtTAQ7VZFGKiGwb8dNS9GzK+PSeoqZyVnwp3IKBW46kxP0j1gcgUCQmK4slr0U
         qxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786508938; x=1787113738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zfSxF//v+gtVkwTrvrITkpqbqxQrUBxyO3+NJDg4Ey8=;
        b=KP6frJg8GbWUV4gDLS+KSg2RpetuCiGg282m8VLQm6NBZdsYObC5OSgzUvbe/bcjOD
         RhZmEAQ76xeZLmGqIHGUgVr0fHtzCgAgpCwf2IYDuYul5U/K2ZbJbw8JtRMotN74rNo/
         8Z7eh2Nd7Vriwj2eij9t9iSVBQ5HZ2IMMyytKqGm2Z04I60OhG5zAEqFYc3iMJJSnjPL
         UpcXLoIMe29LsEdQjpMDZIvnyUcBhhvapTRGEAuG0TbCgsXD+isHTWGMeoAzxiKhv/0b
         PltbTSqWnccLpF6PE6sdlOvoQw9vhRNXUty6BR+yjqZs65M4CF+GsyAb8yReIOJ/18aX
         KunA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/h7V7sa5R2m3BL9IbSV3sd6HqBlSoDJni2UNpUgHElPx+ggV6edPmQt7GH4iIPj7uVIq4dyl8nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVORit3aQV9gMW3LG4qJ7HLStsUijf41JfcR5iu1nU8Ib7pH1
	OA8GrhI61qTMDWPTxaW/WURROrDHmLW41HXlrhQF1l46A0BPEncNxOmj
X-Gm-Gg: AR+sD105VFvMHvRDfyXqbDw0aPb8TCI77FBxmrAZPW/Jo1ClbU8GCaTILEJnKuMtxh6
	G9a+ZxmuFV1nD5cF7QXjllsjp2EgRrou9JjNlzdxEMUahJ/ct5rm9ic77tqpeAjUv7nN28eE3rB
	b4CDfDeKtEf2A8BEYHgoDP0tDwASJHoMkoMZaqWqcokwEi1Pbwya0+0zUdto86kq5tVZC+cbH5t
	bmstiwObLXnhTwl6RBssio7pp68QB3uAIs6MDqAI0jHlZQxbuJ3JI3r+aSZ7s7kvPJCRbUOfRZr
	CUeB+ANw3qaSusN9XQhOLA9dnh7bLkliWopzIsq36gfqUcLthQRyO11z6VqBXdtNp+2CFKdyl2x
	7MZLW2SDBSHOCqRTNV6Md5XTCmrs7kJrIuBSqA/XURlytAos2n7vmxBEedjdIXP3eEfeX5x7u2Q
	SGVyAnIWNUCOIqUNA2UuT8QvFvYtlPs888RTSPb1gYh5qZZ3ZetACTsd4RSV4R6SbHayD48GS4l
	L+DprTkam9RoGx3IQYn6ycNmlyR3aRFt/G6JT9b5QOTz8mg5x84uWV15xlFZi9HhyIZcyJsCqEY
	BnG5hg4aSKNpcZM=
X-Received: by 2002:a05:6a00:2386:b0:845:e440:d0ca with SMTP id d2e1a72fcca58-84fb5395c03mr2267928b3a.8.1786508938483;
        Tue, 11 Aug 2026 21:28:58 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1cf41acsm476376b3a.11.2026.08.11.21.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 21:28:58 -0700 (PDT)
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
Subject: [PATCH 1/3] checkpatch: Add devres_alloc() to allocation functions
Date: Wed, 12 Aug 2026 11:28:39 +0700
Message-ID: <20260812042842.15209-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Add devres_alloc() and devres_alloc_node() to $allocFunctions so
checkpatch.pl can detect unnecessary out-of-memory messages
following a failed allocation.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Link v1: 
https://lore.kernel.org/all/20260812024304.9350-1-phucduc.bui@gmail.com/
Changes in v2:
 - Add devres_alloc_node() to $allocFunctions.
 - Update the commit message.

 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b7a42bbdd94..e89cbc3f2604 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -644,7 +644,8 @@ our $allocFunctions = qr{(?x:
 		kmemdup(?:_nul)?) |
 	(?:\w+)?alloc_skb(?:_ip_align)? |
 				# dev_alloc_skb/netdev_alloc_skb, et al
-	dma_alloc_coherent
+	dma_alloc_coherent |
+	devres_alloc(?:_node)?
 )};
 
 our $signature_tags = qr{(?xi:
-- 
2.43.0

