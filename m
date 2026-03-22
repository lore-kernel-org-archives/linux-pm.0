Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF71C8EB
	for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774197039; cv=none; b=pr3fl3c7XdbaXXkZgUwZ7eYppmI47CzoAEYybuMMTuSGa9S4lURWxpZ0n25owCm8RB3Q1mbfr/0AHHLHEqOQpU7fcnM++5vt449EyfJ6Vai+nVHpCeCqx+SuxBx8cVLMaV5J5Vx9jRLeHijakA7+dcGnMHEIdsQ7QCO0BtcwWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774197039; c=relaxed/simple;
	bh=x1lYQ+SKQla8gR4ZqJZh/SOIDQqj99rU27YfBxGWgUI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d5+jWgTbdL7s9CrBxcXSRsFBQlOKzsoeRnLBrNXZLzHvWRtI8r2n7u8/tC0XElUsvR+h+glOD2HWHTLnLa2Z1JrJ04UJySD9gBXBKTwb1IeNUjM+r6RzFjLUZUtNYh7G2tTJoPm2nqXJwqM5gMvgrEjEKYYnVkD0KcsRF7JFZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LeTkX1Br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LeTkX1Br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A872DC19424;
	Sun, 22 Mar 2026 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774197039;
	bh=x1lYQ+SKQla8gR4ZqJZh/SOIDQqj99rU27YfBxGWgUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LeTkX1BrqPg1yDyhaeOy+mhb4CF/doeGewbsiYhfQTm8829HchiWbyuw2uwJXrgP+
	 KrjM+yUz/3IU2zJfB2Fx4gWXiLyvHXKgYPsAlyTO+dBJfgdglst32y9XYR1k1zXjSL
	 EF5RXyoan0yKQWHKlt307EFH7u47lkJ4R63HjziA=
Date: Sun, 22 Mar 2026 09:30:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: YoungJun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, chrisl@kernel.org, kasong@tencent.com,
 pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
 linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/2] mm/swap, PM: hibernate: fix swapoff race and
 optimize swap
Message-Id: <20260322093038.25a7fd51f5d564b85815db7a@linux-foundation.org>
In-Reply-To: <ab/E5SaSAlAKLCwD@yjaykim-PowerEdge-T330>
References: <20260321103309.439265-1-youngjun.park@lge.com>
	<20260321105921.19388b7acbc0f8d6036e29a7@linux-foundation.org>
	<ab/E5SaSAlAKLCwD@yjaykim-PowerEdge-T330>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Mar 2026 19:31:01 +0900 YoungJun Park <youngjun.park@lge.com> wrote:

> 1. Grab cont_lock on the SWP_HIBERNATION set path, or grab
>    swap_lock in add_swap_count_continuation(). This would
>    serialize the race, but adds lock contention on a path
>    that doesn't really need it.
> 
> 2. Convert si->flags to atomic ops. This would be the correct
>    fix, but is quite extensive and better suited as a separate
>    effort.
> 
> However, on mm-new, Kairui's series [1] has removed
> add_swap_count_continuation() and SWP_CONTINUED entirely, so
> this race path no longer exists (verified by code inspection
> and AI review on mm-new).
> 
> [1] https://lore.kernel.org/linux-mm/20260128-swap-table-p3-v2-9-fe0b67ef0215@tencent.com/
> 
> I based this series on v7.0-rc4 per Rafael's request since it
> depends on PM-side changes. I'm not very familiar with how
> cross-subsystem dependencies are typically coordinated -- if
> rebasing onto mm-new is an option, the race goes away and the
> PM-side changes could be picked up separately. Would that be
> a reasonable approach? I'd appreciate any guidance on this.

The kernel/power/ changes are small.  How about we prepare all this
against mm-new and ask Rafael for an ack?

> On a side note -- the AI review is becoming genuinely useful.
> It might be worth having it gate-check patches before they hit
> the mailing list, rather than reviewing after the fact.

Totally agree.  Problem is, these review are expensive and permitting
people to check their work before publishing could be terribly abused -
anyone in the world gets free patch review.  I don't think Google wants
to pay for that!

Hopefully over time, as engineers see the value in this tool they will
persuade their employers to purchase the tokens they need for such
screening work.

