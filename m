Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520188;
	b=ybhaSdEAr1jPioIqSchUGMvlkkGeTbywwh59Sn6/ceuqWoi9d8DYG3iQ/Ev4L6eSsmOj
	 /5h76fFwXd57KS91r4fvboYxdz0YPBtQurxji0wC2AucJDm8hOMf0T8RpQoismB/VVMqP
	 DnA8M3ou7Nm3YKOgTuyoWtg5ydwd+tGcHXWff8ZWnxhDxh778EwYh9DKhqcYYRgvh/99o
	 rt7WRCifQKZani2qAfN3f+2kJeq8EfbYHGwJxKIMo1znjKyu07Dz2RVZz4qFlHIfFUf+r
	 2sDCWQroe7oweTDdU4VNIYcQVFNmGaOs1A34zyUVNnORs8mtteet0xBCFYmeNqKW1gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520188;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yjkaFmMB/EOjRsxFRMCL6eH/Ahn9j6F0qkTMZyl7g/4=;
	b=yfDKx9Keexhf5aX8QC0/8plfIX5ScpmHL1j4xhTF4cMDwR/wmnV6Vpn3Fxjb2HrR1C0F
	 uKRlazqe4054VNi5uXuUUCF9tH6ob+GCMI8hEgDyGr64Mu0HA8w66qffRc9wSDcU68kZP
	 wMYIu4t4cvjMseYV0R0pq6CLFroMwJ4/NMSzxKhN/qyqopcA+9vwaFy9vZlp+6I5cu1OL
	 VI6q8z+1EK4XtGsowEHz2YBfD9MuUcrw+dhgmQQWtkqVdiuiVSJ9hjfw3yPi+fBmD3kDE
	 Rs2qXLnuU0WGiQzCKLTEJo5SToxF3W5/bRYsGzg8WyMd+W25rWkDO5D7kMRgA6DQh/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oPfsPL9p;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75BA606A330;
	Tue, 24 Nov 2026 11:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C75BA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oPfsPL9p
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ABAE1595;
	Tue, 24 Nov 2026 03:36:24 -0800 (PST)
Received: from e143943.arm.com (unknown [10.57.70.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A02013F86F;
	Tue, 24 Nov 2026 03:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795520187; bh=TeduYDtsc0fp7HuojRA+mdJj2cMUWG0JMpMHLy/kQ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPfsPL9p/qYKOAZaE0L25gRUd/9OIvj3/4MdCMTcIxuBesHWFAVwa9EdOwVDw+eg0
	 EcSNCeBrg6J8/NMYFabYou7K030Xhfiw3xVYyhdjun6PzKEWgm7jaNShuakYw4LFgU
	 NlHQE8zZFoJR8txbVQPEGYtTRmGm4MMjhxgwC1ZQ=
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
Subject: [PATCH v6 3/3 DO NOT MERGE] drm/tyr: enable runtime PM
Date: Tue, 24 Nov 2026 12:34:14 +0100
Message-ID: <20261124113555.2480381-4-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124113555.2480381-1-beata.michalska@arm.com>
References: <20261124113555.2480381-1-beata.michalska@arm.com>
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
 drivers/gpu/drm/tyr/driver.rs | 220 +++++++++++++++++++++++++---------
 drivers/gpu/drm/tyr/file.rs   |   7 +-
 2 files changed, 169 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c2b99d67369f..c82f31e2d2b4 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -9,7 +9,11 @@
         Bound,
         Core,
         Device,
-        DeviceContext, //
+        DeviceContext,
+        pm:: {
+            self,
+            *,
+        }, //
     },
     dma::{
         Device as DmaDevice,
@@ -21,17 +25,13 @@
         poll,
         Io, //
     },
-    new_mutex,
     of,
     platform,
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
 
@@ -55,35 +55,59 @@
 
 pub(crate) struct TyrPlatformDriver;
 
+#[pin_data]
+pub(crate) struct TyrHW<'bound> {
+    /// Firmware sections.
+    pub(crate) fw: Firmware<'bound>,
+
+    /// GPU MMIO register mapping.
+    pub(crate) iomem: Arc<IoMem<'bound>>,
+
+     /// GPU information read from hardware during probe.
+    pub(crate) gpu_info: GpuInfo,
+}
+
+
 #[pin_data(PinnedDrop)]
 pub(crate) struct TyrPlatformDriverData<'bound> {
     #[pin]
-    _reg: drm::Registration<'bound, TyrDrmDriver>,
+    #[uses('pm: invariant, 'hw)]
+    _reg: drm::Registration<'pm, TyrDrmDriver>,
+    // This needs to be dropped after drm::Registration as that one
+    // borrows PMContext.
+    #[pin]
+    #[uses('hw: invariant)]
+    pub(crate) pm: pm::Registration<'hw, TyrPlatformDriver>,
+    #[pin]
+    hw: TyrHW<'bound>,
+}
+
+#[pin_data]
+pub(crate) struct TyrPMRegistrationData<'pm>
+where
+    exists<'bound>: 'pm,
+{
+    #[uses('bound: invariant)]
+    pub(crate) hw: &'pm TyrHW<'bound>,
 }
 
+
 /// Data owned by the DRM [`Registration`].
 ///
 /// This data can have references tied to the parent platform device binding scope
 /// and is accessible only while the DRM device is registered with userspace.
 #[pin_data]
-pub(crate) struct TyrDrmRegistrationData<'drm> {
+pub(crate) struct TyrDrmRegistrationData<'drm>
+where
+    exists<'bound>: 'drm,
+{
     /// Parent platform device.
     pub(crate) pdev: &'drm platform::Device<Bound>,
 
-    /// Firmware sections.
-    pub(crate) fw: Firmware<'drm>,
-
-    #[pin]
-    clks: Mutex<Clocks>,
-
-    #[pin]
-    regulators: Mutex<Regulators>,
-
-    /// GPU MMIO register mapping.
-    pub(crate) iomem: Arc<IoMem<'drm>>,
-
-    /// GPU information read from hardware during probe.
-    pub(crate) gpu_info: GpuInfo,
+    /// Runtime PM context owned by the PM Registration
+    pub(crate) pm: PMContext<'drm, 'drm, TyrPlatformDriver>,
+    #[uses('bound: invariant)]
+    pub(crate) hw: &'drm TyrHW<'bound>,
 }
 
 fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
@@ -113,6 +137,7 @@ impl platform::Driver for TyrPlatformDriver {
     type IdInfo = ();
     type Data<'bound> = TyrPlatformDriverData<'bound>;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const DEV_PM_OPS: Option<pm::OpsRef<Self>> = Some(TYR_PM_OPS.pm_ops());
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
@@ -130,6 +155,22 @@ fn probe<'bound>(
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
             let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
             let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
@@ -150,41 +191,59 @@ fn probe<'bound>(
 
             let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
 
-            let mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
-
-            let firmware = Firmware::new(
-                pdev.as_ref(),
-                iomem.clone(),
-                &unreg_dev,
-                mmu.as_arc_borrow(),
-                &gpu_info,
-            )?;
-
-            firmware.boot()?;
-
             Ok(try_pin_init!(TyrPlatformDriverData {
-                // SAFETY: `_reg` is stored in `TyrPlatformDriverData` and dropped when the
-                // driver is unbound; it is never forgotten.
-                _reg <- unsafe { drm::Registration::new(
-                    pdev.as_ref(),
-                    unreg_dev,
-                    pin_init!(TyrDrmRegistrationData {
-                        pdev,
-                        fw: firmware,
-                        clks <- new_mutex!(Clocks {
-                            core: core_clk,
-                            stacks: stacks_clk,
-                            coregroup: coregroup_clk,
-                        }),
-                        regulators <- new_mutex!(Regulators {
-                            _mali: mali_regulator,
-                            _sram: sram_regulator,
-                        }),
-                        iomem,
-                        gpu_info,
-                    }),
-                )},
-                _: { dev_dbg!(pdev, "Tyr initialized correctly.") },
+                    hw <- {
+                        let mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
+
+                        let firmware = Firmware::new(
+                            pdev.as_ref(),
+                            iomem.clone(),
+                            &unreg_dev,
+                            mmu.as_arc_borrow(),
+                            &gpu_info,
+                        )?;
+
+                        firmware.boot()?;
+
+                        pin_init!(TyrHW {
+                            fw: firmware,
+                            iomem,
+                            gpu_info
+                        })
+                },
+                pm <- {
+                    // SAFETY: `pm` is owned by the driver data and remains accounted for
+                    unsafe {
+                        pm::Registration::new(
+                            pdev.as_ref(),
+                            &TYR_PM_OPS,
+                            None,
+                            Some(pm_configs),
+                            pin_init!(TyrPMRegistrationData{hw: hw.get_ref()}),
+                            pm::RuntimeStatePayload::Active(runtime_payload)
+                        )
+                    }
+                },
+
+                _reg <- {
+                    // SAFETY: `_reg` is owned by the driver data and is not forgotten.
+                    unsafe {
+                        drm::Registration::new(
+                            pdev.as_ref(),
+                            unreg_dev,
+                            pin_init!(TyrDrmRegistrationData {
+                                pdev,
+                                pm: pm.get_ref().get_ctx(),
+                                hw: hw.get_ref(),
+                            }),
+                        )
+                    }
+                },
+
+                _: {
+                    pm.get_ctx().enable(RuntimePMState::Active)?;
+                    dev_dbg!(pdev, "Tyr initialized correctly.");
+                },
             }))
         })
     }
@@ -239,3 +298,52 @@ struct Regulators {
     _mali: Regulator<regulator::Enabled>,
     _sram: Regulator<regulator::Enabled>,
 }
+
+pub(crate) struct TyrRuntimePMPayload {
+    clks: Clocks,
+    _regulators: Regulators,
+}
+
+static TYR_PM_OPS: pm::Ops<TyrPlatformDriver> = pm::Ops::new();
+
+#[vtable]
+impl PMOps for TyrPlatformDriver {
+    type Adapter = platform::Adapter<TyrPlatformDriver>;
+    type DeviceType = platform::Device<kernel::device::Bound>;
+    type RegistrationData<'a> = TyrPMRegistrationData<'a>;
+    type ActivePayload<'a> = TyrRuntimePMPayload;
+    type SuspendedPayload<'a> = TyrRuntimePMPayload;
+
+    fn runtime_suspend<'a>(
+        _dev: &'a Self::DeviceType,
+        _reg_data: &'a Self::RegistrationData<'a>,
+        payload: Self::ActivePayload<'a>,
+    ) -> Result<Self::SuspendedPayload<'a>, (Self::ActivePayload<'a>, Error)> {
+        payload.clks.coregroup.disable_unprepare();
+        payload.clks.stacks.disable_unprepare();
+        payload.clks.core.disable_unprepare();
+        Ok(payload)
+    }
+    fn runtime_resume<'a>(
+        _dev: &'a Self::DeviceType,
+        _reg_data: &'a Self::RegistrationData<'a>,
+        payload: Self::SuspendedPayload<'a>,
+    ) -> Result<Self::ActivePayload<'a>, (Self::SuspendedPayload<'a>, Error)> {
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
index 9f60a90d4948..28a78ed17e5a 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
 use kernel::{
+    device::pm::PMProfile,
     drm::{
         self,
         Registered, //
@@ -37,10 +38,12 @@ pub(crate) fn dev_query(
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
     ) -> Result<u32> {
+        // Runtime suspend called when pm_scope gets dropped
+        let _pm_scope = reg_data.pm.get(PMProfile::new())?;
         if devquery.pointer == 0 {
             match devquery.type_ {
                 uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
-                    devquery.size = core::mem::size_of_val(&reg_data.gpu_info) as u32;
+                    devquery.size = core::mem::size_of_val(&reg_data.with_hw(|hw| hw.gpu_info)) as u32;
                     Ok(0)
                 }
                 _ => Err(EINVAL),
@@ -54,7 +57,7 @@ pub(crate) fn dev_query(
                     )
                     .writer();
 
-                    writer.write(&reg_data.gpu_info)?;
+                    writer.write(&reg_data.with_hw(|hw| hw.gpu_info))?;
 
                     Ok(0)
                 }
-- 
2.43.0

