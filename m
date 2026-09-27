Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DF3C0A17;
	Sun, 27 Sep 2026 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546580; cv=none; b=FzT7tKX8soakuItSuDTaQE47ei/T5oJDr9BnfHP7Iu1EqkTl3bG/JCrOKaUEr/g2hgmJubQzTW54DwgJzC5TmTmj8+N2FrWzqoCDJQd64ltogfkQM9RyQerC/bJy2xryLGwOVyncISGpGIbcAmFBX16IRag+ksJzFxZiP0SiLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546580; c=relaxed/simple;
	bh=ymWUIafOb0l1ELkOQZ8LMzbVx2QMfbBtGcuIQuytGH4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l6kXZdoI2lf/71PNXD7D3bZ2WGnxdhBTimjZLd/PQgTgr3OoJMmi5f+Q2Ek2W7Vr0ThxYrH6ZJAp+SqXngMt6BJNSOiB4hqHppCCxsebuUk2Z8/ofGLYIOMSfC8at9Fflay0Avhuv99SUSNSKWF19NlN4poyA8e3MW12b457svU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FPWknei9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FPWknei9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1CE1F000FF;
	Sun, 27 Sep 2026 22:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790546578;
	bh=5AkcKF60Ps70Cr2izLfZr6VXCM5/oP84FSe9CK86mBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FPWknei98AIXTxcK4IXGTSbYqX8bl0GY/tztGJ4AsjEYwnl/yS9iyESS1hiuL5A4S
	 YMiCQ13I+saVrqRIHyfyoDWNZCC1ApGVSGZFXcoYvuR5b8zXpOzK8M2BC8/W2kb8n1
	 iqkLcrbJzthnJXLI/tz4vJ+pnx4ZjIWwf/yXujJM=
Date: Sun, 27 Sep 2026 15:02:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Potapenko <glider@google.com>, David Hildenbrand
 <david@kernel.org>, Marco Elver <elver@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Len Brown
 <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] hibernation: make safe_copy_page more robust and
 remove debug_pagealloc support
Message-Id: <20260927150257.c9558f807114f2ce9c6675e0@linux-foundation.org>
In-Reply-To: <20260926-hibernation-v2-0-235f69f3ab2a@kernel.org>
References: <20260926-hibernation-v2-0-235f69f3ab2a@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 12:26:29 +0300 "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:

> When hibernation creates a memory image, it uses set_direct_map() APIs to
> temporarily map pages that are marked as not present in the kernel page
> tables.
> 
> Initially, this was intended to support debug_pagealloc along with
> hibernation on x86.
> 
> With the increasing desire to use set_direct_map APIs for hardening
> features and with their inconsistent implementations across architectures,
> using kernel_page_present() + set_direct_map_valid_noflush() to save
> non-present pages in the hibernation image is not very safe, to say the
> least.
> 
> Worse, some combinations of debug features, such as debug_pagealloc and
> PAGE_POISON cause a crash during restore.
> 
> Keeping debug_pagealloc compatible with hibernation requires a complex
> infrastructure for tracking free unmapped pages with a page flag/page type,
> verifying that it is actually a free page that hibernate_map_page() tries
> to remap and making sure there are no stale or failed page table updates.
> With init_on_{alloc,free} and/or PAGE_POISON on top, this also requires the
> ability to map and initialize these free pages on restore.
> 
> This complexity does not seem justified for a somewhat niche debugging
> scenario.
> 
> Instead of a complex fix to support hibernation with debug_pagealloc, make
> sure that copy_data_pages() and its helpers properly handle errors that may
> happen during page table updates, explicitly enable saving of KFENCE pages
> and disallow hibernation when debug_pagealloc is enabled.

Thanks.

> Mike Rapoport (Microsoft) (5):
>       hibernation: make swsusp_page helpers static
>       hibernation: ensure secretmem pages don't reach a snapshot
>       hibernate: handle potential errors in hibernate_{map,unmap}_page()
>       hibernation, KFENCE: explicitly map/unmap KFENCE pages
>       hibernation: make hibernation unavailable when debug_pagealloc is on
> 
>  include/linux/kfence.h   |  29 ++++++++++
>  include/linux/suspend.h  |   6 ---
>  kernel/power/hibernate.c |   6 +++
>  kernel/power/snapshot.c  | 137 +++++++++++++++++++++++++----------------------
>  mm/kfence/core.c         |  52 +++++++++++++++++-
>  5 files changed, 159 insertions(+), 71 deletions(-)

I'm not sure how to route this.  Rafael, wdyt?
