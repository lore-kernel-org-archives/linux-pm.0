Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB26194C95
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774320679; cv=none; b=hLPL1NNaPiFrGON005SzoNW4CfgxBRFRqQTGFrk1O/6kCmwTqX4QaEtiv0R8vntivyuGRyV7r5m7RNSsgubaSr8Aj9S6yzW6TVsfheINxdiIjHT01Nctl1CWhkD+SNvnAC2IUnTkSbGGrnlVo8dZU4yHG2qS4w49rY/aHs1irTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774320679; c=relaxed/simple;
	bh=NgshECAeOFhf6D13XkREkeIKloMA7OT6JeBAql8Jsjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn8yJB4Tyww2QcB3nVZkJUrEX+TKKKsRSUK9GoOIFj0VImDkcwhHPnSy19FZFwDAz8TmleuBF6dTiPbySCLQKRh0eCqQ6EyG+s44VCsjmV7pziBKg+AvglW05JfbSAQuryIRccDmyTRCNnxQQbYDCtq1AyEFbCPvLNsbod2iStY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 24 Mar 2026 11:51:13 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 24 Mar 2026 11:51:12 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>, Pavel Machek <pavel@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>,
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 0/2] mm/swap, PM: hibernate: fix swapoff race in
 uswsusp by pinning swap device
Message-ID: <acH8IKWyv9gW9YFU@yjaykim-PowerEdge-T330>
References: <20260323160822.1409904-1-youngjun.park@lge.com>
 <20260323154833.045b732a5865b11b5b4e539e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323154833.045b732a5865b11b5b4e539e@linux-foundation.org>

On Mon, Mar 23, 2026 at 03:48:33PM -0700, Andrew Morton wrote:
> On Tue, 24 Mar 2026 01:08:20 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> 
> > Rebased onto mm-new per Andrew's suggestion [1]. The si->flags race
> > flagged by AI review in v7 (between SWP_HIBERNATION and cont_lock in
> > add_swap_count_continuation) and the proposed fixes discussed there
> > (atomic ops for si->flags, or serializing with swap_lock) are all moot
> > on mm-new since Kairui's series removed that code path entirely.
> > kernel/power/ changes are small, so Andrew proposed carrying everything
> > through mm-new.
> > 
> > Rafael, could you ack the PM-side changes?
> 
> Please.
> 
> We'll hit a conflict in linux-next and Mark will tell us and we can
> flag that to Linus when merging into mainline, usual stuff.
> 
> Or we can park this until the next cycle, depends on how serious the
> bug is.  How serious is the bug?

Hi Andrew,

In my opinion, this bug is unlikely to occur and does not appear to be serious. 
It may be better to park this for the next cycle.

I verified the behavior using suspend-utils. Below is a recap of the
reproduction scenarios I mentioned earlier in more detail.

Pre-condition
  - swapon /dev/sdb (intended for hibernation)

Case 1

  Process 1 (test program)        Process 2
  ---------------------------     ----------------
  ioctl(SNAPSHOT_SET_SWAP_AREA)
                                   swapoff /dev/sdb
  ioctl(SNAPSHOT_ALLOC_SWAP_PAGE)

  - SNAPSHOT_ALLOC_SWAP_PAGE fails with -ENOSPC.
  - The race window where swapoff /dev/sdb can occur is extremely
    small, and such an intentional sequence is unlikely in practice.
  - If SNAPSHOT_ALLOC_SWAP_PAGE succeeds, swapoff does not occur.

Case 2

  Process 1 (test program)        Process 2
  ---------------------------     ----------------
  ioctl(SNAPSHOT_SET_SWAP_AREA)
                                   swapoff /dev/sdb
                                   swapon /dev/sdc
  freeze processes
  ioctl(SNAPSHOT_ALLOC_SWAP_PAGE)
  create snapshot image

  - In testing, snapshot boot from /dev/sdb succeeds.
  - The swap block offset may be taken from an unexpected device,
    but I/O to /dev/sdb itself succeeds.
  - Since the actual allocated swap offset is not used for writing
    the snapshot image, there is a theoretical risk of corruption if
    I/O occurs at that offset on /dev/sdb during the window.
    However, Processes are frozen before writing the snapshot image to /dev/sdb.
    Therefore, while the issue is theoretically possible, the
    probability of it occurring in practice appears extremely low.


Best regards,
Youngjun Park
