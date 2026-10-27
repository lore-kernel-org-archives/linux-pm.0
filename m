Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103665;
	b=4x5ZU3YArgvF6tWPTJCSgvP+Xg7wzKEuAcLMCzukKYsGM50LXPlBqxZTedVcba7qI62H
	 y3HYCiHm1BoGkPN53xR58iFEDYDfkoL6Kuvd4UmZXRzrrZOuCxXOJw//i9bn4/c+Cx5m+
	 5CmrxZ1P3GK81VP3TWKPxa899JVdJw2Kf4q40I/uGbvBgHvwqIvNo5oL+ALhWhWTIpS/D
	 mnbOSSYYREDhoW4dBUPJ2Ob79DK//PEoiyIsPxOSUn96MXs0EhVy7dsBOt9sgWpdhkFBk
	 iNq4W+H//+x+UMBqu/mxriy6HzK6wUMi2QBvsnM60KvCumHENoLmtRlv7iu5snb2YPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AyPN/ei9nBM4F3juP1Dd34ddlYbEVN2tSm6si2Ukado=;
	b=e63jTsvLuLEe2YQh1UZzrxPDY9x7Pl4nstuV6kkZPxVMKhjsbpzELvd91hV8H3Kbgxtb
	 Cc0U6vKxIpM16Ky9wGdL3xtb54RDspcV0lmfh3ht75Gum9cFlVxvuOkHftJWQe9RS4PxR
	 AEaQjnOb5Ah0W+DDw+BWUxtCFpaEASfAK04OfN9G8KwYrpbDuwbeUS3tNkMhwsKGgeoh6
	 QAl4F6FkfzISIUOZItcAbBCI+trlqX5R03LDntkS1k77jegPT6f+0jWM1hAnvZp8safyp
	 DGVSM/GZIRtnBOQDHUxUo9sHjfGzMxV5AwunQn+I7UcDJy6LCFyO4I5qX4fjGZmSt6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqlS7pmN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8C606A322;
	Tue, 27 Oct 2026 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqlS7pmN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CA21F01825;
	Tue, 27 Oct 2026 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103664;
	bh=AyPN/ei9nBM4F3juP1Dd34ddlYbEVN2tSm6si2Ukado=;
	h=From:To:Cc:Subject:Date;
	b=nqlS7pmNsZMYrMBlAaFdtzHnbf9gmhRd6oOk+9udt+1YXerm4XzK27jUGvFgXAtgo
	 Pww/R9vgsOAKPbwVsIaX2NvfeK86U4pfx9leDi1d9TzYowt/I5g2BuMOcmC93XrJ6K
	 zuHMB4y1M08ofxtGTTx1POnbQE0DuvYtdgOUnpjXRRIlUGilngQgzDCEqXYTVmJv4G
	 CTBQflgiUVmk3U+F37/oT+AzRdSSx3F2MxpwEE6CXrwRKZPBmT160+Hidh2iLXl2RE
	 nu5DCyW9M/u8Cu4u9IsgbdJhCvtM2OsVmuYApKylKlxwJ0qidtIa87J+Ge5fVKujF0
	 c1uqGd1peQQ2A==
From: Joshua Crofts <crofts@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: runtime: clarify pm_runtime_use_autosuspend() undo mechanism
Date: Tue, 27 Oct 2026 12:20:42 +0000
Message-ID: <20261027122042.1444-1-crofts@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()")
introduced a pm_runtime_dont_use_autosuspend() call that is executed automatically
on driver exit without making any changes to the kerneldocs.

Update the kerneldocs to clarify the current mechanism of
pm_runtime_use_autosuspend() cleanup on exit.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
Hi, would it be possible for this patch to go in a fix PR before 7.4 is
released to prevent any confusion about the mechanism of
pm_runtime_use_autosuspend()? Thanks!
---
 Documentation/power/runtime_pm.rst | 10 +++++-----
 include/linux/pm_runtime.h         |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index e4407b687f8b..40a5c23d5259 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -425,11 +425,11 @@ but it also allows more flexibility in the handling of devices during the
 removal of their drivers.
 
 Drivers in ->remove() callback should undo the runtime PM changes done
-in ->probe(). Usually this means calling pm_runtime_disable(),
-pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
-devm_pm_runtime_enable() during probe, which automatically takes care of
-calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon driver
-detachment.
+in ->probe(). Usually this means calling pm_runtime_disable() etc.
+Alternatively, drivers can use devm_pm_runtime_enable() during probe, which
+automatically takes care of calling pm_runtime_disable() upon driver detachment.
+Any pm_runtime_use_autosuspend() calls in a driver will be automatically undone
+on driver exit.
 
 The user space can effectively disallow the driver of the device to power manage
 it at run time by changing the value of its /sys/devices/.../power/control
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 322e3b17f987..ae68a9dc7fc5 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -855,9 +855,9 @@ static inline void pm_runtime_disable(struct device *dev)
  * requested (or "autosuspend" will be handled as direct runtime-suspend for
  * it).
  *
- * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
- * at driver exit time unless your driver initially enabled pm_runtime
- * with devm_pm_runtime_enable() (which handles it for you).
+ * NOTE: This is undone automatically with pm_runtime_dont_use_autosuspend() on
+ * driver exit regardless of whether a driver uses managed devm_* functions or
+ * not.
  */
 static inline void pm_runtime_use_autosuspend(struct device *dev)
 {

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.47.3

