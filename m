Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09F31AF2D;
	Thu, 17 Sep 2026 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625237; cv=none; b=IeAdNOVSeiq9ryO4241/ewDuFWYZyXBMAZV6cQjdXMMN/PcDtyxTK+hgsgTbAthCMT5KcpwERn7GlhbHga4da2XRq+hX691m3We+KRcr0Y3E3g6zgi3uOVPggnqWmRG/pFs2+X3zkeKNFtQ11wBrvXiS1UM34guc3ZaFR6rt4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625237; c=relaxed/simple;
	bh=NHP3eBUIItFXgYj/WhQacdhHIvMQgpz+lUR1XBeJLhc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M56sd+4eksf4coECuqITPna5OsFmSn5hdVNGGhZXNBqkatUX+Lt7/yw2xUiqi9GQwmgLyFvv6iV3/PMpywHFCbCZpsULgkIOoQXUZSZaFSuNXRu46qvXHaws0hekXuW1+FwI8/De8cnvUpING6GuOmI7m2+tfplGE2P/qI8xXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F64G9Zxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F64G9Zxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9191E1F000FF;
	Thu, 17 Sep 2026 06:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625235;
	bh=iU73g1jvl6feg7+ltGvAXjA/dTAvCMcKsUeaZ/YOwCA=;
	h=From:Subject:Date:To:Cc;
	b=F64G9ZxdWZ/xrdo7gIaTiOhKK7qE0nx/tWPLPOuhNcCTjvck6UWxNktHn+t2UFQJ6
	 kM7cgdfWgxp1BsUUTCTLCFnD3LlVq7e6tUA3i33Y65O5C3+zbVis//43Zl6BOoN9rQ
	 LXkUgyd2CLsmRezvHjWECAI2B/4y9zRZt4xnFl+h7kRQLarWrgr5/QKtj8PM9ssjF7
	 TV8yrjNGIfQyBCmOib9kk+8LDuDuoyaUpwFfANCw+jgFncrgnWOUkvt4vqHvpsmqbM
	 X6JDpheJNdYBM9B2brYMsI6Atc6tNHBEymaxMiRcsMkS+WUkKzmNFOEsml4GCXj0Wq
	 6jmdQoC9pWqHA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/5] hibernation: make safe_copy_page more robust and
 remove debug_pagealloc support
Date: Thu, 17 Sep 2026 09:07:02 +0300
Message-Id: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CIBBFr9LMWiK0CbZexbhgcJQxQg1DTZOmd
 xd0+X7efxsIZSaBc7dBpg8Lz6mCOXTgg0sPUnyrDL3urZ6MVYGRcnKleupk9YCjJZxGA/XxznT
 n9Ve7XP8sCz7Jl5ZoBjohhdklH9oU41ziMUa1JCkOXwT7/gXF3/CgkwAAAA==
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
base-commit: 0820e2e85e8aafde66256c567ad37a5b15708d4d
change-id: 20260916-hibernation-7603b86eb981

--
Sincerely yours,
Mike.

