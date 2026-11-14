Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640206;
	b=ECMkbcjlRg6x0yecfPhLGXH/yo0ZANqb/CFvvOfd5/TffB3ry6K22lAvPeXY209er3yH
	 9gkByVtZ+0XGSZSBygzCLN9pKp/D7ab6Yk+NQenwohPxnC88tXplTOR/ML22nBzODqX4z
	 RuhW76gAmA7VNOitZbnJlf3pIzONh/5/BsoYDIeMRsX50Yi4HBYbU9nIOA3+WSKaR+qxA
	 800DwAJIJnWONSzm78qcCKGzjoIVL7ls5W6W6tCfsKL0jmg69bu5k+s2xSm1gMubkRuLn
	 bELjicNR/s7+RH9a1J4whu7sK1hF+nHTQuhqt2ibXJmQWzeXH0+LrzttEweGdJ+a64A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oRfBKleHhU3BUp7ltu8uNKVynP2g/0Xp3jgnuf+J/Eo=;
	b=sCGp3tifPv0p6BBA6Lj7tbgqsG1xt5ApWNfgli0JDgeR1l6xpdKKFBlEhT6Lk9POspsQ
	 FnxyGJM7XOlh5OJaUxp/0DprvrtlpqbN9dRxdp8LzaXmPZ15aOuoAfFzuGKDk5fgyzTKn
	 KhxKrn4JknDInCNxIlqOu38bavPPHzZOvTfW6hmuuTFjzjK8JZulq0Pxb3QRav7YwyQmi
	 JiL67HfUXWexy7ajC8FOs3HPxfeBFdboyzO/U+AgXiOAOyEFStWyGdkML5vbvptl8T62r
	 iCBupZ4CMbG+4zCGNUduCBXRvWoVUkHxZWwfnzw2sPVW1DE9l7jYRwHv9zQolOsxPLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=a14J+ivW;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843B606A330
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 07:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5843B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=a14J+ivW
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55c5b6584ceso2986681cf.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 23:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640204; x=1795245004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oRfBKleHhU3BUp7ltu8uNKVynP2g/0Xp3jgnuf+J/Eo=;
        b=a14J+ivWzJ/poYORcK4nNkkQRbfvwDjPC+e6K1Ne6hUI5q5zkfi2YJp38SflEWnqEp
         XFZVhHKO/Qe4IhOAtPdb+5xWEBDEf+CRvZFv/Xmb9JJ0i82uZjhBpiUGQztIMksos6gg
         xGxFElFmKZ2suNnoBeSLuTQBsMs5Nf7OrYOFYJvYQISHbw4+R+RO8si0+OvQHKqhkbjY
         KvHL4cxvfPXZ96A4VSjq+VnxjO1TGDXLVYg9VsVWtLyw/p2B3+9BUPO/onXKp3RxqVR1
         qrOcQEof96hwqfQFb6IQQIBoMEN2I3TrYTw361/F+VmC6r7ByoRMkxiD8WOkiQSjh60S
         xLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640204; x=1795245004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oRfBKleHhU3BUp7ltu8uNKVynP2g/0Xp3jgnuf+J/Eo=;
        b=2pWCeU04+jag1kPp4o5Ch56KV2WbV57htvvyQELHwVEIf++RzGpnp6pjLrSLVWVeJu
         OVFjaehpbF0K3kaulKPQdWsdvl3fSgYBDMVPZSEZBB9nSnQFzIYXb5gKbw05lwBjd4BX
         uJgKzVBYEJPbfik1pPD6TixG7x2u0ciG1gnnAL7LlpWgc/kk5BkzVX/fWaYKxrgjRYqJ
         q28yayaikf04F3xUA/nn7z3Ta9qDLdabVUMeZlOIBzU1Z0p/kLbkklqUtWstdyIfPoYn
         5Uy2Is0JlL2tG7UUuVJreTNRtRSCX4dAvwesDEifDJyY1U/XQqggARgcftGI+aJXpRoS
         xQCw==
X-Forwarded-Encrypted: i=1; AL+hErHaNdkEtUE2+QJb+DzpjAs4Q7AIQ4iIzBPBZNDzUvNCOxLjGgNCb4TD+zGJH4fidSixhXZOUOpUfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/uWiTCpKFj84ZP+QcF9p2ZDVuJj87VJnZ26jIwZfZZulI1bi9V
	cwadKnpAAlFpPUt/liO8aM1cpvICDoVFNB4aDAG4huHu6TRVTxZedgs9Nnkeehifeqw=
X-Gm-Gg: AYBFou0NB+cvsM+be90DjRReI8+mn6GbpVqNuY0+HlsM22XGkBQP+eOMnwg251/1fHx
	lT25sm78nbPYuOQdKeNQtuxwDYnC/6KJiNQHCH06ms5Gbb5yxkoTSIF27h81dQGG1qoKHLAXAZZ
	vVmuFOx+ucQi3pzeJgE46QDBh4yayWaF4Q5fbZXuelXStR2SKqCgtJ3ISSumwkLWP6L+PubSq9h
	tX99s+XQsGyHV6ztj8kHzlJfI6eCRI+VuwTmIiTvsU5WPznZ8NKoGXso+XbVpuaomKk2sFWI1R9
	VttADDRaPcxjojrIBcEuJ4oJvN2ZpV/uL/YR9UCyhNhyQYdgpLVPeN0lH2Gix1Z+wXPXwFFs7ni
	LzmPsNdzGQKwFdXZ/oEEl1CTaYA/1Lns+jPl84Gow2gl3aZKXbgxXjn7rODUmQcdiq28Dxnt5cR
	G9K1s8niytfJCNsI0sNZ9XDlfoBc4j5GQzYpyaYdNEAp/9PZsQQaP6MBy61YpE1WF+BVXj6GKE9
	3MO/9+N0ySwIIqBaXbnDw+izzTVsE2wmsbwdGt9diEdWKX2sCb6U8IjxdszhO/W6hYD2yWaODIr
	3BecwRalbaZDyNzTxtwca8WBV0ph/y4vQxC6tWagNuCx65oYyVLC2IBP9cbm2AqmgAeVApJCpfU
	Yug+70T98lK5DdSCg
X-Received: by 2002:a05:620a:8398:b0:93c:ba88:cd65 with SMTP id af79cd13be357-9494b9e13damr803141185a.7.1794640204107;
        Fri, 13 Nov 2026 23:10:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:03 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 00/22] mm: introduce N_MEMORY_COMMON
Date: Sat, 14 Nov 2026 02:09:37 -0500
Message-ID: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
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

This is phase 1 of the Private NUMA node series.

I will send v6 "Private Memory NUMA nodes" (phases 2 and 3) separately
next week for further discussion - but I pulled this out ahead to make
the core filtering mechanism easier to review.

The series is now broken up like so:

Phase 1: Introduce N_MEMORY_COMMON to define "general purpose" (common)
         memory as a concept separate from a node having memory as a
         topological feature (N_MEMORY).

         This phase is a no-op for existing systems, but creates the
         baseline for ensuring private node memory is default opted-out
         of being touched by MM (much like ZONE_DEVICE).


Phase 2: Introduce N_MEMORY_PRIVATE to define memory not part of the
         general purpose pool. With this we can introduce a minimum set
         of KUnit tests for the page allocator to demonstrate the
         isolation mechanism.

         At this point it will be possible for a driver to re-use the
         buddy allocator to make uniform order-N allocations.


Phase 3: Introduce feature bits (COMPACTION, RECLAIM, MEMPOLICY) which
         is the minimum viable set to allow userland to manage a private
         memory node via mbind() and migrate_pages().  

         This enables management of HBM and Coherent GPU memory via
         userland tools (numactl, cpuset) while protecting them from
         incidental allocation (no fallbacks, only explicit placement).

         The memory could even be hotplugged in ZONE_NORMAL and pinned.

Actual cover letter for this portion
====================================

N_MEMORY has two meanings today:
  1) this node has memory
  2) ordinary allocations and MM services can use this node's memory

The two are the same today. They stop being the same once a NUMA node
with memory isn't part of the general allocation pool.

This series adds N_MEMORY_COMMON for the second meaning and converts
the relevant N_MEMORY users accordingly. N_MEMORY continues reporting
memory topology - and some users (cpusets) still utilize it.

At the end of this series, N_MEMORY == N_MEMORY_COMMON, so the series
changes no behavior for existing systems. A later series will add memory
outside N_MEMORY_COMMON without having to audit every N_MEMORY user again.

Rather than add new hooks for page-table and pfn walkers, we consolidate
existing ZONE_DEVICE checks (page/folio_is_zone_device()) into a general
`page/folio_is_common_memory()` check.

The series is laid out as:

  1-3   helper functions to check node states and a folio's
        membership to a common memory node.  N_MEMORY_COMMON itself, and
        the `has_common_memory` sysfs ABI.
  4     zonelists: the fallback lists hold common nodes, and a node's
        __GFP_THISNODE list is built only for a common node
  5-21  N_MEMORY->N_MEMORY_COMMON and zone_device -> common_memory
        conversions. One component per patch.
  22    removal of first_memory_node/next_memory_node, which no longer
        have users after this series.

Each conversion restricts or adjusts:
  - an MM service (reclaim, compaction, KSM, collapse, etc)
  - an allocation target to common memory
  - accounting meant for ordinary allocations from common memory only

has_common_memory lists the same nodes as has_memory until memory
outside N_MEMORY_COMMON exists. It is added now so that userspace, such
as libnuma, can start choosing allocation targets from it, and so that
the meaning is fixed before anything makes the two lists differ.

first/next_memory_node() is replaced by first/next_node_state().

Gregory Price (Meta) (22):
  mm: add node-state-filtered zone and node iterators
  mm: publish and clear node memory states via helpers
  mm: introduce the common-memory node state
  mm/page_alloc: build zonelists from common memory
  mm/mempolicy: keep interleave and tmpfs mount policies on common memory
  mm: base hash distribution on common memory nodes
  mm/memory_hotplug: migrate offlined pages to common memory
  mm/memory-tiers: restrict demotion topology to common memory
  mm/ksm: restrict merging to common memory
  mm/khugepaged: restrict collapse to common memory
  mm/mempolicy: don't NUMA-hint folios outside common memory
  mm/damon: restrict DAMON-native folio operations to common memory
  mm/hugetlb: restrict pool growth to common memory
  mm/page_alloc: count common memory nodes for kswapd recovery
  mm/oom_kill: compare OOM constraints against common memory
  tty/sysrq: use common memory for the manual OOM zonelist
  mm/vmscan: restrict reclaim to common memory
  mm/compaction: restrict compaction to common memory
  mm/migrate: restrict move_pages() destinations to common memory
  PM: hibernate: size the image from common memory
  mm/khugepaged: base the recommended min_free_kbytes on common memory
  nodemask: remove the now-unused first_memory_node/next_memory_node

 Documentation/ABI/stable/sysfs-devices-node | 16 +++++++
 Documentation/mm/physical_memory.rst        |  8 +++-
 drivers/base/node.c                         |  2 +
 drivers/tty/sysrq.c                         |  3 +-
 include/linux/mmzone.h                      | 46 +++++++++++++++++++++
 include/linux/nodemask.h                    | 38 +++++++++++++----
 kernel/power/snapshot.c                     |  7 +++-
 mm/compaction.c                             | 14 +++----
 mm/damon/ops-common.c                       |  7 ++--
 mm/damon/vaddr.c                            |  2 +-
 mm/hugetlb.c                                | 44 +++++++++-----------
 mm/internal.h                               | 18 ++++++++
 mm/khugepaged.c                             | 12 ++++--
 mm/ksm.c                                    |  8 ++--
 mm/memory-tiers.c                           | 23 ++++++-----
 mm/memory_hotplug.c                         | 25 ++++++-----
 mm/mempolicy.c                              | 30 +++++++-------
 mm/migrate.c                                |  2 +-
 mm/mm_init.c                                | 16 ++++---
 mm/oom_kill.c                               |  7 ++--
 mm/page_alloc.c                             | 43 +++++++++++++------
 mm/vmscan.c                                 | 26 ++++++------
 22 files changed, 266 insertions(+), 131 deletions(-)

-- 
2.53.1-Meta

