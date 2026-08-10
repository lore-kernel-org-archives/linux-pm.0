Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387F39AD3B;
	Mon, 10 Aug 2026 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397620; cv=none; b=h488RkPew9jq+v4Rqy/F6tkPHgm1LFmMOqERMfoUvS1qqjUNQIcWrrudXQnJ30sYnHKIJQ6WygRXSCJhPamPaR+yoSPuGdHnGo+Cm4v7epxx4Et7hSDvbAZVlrM8++HGGAPt4WSy2AQ5JYiNCDuauhG9n2CXjNP5BW5CX+lYzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397620; c=relaxed/simple;
	bh=RlmjwpzlCbBpemhxJU356QihMtcYLUI1tZuy1+qGDP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVjSPdkkJEfFSMVapmk2aZsTkrTo6HYL9pgGZI+LK9uCYMCAm48oMhhD5IiMyZbkiq+24NfwfN4rt3dNmh6V8na7zXE+siYXLnWsWPPoGgVmOqO3OjinMVlwx6l9vrznbiCAI/ShLwKIbPn+tnlXknCZzALHbck+mA+FLG6mBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UQ9BK6Zf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UQ9BK6Zf"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4A46340E014C;
	Mon, 10 Aug 2026 21:33:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6VMSOBu3H5k6; Mon, 10 Aug 2026 21:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786397604; bh=8srQNQFRvplvv6zNY+6hS99If9YqBFBbBRXals9htKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQ9BK6ZfQTfw5DV1tFdi0ohn0/k+Jl994Qv8DMfmGL6Z2uEZRVV3qkTA0Umzkjvhx
	 iweIkZ+zikNnMqAVzjV9hP2d7H/inAmdqv3WIwoC/1o+KrfoI+iIykBZfVPcewtsOo
	 tBxs4L6AfkIBIrjgWw1RYUGhr3dLKPnvl7Xjrqyk52nMNMYW8PgkR+3Yr4ETdy0JRt
	 ZV+RYe+Rg8F67hzq3dD9tKdSixLhMAsBIlJd+/mooC36DrJ1ohKOU7jpf23EX5a5XR
	 8DquGqtpyHbRalR9w4TKXLoK6xjuFPhMG8siS7WDceDrG/EfmjhMb8JbH9oLrli7zK
	 5HAmcNvr6L6KszdPSprwEE04hWRhOIHlNHOSIgvsfoO/PPi84oIywzXVty4WY/EEka
	 sY0KCBIKQIJXLl5HVhvTcIXhjEq/UXamnBeGdnDOz91lq1h2sMJO5SKdhanU+Ggp56
	 dG+VMQbmuFZqksn8Bw2XjptwbHisg9MkAgYoRzQtE21IWJt44jORGYqrZkLRKZSKcA
	 X7LHaAjflhP+IiK/gL7eIRelJGydRh6zh8i2SZ/v5aJ+7Z+Q7E34rv3DpTzCxRF6Wq
	 4QAHilYGPzU/r+kEP8/ZJrD9jOiHHa5bZ+fRJR7N/tmslzXil0wIrjsIHGKCZCfxxx
	 ZHK3dstU0RyyqrIH0u5uQoZE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 99F6A40E0031;
	Mon, 10 Aug 2026 21:33:12 +0000 (UTC)
Date: Mon, 10 Aug 2026 14:33:09 -0700
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Sean Rhodes <sean@starlabs.systems>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
Message-ID: <20260810213309.GDanpDlS1IcRhHKyWK@fat_crate.local>
References: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
 <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
 <CABtds-0MUDmxK_Vd_P8CijwzUhQEV4eWNzx1+DbN2wfnY4dbrA@mail.gmail.com>
 <20260806012923.GEanPjc0w24EdEquDk@fat_crate.local>
 <131d39d6-c2a9-4d80-99e9-526d347bf608@amd.com>
 <CABtds-1wb1zt4cP9jrUhivRZKEqG6Geq5XtK4j3R4hr-6nMkfw@mail.gmail.com>
 <f4ec6830-6d7e-47a0-8839-f7e50c8bcce9@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4ec6830-6d7e-47a0-8839-f7e50c8bcce9@amd.com>

On Mon, Aug 10, 2026 at 03:07:05PM -0500, Mario Limonciello wrote:
> I think you should narrow down your proposed quirk to the single affected
> processor.

You mean "platform"?

Looking at
https://us.starlabs.systems/pages/starbook?shpxid=c61652d7-d0de-458c-a7ee-ce809ee0ad2b
it sounds to me like we might fix the fw even...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
