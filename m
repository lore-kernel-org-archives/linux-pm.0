Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717875;
	b=erGtqEBlQxU/2pUJmW+oGWEW0koI408Rtf1SUV3n2Ihb+hDooZGO2NtQQ2nyhrGXRC+f
	 CXWE0p7D/SZ/tiNdxScLf6k8j5X6Q04zRZYDnAX7xbK3mWcBDP8EYVX/x6OeGX1AVzImw
	 T7g+KMBOcFvCjAF/6Nq3WwZSiXGRaAzAfanqc7kkBO4+/uYsbzdq71GL/d7kMZntuI9NB
	 rqEutT6V72933IxA2Ibj1Fv+DVMQ9TGgnn8YoGIjEm6CIXv7tEDkTFt78f4g1GdFdRHw3
	 r3WZXBAqmwrH67hAQEpbEXOPwUVRySfSJBTToKqvjTuTLl+YUIQracWj7foehtiLM/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i3ce6V5Fn/mqyiSZg/eYAgXyAQ0fPbUt248njUT/QJU=;
	b=TiPXZklHkIsdDtrZWCRRCpw2xBM3M4zrlnYACKT6w5YWf3wNMuCRDhdMsL+uIMsrbsgu
	 YqiTZ0vnqZVmQ8XzA8Q3+8wLe5Gg4GkVvNg8UoMIAeElUom4AIV2lnO5yBm4q+WeGGQuO
	 UUGOiAp/R/RWy4/Fo5qcz7hRWboDnvuZOP84GrY9pO1uffLuUXi2EHijY+Fza/b7KbMZo
	 wT/tGTyAv6CfZ6/M0co2PlLkGD3L2HeB5fFxPBXH6F5pSb1cXK7EF94ypmWXjPF2v9n7I
	 dmy3Fo2zgj1N+CkqaKt9HWLoeqLR/oaFNq0MCbCsqwyF9YutDlm48zLnV4luiom4m4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x8qJF61G;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6103606BA31
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 14:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6103606BA31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x8qJF61G
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c49b431f022so630927466b.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717873; x=1794322673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3ce6V5Fn/mqyiSZg/eYAgXyAQ0fPbUt248njUT/QJU=;
        b=x8qJF61GmIRGyteW7Ikwi8CKb/NK5DCUXyBgHHKcZ9Gg67wv4grBJd98VKSg/ccWyI
         tU/TkQ4qY0FCqSouDzu7zFw6uf3g95H/xnRd3xZ8Z5sf8LEBwdsVpp/hIb+2EJzZK5PM
         xl3wrZSJsE8a1bZDV6mHsUX5AeSuNdHpqmUQz7NEnrGVozt8jPe8z8vgrmjgQtmd8xC0
         sRboqJzqDy1lfFBXt86jCWJuO9orRilnngG802t6xXp/jv+fJQAjvHqoo3FcSz38vhZC
         PdZ/6YQScplUxkWykUKNqwClN6LjZl8Crj2zoFUyS5yz9oheRQ1ovk7r+UJl+hB7m2K8
         z8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717873; x=1794322673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3ce6V5Fn/mqyiSZg/eYAgXyAQ0fPbUt248njUT/QJU=;
        b=gyPlgiOr+8x2RGwFl+Pi3bAE9VJrwSDb5JvWKvga7Dj65BQAwx/l/xQwIsZSkZPQcr
         DvqOcBmFN4yiszJ3DnuR5PssHjgCkOS66hcOLl1JVqjK6K/XMd4KA3cVwz8pZYZSEiD2
         sbfFIWegc5NwL1qOjW0OA01H6ZC8vWBQb2lDT5IJ8+RwGm/L+bgPKIm9LlMGKXC0eSM9
         eeErZneuhR1VC8g8e01mqSnsMh8M3Kxkj/iAWKiV0frDh5QUMjm1ZOzB8eUrDlTZUzqL
         pqzw3ZF0ORbnwscXcZCKjnipuUEsA3rr3x3roM9zLXm32U2g/7LSr2Nhv7q/dRYb7ewV
         tFsw==
X-Forwarded-Encrypted: i=1; AKwUvByoG+dCo+/CnF+RkFfB74SdKgy36m17rIjrJ6qVllGPvW4O/kVMCsymE2lSwiTLKvKl2vNIFdUblA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/yb7zAKSfAX59f+/5zgD6lzvAvISQDVqK9kW5sI4U5rPAbCmCk
	5Q+d8uTxlxEDWFBpichEwIQJ5sBrnvi0TJ22BYwi4hDVxT77VXnMPThG
X-Gm-Gg: AYBFou3M3nQoewjultqm/YGs4evKeLKJct1UYZPpP0MlmrqxdVmAoY7iYIoMA66jA2v
	Shd7ObhA2E35uxCjxf/0QS5PdOH42Fj7MR/IPOQ+g3Aq9yAb3CfgsGEUoe9rekq23EsjgGqVUHq
	OxFoRrHzEJ2k3NwQMeNjMI5GM0KKdbIonAYZfK1njwjXSGRX3yH+NlIhWwZ+pgKLjzP5cAFuYUx
	sDnmpMirnLpnmVQKHcXkHTLxmE6OqvSCaixbXhhEOj0drWLTglsVP+NkZKNB7QfCRVhIfzQfnHG
	tafajgtljCyi/ilECOeKtPJ/NwWzsCrEYQ80q8ApQTp+6QVT6D+GqC0DE7BoN54G0xjuVqxbGqD
	iTaGXZ/0HCT1Kss58jjeG97m0bv/cBkkhrctk8TlyRSnsgACU3+Q8rOAulITvqg6NWyhUxN0Ear
	fAwXGQPe0/ewV6dktzw/DUks6GmiFx1JsLo5MWhxLwidh/aIvFVv+ae7LI/8Cl6mJzcFMqoKT/D
	+atqR04fcsFWmc9A7qbssQ7QgOm14AKQmD/OBhrkD9ueu2UrLoRP2e/ZuMGUmoi+0BRI5tpgW6h
	E1Kr4B+kJO1wmgf4jaEwrI3AnXBPvSIbF7XWnEbrLPbwyZnc6HM0M4u0CUR9ojpyk6GKB3T9xme
	nhceSu1/piQv5yxiZfB7ZgjNd1EtbGpt0dzMuAEbRL21Ga0xWemJv6a/IsN0DJSg+H56SAsQZtF
	BssEIuLi2XnHMHBTOMKrCZPn7/ZvY2cUSTiJjcYVcDAKS+qhkqbpklo0R/2FkUy6wsHCkSYu4=
X-Received: by 2002:a17:907:c23:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c4ca7ad10edmr1125964766b.41.1793717873240;
        Tue, 03 Nov 2026 06:57:53 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebec78f3sm93656366b.23.2026.11.03.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:57:52 -0800 (PST)
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
Subject: [PATCH v2 2/2] PM: hibernate: refuse splice on /sys/power/resume
Date: Tue,  3 Nov 2026 15:57:43 +0100
Message-ID: <417c773d1719006cc85a3468dc393f5e754bf855.1793715774.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793715774.git.krystianmkaniewski@gmail.com>
References: <cover.1793715774.git.krystianmkaniewski@gmail.com>
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
SYSFS_LOOKUP so that its writable opens refuse splice and use lockdep
classes of their own. Plain read() and write() keep their behavior, and
read-only opens retain splice support.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v2:
- New patch. Together with patch 1, this replaces the v1 autofs change.

 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd5299..9dc5a27f674fa0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1316,7 +1316,8 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return n;
 }
 
-power_attr(resume);
+static struct kobj_attribute resume_attr =
+	__ATTR_LOOKUP(resume, 0644, resume_show, resume_store);
 
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
-- 
2.53.0

