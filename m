Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016354;
	b=FdG4VgKss71yj53I0dG3YfcfVDw+tEmWPfSy4z4ezcEhkjdUwsMar6ssmQAUe8wFZu2k
	 GUODE/Pt8bfEAqO2QJxMdTG/gHBHawOUIxCXHX2Ou9S5UDfPMpOI6zlQWNQUe1tsS1ejP
	 qFjzIVetqrKC2wEKsCbjK+r7o2ffYFCFPv3Vt4L2VbjfnsSMk/YskvQBfmXROrByXC+NM
	 G1bh2qIun0Ptv90Htcl4elZ5mCuETp89KMA/d5cbqttYUcVZ0dU7UoWuuVl6CIcMLjtBm
	 XXix/JpYm/rujm82TkU9rg58uLTrw68b33AKs8eXkqhodi7YqFdh9pSkUilFqYc8R8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016354;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=23qs3RWKEsM/w4KDwLVzJ2NEHur2CIHpUQzAu6EYZ3g=;
	b=AhINUSYQ/eV3P9NeT5hc5SNyJwpFdoo5sNXq/500H5AoAvARhYZl+tzgXB4udPV1GwBs
	 JPLIRkwgac162kLDnvNICNGc2x9C2O+Rx7cCuIqZr1M1JcK9S3tO2i692bqTND+PSSluk
	 A26noYBm3AQFKcPXIEqAjREsKdWxFhwDqX7k9gZeUldl88v51l9rg/nZ+ru8XeSKHCjuu
	 8PD3wkHJaUcjkfHbxhtbMmFewLD/HPMbFL77LzVXDWDOx8fOKYOIFZialyh8s1rh7ojgw
	 4lGg/oRYmWjsuI619eSn9iupQLTdpI0YTZiZIFYmYI4bkXNikIc+soTM3gl1hOiErLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Wp/of0st";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB17606A31D;
	Mon, 26 Oct 2026 12:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EB17606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Wp/of0st
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C72E828C7;
	Mon, 26 Oct 2026 05:05:49 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.58.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A0CD73F7B4;
	Mon, 26 Oct 2026 05:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793016352; bh=4uJ2kXihYcG1CRN0TgazzGGPxO3PZnI4dhnwBPVGNKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wp/of0stS31cCvG3iwqtLvjTLgzveaWdhh6B8lzpxpbD9Ydb7rL7ZxYvA6+ow6r5K
	 rwPT1CWDKahx04IF/xWGDBfbdekAAYyXg/zjhoQYb/rCInayUQGNwcFQvLcT6SuN8M
	 retqsgFakym2SRDOK0rATHa0QfBkCsPUaEaWUBZQ=
From: Beata Michalska <beata.michalska@arm.com>
To: ojeda@kernel.org,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	aliceryhl@google.com
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	boris.brezillon@collabora.com,
	work@onurozkan.dev,
	samitolvanen@google.com,
	acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 3/3 DO NOT MERGE] drm/tyr: enable runtime PM
Date: Mon, 26 Oct 2026 13:05:08 +0100
Message-ID: <20261026120523.526942-4-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026120523.526942-1-beata.michalska@arm.com>
References: <20261026120523.526942-1-beata.michalska@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runtime PM support to the Tyr platform driver. Move the clocks
and regulators used by runtime suspend and resume into the PM
payload, register the PM callbacks, configure autosuspend,
and let DRM paths take a PM usage reference while querying
device state.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/gpu/drm/tyr/driver.rs | 110 +++++++++++++++++++++++++++-------
 drivers/gpu/drm/tyr/file.rs   |   3 +
 2 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c2b99d67369f..de18470f0bd6 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -21,17 +21,15 @@
         poll,
         Io, //
     },
-    new_mutex,
     of,
     platform,
+    pm,
+    pm::*,
     prelude::*,
     regulator,
     regulator::Regulator,
     sizes::SZ_2M,
-    sync::{
-        Arc,
-        Mutex, //
-    },
+    sync::Arc,
     time, //
 };
 
@@ -59,6 +57,9 @@
 pub(crate) struct TyrPlatformDriverData<'bound> {
     #[pin]
     _reg: drm::Registration<'bound, TyrDrmDriver>,
+    // This needs to be dropped after drm::Registration as that one
+    // borrows PMContext.
+    pub(crate) pm: pm::Registration<'bound, TyrPlatformDriver>,
 }
 
 /// Data owned by the DRM [`Registration`].
@@ -73,11 +74,8 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     /// Firmware sections.
     pub(crate) fw: Firmware<'drm>,
 
-    #[pin]
-    clks: Mutex<Clocks>,
-
-    #[pin]
-    regulators: Mutex<Regulators>,
+    /// Runtime PM context owned by the PM Registration
+    pub(crate) pm: PMContext<'drm, TyrPlatformDriver>,
 
     /// GPU MMIO register mapping.
     pub(crate) iomem: Arc<IoMem<'drm>>,
@@ -113,6 +111,8 @@ impl platform::Driver for TyrPlatformDriver {
     type IdInfo = ();
     type Data<'bound> = TyrPlatformDriverData<'bound>;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const DEV_PM_OPS: Option<pm::DevPMOpsRef<'static, platform::Adapter<Self>>> =
+        Some(TYR_PM_OPS.pm_ops());
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
@@ -130,6 +130,37 @@ fn probe<'bound>(
             let mali_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"mali")?;
             let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
 
+            let runtime_payload = TyrRuntimePMPayload {
+                clks: Clocks {
+                    core: core_clk,
+                    stacks: stacks_clk,
+                    coregroup: coregroup_clk,
+                },
+                _regulators: Regulators {
+                    _mali: mali_regulator,
+                    _sram: sram_regulator,
+                },
+            };
+
+            let mut pm_configs = KVec::<PMConfig>::with_capacity(2, GFP_KERNEL)?;
+            pm_configs.push(PMConfig::AutoSuspend(true), GFP_KERNEL)?;
+            pm_configs.push(PMConfig::AutoSuspendDelay(300), GFP_KERNEL)?;
+
+            // SAFETY: `pm_registration` is stored in `TyrPlatformDriverData`
+            // and dropped when the driver is
+            // unbound; it is never forgotten.
+            let pm_registration = unsafe {
+                pm::Registration::new(
+                    pdev.as_ref(),
+                    &TYR_PM_OPS,
+                    None,
+                    Some(pm_configs),
+                    runtime_payload,
+                )
+            }?;
+
+            let pm_context = pm_registration.ctx().clone();
+
             let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
             let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
@@ -171,20 +202,14 @@ fn probe<'bound>(
                     pin_init!(TyrDrmRegistrationData {
                         pdev,
                         fw: firmware,
-                        clks <- new_mutex!(Clocks {
-                            core: core_clk,
-                            stacks: stacks_clk,
-                            coregroup: coregroup_clk,
-                        }),
-                        regulators <- new_mutex!(Regulators {
-                            _mali: mali_regulator,
-                            _sram: sram_regulator,
-                        }),
+                        pm: pm_context,
                         iomem,
                         gpu_info,
                     }),
                 )},
-                _: { dev_dbg!(pdev, "Tyr initialized correctly.") },
+                pm: pm_registration,
+                _: { pm.ctx().enable(RuntimePMState::Resumed)?;
+                    dev_dbg!(pdev, "Tyr initialized correctly.") },
             }))
         })
     }
@@ -239,3 +264,48 @@ struct Regulators {
     _mali: Regulator<regulator::Enabled>,
     _sram: Regulator<regulator::Enabled>,
 }
+
+pub(crate) struct TyrRuntimePMPayload {
+    clks: Clocks,
+    _regulators: Regulators,
+}
+
+static TYR_PM_OPS: pm::DevPMOps<TyrPlatformDriver> = pm::DevPMOps::new();
+
+#[vtable]
+impl PMOps for TyrPlatformDriver {
+    type Adapter = platform::Adapter<TyrPlatformDriver>;
+    type DeviceType = platform::Device<kernel::device::Bound>;
+    type RuntimePayloadType = TyrRuntimePMPayload;
+
+    fn runtime_suspend<'a>(
+        _dev: &'a Self::DeviceType,
+        payload: TyrRuntimePMPayload,
+    ) -> Result<TyrRuntimePMPayload, (TyrRuntimePMPayload, Error)> {
+        payload.clks.coregroup.disable_unprepare();
+        payload.clks.stacks.disable_unprepare();
+        payload.clks.core.disable_unprepare();
+        Ok(payload)
+    }
+    fn runtime_resume<'a>(
+        _dev: &'a Self::DeviceType,
+        payload: TyrRuntimePMPayload,
+    ) -> Result<TyrRuntimePMPayload, (TyrRuntimePMPayload, Error)> {
+        if let Err(e) = payload.clks.core.prepare_enable() {
+            return Err((payload, e));
+        }
+
+        if let Err(e) = payload.clks.stacks.prepare_enable() {
+            payload.clks.core.disable_unprepare();
+            return Err((payload, e));
+        }
+
+        if let Err(e) = payload.clks.coregroup.prepare_enable() {
+            payload.clks.stacks.disable_unprepare();
+            payload.clks.core.disable_unprepare();
+            return Err((payload, e));
+        }
+
+        Ok(payload)
+    }
+}
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 9f60a90d4948..111cd4ccf87c 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -5,6 +5,7 @@
         self,
         Registered, //
     },
+    pm::PMProfile,
     prelude::*,
     uaccess::UserSlice,
     uapi, //
@@ -37,6 +38,8 @@ pub(crate) fn dev_query(
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
     ) -> Result<u32> {
+        // Runtime suspend called when pm_scope gets dropped
+        let _pm_scope = reg_data.pm.get(PMProfile::new())?;
         if devquery.pointer == 0 {
             match devquery.type_ {
                 uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
-- 
2.43.0

