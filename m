Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5A2857EA;
	Wed,  1 Apr 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034692; cv=none; b=rIIKv8wQvTwNPmgc3xpurQVQ+scdb7OfBzOlz54suIHlWKFnkXGTEtlnzuyqNH38kdH5hZ6fz/PiDpqT8ZhSv2WJVPF66Q1Lu+M5iXgG0AO0YoTg5qrlsvg14Frr6Yk0UM5EnuDXaDYxyqpyQ7sutViMYa1HCz+0fpRD3OmIL8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034692; c=relaxed/simple;
	bh=w7MTOz/QakdpD3/7WWwcxLbnWHxPxiLC90EH6FntTfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPuJZH+p7mIwnXA3Vq55qrUoqBkrwaDOMZ0Y3H7lbHn3FUe0ATrZU6pbOqR3LxA4RSQfhbeYRiVZdyXH0uutN4/2e0mZHLj3kjv7yfhUlbPuoPuFhAr8/C60us+dIbkKKQFZcX2eYaDjkJ/3uLY98mxmZZ/0WE9ToqAc2jF8imE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lHHLd6CQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lHHLd6CQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958A7C4CEF7;
	Wed,  1 Apr 2026 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775034692;
	bh=w7MTOz/QakdpD3/7WWwcxLbnWHxPxiLC90EH6FntTfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHHLd6CQQ3yDRpw3pg0btc+UgcMBdI5rl5tOI1Hp4xKdKqDaJDE0Hl93k7UWmaxZA
	 z6uU7g7yERKJV3bDoQYekUYh8jpwT3qTlxw0xLT5ndOBnUNz1K5SFHpfPITBpPF7FT
	 uuCQxx3QhZrZmYMU/wk2wRGlODVtIsnOfn0pQWIo=
Date: Wed, 1 Apr 2026 11:11:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PM: wakeup: Add kfuncs to traverse over
 wakeup_sources
Message-ID: <2026040153-overpass-shanty-71a0@gregkh>
References: <20260331153413.2469218-1-wusamuel@google.com>
 <20260331153413.2469218-2-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331153413.2469218-2-wusamuel@google.com>

On Tue, Mar 31, 2026 at 08:34:10AM -0700, Samuel Wu wrote:
> Iterating through wakeup sources via sysfs or debugfs can be inefficient
> or restricted. Introduce BPF kfuncs to allow high-performance and safe
> in-kernel traversal of the wakeup_sources list.

What exactly is "inefficient"?  I think you might have some numbers in
your 0/2 patch, but putting it in here would be best.

And who is going to be calling these functions, just ebpf scripts?

> The new kfuncs include:
> - bpf_wakeup_sources_get_head() to obtain the list head.
> - bpf_wakeup_sources_read_lock/unlock() to manage the SRCU lock.

Does this mean we can stop exporting wakeup_sources_read_lock() now?

> For verifier safety, the underlying SRCU index is wrapped in an opaque
> 'struct bpf_ws_lock' pointer. This enables the use of KF_ACQUIRE and
> KF_RELEASE flags, allowing the BPF verifier to strictly enforce paired
> lock/unlock cycles and prevent resource leaks.

But it's an index, not a lock.  Is this just a verifier thing?

> 
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  drivers/base/power/power.h  |  7 ++++
>  drivers/base/power/wakeup.c | 72 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 922ed457db19..8823aceeac8b 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -168,3 +168,10 @@ static inline void device_pm_init(struct device *dev)
>  	device_pm_sleep_init(dev);
>  	pm_runtime_init(dev);
>  }
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +struct bpf_ws_lock { };

An empty structure?  This is just an int, so you are casting an int to a
pointer?  Can we make wakeup_sources_read_lock() actually use a
structure instead to make this simpler?

> +struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void);
> +void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock);
> +void *bpf_wakeup_sources_get_head(void);
> +#endif
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index b8e48a023bf0..8eda7d35d9cc 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -1168,11 +1168,79 @@ static const struct file_operations wakeup_sources_stats_fops = {
>  	.release = seq_release_private,
>  };
>  
> -static int __init wakeup_sources_debugfs_init(void)
> +#ifdef CONFIG_BPF_SYSCALL
> +#include <linux/btf.h>
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_wakeup_sources_read_lock - Acquire the SRCU lock for wakeup sources
> + *
> + * The underlying SRCU lock returns an integer index. However, the BPF verifier
> + * requires a pointer (PTR_TO_BTF_ID) to strictly track the state of acquired
> + * resources using KF_ACQUIRE and KF_RELEASE semantics. We use an opaque
> + * structure pointer (struct bpf_ws_lock *) to satisfy the verifier while
> + * safely encoding the integer index within the pointer address itself.
> + *
> + * Return: An opaque pointer encoding the SRCU lock index + 1 (to avoid NULL).
> + */
> +__bpf_kfunc struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void)
> +{
> +	return (struct bpf_ws_lock *)(long)(wakeup_sources_read_lock() + 1);

Why are you incrementing this by 1?

> +}
> +
> +/**
> + * bpf_wakeup_sources_read_unlock - Release the SRCU lock for wakeup sources
> + * @lock: The opaque pointer returned by bpf_wakeup_sources_read_lock()
> + *
> + * The BPF verifier guarantees that @lock is a valid, unreleased pointer from
> + * the acquire function. We decode the pointer back into the integer SRCU index
> + * by subtracting 1 and release the lock.
> + */
> +__bpf_kfunc void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock)
> +{
> +	wakeup_sources_read_unlock((int)(long)lock - 1);

Why decrementing by one?

So it's really an int, but you are casting it to a pointer, incrementing
it by one to make it a "fake" pointer value (i.e. unaligned mess), and
then when unlocking casting the pointer back to an int, and then
decrementing the value?

This feels "odd" :(


> +}
> +
> +/**
> + * bpf_wakeup_sources_get_head - Get the head of the wakeup sources list
> + *
> + * Return: The head of the wakeup sources list.
> + */
> +__bpf_kfunc void *bpf_wakeup_sources_get_head(void)
> +{
> +	return &wakeup_sources;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(wakeup_source_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_wakeup_sources_read_lock, KF_ACQUIRE)
> +BTF_ID_FLAGS(func, bpf_wakeup_sources_read_unlock, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_wakeup_sources_get_head)
> +BTF_KFUNCS_END(wakeup_source_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set wakeup_source_kfunc_set = {
> +	.owner = THIS_MODULE,

This isn't a module.

thanks,

greg k-h
