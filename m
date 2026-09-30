Received: from mail-dy2-f36.google.com (mail-dy2-f36.google.com [74.125.229.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AF36CDF2
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736679; cv=none; b=qrpVOuXhGPOzm4t2YV+z4k9ebq6arl9FYXzI3SpqIaCiVaTsf8JGcP1MPheQaZOrqO3T3vHNiG2Pwef0mDTINdLCnVBVFD4HGqKxFT8h2KKnvD6QCx29qGYMDADKAPOFfyIQm7akNin3DcLOntsv+SgcWiaiqi/ferSfqwcA6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736679; c=relaxed/simple;
	bh=M18trrhOKmqRbT8jD766MTGMDxobgIwZpBaKFR3uMXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmzeppdLRDnW+DwVwf+9U5rxT2Z69Uya9TigRZwDRjrrVuB09evAe6A2wglGzjEmGePeH2z4Oj49lFxRfcCP3Guk26cdZFwWKA7WYDdRvRcwzUMc4WwgEGAWQWpU2t3toiZTIMJizelhMWWl9yqx5cZSg2dbSMEvleDV/xjpdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dVBC6K+S; arc=none smtp.client-ip=74.125.229.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVBC6K+S"
Received: by mail-dy2-f36.google.com with SMTP id 5a478bee46e88-328664c2da6so4082059eec.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 19:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790736676; x=1791341476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDJ/h4O3+ginf8ExTFTYMmMa2icnkdjDFgDRyoVwV0Q=;
        b=dVBC6K+SShcYVeaeowx0p5Lpa0UB30eQREwlWwD4HCt+PBK5XLoARQgkBZabI1uqMK
         JfJt4jL8bAxIP/ekCD3Hp3kx1EEOkPt19j3AxpCLz/BxRMmPl9Rf0cvdS4sBCcmR+/ev
         D0Q05zBPO5h+xwqlDvi6Lv+UupXavU7qmmnT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736676; x=1791341476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HDJ/h4O3+ginf8ExTFTYMmMa2icnkdjDFgDRyoVwV0Q=;
        b=JzL+i0gczM2Dm6AI+9OWxlqbo57bxyGy6oJI9c3akPe9nnYV/cysJHMmDMFF8fAlcU
         IaMgYvuEdt4dVy7cHQA6WhDwSijUL95pveUUi/IaE7ooC9nw9Tedns/7um+/dHcDWIT5
         uuAAu96lhsECkq0uHwyvQaTlFMCAub7Z0ge8y0R96ts9rKiTKlMFQicEfYeRHzCTkclk
         kv8ECwX1SwC9Kf+0rvh7dhUhDih7cD2VZoO+kzHUvAE/JktDCnEt+ZIGANabIQLQ4aSS
         2asaHDTepijbJdhfR//0Z36Xd5niVTTx8NnUsITSuBioDz3iT0Is97KbvGFV/4QK6637
         PK6w==
X-Forwarded-Encrypted: i=1; AKwUvBzDp/boFiKBZqQNu5zLX4CfTeW3rOMy/bjY/geSG12Cjmnv0T/HSqs+RAhnYFhMHaiY8KcPV7D/Dg==@vger.kernel.org
X-Gm-Message-State: AFuF++lbiQE3I5LJQlEdPBFz2MsBNPR9ZqWBO7jy0C0sZmWt0dmVrvbP
	peUigGAvPZdV1oeMcsv7spTrkK8XiVRfrW7FtIh424IidNjxRJlD0eUdb01m1jivmw==
X-Gm-Gg: AYBFou0eq9TsCMogceXW2hXXcP44ele2nG4j5kqdIGZB7ZHR9R2w+ihTn2u33BBPsTp
	wjWb0aIvduX9Ni60dayz8fpexaGzdO02YVH/qxQQrbH2rb03Lo/botYx4abAmq2GVqjJA6l9woi
	mHxuaTpYZEHc37kwhY4afEx1sfg///VT9T/dSWNLmZpZILpnFGNd6vtYC7L+X82d3X5rntPF/v0
	p46WnLBS4RPjpWhTfKINP5Y5AcgcOVEty5WP78Hbj5I6AuTEp2nbXuGU7L/7ZKEvPC9EzuwYOFl
	oIqleBj9NRROe+ayAuiTe7tlBEOQyHLR/Hrf28yKxgAjuzzkyo2wFyb4oBTctyQP1r5HNuQp7r2
	tWkQSV8mPX66TD0zyd6xI2IK6n8eioWWyoMZt6c7iQNgqCZy2IU28bh/SHO6CVhs2Ab5hrNJClr
	8X0QLKXVGU/7PAgqP28Z7UD70DQXn1AJrCXrP9rzhlOWzrm8DlkLWnTaVvyBbsokmQthYMZcFzR
	T/Cp2MKl3Q33uuCU6+4JaZEiGoO4ol5tnkm
X-Received: by 2002:a05:7022:298:b0:143:298e:913d with SMTP id a92af1059eb24-14c9e76ff88mr1286045c88.47.1790736675697;
        Tue, 29 Sep 2026 19:51:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-14d08fb4f9fsm198341c88.11.2026.09.29.19.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 19:51:15 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 6/8] PM: runtime: Clarify driver callback expectations and structure Section 2
Date: Tue, 29 Sep 2026 19:49:54 -0700
Message-ID: <20260929194956.v3.6.If19ee35d3b80d115f264484b21fb003a962762fa@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930025044.104824-1-briannorris@chromium.org>
References: <20260930025044.104824-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Section 2 describes the three runtime callbacks, but:

1) it's fairly dense to read (150+ lines); and
2) it glosses over a big point -- that it's uncommon for drivers to
   implement ->runtime_idle()

Add a note up-front to help direct the reader about #2, and add headings
to try to break up the text a bit.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 Documentation/power/runtime_pm.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 6fe20ad8d3d9..68903d93a3e7 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -54,6 +54,14 @@ There are three device runtime PM callbacks defined in 'struct dev_pm_ops'::
 	...
   };
 
+Most device drivers only need to implement ->runtime_suspend() and
+->runtime_resume(). The ->runtime_idle() callback is optional and rarely
+implemented by peripheral device drivers, as the PM core automatically handles
+suspension and autosuspend when ->runtime_idle() is omitted (or returns 0).
+
+Subsystem and Driver Callbacks
+------------------------------
+
 The ->runtime_suspend(), ->runtime_resume() and ->runtime_idle() callbacks
 are executed by the PM core for the device's subsystem that may be either of
 the following:
@@ -87,6 +95,9 @@ not block or sleep, but it also means that the synchronous helper functions
 listed at the end of `Section 4`_ may be used for that device within an
 interrupt handler or generally in an atomic context.
 
+Callback Semantics
+------------------
+
 The subsystem-level suspend callback, if present, is _entirely_ _responsible_
 for handling the suspend of the device as appropriate, which may, but need not
 include executing the device driver's own ->runtime_suspend() callback (from the
@@ -167,6 +178,9 @@ return a non-zero value (typically -EBUSY or -EAGAIN).  Unlike
 return codes from ->runtime_idle() as a fatal device error; any non-zero value
 simply stops the PM core from suspending the device.
 
+Core Guarantees and Synchronization Rules
+-----------------------------------------
+
 The helper functions provided by the PM core, described in `Section 4`_,
 guarantee that the following constraints are met with respect to runtime PM
 callbacks for one device:
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

