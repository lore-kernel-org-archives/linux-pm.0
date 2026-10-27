Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140768;
	b=vnXwWKSiPso5P7I+ZyEmvzrDHZj5sq2PR0g7p72EZmlezeoT5mXGP+zAxmFljXhqdiJ2
	 Vjyt6JsjbUuv6xIF6OwiOEgtZ5vQ9DHd5tnRVk6C91YUjU796npZnT83rvUGaurSWB/Qp
	 K+EenNAv5xUn0IEw5dKC15tTiRCCUxrunyMZ1P9Pa8u0zaiOpyxlkDwbQ8EyDo9HroYly
	 5IxIb/jxlXPniIgH9UVxHaJYohKX6cXFiuWi0VokQLHBO2RreRvAEWBbrhDPsaPNt911I
	 CGelsT3iDRNXcxn9IYpDJadeBQCvx71jK8s5CgPix69XS8SwrI3w1izc3WMihUE/4Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
	b=cqiR9fHMu5qEpClMrsytQxwHuZ8B/u9YgQlIeKHCb47QO1JmIy+fmGqttRowWlvr8aun
	 w+VmSm91FF4ppV54mg/0H0oQyf5JXiUyfQn+RNXOrszB7LJs+kLpPlOsuXgzKqMPhJmPu
	 28hqJ3iirtbQ04voKu+wR6sJks0re2r+NRZ5jx63B0bRrMsgD3pdobfh905Ha8nt5STK3
	 XEN6K7JdVPU4hrFnPemEF7BamDpNRNng+xhOqWwXqC/YWIsip76aY2YsLcnyJCx3ZKIfw
	 UE7todTU7Cg6sBetN96TjPje5oiLZ9VTvA1wCFko4oj6sIdmD9CMd1n+BFv299N8rjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=liNe3HMy;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B260A261E
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 22:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B58B260A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=liNe3HMy
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-147be78cd56so953113c88.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140767; x=1793745567; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=liNe3HMy55X9pJAx3yYfGsMeNT+e1JnZxB+AQx3A5J9VPGgN92YzVbYvd/za/Drr5k
         lst0PfcfRGocLlrgPC5UssnxEJctFzU+pQm+95FdUho7XQl8tD1ulM7rKwt/jNE+21Vf
         Z9LeRG62rYmnsPQmmg4JlXmw8+AffIjWCQze/e0A/NrbyHM8TP8o1608vrQLYJKc1eVF
         dF+siAZRQfjXJUi0LYKhvOuPmzmxcjf9I8fjPgny0U321qhAu1Pmw+Bv//U3MdnFtahJ
         7n34bb7IiC2Le1ntE29Feez7T+/eMXs0L62grlkW9U2pgTYjfEQQlg6qoj1bz6MQC6fW
         lCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140767; x=1793745567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=aDCfX8qo8uRWwInqPyjWB+j3w4U1UMtT9PQEOFBncsYnMQFb/hGxp65xWmX946pSRd
         y0wWwB1c7sqnAxDGpPL3t+EOgSTCTKc1POPAIJA4rpt2JLd6C4RNVqf8LZnFCq/6ek4x
         SBMFqAwj0ItZO8IvJ6Nrkxe9i30w4Mrk4T3VHrhMz+ubZjRsM9jmzBWvKBYf9JHtIYe7
         Ui2h77Jn2fDG9+vr4DNLw6Wsosqia79cui739x6KaAyJKvYRaxd6SceysBP3y5KGNjG5
         yfWtukHH2XBTC2HeJnGic7Tb7yRzB4C5MletTRfGvGdkNBgPGUpk1MZefpNDXu8Scmbn
         zebg==
X-Forwarded-Encrypted: i=1; AKwUvBxrqZXVEUy0eEBv7l4wWeCxmJ+zyo1xt4Clv4k5q3eiuuj11QE5AD/gCJ9xdEnAXNPn+liebjZh9w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIieohzhE4BHs+w+u4N/cotN1QhrcZrHC6U7pdmmdfhRuOrgZBE
	Kvcvo+LflvjndSmn7zN7Wsa8lr/SQLa+XzLvgcCFn0w/Io1Z7uPpAmAwvbX9Ewhts86dOce2hiG
	j6duf1gbHGg==
X-Received: from dlbqq10.prod.google.com ([2002:a05:7022:ed0a:b0:1a0:a0b4:204c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f115:b0:1a3:6040:bf78
 with SMTP id a92af1059eb24-1a6cc34d07bmr917417c88.11.1793140766453; Tue, 27
 Oct 2026 15:39:26 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:41 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-7-irogers@google.com>
Subject: [PATCH v2 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Content-Type: text/plain; charset="UTF-8"

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
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
2.56.0.313.g2479322e68-goog

