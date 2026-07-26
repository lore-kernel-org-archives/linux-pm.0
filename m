Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469837B3F9
	for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050530; cv=none; b=QOfYaQVH8OVb/K6m3aADDda/rT8TSERtELWuUJM17I7VXHjd/E07CekOE8tp1Xuw5f1NFms7mxVBtohMBGFRm+JOvZU0h5pAvsxslrKZUUjIZ7GOBOfG2D8+5ytRkY8HGHFen7WtApgZpao+W7OCM+ngaX/Yf9ZC4cNtT2vtL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050530; c=relaxed/simple;
	bh=VZCjoqNfIq3fo0Vu4oS3PYyaH8ZyzB/jpp558LfhArU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LN++8R6aldilsbDeJc6H5/Ai3r1iZ7wFh8lKy3s9wogXrzuSf/i5aTaPNln04n9E4HjFaIZgWA4gw3XCmHTkVZ10hTlgRD3h19fBO1XVxiPoxFmRSE8JIx8QAzRt3ZjWlrCquqX+YNIhWfmAPuftaNLM7zlFd9RWYFaVd3wJlk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kzr5k7sa; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kzr5k7sa"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbb85186d43so835459a12.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785050528; x=1785655328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0dbtxwZelwgBLjGWlT9BwYMPJVsVlDkZBf3ZnPfbRw=;
        b=Kzr5k7saDl8DiZ2Dd53XlznkMLHfUaXpgwhtUrcV5G+Df9D4vMTTIinZL4KR5jHnpM
         KdAF4ngR4I53BEA9vUiCC4KG5HKEkCpPO6JOmcYIF1XN12+vl2J1LnMkgiaCWGQ20y6t
         WzAGwHojhEMXAMkYJBrSv86q3LSmgeiVstiOfM87S4FyHz3t4MRlIwvO/rNp2y6N0bcD
         uaD6VjJD5yj4x1BhDbX/AtOLv4cLkv+WAOj3s843r+YzSNV95cZ+1oINrY7vsCOmXjf6
         6RQsmr7yeLiv+l49cw54oRYY7vofE9lhnm5UAB84qoWzhsCe9f/D2ah3OenPbNUhQiWc
         N2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785050528; x=1785655328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0dbtxwZelwgBLjGWlT9BwYMPJVsVlDkZBf3ZnPfbRw=;
        b=HmepINuyAxP+JQFxA/0vcy116NqJo9nXFPgcZif9vxorZhu76eK250LZibTYtk7r67
         Y3kqUtHPvZYneW44MekPU1UpSukvXO8JKBFfy1HXU4x4RHxX3ZE6tkd7pjm9IjZEFw1H
         AzvlifaaosvXdJhF4GywI2EogvodsJzltba8crZKU7F31LReaBAakyBIUeIEeFqplyiq
         sZJMYEXHBN35+4zfuoAHj4oEE3Y6gR6vawfbC2r6Vaevr8Py5mP/JM56N8z6PCnIqTpa
         ENE3hV2JDBCBun9FPCW2fy/NlI3Hg95QQ+326bk1J0MxcNAk6lm3St+ZjprgcR8vNXhJ
         kpLQ==
X-Gm-Message-State: AOJu0YzHQaP46dlIzoUeklj28t1jqD0m/aXTbEZ/O3F7eTJDlU0FoMri
	eFHF8gN/JJ4RzWYCCFTDEhYqqFeIOmO8IClckiXtZ+l7dnTmWVuQ9U9g
X-Gm-Gg: AR+sD10qBZ5s2ciBcxZHf0Y3oQW2szELHxJhW/tgVowcxCYM/eNaY4UTVHi7vwa4Pbj
	odPYKvwve5GwXGIPAeHCKOiD0cv/x5m05mIua/6OiFdiqIW/7rLPrlZVR9FvTP73F9t1IOvk1rJ
	erx3aAzxi2j46YmkJNxQ5d5bLsCgjfgqSDYqcAHS1XpYJri2LMWny6lImq619m5qzlZtsMIHfbn
	OJZ00SxFrusiH+x8GeDGG6nWmWkXyqOJAdcdw3GBrLPIAR6ZSuWvA3LDEDmr46SxHKntp3ZtsuG
	3W+J0TIK/B/ATZq1O0sONKZ8plnyiH1LJPeeRow5rPexZL9Q36vrNXnWvZA6IyrAMkyRPpytIt2
	NAElKUq4bINXI8Q/2+7uOPJjtL15yUDSfmiyzYFX+fZPx2AkT5KX0FizxsymgiQJpy1q7cUbQi2
	C90g==
X-Received: by 2002:a17:90b:57e3:b0:38e:9279:468c with SMTP id 98e67ed59e1d1-38f296091e5mr4291056a91.25.1785050527598;
        Sun, 26 Jul 2026 00:22:07 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f294e1ab1sm1489074a91.10.2026.07.26.00.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 00:22:07 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 0/2] power: supply: sbs-battery: Fix the shared serial number buffer
Date: Sun, 26 Jul 2026 07:22:04 +0000
Message-ID: <20260726072206.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The serial number of every sbs-battery instance is formatted into one
file-scope buffer, so concurrent reads on two batteries can make one
battery report the other's serial number. Patch 1 gives each device its
own buffer.

While rewriting that sprintf() call it became apparent that the
conversion is also the only W=1 warning in this driver: the value is
carried in an int and only its negative half is rejected, so gcc cannot
prove that four hex digits fit the five-byte buffer. Patch 2 casts to
the register's actual width. It is a separate patch because it is a
distinct (and purely cosmetic) change - please just drop it if you would
rather not carry it.

Both patches are compile-tested only; I have no SBS hardware. The race
in patch 1 was derived from the code, not observed on a running system.

Detail on the multi-instance premise for patch 1, since it is the part
that matters: sbs-battery binds per I2C client and sbs-manager registers
one muxed I2C channel per supported battery precisely so that the smart
battery driver can be bound to each of them (MANAGER_SBS Kconfig help
says as much), so more than one instance is a supported configuration
rather than a hypothetical one.

Babanpreet Singh (2):
  power: supply: sbs-battery: Use a per-device serial number buffer
  power: supply: sbs-battery: Bound the serial number conversion to 16
    bits

 drivers/power/supply/sbs-battery.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

