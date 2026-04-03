Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371F2DEA9B;
	Fri,  3 Apr 2026 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237095; cv=none; b=iNcFqJbD8Xlbd4xtuGYr8YQW8fYL35hSPIaw1Yra12rmxnZAi5DXGk0JtGMPOeFNewjtIacgMuLEwCRRyVk1dGgq4BXRGcfq0aAcIUPP0yqiiB/Edp8ddvsLQHZ7ENleOWQ8HO+ctBaPctggfI/ZEwmaV+OBw2aibnqPfYw4RJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237095; c=relaxed/simple;
	bh=X9V3cWhzJh1vQDl6644i8DHAMKpQl/WIMY1Y4bFa1nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC6dieI1n+L3mUCJVUySaxdOjdlUoVp9q8cHIcSxkXt+q8ZiMI8OMGmR3RyQdlHzo4ufO88JsUasGRZPHQCTCZsPzUtF8kiD0z7BCpEvB9J/qtO3tXKH78UNk42v7ZgOg9EuIdodS3AhVcKIjdtu/AzUQleJgrqHmuOzPa4G3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CveWQyqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CveWQyqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E163C4CEF7;
	Fri,  3 Apr 2026 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775237094;
	bh=X9V3cWhzJh1vQDl6644i8DHAMKpQl/WIMY1Y4bFa1nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CveWQyqUg7UQwEQi/gZvPrcwEY21UMCgfZD0NFaTm6fLqLUIDUNeCovloJfSS9Hf4
	 6puAi2dTGD+63ZFXGCvDBMvKnAECg50gSrcYMnpztZNFXveRQtMXkLD8WXrB5SHsHK
	 oSlcfQFdZdQn8eBpkOjQ3AT9A5wDVGQriihItACI=
Date: Fri, 3 Apr 2026 19:24:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH] PM / wakeup: Register class wakeup in pure_initcall phase
Message-ID: <2026040354-kitchen-unwoven-c0ce@gregkh>
References: <ac269a91-0ba0-4798-acc6-ec294926bbb0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac269a91-0ba0-4798-acc6-ec294926bbb0@gmail.com>

On Fri, Apr 03, 2026 at 06:09:59PM +0200, Heiner Kallweit wrote:
> Wakeup sources (e.g. autosleep) can be created as early as core_initcall.
> Class wakeup is registered in postcore_initcall only, what results in
> autosleep wakeup source not being shown in sysfs. To fix this,
> register class wakeup in pure_initcall phase already.
> 
> The current behavior doesn't cause any known issue, therefore treat
> the change as an improvement.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/base/power/wakeup_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
> index 308f8bde9..30f0d3d61 100644
> --- a/drivers/base/power/wakeup_stats.c
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -216,4 +216,4 @@ static int __init wakeup_sources_sysfs_init(void)
>  
>  	return PTR_ERR_OR_ZERO(wakeup_class);
>  }
> -postcore_initcall(wakeup_sources_sysfs_init);
> +pure_initcall(wakeup_sources_sysfs_init);
> -- 
> 2.53.0
> 

Wait, if this doesn't need to be change, we shouldn't change it.  Unless
you have a bug that is being fixed here, don't touch init call levels.
They are tricky and will come to bite you if you don't watch out.

thanks,

greg k-h
