Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5324DF4D4
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328854; cv=none; b=hWIb/ZBwmXzOliNXxl36g2WdwcRyJk7sDa5e1QnxmvfAZtEYNcjYVV7VRmVOITbzDoPtrOg+hXVaHbztVsXQz6CnI6k8gFUegvRAVeBzU1KOQ7HTxVOY5zo/sDFZirnAEnYdyXRmq7jVo7LhZyjGxoG+9ZxhptYjZaZqM5MakrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328854; c=relaxed/simple;
	bh=kiICEqOeglw2XhrB/k+kI2Fjx84mu7DdAPoRB55wjkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMBUn+tPubSdagE53xKjDNuhvEpZ6vBnQCbx6vv9wxBZeYXY+QiF8bgR682VFRx0wnUTC3Qe1SqA8KZPiGZ6chpRyiNUslPd2gDpCC3do1+jh8QmIjNZeoyOa7I8FjBRIpDyN5NKk5t1NH9yfQgcpS1gAuiZlsIKbhWuG8NSML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SiNncF2d; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SiNncF2d"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-141395927feso1727620c88.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328828; x=1791933628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U6RGc5+cjEK9f48M6mR6i/w8C3QZRcmDe6I17iH2K3I=;
        b=SiNncF2dQNqGsaPsFnXVolnEsAuOld+b293Df7vGaZeSJlAikWsNeIWDw8f6DZNst3
         zL7HIQ2OWE98itZP7dfQ6lxP3FiW/lExfJ+5idk3mMGZ210a0QEYBuzav+46+i9Qgb1Z
         iRNHAJBpn83O40SIHpHF9WlwKw1m41DTtGbRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328828; x=1791933628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U6RGc5+cjEK9f48M6mR6i/w8C3QZRcmDe6I17iH2K3I=;
        b=OfS3XETRu6njz0t2RU4urRQJI1ZARktnrfdk6WBmqONDyHeSJrlhSm28aBFwmb1M7E
         gntRbdRh//3badS9Cc5Z6zOxKNzm3bF/xxJGyP/qZhEkY0OaqO04gErND8jyiD85j2Ed
         PHt357oBPL+fJYpgCKRT7uoYpMW7SJq21xolOpRT4O6vSMSP5AQgefLRjIBo7vza+ez6
         FBTz2EPqMRYv8TPKjdvB3e52k8XuCRSXPUXDYwdNx/6DZ82/jyRzRhOputdfU/jQRA+c
         wUFvOKCgOUyvtosXzy96lGz3CKIrUIrsx1tZKg8FQCPggeOQwnk7hAOqNN5ShSS92utS
         fTqA==
X-Gm-Message-State: AFuF++mCcLa4l2qaLIZU+Qi9W/hbnZMxf2aqEJyh6uGBp8xLSYNSv31F
	59ZRDPzn1OZTyLo2ascCZbVxNlnSx8ZC2A/Gx/xwgxkYsdwmvBmPZHHzcCQo0JrXvxzzQMbdi2z
	KgjA=
X-Gm-Gg: AYBFou0IW8NBfNK/Eua20riLOluysQAwfE9SFm68BonHKSyA/CsJRl/Il/zNu2fLo0x
	ozRhUq0nwJWQYHBj8AuMF+X4PnfT86yOqij4Ia8QiBuytSL0Xv7yNe71BBzRtV8lvdFg2yuVOXM
	CY14FYicarM2rpTHCbLPr1MEAzImCxyajb3/f1Mqa5lOGotX6QmXn3AsdoP93Ga+ctLX2kN8mlg
	7Avv3W+k4m3RpJbTPzODv+N3Qsbai/ROAC8jJv3qBguKNXwfBGiP9QuCUfOGpVpI9tAwrhGvNId
	7UghrsN+I1V+TcX0VhHxnY+qKp6QoFhUV5FpjPLB0O19L/4/9fhnXZ3f7t6P7zQkCPhjYB3ym5y
	hXRFpJraXTBPgFYB7q0ZiC1/At78k2M/P7XgPlYyu8w9J8j/uII1v5LF4FD0AmQoZJ1VU3OsABc
	EXDaxz1aFdQrKmCT9990WBKJLJdxdjS00ADbp4mqCsT/B6xOtkTb3PsDKxOXecN2dbIA/LBLIYk
	FDWu3DaENz70X2VMqGAXjSgUiQ3tfExiMh04kk=
X-Received: by 2002:a05:7022:225:b0:143:298e:459f with SMTP id a92af1059eb24-16207e73dbfmr475520c88.42.1791328827603;
        Tue, 06 Oct 2026 16:20:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-161564723fesm1537626c88.0.2026.10.06.16.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:20:26 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 12/13] PM: runtime: Drop pm_runtime_put_autosuspend() return code
Date: Tue,  6 Oct 2026 16:13:40 -0700
Message-ID: <20261006161337.12.Ibc0cfab4a29c61d5582a164da2d9e98049c20910@changeid>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary role of pm_runtime_put_autosuspend() is to update the last
access time and decrement the runtime PM usage counter of the given
device.  It always does that regardless of the value returned by it
later.

In addition, if the runtime PM usage counter after decrementation turns
out to be zero, a timer or work item is queued up to check whether or
not the device can be suspended once its autosuspend delay has elapsed.
This is not guaranteed to succeed though and even if it is successful,
the device may still not be suspended going forward.

There are multiple valid reasons why pm_runtime_put_autosuspend() may
not decide to queue up the timer or work item mentioned above,
including, but not limited to, the case when user space has written
"on" to the device's runtime PM "control" file in sysfs.  In some of
those cases, pm_runtime_put_autosuspend() returns a negative error code
(even though the device's runtime PM usage counter has been successfully
decremented by it) which is very confusing.

Accordingly, to avoid the confusion mentioned above, change the return
types of pm_runtime_put_autosuspend() and __pm_runtime_put_autosuspend()
to void, similar to commit 3afd8df02433 ("PM: runtime: Change
pm_runtime_put() return type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch must be applied after all the preceding patches. Presumably
that can wait for other maintainers.

 include/linux/pm_runtime.h | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 322e3b17f987..b0e7dfb3805f 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -593,22 +593,10 @@ static inline void pm_runtime_put(struct device *dev)
  *
  * Decrement the runtime PM usage counter of @dev and if it turns out to be
  * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
- *
- * Return:
- * * %1: Success. Usage counter dropped to zero, but device was already suspended.
- * * %0: Success.
- * * %-EINVAL: Runtime PM error.
- * * %-EACCES: Runtime PM disabled.
- * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
- *   change ongoing.
- * * %-EBUSY: Runtime PM child_count non-zero.
- * * %-EPERM: Device PM QoS resume latency 0.
- * * %-EINPROGRESS: Suspend already in progress.
- * * %-ENOSYS: %CONFIG_PM not enabled.
  */
-static inline int __pm_runtime_put_autosuspend(struct device *dev)
+static inline void __pm_runtime_put_autosuspend(struct device *dev)
 {
-	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
+	__pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
 }
 
 /**
@@ -619,23 +607,11 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
  * Update the last access time of @dev and decrement its runtime PM usage
  * counter. If the counter drops to zero, asynchronously request the PM core to
  * suspend the device once its autosuspend delay has elapsed.
- *
- * Return:
- * * %1: Success. Usage counter dropped to zero, but device was already suspended.
- * * %0: Success.
- * * %-EINVAL: Runtime PM error.
- * * %-EACCES: Runtime PM disabled.
- * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
- *   change ongoing.
- * * %-EBUSY: Runtime PM child_count non-zero.
- * * %-EPERM: Device PM QoS resume latency 0.
- * * %-EINPROGRESS: Suspend already in progress.
- * * %-ENOSYS: %CONFIG_PM not enabled.
  */
-static inline int pm_runtime_put_autosuspend(struct device *dev)
+static inline void pm_runtime_put_autosuspend(struct device *dev)
 {
 	pm_runtime_mark_last_busy(dev);
-	return __pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 }
 
 DEFINE_GUARD(pm_runtime_noresume, struct device *,
-- 
2.56.0.360.g66cac248cb-goog

