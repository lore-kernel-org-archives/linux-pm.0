Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717872;
	b=m/UoKYo6Pcb58O/i7mEk9UoP0kr4gnL4q2UzFCB/SPqxJonsF//ZdFBqaRVqbEwHVogE
	 Gx7cAcKBssZEpmNoABPsQtJcszeddoVmuqxsKjJwrkHcuDwcWdbyWGZkVLjLL6oXaiZau
	 QmKCTHs1O6pgC5zuLePn6QybNeVbl7gZqt42ib+QXlsWEoCQG9GW55WNAU4RrFD+jQ8y7
	 gHHY00PnhdvuN948HcmJJz34FwFDyS7cIX+90kRJrzwW3BGn3W1FlJ23shhIQyhXP0jMD
	 Jr7oFiF9q+XjDVgmgZ2JYesQRihzELDrDmWjjHrd/jeBe6YD7x+x+5gcmwql7zJ46dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pYV20rPrJp1IkxIFXdFHHE13njY6A8crxl8/hatCo5E=;
	b=eUuzmXPDAgZWbXfw+ErE1Oz0vEj+odkVmYxTGWaXM7IZMms/n7cdmL/Rss5ykS9KyQBu
	 QzowDe4kzePAeg7zSUSMlwExpkvL6ZxxPmtjNxOn68Giwr6P3aG4o3oL5rs1G8nA/a2xr
	 SCiS2TUYgiH/tRcAL0HD6p/pKkj0qYw6hViuVeQaBF3yW4MbwGPKHPVW/D2lHywHUx2jj
	 SJkUymkdAz3lga5T1LF6cwaniL/ned3QnwE30Z76GUhYLC4houfZICCdTCXhZZovdJ5B9
	 /NMELDQCqjQFN2aNZuhbIY8bJbQZ2qkjEAkg6+WKBwjAZV1+zRi4jQSNPqYYGJloMuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p6WV1j5x;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E2606BA17
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 14:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B7E2606BA17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p6WV1j5x
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so7456140a12.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717870; x=1794322670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYV20rPrJp1IkxIFXdFHHE13njY6A8crxl8/hatCo5E=;
        b=p6WV1j5xXG874wk7PArFP5ZRw4LM9P09fLU8fWNlvZNYsq6XeAmVW+axCc7BtE334Q
         OLYWFYNZHOeXzV42UcwdRCoa87g2vb1tbBgTpbUGK1GyzD1MzRv7By7b4ET93hkze+1X
         hWaAArnpALLpnihpMF53D8I7MR/Gu4mzaE5FgnJp2nfTWuRwTk0O7VE2qa6vTu/WR0ep
         kM5s/s1XbhhW4QrB6/NsxlZGJYoJdhye6EzfYDEd8hAMBHrJgLXLdMkhwSU2OPQgdpZ8
         RG2FvIWbDQmPS2kP2Vj52O9VhjSuNSZ1mpbotFjn6Kw9g1RdCaXFrdGOjAQzwfMGqo0L
         WA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717870; x=1794322670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYV20rPrJp1IkxIFXdFHHE13njY6A8crxl8/hatCo5E=;
        b=bXLu43OEDiOT+lM58CRXuiJEyo0Bc3nnjQTktJQO7OXegcqekk/Gn+Qfp3MTJdrdeD
         RXwxi0WF51iOWomkU5eST4MU0fuGTaYomBhgqKpInHIzOG0PVDuOSQqA2TBt112PwflG
         ilok4uVkIAlNN071MbCl7fyDxh9KTWJOdalmvbByK1Rqvn7hB9mptVFw+UGs1hOU+C4X
         amqFlV9qJouiZHYVFJisCPETv9UDEJ0wzx+8j1FP8qQsas4O1mCEWrMFsHOr6ScXQxjB
         STnUgCv2yalIS/dCe2UwJsp2mO1YqTsFSHhmS75D+xcxLzVZEildFtwmo4JuiHfFKBNo
         X4JA==
X-Forwarded-Encrypted: i=1; AKwUvBx+V2EYaVP7RVQAR5cz4Ndes0wv2bveMyXukUwXO2LMHtjlrz427jIRPUi8fwHyd7ov1Q8ge/yh4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/L9sSlGCV7kJ3hvUjSrskHFjrGLK5SqMujeX/2ggF0tEy3ER7V
	nIcP8yGbbbijCrnsWKU2mpW4U5D4CY0cyrLNxbylZiEtAl1EjkUCa1Ta
X-Gm-Gg: AYBFou3pwF9BZc78i4pgll2bF8VPfUaYPcFPUs2MvF47E3h/qEwmOJiJiJW3yGbddsi
	U+B95xA5epxYePufH9+lVyhHHTH00ZlUPzogBHKe6t01v9n9HI6Jo3PghIvIemNnn3W8AZ3awnM
	UjSSp1xyNh7S1nReywqZNxn4RAEbUvSB7nUOf/xhGr46jGRIzx1f3JDbXH7av0lhuQyMByK3i0j
	rEjt356PkWs6Mh2pxmePIXkJN4/kjeFl/3PlMtTrJT6FuUe+V0Th25rwqFqYl+WveNKfZ1Ge5Tt
	NTlUJ4Sc0utKTJdjkqRuMDH2DDnUpeBOZU39mA0DKo+qMJ3XG6TEnL65q/KroPC9/Edjqf1iJAB
	lLffrROFyw/XlFj4B44vqvUVb5HIy0aAThMnT/l7meOb7vOlapAtYOoC/sio1/tc0W8DDAZhDiG
	esTHyD2xl8IzEtRGdCxFg6ph3ZjJ6RH3VWDb66XwiSoVovFnpiXCLSgdD+FxIFxws/IrJF0zPVn
	fkhOKsyK8+YDzaykJF34NJpdYSclLNk5bvYCj/aoOTuMTE4oXGn9Byo0sBXWu+Q1dnW9s8K8nrC
	a5ZrUc+WAoSTyYIkrEFHhkzamoWvCJ7AI2SVFFkN5MrwrPq2uqY0woZRWKVUIKpvLZk4SUgIHRD
	/KnBvGxI8ZylWgR+X1vuHLOOUH6TuF+VLOoK6q+p8WeTsAu4s1ghBRdaM7ViTlIKHYJNWOgA1OS
	L7E3XZdDP8mWS0sDd6fbqz/+0ge3Du2A906uPFXe3BS46Ml9+E9w==
X-Received: by 2002:a17:907:7f90:b0:c49:bc1f:fe2d with SMTP id a640c23a62f3a-c4ca7a858f3mr1272502166b.28.1793717870207;
        Tue, 03 Nov 2026 06:57:50 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebec78f3sm93656366b.23.2026.11.03.06.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:57:49 -0800 (PST)
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
Subject: [PATCH v2 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Tue,  3 Nov 2026 15:57:41 +0100
Message-ID: <cover.1793715774.git.krystianmkaniewski@gmail.com>
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

Hi Tejun, Ian,

This is a narrow replacement for the earlier kernfs serialization and
autofs changes. It follows the suggestion to refuse splice only on files
whose write callback can look up arbitrary paths and to give those opens
separate lockdep classes.

The reported cycle is assembled from two operations. Splice into an
ordinary writable kernfs file records pipe->mutex before of->mutex. A normal
write to /sys/power/resume records of->mutex before the autofs pipe locks
when resume_store() resolves a relative path.

Patch 1 adds SYSFS_LOOKUP and kernfs_ops->may_lookup. Writable opens of a
marked file refuse both splice directions. Their of->mutex and seq_file lock
use separate classes. Read-only opens retain splice support.

The new property cannot be combined with mmap or preallocated buffers.
Kernfs rejects those combinations for direct callers, and sysfs rejects
SYSFS_LOOKUP together with SYSFS_PREALLOC before selecting operations.
Binary attributes do not support SYSFS_LOOKUP and reject it at creation.

Patch 2 marks /sys/power/resume. Normal reads and writes stay unchanged,
including a write which resolves a relative path through autofs.

Other stores also look up paths. They remain outside this minimal series and
can be marked in follow-up patches after the interface is accepted.

Tested on v7.4-rc1 in a QEMU guest with the syzbot kernel config.
Without the series, the C and syz reproducers trigger the reported
lockdep cycle, and a splice from the autofs daemon pipe into
/sys/power/resume deadlocks. With the series, neither reproducer
triggers a lockdep report although autofs receives the same requests,
and that splice fails with EINVAL. Plain reads and writes of
/sys/power/resume, read-only splice and splice on other sysfs and
cgroup files work as before.

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

v1: https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.com

Krystian Kaniewski (2):
  kernfs, sysfs: refuse splice on writable files that look up paths
  PM: hibernate: refuse splice on /sys/power/resume

 fs/kernfs/file.c         | 54 +++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c          | 29 +++++++++++++++++++++
 fs/sysfs/group.c         | 12 +++++++--
 include/linux/kernfs.h   | 10 ++++++++
 include/linux/sysfs.h    | 22 +++++++++++-----
 kernel/power/hibernate.c |  3 ++-
 6 files changed, 118 insertions(+), 12 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

