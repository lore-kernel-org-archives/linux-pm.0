Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472982;
	b=Zp5jEL4TJuhKoci/WjFNzp5oFGZ0uEdDV+u9wCKaFEJTXE2iznUcb67PM3482T9OdA/q
	 NYl8LSc6ro+wmAh7zEASJUTmh2O6WLQEtreB7fo1/vsuqA4Vp7OqY0kZ2CJEJLq5J468r
	 mWvDHbSX6MeAzhYiBAaHRcJKOwY3lJ6pR+CQIrkeHJR0sCZaA9pvWrBGyz8maGQF/BJDR
	 9OxDr+aPxt7wBM350zG5Rr8l2wI53KgZH+fatZfXpMsxgJmxerzF5OJDnfOawU4Rp9na4
	 xtcnUgiuAJ52i+fgONKsUfO71AHqqcIUnLiO/xaQ7UzoaoM6savuiyuH7lWzHdP6Vww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472982;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zGhwVIex9mWZUtab8cF8zHqvZnsJQ3/IQ05w/An8UOU=;
	b=QwE7CYWwceu7NsUrRyGR3Ow82cyZ4VH7Iws0mYrX7VHbUJnqWUKUQjRnYautfBuKjuz0
	 rBOcjkapVOVlVCE6u4kN20zS30G28OVg1pQsVd4vEv2TKaX/KykIoq/SER9tCaT2qqaY/
	 0XFtbQthjRQLf8cHmdfSSshmwbr/30Tga2bzfbMGb6sN9TKQ5LodwU4sfdUV7gC+0JYM+
	 SbVFdTpkg4mouP98iNxsNTDOQcSMMxIM8ew0yZ4T0+B9i4oVsRFXWPxN9ygS08mrXErXX
	 EVlm9aw4Ra5IIkPZelA7wZOl40W6VA8me2zlNuwA5SUTo/rsnoE+Rzz60isexaIXITQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wtu0UdRx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF5606A8B6;
	Thu, 12 Nov 2026 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wtu0UdRx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472982;
	b=dNqxjlSQxBy/trP0/JGaXf/FN8Q5l5GgebG4DoEOKhplus+Vc3v5yZkSxend9ruuMoXv
	 T8rp9Bw+7fSLfP7F15/11S+Vpsz3mmQg5zV/fMhrEnDXVWNG+ijVklLt8ZQlTFt7u/42G
	 Qx6vflqVa1ePkG2WhtBeslLedVV7rFfetP7MSvtDHfHNQCAGmKFNND/BVbn8FJtybtoWo
	 YGXiouNzsZX4Rns49M3pqVDXUGgVwGk1jmEbXEImHp/rrdw91Y/cjl/pbLPcEdY48+Cig
	 f24sGBPWvJVUv6vUsYUEvxFb5n8Y+V1tZaBVDGIdgcjvsqGQkq1ijnfXs89zp64LKrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472982;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zGhwVIex9mWZUtab8cF8zHqvZnsJQ3/IQ05w/An8UOU=;
	b=L5oXJ4t17lG43npSDaTO1CZLaWu34hTZDUV0QJcgrVyTQ0JHZ0RAlEfw1p/ofYvNKkoF
	 HxiypYS6rqB35IfGPhwAl/ZQKFqzZJv0dFgCROgM42yjvryyYpRV6iVNNhhypbCLVWutJ
	 ktXNK6AhHfTvePJMnjNv2Z9f8VUuPD7SbIQovjqgwlIz+3xMjqxXCpkyd+gQQHgD1GtU1
	 krYU6Bu7dhbmSvIJFS7KlyNboEjgURYRFP66CnFKCIOl4A5+oxttQBZmTAkEZd4Tn3Z0G
	 nw61QwmrL3TPxyZKVYBXpkzfutqzfl/UCdy8hFRmCEcnJCYQmK2tQP6kiNLCZnwWLVQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 72F431F00A05;
	Thu, 12 Nov 2026 08:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472982;
	bh=zGhwVIex9mWZUtab8cF8zHqvZnsJQ3/IQ05w/An8UOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wtu0UdRxfIuduBCaVEKZuapLjaMM4ymWoe7Vdl97BfMxCkWldSubQX6KDqyNsAvhg
	 xp6fwY5ifJjFP6PZnwVkwDRR4R9aHtbTuwzplQLLEtI9EbwzdExcTE6BPgJ9fJTCGl
	 yvrJcnEEHU2+0RZlbA7lRMAFJjqtf3ixeG3nPQka+a1wFa411un8SOAcBXG6PCp+HR
	 TXbvphGMd8GYaoHpvOdyGC/eFpk1GtPMauLkr4Z/WEa7guvFd950Lp5RvX/xJLtgqH
	 yyzJ3wtYtvQ3F0CbzwD3emPimQ5/g+xp04CKEas4KNzA0OT0MKZqLYmdi4s0RU/Ron
	 iP34AdRK3cOEA==
Date: Thu, 12 Nov 2026 09:42:54 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Johan
 Hovold <johan@kernel.org>, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, Dominik
 Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 0/3] PM: runtime: add new runtime metrics and summary
Message-ID: <20261112094254.00003d3d@kernel.org>
In-Reply-To: <CAG2KctqMYi+a-NZm7bAHTSc5Ch8=RAaEhY6CAZkvCnGW2VOeEA@mail.gmail.com>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
	<CAG2KctpRRDMXR8wG40PeohsTyAdoNC=+4Nc9pHGQc1fmw9AXeQ@mail.gmail.com>
	<20261111101152.00007785@kernel.org>
	<CAG2KctqMYi+a-NZm7bAHTSc5Ch8=RAaEhY6CAZkvCnGW2VOeEA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 08:56:30 -0800
Samuel Wu <wusamuel@google.com> wrote:

...

> > The main things this is useful for are detecting power "thrashing" and
> > tuning autosuspend delays. Currently, sysfs only shows the total time
> > a device spent in active and suspended mode; from an energy standpoint,
> > a continuous 50 second suspension is different from a device cycling
> > 1000 times for 50ms each (these transitions can be pretty power-hungry).
> > This could help userspace utilities like PowerTOP to more effectively
> > determine what is causing an increased power consumption.
> >
> > From the kernel dev standpoint - this is genuinely useful when testing
> > runtime PM functions in new drivers (for example in the IIO subsystem we
> > deal with a lot of runtime PM stuff).  
> 
> Makes sense, there is value in this info.
> 
> > > And is there a reason the stats need to be surfaced in both sysfs and debugfs?  
> >
> > sysfs definitely, as you should definitely be able to access this info
> > per-device (and this is the way userspace tools would get this info).  
> 
> Is there already a userspace user of these sysfs nodes?

No, there isn't.

> Adding these five sysfs nodes would easily create 10k+ new sysfs nodes
> (a typical Android device can easily have 2k+ devices). Most userspace
> apps would iterate through every possible node, meaning this would be
> an inconsistent snapshot across the 10k+ syscalls, in addition to
> being inefficient.
> 
> These sysfs nodes would have a boot time impact, a non-negligible
> memory impact, and constitute a permanent ABI.

Fair enough, I didn't account for this. 2k+ devices is a lot!

> > The debugfs summary is however pretty elegant IMO and useful. I'm sure a lot
> > of people investigating odd device behaviour would like this (plus there
> > are overviews like this in the kernel already - clk_summary for example).  
> 
> The debugfs addition makes more sense IMO. It filters with
> pm_runtime_enabled() instead of presenting every device, and the
> spinlock at least keeps the view of each device consistent. It's also
> more flexible without the ABI guarantee.

Okay, I've no problem with dropping the sysfs patch. The debugfs summary is
machine-readable for any userspace tools to parse.

-- 
Kind regards,
Joshua Crofts
