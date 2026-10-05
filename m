Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3835548EC99;
	Mon,  5 Oct 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207571; cv=none; b=WtyhJic7Ot1FkAHmeNLyvM2vBi5yZ6RdQbcC1sYomI7FS3ukgxIPVXoR7/wslnXlyx7UPfUxxj2XBX4jvXCgFacSHYDcUTSLqORpSVSwGsDSjdQ128J5c8DP8u7CN+e9q1Y2YTx6AEg0FClzIBLuOAgg/i2yuaRJCAqV2i2+Xqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207571; c=relaxed/simple;
	bh=rZJR+KR348D5iLjfAyI9sANFyGvEEWvTxKviCvypKec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8v3huAWdtW9O1nWXINiIV7IujGqkwjSxNSH3WyEKidahxploWQA0WXFdyWtN0xO0Ty0CYv9WXppff4eaxqTaBn0lotmc0FUPV5IV6vPK/F4TZeP8SWrAGLcPh93013v8iiXe1xlT4bs2M+WcFHzn7jUcediQE81LNN8hgAaohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FmFnOQkm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FmFnOQkm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390B8153B;
	Mon,  5 Oct 2026 06:39:25 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.12.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E33913F86F;
	Mon,  5 Oct 2026 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791207568; bh=rZJR+KR348D5iLjfAyI9sANFyGvEEWvTxKviCvypKec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmFnOQkmtueRJ40C0IjiqE/9sO0JPs3SodJ1u7mDQTo54q509N2SG4IEoVkRLpp2v
	 1hix8c8K7wi1XFZb1oAruvZjIJVjCaMxk8dRnvJXItyMGjc1mwG3d0lv35P3z7Yt2p
	 44MO7NZZtWyzgYhv2+2s6iExCDyg3CfKcLAQBZ3o=
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
	acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 3/3 DO NOT MERGE] drm/tyr: enable runtime PM
Date: Mon,  5 Oct 2026 15:37:41 +0200
Message-ID: <20261005133857.1572243-4-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005133857.1572243-1-beata.michalska@arm.com>
References: <20261005133857.1572243-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runtime PM support to the Tyr platform driver. Move the clocks
and regulators used by runtime suspend and resume into the PM
payload, register the PM callbacks, configure autosuspend,
and let DRM paths take a PM usage reference while querying
device state.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/gpu/drm/tyr/driver.rs | 120 +++++++++++++++++++++++++++-------
 drivers/gpu/drm/tyr/file.rs   |   3 +
 2 files changed, 99 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index bfb0ba19caff..4061e2268371 100644
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
 
@@ -57,6 +55,10 @@
 #[pin_data(PinnedDrop)]
 pub(crate) struct TyrPlatformDriverData<'bound> {
     _reg: drm::Registration<'bound, TyrDrmDriver>,
+    // This needs to be dropped after drm::Registration as that one
+    // borrows PMContext.
+    pub(crate) pm:
+        pm::Registration<'bound, TyrPlatformDriver>,
 }
 
 /// Data owned by the DRM [`Registration`].
@@ -71,11 +73,8 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
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
@@ -112,6 +111,10 @@ impl platform::Driver for TyrPlatformDriver {
     type Data<'bound> = TyrPlatformDriverData<'bound>;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
+    fn dev_pm_ops() -> Option<pm::DevPMOpsRef<'static, platform::Adapter<Self>>> {
+        Some(TYR_PM_OPS.pm_ops())
+    }
+
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
         _info: Option<&'bound Self::IdInfo>,
@@ -127,6 +130,32 @@ fn probe<'bound>(
         let mali_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"mali")?;
         let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
 
+        let runtime_payload = TyrRuntimePMPayload {
+            clks: Clocks {
+                core: core_clk,
+                stacks: stacks_clk,
+                coregroup: coregroup_clk,
+            },
+            _regulators: Regulators {
+                _mali: mali_regulator,
+                _sram: sram_regulator,
+            },
+        };
+
+        let mut pm_configs = KVec::<PMConfig>::with_capacity(2, GFP_KERNEL)?;
+        pm_configs.push(PMConfig::AutoSuspend(true), GFP_KERNEL)?;
+        pm_configs.push(PMConfig::AutoSuspendDelay(300), GFP_KERNEL)?;
+
+        let pm_registration = pm::Registration::new(
+            pdev.as_ref(),
+            &TYR_PM_OPS,
+            None,
+            Some(pm_configs),
+            runtime_payload,
+        )?;
+
+        let pm_context = pm_registration.ctx().clone();
+
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
         let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
@@ -160,27 +189,23 @@ fn probe<'bound>(
         firmware.boot()?;
 
         let reg_data = pin_init!(TyrDrmRegistrationData {
-                pdev,
-                fw: firmware,
-                clks <- new_mutex!(Clocks {
-                    core: core_clk,
-                    stacks: stacks_clk,
-                    coregroup: coregroup_clk,
-                }),
-                regulators <- new_mutex!(Regulators {
-                    _mali: mali_regulator,
-                    _sram: sram_regulator,
-                }),
-                iomem,
-                gpu_info,
+            pdev,
+            fw: firmware,
+            pm: pm_context,
+            iomem,
+            gpu_info,
         });
 
         // SAFETY: `reg` is stored in `TyrPlatformDriverData` and dropped when the driver is
         // unbound; it is never forgotten.
         let reg = unsafe { drm::Registration::new(pdev.as_ref(), unreg_dev, reg_data, 0)? };
 
-        let driver = TyrPlatformDriverData { _reg: reg };
+        let driver = TyrPlatformDriverData {
+            _reg: reg,
+            pm: pm_registration,
+        };
 
+        driver.pm.ctx().enable(RuntimePMState::Resumed)?;
         dev_dbg!(pdev, "Tyr initialized correctly.");
         Ok(driver)
     }
@@ -235,3 +260,50 @@ struct Regulators {
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
+
+        payload.clks.coregroup.disable_unprepare();
+        payload.clks.stacks.disable_unprepare();
+        payload.clks.core.disable_unprepare();
+        Ok(payload)
+    }
+    fn runtime_resume<'a>(
+        _dev: &'a Self::DeviceType,
+        payload: TyrRuntimePMPayload,
+    ) -> Result<TyrRuntimePMPayload, (TyrRuntimePMPayload, Error)> {
+
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

