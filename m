Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4CA37CD3E;
	Mon, 24 Aug 2026 05:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549042; cv=none; b=bo4Hg3GHW6LqzoyCDU91v0kUHCjw+ceCbTJRhVqgA995GC5XVb1n57npmjAwsZY/vhDvIaIJVSLBF1+CupgSbpZFzqnzicZajDYFGhhB5IQeCQ1ALsGzs1EgD75ZhvctlfUoiwUigCWJzOa0f8o34S38a3ULYmuLEWviHBi3tPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549042; c=relaxed/simple;
	bh=eF1HU99iJ8gBveC5b6UroHiZ4cw6Kut4yCqF41kAKwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQLdpDeCbWmuo/m3DdT97WA/w9yBT0XxoOoHEEIbRkW3GgXOQKfJ5EDnvbfBiFvhF7huwMkeY1jI59aD5rpmkjkWWvk6RpTzO6sAWOvAyDA9slCOoZl4rZlC/GQ6h9Bkw6O6h+6u/PQGceTGS2gQ+4DqLK99DI5c5FXWeft9IJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqa96Hzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqa96Hzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E8D1F000E9;
	Mon, 24 Aug 2026 05:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787549041;
	bh=TXtqia5PdtG1NivZEBOtuHaZM1kAw7WMvcIXrQl52d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Oqa96Hzd8wzh+t0td2T9pUNaG2Rt20l0dx4wGw2Z62p3o5MLwBabr3cFUUKkMIDI9
	 qOy7jgnvCWkce10+hj8024pvkv6qoXSzWrLggr2wdYGudIDAxua23t3JlD7cEK4yhV
	 +5kXCDxi6KS6WH6yNXaU0XFYPy/yGtCS7zk+gXqhQx5kpUiHU3lt5cBzvATih4IwaL
	 f9Mu5tvuLJvxG6DZEB2DPe6Me3filgX/oxpga8WSuFQoApECdC3G+RSbsHSV/Z0g0D
	 WIH5nnmP1tmdaq0+T9dUv0EgniuKr1W4zMN85PZ6EvQPqN+7B+oZlt3j/RKgC2R9/f
	 CoVUt4/tfLyfw==
Date: Mon, 24 Aug 2026 05:23:57 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Mayank Rungta <mrungta@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Douglas Anderson <dianders@chromium.org>, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: sleep: Add DPM watchdog to late/early/noirq phases
Message-ID: <aovVbT61s-DseUB7@google.com>
References: <20260821170648.3097673-1-mrungta@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821170648.3097673-1-mrungta@google.com>

On Fri, Aug 21, 2026 at 10:06:48AM -0700, Mayank Rungta wrote:
> Extend the DPM watchdog to wrap device_suspend_late, device_suspend_noirq,
> device_resume_early, and device_resume_noirq callbacks. If a driver hangs
> during these transitions, the watchdog will fire and dump a stack trace
> to help identify the offending driver.
> 
> To prevent false-positive timeouts, the watchdog is set only after
> waiting for subordinate (during suspend) and superior (during resume)
> devices.
> 
> Signed-off-by: Mayank Rungta <mrungta@google.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
