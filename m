Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786436B905;
	Sat, 26 Sep 2026 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790414813; cv=none; b=HMjX+T8u0RzhthFZnW2dCwz9qOVS6phnuHc2ehFcCq/D+vt7amQ/c56VWpRtt9tP2b5imekd7XI4kXydkAsPSGwYNmhrWYnfy0rA0YlSQ7GGjfOfzhBV50uUZBSL41Qg9KchtKkSrQFCUH32veg8/PlsTSfekh50gEl/Np8xo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790414813; c=relaxed/simple;
	bh=LO8AKIR1ZYcQaQz00PDxir3UMP6AhxPZBPVs1IhWyU0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ivE+NGXbZi469gBYU0q7IGm0jw3c5QNBQb4Gxx6aVBwPNyexyaTJw6wKuM0aJxL4lhXT4MuMg+nCJFHVcHMBM2Crfvdwbb46GSLN3J+JlhDh6xOocpBMvFPB7842X5toxd35xHPJun2Oe/iN10AgU6P9McpH8NrR35KqbChZJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOuRxBEY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOuRxBEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D41F000FF;
	Sat, 26 Sep 2026 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790414812;
	bh=ESmr6c9B3f3nPHgJ9uIGzyifAGO5yB3Lw2nHs6HrCGI=;
	h=From:Subject:Date:To:Cc;
	b=FOuRxBEYB8jZsQc86a0abbiPSCGuVnZ3dl/ZVCDQpDGwhDchPhx1mx2qZmuVIUza7
	 dGG6SHxZJAcUWQ+27tgUyQVZXe6sK7yxODc3PctEl0fhb5ElOINWn4LjJD0z78SoNC
	 GHvsSvYyUrAoArg5BT4dn7DNtFKaN5/By8CPJflPSPVlDbomVkiTgdjzEl4orM+q9Q
	 OU+vdQCb1BQl+r30ju34Nr3McD6Wp4PLcAGmlxgTl2z6gkUDfuPflHTHpTuTETX7pX
	 1w0bJrCQKiurLmCqfhaRxZpLR9J33Kslw+R5p2cvobTUR3PQ33Mz1eLKm4Rm7K6+EE
	 t9fa0m2bP+kEw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v2 0/5] hibernation: make safe_copy_page more robust and
 remove debug_pagealloc support
Date: Sat, 26 Sep 2026 12:26:29 +0300
Message-Id: <20260926-hibernation-v2-0-235f69f3ab2a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOQQ7CIBBFr9KwFoU2oa0r72G6YNppQQUM0EbT9
 O5CjQuXb+bN/7OSgF5jIOdiJR4XHbSzCcpDQXol7YRUD4lJyUrBWi6o0oDeypg8WgtWQSMQ2oa
 TdPH0OOrXnnbtvhxmuGEfc0Q2QAak4KXtVR4Z46I5GUNnG6KEB2ZH6RCdf+8vLTxn/drrv/aFU
 0brsR5GidUAyC73tMPH0fmJdNu2fQD97zla3QAAAA==
X-Change-ID: 20260916-hibernation-7603b86eb981
To: Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Potapenko <glider@google.com>, 
 David Hildenbrand <david@kernel.org>, Marco Elver <elver@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Len Brown <lenb@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.1-dev

When hibernation creates a memory image, it uses set_direct_map() APIs to
temporarily map pages that are marked as not present in the kernel page
tables.

Initially, this was intended to support debug_pagealloc along with
hibernation on x86.

With the increasing desire to use set_direct_map APIs for hardening
features and with their inconsistent implementations across architectures,
using kernel_page_present() + set_direct_map_valid_noflush() to save
non-present pages in the hibernation image is not very safe, to say the
least.

Worse, some combinations of debug features, such as debug_pagealloc and
PAGE_POISON cause a crash during restore.

Keeping debug_pagealloc compatible with hibernation requires a complex
infrastructure for tracking free unmapped pages with a page flag/page type,
verifying that it is actually a free page that hibernate_map_page() tries
to remap and making sure there are no stale or failed page table updates.
With init_on_{alloc,free} and/or PAGE_POISON on top, this also requires the
ability to map and initialize these free pages on restore.

This complexity does not seem justified for a somewhat niche debugging
scenario.

Instead of a complex fix to support hibernation with debug_pagealloc, make
sure that copy_data_pages() and its helpers properly handle errors that may
happen during page table updates, explicitly enable saving of KFENCE pages
and disallow hibernation when debug_pagealloc is enabled.

---
Changes in v2:
- use hibernation_available() to close secretmem race
- rename kfence_restore_mapping() to kfence_reset_mapping() for better
  symmetry with kfence_force_mapping()

- Link to v1: https://patch.msgid.link/20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org

---
Mike Rapoport (Microsoft) (5):
      hibernation: make swsusp_page helpers static
      hibernation: ensure secretmem pages don't reach a snapshot
      hibernate: handle potential errors in hibernate_{map,unmap}_page()
      hibernation, KFENCE: explicitly map/unmap KFENCE pages
      hibernation: make hibernation unavailable when debug_pagealloc is on

 include/linux/kfence.h   |  29 ++++++++++
 include/linux/suspend.h  |   6 ---
 kernel/power/hibernate.c |   6 +++
 kernel/power/snapshot.c  | 137 +++++++++++++++++++++++++----------------------
 mm/kfence/core.c         |  52 +++++++++++++++++-
 5 files changed, 159 insertions(+), 71 deletions(-)
---
base-commit: 99d08cb94abb5aeefbda36dc8bd15677c6f76f45
change-id: 20260916-hibernation-7603b86eb981

--
Sincerely yours,
Mike.

