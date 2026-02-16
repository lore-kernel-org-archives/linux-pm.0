Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AE17993;
	Mon, 16 Feb 2026 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278143; cv=none; b=KAgZ35Wg/KH9WCR+Aq7hG2FoITuY7+GafdxRBsuOCfYk319TtQvT0Wbj9878SG6wjAJN04uaLeQLGWuGSIvEhanvPamijcdLSJj2K9zm2uU273xa95vAMWNFykG5A521JNEF/yU7EpUGavfki/67TGRVCyDcsFs5FIBgmXXzf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278143; c=relaxed/simple;
	bh=pxG2R/oIRqyOnH4hhkbbvKCS8frX1294bfA4gX/512w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C8lda91eEoGA7QybK9anDaL8bkxxSqfTfSEhU6KodrzPa3yk1VcWx3XvS5gE+MBNd6SXhmw2K6/YqcI+Ed7bmjqFrDIGLBVtX0dstufFqg8o08bKa0i5QNLovpOzN0uOLkUIpGhaabjg0cfDrh8t2HXgH1OX+r7OIN17quUDTs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YjWMmn0t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YjWMmn0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE26C116C6;
	Mon, 16 Feb 2026 21:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771278143;
	bh=pxG2R/oIRqyOnH4hhkbbvKCS8frX1294bfA4gX/512w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YjWMmn0tghKh9oBaQL6bH1tVOUfoWNCuJsciuQDOZy4C7hfJzpiRkwKDi+UkbDVEC
	 LT8ySi0JC2Sn8ojPtBuQpLLzMNMT6ROmG5/Eqx1Z/mWal5lZVoO7AwTf38Bd9vhfWP
	 4bFqH2fsVN8P8/8E2zPzvBRjlDEM1HJT2gI9HUFo=
Date: Mon, 16 Feb 2026 13:42:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kasong@tencent.com
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>,
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Carsten Grohmann
 <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org, "open list:SUSPEND TO RAM"
 <linux-pm@vger.kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm, swap: speed up hibernation allocation and
 writeout
Message-Id: <20260216134222.5ec936d6503e72348227c58d@linux-foundation.org>
In-Reply-To: <20260216-hibernate-perf-v4-1-1ba9f0bf1ec9@tencent.com>
References: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com>
	<20260216-hibernate-perf-v4-1-1ba9f0bf1ec9@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 22:58:02 +0800 Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> wrote:

> From: Kairui Song <kasong@tencent.com>
> 
> Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
> hibernation has been using the swap slot slow allocation path for
> simplification, which turns out might cause regression for some
> devices because the allocator now rotates clusters too often, leading to
> slower allocation and more random distribution of data.
> 
> Fast allocation is not complex, so implement hibernation support as
> well.
> 
> Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) shows the
> performance is several times better [1]:
> 6.19:               324 seconds
> After this series:  35 seconds

Thanks.

I'll merge only [1/3] at this time, into mm-unstable at this time (I'll
move it to mm-unstable after resyncing mm.git with upstream).

We don't want the other two patches present during testing of this
backportable fix because doing so partially invalidates that testing -
[2/3] and[3/3] might accidentally fix issues which [1/3] added.  It happens,
occasionally.

> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1926,8 +1926,9 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
>  /* Allocate a slot for hibernation */
>  swp_entry_t swap_alloc_hibernation_slot(int type)
>  {
> -	struct swap_info_struct *si = swap_type_to_info(type);
> -	unsigned long offset;
> +	struct swap_info_struct *pcp_si, *si = swap_type_to_info(type);
> +	unsigned long pcp_offset, offset = SWAP_ENTRY_INVALID;
> +	struct swap_cluster_info *ci;
>  	swp_entry_t entry = {0};
>  
>  	if (!si)
> @@ -1937,11 +1938,21 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
>  	if (get_swap_device_info(si)) {
>  		if (si->flags & SWP_WRITEOK) {
>  			/*
> -			 * Grab the local lock to be compliant
> -			 * with swap table allocation.
> +			 * Try the local cluster first if it matches the device. If
> +			 * not, try grab a new cluster and override local cluster.
>  			 */

nanonit, worrying about 80-cols is rather old fashioned but there's no
reason to overflow 80 in a block comment!

>  			local_lock(&percpu_swap_cluster.lock);
> -			offset = cluster_alloc_swap_entry(si, NULL);
> +			pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
> +			pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
> +			if (pcp_si == si && pcp_offset) {
> +				ci = swap_cluster_lock(si, pcp_offset);
> +				if (cluster_is_usable(ci, 0))
> +					offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
> +				else
> +					swap_cluster_unlock(ci);
> +			}
> +			if (!offset)
> +				offset = cluster_alloc_swap_entry(si, NULL);
>  			local_unlock(&percpu_swap_cluster.lock);
>  			if (offset)
>  				entry = swp_entry(si->type, offset);

