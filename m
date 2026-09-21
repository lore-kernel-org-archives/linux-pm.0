Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7A37DE87;
	Mon, 21 Sep 2026 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018356; cv=none; b=Zm+pFHfCPQiRRQAo9Gtt5pGh7VnStySlQEAqd0yjg6k2odQicrLplDaXMq4UtaArsaB88Y6g6L099W1kd3UvjsiBcR0+Hxo0FjhhWd3471cxkiM53I3P5i5AAsOwgV6OShHhSoRf8gmJ7dVRKZ9CA1YpnZwGZA0tSBksGtLCNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018356; c=relaxed/simple;
	bh=Mfe/YPoBIvIFMdg6DNCNmmzwv6iEWWgKp3lCu04jjJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aatevnxy0NyijQnNmXYSu0CtLrgL/vlEqul/OZgadWOn/xmtdUoEkOrHFhTnG8IF3t9j9t3G8XqbJg1B2zOSRHYKc9zdKB+2PSvRY1cULz1JVc3enr0x7ikHEZbHVxM6r4V8QYZstkkBvj/xt840rhpVXtEiWprO3y8/hWEUlbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzmWiG3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzmWiG3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016851F0089A;
	Mon, 21 Sep 2026 19:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018354;
	bh=rme2RDXE0Q3i+onTTofchJv1V8gBFZbfhEbeCgEfq9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SzmWiG3SmFH7M3s3lLVcUKfmQo3Ww+onl5w9ohFXBzj+EVEfdROsbKrtKeLddN+Xr
	 FEyA7Nbm05zot5WbqU+ttloINInr8EpDxaXM3Aj3HJpzrLtc8J0CPsp2Zd9PM9BTBw
	 tcVqPxcqyM+URfyV+gZujTkx5dZSvfbF4xOupkcJlZ7qJBjC5eI/tjQCU/8u9Rw2BW
	 XibVsi/JFiiIkSgUznBTVRMACnoAUnvSu1abhdN+9qjBfSxcsZsOZ/UrbtbiH5tf4i
	 Avg75rJ288nc/ltEPmRIg/bYvZxjlqPKl5iUp2eX8opMg2Zs5L5x6KEcxRYaBhvlS9
	 RLClV/Am+Cpow==
Message-ID: <7feb56df-15d4-4821-99c7-b8c96ce66b81@kernel.org>
Date: Mon, 21 Sep 2026 14:19:11 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: hibernate: Freeze kernel threads after image
 preallocation
Content-Language: en-US
To: flo@geekplace.eu, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Matthew Leach <matthew.leach@collabora.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260920-fix-hibernation-v1-1-f9940c2d7d7f@geekplace.eu>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260920-fix-hibernation-v1-1-f9940c2d7d7f@geekplace.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/26 09:35, Florian Schmaus via B4 Relay wrote:
> From: Florian Schmaus <flo@geekplace.eu>
> 
> Commit 783c81098445 ("PM: hibernate: call preallocate_image() after freeze
> prepare") moved hibernate_preallocate_memory() after dpm_prepare() so
> that device drivers have the opportunity to release pinned/unswappable
> memory during their ->prepare() callback before memory is preallocated
> for the snapshot image.
> 
> However, that commit also placed hibernate_preallocate_memory() after
> freeze_kernel_threads(). While it was assumed during review that swap
> I/O submitted via submit_bio() is synchronous and would not depend on
> frozen kernel threads, this does not hold in practice. Calling
> hibernate_preallocate_memory() with kernel threads frozen leads to
> intermittent deadlocks during hibernation.
> 
> Inside hibernate_preallocate_memory(), shrink_all_memory() is invoked with
> .may_writepage = 1 and .may_swap = 1 to aggressively reclaim and swap out
> pages. Any writeback or swap I/O that relies on freezable kernel threads,
> block device helpers, or WQ_FREEZABLE workqueues (such as those in storage
> drivers, device mapper, or filesystems) deadlocks waiting on tasks that
> are stuck in the refrigerator.
> 
> Fix this by reordering hibernation_snapshot():
> 1. Call dpm_prepare(PMSG_FREEZE) first, allowing device drivers to release
>     pinned resources while kernel threads are still active.
> 2. Call hibernate_preallocate_memory() second, performing page reclaim and
>     swapout while storage layers, workqueues, and kernel threads are alive.
> 3. Call freeze_kernel_threads() third, only after all memory preallocation
>     and swap I/O have completed.
> 
> Additionally, restore the call to swsusp_free() in the cleanup path so
> that preallocated image memory is properly freed if freeze_kernel_threads()
> fails or if TEST_FREEZER is enabled.
> 
> Fixes: 783c81098445 ("PM: hibernate: call preallocate_image() after freeze prepare")
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
> During the review of commit 783c81098445 ("PM: hibernate: call
> preallocate_image() after freeze prepare") [1], concerns were raised
> regarding whether memory reclaim and swap I/O could deadlock if kernel
> threads were already frozen.
> 
> At the time, it was thought that pageout to swap would not depend on
> frozen threads. However, on Linux 7.2, I ran into reliable issues with
> suspend-to-disk hanging during hibernation. Reordering the sequence so
> that kernel threads are frozen after image preallocation (as done in
> this patch) fixes the issue for me.
> 
> This patch restores the ordering where kernel threads are frozen only after
> memory preallocation and swap I/O have completed, while keeping the
> benefit of calling dpm_prepare() beforehand so drivers can release pinned
> pages.
> 
> [1] https://patch.msgid.link/20260403-hibernation-fixes-v3-1-31bc9fa3ba2d@collabora.com
> ---
>   kernel/power/hibernate.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index d2479c69d71a..c13f68ab7f6e 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -408,9 +408,18 @@ int hibernation_snapshot(int platform_mode)
>   	if (error)
>   		goto Close;
>   
> +	error = dpm_prepare(PMSG_FREEZE);
> +	if (error)
> +		goto Complete;
> +
> +	/* Preallocate image memory before freezing kernel threads and shutting down devices. */
> +	error = hibernate_preallocate_memory();
> +	if (error)
> +		goto Complete;
> +
>   	error = freeze_kernel_threads();
>   	if (error)
> -		goto Close;
> +		goto Cleanup;
>   
>   	if (hibernation_test(TEST_FREEZER)) {
>   
> @@ -422,15 +431,6 @@ int hibernation_snapshot(int platform_mode)
>   		goto Thaw;
>   	}
>   
> -	error = dpm_prepare(PMSG_FREEZE);
> -	if (error)
> -		goto Complete;
> -
> -	/* Preallocate image memory before shutting down devices. */
> -	error = hibernate_preallocate_memory();
> -	if (error)
> -		goto Complete;
> -
>   	console_suspend_all();
>   	pm_restrict_gfp_mask();
>   
> @@ -464,10 +464,12 @@ int hibernation_snapshot(int platform_mode)
>   	platform_end(platform_mode);
>   	return error;
>   
> - Complete:
> -	dpm_complete(PMSG_RECOVER);
>    Thaw:
>   	thaw_kernel_threads();
> + Cleanup:
> +	swsusp_free();
> + Complete:
> +	dpm_complete(PMSG_RECOVER);
>   	goto Close;
>   }
>   
> 
> ---
> base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
> change-id: 20260915-fix-hibernation-aad94ce17506
> 
> Best regards,
> --
> Florian Schmaus <flo@geekplace.eu>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
