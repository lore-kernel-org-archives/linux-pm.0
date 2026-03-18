Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA553E0B
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773800203; cv=none; b=WA1JMMyx2GQN6n5GOfj7t+QV8M5aa2HNq3KMA1Va1K1e5O+9uV3ADRYTqnKQzLjFkDDCkRwspkeaWGsawhqTl6Cn4/Tucrl2bKGR3g8mM8lFEMhC9fz0OuyWC+rBeVUoXXd5r/5jULZYH8iDGFXnaSn1bByaguNsfkoLDr38Jss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773800203; c=relaxed/simple;
	bh=+SmgxX/07FQ7gdESSSveArudDF4iuuFYH7QtVNPTCHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRZGCkyoOf5+p/nI567qmxxCp5r90MUtWeceC8UESDdQ4FRtmbwL6/uJ8muisx2KVpMTbPfB7tnSKHVmFx5QMKFm5iAWwLqO9s+onMzYauy6YmwuqubpnzH/Na9qZ0N38rLJl4bW0Ue+6WJVpP1REDpw6dcPh8g4slKQCtzJ7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 18 Mar 2026 11:16:37 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 18 Mar 2026 11:16:36 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rafael@kernel.org, chrisl@kernel.org, kasong@tencent.com,
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] mm/swap, PM: hibernate: fix swapoff race and
 optimize swap
Message-ID: <aboLBJtDUyDedN6M@yjaykim-PowerEdge-T330>
References: <20260317181318.2517015-1-youngjun.park@lge.com>
 <20260317121628.abc7f555ec78963b1d705fd9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317121628.abc7f555ec78963b1d705fd9@linux-foundation.org>

On Tue, Mar 17, 2026 at 12:16:28PM -0700, Andrew Morton wrote:
> On Wed, 18 Mar 2026 03:13:15 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> 
> > Currently, in the uswsusp path, only the swap type value is retrieved at
> > lookup time without holding a reference. If swapoff races after the type
> > is acquired, subsequent slot allocations operate on a stale swap device.
> 
> Has this race been experienced or at least demonstrated?  Or is this
> patchset derived from reading the code?
>
Hello Andrew,

I found and reproduced this race condition 
(using a custom test program for verifying reproducibility):

Pre-condition.
- swapon /dev/sdb (intended for hibernation)

Process 1 (test program)                Process 2
-------------------                     ---------
ioctl(SNAPSHOT_SET_SWAP_AREA)
                                        swapoff /dev/sdb
                                        swapon /dev/sdc
ioctl(SNAPSHOT_ALLOC_SWAP_PAGE)

(The same race applies if the swap device is set up at `open` time
via the `resume` parameter.)

Process 1 operates on a different swap device (or fails if no new swap is
enabled), breaking hibernation. The practical impact is that the subsequent
resume operation will fail. While rare in practice, this can be easily
prevented as shown in the patch.

I initially sent this as an RFC because there were no real-world bug reports.
However, after review and testing, I am submitting it as a formal patch
because it has clear benefits: it prevents a potential bug by enforcing the
code's underlying assumption that `swapoff` must not occur after
`SNAPSHOT_SET_SWAP_AREA` (or after `open`), and it removes unnecessary
reference get/put operations.

I also considered, but rejected, these alternatives:
- Enforcing SNAPSHOT_FREEZE first: Breaks existing user-space behavior
  (e.g., `s2disk` in `suspend-utils` calls `SNAPSHOT_SET_SWAP_AREA`
  before freezing).
- Marking the swap device (e.g., SWP_HIBERNATION) to prevent swapoff:
  Using the existing reference counting mechanism is a cleaner approach.

Best regards,
Youngjun Park
