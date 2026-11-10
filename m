Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331753;
	b=I7NRaRWD+zeLrUjKnuagwPWr5lCUM3OV1BeeaLjB8pVpusZIHbkrhQczXVoLBhDxQykM
	 cNPzcm50j9qfoGtvdSt00IO2SWlMA4FtlSzzXgw/WEJV/gt1/9/9s71c634PlxoCpnloi
	 Sjs9vYNyl0cuLkxnjzPddF9VUuBveKmB5a07PZG8a8MvV8lpRvOoG1/PCCvjldjctqCqC
	 CLipOHeVvPKTmuz8++EPgVy8jqd1T//A5HFgHjGqpvNfRRd94l43zSKizT0XL5t1Tauln
	 MwhZn06tiKQNEUv+DXc7Z2LhhrUgggzplcjmWyzIBv7NZInTLqZA6FsvkljpMl/dxBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331753;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c0IxWeg69L18hS0lsnM67W5uLT9pSaPfwx5NH8G9rgk=;
	b=TnOEWvJOMmvSkpdEtAB/rOEK9P/i8LRiW8qKdfBIooEO89HzGefawWk2MtS41iwHpz99
	 D8YECLw0uSuTofj5CVEd2APksmYsFJCFmMsbxKRNnSUEbxuakR1OTTg3naj2FKc9LHf2e
	 gRsa4OgXvBOKzvQfuKVxWVPMF9V5A102g/gOJmE1AJM3aSh57GhU3Ygn2sP0vzfEos/7A
	 QS5PfbbWPfOd5ntGn+DshH2ObGjxiWkcf196G1cyeLIewW/tqDd8qWN0kI/06SZ9+qu8P
	 SNLhoRDxinF6TxzOGXTkRz2+8D96f/z1LWZlTdQ5PfIroQUNKWNl1uL9BmG3DSpZ04w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kYJqn36t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773E606A321;
	Tue, 10 Nov 2026 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kYJqn36t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9AD1F008A2;
	Tue, 10 Nov 2026 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794331753;
	bh=c0IxWeg69L18hS0lsnM67W5uLT9pSaPfwx5NH8G9rgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kYJqn36thE+ClLNX7zWnjsf3M2Yyw6QJy9ksv2t+lUa5TLX9ve5NZRQ1ab6/qLV6l
	 QCQtxooamb7EaD5+WvNF1SaTyXK9wW+lNbg4cFN3VttaRYUA089iTNSpGCCHQ2EwC7
	 JDccXdfi+KPrRapLrMOMfaglvrD4QjXPaPJEwSNs=
Date: Tue, 10 Nov 2026 12:29:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/3] PM: add sysfs attributes for additional
 suspend/resume metrics
Message-ID: <2026111023-padlock-deluge-4173@gregkh>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
 <20261110-pm-runtime-summary-v1-2-12ebf283db78@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-pm-runtime-summary-v1-2-12ebf283db78@kernel.org>

On Tue, Nov 10, 2026 at 11:43:21AM +0100, Joshua Crofts wrote:
> Add sysfs entries for additional suspend/resume statistics. These are
> useful for investigating the behaviour of devices with PM runtime
> enabled.
> 
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-devices-power | 36 ++++++++++++
>  drivers/base/power/sysfs.c                    | 81 +++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
> index 9bf7c8a267c58703a8a097ada1f12271271dbe98..03e5783d737120f98a1c88e5e53f56fe176484e5 100644
> --- a/Documentation/ABI/testing/sysfs-devices-power
> +++ b/Documentation/ABI/testing/sysfs-devices-power
> @@ -284,6 +284,42 @@ Description:
>  		Reports total time that the device has been suspended, in
>  		milliseconds. Used for runtime PM statistics.
>  
> +What:           /sys/devices/.../power/runtime_resume_count
> +Date:           Nov 2026
> +Contact:        Joshua Crofts <crofts@kernel.org>
> +Description:
> +                Reports the total number of times the device entered a resume
> +                state.
> +
> +What:           /sys/devices/.../power/runtime_suspend_count
> +Date:           Nov 2026
> +Contact:        Joshua Crofts <crofts@kernel.org>
> +Description:
> +                Reports the total number of times the device entered a suspended
> +                state.
> +
> +What:           /sys/devices/.../power/runtime_last_suspended_time
> +Date:           Nov 2026
> +Contact:        Joshua Crofts <crofts@kernel.org>
> +Description:
> +                Reports the residency duration of the most recent suspended
> +                state, in milliseconds.
> +
> +What:           /sys/devices/.../power/runtime_min_suspended_time
> +Date:           Nov 2026
> +Contact:        Joshua Crofts <crofts@kernel.org>
> +Description:
> +                Reports the shortest measured duration the device spent in
> +                suspended mode, in milliseconds.
> +
> +What:           /sys/devices/.../power/runtime_max_suspended_time
> +Date:           Nov 2026
> +Contact:        Joshua Crofts <crofts@kernel.org>
> +Description:
> +                Reports the longest measured duration the device spent in
> +                suspended mode, in milliseconds.
> +
> +
>  What:		/sys/devices/.../power/runtime_usage
>  Date:		Apr 2010
>  Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 13b31a3adc77c0fe0a5c42fcf9b863dd5bc43088..7e5a186b33222d448b5caacaddbaf9913fe41a98 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -178,6 +178,82 @@ static ssize_t runtime_status_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(runtime_status);
>  
> +static ssize_t runtime_resume_count_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	u64 count;
> +
> +	spin_lock_irq(&dev->power.lock);
> +	count = dev->power.resume_count;
> +	spin_unlock_irq(&dev->power.lock);

Why is a lock needed at all?  The value isn't going to "smear", it will
change right after the lock anyway.

> +
> +	return sysfs_emit(buf, "%llu\n", count);
> +}
> +static DEVICE_ATTR_RO(runtime_resume_count);
> +
> +static ssize_t runtime_suspend_count_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	u64 count;
> +
> +	spin_lock_irq(&dev->power.lock);
> +	count = dev->power.suspend_count;
> +	spin_unlock_irq(&dev->power.lock);

Same here, why a lock?

And if you need one, why not a guard()?

Same for rest of this patch.

thanks,

greg k-h
