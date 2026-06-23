Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8432F75B;
	Tue, 23 Jun 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233865; cv=none; b=nY0u+s1wvT4/WM0D1DbA4+3jQr8T1Vix8irDBMDjNyj/7yKRhBspJau7c+cjS+VmZ+iYA8A/lpQOQvYTfe5gxr/8+7AQJpVGyjjys801S5wvAXur9MXqXPpOzsh/Ihg0Xqjped6WJqUq3wHCL6ink8PwIYjraURJUOMfjfn29xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233865; c=relaxed/simple;
	bh=V3ZyqXic/yFE7SEJj1aMbcxqUfOKM4l7oGyg1fmge2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGE9IYGbQ/QKlDhIR0WQzd1rpLMduWZGvPD7tAUD5opMil3vW73GIquqCtSwoAcn4malJyw/gB9PqQnrQ8uzoi5LWASVAvYh1y38SH+jhu7iO9SzlxPhWL8UBoavATaA4BagmFpYKla/XZHC58GLrzjwqrZDtEsX4OPHiVxCsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=RwaoEhgH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="RwaoEhgH"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9008526E45;
	Tue, 23 Jun 2026 18:57:42 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aAQpZxlVdYkq; Tue, 23 Jun 2026 18:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782233862; bh=V3ZyqXic/yFE7SEJj1aMbcxqUfOKM4l7oGyg1fmge2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RwaoEhgHdVZ42vAOR/3v1LoSLfejTfp/8+6HC3GRCq3pzYaXaI/ykOLXtAyCnrFJz
	 dgjOARlhPPfCsxs7YH2HL2MArP8i2lALSVjmnQUBoRUGIkUcKv7Rgiz/qzErD1BMqK
	 93InyAqLx+BzD7HZ7iuaLxaju5pRxbpA5rfDLU5yCM53IlgF8zSJtDMuIS1wnV3ywF
	 pv4cHpt531qAtn9OA6bhovmutnUuEuZ5QhhnaZEMzdFLAkwke3Wb9pJGOvjQPeTnvj
	 cKG3r4i2iTEM8AE9NeNNXjrtixIlsXBeiF+cuZi5zaqv+6VDVXKWRDqR8pbuhLs+IJ
	 RtVAcy5/LjuJA==
From: Marco Scardovi <scardracs@disroot.org>
To: moravec@ukf.sk
Cc: bp@alien8.de,
	crecklin@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mingo@redhat.com,
	pavel@kernel.org,
	rafael@kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	scardracs@disroot.org,
	tglx@kernel.org,
	x86@kernel.org
Subject: [PATCH v2 2/4] PM: hibernate: Define and parse hibernate=relaxed_memmap parameter
Date: Tue, 23 Jun 2026 18:47:28 +0200
Message-ID: <20260623165724.10753-3-scardracs@disroot.org>
In-Reply-To: <20260623165724.10753-1-scardracs@disroot.org>
References: <cd45c7c8-4df9-4963-b847-02cf72bcc039@ukf.sk>
 <20260623165724.10753-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the 'hibernate_relaxed_memmap' global variable and parse the
'relaxed_memmap' option under the 'hibernate=' kernel boot parameter.
This enables users to relax E820 memory map integrity checks during resume.

Assisted-by: Antigravity:gemini-3.5-flash

Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 kernel/power/hibernate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..62ce708f37bd 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -41,6 +41,7 @@
 static int nocompress;
 static int noresume;
 static int nohibernate;
+bool hibernate_relaxed_memmap;
 static int resume_wait;
 static unsigned int resume_delay;
 static char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -1430,6 +1431,8 @@ static int __init hibernate_setup(char *str)
 	} else if (!strncmp(str, "no", 2)) {
 		noresume = 1;
 		nohibernate = 1;
+	} else if (!strncmp(str, "relaxed_memmap", 14)) {
+		hibernate_relaxed_memmap = true;
 	} else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
 		   && !strncmp(str, "protect_image", 13)) {
 		enable_restore_image_protection();
-- 
2.54.0

