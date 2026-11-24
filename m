Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538206;
	b=w9CnmcqDD3OBUvr9PJEz1z7idwtvYvY+RGB0erJb0uPy5hQOheiHQZVlg41oqsmnjh9D
	 diVWCj5PIgtPgr/YJePKocBIxzAHKRdMMwX77uR8gKVlnISLkzvLjd7GeEA+M4sn+8TvZ
	 AHBEd+/dYkDsddiqd+w6lfO18q3D/NXyY0wr1DmaD7j7JwF/9phfbh+AjtFE++8lWHIQb
	 /7tXCgkFRLgj/bAyjTS+hSdzPAfbTUyRJxHlbGLEZL5PW8YjTtQJD1KHOqOqveIv8bXOp
	 XzE/0ulIihal9cHierMVkcxFIC20QbXbPKoatmHlYDMscHYXg2Qj7DGT2g+ztUAru5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538206;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=Lnfns47ZaI4dQV+kbEBEUjkLlO4ykwTSQdd62f/cRuo=;
	b=A+iOkJaJq7frFJ589RU9t3ODq8yvgQtDTR8qa0FPueVwLsIL6B0Ya3II5d4h6RpxQh5R
	 tuGCoh73e9fKyJhUA1OonqgdENCQoZhTWU9SwpBj+JnMObWFZ62ROJjz0Wrkh+nlQvSWq
	 IjqPlHvdZmDeXzPASxbh00hZxkqEM/xzVL7zKn0jbFYLhCYVvc6dACzDZjoQoWEFxBvqY
	 EsSRqX3WgYJ4Faf0fXVuJ2kWX4S/u4aKnHCG1v5n3Onvy6mWa54koluQPRJjGKJrMFRn3
	 hNiBEjlITF+tp4kRsAKIofHzmtjfU4+rNZh0OTumUiLv9vUNaEsc3Z3rJaQBNyVD+OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqC9SnqO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B4606A31E;
	Tue, 24 Nov 2026 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqC9SnqO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047CC1F00A01;
	Tue, 24 Nov 2026 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795538205;
	bh=Lnfns47ZaI4dQV+kbEBEUjkLlO4ykwTSQdd62f/cRuo=;
	h=From:To:Cc:Subject:Date;
	b=OqC9SnqOjGIzhj+B+oEfjK5kaqLDKcaIbh4ikrPz1qnrs/uuUrq9AB4lP/7J/q0eJ
	 0XB82Zuk/EAUVhjJH3HLHTFZDEcIV1zbpJKYs5VrFcp2wuedElci/ECvxF0+KWY8xZ
	 tFe9ERkociyl/O+TnMHN6AItvtMrEd18FOkUvlGbFnHxluDIzR2UN/KUD7j53a2vEw
	 I7rdVgHP4QKlw0K3mAb4f5sIBzSkBUlLkgb/vGS9ts49Nhlr8nP8cQM3CKm7qO3iFL
	 LDKyg+ps2uREHRK4KUEv552Yi12qXM0AbQwMJF/KrrbtFBNCnrAX6Za5EDd/T3uvDv
	 KUKBwMyUUydbg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux Driver Core Development <driver-core@lists.linux.dev>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
 Brian Norris <briannorris@chromium.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [PATCH v1] PM: runtime: Eliminate __pm_runtime_put_autosuspend()
Date: Tue, 24 Nov 2026 17:36:41 +0100
Message-ID: <13014755.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

There are two users of __pm_runtime_put_autosuspend(),
pm_runtime_put_autosuspend() and arm_smmu_rpm_put(), but
the latter duplicates the code from the former.

Fold __pm_runtime_put_autosuspend() into pm_runtime_put_autosuspend()
and make arm_smmu_rpm_put() call the latter.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/power/runtime_pm.rst    |    1 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c |    7 ++-----
 include/linux/pm_runtime.h            |   26 +-------------------------
 3 files changed, 3 insertions(+), 31 deletions(-)

--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -338,7 +338,6 @@ It is safe to execute the following help
 - pm_runtime_put_noidle()
 - pm_runtime_put()
 - pm_runtime_put_autosuspend()
-- __pm_runtime_put_autosuspend()
 - pm_runtime_enable()
 - pm_suspend_ignore_children()
 - pm_runtime_set_active()
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -79,11 +79,8 @@ static inline int arm_smmu_rpm_get(struc
 
 static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
-	if (pm_runtime_enabled(smmu->dev)) {
-		pm_runtime_mark_last_busy(smmu->dev);
-		__pm_runtime_put_autosuspend(smmu->dev);
-
-	}
+	if (pm_runtime_enabled(smmu->dev))
+		pm_runtime_put_autosuspend(smmu->dev);
 }
 
 static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -588,30 +588,6 @@ static inline void pm_runtime_put(struct
 }
 
 /**
- * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
- * @dev: Target device.
- *
- * Decrement the runtime PM usage counter of @dev and if it turns out to be
- * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
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
- */
-static inline int __pm_runtime_put_autosuspend(struct device *dev)
-{
-	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
-}
-
-/**
  * pm_runtime_put_autosuspend - Update the last access time, drop usage counter
  * and request autosuspend.
  * @dev: Target device.
@@ -635,7 +611,7 @@ static inline int __pm_runtime_put_autos
 static inline int pm_runtime_put_autosuspend(struct device *dev)
 {
 	pm_runtime_mark_last_busy(dev);
-	return __pm_runtime_put_autosuspend(dev);
+	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
 }
 
 DEFINE_GUARD(pm_runtime_noresume, struct device *,



