Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF946AA68;
	Tue, 21 Jul 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648212; cv=none; b=mdYUDMbQd/ng8R46bO42EbyFS23/Wsp/grBmF3wogDaLIj4BNGWg+LobLLe9q3jJPw0suM4rRNAOQhgKwAbseHGbrEhXtEZQq2NvdiaVM5IQeoNusgrBsoqlSiZTEkZuC2bPqgju66EzyTjuk+dCuYOD55jP9cdUc/ktwqof6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648212; c=relaxed/simple;
	bh=Tgx+AsJ1cZ3aSr/XoMl1XYAEYXaxeH8/wj0VMqXxtR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPo0k8qVla2nAdkG0c+g1Wbqcs/rXxPrs1TG2mcIpBupbyk6l43Fe0IGiAEkPz+SLYFHJTriCauXaKKJIXC+CHr39e1bSmOsbcZmy+8WlC8b+em8V6vnOlSoOKFSiboffJkpAbU833WtDcU6VrJULHkdM68XAxn9umOP43P996c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cdItnyw0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cdItnyw0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4262E152B;
	Tue, 21 Jul 2026 08:36:46 -0700 (PDT)
Received: from e143943.arm.com (unknown [10.57.39.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 183F73F58B;
	Tue, 21 Jul 2026 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784648210; bh=Tgx+AsJ1cZ3aSr/XoMl1XYAEYXaxeH8/wj0VMqXxtR0=;
	h=From:To:Cc:Subject:Date:From;
	b=cdItnyw0mOsCIiaH9NX6ROh0LFOM6x3wj68pzHvRZaJlXoJsc9i5T7uZoDxw2jVkx
	 RJysIRfsORtLydMSkkP/bJZRs9/R0JEGf5AhIdJnVMt7CRR6KlDXlvIPjEHYGpoUCN
	 TMaO8/haBtZicKB97oYbZ/6qtqHV4m0ixixl7U80=
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
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/3] Rust: add runtime PM support
Date: Tue, 21 Jul 2026 17:34:01 +0200
Message-ID: <20260721153617.869933-1-beata.michalska@arm.com>
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

It is based on Danilo's drm-lifetime branch [1]

Note: Currently the PM abstraction stores the payload data associated with the
PM transitions within `struct device_private`. Newly introduced member has been
deliberately named 'rust_private', wiht the intention to be extended to cover
data registgry (on the Rust side) for any future cases that might need to take
the same approach as PM abstraction. And those are comming.
The work is ongoing and hopefully will be available soon.
For the time beinng the
	`rust_private`
is intended to represent
	`rust_pm_private`.

TBC

---
v2:
- Moving away from the old PMContext<T, Dormant/Active> type-state design
- Introducing an explicit Registration<'a, T> object.
- PMContext now carries a lifetime and is derived from the registration
- Callback data is no longer recovered through driver data
- Simplified PMOps
- Runtime payload handling change
- Request helpers slightly extended

---
[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drm-lifetime
---

Beata Michalska (3):
  rust: add runtime PM support
  rust: platform: wire runtime PM callbacks
  drm/tyr: enable runtime PM

 drivers/base/base.h             |    3 +
 drivers/gpu/drm/tyr/driver.rs   |  112 +++-
 drivers/gpu/drm/tyr/file.rs     |    7 +-
 rust/bindings/bindings_helper.h |    1 +
 rust/helpers/helpers.c          |    1 +
 rust/helpers/pm_runtime.c       |   44 ++
 rust/kernel/lib.rs              |    1 +
 rust/kernel/platform.rs         |    9 +
 rust/kernel/pm.rs               | 1020 +++++++++++++++++++++++++++++++
 9 files changed, 1177 insertions(+), 21 deletions(-)
 create mode 100644 rust/helpers/pm_runtime.c
 create mode 100644 rust/kernel/pm.rs

-- 
2.43.0

