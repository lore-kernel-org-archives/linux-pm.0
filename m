Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6E3A5E75;
	Fri,  1 May 2026 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641497; cv=none; b=FhT/e5lly02lV7bOMcEcJQiML9j8rMVZl7glQyXuZ0Hk20j5n690FBHFD/yIAUVaMoUmT6mzSUqs9CdTH+Ye3h2vIUX1C2mxB48yO/RPJKpkCQBf+Ybdw4+S3WiYdwOnyTKeKEnL/rc7zWQaVSCWTQgZ3DoJS4gpFi4ck/mPfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641497; c=relaxed/simple;
	bh=D6S/B01MEUfCR6VXKLKqzNn9DH6s9mBnNCGUd1tdrAs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rtmB96EFUzYyTtrmc75giCHBorbtU6pK1IvIVJlRxve2Lwp5Cg2/ChCQVt2Ul6Vs7bau9KGlKg35OI5Srhq5QKWzJodV/Sr/VzMqFvBVKKzOPuwpA6pQmmrI148EiHmUteXvTgnPXY9gVOZ1j1JI8tqfBnY7TFZLCffA8j9fcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QMPiIR6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QMPiIR6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3F6C2BCB9;
	Fri,  1 May 2026 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777641497;
	bh=D6S/B01MEUfCR6VXKLKqzNn9DH6s9mBnNCGUd1tdrAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QMPiIR6IFYeIFuRnabCqi7hl1SNQJee2T2jwmjPUjUU4qK/D64EGc3sypoEv7NihU
	 oa+Nq/+z9Jg4/Oi31Joz1tkvVneMyD4HSXvwLq2Nxfv5HwBeTsmufACSQW4a2C8a0y
	 KoXMS3eChOrGUOVGT5jj1tCi3QQ5vY47LU5+H1ag=
Date: Fri, 1 May 2026 06:18:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Carlier <devnexen@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng
 Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Youngjun Park
 <youngjun.park@lge.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] mm/swap, PM: hibernate: atomically replace hibernation
 pin
Message-Id: <20260501061816.5d59d1eefb0a41a3480a3a11@linux-foundation.org>
In-Reply-To: <20260430195651.287659-1-devnexen@gmail.com>
References: <20260430195651.287659-1-devnexen@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 20:56:51 +0100 David Carlier <devnexen@gmail.com> wrote:

> snapshot_set_swap_area() unpins the previously selected swap device
> and pins the new one in two separate swap_lock critical sections.
> In the gap between them, swapoff() observes SWP_HIBERNATION cleared,
> bypasses the guard, and tears down the device, reopening the race
> the SWP_HIBERNATION pin was meant to close. The window is reachable
> on any SNAPSHOT_SET_SWAP_AREA call after the snapshot device is
> opened for hibernation, and on any retry after the resume path's
> first selection.
> 
> Add repin_hibernation_swap_type(), which looks up the new device,
> clears the old SWP_HIBERNATION flag and sets the new one under a
> single swap_lock acquisition. The same-device case is short-
> circuited so userspace can re-select the same swap area without
> tripping WARN_ON_ONCE and -EBUSY. Switch snapshot_set_swap_area()
> to the new helper.
> 
> A failed lookup now preserves the previous pin instead of dropping
> it, so a bad SNAPSHOT_SET_SWAP_AREA leaves the prior selection
> intact. The open and release paths keep using
> pin_hibernation_swap_type() and unpin_hibernation_swap_type().
> 
> The race was identified during AI-assisted review of the
> SWP_HIBERNATION pinning series.

Thanks, I'll queue this for testing.  Can the swap maintainers please
do a detailed review at some point?
