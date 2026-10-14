Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936640801E;
	Wed, 14 Oct 2026 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008092; cv=none; b=Z4ijidLRzbNaqzSAnIwEwtR5BIybclcbsHvXn8TDsBiaZWWvjLhdwImBoJYDmR28GJp/d6d2s2xraRe2SGusK3cOtIyuAQJdXBG7EUgMtIDJxOjK0AtN9oKkjk48wrCELRnNWTQdW0Ew1JdWSAKDqF3C8rC+aZW99xy+ujTa1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008092; c=relaxed/simple;
	bh=I9paKZ1Ye2RkYWWqdc7aKtlvSvifmN+BX4TRFnwiuwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9kt2oC2zgkqEpkBPRvspYaMZGF1WO3V01z0y8EmAnky+GZeQMbaNLQztN8qU/lKIOjH9602Whx/mK1Sq3bAS0Uny1MAnAFM/RQbD6JUihwo8iLLOmv3FiCuWLOpTABVSdhMbIrfYmG6gmpOYKRJgTkdTCiY3jYQWkSQ/Q4spEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFCcMWV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFCcMWV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083F21F000C6;
	Wed, 14 Oct 2026 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008090;
	bh=7ObxhoVmcKp7FKwThZtHmmrAzt8O/xJpkopjoaCninw=;
	h=From:To:Cc:Subject:Date;
	b=oFCcMWV7wOyX42GATyWunKk75YTi91sNND+7gNW6ldFdngx3ChvCgjOZCVg2C5O2b
	 xUr0AQhwRUizBrgIs5Oo5VPeIDG6JkfqIvzBV7PGp4JH1oGuhboqEKn7SE1/I3KPDS
	 Z8N917B3hVPbLaZlZrB5FCMq7caOTunxTHAY33cOYDgEFTW69Wk1C7zGw8VQjGu7T8
	 PflYlj7gOWp4oWkRdzwZdnWTqfq/csi9GpzhpKeFc1Ml4JWVWULzx/kORCNetiZcVT
	 1/09pLEYgp8n/GcH3AAbU6nsNpZgO7dtJtDJyOBjwZmseMaSycm3FF60ilBsVd5wzG
	 qJSy56ZPk+WaQ==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	kexec@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Wake Liu <wakel@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] selftests: target selection fixes for cross and LLVM builds
Date: Wed, 14 Oct 2026 16:01:22 -0400
Message-ID: <20261014200127.1363472-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few suites select their tests from the build host instead of the
target, or depend on the host C library in ways that break cross
builds. This series fixes the ones found while building the selftests
for several architectures:

 - prctl and the Intel thermal suites build nothing when CROSS_COMPILE
   is set, even for x86, and prctl restricts two generic tests to x86.

 - set-anon-vma-name-test fails instead of skipping on kernels built
   without CONFIG_ANON_VMA_NAME.

 - kexec only recognizes the ppc64le spelling of PowerPC and decides
   about the x86-64 jump test from the build host.

 - size links a custom _start against the static C library, which
   fails on ARM with clang and on LoongArch; it now uses nolibc.

The patches are independent of each other.

Sasha Levin (5):
  selftests/prctl: build generated tests for the target architecture
  selftests/prctl: skip the anonymous VMA naming test when unsupported
  selftests/thermal: allow cross builds of the Intel tests
  selftests/kexec: select tests using the target compiler
  selftests/size: use nolibc startup and syscall wrappers

 tools/testing/selftests/kexec/Makefile        | 26 ++++++++-------
 tools/testing/selftests/prctl/Makefile        | 18 +++++-----
 .../selftests/prctl/set-anon-vma-name-test.c  |  3 ++
 tools/testing/selftests/size/Makefile         |  9 ++++-
 tools/testing/selftests/size/get_size.c       | 33 +++++--------------
 .../thermal/intel/power_floor/Makefile        | 12 +++----
 .../thermal/intel/workload_hint/Makefile      | 12 +++----
 7 files changed, 52 insertions(+), 61 deletions(-)


base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
-- 
2.53.0

