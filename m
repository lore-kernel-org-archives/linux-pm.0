Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1035AC11
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 05:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106136; cv=pass; b=Fuu1GNgP72mh+BYVYq6+kMfkKV9wWRLz4S9Dv4pxDEKZE5s+ZczyBVH1s/n8S38jGQQ5m4ncxI1g0TsN1Ud0k9hH4vwQva61/0cEgRpT0LzQOvBtxcJyVt90OetLAJjCvfvnatqgOo1xw+K8U4vGlY+YQWlGvfTgWgllxHpZNA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106136; c=relaxed/simple;
	bh=AVkOkRTtOGmOYW1/Vsdb3Eh/mWt3+SXrUWDOYCxFRJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qD950rrioX0AyaU7hEkLLDasZkxlcJCdeXiUdfGOC495+RgfQZpl7qoknavveGQOC+7kmbF90GgiEPJelyFkHfWFf0Aof7kJevKX9bAD8WDNA6tfE6niaiSMchTIkWuF0CdIpydYt9CS1YWydeceqUGZ9XPVZ/LY1SBbB+EXID4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeYv79Ts; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeYv79Ts"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c85822059d8so2849892a12.1
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 22:28:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782106132; cv=none;
        d=google.com; s=arc-20240605;
        b=Yk8WZSq9seRGmm2by4UDDSXNNri7tUQQnv48qj0iXerY9ECJmlTiuFBZIWBSO8UvvE
         H6qOsq62eqLlBBOIOXTYusqDyO9la/exD35IUu7PslyNG/YxODjTTgJFtiuJH4N5Vo7d
         BYj9ps/zu+LIBsdTZreM1INMwY3TETXXlvzR1jCDTUd7PGRGJNmug/pZgEciTJ/Qk9UJ
         way+1CZH8O92OIm/KWbba1Nby3g/WUIN0wroU+YhgC+J8Nm0kD6LmncvGhYuACgyi93V
         vIl9BaCcwITHKJqj5GRuxRaT3vDwui2XVBRdbxZqtaCEQVgbi0Cvfqt/pwKbxzpkf5T8
         0wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5KNOLAwZyaBThMY1NJgMdUSjBoVwiFJr4CThsL0B6VY=;
        fh=i+xIO1X157kkZRhriKL5LmQjkykIkikHsZOGM95EohQ=;
        b=QKK5XQHv5zj2HgJJb2w5GYlMA5ccr3IbXRh/ezyalhvfJ4t4NuXchHNPObWaLdL6RR
         29NQimUv5eiMyWe5BVlz1B0AV83sn5IzlLCHTYeOweI8G5CymUaIyN2zaAScecadDG2Z
         n7dUQy87A2vQE4lVj9CPNYdKHQG294HFtuYB0GCy4K5CYYSoaIZXik6MA0AiiI9OU9+l
         FhheL2sHxb20o0f9V7WohAQd0s3RGoCvA+IMCNuQ95LrJmggMQVZF8kIjJNvcWRe/gJW
         uR/r1DMVL/3gKoAGIFzRBjpUvrY3oSxVlZ0yeb3jUcxFM2cs77nKaUZdQnHouv2+wnjO
         a/Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106132; x=1782710932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KNOLAwZyaBThMY1NJgMdUSjBoVwiFJr4CThsL0B6VY=;
        b=oeYv79Tsn+qrKAgZY7z2kKZ/F5iVQ7fxdrCLTzHZMdKcAhFNnU/LhmEKscP5KSm7rU
         VIY/N5GiLu1Gxs8T3o/5LwrAOssUtzJ3QLjTVpXH19TUjCQ01tZi0sehg82Hl97Ac/Kv
         l5+iX4sQv17oWCxI0DvogCG3NASCrY6gdlfDpH6xCj5CABo8ImN+a6xSe9DzkQA+Q+z3
         dJ1GksqpeYLNEcvCmiY0ExyB/5dq/RhVYE//ZeykE4wohNBEVooOBO+nPKkZa98zsRPw
         lj+Vr/Sd9wRzhQN5O6C1m7GwL8Jn6m8Rw6lb86x83ZuZNL6JDfQ7bXiZwUU2b7j3O+2e
         lndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106132; x=1782710932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KNOLAwZyaBThMY1NJgMdUSjBoVwiFJr4CThsL0B6VY=;
        b=G0DjwkTK/eXHpokcuOZY55RiHL/WoSBHUS7PJ9gD1jyIgoa9ld+HhOSr7jZTbzJw7G
         7+5mf54komcxicaUm3vwL9MfJEeNiD4sNUc438HXy8Zo4C2+YHlzgtlIxBdvPT3AZifk
         lMhZ7OSK+94am1b8CMa3RqmbfIyQThbwyS+6F1CZzC/a9yj6NJB87A+fq1LqTq1akZcO
         IJeakYybvkkRTvsTcD8gEZw3bvMfGVQQWrKKAnfdvCEx36u8pSRtbWO3sTAsYfrk0eGf
         dDvKb/xjYyzRiHa8tmKdhgw9uij1NXJZD4P1ZppmK64IthfhCterYivPyaa+JYtwhHoQ
         fNvg==
X-Forwarded-Encrypted: i=1; AFNElJ8zQnzJ++sYTjkbxZAWiJv7lKZCCLVnSrriFMkEDwa/2omS6nqmRQB4JZSdYbymp6L/LxX9mSOhyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNZQVraEh1cNCrZka+W8WL4llvI2UZ90WupiFMfTW/I79IrD5
	5gjU/XSpsKLi2twV09rC2+QeIOlPotWA1g7JcmVaJenhcrfuH4N1N0StVEWK3MugFp7W4o7yDkK
	1fCHkfkFpNeYg+LYdFhMrMoEZjkJJ8cA=
X-Gm-Gg: AfdE7clRfQjfJsMHpUapmj8rCILupjAaXyqLL/24RMaqo9u73PkqDhakNmNJw7LVjGv
	as0JfJ37GkrivNBehEpigwIKKScctRBUbCjE4m0h3X10QYwyMughq1CxkozS3H5yZU7pT3ElPie
	YaDb82tyBDMtBE2Hku//yQVxuVVC1Kwec3zvNzQIckqM38nMapXswZ5dcMNdUNxKgqPWmOgEvY7
	wYI1zXl+BeXF1xAQ25Lg9X7SnHZn+7MpQpNfPC+2PpW1p/hu8kX/cUHwQUS53ab7gyg/Ytl49j+
	vdW6TDVgBOVxrr33T3I3PYByHVQiPo/K1GErCG1qyun8l5Rbgx3i3VD9Lz0wOVfoFE7AemX0sVp
	XkcQt58ZyxSpNfMwtRvuDgE6G
X-Received: by 2002:a05:6a21:9102:b0:3b7:b328:4c8b with SMTP id
 adf61e73a8af0-3bb3241d5bemr15602261637.19.1782106131632; Sun, 21 Jun 2026
 22:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
In-Reply-To: <20260622040533.29824-1-kaitao.cheng@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Jun 2026 22:28:40 -0700
X-Gm-Features: AVVi8CdydPWkgrsWeukABG1V_xsA12RL457Ae_ewOX27KaNNGTwhs0J8OHNbSBg
Message-ID: <CAADnVQJmPWFT01b7DuLdtafv=8FyB84GYHNZ8zSTck+9Aw0JpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Prepare mutable list iterators to cache cursor state
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Paul Moore <paul@paul-moore.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Howells <dhowells@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Randy Dunlap <rdunlap@infradead.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Philipp Stanner <phasta@kernel.org>, linux-block@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-ntfs-dev@lists.sourceforge.net, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, io-uring <io-uring@vger.kernel.org>, 
	audit@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, kexec@lists.infradead.org, 
	live-patching@vger.kernel.org, linux-modules@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, rcu@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-mm <linux-mm@kvack.org>, virtualization@lists.linux.dev, damon@lists.linux.dev, 
	clang-built-linux <llvm@lists.linux.dev>, chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 9:06=E2=80=AFPM Kaitao Cheng <kaitao.cheng@linux.de=
v> wrote:
>
> From: chengkaitao <chengkaitao@kylinos.cn>
>
> The list_for_each*_safe() helpers are used when the loop body may remove
> the current entry.  Their current interface, however, forces every caller
> to define a temporary cursor outside the macro and pass it in, even when
> the caller never uses that cursor directly.  For most call sites this
> extra cursor is just boilerplate required by the macro implementation.
>
> This is awkward because the saved next pointer is an internal detail of
> the iteration.  Callers that only remove or move the current entry do not
> need to spell it out.
>
> The _safe() suffix has also caused confusion.  Christian Koenig pointed
> out that the name is easy to read as a thread-safe variant, especially
> for beginners, even though it only means that the iterator keeps enough
> state to tolerate removal of the current entry.  He suggested _mutable()
> as a clearer description of what the loop permits.
>
> Add *_mutable() iterator variants for list, hlist and llist.  The new
> helpers are variadic and support both forms.  In the common case, the
> caller omits the temporary cursor and the macro creates a unique internal
> cursor with typeof(pos) and __UNIQUE_ID().  If a loop really needs an
> explicit temporary cursor, the caller can still pass it and the helper
> keeps the existing *_safe() behaviour.
>
> For example, a call site may use the shorter form:
>
>   list_for_each_entry_mutable(pos, head, member)
>
> or keep the explicit temporary cursor form:
>
>   list_for_each_entry_mutable(pos, tmp, head, member)
>
> The existing *_safe() helpers remain available for compatibility.  This
> series only converts users in mm, block, kernel, init and io_uring.  If
> this approach looks acceptable, the remaining users can be converted in
> follow-up series.
>
> Changes in v3 (Christian K=C3=B6nig, Andy Shevchenko):
> - Convert safe list walks to mutable iterators
>
> Changes in v2 (Muchun Song, Andy Shevchenko):
> - Drop the list_for_each_entry_mutable*() helpers from v1 and make the
>   cursor change directly in the existing list_for_each_entry*() helpers.
> - Open-code special list walks that rely on updating the loop cursor in
>   the body, preserving their existing traversal semantics.
>
> Link to v2:
> https://lore.kernel.org/all/20260609061347.93688-1-kaitao.cheng@linux.dev=
/
>
> Link to v1:
> https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev=
/
>
> Kaitao Cheng (7):
>   list: Add mutable iterator variants
>   llist: Add mutable iterator variants
>   mm: Use mutable list iterators
>   block: Use mutable list iterators
>   kernel: Use mutable list iterators
>   initramfs: Use mutable list iterator
>   io_uring: Use mutable list iterators
>
>  block/bfq-iosched.c                 |  17 +-
>  block/blk-cgroup.c                  |  12 +-
>  block/blk-flush.c                   |   4 +-
>  block/blk-iocost.c                  |  18 +-
>  block/blk-mq.c                      |   8 +-
>  block/blk-throttle.c                |   4 +-
>  block/kyber-iosched.c               |   4 +-
>  block/partitions/ldm.c              |   8 +-
>  block/sed-opal.c                    |   4 +-
>  include/linux/list.h                | 269 ++++++++++++++++++++++++----
>  include/linux/llist.h               |  81 +++++++--
>  init/initramfs.c                    |   5 +-
>  io_uring/cancel.c                   |   6 +-
>  io_uring/poll.c                     |   3 +-
>  io_uring/rw.c                       |   4 +-
>  io_uring/timeout.c                  |   8 +-
>  io_uring/uring_cmd.c                |   3 +-
>  kernel/audit_tree.c                 |   4 +-
>  kernel/audit_watch.c                |  16 +-
>  kernel/auditfilter.c                |   4 +-
>  kernel/auditsc.c                    |   4 +-
>  kernel/bpf/arena.c                  |  10 +-
>  kernel/bpf/arraymap.c               |   8 +-
>  kernel/bpf/bpf_local_storage.c      |   3 +-
>  kernel/bpf/bpf_lru_list.c           |  25 ++-
>  kernel/bpf/btf.c                    |  18 +-
>  kernel/bpf/cgroup.c                 |   7 +-
>  kernel/bpf/cpumap.c                 |   4 +-
>  kernel/bpf/devmap.c                 |  10 +-
>  kernel/bpf/helpers.c                |   8 +-
>  kernel/bpf/local_storage.c          |   4 +-
>  kernel/bpf/memalloc.c               |  16 +-
>  kernel/bpf/offload.c                |   8 +-
>  kernel/bpf/states.c                 |   4 +-
>  kernel/bpf/stream.c                 |   4 +-
>  kernel/bpf/verifier.c               |   6 +-
>  kernel/cgroup/cgroup-v1.c           |   4 +-
>  kernel/cgroup/cgroup.c              |  54 +++---
>  kernel/cgroup/dmem.c                |  12 +-
>  kernel/cgroup/rdma.c                |   8 +-
>  kernel/events/core.c                |  44 +++--
>  kernel/events/uprobes.c             |  12 +-
>  kernel/exit.c                       |   8 +-
>  kernel/fail_function.c              |   4 +-
>  kernel/gcov/clang.c                 |   4 +-
>  kernel/irq_work.c                   |   4 +-
>  kernel/kexec_core.c                 |   4 +-
>  kernel/kprobes.c                    |  16 +-
>  kernel/livepatch/core.c             |   4 +-
>  kernel/livepatch/core.h             |   4 +-
>  kernel/liveupdate/kho_block.c       |   4 +-
>  kernel/liveupdate/luo_flb.c         |   4 +-
>  kernel/locking/rwsem.c              |   2 +-
>  kernel/locking/test-ww_mutex.c      |   2 +-
>  kernel/module/main.c                |  11 +-
>  kernel/padata.c                     |   4 +-
>  kernel/power/snapshot.c             |   8 +-
>  kernel/power/wakelock.c             |   4 +-
>  kernel/printk/printk.c              |  11 +-
>  kernel/ptrace.c                     |   4 +-
>  kernel/rcu/rcutorture.c             |   3 +-
>  kernel/rcu/tasks.h                  |   9 +-
>  kernel/rcu/tree.c                   |   6 +-
>  kernel/resource.c                   |   4 +-
>  kernel/sched/core.c                 |   4 +-
>  kernel/sched/ext.c                  |  22 +--
>  kernel/sched/fair.c                 |  28 +--
>  kernel/sched/topology.c             |   4 +-
>  kernel/sched/wait.c                 |   4 +-
>  kernel/seccomp.c                    |   4 +-
>  kernel/signal.c                     |  11 +-
>  kernel/smp.c                        |   4 +-
>  kernel/taskstats.c                  |   8 +-
>  kernel/time/clockevents.c           |   6 +-
>  kernel/time/clocksource.c           |   4 +-
>  kernel/time/posix-cpu-timers.c      |   4 +-
>  kernel/time/posix-timers.c          |   3 +-
>  kernel/torture.c                    |   3 +-
>  kernel/trace/bpf_trace.c            |   4 +-
>  kernel/trace/ftrace.c               |  49 +++--
>  kernel/trace/ring_buffer.c          |  25 ++-
>  kernel/trace/trace.c                |  12 +-
>  kernel/trace/trace_dynevent.c       |   6 +-
>  kernel/trace/trace_dynevent.h       |   5 +-
>  kernel/trace/trace_events.c         |  35 ++--
>  kernel/trace/trace_events_filter.c  |   4 +-
>  kernel/trace/trace_events_hist.c    |   8 +-
>  kernel/trace/trace_events_trigger.c |  17 +-
>  kernel/trace/trace_events_user.c    |  16 +-
>  kernel/trace/trace_stat.c           |   4 +-
>  kernel/user-return-notifier.c       |   3 +-
>  kernel/workqueue.c                  |  16 +-
>  mm/backing-dev.c                    |   8 +-
>  mm/balloon.c                        |   8 +-
>  mm/cma.c                            |   4 +-
>  mm/compaction.c                     |   4 +-
>  mm/damon/core.c                     |   4 +-
>  mm/damon/sysfs-schemes.c            |   4 +-
>  mm/dmapool.c                        |   4 +-
>  mm/huge_memory.c                    |   8 +-
>  mm/hugetlb.c                        |  56 +++---
>  mm/hugetlb_vmemmap.c                |  16 +-
>  mm/khugepaged.c                     |  14 +-
>  mm/kmemleak.c                       |   7 +-
>  mm/ksm.c                            |  25 +--
>  mm/list_lru.c                       |   4 +-
>  mm/memcontrol-v1.c                  |   8 +-
>  mm/memory-failure.c                 |  12 +-
>  mm/memory-tiers.c                   |   4 +-
>  mm/migrate.c                        |  23 ++-
>  mm/mmu_notifier.c                   |   9 +-
>  mm/page_alloc.c                     |   8 +-
>  mm/page_reporting.c                 |   2 +-
>  mm/percpu.c                         |  11 +-
>  mm/pgtable-generic.c                |   4 +-
>  mm/rmap.c                           |  10 +-
>  mm/shmem.c                          |   9 +-
>  mm/slab_common.c                    |  14 +-
>  mm/slub.c                           |  33 ++--
>  mm/swapfile.c                       |   4 +-
>  mm/userfaultfd.c                    |  12 +-
>  mm/vmalloc.c                        |  24 +--
>  mm/vmscan.c                         |   7 +-
>  mm/zsmalloc.c                       |   4 +-
>  124 files changed, 875 insertions(+), 681 deletions(-)

Not sure what you were thinking, but this diff stat
is not landable.

pw-bot: cr
