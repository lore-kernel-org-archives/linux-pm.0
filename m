Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90282D5950
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306114; cv=none; b=r79AZW2AbTCwBZGiBuxhpMfC3rOcQnBUgSbzbsluL5t0iv4iwMaHFJ/lCPR+JgWBtWZqAOvcaOu1YSES80QMzUbr2l2QHs1r3gNcjm1TtM5nDKFXBW8rLregHBx8y57uYSHOqy8wXhtJUbQVEax8q/0cbEpNEXCpWXbekDEOqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306114; c=relaxed/simple;
	bh=t7d8D7fNG06lhc+Rx8EzDPOazfquULF9R9S4mbUiDBo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dM/UejtAl0Y7d3nK+qBWMfawTnXpxymd/q7wAKLYyH6iUq7VmXB2Ttny5AbdyyUwa72mlU03Q5t0Duv0nZo5aylJENfHRFNrCB5TK6puFercC/o48wTvLa5sctSF4vjg/5ra8A7s0J+r0yPASGq9qkHWbfD0hQ6YkAr35QH08Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PVZItuVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PVZItuVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED89DC4CEF7;
	Mon, 23 Mar 2026 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774306114;
	bh=t7d8D7fNG06lhc+Rx8EzDPOazfquULF9R9S4mbUiDBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PVZItuVDgopVn2J4A2d1E3TrZyGCWXaGaJDCDogcMsKr0eCXZfOrAE2ZF8qmRxrM3
	 Jtl97GMhydx5AhborPlM56e4eHikwzgdDn4iLgD4PvGbiZC2/JvrgHbhRywUrJQgM5
	 BdRbxKw8wfBOE19jR9MwSmTVI4qGgcvqSDYcE244=
Date: Mon, 23 Mar 2026 15:48:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Youngjun Park <youngjun.park@lge.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Pavel Machek <pavel@kernel.org>, Kemeng
 Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 0/2] mm/swap, PM: hibernate: fix swapoff race in
 uswsusp by pinning swap device
Message-Id: <20260323154833.045b732a5865b11b5b4e539e@linux-foundation.org>
In-Reply-To: <20260323160822.1409904-1-youngjun.park@lge.com>
References: <20260323160822.1409904-1-youngjun.park@lge.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 01:08:20 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> Rebased onto mm-new per Andrew's suggestion [1]. The si->flags race
> flagged by AI review in v7 (between SWP_HIBERNATION and cont_lock in
> add_swap_count_continuation) and the proposed fixes discussed there
> (atomic ops for si->flags, or serializing with swap_lock) are all moot
> on mm-new since Kairui's series removed that code path entirely.
> kernel/power/ changes are small, so Andrew proposed carrying everything
> through mm-new.
> 
> Rafael, could you ack the PM-side changes?

Please.

We'll hit a conflict in linux-next and Mark will tell us and we can
flag that to Linus when merging into mainline, usual stuff.

Or we can park this until the next cycle, depends on how serious the
bug is.  How serious is the bug?
