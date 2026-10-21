Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588655;
	b=KLtRK0l3YSvTD3FamCvORdby53QKICWc8/IPnGOASgtMF8rFEMHqNHnWPjvwAMEzB5sG
	 830aUed66UKi0BKylRqmAMiwJotgRxvcwzSWZ2TEG64mFEB9agmDzoCYB/zgLmaLnHX0i
	 JbDlKShCcjoVUQhDG4IoaekOgPl2pB9+jJxH1OcWVLq+0Ej+8XU9gIhKGEyowgn2Ce5Ex
	 3AA3K2mbGtyHKR6eNvlELB0JyVC0TLLQpUU/u9TX702ksumfgL72W6ipVUaUj5rsvuiO+
	 AkXIZ0Rj2vHhVYhTWBn1cs941exdQi+KpdhfUlJaHlbpONj8NIoqdU8JZlguRBHfB7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588655;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=agLknzMu3oVoMvggW9spU09cwqNWOp/fPO88uDYZmIQ=;
	b=MeMnz2Ds3KytR2/+i7Ny6aS6/Vi5b3fQYCdT4QJpG2qNkHwYGoqyrH1dDN+MbUyaX1ap
	 36EsrhZnDK+ZiJinos460HLRCo0eTfgQHx3fVTKUegK2uCkrev5oVlcnD0A3k+XcKcRPF
	 1A0IyRFNo+ma1wcpuuBOWXITDgSG26YCZJfn84wUcP+iwC62H3pcZ/uHvxAvKTsP2xVir
	 QC7u6pPEGuo3r2416IL/n0W2oDoyvmygawBQ6U7OktmXU4sVOvjMSRcFr9o+ccU7vsOl8
	 BFCprUlD93wRF4mUE01nGR8TPW9tz4AmNvVsXI465wIPYwKQLS8uhxT5DRmpgiVJqXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kditkkgl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB8F606A31A;
	Wed, 21 Oct 2026 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kditkkgl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092A21F000C4;
	Wed, 21 Oct 2026 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588654;
	bh=agLknzMu3oVoMvggW9spU09cwqNWOp/fPO88uDYZmIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kditkkgldFDSgRcGHq1o2g4/X5x5ZJBRDKVn1e+kZAFEZ726FdQ5tUV6ed7h9FY1b
	 UW2sY962oLscN57QI2jS1P66CQVxbm+phZJqyhDkIp9q8BINhPZJCs72xo0ZnmhDVq
	 Ba0KL9JtHCa83usVEhqgQUmJj8jwMFjMa8hbtpCIZh5iHa6//DAkO+qu24zQapqgC5
	 7i7huoxlT2LUC0SZS2d1xRekDwGmME+3JtConaEpb2hC0M3ghHhXPOMpjXNQkBqcGz
	 wpa3bDFLOAZsAfMiAWAT0oWm+5OLE7XW8+hDg9Y2yU0RdPTzNn+x+5vvdoa5PUKsyJ
	 lowlIDd/Dt/Sw==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org, 
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Sadrul Chowdhury <sadrul@google.com>
Cc: linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
 linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20261021122543.3547778-1-sadrul@google.com>
References: <20261021122543.3547778-1-sadrul@google.com>
Subject: Re: [PATCH v2 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
Message-Id: <20261021-desaster-oboen-ungemacht-1056e418e106@brauner>
Date: Wed, 21 Oct 2026 15:17:30 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8

On Wed, 21 Oct 2026 12:25:42 +0000, Sadrul Chowdhury wrote:
> During system suspend (freeze_processes) and resume (thaw_processes),
> threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
> try_to_freeze_tasks() executes, it must wake up every sleeping thread
> with a synthetic signal so the thread can schedule, run try_to_freeze(),
> enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes them
> all up simultaneously, only for each thread to re-enter ep_poll(),
> observe no ready I/O events, and call schedule() to go back to sleep.
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
      https://git.kernel.org/vfs/vfs/c/5f2199f2720c
[2/2] fs/select: mark select and poll tasks TASK_FREEZABLE
      https://git.kernel.org/vfs/vfs/c/33ef4cf97c32

