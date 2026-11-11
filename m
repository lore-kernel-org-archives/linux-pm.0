Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400273;
	b=1WBjxkDJfdFyzA3BXgCKsq943gVI2Newo03gjO9wn1+3UvDuy79Hob14+gH/XtNBcRep
	 70wVzdyPbK6of/w7mhUPgOmkVHra4Ywxm6WJqcCJCgc7Go7XkVXhT1atpxBqBtppOtrPl
	 1EmUkgV4pqUHYRgRpkZumEpQxaELwngMJ8Dl7qF+MYtRfOurH1ylPF77HKof0q7sCGoL5
	 NpDOkG9RxzJS8oF1P3p90pv/veZ7h7r7SiOALoFI78hkhNB+q4k7hZv/BSyqkPRI1Q5ae
	 jgDUHcW7pyRoqD3t1tO0sPQF/Q61mmOO/rkfyI9xbjvKZ/wCmVm9Sr2YnzWHGEoWVcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400273;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xV6+erwhAK8Iq400W5ZeM6FEfwhCsdPeud2f/Rh1WYw=;
	b=qWFO3AyISEkGibztohh6YhxdAtzOAUrKo7EnA3y27TfC7tIJWqAC8c5H4ereoQjW95yY
	 G0hwxgsGjH2oqpnz2hSkUrw/hkv9j1vGHYSMGGEzPDS5VnbPqKrROFh5JDV2vUWM+AAO5
	 kqSHWHJ1M7oRb+8fAZATuFy9Vblb/TqNfIYC3Hbfu1+AcQpsCTNBYpeljpM/+wBNxcH/M
	 7bu1lgrU95bWYi2JYvGSxLiS30rlJDUwvQxTdl1J0UFhS28z2y1FBSaHbfhZobFsrEC3z
	 nPrGkxbACMgUa75qjxsB1Dcaiy5VrUJU1u1FpscKBqTVfaD/SgcLUk7pwmJqnn2bkfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMgijUmy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D40606A327;
	Wed, 11 Nov 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMgijUmy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0331F00A05;
	Wed, 11 Nov 2026 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400273;
	bh=xV6+erwhAK8Iq400W5ZeM6FEfwhCsdPeud2f/Rh1WYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mMgijUmyKkYC1oJktxJwThW1tkyknXXsxzHzl4lL2yklY45XVdNHZ2ATZhR4DOxr2
	 LglK1zustE/QwX0LEDzlZUabgnlX2QkDFCK3XOUwRDVtQOQDaZy9Lvs8bnh1CDYsHh
	 vQZ+V+O8eYyb8YNo+YgjJEJM9ml0tjMkAZoQCgDT0khXtQx2DKBhuNxwJQbuATx5pX
	 k2CqOU2euGpg9kA6oBaRrhc21soHxXg2nv0KWR2UdD8Z6hzE6edJmdNy6nlEh7T4TN
	 ffgkY3WulZiPPNt00lYkgVvwlxX4b3qL0C4HLeno+WCT0ZE9wLj0tHOmz8Gg8xFLEa
	 x1AQJ8Aa3M28g==
Date: Wed, 11 Nov 2026 13:31:08 +0100
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <ynorov@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: intel: powerclamp: Use guard(mutex) to simplify
 the code
Message-ID: <avRgDKdyR1KsBVdg@kernel.org>
References: <20261110231611.7159-2-blum@kernel.org>
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
In-Reply-To: <20261110231611.7159-2-blum@kernel.org>

On Wed, Nov 11, 2026 at 12:16:08AM +0100, Thorsten Blum wrote:
> Use guard(mutex) to replace explicit mutex_{lock,unlock}() calls.
> 
> Simplify the return paths and drop redundant ret initializations in
> duration_set(), window_size_set(), and powerclamp_set_cur_state().
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 71 ++++++++++--------------
>  1 file changed, 28 insertions(+), 43 deletions(-)

I'll send a v2 after taking Sashiko's feedback into account:
https://sashiko.dev/#/patchset/20261110231611.7159-2-blum%40kernel.org

And this patch should only be applied after the following fix:
https://lore.kernel.org/r/20261111121225.70218-3-blum@kernel.org/

Thanks,
Thorsten
