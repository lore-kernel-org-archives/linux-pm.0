Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110A1A6812
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774056148; cv=none; b=kc86JFFkctuYhVW9oINjHCwEiLwRTDzeXa7ay2fQqIw4dYl7KXDNl+dI4eByz8QbbaU4aGJ7FfXhqYuS5On9fNkaxnhHYHwa3dUzoStUaf1wozJbq0WdMFG1aZE7XDBsHuaaxGMlWAgbk9BihyItZPRq+WWzHgWQCnPuJrK0aMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774056148; c=relaxed/simple;
	bh=HlmLa0kJjSeCy+9OOKWr1Fj+zLQ3H84FVLAmSQm/oJQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I6Re4uusxCocySNCdbTJRpyOApvRmA3BBb/VrhkE8NdQUzy1rJsUC3uMGCJsN7Y6shDs9wZ7t1zxQY9e6b+c7Gzq4WpXJJNXzntOvnsD4hE+QF3FDMS/o3u+vFGOdnizwwekGEZ1qz2BgWZ7YSEVnTuHFPkppMNDmoL1QA3QzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=easAh+v6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="easAh+v6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68BBC2BC9E;
	Sat, 21 Mar 2026 01:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774056148;
	bh=HlmLa0kJjSeCy+9OOKWr1Fj+zLQ3H84FVLAmSQm/oJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=easAh+v6nKEqi/K5Rfgeb+BYrIYk1k7fMvJxHgH7HUBuLhygBVECCC12LJM7dP7Gs
	 fbRON4QcPeWd/gQjabYo3jMc22htOLARdKjjZa9uRtHOLx+HGCt+bQhkaOoDnimkzK
	 um3RhFVH8zZl/vTxnUQ9Kedx2n9BvasF6gwd6Q5E=
Date: Fri, 20 Mar 2026 18:22:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, chrisl@kernel.org, kasong@tencent.com,
 pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
 linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 0/3] mm/swap, PM: hibernate: fix swapoff race and
 optimize swap
Message-Id: <20260320182227.896f9ab62d62961b2caab5f7@linux-foundation.org>
In-Reply-To: <20260320170313.163386-1-youngjun.park@lge.com>
References: <20260320170313.163386-1-youngjun.park@lge.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 02:03:10 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> Currently, in the uswsusp path, only the swap type value is retrieved at
> lookup time without holding a reference. If swapoff races after the type
> is acquired, subsequent slot allocations operate on a stale swap device.
> 
> Additionally, grabbing and releasing the swap device reference on every
> slot allocation is inefficient across the entire hibernation swap path.

AI review has a couple of questions:
	https://sashiko.dev/#/patchset/20260320170313.163386-1-youngjun.park@lge.com
