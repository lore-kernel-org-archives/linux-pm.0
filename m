Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A6420490
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556825; cv=none; b=f4ktIH+r0rMPrhLh7lS+B3PpegYdGe90usVzUyrtCTFt9BC46vA6JtvaxgyLucA8pYvihCn/1SIT+DxkC3OACveCH42UvfXSTg8fX9EiT1dzg0e8UH/PyvLkLhvzVGHCT+HkXmO1RQ0oYT6XnWuZfoq8w6hqAv9VBU2awSGYg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556825; c=relaxed/simple;
	bh=GjCuMqwTKFKTr1bVwbH2MBuyd3Kpcf7SljlzS5pGAKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QenhpYr+Hsqx5yuIZWlGzcW1g34WSF1MsAnwwx8yzPdclb8m1cI+gEHNxTdyZXhRld8wC1LNynydXiZ5c10acC2tMFgeR3BO7I4PJFoHIo/57vW4+5trplukWMnHbITej0co/krx34Lt1UIuMFnlQaiFe/D3W/Hy9s9qqWJCXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qy1yQPsN; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qy1yQPsN"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so1352486a12.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788556823; x=1789161623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4nRO1s9pLzcSKrRPhFfQyfVY01to/RP04/bcAAweRU=;
        b=Qy1yQPsNXly+ocPuxiugGW+fldep9gQErsWfsfX7AHLcs5p2CztIcT5wwMW1ocvXpf
         KNZ6aE646NEOeHbGj2ezHc2TQbI0B9j8yD17ILK6QicMDksewjmY81Cud1cV+T6jpmil
         Lfox3eoaP/dwEOMtnJrmHVM8WEq97B43m5emc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556823; x=1789161623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4nRO1s9pLzcSKrRPhFfQyfVY01to/RP04/bcAAweRU=;
        b=tEXLOl7bQG1WY7KkzSGMF9i79jm/AHOyrHFscHObVRZjlIWIca4e1UVnyet0osuq3s
         gMq3X5OQ4IffUOAx2OTXGGx47dk+Jnf/GgY9k+QtNVKV0ury8MhNcQbob6c3+F+pwxfD
         Nl4+lx8BPsOZAcnYEaHK58ywbFzmMLMCcQq9j2AjK0gO4mX5pJKMEd86tlaxaazyKKSZ
         9YYjuLtUOnMY6TqnqjIQJsTY6vwugCa6xtAV2L2oao8vbKnQlRP4kHHwg8Sc3mwPdt6c
         CjQyW4B/ID6WQFOPNAfGWMr84cnpJpekDhug2IsTWAO3tMz19ygiqlRvl1ZRWw/hoSjx
         /ymw==
X-Forwarded-Encrypted: i=1; AKwUvBz0fz0B58cg6rtX1LvODNq5kfYlZnZ6UFgDaNesA7XnpWVaK/UrDkdz6t3CmUcT/bLtsoBSNAm72A==@vger.kernel.org
X-Gm-Message-State: AFuF++m2x8gLsqGmwm+onBru7YsVswchfRwydHxZjUdQt3BU80fZ5bA+
	pnPPh3N/I9447lissAipsUGe8rOAsu3P4+n3WMlnJXCgM/dra2u4TG7ayM/oyU187Q==
X-Gm-Gg: AYBFou2WzGCkJVTBqKPDA1ofW3MFWiQ9OhbwrDgbgIAYqqxCSC4zz+ryiOTTFRRrmcv
	eBJcKD1J/epcnFob/V9LTlkEz/K05yhjDQceUwrYEK655DikQvwZirA0Uk20+DEx99ms73oIhQ/
	2erEC7xHytypXWS9SlPCGc3cs9sB+AHCDFoggTwh5v2y5RZSCeZkw4TTwZ1TbhP0rQk0ryQ+Gvr
	Fet6/8tOyFSOJLLt+XtOax1k7zKS/itkT6UOu9ZF7ervtURczxw/xc7PNKXjx7DgPNwbeCwpo8z
	xglUh07Ft4aGMic7zhS4eFzE1qjPwbHj8ha6ENLjGTedAVQ18LSgy+4Od0Lst+K6nIOt28Gft28
	reeqlmMORA8BPrZosdDhPknPzxOUKhh8m7WaBbw3qOuMA1R4zPP4kN16LhYlQAVdvRKFvO9KziB
	9E7mwg8Va2lSDu3ecxi+IHjBXST8Omq+hlDbWZlqxuk+6/L4MjyZX/uUNvDw/jL25M6G3V0N+nF
	mObpgDvFxGKH/eDT/b9NGueVaI=
X-Received: by 2002:a17:90b:3c42:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39b260d2977mr12114905a91.4.1788556823137;
        Fri, 04 Sep 2026 14:20:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5597:62ab:c321:4a7f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1432423f99fsm8514617c88.1.2026.09.04.14.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 14:20:22 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 02/11] PM: runtime: Improve set_{status,active,suspended} docs
Date: Fri,  4 Sep 2026 14:12:07 -0700
Message-ID: <20260904141215.2.If02a538531ea004987c9a28a8d030ee9f71221cd@changeid>
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

The set_active()/set_suspended() docs don't mention that they also clear
the 'runtime_error' field. This is a very important note, since that's
one key purpose for using them.

Fix a typo in __pm_runtime_set_status() while we're at it.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime.c |  4 ++--
 include/linux/pm_runtime.h   | 23 +++++++++++++++--------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0c0931763d07..ce7e08e628a2 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1295,7 +1295,7 @@ int pm_runtime_get_if_in_use(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
 
 /**
- * __pm_runtime_set_status - Set runtime PM status of a device.
+ * __pm_runtime_set_status - Set runtime PM status of a device and clear errors.
  * @dev: Device to handle.
  * @status: New runtime PM status of the device.
  *
@@ -1314,7 +1314,7 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
  * If @dev has any suppliers (as reflected by device links to them), and @status
  * is RPM_ACTIVE, they will be activated upfront and if the activation of one
  * of them fails, the status of @dev will be changed to RPM_SUSPENDED (instead
- * of the @status value) and the suppliers will be deacticated on exit.  The
+ * of the @status value) and the suppliers will be deactivated on exit.  The
  * error returned by the failing supplier activation will be returned in that
  * case.
  */
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index ab6a19a85880..1ffd9d5c3010 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -776,13 +776,18 @@ static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
 }
 
 /**
- * pm_runtime_set_active - Set runtime PM status to "active".
+ * pm_runtime_set_active - Set runtime PM status to "active" and clear errors.
  * @dev: Target device.
  *
- * Set the runtime PM status of @dev to %RPM_ACTIVE and ensure that dependencies
- * of it will be taken into account.
+ * Set the runtime PM status of @dev to %RPM_ACTIVE and ensure that its
+ * dependencies will be taken into account. Also clear the device's error
+ * status (@dev->power.runtime_error).
  *
- * It is not valid to call this function for devices with runtime PM enabled.
+ * It is only valid to call this function if runtime PM is disabled or if
+ * @dev->power.runtime_error is set.
+ *
+ * This will fail if suppliers cannot be resumed, or if the parent is not in
+ * the correct state.
  *
  * Return:
  * * %0: Success.
@@ -794,13 +799,15 @@ static inline int pm_runtime_set_active(struct device *dev)
 }
 
 /**
- * pm_runtime_set_suspended - Set runtime PM status to "suspended".
+ * pm_runtime_set_suspended - Set runtime PM status to "suspended" and clear errors.
  * @dev: Target device.
  *
- * Set the runtime PM status of @dev to %RPM_SUSPENDED and ensure that
- * dependencies of it will be taken into account.
+ * Set the runtime PM status of @dev to %RPM_SUSPENDED and ensure that its
+ * dependencies will be taken into account. Also clear the device's error
+ * status (@dev->power.runtime_error).
  *
- * It is not valid to call this function for devices with runtime PM enabled.
+ * It is only valid to call this function if runtime PM is disabled or if
+ * @dev->power.runtime_error is set.
  *
  * Return:
  * * %0: Success.
-- 
2.55.0.979.g7e5102b832-goog

