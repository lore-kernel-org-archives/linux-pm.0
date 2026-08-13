Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C682F2619
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581697; cv=none; b=UWwWbmGbO85ijDb6RkTtaAxofvy3zPGl3A3d0ebUWU5JzAQ2UgQqN/6a7Evj42167tM58ozOkIQqdJ4DJJZm12Q6cvVPVyl/hbVQCyGgPfs7z6rS//qLITsw3sS/Mi3UeyfLw5cf+mKDlPPNg1ueKJNyl40GdlX7Fdzh1VHKcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581697; c=relaxed/simple;
	bh=gK4VHnD794W69hzgWuSYhi6T7iPzqFtFd762mzcDmWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn5vEsM23O6XOG7kskcUYaUD3aX7vZc2e3+u5GKLmI9xVQwMfsao0doFYVnctGukI6XQ3D3l4KTxKqjO8Uys+baL6d1uEsxLPuRHu9+K745vV2c6pVyfIYWK4f+zFLOMjsIkzik7EuZ37/BBNfw9b/DJy3o9Q0mBmB2/pW405ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuGc4unQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuGc4unQ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848643382fcso1565785b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 17:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786581695; x=1787186495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKZ+tYZaRm3RjjXw3TITpeGuQSuZYB4fY2WfHyZhtaI=;
        b=QuGc4unQbWP9MHKsWrwFJgbPx8dADhgybyRkbU5hhEOZBgjOdqdjOSbuOiCPt6uFMW
         wRC0cbfr72ermNWb5YR4wKxw6mGZJ4iK7fyp+9+nbNP32ELxKrQdHZO58eNWwiqQ5xYc
         Cko9gXlJzg6evjTyY05OMoNZ6MxhDm9qCtRod840JHv+2aElp6uN/30iQm40vGsul8pe
         J7ZfvgKzIxAWNISI+MuWOCnASSTKZ7gsZaeZ01+0ArvYpQbXsbw0mdf8RofJeMd1sVqP
         tqPMmuW3Wuf9kqA9JU3n17jVebn7NltFsHnhmhNbQKc3APMHJOFVdv28MS+zzHalgrOy
         wLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786581695; x=1787186495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKZ+tYZaRm3RjjXw3TITpeGuQSuZYB4fY2WfHyZhtaI=;
        b=BOtlyfdI8nuWZD5C4bX3e85nIhxnjEgzSfdNHCw1fOEP9UKqeVYwNMcV966Z6d/Tc/
         XCK117Ec1zrW0eR3yPb6EBZL2RxszcsPn32QVVcOvHR+UZ96e3t5WPBQxi2AFcI4nVZe
         nwAZJWY6pxx+kAJmN2RTjnOo10knEpOTavktPDlTDmQDKDjV1Rg6woTACD5JM/Yu2w1O
         XFolf99cs4nqT1pi6Q1KjzYMejWqeB1l5AcZqApB5ZGqyBSfbVdaiCuChWem/QP9mCeN
         +gv7SmS/rLGXR1UkNmJ9//fOc1fBoLkNmgRxETy3/qq/lnlywZNuGZ8Ckgux7rcv1muv
         ci/Q==
X-Gm-Message-State: AOJu0YzC/pBulTlfHAR3hwELqNdX8OAmDtR5g0Jfg6IyIMnVNXAsyYUW
	B4YW6659gfnnjE1F6sHHpFleVPiOmJfRg8lo5uverhVnHaq3vTlCb19h
X-Gm-Gg: AR+sD13q5UBbBx0CUgS/BQLeeqmWCvQukr8Jf4sTJttLMQ5uTpFEpSyiU2mwCsgtbmH
	tEqcKhh8xz2HW4rCwArs6vJCSXbamKqF8M2o0PrTnD3UloLGUqL4Ow0rHr1Ig9rc3N13Qf+cuze
	oU1Sa+3vzUVJh93HaMN5AdBGv4jrkb16iKxMYDr7dLVEfDI8YGhjD+LsQGnypBtNDXx/bS8EEG4
	JEjCf53ZQMaOVPZGoQffnOJAo+gq0Q82ju1/Sk45Zl/eqlo3EPiV0h8EItssLVgilyycBGBXglh
	Na6fBqJLilCQw4r74m0jhhvlX8PaJz/EySnQ9E51gQZqw0BJcSyOjRxn9N/p97w+QrXPnscHJAk
	zh5ikqiu+j32mHnQz1KdgBJ5pzrKaIEpQ4vB5SLrgbSqHuF4KdPJ9ne4jM6hlsw0f02zMZi1dDU
	OpQ4NtKVDn9/6gmjaoifgBNf1N0C5XDPXaFsTJQPWW41K/GnT5ZlDSy5ip/FZHx3Pi5JZV19NlB
	Mc5pv/uixCV6yVkJyLFvuFU0MaHD+4+6ItpXsPU18w5IuBHabzbVqrpEKgmWd+30c6NjZ/Q
X-Received: by 2002:a05:6a00:4ac1:b0:848:6c9c:4074 with SMTP id d2e1a72fcca58-84fc7456367mr1942582b3a.1.1786581695121;
        Wed, 12 Aug 2026 17:41:35 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::6868])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc4565c6bsm207084b3a.3.2026.08.12.17.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:41:34 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH] w1: fix spelling mistakes in comments across the subsystem
Date: Wed, 12 Aug 2026 18:41:13 -0600
Message-ID: <20260813004113.29943-2-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813004113.29943-1-skunkolee@gmail.com>
References: <20260808214458.201324-1-skunkolee@gmail.com>
 <20260813004113.29943-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following up on a prior patch that only fixed w1_netlink.c, sweep
the rest of the w1 subsystem for the same class of comment typos:
"loosing" -> "losing", "deatch" -> "detach", "messagse" -> "messages",
"continusly" -> "continuously", "attribut" -> "attribute",
"deactive" -> "deactivate", "determing" -> "determining",
"discrepency" -> "discrepancy", "rerurn" -> "return".

No functional change.

Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/w1/masters/ds2482.c    | 2 +-
 drivers/w1/masters/ds2490.c    | 4 ++--
 drivers/w1/masters/omap_hdq.c  | 2 +-
 drivers/w1/slaves/w1_ds28e17.c | 2 +-
 drivers/w1/slaves/w1_therm.c   | 2 +-
 drivers/w1/w1.c                | 2 +-
 drivers/w1/w1_family.c         | 2 +-
 drivers/w1/w1_netlink.h        | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 0069e6f854d7..040d66415a9b 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -421,7 +421,7 @@ static u8 ds2482_w1_set_pullup(void *data, int delay)
 
 	/* if delay is non-zero activate the pullup,
 	 * the strong pullup will be automatically deactivated
-	 * by the master, so do not explicitly deactive it
+	 * by the master, so do not explicitly deactivate it
 	 */
 	if (delay) {
 		/* both waits are crucial, otherwise devices might not be
diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index aa1f57f74397..3a0740d91a53 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -562,7 +562,7 @@ static int ds_write_bit(struct ds_device *dev, u8 bit)
 
 	/* Set COMM_ICP to write without a readback.  Note, this will
 	 * produce one time slot, a down followed by an up with COMM_D
-	 * only determing the timing.
+	 * only determining the timing.
 	 */
 	err = ds_send_control(dev, COMM_BIT_IO | COMM_IM | COMM_ICP |
 		(bit ? COMM_D : 0), 0);
@@ -691,7 +691,7 @@ static void ds9490r_search(void *data, struct w1_master *master,
 	 * If the number of devices found is less than or equal to the
 	 * search_limit, that number of IDs will be returned.  If there are
 	 * more, search_limit IDs will be returned followed by a non-zero
-	 * discrepency value.
+	 * discrepancy value.
 	 */
 	struct ds_device *dev = data;
 	int err;
diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index d13db3396570..0982efa2b25b 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -282,7 +282,7 @@ static int omap_hdq_break(struct hdq_data *hdq_data)
 	}
 
 	/*
-	 * wait for both INIT and GO bits rerurn to zero.
+	 * wait for both INIT and GO bits return to zero.
 	 * zero wait time expected for interrupt mode.
 	 */
 	ret = hdq_wait_for_flag(hdq_data, OMAP_HDQ_CTRL_STATUS,
diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index e53bc41bde3c..d656233afe54 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -101,7 +101,7 @@ static int w1_f19_i2c_busy_wait(struct w1_slave *sl, size_t count)
 		timebases[data->speed] * (data->stretch) * count
 		+ W1_F19_BUSY_GRATUITY);
 
-	/* Now continusly check the busy flag sent by the DS28E17. */
+	/* Now continuously check the busy flag sent by the DS28E17. */
 	checks = W1_F19_BUSY_CHECKS;
 	while ((checks--) > 0) {
 		/* Return success if the busy flag is cleared. */
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index d96b224e2215..02acf84ffec5 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -355,7 +355,7 @@ static DEVICE_ATTR_RW(alarms);
 static DEVICE_ATTR_RW(conv_time);
 static DEVICE_ATTR_RW(features);
 
-static DEVICE_ATTR_RW(therm_bulk_read); /* attribut at master level */
+static DEVICE_ATTR_RW(therm_bulk_read); /* attribute at master level */
 
 /* Interface Functions declaration */
 
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 486f321eadc8..67ea14a06319 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1177,7 +1177,7 @@ int w1_process(void *data)
 
 		__set_current_state(TASK_INTERRUPTIBLE);
 
-		/* hold list_mutex until after interruptible to prevent loosing
+		/* hold list_mutex until after interruptible to prevent losing
 		 * the wakeup signal when async_cmd is added.
 		 */
 		mutex_unlock(&dev->list_mutex);
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
index 97da4f156e9a..8152a43c8c76 100644
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -67,7 +67,7 @@ void w1_unregister_family(struct w1_family *fent)
 	}
 	spin_unlock(&w1_flock);
 
-	/* deatch devices using this family code */
+	/* detach devices using this family code */
 	w1_reconnect_slaves(fent, 0);
 
 	while (atomic_read(&fent->refcnt)) {
diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
index 449680a61569..1818a06740eb 100644
--- a/drivers/w1/w1_netlink.h
+++ b/drivers/w1/w1_netlink.h
@@ -14,7 +14,7 @@
 /**
  * enum w1_cn_msg_flags - bitfield flags for struct cn_msg.flags
  *
- * @W1_CN_BUNDLE: Request bundling replies into fewer messagse.  Be prepared
+ * @W1_CN_BUNDLE: Request bundling replies into fewer messages.  Be prepared
  * to handle multiple struct cn_msg, struct w1_netlink_msg, and
  * struct w1_netlink_cmd in one packet.
  */
-- 
2.55.0

