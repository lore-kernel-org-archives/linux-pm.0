Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B983AC0E7
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073586; cv=none; b=u026ltyYPH1lhjaLenDowql6cxbkaGO/H4PrLKaAA25JH2f10oiGx62VdRM9goF9HSbCXTIYPMFSj7P+awDyMa4GagQTqEqPc5Wrqlq7P6j0K9VHfEumbGpDU/oh8ESP/HURafd1LP8CBpFqnNX29sRJIrJXabo0KJXEE/tphe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073586; c=relaxed/simple;
	bh=4mRR/lct3JxUI7us99LWGMyA0AfdcUxcoiGG5tWdAAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMSO5AtXhntnWP5dwHVGT8N64+0DIEi/u054jKvT+cvRiYJoqHz/lyvtIqPwKst3klCBmQAB+QmP7B1XTg/of9R0Q6w9+3FTN2rp9B2Qb3Xb9ATd7LPXZD5mtiH+0C8kdZ5RqzFFTxge8XlMrHurHeQLHJ/zjLXuKnALuhJ/3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bu9KASFl; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu9KASFl"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so1727135e9.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789073583; x=1789678383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mCkJNb+QrKnJKj/QcqFSE5iIzRjiFJzvF62FVz0jZM=;
        b=bu9KASFlGGGxmRLJbDyzgrVwnhC3NefLPjdz491XeLiDdncfYVBpbv4Rk4DcSD3+9Z
         k0QpusZHCNPCKxDG36xpp+eboSutpa1iMbygSjDwnJofkE1uIUZA3G4UvZwKx12P48Lo
         SRbOgio03zdVGZ74m+y0gBzwv9vpUx4BchJjM/8CkdgRh0eZJeaXU8V4cbz0tKyaWeHR
         bCv35twcpJTbkI4akALS1DvXSVOAHZfpmU0xhAlvPfGYhdPuxtiUYFQw42cdPSIVjJtu
         wcpkHSNuUJ1Ks/qrBHpoFj7Z76Ric92vRZ7YQMMVluMI+Kjpr+MP0YxU5UFv6rYD4kI7
         sLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073583; x=1789678383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mCkJNb+QrKnJKj/QcqFSE5iIzRjiFJzvF62FVz0jZM=;
        b=FynJeP0pXHy4U410nlzFUkpnYCAKfVSJETKsUQmwwfbK5UkqZAezSFCB83n0BusoFj
         UxZ/vNitiuQbdo0Uhtl8XxWJZd0BnMiCGAXli1Vvs+sy11fazS32u5KU7NlGtAzMZcs0
         v/+UamEGvP5Hesn4BigRci0qtFFBYoV/hMUHrAC6Puaq06/jXEP8QXh80a4dMVIjW8Gv
         +BAhii1Ni3EeQ+u0qVjoYSsQ9HYRzPp1+QZQd6kg9OwDqMBOofQD4jRI95j4/JxbvoIz
         jePKXfcpLER7hpuQYcZuHbMJfIW7ubWBqeQsia3FlYtaz0VWb8LgUd7LuFxf8aT2k9Sk
         SuUg==
X-Forwarded-Encrypted: i=1; AKwUvByXdaveSPuhz6sG24yvMeefNvE8mwqa5hshhY4HsRDRCvyod3SlC+xHpn7LAZK8b7foLo3hWN3Rjw==@vger.kernel.org
X-Gm-Message-State: AFuF++kSQud6az4mbW7I1EzPJFVu2N4w73zFhBy1mkSjfGm1IcV6tK+8
	b1zdAJ3OpkoLG69AfGYFse3lt9DzEtz10I2bBjtUGGxwh/0wAD3NFN0j
X-Gm-Gg: AYBFou3zKOQdkk+xBfrAjWtlUEvSf5ao7sqRfZ/kp4kU7fExQWrwVY+SWHLka8mAdVa
	DjMZj3Q7063MuqBveDsXbUhoycZaGKjLOQkKgVKVoW3Kr7W0iXqPz0pfgz7cwraSyvqABTvn2Zp
	fEE4GQKuyMSKSyLPXhyxcbEEO0igGKiD36sq9Wy2sMAzxkujMExaKu7kQlStX9c+nBsFfGRZjrq
	j6nD7qq3JFC09flPbtbz5e4ThlwzPWTEQDw5KL8oAvmy1qmDnIZo1JO6DxJUw9nRLthtOj6yoYs
	58SXqz+lmijtT/Dm5yEa/KHuUn92bhmvGSQzgr3QDz7kmVCvcQHh1gG/eVsBcSKpEW7XkV3t0Fw
	ZBEABBq1TeQYpfu3AP9Uwa1Br0DyGNSDBnSFMB5thXqj6i9Wfp85zMZ+eva3FNTf3a8fyTWXPW+
	hyuJaazyXEjjg3Wush6rUEjZg8eHAq+Ic+BvJ/TMnH1Us1rOWM2oje/ZdCpsmzCpqk/pbjBlj3f
	irFPIIPqEm5i2hT50TUSgqgatWihCZiiK9hc04rpLp9O7tKq+CYto1pW8Rmy0ZMB8VuyTVSEy3p
	k4+yzcrXMc+UbMd9frXtYtggcuJ5IZzelUYrUh3F+ekUW0CUg199TQoX285XNIuYTfTfq9dsjwg
	aIY/UYzAPGTeIXDg4F6P1MQ==
X-Received: by 2002:a05:600c:a0b:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49e618863bcmr18595615e9.4.1789073583171;
        Thu, 10 Sep 2026 13:53:03 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b3d9-b901-601c-58ef-b3f5-74f5.310.pool.telefonica.de. [2a02:3100:b3d9:b901:601c:58ef:b3f5:74f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49db038401fsm77237325e9.13.2026.09.10.13.53.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 13:53:02 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] PM: EM: allocate the cpumask for every perf domain
Date: Thu, 10 Sep 2026 22:52:34 +0200
Message-Id: <20260910205234.5392-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

em_create_pd() allocates space for the trailing cpus[] flexible array
only for CPU devices.  A performance domain registered for another
device therefore has no storage for its cpumask.

All performance domains are added to em_pd_list.  The netlink interface
does not distinguish CPU and non-CPU domains when it calls
cpumask_weight() or iterates over pd->cpus.  A request for a non-CPU
domain reads cpumask_size() bytes beyond the allocation and can report
bits from the following memory as CPU attributes.

KASAN reports slab-out-of-bounds reads for both dump and by-ID requests
against a synthetic non-CPU performance domain.

GET_PERF_DOMAINS does not require GENL_ADMIN_PERM, so an unprivileged
request can reach this path when a GPU or another devfreq device has
registered an energy model.

Allocate the cpumask for non-CPU domains too.  The zeroed mask remains
empty, as required for the documented unused field.

Fixes: d8eef0453132 ("PM: EM: Implement em_nl_get_pds_doit()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/power/energy_model.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index e610cf8e9a06..fd07c564c201 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -439,7 +439,9 @@ static int em_create_pd(struct device *dev, int nr_states,
 
 		cpumask_copy(em_span_cpus(pd), cpus);
 	} else {
-		pd = kzalloc_obj(*pd);
+		/* Readers expect pd->cpus to exist and remain empty. */
+		pd = kzalloc_flex(*pd, cpus,
+				  BITS_TO_LONGS(large_cpumask_bits));
 		if (!pd)
 			return -ENOMEM;
 	}
-- 
2.53.0

