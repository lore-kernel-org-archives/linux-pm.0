Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493030;
	b=unlZOhx5sHnB7oz1L33xhHi7Urof1getlY+QY4ldfx9ldsrstmm9pjFXG47crz50ZkR5
	 zUnXRkZlC2kreYne2nFVoYCN6e+pkAXr95K4/grNPjzmRa80CCjgMYi2X9u2bIrhu72ZK
	 Dg4veKljsyoIFgj7H6vVZ/WOCZPwICX2hQ3cLFY67FDMibIpn7FNbKj5IETSv/2urNV4J
	 bVm8nP0p/FR+U/OaNhu25gh6ocFdLviwUd6vzUqInSIgR7rmLUSXuoh0VTU2k+Gx/H6/N
	 cooyHLYjiBLsjIi0nFwwSh3If5jMr6eI6h/Od05MVAAoi4NAk1zwer6Yoh8Iav+MZ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=W7IVuM4gM5kY+VlCkjQIKxVNfU8qqC+cV2NO5JrfOD8=;
	b=jyv4MqpHXBkEhZmtASx6tJ96uuu5xNVow8k7oZzpuF3VJPE535B/4w8spi3yY7x4kAac
	 TRj0eIh5ryt98vUHkV9Vq0M8LsuDpwdpqmnZCH4CD6pyPfAQm9ZNjD/O4RiuoboJss+iD
	 zNiwRNcjuS0V9fojQeak+d6eDGprqLngepoRKRHUfekXeYmMW0SIMJw7sMYLghk1RD9NW
	 tvAOy1NgD32nSFWTeP2SedP0+J5kaOP8m1HK6UfxkXDUVgGHKa//dI+Q46qN4bC/iFURy
	 l5R/l289TS8tqNwVa9PqNW+T2RZ/lGztgrshuioDuotI18mb6rCe9zw/yHcz79t7pVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBbUcmC3;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD960A380E
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EAD960A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBbUcmC3
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4cdc606b47so680852266b.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493029; x=1795097829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7IVuM4gM5kY+VlCkjQIKxVNfU8qqC+cV2NO5JrfOD8=;
        b=FBbUcmC3TkNMVh+tg9wiyedlSSvXNi3Z9406WpBziBrpIKlDlj5NNHzZZb1XcwSYkF
         x7+ZTkVfFCUyXjZoWOHRfjpzVtW6WtERVZegkoyX+BBhtCtHf6LctV6VsNgCgGV0Dh25
         bFus9i1wmGquJjtQiDSmWBBR4EvByqHrRHxYbuubocgxgGuB/V/akZFJ2MsZtV334UEe
         u5tmhEk4ZC+S10MzkDJXenSEKFawwFu0DPyRD1pp99MCJasPPMJ7cAmcj+NYoxwpxxca
         Xxlmv7CIj6qklZGD/w57xn370NWyL4vrjhTqvhBUvkfnPoXmRS1R1yOz+snKU5dVDUKS
         v9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493029; x=1795097829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7IVuM4gM5kY+VlCkjQIKxVNfU8qqC+cV2NO5JrfOD8=;
        b=dBVM58fndQwdIsPwrIm9OkXgBImID6YhEljPdCpH9BcZr/1srz1s/cxIuyAyYBHn/m
         jmosJS2sQ8+fUYBqrvIbAESJOZi2AM+/tRusMjc23prB0OyfIeuleHZHd7sUniwwvqDe
         a3l4H9MrMkgNxtNcsEmsirM3Hh49E73cHuQeQuzj+A7Kn4zDahB1BNNvWceip/iWE4u6
         rXGgprY51bObrRB0ONzt0UarxLdXRuFcjJYK0SBXkZsSS6JwZXmgUUjPwhl5xAncBH8b
         UHGq99Fdk505BkPEDx46SojvPyhG3yxfBLcGYYGLjO/x2l1sue0FspGjc7H4MUWMAqwo
         uVMg==
X-Forwarded-Encrypted: i=1; AL+hErG73e+3QZywMoD+sSwiBv+lAJw1Bv9vCvLYMMaqLU2/GPUC8SccluakBJubNRk5YYnr44jHPzeMAg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8OEZ3c9Yb/WGHHzxevUcKNhHS8MRkUbxMMAJeP0ibwsjhKuL5a
	VQYFV+koxZbIRBJwy0eGoon+2vI3tl0vPOb7VMXC+ZVm8DxujywobTNF
X-Gm-Gg: AYBFou2/efptg7N/sVLK65J3TNy6pziIizCw0Ssli9I6Kjo3ZZH2UypvF6xnf7ijyD6
	B/ZXEtikJHGSZj4VHmBDzQQlOTF922NXBp+YpiVps25tseYCeyAG+eDNALwfax7l99MKqZEo6cA
	ioDAgtLzE1dP4BCq1yM5gwUR4wPEyyx6jhlulfispYpoYOZHWbLqzCZATx1stmeoYu4YWCZqSbn
	Uge5GIiN71HtBvyUxs+9VVzU8sZW4oeetL+TJI6wNg2uwrGdIXrVGK5ZJAGIBVPud5WKsw/SyW/
	407gU0B23K6tGFSQbaqVU4cjE5zNZgf3p43iUI9oVHgt6wYNzpBxz+KZTjrKfQ3FvDaZ8dJYz/b
	i3/SKGpaM3JHa+ADgegpKuJT4zsbimgqacOtnUhWhopbSaXFSyv+q14QC40RO4RK7LJ3NvvFr1U
	MO/APHafsQaw5ZBHdFMPoSSTM8D7wWw49fOZxT/bOjvcE6VTah5kQ84o9k6g5efrf2nRu1mB1TC
	NGbUwHllEkj1FlqQJx2lSpx8n/wKE11+NY3R9LNqm57uJrIwTa2lJdkUMtxS4/BF+Q5xgOqhdDr
	WOxIvCL9MDO6O0k9tGaUjt4G2n3sSgYQv5Vw+HJfQadu87VQF/GGIxXW9lyVDcI4pbCJI5jiy6B
	NAjbqaQZvQOQStXQ84GoArtyQ0XT61Rgl+IUDsG3uB9sYAe41oB7jTxkVSFPUJUsT/3Vyye3nvy
	uqgMIWtVPtOmZkxG1ZnL2uXnu6MWiUtk3rR5HOpDWbKpLZ8CY3AWLp0bcz0Jyuxgvhc1OyX/4=
X-Received: by 2002:a17:907:3f24:b0:c2e:4292:d27e with SMTP id a640c23a62f3a-c5066ae263fmr504242866b.22.1794493028760;
        Thu, 12 Nov 2026 06:17:08 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm360156466b.16.2026.11.12.06.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:17:08 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH v3 2/2] PM: hibernate: refuse splice on /sys/power/resume
Date: Thu, 12 Nov 2026 15:17:02 +0100
Message-ID: <aae0f774a25c8e2048c09919d3b6b841e2b1c1dc.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794479968.git.krystianmkaniewski@gmail.com>
References: <cover.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resume_store() passes the written string to lookup_bdev() before it
tries to parse it as a device number, so the string is resolved as a
path relative to the current directory of the writer. The syzbot
reproducer writes a relative name from the root of an indirect autofs
mount. Autofs writes a mount request to its daemon pipe while kernfs
holds of->mutex. Together with a splice into a writable kernfs file,
which takes of->mutex inside a pipe mutex, lockdep reports

  Chain exists of:
    &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex

A splice from the daemon pipe into /sys/power/resume deadlocks when
the written path triggers a mount request. Mark the attribute with
SYSFS_NO_SPLICE so that its writable opens refuse splice and use lockdep
classes of their own. Plain read() and write() keep their behavior, and
read-only opens retain splice support.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v3:
- Use __ATTR_NO_SPLICE after the rename in patch 1. No other change,
  so Rafael's Acked-by is kept.

v2:
- New patch. Together with patch 1, this replaces the v1 autofs change.

 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd52..da5590ffe6cb 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1316,7 +1316,8 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return n;
 }
 
-power_attr(resume);
+static struct kobj_attribute resume_attr =
+	__ATTR_NO_SPLICE(resume, 0644, resume_show, resume_store);
 
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
-- 
2.53.0

