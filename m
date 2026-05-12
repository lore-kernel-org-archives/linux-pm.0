Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF43672BF
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567877; cv=none; b=FW+Nx7afl+ddItlZo2WowbkzJ9Gxh0Po2IHFKyNQJYC1JU2D8zllTdRaFU6MKpd2Xg0ys3LBqSMGrR9Y9Y9ofwRUXxfY/z7Uy/5qjn7x+JY8S+Ccjj78zdEFVVzNZ3U8GtGibRmUV3qPvPgvaSIJLnNJvborDB84Khz00B8GA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567877; c=relaxed/simple;
	bh=TXI1XtROLvlasjDeA+NEOLBXi1z7yuQZmjELABnGG3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ov2ZKErlDnHec7KpRCIgQvn7i6141+tfPloSOOCRX0UzT5xY0QvvH1Ve9vdX9b1sq2XQKprfbET5yBKM7MOvPj4TKE98bas8UOpXJD2rv89DiuVsJSxNmlpmRL2qWBF08i5Xefu941yikiwO4B8UgkiEQJgO/83Gs/1Y5UVK6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCkk/oUs; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCkk/oUs"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-835b78c3797so2151217b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778567862; x=1779172662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUbEBchgUvTXZkFDusQQ+51MvJx568z8YLE9Irrk804=;
        b=hCkk/oUsAfYGquuvYaeQSFfSEDn93EGw7PTGoPE+ESgbX3mend8p9DexEIyRI9W/df
         5c7Wnjs73beAyIUohfV+k/28qFJJ8WgfathfK9NwNWEULCQHSZT0qyrwMeETduXb2H2A
         lD/GPfHmh1sIhMxvYbNfC6cEp8mdosQ363LI3h3unOVMM/C7of8UGPgsDMfXGoloSH05
         m9SvKp3LHR7dQSjQmBH61yPE1NMBLWuFJws0aAIRDPhYk6NUIBg48Bv2m3yuOgd6jBf9
         FzC2R4fBe3PrHs/qVsvW+tN97WWcFg5mPril7wIhj/BhXj8/gElm/8wag+bSK+qx7j2f
         dn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778567862; x=1779172662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUbEBchgUvTXZkFDusQQ+51MvJx568z8YLE9Irrk804=;
        b=EQ3cALy142JJb8RhMbDEogv8pQr+NX4Mcna69TEtCBqqx2Aoxom65T0dofnWu6mXS3
         FUCRHYv24SVl6NBK6KM9nF1CIh1LjD2ArZ5kPS7REqkm5JDfu3mW5ZI/JRhJX4IyI9wm
         ibpulvQA8h0aFbp15yvwVv+m5Xu7tnh7rhOtF4rIJrDjuRqxeu+dgK2q4iP6qLw1EPLU
         2UHWsF/nedxFqua2LtNMEhjecfNU/h+L1PRkZqIqyHilvUavS8zb7LEjnGi4l+hqIocV
         ggTpQNfd8CojRuXZDE2/6lMv9EWE1t0CXN6R7xbm9S2sowypXOOpY+BMYCFxSMlOB/zy
         DpAA==
X-Gm-Message-State: AOJu0YwaDqNPZh+D/9NHP19Sb0xopVjhFvTb4nPieT2/Fz4V6//jHRou
	NzIKqousKH3CKYLvljIVc33IS5Oh8/XRybl5onK6YXNbY4yZ0eL/DBhpp4t3SBKz2+c=
X-Gm-Gg: Acq92OGmHnq7btSnZZjtSVolJFkH8pBxst0qQFwFno+D6MmH5efNhmJUsLtepTwDCOE
	insii97ax4eutBkhmhPMeM1+Ootp/l7Ar13BXtFfpozhofM3DUpiwrHWx/p/pjBv/sz9fIgNSmD
	onZ8ArdXXXhwT9r9sgJDOarLurSqT4Abh4rUouMXEWOiOmdnYsusQ81aQPH+nieCxl/wArWWxGG
	rJ7D8/Gxe2e2T8aCo165G5X0Qxjz8N9St9AyvfbJNb7+Ot3x/g2z0vc0GTlEdydXgIUq6QBLjlF
	Xyw3yUKsEqyEDYqLePRbCwZS/xa1Gg/JboH8/H8YI+KlRne7oYWnlOGTM1fMP6o7BiOly/oZPu7
	hGRBPDJ91cfBu6AODyu4JdRnsNTXDoQhGnl+c0auxIhTKJ0wu/nsL3OujWbO+KFFYDryBhj39sd
	wJyQO0OAaMkA7IFZpNdUhNfFXOQ9KlvMBmNlx2
X-Received: by 2002:a05:6a00:3e09:b0:835:cc47:6ff8 with SMTP id d2e1a72fcca58-83cf7467698mr17420385b3a.45.1778567862438;
        Mon, 11 May 2026 23:37:42 -0700 (PDT)
Received: from swift ([2401:4900:1cb9:7c24:27e7:abab:d982:ef0d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839656464fasm22356866b3a.11.2026.05.11.23.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:37:41 -0700 (PDT)
From: Arun Rao Balappa <arunraobalappa@gmail.com>
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	linux-kernel@vger.kernel.org,
	Arun Rao Balappa <arunraobalappa@gmail.com>
Subject: [PATCH] docs/power: note Btrfs limitation with FIBMAP for swap file offset
Date: Tue, 12 May 2026 12:07:13 +0530
Message-ID: <20260512063713.77200-1-arunraobalappa@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Btrfs, the FIBMAP ioctl does not return physical block addresses.
Tools such as filefrag therefore cannot determine the correct swap file
offset for use as resume_offset. Document the correct btrfs-progs
command to use instead.

Signed-off-by: Arun Rao Balappa <arunraobalappa@gmail.com>
---
 Documentation/power/swsusp-and-swap-files.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/power/swsusp-and-swap-files.rst b/Documentation/power/swsusp-and-swap-files.rst
index a33a2919d..44ffe02b3 100644
--- a/Documentation/power/swsusp-and-swap-files.rst
+++ b/Documentation/power/swsusp-and-swap-files.rst
@@ -35,6 +35,14 @@ FIBMAP ioctl and determine the location of the file's swap header, as the
 offset, in <PAGE_SIZE> units, from the beginning of the partition which
 holds the swap file.
 
+.. note::
+
+   On Btrfs, the FIBMAP ioctl does not return physical block addresses, so
+   tools such as ``filefrag`` cannot be used to determine the correct offset.
+   On Btrfs, use btrfs-progs instead::
+
+      btrfs inspect-internal map-swapfile -r <swap_file_path>
+
 3) Add the following parameters to the kernel command line::
 
     resume=<swap_file_partition> resume_offset=<swap_file_offset>
-- 
2.53.0

