Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836351;
	b=AXSQ4NtQrk6eN1qPVk+x2TSh7i3xyrdAKJPcZG/ALaN2pAsnzmeDOcLsZebKNUSUuBgW
	 tM8lTnxCxxrTtYn3aqY+IkpjaYLKVJq5sr/ZEuO00Xy1/q0iF4DWcaZ69jCJ9vHo1x4Tx
	 rC3x6MF1euYP6eG091XOAfEeKcmE7Sivp480/5iZHaOemZJdSbpjYGs8zjkGhylofKPIa
	 CY5Z9GQmZT2Zk5scyhyRl2zb9YPjxCRqGMHw9j6xJqQV3g2QuZaVqnxIAMacQ+aqaWRL5
	 CH0SguCot6mbuSVDQZFWvmiARa6jsGZ6BgYczEHbp6tF9EURmjueCl0wJLsws4oVcHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0RCY8SlJF1fUzfPYkjMVeM8fsGJwzoRlEM+dvS8w5/M=;
	b=D+0TnF5nPZHI9G+PtbIU/nVg/dAXuH9C66jSl+fGbpniLATILV99vNszAi0B/3NDBF+C
	 PJWlkmhtIRFf+P78Exrx8e92SqkiozGjWvEqXkPfGBy7mpEzrVzgkvCD58+fdhsXLnnPN
	 5etEBUggkuXprs+5FHFHuwiW4fsriCeortn+UzdlgP3Gu30UCU4i94Zj2nQpSbLo1PjeD
	 rQ3g9C5Gv2AaW02DXabBPNrYI1EhoxhzFfGD75sySWEF9w0/8HQ4mBVcfsl8HUvwU9GCF
	 1tv6xYYXDr9cxRJGvWazTTJw/6fPEuK1JEAUGQpALj8B7u06LSRgeRIAdAqXnzPrL2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tuyte0XH;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EE606A89C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 370EE606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tuyte0XH
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso104502466b.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 05:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836349; x=1795441149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RCY8SlJF1fUzfPYkjMVeM8fsGJwzoRlEM+dvS8w5/M=;
        b=tuyte0XHN9vejcqK4l0//VkSntgcv4oWwWa0+sUtmOsAc0uHuCz+B4sf8XJCEQ6lHt
         F6yBmnGoSO4NP/5dfth7qg0DEgKkhdqXx18qjFXlQY91q9VNCaUQewRO+y8vhGd2cj2c
         vjmZB+Pyqu7ss+Z5WvUDDHZMlwoLK1q3FS2dJkkPUlsYs6LBLt10f0raz9lgtflmdL4I
         ALvIZLXPWkEifTnl46MvaDyQMGiuvjHlty1EKX+42GDpiPRYqkKuFKOcceVEWJzmA0tw
         P/4dGFSBL0fP+wJAZlzcN+HfOW7BoGOwZXy7urGRN1aJV8LeLPVi37aepSTtD+UVcVOH
         wbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836349; x=1795441149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RCY8SlJF1fUzfPYkjMVeM8fsGJwzoRlEM+dvS8w5/M=;
        b=HCDvbaaE7WTkUMkcLKuHDEkzQIMr5LRFPq9yT9XQrUgCuHGXcLf0tXTYSMcv7RF1RF
         yXDsu8gChglQLgN27J3eApBgtEvmzHHTYY0QcC87XmvSHImY7YkFFfpWqCq75B5SvE4f
         tsmSzCS94C8K1sKDI0v23CR3WEsRs5OeOtv66uTctxpgVDJWuPA2gBWnZ9GBHo6UGnEV
         qRYlQS41chRsr7fnUDy+y8nv9kCevQQf8SLTdAyZRvFiVf4zJAtBsOE8gyBvg0ntadX7
         GViCCRimkH3LBtYpMBcKtBFpzr0jERHDGGDVzSdloaXEEsHkX+XCFKTqQx3R88dXnCJ0
         /CQA==
X-Forwarded-Encrypted: i=1; AL+hErET0188dIfNB5gX7vXlhYH1+B0rVQCqBLugqfakPXCT9OQhpALyyE12Z3O+xxqtNR5GTmfPgXqP6w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/OMOWjy2/gsS6frdIuKwV0/aqvEKx5/FTWjkUtEVJv3WC1TEJZ
	JE4HRE+4MZ3ZTol6+ojv4MCbbgIA4DyU4O72vOT8WfWs1gY+JKspOnvB
X-Gm-Gg: AYBFou2MDBI3H6PeqG1jWP28XeDLYyimpHhBNzyU9QsrwGYPf82oL33JjHGevMUspGj
	7c651lTjhMQ1BEwH+xcesY27qUitAgSF1Znn6O3jUqendjt6s+cP99nQaSdrcG8QmffGNDlq4Us
	GrfnhsAvs8bTOKiz7LZycj5qwob5TkNuIRCyngSYeOFc2CIy3EuLrLXjfhv5tnBLa1InOKYld23
	3dNCozESwezA4BZIhvxkkX2BFcKe0W20LLbNDU2ji6LIL7XjMWtM2V8zH5UkzSrnGMNtqMkbdI+
	UG19Rprreqtjh26CmAjwFclebPpnPX2eh93Y3xUWKor1JXLe28WNlykMIjB11+JV3iBFtZJCknN
	/0r1Rht9FtiFnx6kzJkVO1hdqEU1CmuKpcAuXpvMNoNon8pLf6/O4LK+S7UWi46ZSFfEJA35H18
	B15NrmkCEyCtzny/HjUDBJIS5tCnoGNERvHCwoEIMDpwzEjGNo4djxMLaepXeX2PmbV2n2IaicF
	qp3RJYGZQulxQurG+8c3csoqgbBd1d3nGqplj2PZhUKiRUVuB+cCO+at8mVFF/6+AdY0/YFT1m0
	x/4Azrfc/n+8OCMLDQrw7dBBHgMxJESH6wtff+AOYpj39dFTBTcqvDtRzgQqCOls18W4YMEXT9X
	8tpoKFlwGHIIoQdgMsXQs4AvdhuPjDRM4iZAPWuRcbfAG+bpB/oBPLenxsUNwy7mXRUH7gPG5YA
	GS4dSxnKIMIMJwNStE3hO8386p7bdRe6yccr8xFcAQgMTlVdZCtJZ+AMpJNmNO4k59yCqCJdJO9
	w==
X-Received: by 2002:a17:907:2d1e:b0:c4d:28c7:eb21 with SMTP id a640c23a62f3a-c50963967fcmr876042966b.29.1794836349492;
        Mon, 16 Nov 2026 05:39:09 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50e9b2b5fasm61267066b.35.2026.11.16.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:39:09 -0800 (PST)
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
Subject: [PATCH v4 2/2] PM: hibernate: refuse splice on /sys/power/resume
Date: Mon, 16 Nov 2026 14:39:03 +0100
Message-ID: <20261116133903.400202-3-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
References: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
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
SYSFS_NO_SPLICE so that its opens refuse splice. Writable opens also
use lockdep classes of their own. Plain read() and write() keep their
behavior.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v4:
- Update the description for splice refusal on read-only opens.
- The code is unchanged, so Rafael's Acked-by is kept. With patch 1,
  read-only opens of the file now refuse splice as well.

v3:
- Use __ATTR_NO_SPLICE after the rename in patch 1. No other change,
  so Rafael's Acked-by was kept.

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

