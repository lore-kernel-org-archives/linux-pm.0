Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2141F5ED
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556842; cv=none; b=M7HdIVB0fPgfsBmU9LllfY6r+YhS3kZG7jDLH+4qR0/OybZ561YLFRrIVJv8wlHoiyqvp7b8qsiF1kJDmecIIdl5p56JfZiDjXTlLcnM80+pm+OWwirh27EkEauX+QARiZ8f9IjLo2JG2ysMfC/TnkC5FfGV9DGBZ42Lln2VR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556842; c=relaxed/simple;
	bh=xKaYW9zJkwwWXZEkPBsIv9x7Ds5D3bG/QUriwzNmc74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYbgxDBj9+nD1LAHm3tYOiyumm5SuyeSAONPsoZhWKjRDyaNHmdWGfuadEltYb9WLBiUrtmfms9eUC72EdHJwoGLke29GX3dY7hmdawZUIh85EgIp1UghBKNpG/2lxxo9Vz5FqMsC3IzV+CdHZaiRpaPgV+g1XTomdP8n4fVe2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O1OcNwS/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1OcNwS/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d6d28aa26cso8742555ad.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556839; x=1789161639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4PRA1MiHjBTxffZGUtkRwz7pDd3V4cniEc57f6JxKLc=;
        b=O1OcNwS/YU+yW4zoye8fy+n013Mcn1hK/4LbgxyJUnbG2149KWz8rkWCntnlxDtuia
         IggSE2vDIPM/rXbaPhK0sa/3SZJmIFDTnTbWGlVyPuq8OxbZMc0EGJ1v3B8Yd0eWg8hj
         Obj1XCqTZQLamwZlEIIqOVZpdOoQ26syq3KXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556839; x=1789161639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4PRA1MiHjBTxffZGUtkRwz7pDd3V4cniEc57f6JxKLc=;
        b=pyby6AzG+oxG4gbIFnS1btyFeqj19npGatnpIOXlr70kl7kdcA1sBJdYcFZr01iRMb
         LOvhSt5ufVd/Jtt548jDpiSa+NejRLtxoy7gykJ4pdnSIpp5gKYfpB2TeJJrsTOXdj7C
         r1i/1g7PiDkaboxWTwedHWZL2nHhbUMTFqGvHB45y/ccGQ0XcDMDlKukocLltbOqP3nM
         CYOssNQCD+gkwF8OO+Sf2jad3CMTavrYJrGsI9jV7Bq+1Z96Az4YGwZSavSNiVOxNzuY
         mx7HKVOKVsiMqgptrNY9z4Bs6b0PZeSdRDiDmhAHxrimu2ixR9F5k2goDwVv/fl4Mt/p
         WkMw==
X-Forwarded-Encrypted: i=1; AKwUvBwGX8GbWYp5JvFK7/xWkz7pLQo0haTVaUGaGCaplVhaS6EF4dMsKcLWYOQQM2XTm/DC/1sVmYuIeA==@vger.kernel.org
X-Gm-Message-State: AFuF++kCyz2sfnP3QH8eA/aWws26jUEtgUyKRvOXk26+KmqStLeFh5Z8
	0MZ2XRZIRJDCZ1+Z4ze1VnsWTYdB3+twsBg5nPcbaFio4kF7ec7p6j2cVcxK0w5Y9Q==
X-Gm-Gg: AYBFou0v7oel1F7srQbXjjoAcyQfSKTqtSuRMrCwY/QB4l4jgFJ5HZ1bZAYjxMvP66I
	zvujb7RPrrG91sBn/L89fIyL2hLkSovB4vNqFT5gx8uuFcj8H31MFi5mZFR/5PJEuAM337eHSxD
	RyzTv40+Y266q25TAgOxxZEilJbpTFKYpMoC0Nx62tmmGpkL7pO1yV0Mt7muMhND6TL2gMOhg9u
	M9Vz3ed4Luoh0SgSjdZdwPqg3kUmkidSjHq5sw3G/2h2EmxFWN1/2KyPEcXcWRaX0+1EUIMAv6a
	AbJuLjYj2Jm6QOqvllBdmotg9VKVc3GaUIM/ykx4I7kTEMTkY3e8SLZkXRkXyrQD2uNPO79t2VU
	KjwR5yeWS8uUYOay2wMVB+peUpRPdy+mTbO1hKTyCdmub7SyNPWDWkFY/6JtT0b0dIF3aGweHTH
	qzgSGxtrRZKqXp/AmpBWMG9rZyJJLOkVcIwm4qidsuRGd5Uve8//Zj3ItkQwFgO4dk9YwZL1f7G
	WDUVrIU0EpJXQfpJ5Ml7rvELo3kKjansx8LeQ==
X-Received: by 2002:a17:903:3804:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2db126d8a54mr132748865ad.10.1788556839162;
        Fri, 04 Sep 2026 14:20:39 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3339ac24d7esm14125746eec.15.2026.09.04.14.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:38 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 08/11] PM: runtime: Clarify driver callback expectations and structure Section 2
Date: Fri,  4 Sep 2026 14:12:13 -0700
Message-ID: <20260904141215.8.If19ee35d3b80d115f264484b21fb003a962762fa@changeid>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904212000.4167880-1-briannorris@chromium.org>
References: <20260904212000.4167880-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Section 2 describes the three runtime callbacks, but:

1) it's fairly dense to read (150+ lines); and
2) it glosses over a big point -- that it's uncommon for drivers to
   implement ->runtime_idle()

Add a note up-front to help direct the reader about #2, and add headings
to try to break up the text a bit.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Documentation/power/runtime_pm.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 334fbdcd8fd6..571a2f29851b 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -99,6 +99,14 @@ There are three device runtime PM callbacks defined in 'struct dev_pm_ops'::
 	...
   };
 
+Most device drivers only need to implement ->runtime_suspend() and
+->runtime_resume(). The ->runtime_idle() callback is optional and rarely
+implemented by peripheral device drivers, as the PM core automatically handles
+suspension and autosuspend when ->runtime_idle() is omitted (or returns 0).
+
+Subsystem and Driver Callbacks
+------------------------------
+
 The ->runtime_suspend(), ->runtime_resume() and ->runtime_idle() callbacks
 are executed by the PM core for the device's subsystem that may be either of
 the following:
@@ -132,6 +140,9 @@ not block or sleep, but it also means that the synchronous helper functions
 listed at the end of Section 4 may be used for that device within an interrupt
 handler or generally in an atomic context.
 
+Callback Semantics
+------------------
+
 The subsystem-level suspend callback, if present, is _entirely_ _responsible_
 for handling the suspend of the device as appropriate, which may, but need not
 include executing the device driver's own ->runtime_suspend() callback (from the
@@ -212,6 +223,9 @@ return a non-zero value (typically -EBUSY or -EAGAIN).  Unlike
 return codes from ->runtime_idle() as a fatal device error; any non-zero value
 simply stops the PM core from suspending the device.
 
+Core Guarantees and Synchronization Rules
+-----------------------------------------
+
 The helper functions provided by the PM core, described in Section 4, guarantee
 that the following constraints are met with respect to runtime PM callbacks for
 one device:
-- 
2.55.0.979.g7e5102b832-goog

