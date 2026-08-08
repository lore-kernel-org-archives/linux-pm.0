Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A537755C
	for <linux-pm@vger.kernel.org>; Sat,  8 Aug 2026 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786225518; cv=none; b=OlqsWDa0HLZTkUbUArCKd8sYj99K1VjY6yXELVfoY22Vr7Q5+GMIGw2kGHrrYothIthnikgM83t52CjI7PKR0Lnm3Q/clTPlVIrWG4U7bD+oPmPcJ9E5ajRkCsNYMAHS9ggPx0RFEufgV9i+v7T7ptywB2GtmRJR419sfvgJ3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786225518; c=relaxed/simple;
	bh=hOGTV5ZOsL4kx/Q0FR6cxiFxpMfZE+LbKJAIogwdIRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYufolJuhz+WOv6JxkQ1E3aNtks4OqT9SP9AQ6FzJ5s+iJaAyUq/SaED1ADqjwhT361i7Xg4Xk6o35C3mMr0u/ZGQ3BPsxw3B8gyjjEeqg9Qbta46uC+ALn5rQGTDRcAMrMBo71BMROYKJTSXWXvBprVYkiTWEh6m7ssXfSqusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icXHXXp1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icXHXXp1"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c998fd549a8so480291a12.2
        for <linux-pm@vger.kernel.org>; Sat, 08 Aug 2026 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786225517; x=1786830317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TWzyFxcV5fFu/M+6J2M1a01Ovc9+42gveuGFxl2QWXQ=;
        b=icXHXXp1eULjMMAkoglcxSm3UbEiYi1Dl//6L6Eez4erQqFjw3eXzjJPQPVXbcOy8n
         MMtdmriCsaGttNxM4FMa58G68NlPQkeQanKEhkY6zRpUhXyx8UVH0H4ZBgt1GrqgC6JY
         HLl2oHbbxPqW1IzN57FErIKNZaWweT7EqdIhAjVpEOebAOiXPNJPrJPpcuw/aMHESdDC
         cqSvV+3ru5iLBZT5wGuuInk4iJmgrr1hJFNgNsKGlFCPvb31ehUylh3e5ebxcD5ZNrHS
         dVeStllTGc6v/toAaKr3OLC54/xR/Wt7QGKN+XpelDsS0pezqpRdrC5ATMFv9aJmIkfL
         YkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786225517; x=1786830317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TWzyFxcV5fFu/M+6J2M1a01Ovc9+42gveuGFxl2QWXQ=;
        b=TtpOJDj/8Y+0QsMto6EX++gyRAOE136c2L02IaaOvAgEDwxnLSGftv2AOLnZURIWvq
         G8UD9QjBR7ZFaktOIvMlg0NQxb70c+ZLE9zPrY0MrdJbCZn51iReMSSyFHINs9hj+rwi
         HafLIeb+sY0twFkcwm24MFaS1UyW6IkvIVbbEn+9EdZc2QJkdeXDPDTQuIwaYYG9+kUU
         X84lS+U09GUZnAM7azRQr3j3UCJZAfTu8r6jQl5JIq87WqDiwQDg7orAFlIv5rbL9+35
         D+tqdi6IIfyA4Zu5rQL20DL8X3vmQCfxlISuI56AqmmrA5lnG/uAD2QJkBivlRFwdn0X
         tdnw==
X-Gm-Message-State: AOJu0YxQDTjKUwN7QeZ1MBDLdSGEz/4qz0Kap5qf4x9F028baB9dLViL
	k3OTzbNyka5dmiRTSyHn1GaFbBmkjxa8z2c2L4cP3Fw49uPnaZloKTRM
X-Gm-Gg: AR+sD10gPzK/XBLO8i9lXGK5iTNoPNpQDIO9VYHVtmIKZE9E9rhsC8rh6ApgJ8E39gn
	4NyQ4yAYRD9A4R+PTx2ETG0wnLRO+420Ot5Q1NtsMplxGa3bjeodwnf3iQ7d7XRKGpfnWQLi5EF
	Nk/XW7hUkaRoq1Mha9xXTLYTp+OXgJhwAgi3q0Q1Xr4VdWwEUDC7KZvbTIHeES7ywC5FzsN1saE
	wgspARqAxlVlc+bpDCpzsSBxHJ01IsdaKQBqecaOOpwDCDaKMWNVr9gfZiqUtYN6IZgI8NRkCYA
	JEloHw9R0Xa66c9qdZ03zOg/DLNc0bw/mwbuaLZr1Z9tKvk7vEwt4HdMdFjhBr9eC6GMAcuYpo1
	KoINQ/L3TTq483aKCOiAV1j5hKxxmzynzidMAFWezm4AZG5NGCGf+344A4UnCOdNeaXXLeP65uO
	6MMl5GtDeowTM9vxxZHCbJhfzEoPxA1ljJSn7vudt1g5/+NJbdS3ppy5qUEmA9KMqNx0hN1jaMY
	nFRBxdb1Z/bFOgZaA1+cAobX5PVDtXw78kFk0PCemqFjK405VqYSTy1XPBvgOeMQ71otnjB
X-Received: by 2002:a05:6a20:cf8d:b0:3c3:94a8:7c18 with SMTP id adf61e73a8af0-3cb8603af1amr40795284637.37.1786225516634;
        Sat, 08 Aug 2026 14:45:16 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::6868])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f35b781sm2194551a12.18.2026.08.08.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 14:45:15 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH] power: supply: ds2760_battery: fix NULL pointer dereference in w1_ds2760_remove_slave()
Date: Sat,  8 Aug 2026 15:44:58 -0600
Message-ID: <20260808214458.201324-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

w1_ds2760_add_slave()'s failure paths (di_alloc_failed, batt_failed,
workqueue_failed) are all empty labels that just return the error
code, with no explicit unwind. This works for di itself and the
registered power supply, both are devm-managed against the w1 slave
device and get cleaned up automatically. But di->monitor_wqueue and
di->pm_notifier are not devm-managed, and are only ever set up in
the success tail of the function, after the workqueue allocation and
power supply registration have both succeeded.

The w1 core's BUS_NOTIFY_ADD_DEVICE handling in w1_family_notify()
logs and returns on a failing add_slave(), but does not prevent the
w1 slave device from later being removed from the bus, which
triggers BUS_NOTIFY_DEL_DEVICE and an unconditional call to
remove_slave(). This means w1_ds2760_remove_slave() is effectively
the only failure-unwind path for a partially initialized di, and
needs to treat every field as potentially never having been set.

Currently it does not: it unconditionally calls
destroy_workqueue(di->monitor_wqueue), which crashes with a NULL
pointer dereference if add_slave() failed before or during the
workqueue allocation (e.g. on a power_supply_register() failure, as
seen when a colliding sysfs name from a misdetected slave device
causes registration to fail).

sl->family_data can also be NULL if add_slave() failed at its own
allocation, before family_data was ever set, which would crash on
the very first dereference in remove_slave().

Fix both: return early if di is NULL, and only call
destroy_workqueue() if monitor_wqueue was actually allocated.
unregister_pm_notifier() and cancel_delayed_work_sync() are safe to
call unconditionally: the former is a no-op if the notifier was
never registered, and the latter operates on the embedded
delayed_work struct, which is always validly initialized by the
time remove_slave() can run with a non-NULL di.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217832
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/power/supply/ds2760_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 142c7492c3c2..3c2433f6b5e9 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -723,9 +723,13 @@ static void w1_ds2760_remove_slave(struct w1_slave *sl)
 {
 	struct ds2760_device_info *di = sl->family_data;
 
+	if (!di)
+		return;
+
 	unregister_pm_notifier(&di->pm_notifier);
 	cancel_delayed_work_sync(&di->monitor_work);
-	destroy_workqueue(di->monitor_wqueue);
+	if (di->monitor_wqueue)
+		destroy_workqueue(di->monitor_wqueue);
 }
 
 #ifdef CONFIG_OF
-- 
2.55.0

