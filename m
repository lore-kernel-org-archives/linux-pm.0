Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055C3E6396
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183517; cv=none; b=pgKGA7ArkFj/Z67W2CTVUHkZKaE2p7bLCjS5ITYbqOCmnRCmSDRDXvfs/HhFDqwyYZ5FObj6mikeyhgXQnTzLWSHJavik3qaeMTxzdShsK/QpMfhNu8B09DW1gFQbM7oH//26iAdOFOxZjEFgAOdHZY+F1aomXjfOmv15Vx2uXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183517; c=relaxed/simple;
	bh=108jA9l62jkTmLRyhDlFFkBzQIQcu60S1NHHpB0HwJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOLbStXtx/rE37b2Ge0QxE/5u2Gih7u+RESiU8cpnVC6FJzCpxz2AyM1zkU+4EsabXFQaCM9NpzxuGg3N4k4EII3dsuABd+09115UkwO2qcgfyUSLigV9GmgP5vA+3kJxRhSEFbLS1CGLM/2K6GWZKDa2TvYfBdq7ifX/+O1d5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 15 Apr 2026 01:18:31 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 15 Apr 2026 01:18:31 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: preserve uswsusp swap pin across
 SNAPSHOT_SET_SWAP_AREA re-set failures
Message-ID: <ad5o1z1hSzLtUxMo@yjaykim-PowerEdge-T330>
References: <20260414143200.1267932-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414143200.1267932-1-charsyam@gmail.com>

On Tue, Apr 14, 2026 at 11:32:00PM +0900, DaeMyung Kang wrote:

Hi Daemyung :)

> Commit 5b2b0c6e4577 ("mm/swap, PM: hibernate: fix swapoff
> race in uswsusp by pinning swap device") introduced
> SWP_HIBERNATION so that the swap device chosen via
> /dev/snapshot is held against swapoff for the entire uswsusp
> session. The intended invariant is: from the first successful
> SNAPSHOT_SET_SWAP_AREA until the /dev/snapshot fd is closed,
> exactly one swap device is pinned.
>
> snapshot_set_swap_area() breaks that invariant on the re-set
> path:
>
>       unpin_hibernation_swap_type(data->swap);
>       data->swap = pin_hibernation_swap_type(swdev, offset);
>       if (data->swap < 0)
>               return swdev ? -ENODEV : -EINVAL;
>
> The unpin happens unconditionally before the new pin is
> attempted. If the new pin fails (e.g. user space supplies an
> offset/device that is not an active swap area), the session
> continues with no swap device pinned, reopening exactly the
> swapoff race the original commit was meant to close. A
> subsequent swapoff on the previously selected device now
> succeeds where it would have been blocked with EBUSY.

Hmm.. This was actually intentional.  The API semantic
is that a second SNAPSHOT_SET_SWAP_AREA abandons the
previous pin.  If the new pin fails, the ioctl returns
an error and userspace is responsible for aborting the
session -- proceeding without a pinned device makes no
sense.

The only benefit of preserving the old pin on failure
would be protecting against userspace that ignores the
error.  But even in that case, the session has no valid
swap target, so the hibernation image write itself
would fail before swapoff becomes a concern.  I think
this is an edge case rather than a bug.

IOW, Looking at your test case, I think this part is
userspace's responsibility:

>       ret = snapshot_set_swap_area(fd, bogus_dev, 0);
>       if (!ret) {
>               fprintf(stderr,
>                       "step6: bogus SNAPSHOT_SET_SWAP_AREA unexpectedly succeeded\n");
>               close(fd);
>               return 2;
>       }

The ioctl has already returned an error here.  Userspace
should close /dev/snapshot and stop, not continue and
expect the old pin to still be in place.

(BTW, the tests are well written and easy to follow.
Thanks!)

For this patch to have real value, there should be
something that concretely breaks after the swapoff
succeeds.  But since the session has no valid swap
target at that point, is there any actual broken
behavior that follows?

>       if (!buggy) {
>               if (swapoff(swap_path_2) < 0) {
>                       fprintf(stderr,
>                               "step8: swapoff(%s) after close failed: %s\n",
>                               swap_path_2, strerror(errno));
>                       return 2;
>               }
>               printf("step8: swapoff succeeded after closing /dev/snapshot\n");
>       }

If you still see concrete value, I would be happy to
take this as an improvement (without Fixes: and
Cc: stable) -- see my suggestion below for a lighter
approach.

> Reordering pin/unpin in the caller cannot fix this
> cleanly. Each of pin_hibernation_swap_type() /
> unpin_hibernation_swap_type() acquires swap_lock
> independently, so any two-call sequence leaves a window
> in which swapoff can observe an inconsistent pin state.
> The same-area re-set case (type == old_type) also cannot
> be expressed with pin+unpin without either toggling the
> bit (racy) or returning EBUSY (a false error).
>
> Introduce repin_hibernation_swap_type(), which performs
> the transition atomically under a single swap_lock
> acquisition:

I understand the intent.  If you still see enough value
in preserving the pin on failure, I would suggest a
lighter approach -- see below.

> -     unpin_hibernation_swap_type(data->swap);
> -
> -     data->swap = pin_hibernation_swap_type(swdev, offset);
> -     if (data->swap < 0)
> +     swap = repin_hibernation_swap_type(data->swap, swdev,
> +                                        offset);
> +     if (swap < 0)
>               return swdev ? -ENODEV : -EINVAL;
> +     data->swap = swap;

Would it be simpler to use find_hibernation_swap_type()
to look up the new type first, and if it differs from
data->swap, call pin_hibernation_swap_type() on the new
one?  If pin succeeds, unpin the old one.  If it returns
-EBUSY, just keep the existing pin.

If swapoff sneaks in between find and pin, pin will
simply fail -- I don't think the kernel needs to
guarantee atomicity for that window.  This does acquire
swap_lock multiple times, but SNAPSHOT_SET_SWAP_AREA is
an extremely rare operation, so the extra lock
round-trips should be negligible.

Reusing the existing helpers seems preferable to adding
a new function with this much code for a single call
site.

How do you think?

Thanks again!
Youngjun Park
