Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520173;
	b=aaaEHU4gqVPLCOgDygg1Kbw8GxplN/R0VvNly+Y9mQX8kimrRIV19PqVnXWtPwbWhUCC
	 Z3eI27EZ7JroMloxLc1mVv6mJ4DAQNui0tgdq+D+Epzm4LL/0jHmZlGtO1kRzL7SOBPuN
	 aRXaGF12cNoYdy3eo7jgyTij7t+T5lHrbI0jpepyWWAqX3PwxaPlad/1GH1hJQyvwcbSI
	 A4UE4uONd8beBU9ILh7leqrNRiqxCUA0khmm891tfiF6lz1ZPjU2/s0hN1UVxDR3vUYDo
	 jUZd0x+vPFf1qR+6RELuvrn5HBFC0bkM8QBPkWuWtzZ/7y6bbTmZXLUlxJHciGVS59A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520173;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=I2TqkGgxHFzcyVp4L8pzpJi/68Ki2N16/nLbGh9MqB0=;
	b=mJzTyvWQQ2JsZ11Wdi4IRb6Iu7kueT7Qx5uHmUA4NrqLSeXx9a/sqnht/9zCYYrZsHkT
	 cFKpHJSDbVU7S/lAcozv0gKFifBD3NijYUIcQ0tZiUPVTqWD+dY32Sa9jQ4A1BsxX3iIV
	 J/GEJB9v00MC2e9jJ3Y/uSZjLQVLtyFrrt/VU6qgaMBpPFmCC8FRleIBAto35ipwdycii
	 Fr85Bm3TvmtnmzAm8GE4Jon855JkYubQS77PZYMvQbM2m+Pgo3SnbPRuTNQuMSmEdXTgf
	 b+j+G0JK3yRFV+Q5rf3KBmvuF58UUXnj8zBV//3vT0hr3SK4rikiQAYSxQjgstwGkrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TP10+jy6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285A606A31E;
	Tue, 24 Nov 2026 11:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6285A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TP10+jy6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3C6B339;
	Tue, 24 Nov 2026 03:36:08 -0800 (PST)
Received: from e143943.arm.com (unknown [10.57.70.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 331FA3F86F;
	Tue, 24 Nov 2026 03:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795520171; bh=bkw4r3g5o+CnTBW29Hdoh8bA4elmp4UthjosKuUd3AE=;
	h=From:To:Cc:Subject:Date:From;
	b=TP10+jy6NrJmehU32+K6vL0cI2+pNEnncHe8o6aIUR7CpUslyInrxzvutyEV8Gvbz
	 Pm9wifsne5qLrIDnsCamAHv7rmqSmt0au1YQiZ4+l2ghrLsrmi7/XfXfh88TPKADcD
	 ReUuX18e7p4kM0ZwmscJhrk8hBZDnJOaOTEjnVBQ=
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
Subject: [PATCH v6 0/3] Rust: add runtime PM support
Date: Tue, 24 Nov 2026 12:34:11 +0100
Message-ID: <20261124113555.2480381-1-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
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
v6:
- Moved the runtime PM API from rust/kernel/pm.rs to rust/kernel/device/pm.rs
- Reworked `Registration::new()` to initialize pinned registration data and
  return a `PinInit`; replaced the cloned, Arc-backed `PMContext` with one
  borrowed from the registration.
- Replaced the single `'static` runtime payload type with separate active
  and suspended payload types, plus registration data passed to callbacks
- Tied PM request scopes to the registration lifetime instead of device's one
- Added SRCU synchronization and intermediate enable/disable states so
  registration teardown waits for those operations to finish.
- Fixed `ResumeScope` and `AwakeScope` handling of `EINPROGRESS` for ASYNC
  and NOWAIT requests; rejected NOWAIT in the synchronous closure helpers.
- Changed enable ordering to apply PM configuration before marking the
  initial device state. Reset autosuspend and ignore-children settings on
  failure, disable and teardown.
- Updated naming, comments and documentation for the revised API and according
  to review suggestions.
- Removed the zero-valued `Sync` mode in favor of `Mode::empty()`, renamed
  `RuntimePMState::Resumed` to `Active`, and updated the PM ops type names.
- Reworked the Tyr example to use pinned hardware, PM and DRM registration
  data with explicit lifetime and drop ordering.

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

Beata Michalska (3):
  rust: add runtime PM support
  rust: platform: wire runtime PM callbacks
  drm/tyr: enable runtime PM

 drivers/base/base.h             |    6 +
 drivers/gpu/drm/tyr/driver.rs   |  220 ++++--
 drivers/gpu/drm/tyr/file.rs     |    7 +-
 rust/bindings/bindings_helper.h |    1 +
 rust/helpers/helpers.c          |    1 +
 rust/helpers/pm_runtime.c       |  101 +++
 rust/kernel/device.rs           |    1 +
 rust/kernel/device/pm.rs        | 1187 +++++++++++++++++++++++++++++++
 rust/kernel/platform.rs         |   35 +-
 9 files changed, 1499 insertions(+), 60 deletions(-)
 create mode 100644 rust/helpers/pm_runtime.c
 create mode 100644 rust/kernel/device/pm.rs

-- 
2.43.0

