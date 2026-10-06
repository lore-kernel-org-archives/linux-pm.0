Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA1B509F0E
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328858; cv=none; b=q7PqXJ4G/AMU8VajLZGv41p/DNw7g4NQMDI53ZUFXndIi6/ZltmvnwbAgs4SIYuYXK0sjmZfYJ7/K8f0J1KRReHi4aDeU7PU81sMskCoJ3stz+H1G1VBEq/rmtVE3YiAFLPdXbTYQuaXnCLU35WK+ZAAZ/ie3KEPVwQw8HTQqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328858; c=relaxed/simple;
	bh=WA7PuvtbUthLvcW/Lb0HQQwhnWNVFVTphdPk0OJcCfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFpmADgCxHFsxpetRESNfNDB/7+1aCU5j7lQJAAXqwspb12P8o9v9dlFlfGIyr9JyaGVJoWt/4W9n3+vqqhUmqpSk+jD5MPlj/bwqLzw4TUzAV+Wf7fnqa38B3RffowcgRmvhF5fG+3BYpZykxL1s1ACYMn2YXZiVjEotG0cmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZA9esMEL; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZA9esMEL"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514b90bb89so1823315eec.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328830; x=1791933630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s1IGI0iM7+36zwsjin4BRCszBFYYHuuKMw3/Hy9I2ks=;
        b=ZA9esMELG5GiLmJHD5/3J8S2U7vjcXdDHdTC2pi1zzQKESxslAFD1ef8SDqHbI+85J
         q8XXTLgvXbW+jp+JD4Ejcaoh4qp3iTjhaZLiutzdXwZG9+Tgac0YVwAVPjLZmQhw0vVC
         QGs9ZRKAaGgHIWLsx5hqL57+4AfE8ZxqctKpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328830; x=1791933630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s1IGI0iM7+36zwsjin4BRCszBFYYHuuKMw3/Hy9I2ks=;
        b=Bw/nc9iP0gmmdyCibeeWts8U7RZsaN3u/V3niyAFfS1MJRGwLwde4TlRmYmvqPDXc4
         no2JmRUI30rnFi0BxKdAQud7NQTkaHRVe+/eeaIexEh2vdRoLHnsEcx0qd2pTdMyEGq+
         Tmv5mNNq20S8qCtrqQo5ilUegx4RO+gmx8Sd5Y29x6Cyt9sVC9CqsvxkV4QRXjiM+OCs
         0A+54aCFtwMdzIKYC2fK5QGLhCI+LrotqT1ruotM7vvy3SUAtWx6iGpZSl+9Z1P3eVDd
         T9oa605Bq9gs2l2mYoDd3uwJ93ZKLfRkzeXQMcPkQRDuY/0WzepKh0ft4XKlN91Tiu5h
         0ovg==
X-Gm-Message-State: AFq9FYJ7sHFRvdgScVMARi9CCB3pzRZZzC7AB8J2M6KIXtmB/0e1Q/BV
	Ls80Fd6ioGLG88DWpnf6yUVYZTSzjAsFOid7tZ1D0dnlfHTWu9HMrYQlaBzImVTcEpGLT7uBlnb
	6OLg=
X-Gm-Gg: AYBFou32pWl7CtPWslYnJoY8C3z3hfdoo/TmR9hx7xPe3RO+6dLyZt2KFCXArbb35rw
	qH4twfXu17NzsGJSbAD7zj0SJy2W1vim8Roa2lArbN3OQjuY25qzM94AnQWSJ+NRC/mYuwljJdj
	cypjKLYWFZu/WyNJ/OCpTfJo1Kr1H4P+gqyT6KGB2qPCTSt2VGiXuHgWCbCuYB/Y7t8esA0EPEN
	ezHHO6VREYqLPNPQi5vhWvDgxWPBVWkmEZXZvoe4/1SP69IJT0qDCC3qdYVS/MgXP0FpRD6eQK7
	ZXb6kSBwj8mGD5GfMQ6/Qwr5G+7R5Rdiy9iEuaTpZw2SERdzBe6Thj6Cj3gtAoRBnOJgrDEK2Cj
	MtwRoGMIMvUz7ReJCouSt9n4NtY4jnhpI52p21EmPVtXyYmAAo7UGE9CEZqT7BzmT8AE84S2qHt
	56q+J1QB0Z5AI2XNTuCVASxmZnb4rK6TOaeb1TW5mM+f34EAE1nP278q8/UX+z6VBFoET0n4c6Z
	c0mEdLdUYwMDB05aTyVrbZRt5hNoKcVT9RTyw==
X-Received: by 2002:a05:693c:65d2:b0:34e:f644:9083 with SMTP id 5a478bee46e88-3515ddad0a3mr331617eec.23.1791328829695;
        Tue, 06 Oct 2026 16:20:29 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3515aeb6013sm1701105eec.5.2026.10.06.16.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:20:29 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 13/13] PM: runtime: Drop pm_request_{idle,autosuspend}() return codes
Date: Tue,  6 Oct 2026 16:13:41 -0700
Message-ID: <20261006161337.13.If024833d8fe53aa824fa29ebd6959702ec7062e0@changeid>
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

No in-tree callers (outside of KUnit tests) use the return values of
pm_request_idle() or pm_request_autosuspend().

As with pm_runtime_put() and pm_runtime_put_autosuspend(), these
functions asynchronously queue up a timer or work item to check whether
or not the device can be suspended, which is not guaranteed to succeed
and may return a negative error code in many valid situations (for
example, when user space has written "on" to the device's runtime PM
"control" file in sysfs, or when the device's usage counter is
non-zero).

Accordingly, change the return types of pm_request_idle() and
pm_request_autosuspend() to void, similar to commit 3afd8df02433 ("PM:
runtime: Change pm_runtime_put() return type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest and could be applied on its own. I
put in this series because it has the same justification as the more
noisy one, "PM: runtime: Drop pm_runtime_put_autosuspend() return code"

 drivers/base/power/runtime-test.c |  8 --------
 include/linux/pm_runtime.h        | 31 ++++---------------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 24865ce844fc..ac3d7277e0c5 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -43,7 +43,6 @@ static void pm_runtime_already_suspended_test(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
-	KUNIT_EXPECT_EQ(test, 1, pm_request_autosuspend(dev));
 
 	pm_runtime_get_noresume(dev);
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev));
@@ -81,7 +80,6 @@ static void pm_runtime_idle_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
 	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
-	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
 }
 
 static void pm_runtime_disabled_test(struct kunit *test)
@@ -112,9 +110,7 @@ static void pm_runtime_disabled_test(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume_and_get(dev));
 	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_idle(dev));
-	KUNIT_EXPECT_EQ(test, -EACCES, pm_request_idle(dev));
 	KUNIT_EXPECT_EQ(test, -EACCES, pm_request_resume(dev));
-	KUNIT_EXPECT_EQ(test, -EACCES, pm_request_autosuspend(dev));
 	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_suspend(dev));
 	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume(dev));
 	KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_autosuspend(dev));
@@ -154,9 +150,7 @@ static void pm_runtime_error_test(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume_and_get(dev));
 	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_idle(dev));
-	KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_idle(dev));
 	KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_resume(dev));
-	KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_autosuspend(dev));
 	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_suspend(dev));
 	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume(dev));
 	KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_autosuspend(dev));
@@ -189,9 +183,7 @@ static void pm_runtime_error_test(struct kunit *test)
 	 * (already resumed).
 	 */
 	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
-	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
 	KUNIT_EXPECT_EQ(test, 1, pm_request_resume(dev));
-	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_autosuspend(dev));
 	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_suspend(dev));
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_resume(dev));
 	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_autosuspend(dev));
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index b0e7dfb3805f..418a51319a62 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -447,21 +447,10 @@ static inline int pm_runtime_resume(struct device *dev)
  *
  * Asynchronously request the PM core to evaluate whether @dev can be idled
  * or suspended, invoking its ->runtime_idle() callback if provided.
- *
- * Return:
- * * %0: Success.
- * * %-EINVAL: Runtime PM error.
- * * %-EACCES: Runtime PM disabled.
- * * %-EAGAIN: Runtime PM usage counter non-zero, Runtime PM status change
- *   ongoing or device not in %RPM_ACTIVE state.
- * * %-EBUSY: Runtime PM child_count non-zero.
- * * %-EPERM: Device PM QoS resume latency 0.
- * * %-EINPROGRESS: Suspend already in progress.
- * * %-ENOSYS: %CONFIG_PM not enabled.
  */
-static inline int pm_request_idle(struct device *dev)
+static inline void pm_request_idle(struct device *dev)
 {
-	return __pm_runtime_idle(dev, RPM_ASYNC);
+	__pm_runtime_idle(dev, RPM_ASYNC);
 }
 
 /**
@@ -487,23 +476,11 @@ static inline int pm_request_resume(struct device *dev)
  *
  * Update the last access time of @dev and asynchronously request the PM core
  * to suspend it after the autosuspend delay has elapsed.
- *
- * Return:
- * * %1: Success; device was already suspended.
- * * %0: Success.
- * * %-EINVAL: Runtime PM error.
- * * %-EACCES: Runtime PM disabled.
- * * %-EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
- *   ongoing.
- * * %-EBUSY: Runtime PM child_count non-zero.
- * * %-EPERM: Device PM QoS resume latency 0.
- * * %-EINPROGRESS: Suspend already in progress.
- * * %-ENOSYS: %CONFIG_PM not enabled.
  */
-static inline int pm_request_autosuspend(struct device *dev)
+static inline void pm_request_autosuspend(struct device *dev)
 {
 	pm_runtime_mark_last_busy(dev);
-	return __pm_runtime_suspend(dev, RPM_ASYNC | RPM_AUTO);
+	__pm_runtime_suspend(dev, RPM_ASYNC | RPM_AUTO);
 }
 
 /**
-- 
2.56.0.360.g66cac248cb-goog

