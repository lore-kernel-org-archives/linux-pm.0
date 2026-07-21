Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAFE46A5E8;
	Tue, 21 Jul 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648239; cv=none; b=oR18icA4aeJbkJ1G8u6hl36ps1js2UHCBmoZv0FQbAlrYyEjMjevbq9AXz8oNLVqMwsOUAOGzDJeVihhgl+BYKYG/aQcz/1rLirvXYIqL/oAMspqavaehjiOB0OjxfD1eGiucWdyWg2BB2Jf4HvaOvCLCPGt7daW9ARZx7Yekvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648239; c=relaxed/simple;
	bh=q4MF5E4h5/8qkpfjUgErQgWgG2L7kAUOY6NiD5Eq7LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paEFQRXGOv44gCZCPhVUL83T6E91r/ZTDireGXgz+DE8imi3ocnPOQdtIiEOz6vu2K8H3Trbf3C3/x2YrchRVhWphRRN8Ivh/FWu/MHlDwPngvyqM4aibnMM8CgB5sQJGqhC80RRvq2jbUaGiLzF7tLnD9eD+Zgsss66gH86W+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zt7Pv+Hh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zt7Pv+Hh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0650152B;
	Tue, 21 Jul 2026 08:37:12 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.39.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F2043F58B;
	Tue, 21 Jul 2026 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784648236; bh=q4MF5E4h5/8qkpfjUgErQgWgG2L7kAUOY6NiD5Eq7LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zt7Pv+Hhb0MmL0k7IcXlMcXV0TUq8hAzqgJvADMF1NwVbfuW8k4ITZrhccW98rijx
	 KRySIaYMn8LhQbmvWCwxBGxbqqtPY/8VspNrdCG221CZB9ykyB4zlwGCFwVwEtwcyi
	 IJKqyh0j+EeelvhSF41vYnkgxHhEtXWk54UCeBb0=
From: Beata Michalska <beata.michalska@arm.com>
To: ojeda@kernel.org,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	boris.brezillon@collabora.com,
	work@onurozkan.dev,
	samitolvanen@google.com,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/3] drm/tyr: enable runtime PM
Date: Tue, 21 Jul 2026 17:34:04 +0200
Message-ID: <20260721153617.869933-4-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721153617.869933-1-beata.michalska@arm.com>
References: <20260721153617.869933-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runtime PM support to the Tyr platform driver. Move the clocks and
regulators used by runtime suspend and resume into the PM payload, register the
PM callbacks, configure autosuspend, and let DRM paths take a PM usage
reference while querying device state.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/gpu/drm/tyr/driver.rs | 112 ++++++++++++++++++++++++++++------
 drivers/gpu/drm/tyr/file.rs   |   7 ++-
 2 files changed, 98 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 8348c6cd3929..89fe216be0de 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
 use kernel::{
+    bindings,
     clk::{
         Clk,
         OptionalClk, //
@@ -20,16 +21,16 @@
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
     sync::{
         aref::ARef,
-        Mutex, //
     },
     time, //
 };
@@ -55,18 +56,21 @@
 pub(crate) struct TyrPlatformDriverData<'bound> {
     _device: ARef<TyrDrmDevice>,
     _reg: drm::Registration<'bound, TyrDrmDriver>,
+    // This needs to be dropped after drm::Registration as this one borrows
+    // borrows PMContext.
+    pub(crate) pm: pm::Registration<'bound, TyrPlatformDriver>,
+
+}
+
+#[pin_data]
+pub(crate) struct TyrRuntimePM<'bound> {
+    pub(crate) pm: PMContext<'bound, TyrPlatformDriver>,
 }
 
 #[pin_data]
 pub(crate) struct TyrDrmDeviceData {
     pub(crate) pdev: ARef<platform::Device>,
 
-    #[pin]
-    clks: Mutex<Clocks>,
-
-    #[pin]
-    regulators: Mutex<Regulators>,
-
     /// Some information on the GPU.
     ///
     /// This is mainly queried by userspace, i.e.: Mesa.
@@ -101,6 +105,7 @@ impl platform::Driver for TyrPlatformDriver {
     type IdInfo = ();
     type Data<'bound> = TyrPlatformDriverData<'bound>;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const PM_OPS: Option<&'static bindings::dev_pm_ops> = Some(&PMContext::<Self>::PM_OPS);
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
@@ -117,6 +122,25 @@ fn probe<'bound>(
         let mali_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"mali")?;
         let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
 
+	let runtime_payload = TyrRuntimePMPayload {
+            clks: Clocks {
+                core: core_clk,
+                stacks: stacks_clk,
+                coregroup: coregroup_clk,
+            },
+            _regulators: Regulators {
+                    _mali: mali_regulator,
+                    _sram: sram_regulator,
+            }
+        };
+
+        let mut pm_configs = KVec::<PMConfig>::with_capacity(2, GFP_KERNEL)?;
+        pm_configs.push(PMConfig::AutoSuspend(true), GFP_KERNEL)?;
+        pm_configs.push(PMConfig::AutoSuspendDelay(300), GFP_KERNEL)?;
+
+        let pm_registration = pm::Registration::new(pdev.as_ref(), None, Some(pm_configs), Some(runtime_payload))?;
+        let pm_context = pm_registration.ctx().clone();
+
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
         let iomem = request.iomap_sized::<SZ_2M>()?;
 
@@ -138,28 +162,26 @@ fn probe<'bound>(
 
         let data = try_pin_init!(TyrDrmDeviceData {
                 pdev: platform.clone(),
-                clks <- new_mutex!(Clocks {
-                    core: core_clk,
-                    stacks: stacks_clk,
-                    coregroup: coregroup_clk,
-                }),
-                regulators <- new_mutex!(Regulators {
-                    _mali: mali_regulator,
-                    _sram: sram_regulator,
-                }),
                 gpu_info,
         });
 
         let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
         // SAFETY: `reg` is stored in `TyrPlatformDriverData` and dropped when the driver is
         // unbound; it is never forgotten.
-        let reg = unsafe { drm::Registration::new(pdev.as_ref(), tdev, (), 0)? };
+        let reg = unsafe { drm::Registration::new(
+            pdev.as_ref(),
+            tdev,
+            pin_init!(TyrRuntimePM { pm: pm_context, }),
+            0
+        )? };
 
         let driver = TyrPlatformDriverData {
             _device: reg.device().into(),
             _reg: reg,
+            pm: pm_registration,
         };
 
+        driver.pm.ctx().enable(RuntimePMState::RESUMED)?;
         // We need this to be dev_info!() because dev_dbg!() does not work at
         // all in Rust for now, and we need to see whether probe succeeded.
         dev_info!(pdev, "Tyr initialized correctly.\n");
@@ -185,7 +207,7 @@ fn drop(self: Pin<&mut Self>) {}
 #[vtable]
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
-    type RegistrationData<'a> = ();
+    type RegistrationData<'a> = TyrRuntimePM<'a>;
     type File = TyrDrmFileData;
     type Object = drm::gem::shmem::Object<BoData>;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
@@ -216,3 +238,55 @@ struct Regulators {
     _mali: Regulator<regulator::Enabled>,
     _sram: Regulator<regulator::Enabled>,
 }
+
+pub(crate) struct TyrRuntimePMPayload {
+    clks: Clocks,
+    _regulators: Regulators,
+}
+
+#[vtable]
+impl PMOps for TyrPlatformDriver {
+    type DeviceType = platform::Device<kernel::device::Bound>;
+    type RuntimePayloadType = TyrRuntimePMPayload;
+
+    fn runtime_suspend<'a>(
+        _dev: &'a Self::DeviceType,
+        payload: Option<TyrRuntimePMPayload>,
+    ) -> Result<Option<TyrRuntimePMPayload>, (Option<TyrRuntimePMPayload>, Error)>  {
+
+        let Some(payload) = payload else {
+          return Err((None, EINVAL));
+        };
+
+        payload.clks.coregroup.disable_unprepare();
+        payload.clks.stacks.disable_unprepare();
+        payload.clks.core.disable_unprepare();
+        Ok(Some(payload))
+    }
+    fn runtime_resume<'a>(
+        _dev: &'a Self::DeviceType,
+        payload: Option<TyrRuntimePMPayload>,
+    ) -> Result<Option<TyrRuntimePMPayload>, (Option<TyrRuntimePMPayload>, Error)> {
+
+      let Some(payload) = payload else {
+          return Err((None, EINVAL));
+      };
+
+      if let Err(e) = payload.clks.core.prepare_enable() {
+          return Err((Some(payload), e));
+      }
+
+      if let Err(e) = payload.clks.stacks.prepare_enable() {
+          payload.clks.core.disable_unprepare();
+          return Err((Some(payload), e));
+      }
+
+      if let Err(e) = payload.clks.coregroup.prepare_enable() {
+          payload.clks.stacks.disable_unprepare();
+          payload.clks.core.disable_unprepare();
+          return Err((Some(payload), e));
+      }
+
+      Ok(Some(payload))
+   }
+}
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index b686041d5d6b..d9371ddfb5f3 100644
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
@@ -12,7 +13,8 @@
 
 use crate::driver::{
     TyrDrmDevice,
-    TyrDrmDriver, //
+    TyrDrmDriver,
+    TyrRuntimePM,//
 };
 
 #[pin_data]
@@ -32,10 +34,11 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
 impl TyrDrmFileData {
     pub(crate) fn dev_query(
         ddev: &TyrDrmDevice<Registered>,
-        _reg_data: &(),
+        reg_data: &TyrRuntimePM<'_>,
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
     ) -> Result<u32> {
+        let _pm_scope = reg_data.pm.get(PMProfile::new())?;
         if devquery.pointer == 0 {
             match devquery.type_ {
                 uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
-- 
2.43.0

