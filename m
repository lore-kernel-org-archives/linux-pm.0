Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1B50276;
	Thu, 26 Mar 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530601; cv=none; b=HHxk2TA1f5B1v9sFcJnCbWIDbckZ0gHeozQIdZX0cCwyhJBeNGZQL2rlbRGxd7M6vNDFMuNN20iORBooagogw55XMpkWauhKB7ZAMZTgTiUpePJ3dV3UoZn0hVCQwYLZ3zrAkhaf+xVjoJ66TWT96VAozbp3d7gNOobgj/YuzYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530601; c=relaxed/simple;
	bh=KKziiV0nVCF6spf7tHtvmQufCwFhtFREGY7iDXHOqvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6EovhiAdxehj8plfnXhdl7sINg/CR8GD0BXqYvRUf7ettBOUMtBue8zCJoxA7ABf4NhvWKG3T31iizlfQ7m4ODslLG70yGT8mq0r8QUJYNg6YWrXhc6535zwYTnG0JwjupzZ+4ug29Ia8JVkI4eEnRDoQIicchb7PblmOP2nTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKp8vOgV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKp8vOgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41BAC116C6;
	Thu, 26 Mar 2026 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774530601;
	bh=KKziiV0nVCF6spf7tHtvmQufCwFhtFREGY7iDXHOqvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qKp8vOgVGeWdYuScDBw38nLrEyTEsal46k7gr6NO0wu75JLkx+LkXxkw5zJ2x/mWr
	 PcUV/XwaAIVONJP9jMjVicR/gGer+NCg4mBVAuxqlvs6o7M9RAwkkNTNJZMdbyTGKI
	 190Yr5568MmodqkQnvWiGpnxoziFAaUi9fY5oHfLtsBNZFuyXuFeqkek1PVyCm4Xbv
	 5bRqYzyiCdTC4DYrmV68aKr99LPjQa0IM6q1o9KZowV/SjOuVPe4EnOXyIudeurksA
	 eE9BpiOXWjG6pkyW+wMKuzyPc/HbPo/AhlqLLjnOWXfT/7YkEurQO1uOExObg4xztl
	 /xNcAmdy771rA==
Message-ID: <8b982cba-be6f-46ad-9a97-87be30280696@kernel.org>
Date: Thu, 26 Mar 2026 08:09:59 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: hibernate: call preallocate_image after freeze
 prepare
To: Matthew Leach <matthew.leach@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 YoungJun Park <youngjun.park@lge.com>, kernel@collabora.com
References: <20260326-hibernation-fixes-v2-1-f6707d82b7b9@collabora.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260326-hibernation-fixes-v2-1-f6707d82b7b9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/26/26 06:36, Matthew Leach wrote:
> [You don't often get email from matthew.leach@collabora.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Certain drivers release resources (pinned pages, etc.) into system
> memory during the prepare freeze PM op, making them swappable.
> Currently, hibernate_preallocate_memory is called before prepare freeze,
> so those drivers have no opportunity to release resources first. If a
> driver is holding a large amount of unswappable system RAM, this can
> cause hibernate_preallocate_memory to fail.
> 
> Move the call to hibernate_preallocate_memory after prepare freeze.
> According to the documentation for the prepare callback, devices should
> be left in a usable state, so storage drivers should still be able to
> service I/O requests. This allows drivers to release unswappable
> resources prior to preallocation, so they can be swapped out through
> hibernate_preallocate_memory's reclaim path. Also remove
> shrink_shmem_memory since hibernate_preallocate_memory will have
> reclaimed enough memory for the hibernation image.
> 
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> Changes in v2:
> - Removed shrink_shmem_memory.
> - Fixed missing call to dpm_prepare in error path.
> - Link to v1: https://lore.kernel.org/r/20260321-hibernation-fixes-v1-1-5fe9637b6ff9@collabora.com
> ---
>   kernel/power/hibernate.c | 46 +++++++++-------------------------------------
>   1 file changed, 9 insertions(+), 37 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index af8d07bafe02..39b0a8ea4024 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -392,23 +392,6 @@ static int create_image(int platform_mode)
>          return error;
>   }
> 
> -static void shrink_shmem_memory(void)
> -{
> -       struct sysinfo info;
> -       unsigned long nr_shmem_pages, nr_freed_pages;
> -
> -       si_meminfo(&info);
> -       nr_shmem_pages = info.sharedram; /* current page count used for shmem */
> -       /*
> -        * The intent is to reclaim all shmem pages. Though shrink_all_memory() can
> -        * only reclaim about half of them, it's enough for creating the hibernation
> -        * image.
> -        */
> -       nr_freed_pages = shrink_all_memory(nr_shmem_pages);
> -       pr_debug("requested to reclaim %lu shmem pages, actually freed %lu pages\n",
> -                       nr_shmem_pages, nr_freed_pages);
> -}
> -
>   /**
>    * hibernation_snapshot - Quiesce devices and create a hibernation image.
>    * @platform_mode: If set, use platform driver to prepare for the transition.
> @@ -425,14 +408,9 @@ int hibernation_snapshot(int platform_mode)
>          if (error)
>                  goto Close;
> 
> -       /* Preallocate image memory before shutting down devices. */
> -       error = hibernate_preallocate_memory();
> -       if (error)
> -               goto Close;
> -
>          error = freeze_kernel_threads();
>          if (error)
> -               goto Cleanup;
> +               goto Close;
> 
>          if (hibernation_test(TEST_FREEZER)) {
> 
> @@ -441,23 +419,17 @@ int hibernation_snapshot(int platform_mode)
>                   * successful freezer test.
>                   */
>                  freezer_test_done = true;
> -               goto Thaw;
> +               goto ThawKThreads;
>          }
> 
>          error = dpm_prepare(PMSG_FREEZE);
> -       if (error) {
> -               dpm_complete(PMSG_RECOVER);
> +       if (error)
>                  goto Thaw;
> -       }
> 
> -       /*
> -        * Device drivers may move lots of data to shmem in dpm_prepare(). The shmem
> -        * pages will use lots of system memory, causing hibernation image creation
> -        * fail due to insufficient free memory.
> -        * This call is to force flush the shmem pages to swap disk and reclaim
> -        * the system memory so that image creation can succeed.
> -        */
> -       shrink_shmem_memory();
> +       /* Preallocate image memory before shutting down devices. */
> +       error = hibernate_preallocate_memory();
> +       if (error)
> +               goto Thaw;
> 
>          console_suspend_all();
>          pm_restrict_gfp_mask();
> @@ -493,9 +465,9 @@ int hibernation_snapshot(int platform_mode)
>          return error;
> 
>    Thaw:
> +       dpm_complete(PMSG_RECOVER);
> + ThawKThreads:
>          thaw_kernel_threads();
> - Cleanup:
> -       swsusp_free();
>          goto Close;
>   }
> 
> 
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260321-hibernation-fixes-69bca2ee5b65
> 
> Best regards,
> --
> Matt
> 

