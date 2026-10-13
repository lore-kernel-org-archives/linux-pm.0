Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BE5218A6;
	Tue, 13 Oct 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911378; cv=pass; b=btPnurM0F4ZmKRmeg4870fgUuBUAD9Jp1BvMgF25Np7VujKCNNT1XErddxJK+Wmm9Fp73wAaYVSdwX8daJHmMU4YNMJngKAYW1RilbJZDxAlYjciFhmRlnFNBYnKQibM17BfmgXYF0OlfOkTKsAlMekjButSwvyX9phWbpQ6Frc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911378; c=relaxed/simple;
	bh=NkG8eBWEaW/aFw1qzDXwU75kpoouS17hH/awpbVx0tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5S9xexVVbXy0qLeZqxIaRJ3WFhaHjE4hSDs25KOg1TC1GFBFbjCMPQehcd67RIQQ/SZXeGG/f9m0yg9hacrUDX2bIbcVK0q4Pt3uiO5WgVfXWbZ5Go2ujfDjsdAa4aCTj6qErPUT05NnoHkswnwTB0scmPz2DSQWuFYtyleLXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=h1psp955; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="h1psp955"
ARC-Seal: i=1; a=rsa-sha256; t=1791911328; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Hf8+IWKRexjLqAAQ3e1Zt9WlPsOnukWe+HanwUOJOzcKBWMeUtLkI763EJCCQiqj0csw0W/QnHQI/633TsaPMRaQja35HIG2QezybgZ5KmsxsOYAVm/ymnr1uA2Iflvhzurlpn7qEfPBVP7Tozt0Q/ddvQwrgqou5YFx5gw0srQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791911328; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p60aizZuEujnCO8yfUL/s2ItwRgdTgERv5BQRJiKttk=; 
	b=YC3WA8iAUuXk0yh9t+Z0nSJni17TRptWOQiyQcY++Mx7pRkkGncNtH2SmNDttRFEy/PgcsNnd4JKIYch/0bT8cQH0Mo9iiLC96vKc6ejLeATm1sObyKbA9/NRRwYJFK8SJ8ifMys8N9ih74k4i439gIkdupkNImehtiUWXFkvDo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791911328;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=p60aizZuEujnCO8yfUL/s2ItwRgdTgERv5BQRJiKttk=;
	b=h1psp955pUzo/PadoHWwg52X/YNiem5pmhvCCNjwQa4CvyVYw6xiVutcqsMLwK9w
	kBRMOeyaiIirxeqzHB9VQUcDIBm1JxpGKSPgENsJ/JF9aAeDoQG2Ft/dT/SV8wLIoBk
	5KSb9zZ+PSrGad5EYNL0hOJAh7bNec+KMvZio0i8=
Received: by smtp.zohomail.com with SMTPS id 17919113261591014.4327720790214;
	Tue, 13 Oct 2026 10:08:46 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 13 Oct 2026 14:07:44 -0300
Subject: [PATCH v6 5/7] rust: clk: add devres-managed clks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-clk-type-state-v6-5-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
In-Reply-To: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Many drivers only need a clock running for as long as the device is
bound and never touch it afterwards. In C, devm_clk_get_enabled() and
devm_clk_get_optional_enabled() cover this case.

Add devm_enable(), devm_enable_optional() and
devm_enable_optional_with_rate(), which wrap the C helpers. They return
no handle, so the driver keeps nothing in its data and cannot change the
state of the clock. The clock is disabled, unprepared and put when the
device is unbound.

This mirrors regulator::devm_enable() and devm_enable_optional().

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 93b4dc17f0ad..e2587c613182 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -121,6 +121,52 @@ impl Sealed for super::Prepared {}
         impl Sealed for super::Enabled {}
     }
 
+    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound device.
+    ///
+    /// [`devres`]: crate::devres::Devres
+    #[inline]
+    pub fn devm_enable(dev: &Device<Bound>, name: Option<&CStr>) -> Result {
+        let name = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: It is safe to call `devm_clk_get_enabled()` for a valid device
+        // pointer and any `name`, including NULL.
+        from_err_ptr(unsafe { bindings::devm_clk_get_enabled(dev.as_raw(), name) })?;
+        Ok(())
+    }
+
+    /// Obtains and enables an optional [`devres`]-managed [`Clk`] for a bound
+    /// device.
+    ///
+    /// If the clock does not exist, this succeeds and does nothing.
+    ///
+    /// [`devres`]: crate::devres::Devres
+    #[inline]
+    pub fn devm_enable_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result {
+        let name = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: It is safe to call `devm_clk_get_optional_enabled()` for a
+        // valid device pointer and any `name`, including NULL.
+        from_err_ptr(unsafe { bindings::devm_clk_get_optional_enabled(dev.as_raw(), name) })?;
+        Ok(())
+    }
+
+    /// Same as [`devm_enable_optional`], but also sets the rate.
+    #[inline]
+    pub fn devm_enable_optional_with_rate(
+        dev: &Device<Bound>,
+        name: Option<&CStr>,
+        rate: Hertz,
+    ) -> Result {
+        let name = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: It is safe to call `devm_clk_get_optional_enabled_with_rate()`
+        // for a valid device pointer and any `name`, including NULL.
+        from_err_ptr(unsafe {
+            bindings::devm_clk_get_optional_enabled_with_rate(dev.as_raw(), name, rate.as_hz())
+        })?;
+        Ok(())
+    }
+
     /// A trait representing the different states that a [`Clk`] can be in.
     pub trait ClkState: private::Sealed {
         /// Whether the clock is enabled in this state.

-- 
2.56.0

