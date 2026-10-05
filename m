Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5287D484258;
	Mon,  5 Oct 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207556; cv=none; b=aYl/ZhMUni2hpIm22yoNZQQ2oTaIBJJuxNH56/edNvJLrOeftEAlUbF4vITPSn0OFDFsOL92yKd1F4cQ94Df+m7zA+7s1k7FL1TE3ocz5+PynU0eRx708inkN1s80h7IcrUIn15IeNWZbujQgn7G+oVhdZ8NJq4SAX9sFgWlsXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207556; c=relaxed/simple;
	bh=0jgwHURPmSuH2aatWzvu9omFHzMVFLxY67H1caEEERM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0080w5pzGILUMQyBZvphgwbrshRHVsRe4p6YzSbr5CdKIuYP3DctVVKh9eN07JC5+ypauNeLPjjIa3oPde59nkjy6mjl41S3yDe17fbap5ZwRxlHgeyu/KecfypGPn2SuHjspIxIGAiaUkKL53+8iiRhgpCdq2aGVvOi+cNYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S1wKT7Qa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S1wKT7Qa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A3A5152B;
	Mon,  5 Oct 2026 06:39:10 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.12.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF5723FA7A;
	Mon,  5 Oct 2026 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791207553; bh=0jgwHURPmSuH2aatWzvu9omFHzMVFLxY67H1caEEERM=;
	h=From:To:Cc:Subject:Date:From;
	b=S1wKT7QaLxOzvopJPXnnUq2yoreTCDInTNPNvIb2vMzhWsCAGzVcrcKxCt0iFkOyo
	 FhJjcbFO5SBUu9rcKyWb9HrmrrXS/sSdn/x5XziyIX3HhTwkzIL1pRpddbmJMb0Rnf
	 kQsZni1lWw5nwkl17wqK1eWSw7oDDjGoWD0I4kgw=
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
Subject: [PATCH v4 0/3] Rust: add runtime PM support
Date: Mon,  5 Oct 2026 15:37:38 +0200
Message-ID: <20261005133857.1572243-1-beata.michalska@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/base/base.h             |    3 +
 drivers/gpu/drm/tyr/driver.rs   |  120 +++-
 drivers/gpu/drm/tyr/file.rs     |    3 +
 rust/bindings/bindings_helper.h |    1 +
 rust/helpers/helpers.c          |    1 +
 rust/helpers/pm_runtime.c       |   44 ++
 rust/kernel/lib.rs              |    1 +
 rust/kernel/platform.rs         |   29 +
 rust/kernel/pm.rs               | 1146 +++++++++++++++++++++++++++++++
 9 files changed, 1324 insertions(+), 24 deletions(-)
 create mode 100644 rust/helpers/pm_runtime.c
 create mode 100644 rust/kernel/pm.rs

-- 
2.43.0

