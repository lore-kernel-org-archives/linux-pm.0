Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B722612;
	Sat, 22 Mar 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742632257; cv=none; b=S7aS5WGHO6vdX5LOfn8No9RsC9vceBuHcxMPA0nqbJveI8TxvbHgA1ZAlo7aJXIavccUodAR+d+gQvW6Cz3ZKo0qRWEYe4jkKDSnBxVkx3oPZlVrblkjj9KgdXaoaouov7Dxarc5+Wbl6A15H4YbjMcOw/mH1NZL/6I8706YdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742632257; c=relaxed/simple;
	bh=nO5gRXhCFzWvpqBR2WfAC740T7D3lMOTI8a61colaU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaIY9jJkp1qD4hkibS6w6lqaMOdDFKCTkNvyjWl3TJw8inIggMdlXmDAbvAEL74rO4yHlnrVSMUV1gkXFpkaU4koSiT4czNHETU+E+g96o14WVlM6SwhdIFkeNScDFxB4wizQ8vmiHPZnw6L7Ydlkk9aZKwvfCKLTyWh1pHpOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BY1cyu9p; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BY1cyu9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742632253;
	bh=nO5gRXhCFzWvpqBR2WfAC740T7D3lMOTI8a61colaU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BY1cyu9p5KO3LP7+lI36AAKBl/4PCYddCb/bzifcInvlLt4zst54kTfw7f+FvKLmR
	 Cm+hp0DDX0o1kpWeQX37Djd0pvFZkyfwRJn7JKdT+n9A5Rh8Sbudntd7xkotNgZHjH
	 qyLWUjHKdHTwGXBW9xyfewqgolTM+kD34ex4ACi4=
Date: Sat, 22 Mar 2025 09:30:53 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Derek J Clark <derekjohn.clark@gmail.com>, 
	Kevin Greenberg <kdgreenberg234@protonmail.com>, Joshua Tam <csinaction@pm.me>, 
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
	sre@kernel.org, ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com, 
	mario.limonciello@amd.com
Subject: Re: [PATCH v7 00/14] hwmon: (oxpsensors) Add devices, features, fix
 ABI and move to platform/x86
Message-ID: <cb4dcc99-1192-47a3-a671-64ef28cfdce5@t-8ch.de>
References: <20250319181044.392235-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319181044.392235-1-lkml@antheas.dev>

On 2025-03-19 19:10:27+0100, Antheas Kapenekakis wrote:
> This four part series updates the oxpsensors module to bring it in line
> with its Windows OneXPlayer counterpart. First, it adds support for all
> 2024, 2025 OneXPlayer handhelds and their special variants. Then, it moves
> the module to platform/x86 to allow for including more EC features.

> [ snip ]

I had some nitpicks for v6. Not necessarily worth a respin.
In any case for the whole series:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
