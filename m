Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BA3546C0
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957200; cv=none; b=vE+T08C3dyZ+rtFC5wzIIxIDfc8eGlq9tbpvs6R3PrFr3UiqK7JAuq6zYz1W6FfhitwD64Pw30v2wAWBmz7+LZwQUKEqavTmtQO9fhxrdeBcBNXYHyedR9m3qKJFfUzKr2kTjZBJ3JIpmt1NesF7lU3YykxYiGHKlkE/2tjpN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957200; c=relaxed/simple;
	bh=yNZ82j0E6cOU7M4TEVWTmABgsqSuolUg23P+N9dX5Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELtfg4pPz7YblqTW4nBJayjL+PaLOdymWmVpksrmwBy6F0pfKSPNHOjoG5rKp8H500Sff+uGIpwX1kca95bVZZcoC0r6myn7ZCpQytAw9k15ZZCpaRv3XWTenirpPXUI1VtPv/JqRdgilzmUiyBuvH9jPDOeWJWyNIe1qclhAtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=LjuOaaP1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="LjuOaaP1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47db714766aso12435f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783957196; x=1784561996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXlrSFErYtjENzy3YZB0q3w2dAvBYZj3GABSDzvON6k=;
        b=LjuOaaP1HmFZzhIQGBQnAuqp6Co1juPTeqCmVe3zKg+0mwa1I13P/3UHTgQ25lXUxk
         lTXUMYoE2un56lLtpmKtrwKwH5cehok9WvMs6xAjHNKWV8ogCz58kyn9cTnlL3rmgkJ+
         wDytMOG360fNfRR9QBZeH1xek90P2LeBDz0JipZtyuMDXWEyA0sd/Tr3GFWdp2IufvTh
         eVIIPLPKdcVh8HD3LpC+Z9neeifq6seE0+Ws3UuiWUpTkAqQakGdCpCR9tekj/ypei6E
         OR82XzVYVM8QoO40ecYhavM0ofx2W4x/JG2C3Pr7I52JREDLabTxGMYPgQw30sujYZH9
         da5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957196; x=1784561996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXlrSFErYtjENzy3YZB0q3w2dAvBYZj3GABSDzvON6k=;
        b=huFTEzAWQyc6kMw+iEBfqi6Z/FeWuB0eAOzWM9BsvrsTTGM4mj46LxlAEj33q94UNs
         SXfhS/CZj/2AGwTWC7lmQu3PFNzwdzAqT/zkZ4pJJsz3BcOFG33vjwAFDkQ4dtIPJXhb
         gVfMse9Y3I3WK3iCrEacIX8PYnebxMSUcce0R/yyAl5W+asg65Qk4cz2NQgiCwiXFFzc
         dfqYggcjFJ4ukFkQviZcI0xTPn+aSSwDPWh4uOlldVOFlIrl5g4ZzWN4WDVYJimf2Mvw
         3WWb5zRxYTGonjJtBZhm7NqxOKs2ET0wN62VkvmAHnmmNvIfaWWhZJOIhGsoRVqLJIAK
         dcVg==
X-Forwarded-Encrypted: i=1; AHgh+RoqaxfwOU5s5XkmX7E/WY/O9pq5VNTEn3wmz0YLuVdv+qdHH7t8HErko1YbSz1bPruef7dccmtnBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpnTwN0YoxI6PiQ6KjizT3A3/t0qtN5mt4sATZ+704M785V1fr
	cN8Gn2cl3k46OrC9a+GQaTZW9qa7ThTB0RSDw0VLy5sqNp7prq0c9b7RQY2nBvNBlg==
X-Gm-Gg: AfdE7cky1LP7nNFXZ7pyv3Y2yM+ObYh8WE79fIDaZmMf+G2GUPaVT5a1SaG1opbTJfi
	9JZng+WzwTKLiBuEtqKFxWq4K/9rDgG0wz4Z8lu0fXkr0h1h3W1mAESzdPwmla5Rx1c3pYXPJiF
	C4R4Ntc0pm+8bcVX3nhqeABtLS5vIHflyeUVZkRg4VP4BMcZO3qs3Sfudooz6qFeM/zztnBb5W+
	W15x0HllWxjUyGkBZF5IQXilM/Z+FOvQ84IV/UFNadajkMT4+2WseiZ6Y01tuZRTMm7srmUgut/
	9CFl4/ORtepDm9S5itVgOM924eNZrKTMV7y2Qf7UpJ+AlPi8HCk/Sh6F6DIYRsF8R/eDaYbQx4z
	hoC27OfHkEggj3TwCvYW5PSsbWwRvomHBCe21CyuyhqZIQxcxXHvvJQIyJlbWq3BbhRokWT4Euo
	C81He2e5PMUIO2w5SGi8yQVhf3qi6WbdxvB1DW9hV4bGN1aS98QCgRRcKwMRZITD9X58Q=
X-Received: by 2002:a05:600c:6749:b0:493:edde:54c8 with SMTP id 5b1f17b1804b1-493f8885b92mr105859105e9.8.1783957196262;
        Mon, 13 Jul 2026 08:39:56 -0700 (PDT)
Received: from horizon.localdomain ([150.228.38.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32c65asm3135735e9.14.2026.07.13.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:55 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Evan Green <evgreen@chromium.org>,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [RFC PATCH 3/3] PM: hibernate: document encrypted snapshot seed ABI
Date: Mon, 13 Jul 2026 16:39:50 +0100
Message-ID: <ed4279610044d0a650ef13f1953b079cd7a3e569.1783956835.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783956835.git.sean@starlabs.systems>
References: <cover.1783956835.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the write-only snapshot_seed sysfs file and update the userspace
snapshot interface text to describe the opaque wrapped-key flow used by
encrypted hibernation.

Tested with a final-tree W=1 object build of kernel/power/snapenc.o,
kernel/power/hibernate.o, and kernel/power/user.o.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 Documentation/ABI/testing/sysfs-power   | 14 ++++++++++++++
 Documentation/power/userland-swsusp.rst | 15 +++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index d38da077905a..57f6063ef88c 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -470,3 +470,17 @@ Description:
 
                 Minimum value: 1
                 Default value: 3
+
+What:		/sys/power/snapshot_seed
+Date:		July 2026
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Write-only file present when CONFIG_ENCRYPTED_HIBERNATION=y.
+
+		Trusted early userspace writes a 32-byte seed, encoded as
+		64 hexadecimal characters plus an optional newline, before
+		enabling encrypted userspace hibernation snapshots.
+
+		The first successful write locks the seed until the next boot.
+		Writing the same seed again succeeds. Writing a different seed
+		fails with EPERM.
diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
index 282e01d2fe61..777518ac591d 100644
--- a/Documentation/power/userland-swsusp.rst
+++ b/Documentation/power/userland-swsusp.rst
@@ -116,12 +116,15 @@ SNAPSHOT_S2RAM
 	its state on the basis of the saved suspend image otherwise)
 
 SNAPSHOT_ENABLE_ENCRYPTION
-	Enables encryption of the hibernate image within the kernel. Upon suspend
-	(ie when the snapshot device was opened for reading), returns a blob
-	representing the random encryption key the kernel created to encrypt the
-	hibernate image with. Upon resume (ie when the snapshot device was opened
-	for writing), receives a blob from usermode containing the key material
-	previously returned during hibernate.
+	Enables encryption of the hibernate image within the kernel. Trusted
+	early userspace must write the 32-byte snapshot encryption seed to
+	/sys/power/snapshot_seed before calling this ioctl. Upon suspend
+	(ie when the snapshot device was opened for reading), this ioctl returns
+	an opaque wrapped key blob and the starting nonce. Upon resume (ie when
+	the snapshot device was opened for writing), this ioctl receives the
+	same blob and nonce from usermode after the same seed has been written
+	to /sys/power/snapshot_seed. The plaintext image key is generated and
+	unwrapped inside the kernel.
 
 SNAPSHOT_SET_USER_KEY
 	Mixes additional user key material into the data portion of an encrypted
-- 
2.53.0

