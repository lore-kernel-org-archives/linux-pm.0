Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0546AED1
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838489; cv=none; b=h8BdXcDsz9z2ZaLpoTpmg4jUKVkpcWMLCGiFww8e3LmegrprWO2nSy8Tzj51EstRbX0BBhxaAY+Le0e4rhgiob8NgQmphyAJs7NrIFHl1F2RtOvSf/x31lF4RpSOqaE9pB/nyAzFqwDN3Rke5siPFljCdjBor13jlRvZJaZPaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838489; c=relaxed/simple;
	bh=YAY85gc1J7l4pem+Ynb5YEtvC9qyhSgj+8jFccC3U1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ7KIsH+ezLN3UtPXmkOnIZpOzStoBq8pLr07pu0mPL0ZQsLV/gFS57a+6CMZXtaA1F/tko9ufUGpRpHPTUmRaS607op9BX1/fThTkrs0jBSQEpwltBfyw6j5sDEThTjqJSG4haOw4yzZeM0C20DL/T2ZOII9Kx+AqWxMTWxFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=TmhBfOkw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="TmhBfOkw"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso14684985e9.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785838485; x=1786443285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjThVuiPrln2+ib/P2lXqoKMuHizlqJXK8kVkecnjrE=;
        b=TmhBfOkw/s7grKESu166inWttGlniDjxJf2EATHZbsEEuh7pF0oUxim8gP5tMPWA0n
         UfMhy3NGtqvyRtZXFFOqruvKjzPB0Me3pC/rjrebzO4vwPGCEtdATlQv7hrzIEAdsWG5
         Y5n498+moByVZLtxQi+mJ6TF3j+DpA4fdlGiXnE/Ws/TEHVxVqtp4FkJKnWkJhMtWvgN
         NZ+Yj3LD4RAI6cMEVvWkn5vjZvzP+hNLAD9AVbPESWHBFr2UNNEt2KHZzdJ6GZ5XH33e
         zjXPnJvriJS8I5xc26cRZyHOzBlVpxIZQEMwxi0KbYO7Fqrw0tgnTI5MNExAX0QfeVsj
         3glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838485; x=1786443285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xjThVuiPrln2+ib/P2lXqoKMuHizlqJXK8kVkecnjrE=;
        b=Ug2J7faSYz/cNtmtiq5Bisvy5GGXqfPn6ceYCWRPHkWQHouYyoH48255aOV7xrJNb/
         1vpwQ5glpzhn2ngmmaE7gfqmjr7709UBAvDUivB9mECIjXdPmZPFlseMKbtCI69Pm+uF
         iTsQ9vUs/Lxi3JQHfTswSWJXxGg19ELIdSE+F/SUppgoN6n+NttaHF5HASF8ZUfEGm5m
         ddpM0TBlN4I7kLORk29KcMUEJqbfxajHuiwd66M8pQrfkfl1L7htalunaFX46DHqpLBJ
         4ac39RvZafuoJpwAKczqMM4C/eZNPeiu1YhHkTC8XXkd2plZDzi89Vjzyz/z3woXQHcd
         TwmA==
X-Gm-Message-State: AOJu0YwzSHYmcN/aQs/RUQfaGKdKf+vj5ETyogISE+u6i52pfQPObYV3
	7SMljKWIhgfqY/nY7DoFdxDuIl3nvHGcfc7/IDEJKpaVZ03yjfRimuAIYTRzN+HaebvIXcnpBj+
	URMshsOE5
X-Gm-Gg: AR+sD12niJxDgjKnH6vLFx+edzEVUN04SezpYKLqby662fAvG6KvyD82Q+V4URosBnQ
	VoEBNkwdZk7VD+0Bv96vO/C5oIhs/8IIo+jAHtwlaagQ8jBp9LkSx+43CDcxVRUD6yKLBUeSuXr
	U9ux4Ddt4IkUF3IYGgvydMFZ+j8hgRGofpJi7dzAwoeGT2wqFLtAeiM/g2AEZtYCHUAhJcf56it
	Aibhx2KGQRMPwyfOuN+84El7AOmhl1rJwEEaZIg5OeQZhJ5U3TdiX8+odPPc+DWgwFn75Qi5SNQ
	BUaQKQsm7bBBSUgPxv0lEOYIK2B/j0ENkYG6TGittEuxlt1eEyP67BMKfD/3wArr2DJfgVcm0Kn
	t+ZcXKsjNweqOu5Sw/0IIoQycHk6er1rKrcZZjHd1NKXvHSko415BGOLy4mMcrgWKctA0QUhU/o
	+TvK/6cN5JIcjyVcWcIop3ZNiOZyRkKnv86al6/LmsZnEgcAKOsMRd/bvXewuQ9YkxwVQhpXsE1
	Czd73FhsJ8rI14PksjAkZEoPGheDtBq
X-Received: by 2002:a05:600c:564b:b0:495:52dc:73a9 with SMTP id 5b1f17b1804b1-4980c675370mr239950485e9.11.1785838485451;
        Tue, 04 Aug 2026 03:14:45 -0700 (PDT)
Received: from horizon.localdomain ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7bf4sm73248805e9.11.2026.08.04.03.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:14:45 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/4] PM: hibernate: document encrypted snapshot seed ABI
Date: Tue,  4 Aug 2026 11:14:36 +0100
Message-ID: <1f5b50e20b857dfa66f9c5d7c3df41738706140b.1785838445.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785838445.git.sean@starlabs.systems>
References: <cover.1785838445.git.sean@starlabs.systems>
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
