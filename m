Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25B2820A9
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115963; cv=none; b=hkeaSq/Rwktfbkwt+7MAWIK+FH8DHfd5FVwf4vuLeEsysyvf+GjgJHnUdyWq2MkttVXRSrQPwRpf07QXCHOjTIGH6qxTGfeyfus4naONhyAL1JueLpHlqwJI95wWliPaTkHInw1pY2dk+VRd8C9Kds6D8jbIYwR8Wap6Eufo7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115963; c=relaxed/simple;
	bh=84p3Slq6ofODyReBGmrKpMl97d43ab6ti5Ey5r2+UOk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PILf5v+RuJfqnvxWXeOL4F+2HtyRGFyMzPU4i5YGqd8nx3xsZUfTrhpPE0+vNRB5yUDX04xXmgIwCrygztMgRL4K0He5W476IFt8cjHP458VFTQI2nOcccLRfemXXBR5atKu1QkD09qzvS7C250nQqPFIZpLXJw67b7SZQCfJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=chMULYR9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="chMULYR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1DBC19421;
	Sat, 21 Mar 2026 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774115962;
	bh=84p3Slq6ofODyReBGmrKpMl97d43ab6ti5Ey5r2+UOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=chMULYR9rnO2u2qWOsi9FI3oVkk7OZ/5ggenjdK2tuT712lAwlWmJgnG3Fp9csfkT
	 NEGx9xzqA1r8Ja5rZ7n6+IzyEbRz9+s1K71t+rJEgezfWRmGbrc10MNuGREnDC087Q
	 nSL/fbNWNn/OFm77WuB9cVNGDeHVDJZkLqbkqJn4=
Date: Sat, 21 Mar 2026 10:59:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, chrisl@kernel.org, kasong@tencent.com,
 pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
 linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/2] mm/swap, PM: hibernate: fix swapoff race and
 optimize swap
Message-Id: <20260321105921.19388b7acbc0f8d6036e29a7@linux-foundation.org>
In-Reply-To: <20260321103309.439265-1-youngjun.park@lge.com>
References: <20260321103309.439265-1-youngjun.park@lge.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 19:33:07 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> Apologies for the frequent revisions. Hopefully this version is close to final.
> 
> Currently, in the uswsusp path, only the swap type value is retrieved at
> lookup time without holding a reference. If swapoff races after the type
> is acquired, subsequent slot allocations operate on a stale swap device.
> 
> Additionally, grabbing and releasing the swap device reference on every
> slot allocation is inefficient across the entire hibernation swap path.
> 
> This patch series addresses these issues:
> - Patch 1: Fixes the swapoff race in uswsusp by pinning the swap device
>   from the point it is looked up until the session completes.
> - Patch 2: Removes the overhead of per-slot reference counting in alloc/free
>   paths and cleans up the redundant SWP_WRITEOK check.
> 
> ...
>
> v6 -> v7:
>  - Dropped Patch 3 (pm_restore_gfp_mask fix) from series as it has
>    no dependency on Patches 1-2. Will be sent separately.
>    (Rafael J. Wysocki feedback)
>  - Andrew Morton's AI review 

Well.  Roman, Chris, Google and others.  I'm just a messenger ;)

> findings applied only to Patch 3;
>    Patches 1-2 are unchanged. (no problem on AI's review)

Seems that it changed its mind!

	https://sashiko.dev/#/patchset/20260321103309.439265-1-youngjun.park@lge.com
