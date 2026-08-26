Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951E423A79;
	Wed, 26 Aug 2026 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749967; cv=none; b=lgWKR+NMvIBv+kdRHX+FIvr7ALEy5rdqoZrGiaKwpNyEQegJkz3P4matdLCpt1oQ94e5/SV7mGOLL0YcQ/qRh1QXtE2TqrmihKtyLTTXCv98fJLyUDLgw3d2Lzp15WU+bkRiRwH/PEZ273e+K+f5fRgooj1jINyT5MqfzQzIZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749967; c=relaxed/simple;
	bh=PoMmisv3MGM+Nem3SRMMMh2evBg2UTXdBRosxI3LpTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIrKBEdkGFu0Q4qPegQx7J5aIvzbxa8kSfFJVxT9+PhN3oZGI3lIaMAqs7A4TqrjTubXn1itFyGVX0BrXP0tnKdMLWKWEYlwMgecrcho3vDHqLs+lL0RVd3CMuc1GTvSKH0Q0BeL3Uo8TYSpdtoHDIqSSDUFrm+kcvz64faVP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G7xzDuL8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G7xzDuL8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 261A41684;
	Wed, 26 Aug 2026 06:12:40 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.1.236])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A63203F66F;
	Wed, 26 Aug 2026 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787749963; bh=PoMmisv3MGM+Nem3SRMMMh2evBg2UTXdBRosxI3LpTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7xzDuL8t0T2VVUQa7TMF8cL3JoYap7kb5gdRKe2mxSdv89koqhCqmW5GLcUOgJDe
	 Xy9naxY++pyBcrl1JZTNKn6GqShwIGLE/kf9M3CQpAWPyBtpjiN2uoXvmd/0nfXJsW
	 vnClndzbOt1eEUnvDflwMgTxg09PCnhEfSFxLUfo=
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
Subject: [PATCH v3 3/3 DO NOT MERGE] drm/tyr: enable runtime PM
Date: Wed, 26 Aug 2026 15:10:57 +0200
Message-ID: <20260826131213.1820408-4-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826131213.1820408-1-beata.michalska@arm.com>
References: <20260826131213.1820408-1-beata.michalska@arm.com>
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
 drivers/gpu/drm/tyr/driver.rs | 123 +++++++++++++++++++++++++++-------
 drivers/gpu/drm/tyr/file.rs   |   3 +
 2 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 94bc85635725..0bd290eeae7c 100644
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
     time,
     types::CovariantForLt, //
 };
@@ -58,6 +56,10 @@
 #[pin_data(PinnedDrop)]
 pub(crate) struct TyrPlatformDriverData<'bound> {
     _reg: drm::Registration<'bound, TyrDrmDriver>,
+    // This needs to be dropped after drm::Registration as that one
+    // borrows PMContext.
+    pub(crate) pm:
+        pm::Registration<'bound, platform::Adapter<TyrPlatformDriver>, TyrPlatformDriver>,
 }
 
 /// Data owned by the DRM [`Registration`].
@@ -72,11 +74,8 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     /// Firmware sections.
     pub(crate) fw: Firmware<'drm>,
 
-    #[pin]
-    clks: Mutex<Clocks>,
-
-    #[pin]
-    regulators: Mutex<Regulators>,
+    /// Runtime PM context owned by the PM Registration
+    pub(crate) pm: PMContext<'drm, platform::Adapter<TyrPlatformDriver>, TyrPlatformDriver>,
 
     /// GPU MMIO register mapping.
     pub(crate) iomem: Arc<IoMem<'drm>>,
@@ -114,6 +113,10 @@ impl platform::Driver for TyrPlatformDriver {
     type Data<'bound> = TyrPlatformDriverData<'bound>;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
+    fn dev_pm_ops() -> Option<pm::DevPMOps<platform::Adapter<Self>, Self>> {
+        Some(pm::DevPMOps::<platform::Adapter<Self>, Self>::new())
+    }
+
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
         _info: Option<&'bound Self::IdInfo>,
@@ -129,6 +132,32 @@ fn probe<'bound>(
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
+            pm::DevPMOps::<platform::Adapter<Self>, Self>::new(),
+            None,
+            Some(pm_configs),
+            Some(runtime_payload),
+        )?;
+
+        let pm_context = pm_registration.ctx().clone();
+
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
         let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
@@ -162,27 +191,23 @@ fn probe<'bound>(
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
 
+        driver.pm.ctx().enable(RuntimePMState::RESUMED)?;
         dev_dbg!(pdev, "Tyr initialized correctly.");
         Ok(driver)
     }
@@ -237,3 +262,53 @@ struct Regulators {
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
+impl PMOps<platform::Adapter<TyrPlatformDriver>> for TyrPlatformDriver {
+    type DeviceType = platform::Device<kernel::device::Bound>;
+    type RuntimePayloadType = TyrRuntimePMPayload;
+
+    fn runtime_suspend<'a>(
+        _dev: &'a Self::DeviceType,
+        payload: Option<TyrRuntimePMPayload>,
+    ) -> Result<Option<TyrRuntimePMPayload>, (Option<TyrRuntimePMPayload>, Error)> {
+        let Some(payload) = payload else {
+            return Err((None, EINVAL));
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
+        let Some(payload) = payload else {
+            return Err((None, EINVAL));
+        };
+
+        if let Err(e) = payload.clks.core.prepare_enable() {
+            return Err((Some(payload), e));
+        }
+
+        if let Err(e) = payload.clks.stacks.prepare_enable() {
+            payload.clks.core.disable_unprepare();
+            return Err((Some(payload), e));
+        }
+
+        if let Err(e) = payload.clks.coregroup.prepare_enable() {
+            payload.clks.stacks.disable_unprepare();
+            payload.clks.core.disable_unprepare();
+            return Err((Some(payload), e));
+        }
+
+        Ok(Some(payload))
+    }
+}
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 933a365cb016..934203b61d06 100644
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
@@ -40,6 +41,8 @@ pub(crate) fn dev_query(
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

