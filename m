Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177585;
	b=C28AtfE3BRdqFFgvL+N0TFVr29cHBmDaV27FtXHOc8IiG/LwqbRlG+MuHG9BOV7dDbZV
	 r1IDBKdsQ7MC55Lc4yXjNdHxs1E1z44GCZaIpNn6tViNaj/3jvBJeUX1UHWbnlFV5Aw5i
	 xC9q6y5lmAPQqUHZBRogl8MgsyFV1zXOymE3xGRlO7nI+zAPvz34OVFMl1t/iGSZEXVDW
	 HMFqRN1HSXHkozVk9gv3Y9Aeqli6OW7Bw0IEh/6KuzAhymJsmHIvAnNjETiXmBnCW+HE+
	 RJBX5X5KZSsYXu5NaSxln0Ue6gx5/aAM5RSB27GkHn4tWcy45OFvwQJ1hsvQT1BEYoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
	b=fGZRfPh0DHjiHQtXJPDaAwGtkFtUTfdYJwM/sl4OtDV+HTlcBOd2DWqenAn5LXpHrUqz
	 0s8tH4P9O7GDI97MambIXMWNPuq0QoTvRJG4xPTT04lAP7clOGiX+2KHDozWjuV7m1qJm
	 Xk7tBwvfjESZz0ZTbxxolBn6cM+WNVml3ViWl7O12gqH4exf6PuN/vmcOPjHgu0GvtFOB
	 FcQNvxfm+DenMuiUt/raXs540T+gTFhAOX/+EeiegcfWVL9GySz65kOVlCm+PZrrBRqp1
	 TLF73mZ+oux5Q9cUge5GWdWbQTx2yhLDiGv4ehihTA3O6PjchcQsMHEnDzMRv9wjJGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F2fR56c8;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D7606D82C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 22:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 541D7606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F2fR56c8
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b0d864826cso1320318c88.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177585; x=1794782385; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=F2fR56c8EK+/NNiWwKnUp03MHEuPZjp85TN676tB/7q/inQJoVFf6SD6wn2QHLXNGH
         YAu1WTw9vb77lT6Q13keSswKQp4O4Sy20/xdZyYkYAQwMjKOEa/FQIADFabel8Mi0qmm
         zfu/coM7V+RQVFmzTw8CAfNNU9JxsSXdLiz8JupxtxRWOfv//oilbImCZKZENLJVpE20
         /5ndXGNz6cnPJaMF0bOPdL771Um9KJblXiPawXOPJb5PuqW4UVbtoCtL2CMXsRAwTsFT
         8A8fmxZSRi1L6WtT9m6cVcvIfFLbHm/Z+d9ETzLC/ysoQFeL7nXMTH5T1Ie4mtHDgo3w
         M4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177585; x=1794782385;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kX4Ed3A+P912IudIYmkHnIS6SHmJhWXUKLWP4ZNJ5k=;
        b=W41rqkEUUJ6tmoiEcZszfwCm0qYE325x8CtcWKPgSRDR68uLWwPjQJZrJErBCMZ00J
         +a65pZE1R43qgjAcmBdt1aT9/57kwZ5VaSexElMaZFUC3MbfX81iRW9NEz2utqBWWEUT
         3u8x3GA9Z/H/iiesdwMim6BjlK8R6M5PMoYRcZ8lXMWYMbWnDNYU5yiWL2kXna0pqycY
         yNrKvF5WCWkoM8/zTFEwibnhkVmG5dX5t9HH/69xgfLLkWAVLqGPNNe9EWnmj8OKjBkW
         MxzsVWlCOoAH8vs2Ar1TvI68HIc5Hq5IMCir/MdoM9FJUXdNk2Tbs18Bv79UIGF7Zzy5
         Y63Q==
X-Forwarded-Encrypted: i=1; AL+hErHR2FZzi80kVQB01djpQhlUuZE9of/VzDNuM7cT/g286V9sae1mlwFpm28JSha9MAvecSIhAZfPzg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Kgg/hXDIpXq1A5v4xDsN4zC2DC8KEDXV09/pqWUbT3F/ZgX08
	BPZ9itKBOE8TbMfcmJNdjeaKYwWMJpxFHdMuRGOy0PEQnkNMTcGL+gJ4W+gD6w/81LoH0p/bMLe
	1mDQO6YRcyg==
X-Received: from dlad1.prod.google.com ([2002:a05:701b:2201:b0:1b2:6421:f4fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea8a:b0:163:bee9:b250
 with SMTP id a92af1059eb24-1b39fedbec2mr3348910c88.22.1794177583902; Sun, 08
 Nov 2026 14:39:43 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:06 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-3-irogers@google.com>
Subject: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog

