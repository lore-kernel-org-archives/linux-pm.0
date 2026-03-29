Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD42C3266
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768023; cv=none; b=jOQmmKQeeSn7GtkU4qdctL5zT1SRYUCuJH7s64q+SjWcTBOaKawElOethtbp2dTpY9UcMNIKNDCtKvjMla0ywfYvp8wgpBas4R4NwjXmK98MkLaPmjBKgn5gc0W5QK/rF6r9qse9yJ5ClmEkkFWhBYLqQHjSIQgeP7KZmlKfHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768023; c=relaxed/simple;
	bh=El5UGz6rKlunrw+bvxZSz+QJrugKhpwdFMLjMHXMgzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv5r99VdMqDqD8JagT3bInq0U2ikYmHw+xy+QeC6W3ziVx6gWOcySwnrZxAQsWHKVWIo/qA9+XU0Cs38OVY9gO/jYYH883cWQ1Wmfxo1te8t5gE7Jm0IXu6XgNr6wqP7BxFl+YFVBSvAydSzt5Bv56qvh+o4MKx630EdO7WNxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpA++fTb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpA++fTb"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c7412b07f22so1809809a12.0
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 00:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774768021; x=1775372821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/it1c9Kax7yLBHD1HmPRV0TNRw4DIg5tr0zA922iag=;
        b=EpA++fTbV21UJh8PZWTeQhnFB1kVLR4Negaz9qxJ3ZV8+q/stIDVUl201OY1x7CRcQ
         9N4n43Foo57IiOuCRap3m/FgoUuk4TFQJ0YuiSxgsXJejyQgkGMY1yeKpKxflUKlLOR1
         lpLLLad7wmCKY0qaFlrzX9JUVjMlEzYNzKy1aARB4YjKsztqDgP3SZn4anQCSAYCwbsv
         g+ZCJ6crrn38y5muOftqHhKmxX+DonyTF/miXmcqZoRTDKzvNKJlaP+ajpdI8auDf6tg
         cN3CGuoR2v7U9RzKBGwkLGmAWdDJhAdJM//NaAtxyCvR0sY5+e3h/oz3K+zPDVDjUx0X
         +jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774768021; x=1775372821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/it1c9Kax7yLBHD1HmPRV0TNRw4DIg5tr0zA922iag=;
        b=YqfCANqXQ8KaUl7wtN4EjK4orocSX62fnUuQxqJslWWDIYc94cSFvtzRuJXWivAl4g
         ClRqIfzqdU0wwQXcKvwPAZ+sbtOcHjXMXujf7xIEo8wsnonfT+rU8Mz/nzm37kGQG6qb
         Rt9zrSSfoSlpmzijGyRcgA9y2WnM2UJeq1KL8ksg6AuCaoD3QOalOKsoUcXQcZPjPZ8U
         awBrog2OjqUCl2g1+emcwbcMnsHiagHCVVUU3il5TSAk8lkEH7ge/KpkbINTWZkC6zzP
         6tmpGRxVHuEmskaGAPcZRdIywZaKGKiEEdPiCbSlD6Jqlb9rS4PidoMkOhnm7vVVL57C
         JG4A==
X-Forwarded-Encrypted: i=1; AJvYcCXjxGTvJO1mFy2F3xDqYUXFirIXgvnLBKDegaOHNs+ssyaBEpQsMrmRE3hXZjdviQ9hrzfykFKeBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIOYF1ql6MfKB4x87lLUQ8Tg9yJuCFZNl9SSu7O0H7ymHwS0o
	aPJrlVlDLLxDUoKY9iS0WdMCzioRyANjCJ02MdzwNa5/ucQUjeY3q6AC
X-Gm-Gg: ATEYQzxGN51d2WIjzmuc7QbOF9wvQJVAsGLw/jv9Gtr7fX+v96G1z3SehY90ZIeK3iq
	bWstmzJaO7wcxyomS0vA4Qbt3cIowpA+Dz17zmiEi5ombJ1o4cwGf/Ng96iR+FtBXy80/WrC10d
	Nzn0t+Pde/RVOiU2c+mYh9gMp1dAVmO2kLxJtDzBFTMAprf+dWcTQKVrCw03DYnOMqlWZtOyZhK
	Yl6webg7sllbnnRvOeM78Jgg7KiCJGlIUPZlFsrPkLqdk/tT9T44ufUYt3N/urYYJtApf7LtkIE
	+eIo9vCapYeWypqJvmzfzqB1kSGBgL6wj/XoHgAbY15PEW7t8xHIh9M+O33yYru3P8ULBuMSD1r
	8xtj3SF06nsIuIGNMzpAarVNkqHQy741DcGbmZKCK2pdkaeqn0jLWyFuorS7Al5YGlb+wBrnNe8
	sltzYTM40St+bXdO2skbrH3vsY2PfWzcNLDmCkTNw3GRI=
X-Received: by 2002:a05:6a00:a809:b0:829:7a62:6a with SMTP id d2e1a72fcca58-82c969c171amr7304542b3a.22.1774768021086;
        Sun, 29 Mar 2026 00:07:01 -0700 (PDT)
Received: from debian.killsync.com ([103.85.207.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8437441sm3911640b3a.3.2026.03.29.00.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:07:00 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: rafael@kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	srinivas.pandruvada@linux.intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH v2 2/2] thermal: intel: int340x: Check return value of ptc_create_groups()
Date: Sun, 29 Mar 2026 03:06:42 -0400
Message-ID: <20260329070642.10721-3-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329070642.10721-1-aravindanilraj0702@gmail.com>
References: <20260329070642.10721-1-aravindanilraj0702@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

proc_thermal_ptc_add() ignores the return value of ptc_create_groups(),
causing the driver to silenty continue even if sysfs group creation
fails. The thermal control interface would be unavailable with no
indication of failure.

Check the return value and on failure clean up any sysfs groups that
were successfully created before the error, then propagate the error to
the caller which already handles it correctly via goto err_rem_rapl.

Signed-off-by: Aravind Anilraj <aravindanilraj0702@gmail.com>
---
 .../int340x_thermal/platform_temperature_control.c     | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
index 18ac5014d8dc..d92a6f84a778 100644
--- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
+++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
@@ -278,12 +278,18 @@ static void ptc_delete_debugfs(void)
 int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_PTC) {
-		int i;
+		int i, ret;
 
 		for (i = 0; i < PTC_MAX_INSTANCES; i++) {
 			ptc_instance[i].offset = ptc_offsets[i];
 			ptc_instance[i].pdev = pdev;
-			ptc_create_groups(pdev, i, &ptc_instance[i]);
+			ret = ptc_create_groups(pdev, i, &ptc_instance[i]);
+			if (ret) {
+				while (i--)
+					sysfs_remove_group(&pdev->dev.kobj,
+							&ptc_instance[i].ptc_attr_group);
+				return ret;
+			}
 		}
 
 		ptc_create_debugfs();
-- 
2.47.3

