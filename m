Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493028;
	b=g8BiRO2iMuap9blVe0TExyA7cmvj57Ho8T5zY8h3rFruqgMEHTwWn9XDl0pPrvB4owfq
	 m/gnIQoWaiTmKAbC/AbdOlc+pBvHGA1CBzmFhP5bDmQJIMC5onJ80DzRiwQOvKYZPan7R
	 FTQdLmapaJwjkrRnvKrVHtvQrGoytZfpkerAZmTU0cvFikA5rgfWUMBTpoDJJj0fQDm+9
	 5K5OVo/kvR8SSDxNS70f0DlHhtWNoXPYMDwoOJMjb47e77QBD0cZHJ9w0s5TWcQPefipx
	 h1h7BnWScOKUGwbZ2JOzR50c4LHFtYPD5vFyxe05fGvwDAWiLnKrzczCAb5CP3t0zxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qrF09GR+ihkQ4thcmIGrsAzK57Wx7VRqM+yLsEJ4p3o=;
	b=KxUeTqcDanL+uNNga+Kx/lUldU5k+XT80Ht4pwQgUuR4ZT9KAQqsL5C1J92Nq8PAsyCU
	 nROdxXGuJVbyUKtX0Hy01Y91xYmYxpV0ta0LZudhSDuPJZUiES0DxvwGgYTOjodrO0sJZ
	 YGr1iRULxkFLZLIdPBvV3rfjTRneA2cdhFfMP79nAGReMSb2NPtLxyLa5LU47w/98vOwM
	 PAO+1nNTeK409MC4mV3fMpMT0lNCjl4/LS/dAHZNp/uMdwtXKzeRZ5uquaCvzFPu0zX6T
	 F+MheE+GbMFfOCe/SHE9DrI/BBQPQmIH6SA4CwWHTTt6ILDTCxNuLJjtHcLmu9n76kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BUc/oAiX";
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12097606A335
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12097606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BUc/oAiX
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so5353207a12.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493026; x=1795097826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qrF09GR+ihkQ4thcmIGrsAzK57Wx7VRqM+yLsEJ4p3o=;
        b=BUc/oAiX8fnhkktLnZFvgLNatm2C/o2PyMn9TAlcNkOqWquh+iDGcpCDApB4TUPIJe
         szU1ye7M0VlqedHpuHo/UjjBFRdDNznR8n86L+9cZfulBPjCPrQtsGj7cS9Jew+uiz/j
         BPM2QVXwGTts7clvGUtG+K8M67nUK8uC0Cy7JTV+R5igmEOwF9B6Ay83mcEKDbgyCzU8
         0ba3S1RFeRz9kOPxUzfcbou1wF6kupEGcm1Essy2qdmZWVGY/Xt6wD9LDnb1R/zYFUWf
         G+vAbannvJsIZA29ZLhmQMtaQPfFA7Irx7D2rAaAr+v3W5Di5r++BfmcU77pSyYkI8e7
         hmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493026; x=1795097826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrF09GR+ihkQ4thcmIGrsAzK57Wx7VRqM+yLsEJ4p3o=;
        b=aAfmHc+7svPSv5y1sIvOIJdI340ngSjCP7sy6sEFZkAOb43tcURhHuaaHg2LhxCdJv
         PLuWMGvxrTQiJJM7+nwtRovO/V18/eENyvoSU7uViStg6wyL+tKHDEH5M0LvulZJe6mH
         Vb39ATDpe7oDw/ly1cOeWheO7qAyqA/TRE8Xu1TVsPXbe93Dm1n2fQjq83lqlEnFePU5
         v8bwqPdfa1wQRM7IZ8dttA9LU9h7RbwbYBmr1pNEi5yo6+ip9SEKBqBgmr/qjWdxeX7L
         W9QSeEwkDKeiF56GzvbW0XB7JTzIIGP5sjYf4L1HqP8QeYr8ts1B9jO9tle5W9HT22Ca
         29qA==
X-Forwarded-Encrypted: i=1; AL+hErF0tE7UhvK0Wtn0Ml4Q7MWp086UvVwYvyUQO8dZYeSYPvQJ3nah/1e2b+Bi9+d/sDlvT7pqtgzZng==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CV+zt8A49cP3w2V+pEWj2c0nMW08OoOCyxWcn1P26+4X+LNYp
	ns4K8Q0XHuEt6bMO4wF/NwXHuW9bh9MT/vAvhi6FL67hF4zQiJjbhsmN
X-Gm-Gg: AYBFou1htacYgofIKuuPkHcsg3YIog/gp34GSNdjhkhym/NbrQOVLEJFryjo9HIzApR
	HRoySBes34puqO9Y+aptjacQOqCoTsJqZWflyEss/Nxin9UIoBBbhe/Pex7zcWJhNPC5sSgb1jZ
	pvl8EXr+Yzh8zlubQz8OR4P7+tzhNmCTyYIrZEtbcKbBqgi8v9K0C1HZg7jc4eBFL1i+5K6vnnT
	JzOJySzAkyMyXd92Mwr2oH3ot2PLXapth7f/KiFAKiP2jkYx0FfEipTpCJcyGhcSiVYtnXftzsL
	aKcUAR5we8d2CkpzbEUPtoIyLg5RXe5I/UxjSf07pLrKL0I3/N41fMkJmQLZWXP7T44KKEKwwEi
	KvVx0jhmAwsF+ZztS9N3LDQzFcFrf7fH4jKjwA6qrr9YsYu1AhMd81+j7NN3+Fu3N71LG85KRuK
	/cSZhZ7xS7ywciYk2C4EuJ4nJvxm3RvZZOCDNjI6WneTBGgl8kc+iSE0QND1HYIzLgInxVpoyMO
	Gj0qt5fF+lWaAa3jMx36/7glDxJsJJutuVJU1/S1wG3h2W0L3u+gbvsedhYStnkKgDeKxZ+JcwF
	TK23WIsg7xUIXrNW4N1EAyn1dqFjS1ZAdmm44sWX7RxsQgpUyYR8a1NFQKVISrtMxX09YVZCchL
	Lxzc8frS6/9l8kPEltD4ef6apMF+rwhYJsi/exdVkyRh52IOMQD600XlPRqPKDZiDAKmIHa0cJT
	haiahFW1hYaSENbsJgaBRhBgt7a3/U5QDaQuY8DZF5mDzFUznkcg==
X-Received: by 2002:a17:906:9fc4:b0:c41:5a0e:3356 with SMTP id a640c23a62f3a-c5066cf82b8mr489669866b.41.1794493026263;
        Thu, 12 Nov 2026 06:17:06 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm360156466b.16.2026.11.12.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:17:05 -0800 (PST)
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
Subject: [PATCH v3 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Thu, 12 Nov 2026 15:17:00 +0100
Message-ID: <cover.1794479968.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series refuses splice on writable opens of /sys/power/resume and
gives those opens separate lockdep classes, as Tejun suggested in the
v1 discussion.

The reported cycle is assembled from two operations. Splice into an
ordinary writable kernfs file records pipe->mutex before of->mutex. A
normal write to /sys/power/resume records of->mutex before the autofs
pipe locks when resume_store() resolves a relative path.

Patch 1 adds SYSFS_NO_SPLICE and kernfs_ops->no_splice. Writable opens
of a marked file refuse both splice directions. Their of->mutex and
seq_file lock use separate classes. Read-only opens retain splice
support.

Patch 2 marks /sys/power/resume. Normal reads and writes stay unchanged,
including a write which resolves a relative path through autofs. Rafael
acked it to go together with patch 1.

Other stores also look up paths. They remain outside this minimal series
and can be marked in follow-up patches.

Tested on v7.4-rc1 in a QEMU guest with the syzbot kernel config.
Without the series, the C and syz reproducers trigger the reported
lockdep cycle, and a splice from the autofs daemon pipe into
/sys/power/resume deadlocks. With the series, neither reproducer
triggers a lockdep report although autofs receives the same requests,
and that splice fails with EINVAL. Plain reads and writes of
/sys/power/resume, read-only splice and splice on other sysfs and
cgroup files work as before.

v3:
- Rename SYSFS_LOOKUP and ->may_lookup to SYSFS_NO_SPLICE and
  ->no_splice (Tejun).
- Drop the mmap, prealloc and binary attribute checks (Tejun).
- Add Rafael's Acked-by to patch 2.

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

v2: https://lore.kernel.org/r/cover.1793715774.git.krystianmkaniewski@gmail.com
v1: https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.com

Krystian Kaniewski (2):
  kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice on writable opens
  PM: hibernate: refuse splice on /sys/power/resume

 fs/kernfs/file.c         | 46 +++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c          | 18 ++++++++++++++++
 fs/sysfs/group.c         |  4 ++--
 include/linux/kernfs.h   |  9 ++++++++
 include/linux/sysfs.h    | 22 +++++++++++++------
 kernel/power/hibernate.c |  3 ++-
 6 files changed, 90 insertions(+), 12 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

