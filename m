Received: from out-12.smtp.spacemail.com (out-12.smtp.spacemail.com [198.54.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD137BE6A;
	Mon,  6 Jul 2026 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307314; cv=none; b=l5ix9BEqyGLPjozr+seFOIE2LhKGcaSST0+n9kkCeTi4nDRGcEw8hpY5vWToWw5dyDLh0rEr02bFNSDkcgBWFG6PG5NR/5ZMbyBj/pVr0hJUHn4FQ8nrmvjmz3GjUg2SEZBTNkJJ0+F+f/3Tr2AXtLjacT9UDphWKNquSt0BfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307314; c=relaxed/simple;
	bh=+DA/HwoXt7CtF2Uarvdl198hd82vebz936EdyVEhDzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dEEaa5UVrGeGY98+w0+mun35fMAQEZe4fK5a+nhFnhltC6fsoieGEHRCj5vCLl9VsupDJfEstZqRlm0CeFJLR50S3pj8RJff0tKWJwKfayjchLf3qHmtjA/5NcXwBmUmTlGj/sJKvYObNW20YD7U1BpoqGod0Yb1uQCVmN75mkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=DpIHLWtA; arc=none smtp.client-ip=198.54.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="DpIHLWtA"
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gtq7F2p22z8sWS;
	Mon, 06 Jul 2026 03:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1783307306;
	bh=YRMibSFwK804QPJPIgF7c0N519nNgQsUXfo43Xxwf9A=;
	h=From:Date:Subject:To:Cc:From;
	b=DpIHLWtAxqqtYxhZ+fcfthWdTnc6cS6vv/np6zwVeXZM17BQEvkxSjA+bAqT9gNk6
	 OzDln4gs59uCdDmiKxM3b5+WRbF5rJaqg1TilOHPqtvVn+wJA0jvcOgzYLBhbNZYWG
	 GatIEaXv27qCKHvW9+S7us9F+xD8FEheHPgCq0JLvEGQ/7P0+8fufIAVeQcSTug3JP
	 8WU2vJaM50NmPMcC0iZ2VO8yBNki1WIe7Ln08/yZ7S5S3Ki03koZWAPGDEwqJ2HCVl
	 kL3DEX2GCfmwvrMeqbuLpeOKB72JbzBYmYfgVH2MQU1U9EWK7WUAl51wfsHoADo6QO
	 9olLZc/DdOPEQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 05 Jul 2026 20:08:15 -0700
Subject: [PATCH] rust: rcpufreq_dt: use vertical import style
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-pm-rust-vert-imp-v1-1-8aa778c32d82@gurudas.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQ6DMAxA0asgr7EUhpThKogFoW5rJCCyA0JC3
 L2hXb7F/ycoCZNCm5wgtLPyukRkaQLjZ1jehPyMhtzkD1MZi35G2TTgThKQZ4+1K5vMVY2zhYW
 YeaEXH79l1/+tm5toDPcHrusLF4MSq3QAAAA=
X-Change-ID: 20260705-pm-rust-vert-imp-8b491b79b535
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
vertical import style") and found a few more locations that could
benefit from this cleanup. No functional changes.

Separating out patches per-subsystem as per the review feedback in [0].

Tested via:

    $ make LLVM=1 rustfmtcheck || echo "fail"
    $

[0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
---
 drivers/cpufreq/rcpufreq_dt.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 10106fa13095..5d27857261da 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -4,12 +4,19 @@
 
 use kernel::{
     clk::Clk,
-    cpu, cpufreq,
+    cpu,
+    cpufreq, //
     cpumask::CpumaskVar,
-    device::{Core, Device},
+    device::{
+        Core,
+        Device, //
+    },
     error::code::*,
     macros::vtable,
-    module_platform_driver, of, opp, platform,
+    module_platform_driver,
+    of,
+    opp,
+    platform, //
     prelude::*,
     str::CString,
     sync::Arc,

---
base-commit: da2e2fd83f1ef6160bfe2b863bbb904b44263dc4
change-id: 20260705-pm-rust-vert-imp-8b491b79b535

Best regards,
--  
Guru Das Srinagesh <linux@gurudas.dev>

