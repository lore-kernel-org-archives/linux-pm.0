Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116359;
	b=Jtw5KUz4q2ONTz1QPJzgsM4j8iP2Pwcx9ZlFUZFXj6qWScPbhJ24Vbzpk7VGdyPOgaW9
	 n+d9lB6Z/kE/X7VbTQhp5kig6aoSosnGclBJp0XHDj4FkxkN/cgLxcr78e7i8i+NA/3+U
	 bgqbaFcqaMzIVUqy9fv7PgchIJcC6WNuUEHNaM6LUCEIOv0v3BWCXFezYXSIhGF78WYQJ
	 Ti2XLFYRdld/RxgMYIuXr+097mtjzoMKTbAc1dISrthASoW/RbEyHK3bwXS3x+AAJrFcN
	 7K2pvv7n9KDxGCbZlu/SmX/pHgZGNs41f+D7lW2um2DheMptojmwI0tvkXZ1W6wRwLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
	b=dPfI68kJ9vHcQAWzG5futWp8Kyw4eT4sG47PZj5NoX7PTpT51HyIFjkoQKSjYlKaTBh9
	 Lz1KAG+t1ltV/6RNlkQLpc8nv6HVlPAVeL7AetxcKE/eZVki0oxDb2Q8BnChwhWmgiydW
	 zh7d9yA9Q/acl+WGS3Hlw0VN+NiYrQc/sPgaMQh7HUlUBH39W0dY/pEiVsArhF7A2AxwV
	 RtrhToYFT2NZwrfH8n6R8oBe//4iVRWk+Xz7UrOT49KISi1CdPDH4O8hEe9KL5E0tJngo
	 DEMB9ca/W1dXX0kuc+721YU8ra4y5mAx9YH60wul24pcOFQrA2i4hePRein2Pa/0huA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D+q8GpbI;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2D606A337
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 19:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A2D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D+q8GpbI
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8b32efd7ec4so136391b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116359; x=1795721159; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=D+q8GpbI4NdO7QuDoNEZVES5pOHQO240I7HDWjn1f2rrdZCPcnuN3whOXGpx0a39oF
         vy29NgI8yDcoBcybaw2tN63zB7751vVbEVZZn/LzCMjY9HBRS20Keo1KE3hlO33zrKMY
         i9rsNYFToAMc7x/wdPBJ/4VyeJTA7enjCxjXgL3JsrE7hQmAx+Yowi3dVHZ+q9R9WTsa
         Q51KrqNHmyCaoJot9RTu5s/hbSfngwHvYv+jm5vhy3LwOlq0rIMZBhXUMFuk5WVGWCJ5
         g7VSQ0AS6OPJKeceOFnEmsage9ERncv5M09VAiTQMd1EpN6QJylgkCyMQrC/nJS7o9QN
         QLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116359; x=1795721159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=SQGfTrD1C7sIgTmLOEF3HwbTMPQMliaP/8a3oRvPFcBepnSDc4BvEXAA0oxuVDDCLE
         Q1fFMdY465eWVzKTsU2cucwB0CWyPrb6qSyAiV9H5XgChVcvMAnrPFp5SUq661AKZJ0k
         8HzD5sIS7i4d2URchWgGiHNIxJoE8XnuqdVSW+rHr5ffWz8T6SO3CqE6ALx4sI5cxMtF
         OEX5S7HyGBWu1lno+c8qCCYbTHG5fdFS6CP1ZB0amr9nVoA3hzQ+7LQdptqu8+gI9Xeo
         nW5wKjoxHpT2bOLIoxPEnmk9d7XuSCxyuEKIHtUQQcnoNA372QJCNY4OSZgJRvNec4sh
         LloA==
X-Forwarded-Encrypted: i=1; AL+hErEL4NlShdG52iNYG5o9q9wsQBeR6LwX+Wly/EuuuTLm6aJE/4mZS7IlyTLnPi0Q64m3eVIC2Q8zyA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+vC9N3twrZDbaoxcbpleSDm1kTM3xfTBWkG6Z9zlX+AsbWAUk/
	cUf5c80H19R8S/Dhid8a361CDgNME1ePGI90F/7okZl1j9IDO3F5QJGK+mmNRtr18yMnccDrYl0
	/JlTT1azOHQ==
X-Received: from pgjk11-n2.prod.google.com ([2002:a05:6a02:81cb:20b0:cd6:1fc4:6199])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9191:b0:3fb:1bfb:ff29
 with SMTP id adf61e73a8af0-4014e74d624mr589862637.69.1795116358583; Thu, 19
 Nov 2026 11:25:58 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:17 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-7-irogers@google.com>
Subject: [PATCH v4 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
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

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.1.708.g77570a6a1d-goog

