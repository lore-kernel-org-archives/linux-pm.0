Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF0494833
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818449; cv=none; b=RYVGhuNjrtdC2warm9ZKORr2k3uWbUFvPjqMEWTzOwl0u8jAXd1FQYElic3loFdLsEsaIY/Q07ZkuaYlFSmx3wTqis8uwPRYH1wAaOoWG0UadZcYa+Ht0uFcLS92aG6tp+ndzP4sNJzPeBOTQi2Sgi1o7RGo09CpsnZgAtjh+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818449; c=relaxed/simple;
	bh=hYDKT3xArZmciyLfJYiXIMbcjnMjQlt/qr8tZhfeJQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lywnc+JuhhxjnX3cVxjXCT7rSygEtgSO+cYz0dJGR8TdugxCpaAY3z2JllxC0Oi/zHY5Nl00+gTsyYuu4tmTtLHdSewsoXEkrTc2SahsrdiiSl06W5fcpgND0M2k27Fg3pAaHWCTl528Q2kyMFPqTvfFtTj64g3cetmm0YkIJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNaENbaa; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNaENbaa"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b647aac23so519341eec.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818447; x=1792423247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yar2nzXprexqPKj2vgCvzCiguNq4T5j0jFeUqERpoec=;
        b=pNaENbaaVScDLNmnSaWKX3ru1C9yAOfmpXsdmT/AeTzYiOJSRVaf7LVscoFZ77QM1a
         etmLL10qNNRyDIISglgeyew8e3inIm5spA+FpruBQQVyrs8UvBuLG0mNQyB3Isc0jvIl
         MUAkLYXbmonY3Px1omiIZWXJi1fszmraW6CH2Qxsmokn8n/qbbljJQARZo8OiaI6/O85
         XaGW2Nku9KTrwQmy3K/jSvdhbWl9zrHtMVmhHfudQwuc+gCUWlL+EwYWf/SrpG+5CDZq
         f1/YjoHXzW+dYxW1DeDeU+261+Q0iXjsRilWC7KGcE2MRqnDPZ1QFYBczgQhaqJxM2rt
         gC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818447; x=1792423247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yar2nzXprexqPKj2vgCvzCiguNq4T5j0jFeUqERpoec=;
        b=RjdClGYoJa3XV9LImXtB8vKWHihC93Zxv4X5wJQVS0j3g299G6+KvmglmE7kybpLH9
         ezw3+qnDTGEU6FcFMGvli34xudLOHj7gT3+wZIShc/icynLMZ2qQjNW8btsW075lp/Bs
         1IjJQqQQYoH4DUz2XtJ3HgWQ/nsY9ndKOeVo1dS+/5TkrnIUQ9XsJcdbTwO7YE0XaD5K
         syQ8sj5EjAoFGd8al8fSidh2BXhpCxof3WHmFyrNIda/i3568eUs9cTPdbaN6rVCkUqr
         11JDJP8TokQn+64wbJIGO0nB2ScxLj2V1G/5nRheS0ltpymFG2uMFzJ0DPo2WMpO/W9q
         ybpg==
X-Forwarded-Encrypted: i=1; AKwUvBwvqlIVXrnsaVcL2P4S/X+Bz+Xzvvy7YOsjcC70/UtXCj+O2cSwXS26h2kERsp0vAy+9clSTBhO+g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLz5vhZQUckrEUy/1a4Npk1x090+NFWoIWJcxRvZCjI0EgRJtS8
	mSyHU5VSFc77cgcyjKcTp/mfKiZv+kTjbnMCPiqBOL7ssHCrXK7eiMUw
X-Gm-Gg: AYBFou0e0ehMrnhjAOvAET0mMrRj5+7xHiOYmvefO7ZhwPhuZO5hYK5ELG3JtYpaWlz
	7XIYYUp6TF5/5I5eb+lvUJOqRmtGUCek6NYGOASJQL4vYrwG2YmVLEEyGNQr0dzi4Rm7npBrpCr
	HPp0HvRoVngltkhVzWidus38qQ76VE6nJaAhjKx64QC/8WzxKzewbs+jiMKWmvv/fWZOEx89jEX
	6nrCg/M/xRjTvvCjmrP8K/flWWVPZ4bF9G9FZXwtG0MElUGXINZNJwLJWrRPU1xCbgn5Mg8DlFU
	USKkutZz14fn13IotnW7tYjeQPTIAFNqSkUOqsLuY1nX69DH+cqEPPg6gJVd2LDmk0gwaCs5lWg
	7t04Yq2Aq8M6arMAVbRNaeMBCjOFwwM7EBdDhv4dxSZJcCX5JNED6ktr2A1d9Lp61EAgn3qVytz
	3v3dfBghFWhdLoOw3uFwWo7VOFTGcXWjh+hvr/nQDA4x6TOvUUy6MfWyrXTcZeO3Ef7IR3YWDhL
	+KQSwzBMlBZbrnGlwTPNijNBHtxEJTgh52CYpG40VhyXuXIEwbz177FzrP0MtjangdRN6ie
X-Received: by 2002:a05:7301:241c:b0:353:7f47:8168 with SMTP id 5a478bee46e88-3537f479117mr15344492eec.17.1791818446888;
        Mon, 12 Oct 2026 08:20:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:c1bb:8d21:6c07:8107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35a352d4b05sm14939172eec.19.2026.10.12.08.20.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 08:20:46 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] thermal/fw: Fix kernel-doc parameter names
Date: Mon, 12 Oct 2026 20:50:32 +0530
Message-ID: <20261012152037.33461-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc for thermal_fwnode_cooling_device_register() still names the
old device tree arguments np and of_index, and
devm_thermal_fwnode_cooling_device_register() documents fw_index rather
than fwn_index. Rename them to match the code and reword the device tree
reference as a firmware node one.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/thermal/thermal_fw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_fw.c b/drivers/thermal/thermal_fw.c
index e8bd2049c..7c28bfada 100644
--- a/drivers/thermal/thermal_fw.c
+++ b/drivers/thermal/thermal_fw.c
@@ -11,13 +11,13 @@
 
 /**
  * thermal_fwnode_cooling_device_register() - register an thermal cooling device
- * @np:		a pointer to a device tree node.
- * @of_index:	a cooling device index in the cooling controller
+ * @fwnode:	a pointer to a firmware node.
+ * @fwn_index:	a cooling device index in the cooling controller
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:		standard thermal cooling devices callbacks.
  *
- * This function will register a cooling device with device tree node reference.
+ * This function will register a cooling device with a firmware node reference.
  * This interface function adds a new thermal cooling device (fan/processor/...)
  * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
  * to all the thermal zone devices registered at the same time.
@@ -71,7 +71,7 @@ __devm_thermal_fwnode_cooling_device_register(struct device *dev, struct fwnode_
 /**
  * devm_thermal_fwnode_cooling_device_register() - register a thermal cooling device
  * @dev:	a valid struct device pointer of a sensor device.
- * @fw_index:	a cooling device index in the cooling controller
+ * @fwn_index:	a cooling device index in the cooling controller
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:	standard thermal cooling devices callbacks.
-- 
2.46.0

