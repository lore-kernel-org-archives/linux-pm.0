Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E7559C8D
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707665; cv=none; b=pyi+eCw7lCWGm6gUgRaOBayChPoxQNYtWJ/yNLwnUjDxLHacx7SCjCbC9Obm0Q4GEKVS4QgZ+/t3J9oO1ujqTKNoiZzQsL6l1l+H9WugNJvizSIMMLsHKq/VM6Ga/RlLaUKHWTocVbVB6s3NmhbC5FO/XLnzb7FUW/yPXVMTQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707665; c=relaxed/simple;
	bh=z0Pi4B22PzS1+uUdLqH1RmbsVdNDUkFA8bOOdspYgEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/NLcF/67TDVfALh8VQeBPCPF4vL4R+1hP1yrcQg+dOX/NJcHx2I2p3PTs/lP+z94rbhrOLZTF0dvJFWljEd6ZzjlaRPhcoDnjKJbK3s/TalxBJsmx0FvT+epnA86mT/58igSmCDnH+mBQfS7E0ZmYkUTOEOHHBW7I1kVxRyQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UBxzsfp8; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UBxzsfp8"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-14ba4dcd563so352360c88.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790707663; x=1791312463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ts6qeE54OHwqDLqAUGkkPdOGcZpkcyC3qTl3pMkR4w0=;
        b=UBxzsfp8ps2a0aXQA8mWsMO5cIsDUluKTn2UkTLs18jaGQndy3+aAd5TIxaK0GAeQ7
         /1FlqfDo/6Ev8kYxpQ+FepqrS/LAN6u3U+KzkTq196cjn1yZb/O5FtlyVCHt7ZGkRmEr
         3Km38AdRgt18mAk1JyTQ/RF/p3IYjlgtBK004=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707663; x=1791312463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ts6qeE54OHwqDLqAUGkkPdOGcZpkcyC3qTl3pMkR4w0=;
        b=NqP4mqS0Qs0sTvFX7XDsP2FjjPpsPwq8WQBFg0wODWtWohL+/7SZ/wnCUkHId4fK3K
         2Q8Kjy7vyJDDnkbHw7M9RT4D5ilnkeS0Kqt5GDFAongM79lZmcMVhwtMU9px2ugC6z0i
         3ThmlnS1gpSMg+IlgI8qLrgiBPU302rhQv4oWkYA+mWoYTkvXBx0YxTuNmBHDjr5QHMX
         V8wTJVQJlAkrF7WxVzOUTgsbH1Xndp4u5x4WGJ/9f0IpMxLMgrUsmDV/8LHZBlBdkib8
         x683CgO4eRmMaZJe2kI4nwvGRpymk6vUsvbKIJa3c5Qe33s3WFHqcW4HokofaNOHzmPj
         oyww==
X-Forwarded-Encrypted: i=1; AKwUvBxkmg8efZUHYFLuHlycp1HBsiIUTurWYgAxI6w2BgbppK1Slk3eSihL/xZ1G1Mnuh8qVUs7rEfmLA==@vger.kernel.org
X-Gm-Message-State: AFuF++mQ+Vkl1vXgps+MOr2U5hMCV07VesBYKVXrr5aKls9N4uOpbzd8
	ry8rD66kLpNgN2SsogK7c1Hx7o2hlelu98HtgSVCtymicr8sMgTIbUWc1u9lSTykpQ==
X-Gm-Gg: AYBFou3lrQVlEc6uAynHfXb8z2LwtvyEu2jF2gKOgXEcdG3Qqhwu755znTLqkzSRGiB
	eumE3Bp5WOvPQiHmmAycaD6SyW7IZEwUfwUIOGTFP0asQz+A2xVcaEp+F2ZczJj45qW2LRYFALT
	RPL3fbk624RSi3Va9usVi2fFv8lumAIg6v8MhVueHyXRW1ARU7DfO4jjI5NPelcZe1Hf2ZUczq+
	vdDrDlTKXi/eXUnqjdJJGi9hcHLbPxvIXHOqY14uxEt+PeUBg3zcwn+j8bBksv1I7FRboSNE/fy
	kyQ7FPYEz7hyamgJ6ayx8FNU6r7LOLOQtSXAU6qukCHh+IvyATXIzV9lim99+8/99GT83NSPJs8
	jw1Xa9f5tsar6z1BqCKkNspAPaUcMmHTxQ4C+eunggPRflgm33EGkvKGQi37eK6ms+phBsMBhcM
	h8lTb8hba2DVgewimBub3d1ihrxko1X+vHaRnjtas60A4V8w8cS47OiKkQFtYaLrvrnUV+3qHZI
	N9sa86ri5NzD9q8Xztr8v9jLEPhh3XSamaH
X-Received: by 2002:a05:7022:2588:b0:143:2974:bb05 with SMTP id a92af1059eb24-14c9e0ad25fmr123939c88.31.1790707662973;
        Tue, 29 Sep 2026 11:47:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-14c640bcb24sm833020c88.12.2026.09.29.11.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 11:47:42 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-pm@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/5] PM: runtime: Cancel pending only during non-transient suspend failure
Date: Tue, 29 Sep 2026 11:47:11 -0700
Message-ID: <20260929114714.1.Ibec91ccb2c418f97b240cbbab606b0451e3febc9@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260929184729.2346769-1-briannorris@chromium.org>
References: <20260929184729.2346769-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If runtime_suspend() fails for transient reasons (EBUSY, EAGAIN), we
intend to allow retrying suspend in many cases. However, on the failure
path we unconditionally cancel any pending timers, which means a suspend
timer scheduled while the callback was running (e.g., via
pm_schedule_suspend()) may be prematurely aborted.

This seems to have inadvertently changed with commit 72263869656d ("PM:
runtime: Unify error handling during suspend and resume"), where the
error-handling logic in rpm_suspend() was subtly changed.

Fixes: 72263869656d ("PM: runtime: Unify error handling during suspend and resume")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index bb008dfe85a1..bc5905ffc45f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -749,8 +749,10 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
 
-	if (retval != -EAGAIN && retval != -EBUSY)
+	if (retval != -EAGAIN && retval != -EBUSY) {
 		dev->power.runtime_error = retval;
+		pm_runtime_cancel_pending(dev);
+	}
 
 	/*
 	 * On transient errors, if the callback routine failed an autosuspend,
@@ -762,8 +764,6 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	    pm_runtime_autosuspend_expiration(dev) != 0)
 		goto repeat;
 
-	pm_runtime_cancel_pending(dev);
-
 	goto out;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

