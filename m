Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8A27E049
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279410; cv=none; b=FZuDS3UIUin3QNic4gYai1ilLgHpLWi0wtSb7ZXYCYjRY6qV2jUd64yxAfHqaabwC7KEpxYBsU08oNaKswFYvt/jAvNselVALLPdXUNn6vkmKgn6NAFpFbxSBVFOHlNyK5AAnhF9dzDbOMVACxKgNQocbiQ4oikvdpmdIeIEht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279410; c=relaxed/simple;
	bh=MpDFFq3W6pzbYYCnh+7qOqJl5fYOR39VLPRWUOB0O/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW7Z2CIDYBGesULzLMUPhcuVF/1wPFDS22XnTW+o77fKWzAEn0aQeylNii8SyXBW95KXB3ztABResTD9soZrs8gBuIsZ7RmfNH1r2p1JjWPSVEDHmixfyRuUOz1AbdMKh9cAxciU05yo36F6sHuk7pUjcKJHOkk3IuVSy1jKRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 24 Mar 2026 00:23:19 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 24 Mar 2026 00:23:19 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Matthew Leach <matthew.leach@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] PM: hibernate: call preallocate_image after freeze
 prepare
Message-ID: <acFa5+ihROC9/0Va@yjaykim-PowerEdge-T330>
References: <20260321-hibernation-fixes-v1-1-5fe9637b6ff9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321-hibernation-fixes-v1-1-5fe9637b6ff9@collabora.com>

On Sat, Mar 21, 2026 at 08:51:31AM +0000, Matthew Leach wrote:

Hi Matthew,

> +     /* Preallocate image memory before shutting down devices. */
> +     error = hibernate_preallocate_memory();

The shrink_shmem_memory() below is also intended to run after
dpm_prepare(), and the motivation is the same. Since
hibernate_preallocate_memory() already does shrinking internally,
how about pulling out the shrink-related parts and consolidating
them together?

> +     if (error)
> +             goto Thaw;

Don't we need to call dpm_complete(PMSG_RECOVER) in this error path?

>  Thaw:
>       thaw_kernel_threads();
> - Cleanup:
> -     swsusp_free();
>       goto Close;

Thanks,
Youngjun Park
