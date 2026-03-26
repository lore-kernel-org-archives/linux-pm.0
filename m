Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471A382F0C;
	Thu, 26 Mar 2026 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526388; cv=none; b=ibrNJw0/nlBB53jSZc26t/7T05oiAno0mCXzWj4KOz1EIUhG9niDmmtb541iRVnd3TRkaDf8CxDyqQLFuhZ3/oyhNwKyp0yOqRf7Bahc6dQBeak9mm0b2hZhJQMVP/zL/lvrQIzmhcFeftwoi8fbAxMRqwi2ryHDwolgMTZOF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526388; c=relaxed/simple;
	bh=exBUxg/W5ACsTUYcMPI8TgHtkxtmkFsu0fV9m7uVmsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0VjyhjZPin5LWWLtGRagdvucMU0STbJ0aa/Vz7QEIZRx3TyFSiiKtDVRAxjuIT7DElmv4oyC9eVH9/tNToznZdIDyteSmsKQ0FBDW08S7uP2t+gc0plEjjFYPFZ2FDZUiqPE3TW728HdI+LZpmFTCBRuAtVybK2uBHPvnRzUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niYj8y8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niYj8y8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE34C116C6;
	Thu, 26 Mar 2026 11:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774526387;
	bh=exBUxg/W5ACsTUYcMPI8TgHtkxtmkFsu0fV9m7uVmsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=niYj8y8PVhY1Ef/+WtKggxwC6kdgKy2CHLAJsEm5cEUZ7AhLIId7B8OJaTasd01Rs
	 Y1seLS3D/76aadALID6s7e37jcqzWr8QLb9g/Z10sd8llsaDH98JrYPnW6l2WmcaaU
	 qa42cgDxZ0BVVkXk1tvjZHysOmDXwXP4ZgvTxp1BVM6XPpITzOSOKyuk/OoRwxCi3Q
	 Jlay44S3BzauOLHY37m+KiGtU2hlt0fzhIxFgzbuHjnaO1ihIk4em7Vq4Ma71ff5RM
	 P+lk54dy/2Kh8zDk8bbYV1sQqw330vEvTzOerhYzO1fKq3+cHrF2opSrqYMxmFHsIe
	 2ZXhbJCUpnCwA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Samuel Wu <wusamuel@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek
 <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Cc: memxor@gmail.com, Samuel Wu <wusamuel@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PM: wakeup: Add kfuncs to traverse over
 wakeup_sources
In-Reply-To: <20260326112521.2827500-2-wusamuel@google.com>
References: <20260326112521.2827500-1-wusamuel@google.com>
 <20260326112521.2827500-2-wusamuel@google.com>
Date: Thu, 26 Mar 2026 11:59:43 +0000
Message-ID: <m2y0jeg5sg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Wu <wusamuel@google.com> writes:

> Iterating through wakeup sources via sysfs or debugfs can be inefficient
> or restricted. Introduce BPF kfuncs to allow high-performance and safe
> in-kernel traversal of the wakeup_sources list.
>
> The new kfuncs include:
> - bpf_wakeup_sources_get_head() to obtain the list head.
> - bpf_wakeup_sources_read_lock/unlock() to manage the SRCU lock.
>
> For verifier safety, the underlying SRCU index is wrapped in an opaque
> 'struct bpf_ws_lock' pointer. This enables the use of KF_ACQUIRE and
> KF_RELEASE flags, allowing the BPF verifier to strictly enforce paired
> lock/unlock cycles and prevent resource leaks.
>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  drivers/base/power/power.h  |  7 ++++
>  drivers/base/power/wakeup.c | 72 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 77 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 922ed457db19..ced563286ac5 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -168,3 +168,10 @@ static inline void device_pm_init(struct device *dev)
>  	device_pm_sleep_init(dev);
>  	pm_runtime_init(dev);
>  }
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +struct bpf_ws_lock { };
> +struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void);
> +void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock);
> +struct list_head *bpf_wakeup_sources_get_head(void);
> +#endif
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index b8e48a023bf0..27a26a30b6ee 100644
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
> +}
> +
> +/**
> + * bpf_wakeup_sources_get_head - Get the head of the wakeup sources list
> + *
> + * Return: The head of the wakeup sources list.
> + */
> +__bpf_kfunc struct list_head *bpf_wakeup_sources_get_head(void)
> +{
> +	return &wakeup_sources;
> +}

What stops a bpf program from using this kfunc to get the wakeup_sources
pointer and iterating this list without taking the srcu lock? 

An open-coded iterator would solve this by internalizing the lock:
  // Iterator new() acquires SRCU lock
  // Iterator next() returns next wakeup_source
  // Iterator destroy() releases SRCU lock

> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(wakeup_source_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_wakeup_sources_read_lock, KF_ACQUIRE)

I think this needs KF_RET_NULL as well.

> +BTF_ID_FLAGS(func, bpf_wakeup_sources_read_unlock, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_wakeup_sources_get_head)
> +BTF_KFUNCS_END(wakeup_source_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set wakeup_source_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &wakeup_source_kfunc_ids,
> +};
> +
> +static void __init wakeup_sources_bpf_init(void)
> +{
> +	if (register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &wakeup_source_kfunc_set))
> +		pm_pr_dbg("Wakeup: failed to register BTF kfuncs\n");
> +}
> +#else
> +static inline void wakeup_sources_bpf_init(void) {}
> +#endif /* CONFIG_BPF_SYSCALL */
> +
> +static int __init wakeup_sources_init(void)
>  {
>  	debugfs_create_file("wakeup_sources", 0444, NULL, NULL,
>  			    &wakeup_sources_stats_fops);
> +	wakeup_sources_bpf_init();
> +
>  	return 0;
>  }
>  
> -postcore_initcall(wakeup_sources_debugfs_init);
> +postcore_initcall(wakeup_sources_init);
> -- 
> 2.53.0.1018.g2bb0e51243-goog
