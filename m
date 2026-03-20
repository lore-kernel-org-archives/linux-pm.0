Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8006F285CB6
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773975033; cv=none; b=AasdaaF8EKq4x35ks63HjzKCWYlvb1ZeZFcAMJ8NQCa0sao+rJK182DQ8/RfGuDbu7M4iVnrD18mUK9NCkEjjNDr2Pej15vJ+pOOxLVXEb91QOg1PznPgBsoyADa4d/+uk/FM9ttyx0A0UTT+E6hieZwlo/aJMas12rVsZTflEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773975033; c=relaxed/simple;
	bh=KVGDEI6eseEcgaCSXUJI4ZcpUMbgOitzgm/GxAkzI5g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LlmA/d2XrSue8eYq0ddohnczZ5AeCsC0gUzNqRnNQLFK3C6OY5Jp/+kjnKRtRvuiU9pgW3tX4U1fGsevEXOiZ0JIw9kiCro6kWCazsIlbZBo/I2E9DIBFz13KdV7gB0HUnR2oG613FD77PlZUUtICI+HJYWrr+D6Da1QU0D6IOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E6TxFQP7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E6TxFQP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEBCC19424;
	Fri, 20 Mar 2026 02:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773975033;
	bh=KVGDEI6eseEcgaCSXUJI4ZcpUMbgOitzgm/GxAkzI5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E6TxFQP7Us5HlcDBS3w1rFIHGHtPxPvGxTJH4au24oBWmb5WdPGXDBC6r4qsM3aD6
	 JpTdit6mPR52t4ng4EzRvC/xyyYMeDQcybaiGVDgWNBSO1+jy8v8jT77fYccRdTWPC
	 62tDCIG/2twQCkcLRvwx/+bO4TsEstd5elYdu1BE=
Date: Thu, 19 Mar 2026 19:50:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, chrisl@kernel.org, kasong@tencent.com,
 pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
 linux-mm@kvack.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Fix swapoff race and cleanup in hibernation swap
 path
Message-Id: <20260319195032.5c3b187d5779cf43cd63fcd0@linux-foundation.org>
In-Reply-To: <20260319142404.3683019-1-youngjun.park@lge.com>
References: <20260319142404.3683019-1-youngjun.park@lge.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 23:24:01 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> Currently, in the uswsusp path, only the swap type value is retrieved at
> lookup time without holding a reference. If swapoff races after the type
> is acquired, subsequent slot allocations operate on a stale swap device.
> 
> Additionally, grabbing and releasing the swap device reference on every
> slot allocation is inefficient across the entire hibernation swap path.

AI review has questions:
	https://sashiko.dev/#/patchset/20260319142404.3683019-1-youngjun.park%40lge.com
