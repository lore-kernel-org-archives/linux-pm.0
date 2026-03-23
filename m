Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044003E022B
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295768; cv=none; b=Z3CLVzrQLZetTk/3ASB4Fls6XAa1gs42vJc/8UtsLJPyNGEf1EaLjHatfM/L8Uds3E/GwTXrqx/e+R3iC1TPnA7weFlxNUIjOhk1V7AEYRNLhyVmGLrcoT9zZOPr3k+pLMGSJx91/FhabW0j8H/nbATkpFK8Abznz/LuQXxNfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295768; c=relaxed/simple;
	bh=kjRbcw71r11JI072zOdiu0k1SMF7kUPjaV24JWXZRJ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MUPx6OM8z0KLrASf4NB8DXVt0yqxKJwFeX7Dfo61NG9uKO5N2EXHCwsAigvJVLNGKhCm4w7/JcntsFp/xlIFGyyyum6G20uqnUuPcC4QErGZTQo5LLrej/8x/oZhJEETrB+HSlpzJjXCyYvTxsy+hlkI+HMJCtpdEB2hanYHwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pehxsDKj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pehxsDKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4935CC4CEF7;
	Mon, 23 Mar 2026 19:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774295767;
	bh=kjRbcw71r11JI072zOdiu0k1SMF7kUPjaV24JWXZRJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pehxsDKjmHi7i6PM5B4VBIDf4A9tt5hZh0zwhUINTslYkFF675Eel4gwCoVacls/5
	 tDXg2HBIQEVu2VXQz1DSs58tpQFa0lt0AsZu7XSfv6OydiYUvRQv6AoLz8sqyuH1Nb
	 7iotP7DcCrsNS2S9Q18XYwAxNcgNHbuChDvxn4bQ=
Date: Mon, 23 Mar 2026 12:56:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: YoungJun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, chrisl@kernel.org, kasong@tencent.com,
 pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
 linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/2] mm/swap, PM: hibernate: fix swapoff race and
 optimize swap
Message-Id: <20260323125606.820518227d80a30f7e022fe7@linux-foundation.org>
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

> I based this series on v7.0-rc4 per Rafael's request since it
> depends on PM-side changes. I'm not very familiar with how
> cross-subsystem dependencies are typically coordinated -- if
> rebasing onto mm-new is an option, the race goes away and the
> PM-side changes could be picked up separately. Would that be
> a reasonable approach? I'd appreciate any guidance on this.

hm, yes, 2/2 doesn't apply to linux-next.

The easiest approach would be to park this until the next cycle.  How
serious is the bug?

Or Rafael can merge the whole thing, if we can tease some review out of
the swap maintainers (please).
