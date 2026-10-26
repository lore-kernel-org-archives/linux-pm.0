Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017563;
	b=XZRkYoGiYw8LoGsEgKpFFktjF/J9g0Rfm7qrQklZwCUog4FFOPDgzwK+ritXu80rGTJZ
	 BXHA3FcEaBmQF0Vxc0jwhwBrFrRWm/sfi1QlX0u8pFFZTyDqJofHoIWKowiv14WZml7pt
	 HSPonA9y+DA4ByxRZZ4gAGySTM0wZZXSj/jbdLmfCOMlANPVHH+PL9CpBWy+ymKhGHueg
	 ard9AR4X3iFMtIOkNzaLUl3qhFcLsz7w/eQPMbIraG3N+jlyPbTl7tG/yajiFXyVVQrp+
	 VFxugRcRwxuaZkMT8wOtHhgwQilN1yeANw0vw6U4AEOPZ4Ra+uegL34HdfcWv0JwB/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017563;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G8xQcDH2otxxYZLzgFmvvHPotcztln45z2AqQl3MVAo=;
	b=C4l0p2L2c6oZcqigE1a13aK0fnS2klMlRoy8PzB/bcTj0xHGwifSScEtM3NlzQt2ZWr9
	 lRgy0lBkCd08IYEpH3JOBZUgGie/37NYujdJZvUvUrLlC3Yw4aaZcbK0ksP/zOY8s7njf
	 5pK03AVZRKcLxaurEXi1ZXMEkHarQBBuG1mxDK5sG4DUuY3oEgQuC9zgts9+qmbIVJ2Iv
	 eWf4GjtqtoF2tBV4GGyzZStmOnRqg7uulV4ZkMCf05AVDYLBkvL3R0E99nVcWU54Sr09k
	 vtEIM3+KaEKpfhvLBZu2VdJGMzZz9imFRTh7V/4O8wHqwNF6zC0/+uLY/JlCrHt4mAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jXpba3B5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F7606A31B;
	Mon, 26 Oct 2026 12:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D53F7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jXpba3B5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D037428C7;
	Mon, 26 Oct 2026 05:25:58 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.58.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9DD33F7B4;
	Mon, 26 Oct 2026 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793017562; bh=i2qQHLE0grhenajYcjIhJMoYmoqCSUyZD0j5cnUvM9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXpba3B5Td/GG+JNUHPNpT5ECro24BKMrW/Pidl8gZNO5BAFy5B0eUjTmklhucykY
	 l74MdKxItGu3cnA7ZA5t3sTa8lLCT7lvd+QuDhgz231qebyh0kRq303T4GMoNe7Luo
	 o2tPD3Ib4Quz6brmuHdhEa5rXCGWEvv0x9hmSV34=
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
Subject: [PATCH v5 0/3] Rust: add runtime PM support
Date: Mon, 26 Oct 2026 13:25:42 +0100
Message-ID: <20261026122551.536381-1-beata.michalska@arm.com>
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

Hi All,

This series adds initial Rust support for Linux runtime PM.

The concept for Rust abstraction gets introduced in the first patch.
It provides callback registration, PM callback dispatch through PMOps trait,
scoped request helpers for common runtime PM operations and configuration
helpers.

The abstraction intends to keep the request semantics aligned with
the C runtime PM core.

Second patch integrates dev_pm_ops into the Rust platform driver abstraction,
enabling drivers to register PM callbacks with the core.

The last in the series is provided for demonstrative purposes
(not intended to be an actual merge material).

This has been lightly tested with the Tyr driver.

Based on drm-next.

---
v5:
- Added doc comment for `rust_private`
- Dropped the `RuntimePMState::Unknown` as that was no longer needed
- Dropped masking the RPM mode in `ResumeScope::release_inner` as that is not
  necessary and brings in only confusion
- Fixed the behaviour of `AwakeScope::new` when the `Request::resume` returns
  `EINPROGRESS`.
- Note on `RetainScope`: the pairing of:
  `Request::get_noresume` ->`Request::put_noidle`
  is intentional to avoid mixing the expected behaviour of `Scope`s
- Cleaned up all the CONFIG_PM guards
- Switched the `PMPayload` to use `ManuallyDrop<>` instead of `Option<>`
- Apply the `PMConfig` only after successfully marking the devices devices PM
  state
- Dropped `#[pin_data]` for `RegistrationData`
- `Registration::new()` is now usafe to with the safety requirement that the
  `Registration` cannot be mem::forgotten
- Overall cleanup for attributes and formatting
- The `platform::Driver` trait is now sized to enable making the DevPMOps an
  associated constant.

v4:
- Simplified the PMOps/DevPMOps type model by making the bus adapter an
  associated type of PMOps, so DevPMOps is now parameterized only by the
  driver PM implementation type.
- Added DevPMOpsRef to pass typed, adapter-scoped dev_pm_ops references through
  bus registration code.
- Made DevPMOps own the generated dev_pm_ops table and require a static
  DevPMOps instance for Registration::new().
- Made the runtime PM payload mandatory.
- Replaced the PMContext enabled flag with an explicit Disabled/Enabled/Dead
  state machine to prevent re-enabling through stale PMContext clones during
  teardown.
- Updated with_get() to reject NOWAIT profiles in addition to ASYNC profiles.
- Changed AutoSuspendDelay to i32 to match the C runtime PM API.
- Renamed RuntimePMState variants to Rust-style names.
- Dropped the local EINPROGRESS error addition: already available
- Updated the platform PM wiring and Tyr example to the new DevPMOpsRef/static
  DevPMOps model.
- Cleaned up comments, docs, and minor typos.

v3:
- Dropped macros in favour of plain encoding of the PM callbacks
- Moved Mode to use kernel::impl_flags
- Generated PM callbacks, the stored payload, and the device cast
  are all monomorphized for the same (Adapter<T>, T) pair,
  with the registration sealing the contract by validating installed dev_pm_ops
- Platform PM wiring should be type-safe now
- Tracking runtime enable/disable state
- Few fixes for issues pointed out by Sami Tolvanen (samitolvanen@google.com),
  like making the registration teardown respecting the CONFIG_PM settings or
  fixing AwakeScope for async/no wait calls; Sami is also the person behind
  adding get_if_active variant (much appreciated)
- Changed base branch
v2:
- Moving away from the old PMContext<T, Dormant/Active> type-state design
- Introducing an explicit Registration<'a, T> object.
- PMContext now carries a lifetime and is derived from the registration
- Callback data is no longer recovered through driver data
- Simplified PMOps
- Runtime payload handling change
- Request helpers slightly extended


*** BLURB HERE ***

Beata Michalska (3):
  rust: add runtime PM support
  rust: platform: wire runtime PM callbacks
  drm/tyr: enable runtime PM

 drivers/base/base.h             |    4 +
 drivers/gpu/drm/tyr/driver.rs   |  110 ++-
 drivers/gpu/drm/tyr/file.rs     |    3 +
 rust/bindings/bindings_helper.h |    1 +
 rust/helpers/helpers.c          |    1 +
 rust/helpers/pm_runtime.c       |   89 +++
 rust/kernel/lib.rs              |    1 +
 rust/kernel/platform.rs         |   32 +-
 rust/kernel/pm.rs               | 1106 +++++++++++++++++++++++++++++++
 9 files changed, 1326 insertions(+), 21 deletions(-)
 create mode 100644 rust/helpers/pm_runtime.c
 create mode 100644 rust/kernel/pm.rs

-- 
2.43.0

