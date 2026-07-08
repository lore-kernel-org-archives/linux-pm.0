Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761343F86F3
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547320; cv=none; b=EzpLZYlaVzLwNL+Ug7t74ofDLxlve7c+jcfaOTomDj7uIUVBsVh/0VnVz5ZhQlMlCPZdG7tZJEXk+4kPRo815i4+q9PGiE0ttCpNrKQiCICawpxU80Mvo5wA1jrf58ccJsngkSNPkjWwjfQce7bGIhx8AOlLHvwSO3fOzNN3qPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547320; c=relaxed/simple;
	bh=oBzYn/0he9cz2/wYEhSxbP/n2MENiOCwowkBueU0EHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT694FBEXkB1S0cOgKXQ3CWen10gMVhv6EAVPNGuZwdYBbewYlW8OPFGqzx2AxmTB0KDk1DiDDM7aBGoqTZpZTGbHTzAM+ydtK9K+RvPxtK9WMtKFJ+ycPa+XXUyE7XVJU/bwVGvpaWtkCPlRaythcS0qzeAVq8FwuqoWNt9WVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO8wvIaS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO8wvIaS"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so11664015ad.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 14:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783547318; x=1784152118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CcHS4omCQhk6NJkHYXiTY8hUWJw218fa7Nr5nM8cK8s=;
        b=WO8wvIaSoJFMggpqfwmBgZe2JdJrXMskMHz5guokONGFElTeHr+s8dTYLu9ZqhO6DN
         0j+57Q2RplQvi7n17P8zDJGPt+6wQ1WVGDsO0c1D9J6/XD8Loc2gYPnmTpzpjyiF6WtK
         aZ541SMZD6tT6y0OTJQA+Kyc36GOZ4uNUjSvBBbYj9DuaPImaCl4QKtx8Rozd/oWfnQV
         kZunitDST4BiPlEbRSobSWAa462DtE36Qv3Qd1r/3qFETQveEktAwopFNI/FBrlyWYAd
         W6i8yg1pmZqJcoQ3rh0d21ZFt5TG+TURL8BvrLdxWH/meoUrpl6FKPaXpf9O8at4Okyp
         mhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547318; x=1784152118;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcHS4omCQhk6NJkHYXiTY8hUWJw218fa7Nr5nM8cK8s=;
        b=CMz8xB9wkm6H0aztwz5igWBDCWNS74F/ThraNyHO8TrUMutWfE8JOrxiylu4Ppll0x
         z703PTszDHY3UbqPMuL3A61DjCNnhz6eAuQy1G7O3Si9Nfbh3Nu0xbTBzx9wkNIiuDlj
         M7VKnn42owdrcT8X9xmGr5LuyyKf9O/omQMVN9ZcTjPSypGGq5Q6Xm7ZVCa+IcvrsEzI
         hXzV85IpTUgEuD8rfiBi2b0vxhxSymowLbXvj5gTX86hTuAj1XP4LDl+FCD3cYDzHFmM
         yjxivUHd8d2K8spkrsdOWPLN2lJ4UM2VfpgcXmwuZyOIiykAlj/qNzRaST8juTFbeIb4
         0V5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpZ5HXQlbgFWJPA4eN9f/Mx9fD9I2vTVANREGGMIluIal2feK6vGKJHqBG1UVymqFoHGK4vno8NFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WDVNt1pHAAM5vgFmiYKVA8CRZS7D/j/VIX/VkAkqryjxb+wJ
	0my3I0mgxthaPkuKDSGUwhXlZADO5LOddidb+dGvnW6VUqJfzkmed7hf
X-Gm-Gg: AfdE7cn39B6HXZS+QH5DkXOLHQbLDfFw7pT7vFbyurSE7GYHfJzXvqu7nacu/skKX9e
	+4QcNq0Kjqh2QmIECDLYNez3zxTfWvzYp2xwpeTSMnWIzn1WdE430qFrzuTx4+rDwCykj5Z1g7Q
	J1ahwWmJImo/vpXzmI58WBfXs7tx6Q2KZAttKYDKgtzVgVjvT9x2Sh7tpHzb+PS0yvo1y4+qEvT
	G8xms8dUEphTJAOgfvr3l/fPodozCQgrZLEfsuUGXQe/vcwgePVfGPuj4axQmxl5Bom0dpU2aT0
	zeQHymP3qmeYAQ2QsFXDgac6uRpv9Mc4Td65hC2lUKdPBxqFCU0obUgljEgwZtt/43gHHgNaHjS
	cJqKqQAlyFbJw9EGLgzFcUSujPW0RJW5ySyzG2hgmennVyz2wfX8/lEpHh3jI9lgacXsdBuSiO6
	VOhyqi1sLjeSwENoMVMjnacGfs/ExPMfAyEItfsiIjf3A4padDB1lXHx40tiimGHfqEKjU04bgU
	bKHYdRcUipGlpziwbuw7mHdfBHZhWFchdbu1Ymy80IoYMy0pDdyN27tZAPdI7eRYxXtj7LGGlbi
	Y1tReerVWvHV3YM5YXm0ZrAhABRKqG/Ja7tS/JLSGNzURbUQL8Uns7l02dvMDCl5hj+NpV4dTH0
	f8wAHqr4=
X-Received: by 2002:a17:902:ff8e:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2ccea3ca5eemr46255005ad.16.1783547317719;
        Wed, 08 Jul 2026 14:48:37 -0700 (PDT)
Received: from ip-172-31-21-198.us-west-2.compute.internal (ec2-35-85-29-74.us-west-2.compute.amazonaws.com. [35.85.29.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d946sm33733855ad.66.2026.07.08.14.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 14:48:37 -0700 (PDT)
From: Bruce Robertson <brucer42@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Gary Guo <gary@garyguo.net>,
	Tamir Duberstein <tamird@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun@kernel.org>,
	Bruce Robertson <brucer42@gmail.com>
Subject: [RFC PATCH 2/3] rust: power_supply: add power supply class abstraction
Date: Wed,  8 Jul 2026 21:47:37 +0000
Message-ID: <20260708214738.25008-3-brucer42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708214738.25008-1-brucer42@gmail.com>
References: <20260708214738.25008-1-brucer42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is no Rust abstraction for the power supply class in mainline or
rust-next. Add a minimal one:

  - a Driver trait carrying the supply's name, type and property list,
    plus a get_property() method;
  - a generic extern "C" trampoline the power supply core calls back
    into, recovering the driver's private data via the parent device and
    dispatching to get_property();
  - a Registration that owns the power_supply_desc and unregisters the
    supply on drop, freeing the descriptor in the correct order.

Property, type and status constants are re-exported so drivers need not
reach into the generated bindings directly.

Signed-off-by: Bruce Robertson <brucer42@gmail.com>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/power_supply.rs     | 133 ++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 rust/kernel/power_supply.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..8e41f7917825 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21546,6 +21546,7 @@ F:	Documentation/devicetree/bindings/power/supply/
 F:	drivers/power/supply/
 F:	include/linux/power/
 F:	include/linux/power_supply.h
+F:	rust/kernel/power_supply.rs
 F:	tools/testing/selftests/power_supply/
 
 POWERNV OPERATOR PANEL LCD DISPLAY DRIVER
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b..0bdaf7316140 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -78,6 +78,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/poll.h>
+#include <linux/power_supply.h>
 #include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/random.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df..5013bdd30361 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -106,6 +106,7 @@
 pub mod pci;
 pub mod pid_namespace;
 pub mod platform;
+pub mod power_supply;
 pub mod prelude;
 pub mod print;
 pub mod processor;
diff --git a/rust/kernel/power_supply.rs b/rust/kernel/power_supply.rs
new file mode 100644
index 000000000000..f466a89e7b3a
--- /dev/null
+++ b/rust/kernel/power_supply.rs
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Power supply class abstraction.
+//!
+//! C header: [`include/linux/power_supply.h`](srctree/include/linux/power_supply.h)
+
+use crate::{
+    bindings,
+    device::{self, Device},
+    error::*,
+    prelude::*,
+};
+
+/// A power-supply property id.
+pub use bindings::power_supply_property as Property;
+/// The value returned for a property query.
+pub use bindings::power_supply_propval as PropertyValue;
+/// A power-supply type.
+pub use bindings::power_supply_type as Type;
+
+/// `POWER_SUPPLY_PROP_STATUS`.
+pub const PROP_STATUS: Property = bindings::power_supply_property_POWER_SUPPLY_PROP_STATUS;
+/// `POWER_SUPPLY_PROP_ONLINE`.
+pub const PROP_ONLINE: Property = bindings::power_supply_property_POWER_SUPPLY_PROP_ONLINE;
+/// `POWER_SUPPLY_TYPE_MAINS`.
+pub const TYPE_MAINS: Type = bindings::power_supply_type_POWER_SUPPLY_TYPE_MAINS;
+/// `POWER_SUPPLY_STATUS_CHARGING`.
+pub const STATUS_CHARGING: i32 = bindings::POWER_SUPPLY_STATUS_CHARGING as i32;
+/// `POWER_SUPPLY_STATUS_NOT_CHARGING`.
+pub const STATUS_NOT_CHARGING: i32 = bindings::POWER_SUPPLY_STATUS_NOT_CHARGING as i32;
+/// `POWER_SUPPLY_PROP_CHARGE_TYPE`.
+pub const PROP_CHARGE_TYPE: Property =
+    bindings::power_supply_property_POWER_SUPPLY_PROP_CHARGE_TYPE;
+/// `POWER_SUPPLY_CHARGE_TYPE_NONE`.
+pub const CHARGE_TYPE_NONE: i32 =
+    bindings::power_supply_charge_type_POWER_SUPPLY_CHARGE_TYPE_NONE as i32;
+/// `POWER_SUPPLY_CHARGE_TYPE_TRICKLE`.
+pub const CHARGE_TYPE_TRICKLE: i32 =
+    bindings::power_supply_charge_type_POWER_SUPPLY_CHARGE_TYPE_TRICKLE as i32;
+/// `POWER_SUPPLY_CHARGE_TYPE_FAST`.
+pub const CHARGE_TYPE_FAST: i32 =
+    bindings::power_supply_charge_type_POWER_SUPPLY_CHARGE_TYPE_FAST as i32;
+
+/// A driver backing a power supply.
+pub trait Driver {
+    /// sysfs name: appears at `/sys/class/power_supply/<NAME>`.
+    const NAME: &'static CStr;
+
+    /// The power-supply type (mains, USB, battery, …).
+    const TYPE: Type;
+
+    /// The properties this supply can answer.
+    const PROPERTIES: &'static [Property];
+
+    /// Answer a single property query.
+    fn get_property(self: Pin<&Self>, psp: Property, val: &mut PropertyValue) -> Result;
+}
+
+/// `get_property` trampoline: the C power supply core calls this and it
+/// dispatches to [`Driver::get_property`].
+///
+/// # Safety
+///
+/// May only be installed as the `get_property` field of a `power_supply_desc`
+/// registered with `drv_data` set to the parent `*mut device`. The core
+/// guarantees `psy` and `val` are valid for the duration of the call.
+unsafe extern "C" fn get_property_trampoline<T: Driver + 'static>(
+    psy: *mut bindings::power_supply,
+    psp: Property,
+    val: *mut PropertyValue,
+) -> kernel::ffi::c_int {
+    // SAFETY: core passes a valid `psy`; we stored the parent device ptr as its drv_data.
+    let dev_ptr = unsafe { bindings::power_supply_get_drvdata(psy) }.cast::<bindings::device>();
+    // SAFETY: that device is valid while the (devm) supply lives.
+    let dev: &Device<device::CoreInternal<'_>> = unsafe { Device::from_raw(dev_ptr) };
+    // SAFETY: callbacks only fire after probe returned, so set_drvdata stored a `T`.
+    let data = unsafe { dev.drvdata_borrow::<T>() };
+    // SAFETY: core passes a valid `val` for the call.
+    let val = unsafe { &mut *val };
+    from_result(|| {
+        data.get_property(psp, val)?;
+        Ok(0)
+    })
+}
+
+/// A registered power supply. Unregisters and frees its descriptor on drop.
+pub struct Registration {
+    psy: *mut bindings::power_supply,
+    // Kept alive so the descriptor the core holds stays valid until unregister.
+    _desc: KBox<bindings::power_supply_desc>,
+}
+
+// SAFETY: `Registration` owns the `power_supply` and its descriptor; the raw
+// pointer is only used to unregister on drop. Safe to send/share across threads.
+unsafe impl Send for Registration {}
+// SAFETY: as above — psy and descriptor are only accessed on drop, so sharing
+// a `&Registration` across threads is sound.
+unsafe impl Sync for Registration {}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        // SAFETY: `psy` came from a successful `power_supply_register` and has not been
+        // unregistered. `power_supply_unregister` blocks until no callback is running;
+        // `_desc` (dropped immediately after) is then no longer referenced by the core.
+        unsafe { bindings::power_supply_unregister(self.psy) };
+    }
+}
+
+/// Register a power supply backed by driver `T` against `dev`.
+pub fn register<T: Driver + 'static>(dev: &Device) -> Result<Registration> {
+    let mut desc = KBox::new(bindings::power_supply_desc::default(), GFP_KERNEL)?;
+    desc.name = T::NAME.as_char_ptr();
+    desc.type_ = T::TYPE;
+    desc.properties = T::PROPERTIES.as_ptr();
+    desc.num_properties = T::PROPERTIES.len();
+    desc.get_property = Some(get_property_trampoline::<T>);
+
+    // Stable heap address; moving the KBox into `Registration` keeps this valid
+    // (moving a KBox moves the pointer, not the heap allocation).
+    let desc_ptr: *const bindings::power_supply_desc = &*desc;
+
+    let cfg = bindings::power_supply_config {
+        drv_data: dev.as_raw().cast::<kernel::ffi::c_void>(),
+        ..Default::default()
+    };
+
+    // SAFETY: `dev` valid; `desc_ptr` points into `desc`, kept alive in the returned
+    // `Registration` and freed only after `power_supply_unregister`; `cfg` valid for the call.
+    let psy = unsafe { bindings::power_supply_register(dev.as_raw(), desc_ptr, &cfg) };
+    let psy = from_err_ptr(psy)?;
+
+    Ok(Registration { psy, _desc: desc })
+}
-- 
2.43.0

