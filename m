Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D628850E;
	Tue, 13 Oct 2026 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911346; cv=pass; b=S2M2Rrl0BoU7IJtU6BNbf5PzvIDDoU4Xzd7ecqdGl6zPxGUvESGDYy/ZZEzASaGK6JSJSHFJRqcYodmW6o29shwLT42xdk4KSBH2YdmyJO4wI+7UX1ynI2L41V+No/oLMiHwC0zgsUR6Hn3fy8mgYDRHeYCpSC2dzmUoRi+Mijw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911346; c=relaxed/simple;
	bh=IpWmyPQgsVDGSNt6llldAaDS55/CjrI5G8XAEbzytUY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R4tTKU2NrL4PzmcMaaaLGvxWwsRxhzXN0W4+T4+stsnUc1IlSM5T8ILBLt0zs5pi73iNEvdG8Vy3DrGWYZEsI9jdJK4L16MYjgSLsYGx87xXuZNjlQN4SQOFY5xFQBFgdJEERftxiTkb7RAaM/RNNJELeACeRU4zpHpULRk2RtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=crV1fo8Y; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="crV1fo8Y"
ARC-Seal: i=1; a=rsa-sha256; t=1791911289; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mfIrgCehaFLWkqQlKS3VGS/pVkr8f/IJcq+kyeJFupdLA1r+8xcHckG/fObYTQ8XyHlM64BmsjHJgCfbyq4yxP2Ydgjdb1Movyux++039RQqCJlW2ueM5uzWFHv8Eb8D1VPaut857b7B7brqUCN2Cg4Ao3zI82XPexP75WRQNk4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791911289; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CPCHlzrectKcVe5zKVmVCz7i/1K/BPfs+kZWr+grD+A=; 
	b=HVqKbb/RCQM8ErQ8SuUyStdNgAQ9Tez0WDXfTA9MV8jqN14HgG7kXGe94U4bsR/kZXgHfIFFnjTy0GtBC9/FKz1Y1ZCOtnMt4YaADnM3M/nyKFvu3XC6PKGpiS5gM4YcRdKpqGgtdAJIKpnyhA1/VCk/tdSWm+ezAzxXKdzrHWM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791911289;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=CPCHlzrectKcVe5zKVmVCz7i/1K/BPfs+kZWr+grD+A=;
	b=crV1fo8YbkJbpb35sFsOE8gBHoQlUgv538AH1dZ2xwJ0KF1074KXwAM42FxwOV7E
	XDZkD681c73S0ZTkE4fBSpttwlB4yLpcmE04VmTNgqsFGcU2HoxjzVWzG40dyHriE8X
	4/xXjyHD5nMYBQeLOAGtPnp9sOXidkuMCasolZeE=
Received: by smtp.zohomail.com with SMTPS id 1791911287188743.1518436996159;
	Tue, 13 Oct 2026 10:08:07 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v6 0/7] Clk improvements
Date: Tue, 13 Oct 2026 14:07:39 -0300
Message-Id: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6XRTW7DIBAF4KtErEs1A+HHWfUeVReAxzVqElJMr
 UaR716ctLIUZ9flW7wPRu/CBsqRBrbbXFimMQ4xHWvQTxsWend8Jx7bmpkAoaCBhof9By/nE/G
 huEI8ADpn2lYpbFktnTJ18fsKvr7V3OV04KXP5BbGiBUzIkduG+2VtKg7419C2u+dT9k9h3SY5
 T4OJeXz9aejmP3/aLd7EFZVwYGjb0xA9F5LvKvON43y73UNCGZFyEoY00qSRKoJ4hGxXQiNdkV
 sK2E9gRXGarDwiFALYUCvCFUJbYLqpNAOdbgnpttamT6/6urld7Jp+gEsdWizEwIAAA==
X-Change-ID: 20250909-clk-type-state-c01aa7dd551d
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

This series contains a few improvements that simplify clock handling for
drivers.

Patch 1 converts clk.rs to the kernel-vertical style for imports.

Patch 2 replaces OptionalClk with Clk::get_optional(). There is no struct
optional_clk in C, and Clk already allows a NULL pointer.

Patch 3 implements the same typestate pattern that has been used
successfully for Regulators. This is needed because otherwise drivers
will be responsible for unpreparing and disabling clocks themselves and
ultimately handling the reference counts on their own. This is
undesirable. The patch automatically encodes this information using the
type system so that no misuse can occur.

Patch 4 adds guards that prepare and/or enable a clock for the lifetime
of the guard without consuming the Clk, so that a driver can keep a
long-lived Clk<Prepared> and enable it for scoped sections.

Patch 5 makes things more convenient by offering devres-managed APIs. This
lets drivers set clock parameters once and forget about lifetime
management.

Patch 6 adds ExclusiveClk<T>, which holds rate exclusivity over a Clk<T>
in any state until it is dropped.

Patch 7 uses it in pwm-th1520 to lock the clock rate for the lifetime of
the driver data.

---
Changes in v6:
- Rebased onto the latest clk-next.
- Moved the import style conversion to the front (Alexandre, Onur).
- Kept Alexandre's and Onur's Reviewed-by on the imports patch, and
  Alexandre's on the devres patch. Dropped Alexandre's Reviewed-by on the
  type-state patch, which changed too much since v5.
- Split the OptionalClk removal into its own patch (Gary).
- Replaced "rust: clk: implement Clone for Clk<T>" with EnabledGuard,
  PreparedGuard and PrepareEnabledGuard (Alexandre, Gary). Clones shared
  a single struct clk, so per-consumer state such as the rate
  exclusivity taken by clk_rate_exclusive_get() was shared between them.
- Dropped Clk::<Prepared>::with_enabled(), superseded by EnabledGuard.
- Named the ClkState constants ENABLED and PREPARED from the start
  (Alexandre).
- Implemented Debug for Error<State> (Alexandre).
- Documented that dropping a prepared or enabled Clk may sleep
  (Alexandre).
- Used a different connection id for the second clock in the example
  (Alexandre).
- Used `?` in the per-state get() and get_optional() shortcuts.
- Dropped the trailing `//` from doctest imports (Alexandre).
- Removed the intra-doc links from SAFETY comments (Onur) and reworded
  the devm_enable_optional() documentation (Alexandre).
- Expanded the devres commit message (Gary).
- Added ExclusiveClk and its pwm-th1520 user, based on Maurice
  Hieronymus's series [1], with ExclusiveClk made generic over the clock
  state, ExclusiveClk::new() in place of Clk::rate_exclusive_get(), and
  a new ExclusiveClk::into_inner().
- Link to v5: https://patch.msgid.link/20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com

[1] https://lore.kernel.org/rust-for-linux/20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org/

Changes in v5:
- Rebased onto the latest clk-next.
- New patch: "rust: clk: implement Clone for Clk<T>". Each clone is an
  independent view of the same underlying clock, owning its own
  prepare/enable counts; the raw pointer is shared through an Arc so
  clk_get()/clk_put() stay balanced. Follows the v3 discussion with
  Boris Brezillon and Gary Guo.
- Moved rate() and set_rate() from Clk<Enabled> to all states; the C API
  does not restrict these to enabled clocks, and some clocks can only
  change rate before being prepared.
- Made Clk::<Enabled>::disable() infallible, matching unprepare() and
  the void C API (Onur).
- Fixed a typo in the "# Invariants" section, fixed SAFETY comments
  that referred to the non-existent `self.0` field, and added missing
  INVARIANT comments on the state transitions.
- Added the missing rustdoc link definitions for clk_unprepare and
  clk_put (Maurice).
- Dropped the redundant `Result` import and the `use
  kernel::error::Result;` lines from the doctests; the prelude already
  provides it (Miguel).
- Added #[inline] to the devm_* helpers.
- Link to v4: https://patch.msgid.link/20260618-clk-type-state-v4-0-8be082786080@collabora.com

Changes in v4:
- Rebased onto clk-next. Alice Ryhl's "rust: clk: implement Send and Sync"
  series is now merged upstream, so it is no longer carried as a dependency.
- Fixed the build with CONFIG_CPUFREQ_DT_RUST=y. The generic DT cpufreq
  driver only has the (unbound) per-CPU device, so it cannot hand a
  &Device<Bound> to Policy::set_clk(). Added a pub(crate) Clk::get_unbound()
  for the few in-tree abstractions that operate on a device outside a bind
  scope; set_clk() now takes &Device and uses it. Clk::get()/get_optional()
  and the devm_* helpers still require &Device<Bound>.
- Added impl From<Error<State>> for kernel::error::Error, so the fallible
  state transitions can be used with `?` (and chained) instead of
  .map_err(|e| e.error).
- Added Clk::<Prepared>::with_enabled(), which runs a closure with the clock
  temporarily enabled, scoping the Enabled state without giving up the
  prepared clock.
- Documented how to change a clock's state at runtime via an enum, for
  drivers that enable/disable across resume/suspend.
- Link to v3: https://lore.kernel.org/r/20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com

Changes in v3:
- Rebased on top of 6.19-rc4
- Dropped patch 1 (from Alice), added her series as a dependency instead
- Fixed Tyr, PWM_TH1520 drivers
- Changed clk.rs imports to kernel-vertical style
- Added support get_optional shortcut for Prepared and Enabled (i.e.:
  Clk::<Enabled>::get_optional())
- Fixed misplaced #[inline] tag

Thanks, Danilo {
  - Moved the devres changes into its own patch
  - Require &Device<Bound> for all functions where a &Device is used
  - Account for con_in in SAFETY comments where applicable
  - Added backticks
}

- Link to v2: https://lore.kernel.org/r/20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com

Changes in v2:
- Added Alice's patch as patch 1, since it is a dependency.
- Added devm helpers (like we did for Regulator<T>)
- Fixed missing clk_put() call in Drop (Danilo)
- Fixed missing parenthesis and wrong docs (Viresh)
- Removed extra "dev" parameter from "shutdown" example (Danilo)
- Removed useless type annotation from example (Danilo)
- Link to v1: https://lore.kernel.org/rust-for-linux/20250729-clk-type-state-v1-1-896b53816f7b@collabora.com/#r

---
Daniel Almeida (6):
      rust: clk: use 'kernel vertical style' for imports
      rust: clk: replace `OptionalClk` with `Clk::get_optional()`
      rust: clk: use the type-state pattern
      rust: clk: add guards for scoped prepare and enable
      rust: clk: add devres-managed clks
      rust: clk: add `ExclusiveClk`

Maurice Hieronymus (1):
      pwm: th1520: Lock clock rate with clk_rate_exclusive_get

 drivers/cpufreq/rcpufreq_dt.rs |   7 +-
 drivers/gpu/drm/tyr/driver.rs  |  32 +-
 drivers/pwm/pwm_th1520.rs      |  25 +-
 rust/kernel/clk.rs             | 834 +++++++++++++++++++++++++++++++++++------
 rust/kernel/cpufreq.rs         |   8 +-
 5 files changed, 748 insertions(+), 158 deletions(-)
---
base-commit: d3645b43ad60fe1ab3b4a869f6908414d5831a65
change-id: 20250909-clk-type-state-c01aa7dd551d

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>

